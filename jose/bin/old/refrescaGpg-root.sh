#!/bin/sh
# Refrescar las claves gpg con servidor de claves
# Pendiente: ejecutar gpg con el uid de jose
TEST=1

# mostrar mensajes en consola y a un fichero en la variable $SALIDA
# entra el mensaje a mostrar y quizá un código de retorno de una ejecución
mensajeSalida () 
{
	if [ $# -gt 1 ]; then 
		if [ $2 -eq 0 ]; then
		    ANIADE="OK"
		else
		    ANIADE="KO: $?" 
		fi
	fi
    printf "%s\n" "$0 $(date +%Y-%m-%d) $1 $ANIADE" | tee -a $SALIDA
}

SALIDA=/home/jose/refrescoGpg.txt
printf "%s\n" "$0 $(date +%Y-%m-%d) Inicio..." | tee $SALIDA

chown jose:jose $SALIDA

if [ $TEST -eq 0 ]; then
    gpg --refresh-keys
    mensajeSalida "Refresco local" $?
else 
    mensajeSalida "TEST=$TEST. gpg --refresh-keys"
fi

if   [ -d /mnt/home1 ]; then HOMEX=home1
elif [ -d /mnt/home2 ]; then HOMEX=home2
fi

EXITO=0
DESMONTAR=0

if [ ! -d /mnt/$HOMEX/jose ]; then
    mount /dev/vgK/$HOMEX /mnt/$HOMEX
    EXITO=$?
    if [ $EXITO -eq 0 ]; then DESMONTAR=1; fi
    mensajeSalida "Montar $HOMEX" $EXITO
else
    mensajeSalida "No se monta $HOMEX? --> /mnt/$HOMEX/jose"
fi

if [ $EXITO -eq 0 ] 
then        
    if [ $TEST -eq 0 ]; then
        gpg --homedir /mnt/$HOMEX/jose/.gnupg --refresh-keys
        mensajeSalida "Refresco $HOMEX" $?
    else 
        mensajeSalida "TEST=$TEST. gpg --homedir /mnt/$HOMEX/jose/.gnupg --refresh-keys"
    fi
fi

if [ $DESMONTAR -eq 1 ]
then 
    umount /mnt/$HOMEX
    mensajeSalida "Desmontar $HOMEX" $?
fi
