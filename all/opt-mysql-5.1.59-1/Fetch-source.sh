#!/bin/bash

SRC=mysql-5.1.59.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sunsite.icm.edu.pl/pub/unix/databases/relational/mysql/Downloads/MySQL-5.1/$SRC
