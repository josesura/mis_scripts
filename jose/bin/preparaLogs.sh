#!/bin/bash 
# preparaLogs.sh
# crea directorio indicado en argumento 1 y prepara el nombre del fichero a escribir 
# con formato directorio/nombre.yymmdd-HHMM
# Argumento 1: Ruta de salida
# Argumento 2: Nombre del fichero
# El resultado lo pone en la variable $FICHERO_LOG
#

if [ $# -gt 0 ]; then 
	DIR_LOGS=$1
else
	DIR_LOGS=.
fi

if [ ! -d $DIR_LOGS ]; then
	echo Creando $DIR_LOGS
	mkdir -p $DIR_LOGS
fi

if [ $# -gt 1 ]; then 
	NOMBRE_LOG=$2
else
	NOMBRE_LOG=nombre
fi

#FECHA=`date +%y%m%d-%H%M`
FECHA=`date +%y%m%d-%H`
FICHERO_LOG=$DIR_LOGS/$NOMBRE_LOG-$FECHA
echo $FICHERO_LOG
