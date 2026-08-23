#!/usr/bin/env bash

# Зеркалит CLIPBOARD -> PRIMARY: после <leader>y в opencode
# текст вставляется и по Shift+Insert тоже.

last=""
while sleep 1; do
    cur=$(xclip -selection clipboard -o 2>/dev/null) || continue
    [[ $cur == "$last" ]] && continue
    last=$cur
    printf '%s' "$cur" | xclip -selection primary -i
done
