#!/bin/bash

SRC=re-alpine-2.02.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5e75826b15f05674856be8618bdefdfb

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://osdn.dl.sourceforge.net/sourceforge/re-alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/5e75826b15f05674856be8618bdefdfb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/re-alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/re-alpine/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
