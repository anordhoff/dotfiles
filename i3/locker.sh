#!/bin/sh

exec xautolock -detectsleep \
    -time 60 \
    -corners ---- \
    -locker 'pidof i3lock 1>/dev/null || i3lock -c 000000; systemctl suspend' \
    -notify 60 \
    -notifier "notify-send -u critical -t 10000 -- 'System sleeping in less than a minute'"

