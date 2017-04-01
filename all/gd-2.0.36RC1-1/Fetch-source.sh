#!/bin/bash

SRC=gd-2.0.36RC1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=e876979ca3130623a4e7866d9579171a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ring.u-toyama.ac.jp/archives/graphics/gd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ring.ix.oita-u.ac.jp/archives/graphics/gd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://distro.ibiblio.org/tinycorelinux/2.x/tce/src/libgd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libgd/libgd-2.0.36RC1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-10183/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fallingrocks.ocf.berkeley.edu/archlinux/other/gd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
