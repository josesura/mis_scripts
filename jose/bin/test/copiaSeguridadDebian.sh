#!/bin/sh -e
# Copyright (C) 2007-2008 Osamu Aoki <osamu@debian.org>, Public Domain
# jsr:
# Esto está en la antigua guia de referencia Debian:
# file:///usr/share/debian-reference/ch10.es.html#_an_example_script_for_the_system_backup
# En la actual esto se ha movido:
# https://www.debian.org/doc/manuals/debian-reference/ch10.es.html#_personal_backup
# Que dirige a esta pagina de github: https://github.com/osamuaoki/bss
BUUID=1000; USER=osamu # UID and name of a user who accesses backup files
BUDIR=«/var/backups«
XDIR0=«.+/Mail|.+/Desktop«
XDIR1=«.+/\.thumbnails|.+/\.?Trash|.+/\.?[cC]ache|.+/\.gvfs|.+/sessions«
# [algo]/.thumbnails | [algo]/[.]Trash | [algo]/[.][cC]ache | [algo]/.gvfs | [algo]/sessions
XDIR2=«.+/CVS|.+/\.git|.+/\.svn|.+/Downloads|.+/Archive|.+/Checkout|.+/tmp«
# [algo]/CVS | [algo]/.git | [algo]/.svn | [algo]/Downloads | [algo]/Archive | [algo]/Checkout | [algo]/tmp
XSFX=«.+\.iso|.+\.tgz|.+\.tar\.gz|.+\.tar\.bz2|.+\.cpio|.+\.tmp|.+\.swp|.+~«
# Esas extensiones de archivo: iso, tgz, tar.gz, tar.bz2, cpio, tmp, swp
SIZE=«+99M«
DATE=$(date --utc +«%Y%m%d-%H%M«)
[ -d «$BUDIR« ] || mkdir -p «BUDIR«
umask 077
dpkg --get-selections \* > /var/lib/dpkg/dpkg-selections.list
debconf-get-selections > /var/cache/debconf/debconf-selections

{
find /etc /usr/local /opt /var/lib/dpkg/dpkg-selections.list \
     /var/cache/debconf/debconf-selections -xdev -print0
find /home/$USER /root -xdev -regextype posix-extended \
  -type d -regex «$XDIR0|$XDIR1« -prune -o -type f -regex «$XSFX« -prune -o \
  -type f -size  «$SIZE« -prune -o -print0
find /home/$USER/Mail/Inbox /home/$USER/Mail/Outbox -print0
find /home/$USER/Desktop  -xdev -regextype posix-extended \
  -type d -regex «$XDIR2« -prune -o -type f -regex «$XSFX« -prune -o \
  -type f -size  «$SIZE« -prune -o -print0
} | cpio -ov --null -O $BUDIR/BU$DATE.cpio
chown $BUUID $BUDIR/BU$DATE.cpio
touch $BUDIR/backup.stamp
