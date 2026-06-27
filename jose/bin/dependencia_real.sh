#!/bin/sh
# Ver test/dependenciaReal.txt
# Ver las dependencias de un paquete directas o inversas respecto de lo que tengo instalado, mayormente de forma manual¿?.
# 
# Uso: dependenciaReal.sh paquete [-d]
# corregido con ShellCheck -- https://www.shellcheck.net/

if [ $# -eq 0 ]
then
	printf "%s\n" "Uso: $0 paquete [-d]"
	return
else
	PAQ_ORIGINAL=$1
	COMANDO=rdepends
	if [ $# -ge 2 ] 
    then #if [ $# -ge 2 -a "$2"="D"]; then
        if [ "$2" = "-d" ] 
        then
		    COMANDO=depends
        fi
	fi
fi
printf "%s\n" "Comando: $COMANDO"

FILTRADO=$(apt $COMANDO "$PAQ_ORIGINAL" | grep -E "Depende|Recomienda|Sugiere")
#echo $FILTRADO
#for PAQ_DEPENDIENTE in $(apt $COMANDO "$PAQ_ORIGINAL" | grep -E "Depende|Recomienda|Sugiere" | awk '{print $2}')

printf "%s %s\n" "Auto:1/0  paquete (version)"; 
printf "%s %s\n" "--------  -----------------"; 
for PAQ_DEPENDIENTE in $(echo "$FILTRADO" | awk '{print $2}')
do 
    #echo "$PAQ_DEPENDIENTE"
    # VERSION recoger version instalada y requerida para mostrar
	INSTALADO=$(dpkg -l "$PAQ_DEPENDIENTE" | grep -c ^ii) 
	if [ "$INSTALADO" -gt 0 ] 
    then 
		MAN=$(apt-mark showauto "$PAQ_DEPENDIENTE" | wc -l) 
        PAQ__DEP_V=$(echo "$FILTRADO" | grep "$PAQ_DEPENDIENTE" | cut -d: -f2-)
		printf "%s:%s   %s %s\n" Auto "$MAN" "$PAQ__DEP_V"; 
	fi 
done 2>/dev/null
printf "%s %s\n" "--------  -----------------"; 
printf "%s\n" "Auto:1 == automático (*); Auto:0 == manual"
printf "%s\n" "(*) Nos interesa más ésto"
