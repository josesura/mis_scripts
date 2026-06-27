#!/bin/sh
# Refrescar las claves gpg con servidor de claves
TEST=1

mensajeSalida () 
{
#	echo "2ª: "$2
	if [ $# -gt 1 ]
	then 
		if [ $2 -eq 0 ]
		then
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
    gpg --homedir ~jose/.gnupg --refresh-keys
    mensajeSalida "Refresco local" $?
else 
    mensajeSalida "TEST=$TEST. gpg --homedir ~jose/.gnupg --refresh-keys"
fi

EXITO=0
DESMONTAR=0
if [ -d /mnt/home1 ]
then  
    if [ ! -d /mnt/home1/jose ]; then
        mount /dev/vgAcer/home1 /mnt/home1
        EXITO=$?
        if [ $EXITO -eq 0 ]; then DESMONTAR=1; fi
        mensajeSalida "Montar home1" $EXITO
    fi

    if [ $EXITO -eq 0 ] 
    then        
        if [ $TEST -eq 0 ]; then
            gpg --homedir /mnt/home1/jose/.gnupg --refresh-keys
            mensajeSalida "Refresco home1" $?
        else 
            mensajeSalida "TEST=$TEST. gpg --homedir /mnt/home1/jose/.gnupg --refresh-keys"
        fi
    fi
    
    if [ $DESMONTAR -eq 1 ]
    then 
        umount /mnt/home1
        mensajeSalida "Desmontar home1" $?
    fi
    
    else if [ -d /mnt/home2 ]
    then  
        if [ ! -d /mnt/home2/jose ]; then
            mount /dev/vgAcer/home2 /mnt/home2
            EXITO=$?
            if [ $EXITO -eq 0 ]; then DESMONTAR=1; fi
            mensajeSalida "Montar home2" $EXITO
        fi

        if [ $EXITO -eq 0 ] 
        then        
            if [ $TEST -eq 0 ]; then
                gpg --homedir /mnt/home2/jose/.gnupg --refresh-keys
                mensajeSalida "Refresco home2" $?
            else 
                mensajeSalida "TEST=$TEST. gpg --homedir /mnt/home2/jose/.gnupg --refresh-keys"
            fi
        fi
        
        
        if [ $DESMONTAR -eq 1 ]; then
            umount /mnt/home2
            mensajeSalida "Desmontar home2" $?
        fi
    fi
fi
