#!/bin/sh
# Comprobar si ha iniciado bien wireplumber
# Si no, mostrar e iniciar

PIPEWIRE="$(pgrep -fl /usr/bin/pipewire)"
PLUMBER="$(pgrep -fl /usr/bin/wireplumber)"

printf "%s\n" "$PIPEWIRE"
printf "%s\n" "$PLUMBER"

if [ "$(pgrep -f /usr/bin/wireplumber)" = "" ]
then
  exec /usr/bin/wireplumber &
fi
