#!/bin/sh
# Iniciar servicios indicados
# comando sudo service X start

#FECHA=$(/usr/bin/date +%H:%M)
#

uso() {
  printf "%s\n" "Uso: $0 lista-de-servicios"
}

if [ $# -eq 0 ]
  then  uso;
  return 1; 
fi

if [ -f $1 ]
then
  printf "$s\n" "Leo servicios del fichero $1"
  LISTA="$(cat $1)"
  printf "$s\n" "Lista: $LISTA"
else
  LISTA="$@"
  printf "$s\n" "Lista: $LISTA"
fi

for SERVI in "$@"
do
  sudo service "$SERVI" start
done
