#!/bin/bash
# recortaNombreFicheros.sh
# En el directorio ~jose/outCkMalware/
# Se recortan los minutos de un nombre de fichero que acaba en -HHmm, es decir date +%y%m%d-%H%M
# for a in `ls ~jose/outCkMalware/`; do echo `ls ~jose/outCkMalware/$a | cut -d- -f3- | cut -b-2`; done

for a in `ls ~jose/outCkMalware/`; do 
	#echo `ls ~jose/outCkMalware/$a` 
	old=~jose/outCkMalware/$a
	pre=`ls $old | cut -d- -f-2`
	suf=`ls $old | cut -d- -f3- | cut -b-2`
	new=$pre-$suf
	echo "De $old"
        echo " A $new"
	mv $old $new
done

