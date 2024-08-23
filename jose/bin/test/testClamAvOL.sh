#!/bin/bash 
# bin/testClamAvOL.sh
# Lo mismo que el otro con alguna opcion de verbosidad y aviso

source $HOME/bin/preparaLogs.sh /home/testadmin/outCkMalware clamscan

if [[ '' != $1 ]]; then
	DIR_BUSCAR=$1
else
	DIR_BUSCAR=$PWD
fi

echo /usr/bin/clamscan -i -r -z -l -a -v $FICHERO_LOG $DIR_BUSCAR
/usr/bin/clamscan -i -r -z -l -a -v $FICHERO_LOG $DIR_BUSCAR
