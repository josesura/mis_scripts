#!/bin/bash
#
# Nombre del script: comprueba_usuario-01.sh
# Autor:
# Curso:
# Fecha:
#
# Descripción:
# comprobar si existe o no cada uno de los usuarios que me pasan por parámetro.
# Podemos recibir una cantidad indefinida de parámetros
#
# Uso:
# ./comprueba_usuario-01.sh usu1 usua2 ...
#

# ==============================
# INICIO DEL SCRIPT
# ==============================
check_usuario() {
  local USUARIO=$1
  if $(id $USUARIO &> /dev/null); then
    echo "Existe $USUARIO"
  else
    echo "No Existe $USUARIO"
  fi
}

for PARAMETRO; do
  check_usuario $PARAMETRO
done
# ==============================
# FIN DEL SCRIPT
# ==============================
