#!/bin/sh
# guardar-particiones.sh
# Lista de sistemas: sat1, k1, sysrescue  --> $SIS
# Dispositivos: /dev/sdaN, /dev/nvme0n1p2, /dev/nvme0n1p3 --> $DEV_BOOT
#
## CAMBIOS PTES: Tener en cuenta que esto se debe ejecutar en Sysrescue

mensaje() {
    HORA=$(date "+%F %T.%3N")
    printf "$HORA %s\n" "$*" 2>&1 | tee -a  "$FIC_LOG"
}

# Donde encontrar las cosas
RAIZ_COPIA=/media/jose/ToshExt4
# 2. cargar variables
# shellcheck source=/dev/null
. $RAIZ_COPIA/bin/ponParamSistema.sh

TEST=0 # 0 es en serio, si no se pone otro numero
FECHA=$(date +%Y%m%d-%H%M)
FIC_LOG=$RAIZ_COPIA/logs/log-particiones-$FECHA.txt
DESTINO=$RAIZ_COPIA/particiones

if [ $# -gt 0 ]; then
	FIC_LOG=$1
fi

mensaje "Vamos a hacer copia de seguridad de las particiones boot y root"
mensaje "También guardaremos la carpeta /var/lib/dpkg/ y los archivos /var/lib/apt/extended_states /var/lib/aptitude/pkgstates"
mensaje "Para ello es necesario ejecutar esto en un sistema desmontado con privilegios de administrador"

if [ "$SIS" != "sysrescue" ]
then
	mensaje "El sistema no es sysrescue, sino $SIS. No se puede continuar..."
	exit 1
fi

if [ "$(id -u)" -ne "0" ]; then # Comprobar privilegios
	mensaje "No tienes privilegios de administrador. Salimos"
	exit 1
fi


if [ $TEST != 0 ]; then
	mensaje "estoy en $(pwd)"
	mensaje "ls $DESTINO: $(ls $DESTINO)"
fi

mensaje "Las copias con estos nombres se moverán a old, sobreescribiendo las existentes"
if [ ! -d $DESTINO/old ]; then
	mkdir -p $DESTINO/old;
fi

mensaje "Moviendo copias antiguas ..."
if [ $TEST != 0 ]; then
	echo "se haria: mv $DESTINO/*$SYS1.fsa $DESTINO/old"
else 
	echo mv '$DESTINO/*$SYS1.fsa' '$DESTINO/old'
	mv "$DESTINO"/*"$SYS1".fsa "$DESTINO"/old
	echo rm -r '$DESTINO/old/lib/*'
	rm -r "$DESTINO"/old/lib/*
	echo mv '$DESTINO/lib' '$DESTINO/old/'
	mv "$DESTINO"/lib "$DESTINO"/old/
fi


mensaje "Listo! Empezamos:"
mensaje "cp archivos y directorios a $DESTINO/lib..."
[ -d $DESTINO/lib/dpkg ] || mkdir -p $DESTINO/lib/dpkg
[ -d $DESTINO/lib/apt ]  || mkdir -p $DESTINO/lib/apt
[ -d $DESTINO/lib/aptitude ] || mkdir -p $DESTINO/lib/aptitude

# No funcionará en sysrescue xq /var no es el mismo, habrá que montar /dev/$VG_NAME/var, como se hace en incrementales.sh
# Elegir origen correcto. En base al nombre del sistema
VAR1="/mnt/var"
mount "/dev/$VG_NAME/var" "$VAR1"

cp -a $VAR1/lib/aptitude/pkgstates $DESTINO/lib/aptitude
cp -a $VAR1/lib/apt/extended_states $DESTINO/lib/apt
cp -a $VAR1/lib/dpkg $DESTINO/lib

#mensaje "fin de pruebas, saliendo...."
#[ ! true ] || exit

mensaje "fsarchiver -v -j3 savefs $DESTINO/boot-$SYS1.fsa $DEV_BOOT1 ...."
if [ $TEST = 0 ]; then
		 fsarchiver -j3 savefs "$DESTINO/boot-$SYS1.fsa" "$DEV_BOOT1"
fi 
mensaje "fsarchiver -v -j3 savefs $DESTINO/root-$SYS1.fsa /dev/$VG_NAME/root ...."
if [ $TEST = 0 ]; then
		 fsarchiver -j3 savefs "$DESTINO/root-$SYS1.fsa" "/dev/$VG_NAME/root"
fi


#mensaje "fsarchiver -j3 savefs $DESTINO/tmp1.fsa /dev/$VG_NAME/tmp1 ...."
#     fsarchiver -j3 savefs $DESTINO/tmp1.fsa /dev/$VG_NAME/tmp1
#mensaje "fsarchiver -j3 savefs $DESTINO/var1.fsa /dev/$VG_NAME/var1 ...."
#     fsarchiver -j3 savefs $DESTINO/var1.fsa /dev/$VG_NAME/var1

# opt va en incrementales
#mensaje "fsarchiver -j3 savefs $DESTINO/opt.fsa /dev/$VG_NAME/opt ..."
 #    fsarchiver -j3 savefs $DESTINO/opt.fsa /dev/$VG_NAME/opt

mensaje "listo!"

mensaje "FIN"
