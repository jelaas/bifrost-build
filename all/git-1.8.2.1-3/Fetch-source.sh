#!/bin/bash

SRC=git-1.8.2.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3f6ebca116c627490e4ee1f1324d5e65

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://git-core.googlecode.com/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mail.tisys.org/pub/blfs/conglomeration/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
