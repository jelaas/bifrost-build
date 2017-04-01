#!/bin/bash

SRC=gettext-0.18.1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3dd55b952826d2b32f51308f2f91aa89

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/gettext/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/gettext/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/g/gettext/gettext-0.18.1.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.vips.ecs.soton.ac.uk/supported/7.42/win32/dependencies/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.raffsoftware.com/gettext/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dcpomatic.com/build/windows/windows/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/7.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/gettext/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
