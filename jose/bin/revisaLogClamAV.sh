#!/bin/sh
# test date y expansión aritmética de shell:
#

# test lectura usuarios. La variable HOMES tiene cada home separadas por espacio
dame_homes ()
{
    local IFS=':'
    while read usuario password uid gid nombre home tipo_shell
    do
        # Encuentra los usuarios con home en /home
        if [ $(echo $home | grep home) ]
        then
            #printf "%s" "En $home: "
            HOMES="$home "$HOMES
        fi
    done < /etc/passwd     # usuario:x:uid:gid:Nombre Apellidos y +,,,:/home/usuario:/bin/bash
}
    
dame_homes
printf "%s\n" "HOMES:$HOMES"
LISTA_LOGS=""
for home in $HOMES
do
    FICH_LOG="$(find $home/.clamtk/history/ -type f -printf "%T+ %u %p\n" | grep jose | sort -r | head -1 | cut -d' ' -f3)"
    # Ultimo fichero en el directorio de log de clamav
    if [ -z $FICH_LOG ]; then # Cadena vacia
        #printf "%s\n" "No existe fichero de LOG"
        continue
    fi
    if [ ! -r $FICH_LOG ] # fichero no legible
    then 
        printf "%s\n" "Fichero $FICH_LOG no legible"
        ls -l $FICH_LOG
        continue 
    fi
    #printf "%s\n" "Procesar $FICH_LOG ..."
    LISTA_LOGS=$LISTA_LOGS" $FICH_LOG"
done

if [ -z "$LISTA_LOGS" ] 
then
    #printf "%s\n" "Procesar $LISTA_LOGS...."
    printf "%s\n" "No hay un log en que buscar. Salimos."
    exit 0
fi
    
printf "%s\n" "LISTA_LOGS:$LISTA_LOGS"
DIR_VIRUS=~/.clamtk/viruses

#FOUND=$(grep FOUND $LISTA_LOGS | cut -d: -f 2 | cut -d" " -f 2)
#$FOUND | cut -d: -f 2 | cut -d" " -f 2
INFECTADOS=$(grep -h FOUND $LISTA_LOGS | cut -d: -f 1)
NUM_INFECC=$(grep FOUND $LISTA_LOGS | wc -l)

if [ $NUM_INFECC -eq 0 ]; then
    printf "%s\n"  "No hay infectados. Salimos..."
    exit 0
fi

printf "%s\n" "Hay $NUM_INFECC Ficheros infectados: " "$INFECTADOS"
printf "%s" "¿Quieres borrarlos (Si/Cuarentena/Ver/otra)?"
read BORRAR
if [ $BORRAR = s -o $BORRAR = S ]; then 
    printf "%s\n" "Borrando $INFECTADOS ..."
    rm $INFECTADOS
elif [ $BORRAR = c -o $BORRAR = C ]; then
    printf "%s\n" "moviendo a $DIR_VIRUS ..."
    mv $INFECTADOS $DIR_VIRUS
elif [ $BORRAR = v -o $BORRAR = V ]; then
    ls -l $INFECTADOS
    #file $INFECTADOS
fi

printf "%s\n" "Listo!, Salimos ..."

    
