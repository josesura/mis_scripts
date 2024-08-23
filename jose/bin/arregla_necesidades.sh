#!/bin/sh
# Arreglar Descarga de necesidades ARES tipo csv para importar en hoja de cálculo:
# * Separar el código de centro del nombre que vienen en la misma columna
# * Si veo cómo, convertir fichero ISO-8859 text en UTF-8 --> iconv, pero no trata las Ñ
# * Quitar 4 primeras líneas
# $ grep ', IES' Resolucion_necesidades-0304-PS.csv
# ...
# grep: Resolucion_necesidades-0304-PS.csv: coincidencia en fichero binario
# $ file file Resolucion_necesidades-0304-PS.csv 
# Resolucion_necesidades-0304-PS.csv: ISO-8859 text, with CRLF, LF line terminators
# $ $ sed -e 's/, IES/", "IES/' Resolucion_necesidades-0304-PS.csv
# iconv -o Resolucion_necesidades-0304-PS-conv.csv -f ISO-8859-1 -t UTF8 Resolucion_necesidades-0304-PS.csv

# Nombre del fichero sin PATH
BASE=$(basename $1)
NOMBRE="${BASE%*.*}"
EXT="${BASE##*.}"

TEMP_FIC=$NOMBRE.conv
iconv -o $TEMP_FIC -f ISO-8859-1 -t UTF8 $1
sed -i -e 's/, IES/", "IES/' $TEMP_FIC
tail -n+5 $TEMP_FIC > $NOMBRE-conv.$EXT
rm $TEMP_FIC

