#!/bin/sh
# test date y expansión aritmética de shell
#
dias_fin_ano() echo "$(( 365­ - $(date +%-j) )) dias para el 31 de Dic"

# test lectura usuarios. La variable HOMES tiene cada home separadas por espacio
dame_homes ()
{
    local IFS=''
    while read usuario password uid gid nombre home tipo_shell
    do
        # Encuentra los usuarios con home en /home
        if [ $(echo $home | grep home) ]
        then
            #printf "%s" "En $home "
            HOMES="$home "$HOMES
        fi
    done < /etc/passwd     # usuarioxuidgidNombre Apellidos y +,,,/home/usuario/bin/bash
}

expansion ()
{    
    # Expansion de params.
    local ALGO=Algo
    unset NADA; 
    echo "-1-"
    # Use Default Values
    A=${ALGO:-Defect}     # the value of parameter is substituted
    B=${NADA:-Defect}     # the expansion of word is substituted;
    echo $A $B            # Algo Defect 
    echo $ALGO $NADA      # Algo

    echo "-2-"
    # Assign Default Values. In all cases, the final value of parameter is substituted.  Only variables, not positional parameters or special parameters, can be assigned in this way.
    unset NADA; echo $NADA
    A=${ALGO:=Defect}     # Assign Default Values.
    B=${NADA:=Defect}     # the expansion of word is assigned to parameter
    echo $A $B            # Algo Defect    
    echo $ALGO $NADA      # Algo Defect

    echo "-3-"
    # Indicate Error if Null or Unset
    unset NADA; unset B
    A=${ALGO:?Defect}     # the value of parameter is substituted
    #B=${NADA:?Defect}    # Indicate Error if Null or Unset
    echo $A $B            # Algo 
    echo $ALGO $NADA      # Algo 

    echo "-4-"
    #Use Alternative Value 
    unset NADA; echo $NADA
    A=${ALGO:+Defect}     # expansion of word is substituted
    B=${NADA:+Defect}     # null is substituted
    echo $A $B            # Defect 
    echo $ALGO $NADA      # Algo 
}

comprobar ()
{
    local VAR=PENPENPENDEJOPAPAPAPA
    echo ${VAR%PA*}       # elimina patrón del sufijo más pequeño
    echo ${VAR%%PA*}      # elimina el patrón del sufijo más largo
    echo ${VAR#*PEN}      # elimina el patrón del prefijo más pequeño
    echo ${VAR##*PEN}     # elimina el patrón del prefijo más largo
}

expansion
