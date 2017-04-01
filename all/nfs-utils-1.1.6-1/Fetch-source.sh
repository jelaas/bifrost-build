#!/bin/bash

SRC=nfs-utils-1.1.6.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=b0d1b8ec5c8c081a340cfc77bb8670cd

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freefr.dl.sourceforge.net/project/nfs/nfs-utils/1.1.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://korg.cs.utah.edu/pub/linux/utils/nfs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/kernel.org/linux/utils/nfs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.dotsrc.org/mirrors/linux/utils/nfs/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
