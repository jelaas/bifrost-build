#!/bin/bash

SRC=lzo-2.03.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0c3d078c2e8ea5a88971089a2f02a726

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.oberhumer.com/opensource/lzo/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.voipac.com/downloads/imx/25/src/fs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stratus.com/vos/posix/ga/v-series-customer/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/lzo/lzo-2.03/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/xbmc.org/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-3020/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tokyocabinet.sourceforge.net/misc/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
