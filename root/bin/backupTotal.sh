#!/bin/sh
# backupTotal.sh
# Llamada sucesiva a los scripts  guardar-particiones.sh incrementales.sh en la ruta actual
# 
RAIZ_COPIA=/media/jose/ToshExt4

FECHA=$(date +%Y%m%d-%H%M)
FIC_LOG=$RAIZ_COPIA/logs/log-backupTotal-$FECHA.txt

printf "%s\n" "$0 Llamada sucesiva a guardar-particiones.sh e incrementales.sh" | tee -a $FIC_LOG
printf "%s\n" "$0 guardar-particiones.sh ..." | tee -a $FIC_LOG
$RAIZ_COPIA/bin/guardar-particiones.sh $FIC_LOG
printf "%s\n" "$0 Listo!!. incrementales.sh ..." | tee -a $FIC_LOG
$RAIZ_COPIA//bin/incrementales.sh $FIC_LOG
printf "%s\n" "$0 Listo!!. Acabamos."| tee -a $FIC_LOG
