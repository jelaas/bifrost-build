#!/bin/bash

SRC=libid3tag-0.15.1b.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e5808ad997ba32c498803822078748c3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.mars.org/pub/mpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libid3tag/libid3tag-0.15.1b/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.videolan.org/pub/videolan/vlc/0.8.4/contribs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/libid3tag/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://softlibre.unizar.es/videolan/vlc/0.8.4/contrib/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
