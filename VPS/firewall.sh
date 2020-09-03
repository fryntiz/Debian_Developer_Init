#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

mainFirewall() {
    ## Comprobar que existe firewall-cmd

    sudo systemctl start firewalld

    ## Permito ssh
    sudo firewall-cmd --zone=public --add-port=22/tcp --permanent

    ## Permito http
    sudo firewall-cmd --zone=public --add-port=80/tcp --permanent

    ## Permito https
    sudo firewall-cmd --zone=public --add-port=443/tcp --permanent

    ## Permito PostgreSQL
    #sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent

    ## Permito ISPConfig
    #sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent

    ## Permito mumble
    #sudo firewall-cmd --zone=public --add-port=64738/tcp --permanent
    #sudo firewall-cmd --zone=public --add-port=64738/udp --permanent

    ## Permito VPN
    #sudo firewall-cmd --zone=public --add-port=1194/udp --permanent

    ## Recargo cortafuegos
    #sudo firewall-cmd --reload
}
