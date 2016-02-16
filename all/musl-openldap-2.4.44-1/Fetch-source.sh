#!/bin/bash

SRC=openldap-2.4.44.tgz
DST=/var/spool/src/openldap-2.4.44.tar.gz

[ -s "$DST" ] || wget -O $DST http://www.openldap.org/software/download/OpenLDAP/openldap-release/$SRC
