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

#if [ $EXITO -eq 0 ]; then        
if [ ! true ]; then
    if [ $TEST -eq 0 ]; then
        gpg --homedir /mnt/$HOME_LOCAL/jose/.gnupg --refresh-keys
        mensajeSalida "Refresco $HOME_LOCAL" $?
    else 
        mensajeSalida "TEST=$TEST. gpg --homedir /mnt/$HOME_LOCAL/jose/.gnupg --refresh-keys"
    fi
fi

