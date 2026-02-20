#!/usr/bin/env bash

#
# Копируем дампы закладок Firefox на удаленный сервер
#

set -euo pipefail

# --- Конфигурация ---
FIREFOX_CONFIG_DIR="$HOME/.config/mozilla/firefox"
PROFILES_INI="$FIREFOX_CONFIG_DIR/profiles.ini"
REMOTE_HOST="koljasha"
REMOTE_DIR="~/zip/bookmarks/"
SSH_OPTS="-o BatchMode=yes -o ConnectTimeout=30"

# --- Логирование ---
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# --- Поиск профиля ---
find_profile_path() {
    if [[ ! -f "$PROFILES_INI" ]]; then
        log "ERROR: Файл profiles.ini не найден в $PROFILES_INI"
        exit 1
    fi

    local profile_path
    profile_path="$FIREFOX_CONFIG_DIR/$(grep 'Default' "$PROFILES_INI" | head -1 | cut -d'=' -f2)"

    if [[ -z "$profile_path" ]]; then
        log "ERROR: Не удалось найти профиль с Default=1 в profiles.ini"
        exit 1
    fi

    echo "$profile_path"
}

# --- Основная логика ---
main() {
    log "Запуск задачи Firefox Bookmarks..."

    # 1. Получаем путь к профилю
    PROFILE_PATH=$(find_profile_path)
    BACKUP_SOURCE="$PROFILE_PATH/bookmarkbackups/"

    log "Найден профиль: $PROFILE_PATH"
    log "Источник: $BACKUP_SOURCE"

    # 2. Проверка наличия исходной директории
    if [[ ! -d "$BACKUP_SOURCE" ]]; then
        log "ERROR: Директория не найдена: $BACKUP_SOURCE"
        log "Возможно, Firefox еще не создавал резервные копии закладок."
        exit 1
    fi

    # 3. Выполнение rsync
    # --delete удаляет на сервере файлы, которых нет локально
    # -a сохраняет права и атрибуты
    # -z сжимает данные при передаче
    log "Начало синхронизации с $REMOTE_HOST..."

    # Важно: слэш в конце $BACKUP_SOURCE/ означает "содержимое папки"
    rsync -avz --delete --timeout=30 -e "ssh $SSH_OPTS" "$BACKUP_SOURCE" "$REMOTE_HOST:$REMOTE_DIR"

    if [[ $? -eq 0 ]]; then
        log "SUCCESS: Синхронизация завершена успешно."
    else
        log "ERROR: Ошибка rsync (код выхода: $?)"
        exit 1
    fi
}

main

