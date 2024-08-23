#!/bin/sh
# probar quitar extension a fichero
DIRN=$(dirname $1)
BASE=$(basename $1)
EXT="${BASE##*.}"
TODAS_EXT="${BASE#*.}"
NOMBRE="${BASE%*.*}"
echo DIRN: $DIRN
echo BASE: $BASE
echo NOMBRE: $NOMBRE
echo EXT: $EXT
echo TODA_EXT: $TODAS_EXT
# El fichero sería $NOMBRE.$EXT

