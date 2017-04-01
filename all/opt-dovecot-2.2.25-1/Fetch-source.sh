#!/bin/bash

SRC=dovecot-2.2.25.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8f62ea76489c47c369cbbe0b19818448

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/7.10/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dvlnx.com/docs/lfs/blfs/7.10/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.thzhost.com/directadmin/services/customapache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/customapache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.10/d/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
