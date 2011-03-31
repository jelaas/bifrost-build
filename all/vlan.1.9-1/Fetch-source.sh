#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST --no-check-certificate  https://laas.mine.nu/srcrepo/$SRC || wget -O $DST http://www.candelatech.com/~greear/vlan/$SRC
