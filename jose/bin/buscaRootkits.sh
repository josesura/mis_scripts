#!/bin/bash 
# buscaRootkits.sh
#  esta con bash porque la llamada source en dash que conozco no coge parámetros
# . fichero

# 1. chkrootkit
source ~jose/bin/preparaLogs.sh /home/jose/outCkMalware chkrootkit

echo "buscaRootkits.sh /usr/sbin/chkrootkit" | tee $FICHERO_LOG
/usr/sbin/chkrootkit | tee $FICHERO_LOG

# 2. rkhunter
source ~jose/bin/preparaLogs.sh /home/jose/outCkMalware rkhunter

echo  "buscaRootkits.sh /usr/bin/rkhunter -c -sk --rwo --logfile $FICHERO_LOG"
/usr/bin/rkhunter -c -sk --rwo --logfile $FICHERO_LOG
chmod 644 $FICHERO_LOG

