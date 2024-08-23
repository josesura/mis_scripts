#!/bin/bash
# Ahora escribe los comandos. P. ej: 
# Comprobamos en que sistema estamos para poner el destino correcto
if [ `uname -n` = k1 ]; then
	#mount /dev/vg-1/lv2-home /comun/EstudioSistema/home2
	#DESTINO1=incrementales/sis1
	echo Estamos en sistema k1
elif [ `uname -n` = k2 ]; then
	#mount /dev/vg-1/lv1-home /comun/EstudioSistema/home1
	#DESTINO1=incrementales/sis2
	echo Estamos en sistema k2
else
	echo El sistema es otro $(uname -n)
	exit 1
fi



