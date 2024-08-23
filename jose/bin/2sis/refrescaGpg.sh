#!/bin/sh
# Refrescar las claves gpg con servidor de claves

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

SIS=$(uname -n)
# Para refrescaGpg.sh, quiza mas

case $SIS in
(*1)
    HOMEX=home1
    HOME_LOCAL=home2
    ;;
(*2) 
    HOMEX=home2
    HOME_LOCAL=home1
esac

VG_NAME=$(sudo vgs -o vgname | grep -v VG | cut -c 3-)

TEST=0

SALIDA=/home/jose/refrescoGpg.txt
mensajeSalida "Inicio..."

if [ $TEST -eq 0 ]; then
    gpg --refresh-keys
    mensajeSalida "Refresco local" $?
else 
    mensajeSalida "TEST=$TEST. gpg --refresh-keys"
fi

EXITO=0
DESMONTAR=0

if [ ! -d /mnt/$HOMEX/jose ]; then
    sudo mount /dev/$VG_NAME/$HOMEX /mnt/$HOME_LOCAL
    EXITO=$?
    if [ $EXITO -eq 0 ]; then DESMONTAR=1; fi
    mensajeSalida "Montar $HOMEX" $EXITO
else
    mensajeSalida "No se monta $HOMEX? --> /mnt/$HOMEX/jose"
fi

if [ $EXITO -eq 0 ]; then        
    if [ $TEST -eq 0 ]; then
        gpg --homedir /mnt/$HOME_LOCAL/jose/.gnupg --refresh-keys
        mensajeSalida "Refresco $HOME_LOCAL" $?
    else 
        mensajeSalida "TEST=$TEST. gpg --homedir /mnt/$HOME_LOCAL/jose/.gnupg --refresh-keys"
    fi
fi

if [ $DESMONTAR -eq 1 ]; then 
    sudo umount /mnt/$HOME_LOCAL
    mensajeSalida "Desmontar $HOME_LOCAL" $?
fi
