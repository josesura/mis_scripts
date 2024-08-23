#!/bin/bash 
# testRootkit.sh

source $HOME/bin/preparaLogs.sh /home/jose/outCkMalware chkrootkit

echo /usr/sbin/chkrootkit | tee $FICHERO_LOG
/usr/sbin/chkrootkit | tee $FICHERO_LOG
