#!/bin/sh
lock() {
    i3lock -c 000000
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && systemctl -i suspend
        ;;
    hibernate)
        lock && systemctl -i hibernate
        ;;
    reboot)
        systemctl -i reboot
        ;;
    shutdown)
        systemctl -i poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
