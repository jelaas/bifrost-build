#!/bin/bash

SRC=openldap-2.4.33.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/$SRC
