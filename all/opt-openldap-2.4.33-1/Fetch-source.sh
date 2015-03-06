#!/bin/bash

SRC=openldap-2.4.33.tgz
DST=/var/spool/src/$SRC
MD5=5adae44897647c15ce5abbff313bc85a

[ -s "$DST" ] || wget -O $DST ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
