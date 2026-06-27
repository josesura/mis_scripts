#!/bin/dash
# Revisíon y actualización de elementos fuera del ámbito del gestor de paquetes (apt)
#
# Esquema, para cada entorno a actualizar
# printf "\n\n%s\n%s\n" "Revisar entorno XX..." " ... Necesitas tener instalado XX"
# if [ -x /usr/bin/COMANDO ]
# then
#     printf "\n\n%s\n" "XX check... "
#     /usr/bin/COMANDO
#     printf "\n\n%s\n%s\n\n" "Actualizar con:" "$ XX"
# else
#     printf "\n%s\n" "No encontrado /usr/bin/COMANDO"
# fi
# read -rp "Pulsa enter para seguir..." SEGUIR
#
# Formato: lo siguiente pone SALIDA negrita en amarillo$(tput bold)$(tput setaf 6) SALIDA$(tput sgr0)
# man tput      tput - initialize a terminal ....
# man terminfo  terminfo - terminal capability database. Colores: 1 rojo, 2 verde, 3 amarillo, 4 azul, 5 magenta, 6 cyan, 7 blanco
#
#clear
printf "%s %s\n" "$(tput bold)$(tput setaf 5)Revisando actualizaciones$(tput sgr0)" "firmware, rustup, flatpak, podman, ... lo que esté instalado"

# fwupdmgr: Firmware
printf "\n%s %s\n" "$(tput bold)$(tput setaf 6)Firmware$(tput sgr0)" "... Necesitas tener instalado fwupdmgr"
if [ -x /usr/bin/fwupdmgr ]
then
    printf "\n%s\n%s\n" "Refrescar estado" "\$ $(tput setaf 2)fwupdmgr refresh$(tput sgr0)"
    /usr/bin/fwupdmgr refresh

    printf "\n%s\n%s\n%s" "Comprobar actualizaciones" "\$ $(tput setaf 2)fwupdmgr get-updates$(tput sgr0)"
    /usr/bin/fwupdmgr get-updates
    # salida echo $? = 2 # ver pág man --> return code of “2” is used for commands that have no actions but were successfully executed
    SALIDA=$?
    printf "%s %s\n" "Resultado $(tput bold)$(tput setaf 6)get-updates:" "$(tput setaf 5)$SALIDA$(tput sgr0)"

    if [ "$SALIDA" -eq 0 ]
    then
      printf "%s\n%s\n\n" "Actualizar ejecutando (como root)" "$(tput bold)# $(tput setaf 2)fwupdmgr update$(tput sgr0)"
      read -rp "Pulsa enter para seguir" SEGUIR
    fi

else
    printf "\n%s\n" "No encontrado /usr/bin/fwupdmgr"
fi

#read -rp "Pulsa enter para seguir" SEGUIR

# flatpak
printf "\n%s %s\n" "$(tput bold)$(tput setaf 6)Entorno flatpak$(tput sgr0)" "... Necesitas tener instalado flatpak"
if [ -x /usr/bin/flatpak ]
then
    printf "\n%s\n%s\n" "\$ $(tput setaf 2)flatpak list --app$(tput sgr0)" "Aplicaciones instaladas:"
    /usr/bin/flatpak list --app
    # salida sin nada echo $? = 0
    printf "\n\n%s\n%s\n" "Actualizando " "# $(tput setaf 2)flatpak update$(tput sgr0)"
    sudo /usr/bin/flatpak update

    printf "%s %s\n\n" "Para desinstalar:" "# $(tput setaf 1)flatpak uninstall $(tput bold)ID de aplicación$(tput sgr0)"

    read -rp "Pulsa enter para seguir" SEGUIR
else
    printf "\n%s\n" "No encontrado /usr/bin/flatpak"
fi
#read -rp "Pulsa enter para seguir" SEGUIR

# rustup: Entorno Rust
printf "\n%s %s" "$(tput bold)$(tput setaf 6)Entorno rust$(tput sgr0)" "... Necesitas tener instalado rustup"
if [ -x /usr/bin/rustup ]
then
    if [ ! true ]
    then
        printf "\n%s\n\n" "\$ $(tput setaf 2)rustup check | grep -v rustup | grep --color=auto -E \"Update available|Up to date\"$(tput sgr0)"
        #/usr/bin/rustup check
        /usr/bin/rustup check | grep -v rustup | grep --color=auto -E "Update available|Up to date"
        # stable-x86_64-unknown-linux-gnu - Update available : 1.86.0 (05f9846f8 2025-03-31) -> 1.87.0 (17067e9ac 2025-05-09)

        printf "\n%s\n%s\n\n" "En ese caso actualizar con:" "$(tput bold)\$ $(tput setaf 2)rustup update$(tput sgr0)"
        #printf "%s\n\n" "\$ $(tput setaf 2)rustup update$(tput sgr0)"
    fi
    # rustup check | grep -v rustup | grep --color=auto -E "Update available" | wc -l --> 0: sin actualizaciones
    printf "\n%s\n" "\$ $(tput setaf 2)rustup check | grep -v rustup | grep --color=auto -E \"Update available\" $(tput sgr0)"
    NUM_ACTUALIZA="$(rustup check | grep -v rustup | grep --color=auto -E 'Update available' | wc -l)"
    #NUM_ACTUALIZA=1

    if [ "$NUM_ACTUALIZA" -eq "0" ]
    then
        printf "\n%s\n" "No hay actualizaciones para rustup"
    else
        ACTUALIZACION="$(rustup check | grep -v rustup | grep --color=auto -E 'Update available')"
        printf "\n%s %s" "Hay actualizaciones para rustup: " "$ACTUALIZACION"
        printf "\n%s\n%s %s\n" "$(tput setaf 6)Comenzamos$(tput sgr0) ..." "\$ $(tput bold)$(tput setaf 2)rustup update$(tput sgr0)" "..."
        rustup update
        read -rp "Pulsa enter para seguir" SEGUIR
    fi

else
    printf "\n%s\n" "No encontrado /usr/bin/rustup"
fi
#read -rp "Pulsa enter para seguir" SEGUIR

# podman
printf "\n%s %s\n" "$(tput bold)$(tput setaf 6)Entorno podman$(tput sgr0)" "... Necesitas tener instalado podman"
if [ -x /usr/bin/podman ]
then
    printf "\n%s\n" "\$ $(tput setaf 2)podman images$(tput sgr0)"
    /usr/bin/podman images
    printf "%s\n%s\n%s\n%s\n" "Actualizar con:" "\$ $(tput setaf 2)podman pull $(tput bold)<imagen>$(tput sgr0)" "P.ej:" "\$ $(tput setaf 2)podman pull $(tput bold)mariadb:11.5$(tput sgr0)"

#    read -rp "Pulsa enter para seguir" SEGUIR
else
    printf "\n%s\n" "No encontrado /usr/bin/podman"
fi
printf "\n%s\n\n" "$(tput bold)$(tput setaf 5)¡Terminado!!$(tput sgr0)"
