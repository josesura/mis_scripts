#!/bin/sh
uso()
{
    printf "%s\n" "Uso $0 nombre-fichero-selections"
}
if [ $# -eq 0 ]; then uso; return 1; fi

sudo dpkg --set-selections < $1 2>&1 | grep disponibles | cut -d: -f 4 | cut -c2- 
