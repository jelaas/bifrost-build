#!/bin/bash

SRC=console-tools-0.2.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=983d4586a791b3fdfa0fbeff76aadf43

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ibiblio.org/pub/Linux/system/keyboards/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ibiblio.org/pub/linux/system/keyboards/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.lunar-linux.org/lunar/cache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
