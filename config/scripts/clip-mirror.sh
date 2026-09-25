#!/usr/bin/env bash
# clip-mirror.sh — зеркалит CLIPBOARD -> PRIMARY.
# Событийный (push) режим через clipnotify: НЕТ busy-polling, нет вечных sleep в цикле.
# Зависимости: clipnotify, xclip (X11).

set -Eeuo pipefail

TMP=""

# clipnotify — прямой потомок этого скрипта; при выходе убираем его, иначе зависнет сиротой.
cleanup() {
	pkill -P "$$" clipnotify 2>/dev/null || true
	[[ -n "${TMP:-}" ]] && rm -f "$TMP" 2>/dev/null || true
}
trap cleanup EXIT
trap 'exit 0' INT TERM

while true; do
	# Блокируется и печатает строку, только когда меняется CLIPBOARD -> событие,
	# а не опрос каждую секунду. Ненулевой код = X-события недоступны (переждали).
	if ! clipnotify -s clipboard >/dev/null 2>&1; then
		sleep 2
		continue
	fi

	# Через файл, а не shell-переменную: сохраняются trailing \n и NUL-байты,
	# плюс не упираемся в размер переменной на больших копипастах.
	TMP="$(mktemp)"
	if ! xclip -selection clipboard -o >"$TMP" 2>/dev/null; then
		rm -f "$TMP"
		TMP=""
		continue
	fi

	# Пустой CLIPBOARD PRIMARY не затирает.
	if [[ ! -s "$TMP" ]]; then
		rm -f "$TMP"
		TMP=""
		continue
	fi

	# Сверка с живым PRIMARY, а не с кэшем LAST:
	# выделение текста затирает PRIMARY, и повторный Ctrl+C того же
	# содержимого обязан перезеркалить. Иначе Shift-Ins вставляет stale.
	if xclip -selection primary -o 2>/dev/null | cmp -s -- "$TMP" -; then
		rm -f "$TMP"
		TMP=""
		continue
	fi

	# xclip -i становится владельцем PRIMARY; прежний владелец получает SelectionClear
	# и завершается сам — процессы не копятся.
	xclip -selection primary <"$TMP" >/dev/null 2>&1 || true
	rm -f "$TMP"
	TMP=""
done
