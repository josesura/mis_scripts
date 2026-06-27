#!/bin/sh
# Mostrar la fecha hora y nivel de carga
# Opciones popup: notify-send comando   zenity ... 

#FECHA=$(/usr/bin/date +%H:%M)
#CARGA=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage: | awk '{print $2}')
MENSAJE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -e "percentage\|state\|time")
#zenity zenity --info --text="Bateria: $MENSAJE"
#notify-send "Bateria" "$MENSAJE"
printf "%s\n%s\n" "Bateria:" "$MENSAJE"
