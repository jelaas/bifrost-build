#!/bin/bash

SRC=net-snmp-5.7.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/$SRC
