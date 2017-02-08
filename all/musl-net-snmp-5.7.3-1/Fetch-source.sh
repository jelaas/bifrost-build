#!/bin/bash

SRC=net-snmp-5.7.3.tar.gz
DST=/var/spool/src/$SRC

pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || curl -L -k -o $DST http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/$SRC
