#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2017 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      dev@fryntiz.es
## @web        https://fryntiz.es
## @gitlab     https://gitlab.com/fryntiz
## @github     https://github.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Guía de estilos aplicada:
## @style      https://gitlab.com/fryntiz/bash-style-guide

############################
##     INSTRUCCIONES      ##
############################
## Prepara un VPS recién creado antes de ejecutar el script principal.
## Este script debe ejecutarse como root.

###########################
##       FUNCIONES       ##
###########################

if [[ $USER != 'root' ]]; then
    echo 'Este script tiene que ser iniciado por root'
fi

apt install sudo git
adduser web
gpasswd -a web sudo
gpasswd -a web crontab
gpasswd -a web web
gpasswd -a web www-data

git clone https://gitlab.com/fryntiz/debian-developer-conf.git /home/web/
cd /home/web/debian-developer-conf
su web
./main.sh

exit 0
