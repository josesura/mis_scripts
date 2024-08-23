#!/bin/sh -e
# Copyright (C) 2007-2008 Osamu Aoki <osamu@debian.org>, Public Domain
# Que hace esto : https://www.debian.org/doc/manuals/debian-reference/ch10.es.html#_idioms_for_the_selection_of_files
# -size [+|-]nM : tamaño igual, mayor|menor de n, redondeado hacia arriba (puede ser k, M, G, más) 
# -prune        : si es directorio no entrar (no funciona con -depth)
# -xdev         : no entrar en direcotrios en otros filesystems
# -print0       : saca el nobre completo por salida estándar seguido de un caracter null en vez de nueva linea (como hace -print)

BUUID=1000; USER=jose # UID and name of a user who accesses backup files
BUDIR="/var/backups"
SIZE="+99M"
DATE=$(date --utc +"%Y%m%d-%H%M")
[ -d "$BUDIR" ] || mkdir -p "BUDIR"
umask 077
dpkg --get-selections \* > /var/lib/dpkg/dpkg-selections.list
debconf-get-selections > /var/cache/debconf/debconf-selections

find /etc /usr/local /opt /var/lib/dpkg/dpkg-selections.list \
     /var/cache/debconf/debconf-selections -xdev -fprint find01.txt

#find /home/$USER /comun/$USER /root -xdev -regextype posix-extended \
  -type d -regex "$XDIR1" -prune -o -type f -regex "$XSFX" -prune -o \
  -type f -size  "$SIZE" -prune -o -fprint find02.txt

#find /home/$USER/Mail/Inbox /home/$USER/Mail/Outbox -fprint find03.txt Esto no saca nada

#find /home/$USER/Escritorio  -xdev -regextype posix-extended \
  -type d -regex "$XDIR2" -prune -o -type f -regex "$XSFX" -prune -o \
  -type f -size  "$SIZE" -prune -o -fprint find04.txt # Esto no saca casi nada

# Qué necesitamos para copia de seguridad de datos y opciones
# Los comandos de dpkg y debconf y todo el contenido de lo siguiente
# /etc \
    /usr/local (bastante vacio) \
    /opt \
    /var/lib/dpkg/dpkg-selections.list \
    /var/cache/debconf/debconf-selections
# De los homes hace una selección, que no entiendo por qué, yo tendría \
    /root \
    /home/jose \
    /comun



