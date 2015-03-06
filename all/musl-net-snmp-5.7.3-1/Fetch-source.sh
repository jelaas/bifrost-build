#!/bin/bash

SRC=net-snmp-5.7.3.tar.gz
DST=/var/spool/src/$SRC
MD5=d4a3459e1577d0efa8d96ca70a885e53

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
