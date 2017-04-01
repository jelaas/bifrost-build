#!/bin/bash

SRC=fuse-2.9.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=894ee11674f89a915ae87524aed55bc4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ignum2.dl.sourceforge.net/project/fuse/fuse-2.X/2.9.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/fuse/fuse-2.X/2.9.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/f/fuse/fuse-2.9.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://librecmc.org/librecmc/downloads/sources/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
