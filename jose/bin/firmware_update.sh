#!/bin/dash
# Revisíon del firmware a actualizar
# 
printf "%s\n%s\n\n" "Revisando actualizaciones de firmware" "Necesitas tener instalado fwupdmgr"

fwupdmgr refresh

printf "\n%s\n%s\n%s\n" "Actualizar ejecutando (como root)" "# fwupdmgr update" ""
fwupdmgr get-updates
