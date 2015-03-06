#!/bin/bash

SRC=mysql-5.5.16.tar.gz
DST=/var/spool/src/$SRC
MD5=462ab3752dd666ec06ca32f92673b59e

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/$SRC \
              || wget -O $DST http://downloads.mysql.com/archives/mysql-5.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
