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
## Instala el IDE PyCharm

############################
##       FUNCIONES        ##
############################
##
## Descarga PyCharm de su web oficial
## $1 string Recibe el nombre de la versión
##
pycharm_descargar() {
    descargar "${1}.tar.gz" "https://download.jetbrains.com/python/${1}.tar.gz"
}

pycharm_preconfiguracion() {
    echo -e "$VE Generando Pre-Configuraciones de$RO PyCharm$CL"
    if [[ -d "$HOME/.local/opt/pycharm" ]]; then
        rm -Rf "$HOME/.local/opt/pycharm"
    fi

    if [[ -f "$HOME/.local/bin/pycharm" ]]; then
        rm -f "$HOME/.local/bin/pycharm"
    fi

    if [[ -f "$HOME/.local/share/applications/pycharm.desktop" ]]; then
        rm -f "$HOME/.local/share/applications/pycharm.desktop"
    fi
}

##
## Instala PyCharm para el usuario dentro de ~/.local/opt
## $1 string Recibe el nombre de la versión
##
pycharm_instalar() {
    echo -e "$VE Preparando para instalar$RO PyCharm$CL"
    echo -e "$VE Extrayendo IDE$CL"
    cd "$WORKSCRIPT/tmp/" || return 0
    tar -zxf "${1}.tar.gz" 2>> /dev/null
    local directorio="$(ls | grep -E ^PyCharm.+[^\.tar\.gz]$)"
    mv "$WORKSCRIPT/tmp/$directorio" "$HOME/.local/opt/pycharm"
    cd "$WORKSCRIPT" || exit 1
}

pycharm_postconfiguracion() {
    echo -e "$VE Generando Post-Configuraciones$RO PyCharm$CL"

    echo -e "$VE Generando acceso directo$CL"
    rm -f "$HOME/.local/share/applications/pycharm.desktop"
    cp "$WORKSCRIPT/Accesos_Directos/pycharm.desktop" "$HOME/.local/share/applications/"

    echo -e "$VE Generando comando$RO pycharm$CL"
    ln -s "$HOME/.local/opt/pycharm/bin/pycharm.sh" "$HOME/.local/bin/pycharm"
}

pycharm_pro_instalador() {
    local version='pycharm-professional-2018.1.2'

    echo -e "$VE Comenzando instalación de$RO PyCharm$CL"

    pycharm_preconfiguracion "$version"

    if [[ -f "$HOME/.local/bin/pycharm" ]] &&
       [[ -d "$HOME/.local/opt/pycharm" ]]
    then
        echo -e "$VE Ya esta$RO PyCharm$VE instalado en el equipo, omitiendo paso$CL"
    else
        if [[ -f "$WORKSCRIPT/tmp/${version}.tar.gz" ]]; then
            pycharm_instalar "$version" || rm -Rf "$WORKSCRIPT/tmp/${version}.tar.gz"
        else
            pycharm_descargar "$version"
            pycharm_instalar "$version"
        fi
    fi

    pycharm_postconfiguracion "$version"
}
