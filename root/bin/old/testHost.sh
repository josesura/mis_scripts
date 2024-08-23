#!/bin/bash
# Ahora escribe los comandos. P. ej: 
# Comprobamos en que sistema estamos para poner el destino correcto
if [ `uname -n` = kdebian ]; then
	mount /dev/vg-1/lv2-home /comun/EstudioSistema/home2
	DESTINO1=incrementales/sis1
	echo Estamos en sistema 1. Copiamos de /home y /root a $DESTINO1
elif [ `uname -n` = k2-debian ]; then
	mount /dev/vg-1/lv1-home /comun/EstudioSistema/home1
	DESTINO1=incrementales/sis2
	echo Estamos en sistema 2. Copiamos de /home y /root a $DESTINO1
else
	echo no sabemos donde copiar. Salimos
	exit 1
fi



