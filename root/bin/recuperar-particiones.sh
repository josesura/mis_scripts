#!/bin/bash
# descomentar las lineas necesarias
# Sustituir por los ficheros y sistemas actuales
# ---------------
echo fsarchiver -j2 restfs particiones/boot1.fsa id=0,dest=/dev/sda1
echo descomentar para ejecutar
if [ -f particiones/boot1.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/boot1.fsa id=0,dest=/dev/sda1
fi

echo fsarchiver -j2 restfs particiones/root1.fsa id=0,dest=/dev/vgK/root1
echo descomentar para ejecutar
if [ -f particiones/root1.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/root1.fsa id=0,dest=/dev/vgK/root1
fi

#echo fsarchiver -j2 restfs particiones/tmp1.fsa id=0,dest=/dev/vgK/tmp1
#echo descomentar para ejecutar
if [ -f particiones/tmp1.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/tmp1.fsa id=0,dest=/dev/vgK/tmp1
fi

echo fsarchiver -j2 restfs particiones/var1.fsa id=0,dest=/dev/vgK/var1
echo descomentar para ejecutar
if [ -f particiones/var1.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/var1.fsa id=0,dest=/dev/vgK/var1
fi

# ------------
echo fsarchiver -j2 restfs particiones/boot2.fsa id=0,dest=/dev/sda2
echo descomentar para ejecutar
if [ -f particiones/boot2.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/boot2.fsa id=0,dest=/dev/sda2
fi


echo fsarchiver -j2 restfs particiones/root2.fsa id=0,dest=/dev/vgK/root2
echo descomentar para ejecutar
if [ -f particiones/root2.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/root2.fsa id=0,dest=/dev/vgK/root2
fi

#echo fsarchiver -j2 restfs particiones/tmp2.fsa id=0,dest=/dev/vgK/tmp2
#echo descomentar para ejecutar
if [ -f particiones/tmp2.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/tmp2.fsa id=0,dest=/dev/vgK/tmp2
fi

echo fsarchiver -j2 restfs particiones/var2.fsa id=0,dest=/dev/vgK/var2
echo descomentar para ejecutar
if [ -f particiones/var2.fsa ]; then
	echo no lo voy a hacer
	#fsarchiver -j2 restfs particiones/var2.fsa id=0,dest=/dev/vgK/var2
fi


echo FIN
