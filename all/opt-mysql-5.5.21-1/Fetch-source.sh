#!/bin/bash

SRC=mysql-5.5.21.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sunsite.icm.edu.pl/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/$SRC || wget -O $DST http://downloads.mysql.com/archives/mysql-5.5/$SRC
