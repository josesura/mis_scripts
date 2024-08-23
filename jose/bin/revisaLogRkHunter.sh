#!/bin/sh
# bin/revisaLogRkHunter.sh
#echo "#:"$#",*:"$*"."
if [ $# != 0 ]; then # Num. de argumentos != 0
	#echo con argumento \'$1\', " lon:"${##}
	FECHA=`/usr/bin/date -d $1 +%y%m%d`
	#echo $MSJ`/usr/bin/date -d $1 +%Y/%m/%d`
else
	#echo sin argumento
	FECHA=`/usr/bin/date +%y%m%d`
	#echo $MSJ`/usr/bin/date +%Y/%m/%d`
fi

FIC_LOG=/home/jose/outCkMalware/rkhunter-$FECHA
printf "%s\n" "Reviso $FIC_LOG*"
#tail -n 17 $FIC_LOG*

# Esto del tail es la versión primitiva, hay que buscar concretamente la
# parte de las infecciones
# Suspect files:
# 
# egrep 'Suspect files:'\|'Possible rootkits:'
#egrep 'Suspect files:'\|'Possible rootkits:' $FIC_LOG*

# Afinar mas:
# | cut -d: -f4
# | cut -d] -f2
# | awk '{print $2" "$3" " $4}'

egrep 'Suspect files:'\|'Possible rootkits:' $FIC_LOG* |  awk '{print $2" "$3" " $4}'
