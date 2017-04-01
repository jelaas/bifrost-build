#!/bin/bash

SRC=pcre-8.37.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=ed91be292cb01d21bc7e526816c26981

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.is.co.za/mirror/ftp.exim.org/ftp/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.exim.org/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hummypkg.org.uk/hdrfoxt2/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/exim/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
