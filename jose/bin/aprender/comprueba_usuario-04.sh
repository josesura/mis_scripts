#!/bin/bash
#
# Nombre del script: comprueba_usuario-01.sh
# Autor:
# Curso:
# Fecha:
#
# Descripción:
#
# Comprobar si existe o no cada uno de los usuarios que me pasan por parámetro. Podemos recibir una cantidad indefinida
# de parámetros.
#
# Si el usuario existe crea un directorio llamado web dentro de su directorio personal.
# Configura el directorio para que el único usuario que pueda realizar operaciones de escritura y lectura sobre ese
# directorio sea el usuario en concreto.
#
# Si el usuario no existe vamos a dar la posibilidad de que se pueda crear
# preguntamos al operador si desea crear la cuenta de usuario
# Si la respuesta es negativa, no hacemos nada
# Si la respuesta es afirmativa, crearemos una nueva cuenta de usuario en el sistema con el nombre del usuario pasdo
# por parámetro y con la contraseña ClaveRoot#20. Además, crearemos el directorio web cómo en el caso anterior
#
# ahora vamos a leer los datos de un fichero en el que en cada línea hay el nombre de un usuario.
# Me tienen pasar por parámetro la ruta del fichero con el que vamos a trabajar. PTE https://www.educatica.es/informatica/sistemas-operativos-en-red/casos-practicos/2405-scripts-gnu-linux/ejemplos-de-repaso-de-scripts/
#
# Uso:
# ./comprueba_usuario-01.sh usu1 usua2 ...
#

# ==============================
# INICIO DEL SCRIPT
# ==============================
check_usuario() {
  local USUARIO=$1
  if ! $(id $USUARIO &> /dev/null); then
    read -p "¿Desea crear el nuevo usuario? (s/[N])" CREAR

    if [ $CREAR = "s" -o $CREAR = "S"; then
      useradd -m -s /bin/bash $USUARIO | chpasswd
    fi

  if $(id $USUARIO &> /dev/null); then
    echo crea_directorio_web $USUARIO
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
