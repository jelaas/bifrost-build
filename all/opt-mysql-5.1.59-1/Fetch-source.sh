#!/bin/bash

SRC=mysql-5.1.59.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1e89816164692f44f768024db4bc05f6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.mariadb.com/archives/mysql-5.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
