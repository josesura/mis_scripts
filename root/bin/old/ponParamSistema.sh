#!/bin/sh 
# ponParamSistema.sh
# Establece los parametros del sistema para los scripts que lo necesiten
# En principio necesita ser ejecutado por el administrador
# Nombre de SIS, VG, y algo más
# source /comun/bin/ponParamSistema.sh
# Variables: SIS, SYS1, SYS2, VG_NAME, HOMEX, HOME_LOCAL, DEV_BOOT1, DEV_BOOT2
# Lista de sistemas: k1, k2, sat1, sat2, sysrescue
# Lista de VG: vgK, vgSat
# Averigua nombre del sistema, grupo de volumenes, dispositivo de almacenamiento local
# Lista de DEV_BOOT: /dev/sda1, /dev/sda2, /dev/nvme0n1p2, /dev/nvme0n1p3

mensajeParm() {
    printf "$0 %s\n" "$*" 2>&1 
}

SIS=$(uname -n)

if [ $(id -u) -gt 0 ]; then # Comprobar privilegios
	mensajeParm "No eres administrador. Salimos"
	exit 1
fi
#En base a uname -n?, ver manual dash
VG_NAME=$(vgs -o vgname | grep -v VG | cut -c 3-)

# Para las copias de seguridad, montar dispositivos, ...
if [ 0 -eq 1 ]; then
    AUX=$(ls -l /dev/nvme0n1)
    if [ $? -eq 0 ]; then
        mensajeParm "Existe /dev/nvme0n1"
    else
        mensajeParm "No parece existir /dev/nvme0n1"
    fi
fi
    
case $SIS in
(k?)
    DEV_BOOT1=/dev/sda1
    DEV_BOOT2=/dev/sda2
    SYS1=k1
    SYS2=k2
    ;;
(*sat*)
    DEV_BOOT1=/dev/nvme0n1p2
    DEV_BOOT2=/dev/nvme0n1p3
    SYS1=sat1
    SYS2=sat2
    ;;
(sysrescue)
    mensajeParm Averiguar como obtengo eso
    AUX=$(ls -l /dev/nvme0n1)
    if [ $? -eq 0 ]; then
        DEV_BOOT1=/dev/nvme0n1p2
        DEV_BOOT2=/dev/nvme0n1p3
        SYS1=sat1
        SYS2=sat2
    else
        mensajeParm "No parece existir /dev/nvme0n1"
        DEV_BOOT1=/dev/sda1
        DEV_BOOT2=/dev/sda2
        SYS1=k1
        SYS2=k2
    fi
    ;;
(*)
    mensajeParm No sé cual es el sistema. Salida con error
    exit 2
esac

mensajeParm VG_NAME=$VG_NAME
mensajeParm SIS=$SIS
mensajeParm SYS1=$SYS1
mensajeParm SYS2=$SYS2
mensajeParm DEV_BOOT1=$DEV_BOOT1
mensajeParm DEV_BOOT2=$DEV_BOOT2
