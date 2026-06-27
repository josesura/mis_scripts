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
if [ $# -eq 0 ]
then
  echo "$(basename $0): convertir ficheros ISO-8859-1 del PADI a UTF8 importable en libreoffice"
  echo
  echo "Uso:"
  echo "==="
  echo "$0 ficheros a convertir"
  echo
  echo "como se indicaría en el shell. Sin separar, admite comodines (glob)"
  echo
fi

for FICHERO in "$@"
do
    echo $FICHERO
    # Nombre del fichero sin PATH
    BASE=$(basename "$FICHERO")
    NOMBRE="${BASE%*.*}"
    EXT="${BASE##*.}"

    TEMP_FIC=$NOMBRE.conv
    iconv -o "$TEMP_FIC" -f ISO-8859-1 -t UTF8 "$FICHERO"
    sed -i -e 's/, IES/", "IES/' "$TEMP_FIC"
    sed -i -e 's/, CP IFP/", "CP IFP/' "$TEMP_FIC"
    tail -n+5 "$TEMP_FIC" | sort > "$NOMBRE"-conv."$EXT"
    rm "$TEMP_FIC"

done
