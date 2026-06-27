#!/bin/sh
# revisaClamAV.sh revisa los log de la tarea diaria de clamscan y ofrece opciones respecto de los posibles virus detectados
# uso revisaClamAV.sh fecha
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
FORMATO_LOGS="+\%F"
if [ $# -eq 0 ] 
then
    DIA=today
    FICHERO=$(date +\%F -d today)
else
    DIA=$1
    FICHERO=$(date +\%F -d $"DIA")
    if [ $? gt 0 ]
    then
        printf "%s\n%s\n%s\n" "Uso: $0 Fecha(cadena de texto con un formato más o menos libre para indicar una fecha" \
        "Ejemplo: \"2020-02-29 16:21:42\", incluso podría ser \"next Thursday\""\
        "Ejemplos en man date CADENA DE FECHA"
        return
    fi
fi

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
    
DIR_CUARENTENA=~/.clamtk/viruses
printf "%s\n" "LISTA_LOGS:$LISTA_LOGS"
printf "%s\n" "DIR_CUARENTENA:$DIR_CUARENTENA"

#FOUND=$(grep FOUND $LISTA_LOGS | cut -d: -f 2 | cut -d" " -f 2)
#$FOUND | cut -d: -f 2 | cut -d" " -f 2
INFECTADOS=$(grep -h FOUND $LISTA_LOGS | cut -d: -f 1)
NUM_INFECC=$(grep FOUND $LISTA_LOGS | wc -l)

if [ $NUM_INFECC -eq 0 ]; then
    printf "%s\n"  "No hay infectados. Salimos..."
    exit 0
fi

# $(tput bold)$(tput setaf 2)XX$(tput sgr0)
# man terminfo  terminfo - terminal capability database. Colores: 1 rojo, 2 verde, 3 amarillo, 4 azul, 5 magenta, 6 cyan, 7 blanco
printf "%s\n%s\n" "Hay $(tput setaf 1)$NUM_INFECC Ficheros infectados$(tput sgr0)" "$INFECTADOS"
read -rp "¿Quieres borrarlos (Si/Cuarentena/Ver/Listar/otra)?" ACCION
#printf "%s" "¿Quieres borrarlos (Si/Cuarentena/Ver/Listar/otra)?"
if [ $ACCION = s -o $ACCION = S ] # BORRAR
then 
    printf "%s\n%s\n" "Borrando..." "$INFECTADOS"
    rm $INFECTADOS

elif [ $ACCION = c -o $ACCION = C ] # MOVER A CUARENTENA
then 
    printf "%s\n" "moviendo a $DIR_CUARENTENA ..."
    mv $INFECTADOS $DIR_CUARENTENA
    
elif [ $ACCION = v -o $ACCION = V ] # Ver el contenido
then
    for FIC_INFECTADO in $INFECTADOS
    do 
        printf "%s\n" "Buscando http en $FIC_INFECTADO:"
        grep -a http $FIC_INFECTADO
        read -rp "Pulsa enter para seguir..." SEGUIR
        printf "\n\n"
    done
    
elif [ $ACCION = l -o $ACCION = L ] # Listar (si existen)
then
    ls -l $INFECTADOS
    #file $INFECTADOS

fi

printf "\n%s\n" "Listo!, Salimos ..."
