#!/bin/bash

SRC=lsof_4.84.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6dae655988c810a7042c06a4e2fa3c5f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.fu-berlin.de/pub/unix/tools/lsof/OLD/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp-curri.u-strasbg.fr/securite/lsof/OLD/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/lsof.itap.purdue.edu/pub/tools/unix/lsof/OLD/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
