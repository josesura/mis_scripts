#!/bin/bash
# Busca cadena indicada en el argumento 2 en los ficheros del directorio del argumento 1
# Argumento 1: Directorio a buscar
# Argumento 2: cadena a encontrar
# Escribe las lineas con la cadena a continuacion de cada fichero en que lo encuentra
# 

if [ -n $1 ]; then
	DIR=$1
else
	DIR=.
fi

if [ -n $2 ]; then
	CADENA=$2
else
	CADENA=nombre
fi

#echo \"\" / \" \"
for FICH in `find $DIR -type f`; do
	FOUND=`strings $FICH | grep $CADENA`
	#echo \"$FOUND\"

	if [ -n " " ]; then
	#if [ -n $FOUND ]; then
		echo Encontrada $CADENA en $FICH?
		echo $FOUND
	fi
done

