#!/bin/dash
# Revisíon más informada los paquetes a actualizar
# Lista el total de actualizaciones y permite filtrar aquellos de los que se quiere más info
# De ellos muestra el Description
# Por defecto filtra librerias, python, tomcat, bin, gtk
#
# Mirar esto: https://piproductora.com/enumere-las-actualizaciones-disponibles-pero-no-las-instale/
# 

printf "%s\n" "Lista de actualizaciones:"
COMANDO='cat bin/test/actualizaciones.txt'
ACTUALIZACION=$($COMANDO 2>/dev/null) #| tr -s '\n' ' ' 2>/dev/null

printf "%s\n" "$ACTUALIZACION"

FILTRO="bin$\|^cpp\|^dbus-\|^evolution\|^firefox\|g++\|gcc\|^gir1.2-\|^gnome\|gtk$\|^lib\|^nautilus\|^perl\|^php\|^python\|^systemd\|^vim\|^vlc"
printf "%s\n" "El Filtro definido es $FILTRO"
#printf "%s" "¿Quieres ver detalle (Todo|filtro Definido|otro Filtro|otra letra)?"
read -rp "¿Quieres ver detalle (Todo|filtro Definido|otro Filtro|otra letra)?" SEGUIR


if [ "$SEGUIR" = t ] || [ "$SEGUIR" = T ]
then 
	printf "%s\n" "Se muestra todo" 
elif [ "$SEGUIR" = d ] || [ "$SEGUIR" = D ]
then 
    printf "%s\n" "Se va a filtrar: $FILTRO" 
    
elif [ "$SEGUIR" = f ] || [ "$SEGUIR" = F ] 
then 
    #printf "%s\n" "Introduce tu filtro. Usa \\\| en lugar de \|" 
    read -rp "Introduce tu filtro. Usa \\\| en lugar de \|"  FILTRO
    printf "%s\n" "El Filtro definido es $FILTRO"
else
    return 0
fi
#for a in $(echo "$ACTUALIZACION" | grep -v $FILTRO); do apt show $a | grep --color=auto ^Package; apt show $a | grep --color=auto -A 10 ^Description; printf "\n" ;done 2>/dev/null
for a in $(echo "$ACTUALIZACION"); do printf "%s\n" "Paquete: $a"; apt show $a | grep --color=auto ^Package; apt show $a | grep --color=auto -A 10 ^Description; printf "\n" ;done 2>/dev/null

# actualizacion con autoremove: 
# sudo apt-get --autoremove upgrade
