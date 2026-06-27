#!/bin/bash
#
# Nombre del script: comprueba_usuario-01.sh
# Autor:
# Curso:
# Fecha:
#
# Descripción:
# comprobar si existe o no cada uno de los usuarios que me pasan por parámetro. Podemos recibir una cantidad indefinida
# de parámetros.
# Si el usuario existe crea un directorio llamado web dentro de su directorio personal.
# Configura el directorio para que el único usuario que pueda realizar operaciones de escritura y lectura sobre ese directorio sea el usuario en concreto.
# Uso:
# ./comprueba_usuario-01.sh usu1 usua2 ...
#

# ==============================
# INICIO DEL SCRIPT
# ==============================
check_usuario() {
  local USUARIO=$1
  if $(id $USUARIO &> /dev/null); then
    echo crea_directorio_web $USUARIO
  else
    echo "No Existe $USUARIO"
  fi
}

crea_directorio_web(){
  local USUARIO=$1
  DIR_HOME=$(grep -w ^jose /etc/passwd | cut -d: -f6)
  DIR_WEB=$DIR_HOME/web

  mkdir -p $DIR_WEB
  chown -R $DIR_WEB
  chmod 700 $DIR_WEB
}

for PARAMETRO; do
  check_usuario $PARAMETRO
done
# ==============================
# FIN DEL SCRIPT
# ==============================
