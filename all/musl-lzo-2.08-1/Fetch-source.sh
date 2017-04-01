#!/bin/bash

SRC=lzo-2.08.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fcec64c26a0f4f4901468f360029678f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.oberhumer.com/opensource/lzo/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gadow.freifunk.net:8004/srv2/libremesh/lime/lime-build/dl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.csclub.uwaterloo.ca/MacPorts/mpdistfiles/lzo2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/lzo/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.6/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.jaleco.com/lfs/pub/blfs/7.6/l/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
