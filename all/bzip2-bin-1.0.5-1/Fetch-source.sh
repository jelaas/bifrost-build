#!/bin/bash

SRC=bzip2-1.0.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3c15a0c8d1d3ee1c46a1634d00617b1a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.bzip.org/1.0.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/bzip2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.suse.com/pub/people/sbrabec/bzip2/tarballs/source/1.0.5/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
