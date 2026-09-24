#!/usr/bin/env bash

#
# Копируем дампы закладок Firefox на удалённый сервер.
#
# Запускается ежедневно (systemd-таймер / cron). Зеркально синхронизирует
# каталог bookmarkbackups текущего профиля Firefox.
#

set -euo pipefail

# --- Конфигурация ---
FIREFOX_CONFIG_DIR="$HOME/.config/mozilla/firefox"
PROFILES_INI="$FIREFOX_CONFIG_DIR/profiles.ini"
REMOTE_HOST="koljasha"
# Тильда раскрывается на удалённой стороне, поэтому кавычки нужны;
# SC2088 — ложное срабатывание.
# shellcheck disable=SC2088
REMOTE_DIR="~/zip/bookmarks/"
SSH_OPTS=(-o BatchMode=yes -o ConnectTimeout=30)

# --- Логирование ---
# Пишем в stderr, чтобы не смешивать логи с данными, возвращаемыми функциями.
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >&2
}

# --- Поиск каталога профиля Firefox ---
# Печатает в stdout только путь к профилю. Разбирает profiles.ini по секциям:
#   1) [Install…] Default=<путь> — так делает современный Firefox;
#   2) иначе профиль с Default=1 и его Path (с учётом IsRelative).
# Возвращает 1, если профиль определить не удалось.
find_profile_path() {
    awk -v base="$FIREFOX_CONFIG_DIR" '
        function trim(s) {
            sub(/^[ \t\r]+/, "", s)
            sub(/[ \t\r]+$/, "", s)
            return s
        }
        function full_path(p, isrel) {
            if (p == "") return ""
            if (p ~ /^\//) return p
            if (isrel == "0") return p
            return base "/" p
        }
        /^\[/ {
            sect = $0
            gsub(/[][]/, "", sect)
            is_install = (sect ~ /^Install/)
            next
        }
        /^[ \t]*Default[ \t]*=/ {
            v = trim(substr($0, index($0, "=") + 1))
            if (is_install) {
                install_default = v
            } else if (v == "1" || tolower(v) == "true") {
                default_sect = sect
            }
            next
        }
        /^[ \t]*Path[ \t]*=/ {
            prof_path[sect] = trim(substr($0, index($0, "=") + 1))
            next
        }
        /^[ \t]*IsRelative[ \t]*=/ {
            is_rel[sect] = trim(substr($0, index($0, "=") + 1))
            next
        }
        END {
            if (install_default != "") {
                print full_path(install_default, "1")
                exit
            }
            if (default_sect != "" && prof_path[default_sect] != "") {
                print full_path(prof_path[default_sect], is_rel[default_sect])
                exit
            }
            exit 1
        }
    ' "$PROFILES_INI"
}

# --- Проверка зависимостей ---
check_deps() {
    local cmd
    for cmd in rsync ssh awk; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log "ERROR: не найдена команда '$cmd'"
            exit 1
        fi
    done
}

# --- Основная логика ---
main() {
    log "Запуск задачи Firefox Bookmarks..."

    check_deps

    # 1. Проверяем наличие profiles.ini
    if [[ ! -f "$PROFILES_INI" ]]; then
        log "ERROR: файл profiles.ini не найден: $PROFILES_INI"
        exit 1
    fi

    # 2. Определяем профиль
    if ! PROFILE_PATH="$(find_profile_path)"; then
        log "ERROR: не удалось определить профиль Firefox в $PROFILES_INI"
        exit 1
    fi
    BACKUP_SOURCE="$PROFILE_PATH/bookmarkbackups/"

    log "Найден профиль: $PROFILE_PATH"
    log "Источник: $BACKUP_SOURCE"

    # 3. Проверяем, что каталог существует
    if [[ ! -d "$BACKUP_SOURCE" ]]; then
        log "ERROR: каталог не найден: $BACKUP_SOURCE"
        log "Возможно, Firefox ещё не создавал резервные копии закладок."
        exit 1
    fi

    # 4. Защита от затирания: не запускаем rsync --delete по пустому источнику
    if [[ -z "$(find "$BACKUP_SOURCE" -mindepth 1 -print -quit 2>/dev/null)" ]]; then
        log "ERROR: каталог закладок пуст: $BACKUP_SOURCE"
        log "Синхронизация отменена, чтобы не удалить копии на сервере (rsync --delete)."
        exit 1
    fi

    # 5. Выполняем rsync
    # --delete удаляет на сервере файлы, которых нет локально;
    # -a сохраняет права и атрибуты; -z сжимает данные при передаче.
    log "Начало синхронизации с $REMOTE_HOST..."

    # Важно: слэш в конце $BACKUP_SOURCE/ означает "содержимое папки".
    if rsync -avz --delete --timeout=30 --rsh="ssh ${SSH_OPTS[*]}" \
        "$BACKUP_SOURCE" "$REMOTE_HOST:$REMOTE_DIR"; then
        log "SUCCESS: Синхронизация завершена успешно."
    else
        log "ERROR: Ошибка rsync."
        exit 1
    fi
}

main
