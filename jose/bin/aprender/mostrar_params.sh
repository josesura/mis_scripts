#!/bin/sh
# Ahora escribe los comandos. P. ej:
#
# help for

NUM=1

for PARM
do
  echo "($NUM) - $PARM"
  NUM=$(($NUM+1))
done

if [ $# -ne 0 ]
then
  echo "El número de parámetros es: $#"
else
  echo "No se han pasado parámetros"
fi
