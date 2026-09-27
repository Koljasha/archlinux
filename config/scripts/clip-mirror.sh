#!/usr/bin/env bash
# clip-mirror.sh — зеркалит CLIPBOARD -> PRIMARY.
# Событийный режим через clipnotify + тик раз в T_WAIT секунд (самовосстановление,
# если событие пропущено или X-события отвалились). Все блокирующие вызовы под
# timeout: зависший владелец selection не способен остановить цикл навсегда —
# по зависанию делаем exit 1, и Restart=always поднимает свежий инстанс,
# сбрасывая зависших владельцев X selections.
# Зависимости: clipnotify, xclip, timeout (coreutils), systemd-cat.

set -Eeuo pipefail

T_WAIT=30 # макс. пауза между итерациями (событие или тик), сек
T_XCLIP=3 # таймаут на чтение/запись xclip, сек
TMP=""
PRIM=""

# Лог в журнал systemd: journalctl --user -t clip-mirror -f
log() { printf '%s\n' "$*" | systemd-cat -t clip-mirror -p warning; }

# clipnotify — прямой потомок этого скрипта; при выходе убираем его, иначе зависнет сиротой.
cleanup() {
	pkill -P "$$" clipnotify 2>/dev/null || true
	[[ -n "${TMP:-}" ]] && rm -f "$TMP" 2>/dev/null || true
	[[ -n "${PRIM:-}" ]] && rm -f "$PRIM" 2>/dev/null || true
}
trap cleanup EXIT
trap 'exit 0' INT TERM

while true; do
	# Блокируется до изменения CLIPBOARD; максимум T_WAIT секунд, дальше тик.
	# Тик нужен только чтобы цикл не залипал навечно (X-обрыв, зависший
	# clipnotify): он НЕ зеркалит, иначе зеркало перезаписывает PRIMARY
	# поверх свежих выделений пользователя и дёргает clipmenud каждые 30с.
	# Зеркалит только реальное событие (rc=0).
	timeout "$T_WAIT" clipnotify -s clipboard >/dev/null 2>&1
	rc=$?
	if ((rc != 0)); then
		continue
	fi

	TMP="$(mktemp)"
	PRIM="$(mktemp)"

	# Через файл, а не shell-переменную: сохраняются trailing \n и NUL-байты,
	# плюс не упираемся в размер переменной на больших копипастах.
	# Любая неудача чтения (таймаут зависшего владельца или владельца нет)
	# не фатальна: пропускаем итерацию, повтор на следующем тике. exit 1
	# здесь запрещён: рестарт сервиса убивает fork-демона xclip, державшего
	# PRIMARY, и следующий инстанс читает PRIMARY у умирающего владельца —
	# получаем вечный цикл рестартов вместо зеркала.
	if ! timeout "$T_XCLIP" xclip -selection clipboard -o >"$TMP" 2>/dev/null; then
		log "xclip clipboard -o не ответил за ${T_XCLIP}s — повтор на следующем тике"
		rm -f "$TMP" "$PRIM"
		TMP=""
		PRIM=""
		continue
	fi

	# Пустой CLIPBOARD PRIMARY не затирает.
	if [[ ! -s "$TMP" ]]; then
		rm -f "$TMP" "$PRIM"
		TMP=""
		PRIM=""
		continue
	fi

	# Сверка с живым PRIMARY, а не с кэшем LAST:
	# выделение текста затирает PRIMARY, и повторный Ctrl+C того же
	# содержимого обязан перезеркалить. Иначе Shift-Ins вставляет stale.
	if ! timeout "$T_XCLIP" xclip -selection primary -o >"$PRIM" 2>/dev/null; then
		log "xclip primary -o не ответил за ${T_XCLIP}s — повтор на следующем тике"
		rm -f "$TMP" "$PRIM"
		TMP=""
		PRIM=""
		continue
	fi

	if cmp -s -- "$PRIM" "$TMP"; then
		rm -f "$TMP" "$PRIM"
		TMP=""
		PRIM=""
		continue
	fi

	# xclip -i становится владельцем PRIMARY; прежний владелец получает SelectionClear
	# и завершается сам — процессы не копятся. (Сам демон xclip -i живёт до
	# следующей смены владельца — это нормально; timeout контролирует лишь сам вызов.)
	if ! timeout "$T_XCLIP" xclip -selection primary <"$TMP" >/dev/null 2>&1; then
		log "xclip primary -i не смог установить PRIMARY — повтор на следующем тике"
	fi
	rm -f "$TMP" "$PRIM"
	TMP=""
	PRIM=""
done
