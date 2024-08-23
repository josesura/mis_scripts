#!/bin/sh
# Ver test/dependenciaReal.txt
# Ver las dependencias de un paquete directas o inversas respecto de lo que tengo instalado, mayormente de forma maual.
# 
# Uso: dependenciaReal.sh paquete [-d]
# corregido con ShellCheck -- https://www.shellcheck.net/

if [ $# -eq 0 ]; then
	printf "%s\n" "Uso: $0 paquete [-d]"
	return
else
	PAQ=$1
	COMANDO=rdepends
	if [ $# -ge 2 ]; then #if [ $# -ge 2 -a "$2"="D"]; then
        if [ "$2" = "-d" ]; then
		    COMANDO=depends
        fi
	fi
fi
printf "%s\n" "Comando:$COMANDO"

for p in $(apt $COMANDO "$PAQ" | grep -E "Depende|Recomienda" | awk '{print $2}')
do 
	INS=$(dpkg -l "$p" | grep -c ^ii) 
	if [ "$INS" -gt 0 ]; then 
		MAN=$(apt-mark showauto "$p"|wc -l) 
		printf "%s:%s  %s\n" Auto "$MAN" "$p"; 
	fi 
done 2>/dev/null

