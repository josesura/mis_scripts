#!/bin/sh
# Mostrar la fecha hora y nivel de carga
#


FECHA=$(/usr/bin/date +%H:%M)
ACPI=$(/usr/bin/acpi)
CARGA=$(echo $ACPI | awk '{print $4}'| cut -d, -f 1)
printf "%s\n" "$FECHA $CARGA"
