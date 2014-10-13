#!/bin/bash

#openvpn
OPENVPN_DIR=$(dirname $(pwd))/openvpn-config
mkdir $OPENVPN_DIR/log
sudo cp ./openvpn.conf.templ /etc/supervisor/conf.d/openvpn.conf
sudo sed -i "s#OPENVPN_DIR#$OPENVPN_DIR#g" /etc/supervisor/conf.d/openvpn.conf 

#virtuoso
sudo cp ./virtuoso.conf /etc/supervisor/conf.d/virtuoso.conf
