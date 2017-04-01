#!/bin/bash

SRC=shadow-4.1.4.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=d593a9cab93c48ee0a6ba056db8c1997

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/shadow/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/shadow/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://packages.vo2labs.org/sources-4.99/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/shadow/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hlsys.org/pub/blfs/conglomeration/shadow/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.yoctoproject.org/releases/yocto/yocto-0.9/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
