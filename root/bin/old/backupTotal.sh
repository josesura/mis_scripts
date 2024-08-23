#!/bin/sh
# backupTotal.sh
# Llamada sucesiva a los scripts  guardar-particiones.sh incremental-homes.sh en la ruta actual
# luego a incremental-comun.sh que está en la ruta ../../datos/bin si se ha respetado este nombre al montar la particion datos

FECHA=$(date +%Y%m%d-%H%M)
FIC_LOG=$PWD/log_backupTotal-$FECHA.txt

printf "%s\n" "$0 Llamada sucesiva a guardar-particiones.sh incremental-homes.sh en la ruta actual y incremental-comun.sh en ../../datos/bin si existe" | tee -a $FIC_LOG
printf "%s\n" "$0 guardar-particiones.sh ..." | tee -a $FIC_LOG
./bin/guardar-particiones.sh $FIC_LOG
printf "%s\n" "$0 Listo!!. incrementales.sh ..." | tee -a $FIC_LOG
./bin/incrementales.sh $FIC_LOG
printf "%s\n" "$0 Listo!!. Acabamos."| tee -a $FIC_LOG
