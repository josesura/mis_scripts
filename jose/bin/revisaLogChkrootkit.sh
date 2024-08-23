#!/bin/bash 
# bin/revisaLogChkrootkit.sh
# Quiero comprobar si la ejecuacion de esto obtiene alguna cadena de tamaño > 0
# grep  -A 10 INFECTED ~jose/outCkMalware/chkrootkit*
printf %s $0
echo 
#INFECTADO=$(grep -A 10 INFECTED ~jose/outCkMalware/chkrootkit*)
INFECTADO=$(grep -A 10 INFECTED ~jose/outCkMalware/chkrootkit* | grep -v Searching | grep -v Checking | grep -v chkdirs | grep -v ^-- | cut -d- -f4)
if [[ -n $INFECTADO ]]  ; then 
    #grep -A 10 INFECTED ~jose/outCkMalware/chkrootkit* | grep -v Searching | grep -v Checking | grep -v chkdirs | grep -v ^-- 
    #grep -A 10 INFECTED ~jose/outCkMalware/chkrootkit* | grep -v Searching | grep -v Checking | grep -v chkdirs | grep -v ^-- | cut -d- -f4
    POSIBLE_VIRUS=$(grep INFECTED ~jose/outCkMalware/chkrootkit* | cut -d: -f3)
    printf "%s\n" "Encontrado$POSIBLE_VIRUS en este fichero: $INFECTADO"
    if [ -e $INFECTADO ]
    then 
        ls -l $INFECTADO
    else
        printf "%s\n" "Ya no existe"
    fi
    #grep -A 10 INFECTED ~jose/outCkMalware/chkrootkit* | grep -v Searching | grep -v Checking | grep -v chkdirs | grep -v ^-- | cut -d- -f4 | xargs file
else 
    #echo "INFECTADO=$INFECTADO;"
    echo "No hay problemas en ~jose/outCkMalware/chkrootkit*"
fi
