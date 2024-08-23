#!/bin/sh
# Revision de paquetes instalados, de paquetes que no son Debian y obsoletos
msgSal() {
    if [ $# -gt 2 ]; then
        printf "%s\n Error en los parametros $0 $*"
        exit 1
    fi
    printf "%s\n" "$1" | tee -a $2
}
# Comprobar directorio de copias antiguas
DIR_OLD=pkt-old
[ -d $DIR_OLD ] || mkdir $DIR_OLD

# if [ ! 0 -eq 0 ]; then

FIC=pkt-0noDevuan
[ ! -e $FIC ] || mv $FIC $DIR_OLD
msgSal "Buscando con aptitude paquetes que no son Devuan" $FIC
msgSal "# aptitude search '?narrow(?installed, ?not(?origin(Devuan)))'" $FIC
aptitude search '?narrow(?installed, ?not(?origin(Devuan)))' | tee -a $FIC
msgSal "-------------------------" $FIC
msgSal "" $FIC

FIC=pkt-1noDeXXan-forktracer
[ ! -e $FIC ] || mv $FIC $DIR_OLD
msgSal "Buscando con apt-forktracer paquetes que no son Dexxan" | tee -a $FIC
msgSal "# apt-forktracer | sort" $FIC
apt-forktracer | sort | tee -a $FIC
msgSal "-------------------------" $FIC
msgSal "" $FIC

if [ ! true ]; then
	FIC=pkt-1noDebian-aptitude
	[ ! -e $FIC ] || mv $FIC $DIR_OLD
	msgSal "Buscando con aptitude paquetes que no son Debian" $FIC
	msgSal "# aptitude search '?narrow(?installed, ?not(?origin(Debian)))'" $FIC
	aptitude search '?narrow(?installed, ?not(?origin(Debian)))' | tee -a $FIC
	msgSal "-------------------------" $FIC
	msgSal "" $FIC
fi

FIC=pkt-2obsoletos
[ ! -e $FIC ] || mv $FIC $DIR_OLD
msgSal "Buscando paquetes obsoletos" $FIC
msgSal "# aptitude search '~o'" $FIC
aptitude search '~o' | tee -a $FIC
msgSal "" $FIC
msgSal "Se pueden purgar con " $FIC
msgSal "# aptitude purge '~o'" $FIC
msgSal "-------------------------" $FIC
msgSal "" $FIC

FIC=pkt-3eliminados-dpkg
[ ! -e $FIC ] || mv $FIC $DIR_OLD
msgSal "Buscando paquetes eliminados con dpkg" $FIC
msgSal "# dpkg -l | awk '/^rc/ { print $2 }'" $FIC
dpkg -l | awk '/^rc/ { print $2 }' | tee -a $FIC
msgSal "Se pueden purgar con: " $FIC
msgSal '# apt purge $(dpkg -l | awk '\''/^rc/ { print $2 }'\'')' $FIC
msgSal "-------------------------" $FIC
msgSal "" $FIC

FIC=pkt-3eliminados-aptitude
[ ! -e $FIC ] || mv $FIC $DIR_OLD
msgSal "Buscando paquetes eliminados con aptitude" $FIC
msgSal "aptitude search '~c'" $FIC
aptitude search '~c' | tee -a $FIC
msgSal "" $FIC
msgSal "Se pueden purgar con: " $FIC
msgSal "# aptitude purge '~c' " $FIC
msgSal "-------------------------" $FIC
msgSal "FIN" $FIC

#fi
