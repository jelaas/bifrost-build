#!/bin/bash

SRC=openldap-2.4.44.tgz
DST=/var/spool/src/openldap-2.4.44.tar.gz
MD5=693ac26de86231f8dcae2b4e9d768e51

[ -s "$DST" ] || wget -O $DST http://www.openldap.org/software/download/OpenLDAP/openldap-release/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/lookaside/extras/openldap/openldap-2.4.44.tgz/693ac26de86231f8dcae2b4e9d768e51/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
