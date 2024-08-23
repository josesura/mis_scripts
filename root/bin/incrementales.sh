#!/bin/sh -e
# incrementales.sh
# Parametros: si los hay, el primero será nombre completo de fichero de log
#
# Copia con rsync los directorios /home /root /etc /opt /usr/local /de los sistemas
# Monta los filesystem necesarios según en qué sistema se ejecute: $SYS1 sysrcd
# En /mnt ... lo que sea 
# Averigua nombre del sistema, grupo de volumenes, dispositivo de almacenamiento local

# 1. Funciones
mensaje() {
    HORA=$(date "+%F %T.%3N")
    printf "$HORA %s\n" "$*" 2>&1 | tee -a  "$FIC_LOG"
}

copia() { # Arg1: Origen, # Arg2: Destino, # Arg3: Fichero-exluir
    mensaje
	mensaje "Comienza: copia $1 $2,  excluye $3"
#	mensaje "rsync -ah --delete --progress --exclude-from=$3 $1 $2"
	mensaje "rsync $OPCIONES_RSYNC --exclude-from=$3 $1 $2"
    if [ $TEST = 0 ]; then
        #rsync -ah --delete --progress --exclude-from=$3 $1 $2 | tee -a  "$FIC_LOG" 2>&1
        rsync "$OPCIONES_RSYNC --exclude-from=$3 $1 $2" | tee -a  "$FIC_LOG" 2>&1
        mensaje "Terminado copia: $1, $2, $3."
        mensaje "----------------------------------------------------------"
    fi
}

montoFilesystemRuta() { #$1: Filesystem, $2: Ruta
    mensaje "Se crea $2 si no existe"
    mensaje "Se monta $1 $2"
    mensaje ""
    if [ $TEST = 0 ]; then
        [ -d "$2" ] || mkdir -p "$2"
        [ -d "$2/lost+found" ] || mount "$1 $2"
    #else
    fi
}

# Donde encontrar las cosas
RAIZ_COPIA=/media/jose/ToshExt4
# 2. cargar variables
# shellcheck source=/dev/null
. $RAIZ_COPIA/bin/ponParamSistema.sh

###########################################
# 3. Variables
# 3.1 opciones
# 0 es hacer todo, Otra cosa para pruebas
TEST=0 
# Opciones a pasar a rsync
OPCIONES_RSYNC="-ah --delete --progress"

# fichero de logs por defecto, si no se ha puesto en las opciones
FECHA=$(date +%Y%m%d-%H%M) # fecha con año hora hasta milisegundos
FIC_LOG=$RAIZ_COPIA/logs/log-incrementales-$FECHA.txt

# para ejecutar desde $RAIZ_COPIA
#if [ $(pwd) != "/media/jose/ToshExt4" ]; then
# cambiarlo para poner esa ruta como raiz de todo
if [ ! -d $RAIZ_COPIA ]; then # existe el directorio
    mensaje "Necesitamos escribir en $RAIZ_COPIA. Salimos"
    exit 1
fi

# fichero de logs si hay opciones, parametro 1
if [ $# -gt 0 ]; then
	FIC_LOG=$1
fi
#touch "$FIC_LOG"

mensaje "Se montan filesystems locales necesarios y se hace backup incremental." 
mensaje "Para ello es necesario privilegios de administrador."
#mensaje "Es necesario ejecutar esto en el raíz del dispositivo destino."
# test de usuario root
if [ "$(id -u)" -ne "0" ]; then # Comprobar privilegios
    mensaje "No eres administrador"
    TEST=1
fi

# modo test, mensaje de aviso
if [ $TEST -gt 0 ]; then
	mensaje "Estamos en modo test, no se ejecutara nada"
fi

# testaer rsync instalado y accesible
# $RAIZ_COPIA/bin/incrementales.sh: 22: rsync: not found
#RSVERSION=$(rsync -V | head -1)
if [ -x /usr/bin/rsync ] || [ -x /bin/rsync ]; then
	mensaje "rsync no se encuentra en el sistema. Salimos..."
	exit 1
else 
	mensaje "La version de rsync es $RSVERSION"
fi

# Elegir origen correcto. En base al nombre del sistema
HOME1="/mnt/home"
ROOT1="/mnt/root"
VAR1="/mnt/var"
OPT="/opt"

case $SIS in
(dev*) # Devuan
	mensaje "Estamos en sistema devuan"
	mensaje ""
	HOME1="/home"
	ROOT1=""
    VAR1="/var"
    ;;
(sysrescue) # SystemRescueCD. 
	mensaje "Estamos en System Rescue"
	mensaje ""
    OPT="/mnt/opt"
    montoFilesystemRuta "/dev/$VG_NAME/home" "$HOME1"
    montoFilesystemRuta "/dev/$VG_NAME/root" "$ROOT1"
    montoFilesystemRuta "/dev/$VG_NAME/var" "$VAR1"
    montoFilesystemRuta "/dev/$VG_NAME/opt"  "$OPT"
    ;;
(*)
	mensaje "No sabemos en qué sistema estamos. Salimos"
	exit 1
    ;;
esac

# Esto se configura en ponParamSistema.sh
# Nombre del sistema, grupo de Volumenes
#SYS1=k1
# Nombre del Volume Group
#VG_NAME="vgK"
# Destinos
DESTINO_LOC=$RAIZ_COPIA

mkdir -p            	 "$DESTINO_LOC/$SYS1/"
copia "$HOME1/"       	 "$DESTINO_LOC/$SYS1/home"   "$RAIZ_COPIA/bin/excluye-home.txt"
copia "$ROOT1/root"   	 "$DESTINO_LOC/$SYS1"        "$RAIZ_COPIA/bin/excluye-root.txt"
copia "$ROOT1/etc"    	 "$DESTINO_LOC/$SYS1"        "$RAIZ_COPIA/bin/excluye-nada.txt"
copia "$ROOT1/usr/local" "$DESTINO_LOC/$SYS1/usr" 	 "$RAIZ_COPIA/bin/excluye-nada.txt"
copia "$VAR1/"        	 "$DESTINO_LOC/$SYS1/var"    "$RAIZ_COPIA/bin/excluye-var.txt"

case $SIS in     # Solo en satellite
(devs)
    copia "$OPT"      "$DESTINO_LOC"              "$RAIZ_COPIA/bin/excluye-nada.txt"
    ;;
esac

if [ $TEST -gt 0 ]; then
    exit
fi

# Desmontar fs montados
case $SIS in
(devs) # Devuan. No hacer nada
    ;;

(*)
	umount $HOME1
	umount $ROOT1
	umount $VAR1
    umount $OPT
esac

mensaje "Listo!!"
