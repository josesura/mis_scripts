#!/bin/sh
# bin/pipewire_inicio.sh
# iniciar manualmente demonios de pipewire
# https://dev1galaxy.org/viewtopic.php?pid=47224#p47224
# kill any existing pipewire instance to restore sound
pkill -u "$USER" -fx /usr/bin/pipewire-pulse 1>/dev/null 2>&1
pkill -u "$USER" -fx /usr/bin/wireplumber 1>/dev/null 2>&1
pkill -u "$USER" -fx /usr/bin/pipewire 1>/dev/null 2>&1

exec /usr/bin/pipewire &

# wait for pipewire to start before attempting to start related daemons
while [ "$(pgrep -f /usr/bin/pipewire)" = "" ]
do
   sleep 1
done

exec /usr/bin/wireplumber &

# wait for wireplumber to start before attempting to start pipewire-pulse
while [ "$(pgrep -f /usr/bin/wireplumber)" = "" ]
do
   sleep 1
done

exec /usr/bin/pipewire-pulse &
