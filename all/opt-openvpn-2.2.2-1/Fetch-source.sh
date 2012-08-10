#!/bin/bash

SRC=openvpn-2.2.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://swupdate.openvpn.org/community/releases/$SRC
