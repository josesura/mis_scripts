#!/bin/sh
# Controlar la carga de la bateria para mensajear si baja de lo estipulado
#
# Para que funcione en el crontab poner
# * * * * * DISPLAY=:0 /home/jose/bin/opcionBateria.sh
# Y, en .bashrc, una linea xhost, como esto:
# xhost -local:jose # O similar
# el beep printf "\a" no funciona desde el crontab, pruebo esto:
# watch -n segundos -b -x bin/alertaBateria.sh 

# Cambiar acpi por upower, visto el comportamiento de ambos
mensaje() # Copiado de refrescaGpg.sh
{
    printf "%s\n" "$(uname -sn) $FECHA $*" >> $LOG
}

FECHA=`/usr/bin/date +%Y-%m-%d' '%H:%M`
#echo $FECHA
LOG=/home/jose/Documentos/registroBateria.txt
# https://aatma.es/aprenda-a-prolongar-la-vida-util-de-las-baterias-de-iones-de-litio/
# Los mejores valores de max y min están en orden. 
# Modifico esto tratando de aumentar la vida, que a la 4ª carga está al 68%
#CARGA_MIN=3 #45 #65,45,25,25, 50, 40, 25
#CARGA_MAX=100 #75 #75,75,75,85,100,100,100
CARGA_MIN=3 #65,45,25,25, 50, 40, 25
CARGA_MAX=101 #75,75,75,85,100,100,100
# tipos msg zenity: --info, --warning, --error
ACPI=$(/usr/bin/acpi)
CARGA=$(echo $ACPI | awk '{print $4}'| cut -d% -f 1)
DESCARGANDO=$(echo $ACPI | grep Discharging)
MSG_FIN=$(echo $ACPI | cut -d' ' -f3,5-)
#echo MSG_FIN:$MSG_FIN
# no funciona desde el crontab, pero lo puedo lanzar con un watch, que con -b hace el beep
#printf "\a"

if [ $CARGA -le $CARGA_MIN -a -n "$DESCARGANDO" ]; then # Carga baja y descargando
    if [ $CARGA -lt 10 ]; then CARGA=0$CARGA; fi # Control de dígitos
    mensaje CARGA: $CARGA. $MSG_FIN
    zenity --title=Bateria --warning --no-wrap --text="Bateria baja: $CARGA%"
    if [ $CARGA -le 9 ]; then #    
        printf "\a"
    fi 
    return 1
elif [ $CARGA -ge $CARGA_MAX -a -z "$DESCARGANDO" ]; then # Carga alta y cargando
    mensaje CARGA: $CARGA. $MSG_FIN
    zenity --title=Bateria --warning --no-wrap --text="Bateria cargada: $CARGA%"
    return 1
elif [ $CARGA -ge 95 -a -n "$DESCARGANDO" ]; then # Comienza descarga. Revisión capacidad
    #mensaje Revision capacidad
    MSG_FIN="$MSG_FIN. $(acpi -i | grep design | cut -d" " -f 7-)"
    mensaje CARGA: $CARGA. $MSG_FIN
else
    mensaje CARGA: $CARGA. $MSG_FIN
fi

return 0
