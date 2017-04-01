#!/bin/bash

SRC=libdnet-1.12.tgz
DST=/var/spool/src/"${SRC}"
MD5=9253ef6de1b5e28e9c9a62b882e44cc9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://libdnet.googlecode.com/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.psu.ac.th/pub/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/libdnet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://val.bmstu.ru/unix/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portal.nersc.gov/project/dtec/tarballs/dependencies/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mail-tp.fareoffice.com/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.garbled.net/packages/netbsd/4.0_BETA2/arm/net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
