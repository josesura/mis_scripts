#!/bin/bash 
# borraOldFiles.sh
# Borra ficheros anteriores a n dias desde ahora en la ubicacion indicada
# directorio/$PRE_FICHEROsufijo
# Argumentos: Inicio del nombre del fichero, directorio, dias de antigüedad, más?
# Hay valores por defecto: $PRE_FICHERO=rkhunter, $DIRECTORIO=~jose/outCkMalware/, $ANTIGUO_DIAS=5
#

PRE_FICHERO=rkhunter
DIRECTORIO=~jose/outCkMalware/
ANTIGUO_DIAS=5

echo ----- borraOldFiles.sh ---------------------
# Control de argumentos
if [ $# -eq 0 ]; then
	echo borraOldFiles.sh Sin args
else
	echo borraOldFiles.sh \"$*\" 
	PRE_FICHERO=$1
	if [ $# -gt 1 ]; then
		DIRECTORIO=$2
		if [[ $DIRECTORIO == *".clamtk/history/"* ]]; then
			PRE_FICHERO=
			#ANTIGUO_DIAS=20
		fi
		if [ $# -gt 2 ]; then
			ANTIGUO_DIAS=$3
		fi
	fi
fi

#ORDEN=find $DIRECTORIO -maxdepth 1 -mtime +$ANTIGUO_DIAS -name "$PRE_FICHERO*"
NUM=`find $DIRECTORIO -maxdepth 1 -mtime +$ANTIGUO_DIAS -name "$PRE_FICHERO*" | wc -l`

echo A borrar: $DIRECTORIO$PRE_FICHERO'*' +$ANTIGUO_DIAS Dias. Núm de Ficheros:$NUM

if [[ $NUM -eq 0 ]]; then
	echo Nada a borrar
	echo ----- borraOldFiles.sh FIN -----------------
	exit 0
fi

echo find $DIRECTORIO -maxdepth 1 -mtime +$ANTIGUO_DIAS -name "$PRE_FICHERO*"
echo Borrando `find $DIRECTORIO -maxdepth 1 -mtime +$ANTIGUO_DIAS -name "$PRE_FICHERO*"`
find $DIRECTORIO -maxdepth 1 -mtime +$ANTIGUO_DIAS -name "$PRE_FICHERO*" -exec rm {} \;
echo ----- borraOldFiles.sh FIN -----------------
