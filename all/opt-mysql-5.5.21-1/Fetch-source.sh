#!/bin/bash

SRC=mysql-5.5.21.tar.gz
DST=/var/spool/src/$SRC
MD5=86d6bd335054a0aed1756ed60574c16d

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/$SRC \
              || wget -O $DST http://downloads.mysql.com/archives/mysql-5.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
