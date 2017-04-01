#!/bin/bash

SRC=dovecot-2.2.19.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=95591b6556413edc2f0b160fb469d04c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/dovecot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files10.directadmin.com/services/customapache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/custombuild/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
