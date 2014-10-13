#!/bin/bash

CURRENT_DIR=$(pwd)
cp conf_PIA21.ovpn.templ conf_PIA21.ovpn
sed -i "s#CURRENT_DIR#$CURRENT_DIR#g" conf_PIA21.ovpn 
