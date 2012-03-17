#!/bin/bash

SRC=mysql-5.5.16.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/$SRC || wget -O $DST http://downloads.mysql.com/archives/mysql-5.5/$SRC
