#!/bin/bash 
# testRkHunter.sh

source $HOME/bin/preparaLogs.sh /home/jose/outCkMalware rkhunter

echo /usr/bin/rkhunter -c -sk --rwo --logfile $FICHERO_LOG
/usr/bin/rkhunter -c -sk --rwo --logfile $FICHERO_LOG
chmod 644 $FICHERO_LOG
