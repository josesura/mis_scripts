#!/bin/sh 
# ponParamSistema.sh
# Establece los parametros del sistema para los scripts que lo necesiten
# En principio necesita ser ejecutado por el administrador
# Nombre de SIS, VG, y algo más
# source /comun/bin/ponParamSistema.sh
# Variables: SIS, SYS1, SYS2, VG_NAME, HOMEX, HOME_LOCAL, DEV_BOOT1, DEV_BOOT2
# Lista de sistemas: devs, devk, sysrescue
# Lista de VG: vgK, vgSat
# Averigua nombre del sistema, grupo de volumenes, dispositivo de almacenamiento local
# Lista de DEV_BOOT: /dev/sda1, /dev/nvme0n1p2

mensajeParm() {
	HORA=$(date "+%F %T.%3N")
    printf "$HORA $0 %s\n" "$*" 2>&1 
}

montoFilesystemRuta() { #$1: Filesystem, $2: Ruta
    mensajeParm "Se crea $2 si no existe"
    mensajeParm "Se monta $1 $2"
    mensajeParm ""
    if [ $TEST = 0 ]; then
        [ -d "$2" ] || mkdir -p "$2"
        [ -d "$2/lost+found" ] || mount "$1 $2"
    #else
    fi
}

SIS=$(uname -n)

VG_NAME=""

if [ "$(id -u)" -ne "0" ]; then # Comprobar privilegios
	mensajeParm "No eres administrador. Poco se hará..."
	#exit 1
else 
	VG_NAME=$(vgs -o vgname | grep -v VG | cut -c 3-)
fi

case $SIS in
(devk)
    mensajeParm "Sistema K"
    DEV_BOOT1=/dev/sda1
    SYS1=devk
    #SYS2=k2
    ;;
(devs)
    mensajeParm "Sistema Sat"
    DEV_BOOT1=/dev/nvme0n1p2
    SYS1=devs
    ;;
(sysrescue)
    mensajeParm "Sistema sysrescue"
    if [ -b /dev/nvme0n1 ]
    then
        DEV_BOOT1=/dev/nvme0n1p2
        SYS1=devs
    else
        mensajeParm "No parece existir /dev/nvme0n1"
        DEV_BOOT1=/dev/sda1
        SYS1=devk
    fi
    ;;
(*)
    mensajeParm No sé cual es el sistema. Salida con error
    mensajeParm "SIS=$SIS"
    exit 2
esac

mensajeParm "VG_NAME=$VG_NAME"
mensajeParm "SIS=$SIS"
mensajeParm "SYS1=$SYS1"
#mensajeParm SYS2=$SYS2
mensajeParm "DEV_BOOT1=$DEV_BOOT1"
#mensajeParm "DEV_BOOT2=$DEV_BOOT2"
