#!/bin/sh
# Script que pretende renombrar un fichero (inicialmente pdf) para poder salvar el abierto con el nombre anterior
# Debería ejecutarse periódicamente con los ficheros a modificar, por lo que seguramente habrá que llamarlo 
# Preferentemente con watch o si es necesario desde cron 
# Parametros 1. fichero a renombrar, 2. extensión a añadir

mensajeSalida () 
{
#	echo "2ª: "$2
	if [ $# -gt 1 ]
	then 
		if [ $2 -eq 0 ]
		then
		    ANIADE="OK"
		else
		    ANIADE="KO: $?" 
		fi
	fi
    printf "%s\n" "$0 $(date $FORMATO_FECHA) $1 $ANIADE" >> $SALIDA
}
    
SALIDA=/home/jose/renombraDoc.txt
FORMATO_FECHA="+%y/%m/%d-%H:%M"
printf "%s\n" "$0 $(date $FORMATO_FECHA) Inicio..." >> $SALIDA

if [ -f $1 ]
then  
	mv $1 $1-$2
else 
	if [ -f $1-$2 ]
	then
		mensajeSalida "No existe $1, pero sí $1-$2" 
	else
		mensajeSalida "Error al Renombrar. No existe $1" 1
	fi
fi

