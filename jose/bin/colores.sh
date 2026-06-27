#!/bin/sh
# Test de salida coloreada
# tputcolors http://stackoverflow.com/questions/18560647/ddg#18560675

echo
echo "$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)"

for i in $(seq 1 7); do
  echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
done

echo ' Bold            $(tput bold)'
echo ' Underline       $(tput sgr 0 1)'
echo ' Reset           $(tput sgr0)'
echo

# amarillo negrita
#echo "$(tput bold)$(tput setaf 3)Texto$(tput sgr0)"

# Otra forma https://soloconlinux.org.es/colores-en-bash/
# Colores (Sin estilo)
echo -e "\e[31m ROJO \e[33m  AMARILLO \e[32m VERDE \e[0m NORMAL"

# Negrita + Colores
echo -e "\e[1;31m ROJO \e[1;33m  AMARILLO \e[1;32m VERDE \e[1;39m NEGRITA \e[0m"

# Tachado + Colores
echo -e "\e[9;31m ROJO \e[9;33m  AMARILLO \e[9;32m VERDE \e[9;39m TACHADO \e[0m"
