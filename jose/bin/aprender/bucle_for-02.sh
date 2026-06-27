#!/bin/sh
# Ahora escribe los comandos. P. ej:
#
# en bash se puede poner in {1..10}
for CONT in $(seq 10) # equivalente a seq 1 10
do
  echo -n "$CONT "
done

printf "\n"

