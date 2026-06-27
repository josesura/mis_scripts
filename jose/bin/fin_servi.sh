#!/bin/sh
# Iniciar servicios indicados
# comando sudo service X stop

#FECHA=$(/usr/bin/date +%H:%M)
#

uso() {
  printf "%s\n" "Uso: $0 lista-de-servicios"
}

if [ $# -eq 0 ]
  then  uso;
  return 1; 
fi

for SERVI in "$@"
do
  sudo service "$SERVI" stop
done
