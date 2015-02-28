#!/bin/bash

SRC=mysql-5.1.59.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST https://downloads.mariadb.com/archives/mysql-5.1/$SRC \
              || wget -O $DST http://ftp.devil-linux.org/pub/devel/sources/1.4/$SRC \
              || wget -O $DST http://distfiles.macports.org/mysql5/$SRC
