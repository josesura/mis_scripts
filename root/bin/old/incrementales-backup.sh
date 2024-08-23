#!/bin/sh -e
# incrementales.sh
# Parametros: si los hay, el primero será nombre completo de fichero de log
#
# Copia con rsync los directorios /home /root /etc /opt /usr/local /comun de los sistemas
# Monta los filesystem necesarios según en qué sistema se ejecute: $SYS1 $SYS2 sysrcd
# En /mnt ... lo que sea y /comun
# Averigua nombre del sistema, grupo de volumenes, dispositivo de almacenamiento local
. bin/ponParamSistema.sh

mensaje() {
    HORA=$(date "+%F %T.%N")
    printf "$HORA %s\n" "$*" 2>&1 | tee -a  $FIC_LOG
}

copia() { # Arg1: Origen, # Arg2: Destino, # Arg3: Fichero-exluir
    mensaje
	mensaje "Comienza: copia $1 $2,  excluye $3"
	#mensaje "rsync -ah --delete --progress --exclude-from=$3 $1 $2"
	mensaje "rsync -ah --delete --exclude-from=$3 $1 $2"
    if [ $TEST = 0 ]; then
        #rsync -ah --delete --progress --exclude-from=$3 $1 $2 | tee -a  $FIC_LOG 2>&1
        rsync -ah --delete --exclude-from=$3 $1 $2 | tee -a  $FIC_LOG 2>&1
        mensaje "Terminado copia: $1, $2, $3."
        mensaje "----------------------------------------------------------"
    fi
}

montoFilesystemRuta() { #$1: Filesystem, $2: Ruta
    mensaje "Se crea $2 si no existe"
    mensaje "Se monta $1 $2"
    mensaje ""
    if [ $TEST = 0 ]; then
        [ -d $2 ] || mkdir -p $2
        [ -d $2/lost+found ] || mount $1 $2
    #else
    fi
}
###########################################
# Variables
TEST=0 # 0 es hacer todo, Otra cosa para pruebas
FECHA=$(date +%Y%m%d-%H%M)
FIC_LOG=log-incrementales-$FECHA.txt


if [ $# -gt 0 ]; then
	FIC_LOG=$1
fi
#touch $FIC_LOG

mensaje "Se montan filesystems locales necesarios y se hace backup incremental." 
mensaje "Para ello es necesario privilegios de administrador."
mensaje "Es necesario ejecutar esto en el raíz del dispositivo destino."

if [ $(id -u) != 0 ]; then
    mensaje "No eres administrador, se pone modo TEST"
    TEST=1
fi

if [ $(pwd) != "/media/jose/ToshExt4" ]; then
    mensaje "No se está ejecutando en el raíz del dispositivo destino. Salimos"
    rm $FIC_LOG
    exit 1
fi

if [ $TEST -eq 1 ]; then
	mensaje "Estamos en modo test, no se ejecutara nada"
fi

# Elegir origen correcto. En base al nombre del sistema
HOME1="/mnt/home"
ROOT1="/mnt/root"
VAR1="/mnt/var"
HOME2="/mnt/home"
ROOT2="/mnt/root"
VAR2="/mnt/var"
COMUN="/comun"
OPT="/opt"

case $SIS in
(*1) # Debian estable 
	mensaje "Estamos en sistema 1"
	mensaje ""
	HOME1="/home"
	ROOT1=""
    VAR1="/var"
    montoFilesystemRuta "/dev/$VG_NAME/home2" "$HOME2"
    montoFilesystemRuta "/dev/$VG_NAME/root2" "$ROOT2"
    montoFilesystemRuta "/dev/$VG_NAME/var2" "$VAR2"
    ;;
(*2)  # Debian inestable 
	mensaje "Estamos en sistema 2"
	mensaje ""
	HOME2="/home"
	ROOT2=""
    VAR2="/var"
    montoFilesystemRuta "/dev/$VG_NAME/home1" "$HOME1"
    montoFilesystemRuta "/dev/$VG_NAME/root1" "$ROOT1"
    montoFilesystemRuta "/dev/$VG_NAME/var1" "$VAR1"
    ;;
(sysrescue) # SystemRescueCD. 
	mensaje "Estamos en System Rescue"
	mensaje ""
    OPT="/mnt/opt"
    montoFilesystemRuta "/dev/$VG_NAME/home1" "$HOME1"
    montoFilesystemRuta "/dev/$VG_NAME/root1" "$ROOT1"
    montoFilesystemRuta "/dev/$VG_NAME/var1" "$VAR1"
    montoFilesystemRuta "/dev/$VG_NAME/home2" "$HOME2"
    montoFilesystemRuta "/dev/$VG_NAME/root2" "$ROOT2"
    montoFilesystemRuta "/dev/$VG_NAME/var2" "$VAR2"
    montoFilesystemRuta "/dev/$VG_NAME/opt"  "$OPT"
    montoFilesystemRuta "/dev/$VG_NAME/comun" "/comun"
    ;;
(*)
	mensaje "No sabemos en qué sistema estamos. Salimos"
	exit 1
    ;;
esac

# Esto se configura en ponParamSistema.sh
# Nombre del sistema, grupo de Volumenes
#SYS1=k1
#SYS2=k2
# Nombre del Volume Group
#VG_NAME="vgK"
# Destinos
DESTINO_LOC="."
#DESTINO_COM="../ToshDatos/copiaComun"
DESTINO_COM="comun"


mkdir -p            $DESTINO_LOC/$SYS1/       $DESTINO_LOC/$SYS2/
copia $HOME1/       $DESTINO_LOC/$SYS1/home   bin/excluye-home.txt
copia $ROOT1/root   $DESTINO_LOC/$SYS1        bin/excluye-root.txt
copia $ROOT1/etc    $DESTINO_LOC/$SYS1        bin/excluye-nada.txt
copia $ROOT1/usr/local $DESTINO_LOC/$SYS1/usr bin/excluye-nada.txt
copia $VAR1/        $DESTINO_LOC/$SYS1/var    bin/excluye-var.txt

copia $HOME2/       $DESTINO_LOC/$SYS2/home   bin/excluye-home.txt
copia $ROOT2/root   $DESTINO_LOC/$SYS2        bin/excluye-root.txt
copia $ROOT2/etc    $DESTINO_LOC/$SYS2        bin/excluye-nada.txt
copia $ROOT2/usr/local $DESTINO_LOC/$SYS2/usr bin/excluye-nada.txt
copia $VAR2/        $DESTINO_LOC/$SYS2/var    bin/excluye-var.txt
copia $COMUN/       $DESTINO_COM/             bin/excluye-comun.txt

case $SIS in     # Solo en satellite
(sat?)
    copia $OPT      $DESTINO_LOC              bin/excluye-nada.txt
    ;;
esac


if [ $TEST -gt 0 ]; then
    exit
fi

case $SIS in
(*1) # Debian estable 
	umount $HOME2
	umount $ROOT2
	umount $VAR2
    ;;
(*2)  # Debian inestable 
	umount $HOME1
	umount $ROOT1
	umount $VAR1
    ;;
(*)
	umount $HOME1
	umount $ROOT1
	umount $VAR1
	umount $HOME2
	umount $ROOT2
	umount $VAR2
    umount $OPT
    umount $COMUN
esac

mensaje "Listo!!"
