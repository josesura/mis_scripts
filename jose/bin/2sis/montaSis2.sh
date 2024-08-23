#!/bin/sh 
# montaSis2.sh
# Monta debian 2 en ubicacion alternativa /mnt/root
. ~root/bin/ponParamSistema.sh
sudo mount /dev/$VG_NAME/root2 /mnt/root
sudo mount /dev/$VG_NAME/tmp2 /mnt/root/tmp
sudo mount /dev/$VG_NAME/var2 /mnt/root/var/
sudo mount /dev/$VG_NAME/home2 /mnt/root/home/
