#!/bin/bash

SRC=openldap-2.4.26.tgz
DST=/var/spool/src/openldap-2.4.26.tar.gz
MD5=f36f3086031dd56ae94f722ffae8df5e

[ -s "$DST" ] || wget -O $DST ftp://sunsite.cnlab-switch.ch/mirror/OpenLDAP/openldap-release/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
