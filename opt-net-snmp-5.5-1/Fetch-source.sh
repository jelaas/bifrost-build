#!/bin/bash

SRC=net-snmp-5.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://garr.dl.sourceforge.net/project/net-snmp/net-snmp/5.5/$SRC
