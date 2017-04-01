#!/bin/bash

SRC=logrotate-3.7.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=266c48560ba588649f815a0c59edb488

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ibiblio.download.sourcemage.org/pub/linux/distributions/sourcemage/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
