#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2018 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      tecnico@fryntiz.es
## @web        www.fryntiz.es
## @github     https://github.com/fryntiz
## @gitlab     https://gitlab.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Guía de estilos aplicada:
## @style      https://github.com/fryntiz/Bash_Style_Guide

############################
##     INSTRUCCIONES      ##
############################

############################
##     IMPORTACIONES      ##
############################

###########################
##       FUNCIONES       ##
###########################
##
## Menú para elegir el conjunto de paquetes a instalar
## @param $1 -a Si recibe este parámetro ejecutará todos los scripts
##
menuPaquetes() {
    todos_paquetes() {
        clear
        echo -e "$VE Instalando todos los paquetes$CL"

        instalarSoftwareLista "$WORKSCRIPT/Apps/Packages/vps.lst"
    }

    ## Si la función recibe "-a" indica que instale todos los paquetes
    if [[ "$1" = '-a' ]]; then
        todos_paquetes
    else
        while true :; do
            clear
            local descripcion='Menú de Servidores y Lenguajes de programación
                1) VPS

                0) Atrás
            '
            opciones "$descripcion"

            echo -e "$RO"
            read -p "    Acción → " entrada
            echo -e "$CL"

            case $entrada in
                1)  instalarSoftwareLista "$WORKSCRIPT/Apps/Packages/vps.lst";;

                0)  ## SALIR
                    clear
                    echo -e "$RO Se sale del menú$CL"
                    echo ''
                    break;;

                *)  ## Acción ante entrada no válida
                    echo ""
                    echo -e "             $RO ATENCIÓN: Elección no válida$CL";;
            esac
        done
    fi
}
