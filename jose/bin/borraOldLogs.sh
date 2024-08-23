#!/bin/bash 
# borraOldLogs.sh
# Borra ficheros de log de rkhunter, chkrootkit, clamscan
# directorios: 	~jose/outCkMalware/	para los rootkit
#		~jose/.clamtk/history/		para clamscan
# Se puede poner la antigüedad mínima a borrar como 3er argumento (en dias)

~jose/bin/borraOldFiles.sh chkrootkit ~jose/outCkMalware/
~jose/bin/borraOldFiles.sh rkhunter ~jose/outCkMalware/
~jose/bin/borraOldFiles.sh kk ~jose/.clamtk/history/ 10

