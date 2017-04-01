#!/bin/bash

SRC=flex-2.5.35.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=10714e50cea54dc7a227e3eddcd44d57

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://switch.dl.sourceforge.net/project/flex/flex/flex-2.5.35/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/flex/flex-2.5.35.tar.bz2/10714e50cea54dc7a227e3eddcd44d57/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/f/flex/flex-2.5.35/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.embedian.com/oe-downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/flex/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/haiku/releases/r1alpha3/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/flex/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
