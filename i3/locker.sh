#!/bin/sh

exec xautolock -detectsleep \
    -time 30 \
    -corners ---- \
    -locker 'pidof i3lock 1>/dev/null || i3lock -c 000000; systemctl suspend' \
    -notify 300 \
    -notifier "notify-send -u critical -t 10000 -- 'System sleeping in less than five minute'"
