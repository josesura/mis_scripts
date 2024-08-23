#!/bin/bash
# bin/buscaHttpStrings.sh
# Busca la cadena http en los ficheros binarios de la ruta que recibe por argumento

RUTA=$1

for a in `ls $RUTA`; do 
	echo $a 
	strings $RUTA/$a | grep http 
done
