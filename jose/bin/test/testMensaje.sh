#!/bin/sh
# 
SALIDA=~/refrescoGpg.txt
MENSAJE="$0 Refresco de claves $(date +%Y-%m-%d)"
#echo $MENSAJE
if [ $? -eq 0 ]
then
    printf "%s\n" "$MENSAJE OK"
else
    printf "%s\n" "$MENSAJE KO"
fi
