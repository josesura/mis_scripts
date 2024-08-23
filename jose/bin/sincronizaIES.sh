#!/bin/sh 
# sincronizaIES.sh
# sincronizar workspaces y documentos entre el pen CosasJose y las ubicaciones locales
# Ver uso()
# todo: decidir donde va el backup, y si lo meto en el EXCLUDE
uso()
{
	printf "%s\n" "Uso $0 -d|-r"
	printf "%s\n" "-d: uso directo, copia de local al EXT"
	printf "%s\n" "-r: uso inverso, copia del EXT a local"
}
# 1 origen, 2 destino, 3 - 5: lo que se excluye
sincroniza() {
    EXCLUYE=""
    if [ $# -gt 2 ]; then #
        EXCLUYE=--exclude $3
        #EXCLUYE=--filter=-$3 
    fi
    COMANDO="rsync -aLuv --list-only --del --backup-dir=$BACKUP_DIR --chmod=D755,F644 $1 $2 $EXCLUYE"
    if [ ! $TEST -eq 0 ]; then
        printf "%s\n%s\n" "Se va a ejecutar" "$COMANDO"
        printf "%s" "¿Proceder (Si/otra)?"
        read VOY
        if [ ! $VOY = s -a ! $VOY = S ]; then 
            printf "%s\n" "Cancelado"
            return
        fi
    fi    
    printf "%s\n" "$COMANDO"
    $($COMANDO)
}

if [ $# -eq 0 ]; then #
    uso
    return 1
fi

TEST=1 #Distinto de cero para que lo sea
# Base de los filesystem externos
PEN=/media/jose/CosasJose
DDE=/media/jose/NtElem
# Elijo el FS ext
EXTERNO=$DDE

# Base de los filesystem locales
LOCAL=/comun/jose

# Rutas
WORKSPACE=workspaces/IESJuanHerrera
PROYECTO1=EjerciciosEntregados
PROYECTO2=TestJose
DOC_LOCAL=Documentos/Profe-CAM-2021-2/clases
DOC_EXT=clases

# FECHA, para backups, etc
FECHA=$(/usr/bin/date +%Y'_'%m%d-%H%M)

if [ $1 = -r ]; then
    echo opcion -r
    ORIGEN=$EXTERNO
    DESTINO=$LOCAL
    DOC_ORIGEN=$DOC_EXT
    DOC_DESTINO=$DOC_LOCAL
    BACKUP_BASE=../backup-r.$FECHA
elif [ $1 = -d ]; then
    echo opcion -d
    ORIGEN=$LOCAL
    DESTINO=$EXTERNO
    DOC_ORIGEN=$DOC_LOCAL
    DOC_DESTINO=$DOC_EXT
    BACKUP_BASE=../backup-d.$FECHA
else
    uso
    return 1
fi

COMANDO="rsync -aLu --del --backup-dir=$BACKUP_BASE $ORIGEN $DESTINO"
printf "%s\n%s\n" "Se va a ejecutar" "$COMANDO"
printf "%s" "¿Proceder (Si/otra)?"
read VOY
if [ ! $VOY = s -a ! $VOY = S ]; then 
    printf "%s\n" "Cancelado"
    return
fi

# Copia proyectos
BACKUP_DIR=$BACKUP_BASE/$PROYECTO1
sincroniza $ORIGEN/$WORKSPACE/$PROYECTO1/src $DESTINO/$WORKSPACE/$PROYECTO1
sincroniza $ORIGEN/$WORKSPACE/$PROYECTO1/bin $DESTINO/$WORKSPACE/$PROYECTO1
BACKUP_DIR=$BACKUP_BASE/$PROYECTO2
sincroniza $ORIGEN/$WORKSPACE/$PROYECTO2/src $DESTINO/$WORKSPACE/$PROYECTO2
sincroniza $ORIGEN/$WORKSPACE/$PROYECTO2/bin $DESTINO/$WORKSPACE/$PROYECTO2

# 2. Otros documentos
#echo $(ls $ORIGEN/$DOC_ORIGEN $DESTINO/$DOC_DESTINO)
#return
BACKUP_DIR=$BACKUP_BASE/clases
sincroniza $ORIGEN/$DOC_ORIGEN/ $DESTINO/$DOC_DESTINO "Bruce_Eckel/*master/ tutorial/ src/"

