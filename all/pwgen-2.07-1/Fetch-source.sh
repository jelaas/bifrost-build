#!/bin/bash

SRC=pwgen-2.07.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=910b1008cdd86445e9e01305d21ee4c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/pwgen/pwgen/2.07/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/pwgen/pwgen-2.07.tar.gz/910b1008cdd86445e9e01305d21ee4c5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/pwgen/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-md5/9/1/910b1008cdd86445e9e01305d21ee4c5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/p/pw/pwgen/pwgen/2.07/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.leg.uct.ac.za/pub/packages/macports/distfiles/pwgen/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/OpenBSD/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/?C=N;O=D"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
