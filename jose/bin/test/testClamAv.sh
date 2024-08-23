#!/bin/bash 
# testClamAv.sh

source $HOME/bin/preparaLogs.sh /home/jose/outCkMalware clamscan

if [[ '' != $1 ]]; then
	DIR_BUSCAR=$1
else
	DIR_BUSCAR=/home
fi

echo /usr/bin/clamscan -i -r -z -l $FICHERO_LOG $DIR_BUSCAR
/usr/bin/clamscan -i -r -z -l $FICHERO_LOG $DIR_BUSCAR
