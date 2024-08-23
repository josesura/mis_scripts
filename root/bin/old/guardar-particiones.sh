#!/bin/sh
# guardar-particiones.sh
# Lista de sistemas: sat1, sat2, k1, k2, sysrescue  --> $SIS
# Dispositivos: /dev/sdaN, /dev/nvme0n1p2, /dev/nvme0n1p3 --> $DEV_BOOT

#. ~root/bin/ponParamSistema.sh

. bin/ponParamSistema.sh

mensaje() {
    HORA=$(date "+%F %T.%N")
    printf "$HORA %s\n" "$*" 2>&1 | tee -a  $FIC_LOG
}

TEST=0 # 0 es en serio, si no se pone otro numero
FECHA=`date +%Y%m%d-%H%M`
FIC_LOG=log-particiones-$FECHA.txt
# Nombre del Volume Group
#VG_NAME="vgK"

if [ $# -gt 0 ]
then
	FIC_LOG=$1
fi

mensaje "Vamos a hacer copia de seguridad de las particiones linux en esta carpeta."
mensaje "*.fsa. Para ello es necesario privilegios de administrador"

if [ $(pwd) != "/media/jose/ToshExt4" ]; then
    mensaje "No se está ejecutando en el raíz del dispositivo destino. Salimos"
    rm $FIC_LOG
    exit 1
fi

# Comprobamos en que sistema estamos para poner el destino correcto
case $SIS in
(*1)
	COPIA=2
	mensaje "Estamos en sistema 1. Copiamos el 2"
    ;;
(*2) 
	COPIA=1
	mensaje "Estamos en sistema 2. Copiamos el 1"
    ;;
(sysrescue)
	COPIA=A
	mensaje "Estamos en sysrescue, copiamos sistemas 1 y 2"
    ;;
(*)
	mensaje "SIS=$SIS. No sabemos que hacer. Salimos"
	exit 1
esac

#echo 'Copia de: (1)EXTFS1, (2)EXTFS2, (N)TFS, (A)mbos, (Otra)Cancelar ?'
#echo 'Se recomienda copia de Sistema '$COPIA'. Copia de: (1)EXTFS1, (2)EXTFS2, (A)mbos, (Otra)Cancelar ?'
#read COPIA

#echo COPIA=$COPIA

if [ `whoami` != root ]; then # Comprobar premisos
	mensaje "No tienes privilegios de administrador. Salimos"
	exit 1
fi

if [ $TEST != 0 ]; then
	mensaje "estoy en `pwd`"
	mensaje "ls particiones: `ls particiones`"
	#echo `dirname particiones`
	mensaje "TEST=$TEST. Saliendo...."
	exit 0
fi

mensaje "Las copias con estos nombres se moverán a old, sobreescribiendo las existentes"
if [ ! -d particiones/old ]; then
	mkdir -p particiones/old;
fi

# EXTFS
if [ $COPIA = 1 -o $COPIA = A -o $COPIA = a ]; then
#if [ $COPIA = 1 ]; then
	mensaje "Empezamos con sistemas EXTFS1"
	mensaje "Moviendo copias antiguas ..."
	mv particiones/*$SYS1.fsa particiones/old
	mensaje "Listo! Empezamos:"

	mensaje "fsarchiver -j3 savefs particiones/boot-$SYS1.fsa $DEV_BOOT1 ...."
	         fsarchiver -j3 savefs particiones/boot-$SYS1.fsa $DEV_BOOT1
	mensaje "fsarchiver -j3 savefs particiones/root-$SYS1.fsa /dev/$VG_NAME/root1 ...."
	         fsarchiver -j3 savefs particiones/root-$SYS1.fsa /dev/$VG_NAME/root1
	#mensaje "fsarchiver -j3 savefs particiones/tmp1.fsa /dev/$VG_NAME/tmp1 ...."
	#     fsarchiver -j3 savefs particiones/tmp1.fsa /dev/$VG_NAME/tmp1
	#mensaje "fsarchiver -j3 savefs particiones/var1.fsa /dev/$VG_NAME/var1 ...."
	#     fsarchiver -j3 savefs particiones/var1.fsa /dev/$VG_NAME/var1

	# opt va en incrementales
	#mensaje "fsarchiver -j3 savefs particiones/opt.fsa /dev/$VG_NAME/opt ..."
	 #    fsarchiver -j3 savefs particiones/opt.fsa /dev/$VG_NAME/opt

	mensaje "listo!"
else 
	mensaje "Saltamos sistemas EXTFS1"
fi

if [ $COPIA = 2 -o $COPIA = A -o $COPIA = a ]; then
#if [ $COPIA = 2 ]; then

	mensaje "Empezamos con sistemas EXTFS2"
	mensaje "Moviendo copias antiguas ..."
	mv particiones/*$SYS2.fsa particiones/old
	mensaje "Listo! Empezamos:"

	mensaje "fsarchiver -j3 savefs particiones/boot-$SYS2.fsa $DEV_BOOT2 ...."
	         fsarchiver -j3 savefs particiones/boot-$SYS2.fsa $DEV_BOOT2
	mensaje "fsarchiver -j3 savefs particiones/root-$SYS2.fsa /dev/$VG_NAME/root2 ...."
	         fsarchiver -j3 savefs particiones/root-$SYS2.fsa /dev/$VG_NAME/root2
	#mensaje "fsarchiver -j3 savefs particiones/tmp2.fsa /dev/$VG_NAME/tmp2 ...."
	#     fsarchiver -j3 savefs particiones/tmp2.fsa /dev/$VG_NAME/tmp2
	#mensaje "fsarchiver -j3 savefs particiones/var2.fsa /dev/$VG_NAME/var2 ...."
	#     fsarchiver -j3 savefs particiones/var2.fsa /dev/$VG_NAME/var2

	mensaje "listo!"
else 
	mensaje "Saltamos sistemas EXTFS2"
fi

mensaje "FIN"
