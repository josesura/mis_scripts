#!/bin/sh
# Hace un diff básico sobre directorios proporcionados
# diff -qr $1 $2
# Después sobre los archivos proporcionados en la salida
# Habria que hacer algo para seleccionar los deseados
# ls -l, diff , diff -y
uso()
{
	printf "%s\n" "Uso $0 dir1 dir2"
}
uso
return

TEST=0; # Poner 1 para testear
# Filtro de lo más pesado en general
FILTRO="^lib\|^python\|^tomcat\|bin$\|gtk$"
PRE_FILTRO="Listando..."

printf "%s\n" "Lista de actualizaciones:"
apt list --upgradable 2>/dev/null #| tr -s '\n' ' ' 2>/dev/null
printf "%s\n" "El Filtro definido es $FILTRO"
printf "%s" "¿Quieres ver detalle (Todo|filtro Definido|otro Filtro|otra letra)?"
read SEGUIR


if [ $SEGUIR = t -o $SEGUIR = T ]; then 
	FILTRO=$PRE_FILTRO
elif [ $SEGUIR = d -o $SEGUIR = D ]; then
    printf "%s\n" "Se va a filtrar: $FILTRO" 
    FILTRO="$PRE_FILTRO\|$FILTRO"
elif [ $SEGUIR = f -o $SEGUIR = F ]; then
    printf "%s\n" "Introduce tu filtro. Usa \\\| en lugar de \|" 
    read FILTRO
    printf "%s\n" "El Filtro definido es $FILTRO"
    FILTRO="$PRE_FILTRO\|$FILTRO"
else
    return 0
fi

if [ ! $TEST -eq 0 ]; then 
    # Contenido en el fichero listaTest
    #for a in $(cut -d/ -f 1 listaTest | grep -v $FILTRO ); do apt show $a | grep --color=auto ^Package; apt show $a | grep -A 10 ^Description;done 2>/dev/null
    printf "%s\n" "$FILTRO"
    printf "%s\n" "$(apt list --upgradable | cut -d/ -f1 | grep -v $FILTRO);"
    for a in $(apt list --upgradable | cut -d/ -f1 | grep -v $FILTRO); do printf "%s\n" "$a"; done
else
    for a in $(apt list --upgradable | cut -d/ -f1 | grep -v $FILTRO); do apt show $a | grep --color=auto ^Package; apt show $a | grep --color=auto -A 10 ^Description; printf "\n" ;done 2>/dev/null
fi

