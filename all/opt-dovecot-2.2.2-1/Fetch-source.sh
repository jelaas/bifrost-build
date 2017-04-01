#!/bin/bash

SRC=dovecot-2.2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e6c011b4bbddf19e79205d012723449a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/dovecot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/custombuild/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
