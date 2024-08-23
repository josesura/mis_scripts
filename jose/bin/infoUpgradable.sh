#!/bin/dash
# Revisíon más informada los paquetes a actualizar
# Lista el total de actualizaciones y permite filtrar aquellos de los que se quiere más info
# De ellos muestra el Description
# Por defecto filtra librerias, python, tomcat, bin, gtk
#
# Mirar esto: https://piproductora.com/enumere-las-actualizaciones-disponibles-pero-no-las-instale/
# 
printf "%s\n" "Revisando actualizaciones disponibles"

if ! true; then 
	ACTUALIZA_BD=$(sudo apt update)
	printf "%s\n" "$ACTUALIZA_BD"

	NUM_ACTUALIZ=$(echo "$ACTUALIZA_BD" | grep "actualizar" | awk '{print $4}') 
	printf "%s\n" "'NUM_ACTUALIZ:'$NUM_ACTUALIZ"
	return
fi
	
sudo apt-get update

OLD=0
# OLD
if [ $OLD -eq 1 ]; then
	COMANDO='apt list --upgradable'
	PRE_FILTRO="Listando..."
	NUM_ACTUALIZ=$($COMANDO | wc -l) 
else
# Nuevo
	COMANDO='apt-get --just-print upgrade'
	NUM_ACTUALIZ=$($COMANDO | grep actualizados | awk '{print $1}')
fi
# control de salida correcta. Otra opcion es comprobar si esta en uso /var/lib/apt/lists/lock
EXITO=$?
if [ ! $EXITO -eq 0 ]; then 
	printf "%s\n" "Comando: $COMANDO. Salida: $EXITO"
	printf "%s\n" "No es posible refrescar las actualizaciones. Esperar unos momentos"
	return
fi

if [ "$NUM_ACTUALIZ" -eq "0" ]; then 
    printf "%s\n" "No hay actualizaciones disponibles"
    return
fi
#printf "%s\n" "Hay $NUM_ACTUALIZ actualizaciones disponibles. ¿Quieres verlas? (No/Otra)"
read -rp "Hay $NUM_ACTUALIZ actualizaciones disponibles. ¿Quieres verlas? (No/Otra)" SEGUIR

if [ "$SEGUIR" = n ] || [ "$SEGUIR" = N ]; then 
    return
fi

# actualizo cache de apt-file
sudo apt-file update

printf "%s\n" "Lista de actualizaciones:"
#if [ "$OLD" -eq "1" ]; then
if true ; then
	# OLD
	COMANDO='apt list --upgradable'
	PRE_FILTRO="Listando..."
	ACTUALIZACION=$($COMANDO | grep -v "$PRE_FILTRO" 2>/dev/null) #| tr -s '\n' ' ' 2>/dev/null
else
	# Nuevo
	ACTUALIZACION=$($COMANDO | grep -A1 actualizarán 2>/dev/null) #| tr -s '\n' ' ' 2>/dev/null
	ACTUALIZACION=$(echo "$ACTUALIZACION" | grep -v actualizarán)
fi
printf "%s\n" "$ACTUALIZACION"

#salir
#if [ "$OLD" -eq "0" ]; then
if ! true ; then
 return
fi


FILTRO="bin$\|^cpp\|^dbus-\|^evolution\|^firefox\|g++\|gcc\|^gir1.2-\|^gnome\|gtk$\|^lib\|^nautilus\|^perl\|^php\|^python\|^systemd\|^vim\|^vlc"
printf "%s\n" "El Filtro definido es $FILTRO"
#printf "%s" "¿Quieres ver detalle (Todo|filtro Definido|otro Filtro|otra letra)?"
read -rp "¿Quieres ver detalle (Todo|filtro Definido|otro Filtro|otra letra)?" SEGUIR


if [ "$SEGUIR" = t ] || [ "$SEGUIR" = T ]; then 
	FILTRO="$PRE_FILTRO"
elif [ "$SEGUIR" = d ] || [ "$SEGUIR" = D ]; then 
    printf "%s\n" "Se va a filtrar: $FILTRO" 
    FILTRO="$PRE_FILTRO\|$FILTRO"
elif [ "$SEGUIR" = f ] || [ "$SEGUIR" = F ]; then 
    #printf "%s\n" "Introduce tu filtro. Usa \\\| en lugar de \|" 
    read -rp "Introduce tu filtro. Usa \\\| en lugar de \|"  FILTRO
    printf "%s\n" "El Filtro definido es $FILTRO"
    FILTRO="$PRE_FILTRO\|$FILTRO"
else
    return 0
fi
# No funciona porque $ACTUALIZACION no tiene saltos de linea. Pero con "" sí debería tenerlos
for a in $(echo "$ACTUALIZACION" | cut -d/ -f1 | grep -v $FILTRO); do apt show $a | grep --color=auto ^Package; apt show $a | grep --color=auto -A 10 ^Description; printf "\n" ;done 2>/dev/null
#for a in $(apt list --upgradable | cut -d/ -f1 | grep -v "$FILTRO"); do apt show "$a" | grep --color=auto ^Package; apt show "$a" | grep --color=auto -A 10 ^Description; printf "\n" ;done 2>/dev/null

# actualizacion con autoremove: 
# sudo apt-get --autoremove upgrade
