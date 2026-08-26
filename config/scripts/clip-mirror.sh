#!/usr/bin/env bash
# clip-mirror.sh — зеркалит CLIPBOARD -> PRIMARY
# После <leader>y в opencode текст вставляется и по Shift+Insert тоже.

set -euo pipefail

LAST=""
FAIL_COUNT=0
MAX_FAIL=10  # после стольких ошибок подряд — переподключение

while true; do
    # Проверяем доступность X11
    if ! xclip -selection clipboard -o >/dev/null 2>&1; then
        FAIL_COUNT=$((FAIL_COUNT + 1))
        if (( FAIL_COUNT >= MAX_FAIL )); then
            # X11 недоступен — ждём дольше, не спамим
            sleep 5
        else
            sleep 1
        fi
        continue
    fi

    # X11 работает — сбрасываем счётчик ошибок
    FAIL_COUNT=0

    cur=$(xclip -selection clipboard -o 2>/dev/null) || { sleep 1; continue; }
    [[ "$cur" == "$LAST" ]] && { sleep 1; continue; }
    LAST="$cur"

    printf '%s' "$cur" | xclip -selection primary -i 2>/dev/null || true
    sleep 1
done
