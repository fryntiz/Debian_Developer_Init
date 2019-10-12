#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2018 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      dev@fryntiz.es
## @web        https://fryntiz.es
## @gitlab     https://gitlab.com/fryntiz
## @github     https://github.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Guía de estilos aplicada:
## @style      https://gitlab.com/fryntiz/bash-guide-style

############################
##     INSTRUCCIONES      ##
############################
## Este script agrega repositorios comunes para todas las ramas.

###########################
##       FUNCIONES       ##
###########################
##
## Añade llaves oficiales para cada repositorio común
##
comunes_agregar_llaves() {
    ## Riot
    echo -e "$VE Agregando clave para$RO Riot$CL"
    curl -L https://riot.im/packages/debian/repo-key.asc | sudo apt-key add -

    ## Multisystem
    echo -e "$VE Agregando clave para$RO Multisystem$CL"
    sudo wget -q -O - http://liveusb.info/multisystem/depot/multisystem.asc | sudo apt-key add -

    ## Webmin
    echo -e "$VE Agregando clave para$RO Webmin$CL"
    wget http://www.webmin.com/jcameron-key.asc && sudo apt-key add jcameron-key.asc
    sudo rm jcameron-key.asc

    ## Virtualbox Oficial
    echo -e "$VE Agregando clave para$RO Virtualbox$CL"
    sudo wget https://www.virtualbox.org/download/oracle_vbox_2016.asc -O '/tmp/oracle_vbox.asc'
    sudo apt-key add '/tmp/oracle_vbox.asc'
    sudo rm '/tmp/oracle_vbox.asc'

    ## Docker
    echo -e "$VE Agregando clave para$RO Docker$CL"
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609D

    ## Heroku
    echo -e "$VE Agregando clave para$RO Heroku$CL"
    curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -

    ## Kali Linux
    echo -e "$VE Agregando clave para$RO Kali Linux$CL"
    sudo apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6

    ## Mi propio repositorio en launchpad
    echo -e "$VE Agregando clave para$RO Fryntiz Repositorio$CL"
    gpg --keyserver keyserver.ubuntu.com --recv-key B5C6D9592512B8CD && gpg -a --export $PUBKRY | sudo apt-key add -

    ## Repositorio de PostgreSQL Oficial
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

    ## Debian Multimedia
    instalarSoftware deb-multimedia-keyring

    ## Repositorio para Tor oficial y estable
    echo -e "$VE Agregando clave para$RO Tor Repositorio$CL"
    curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | sudo gpg --import && sudo gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
    actualizarRepositorios
    instalarSoftware 'deb.torproject.org-keyring' 'apt-transport-tor'

    ## Repositorio para mongodb.
    echo -e "$VE Agregando clave para$RO MongoDB Repositorio Oficial$CL"
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

    ## Repositorio para Team Viewer.
    echo -e "$VE Agregando clave para$RO Team Viewer Repositorio Oficial$CL"
    wget -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -

    ## Repositorio para Etcher
    echo -e "$VE Agregando clave para$RO Etcher$CL"
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

    ## Repositorio para editor Atom.
    echo -e "$VE Agregando clave para el editor$RO Atom$CL"
    wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
}

##
## Agrega los repositorios desde su directorio "comunes"
##
comunes_sources_repositorios() {
    echo -e "$VE Añadido$RO sources.list$VE y$RO sources.list.d/$VE Agregados$CL"

    if [[ ! -d '/etc/apt/sources.list.d' ]]; then
        sudo mkdir -p '/etc/apt/sources.list.d'
    fi

    sudo cp $WORKSCRIPT/Repositorios/debian/comunes/sources.list.d/* /etc/apt/sources.list.d/
}

##
## Instala repositorios que son descargados mediante un script oficial
##
comunes_download_repositorios() {
    echo -e "$VE Descargando repositorios desde scripts oficiales$CL"
    ## NodeJS Oficial
    echo -e "$VE Agregando repositorio$RO NodeJS$AM Repositorio Oficial$CL"
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -

    ## Riot
    echo -e "$VE Agregando Repositorio para$RO Riot (Matrix)$CL"
    sudo sh -c "echo '##deb https://riot.im/packages/debian/ artful main' > /etc/apt/sources.list.d/matrix-riot-im.list"

    ## Atom
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
}

##
## Añade todos los repositorios y llaves
##
comunes_agregar_repositorios() {
    echo -e "$VE Instalando repositorios$RO Comunes$CL"
    comunes_sources_repositorios
    comunes_download_repositorios
    echo -e "$VE Actualizando antes de obtener las llaves, es normal que se muestren errores$AM (Serán solucionados en el próximo paso)$CL"
    actualizarRepositorios
    comunes_agregar_llaves
    echo -e "$VE Actualizando listas de repositorios definitiva, comprueba que no hay$RO errores$CL"
    actualizarRepositorios
}