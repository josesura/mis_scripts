#!/bin/sh 
# montaSis1.sh
# Monta debian 1 en ubicacion alternativa /mnt/root
. ~root/bin/ponParamSistema.sh
mount /dev/$VG_NAME/root1 /mnt/root
mount /dev/$VG_NAME/tmp1 /mnt/root/tmp
mount /dev/$VG_NAME/var1 /mnt/root/var/
mount /dev/$VG_NAME/home1 /mnt/root/home/
