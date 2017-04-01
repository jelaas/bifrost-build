#!/bin/bash

SRC=console-data-1999.08.29.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b534787af0edaa73f608f518263f9334

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ibiblio.org/pub/Linux/system/keyboards/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.openwall.net/pub/Owl/pool/sources/console-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ibiblio.org/pub/linux/system/keyboards/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/openwall/Owl/pool/sources/console-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
