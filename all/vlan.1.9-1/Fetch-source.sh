#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.candelatech.com/~greear/vlan/$SRC
