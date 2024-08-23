#!/bin/sh
# El backup de configuración está en ../incrementales
# habrá que ver qué opciones se le pasan. Por ahora el sistema sis1/sis2
#
mensaje() {
    printf "$0- %s\n" "$1" 2>&1 | tee -a  $FIC_LOG
}

uso()
{
    mensaje "Uso: $0 sis1|sis2"
}

TEST=0 # 0 es hacer todo, Otra cosa para pruebas
mensaje "Recuperación de la configuración en los incrementales al HOME."

FECHA=$(date +%Y%m%d-%H%M)
FIC_LOG=Log-recuperarConfig-$FECHA.txt

if [ $# -eq 0 ]; then uso; return 1; fi

BASEDIR=incrementales/$1
DESTINO=~/$BASEDIR

# grub: /etc/default/grub /etc/grub.d/*
# apt: /etc/apt/sources.list* /etc/apt/trusted.gpg.d/*
# sudo: /etc/sudoers.d/*
# /etc/hosts
mkdir -p $DESTINO/etc/default/
mkdir -p $DESTINO/etc/apt/sources.list.d
mkdir -p $DESTINO/etc/apt/trusted.gpg.d

Algo pasa con el propietario de los archivos destino, es quien lo ejecuta, habría que ejecuatr como root?
cp -av $BASEDIR/etc/default/grub $DESTINO/etc/default/
cp -av $BASEDIR/etc/grub.d $DESTINO/etc
cp -av $BASEDIR/etc/apt/sources.list* $DESTINO/etc/apt
cp -av $BASEDIR/etc/apt/trusted.gpg.d $DESTINO/etc/apt
cp -av $BASEDIR/etc/hosts $DESTINO/etc/

return
rsync -av $BASEDIR/etc/default/grub $DESTINO/etc/default/
rsync -av $BASEDIR/etc/grub.d $DESTINO/etc
rsync -av $BASEDIR/etc/apt/sources.list* $DESTINO/etc/apt
rsync -av $BASEDIR/etc/apt/trusted.gpg.d $DESTINO/etc/apt
rsync -av $BASEDIR/etc/hosts $DESTINO/etc/





