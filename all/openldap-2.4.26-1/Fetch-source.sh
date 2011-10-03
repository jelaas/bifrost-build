#!/bin/bash

SRC=openldap-2.4.26.tgz
DST=/var/spool/src/openldap-2.4.26.tar.gz

[ -s "$DST" ] || wget -O $DST ftp://sunsite.cnlab-switch.ch/mirror/OpenLDAP/openldap-release/$SRC
