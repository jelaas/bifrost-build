#!/bin/bash

SRC=l2tpns-2.1.21.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=385c58055723ebc6c38062acd2db9c2c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/l2tpns/l2tpns/2.1.21/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ipkg.nslu2-linux.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dl.openwrtdl.com/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
