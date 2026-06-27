#!/bin/sh
# Esta forma de definir funciones no le gusta a lint
uso() printf "%s\n" "Uso $0 comando"


if [ $# -eq 0 ]
  then  uso;
  return 1; 
fi

printf "%s %s\n" "# apt -o APT::Get::Trivial-Only=true $@"
sudo apt -o APT::Get::Trivial-Only=true "$@"
