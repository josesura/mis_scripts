#!/bin/sh
mensaje() # Copiado de refrescaGpg.sh
{
    printf "%s\n" $* | tee -a $LOG
}
LOG=/home/jose/Documentos/registroBateria.txt
FECHA=$(/usr/bin/date +%Y-%m-%d' '%H:%M)
#echo $FECHA

#CARGA=$(/usr/bin/acpi | awk '{print $4}')
CARGA=`/usr/bin/acpi`
mensaje $(uname -sn) $FECHA: $CARGA

