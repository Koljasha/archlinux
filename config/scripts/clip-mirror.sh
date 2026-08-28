#!/usr/bin/env bash
# clip-mirror.sh — зеркалит CLIPBOARD -> PRIMARY.
# Событийный (push) режим через clipnotify: НЕТ busy-polling, нет вечных sleep в цикле.
# Зависимости: clipnotify, xclip (X11).

set -Eeuo pipefail

LAST=""

# clipnotify — прямой потомок этого скрипта; при выходе убираем его, иначе зависнет сиротой.
cleanup() { pkill -P "$$" clipnotify 2>/dev/null || true; }
trap cleanup EXIT
trap 'exit 0' INT TERM

while true; do
    # Блокируется и печатает строку, только когда меняется CLIPBOARD -> событие,
    # а не опрос каждую секунду. Ненулевой код = X-события недоступны (переждали).
    if ! clipnotify >/dev/null 2>&1; then
        sleep 2
        continue
    fi

    cur="$(xclip -selection clipboard -o 2>/dev/null || true)"
    [[ -z "$cur" || "$cur" == "$LAST" ]] && continue
    LAST="$cur"

    # xclip -i становится владельцем PRIMARY; прежний владелец получает SelectionClear
    # и завершается сам — процессы не копятся.
    printf '%s' "$cur" | xclip -selection primary >/dev/null 2>&1 || true
done
