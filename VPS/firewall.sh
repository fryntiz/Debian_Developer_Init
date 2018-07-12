#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

mainFirewall() {
    ## Comprobar que existe firewall-cmd

    ## Permito ssh
    sudo firewall-cmd --zone=public --add-port=22/tcp --permanent

    ## Permito http
    sudo firewall-cmd --zone=public --add-port=80/tcp --permanent

    ## Permito https
    sudo firewall-cmd --zone=public --add-port=443/tcp --permanent

    ## Recargo cortafuegos
    sudo firewall-cmd --reload
}
