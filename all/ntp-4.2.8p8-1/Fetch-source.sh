#!/bin/bash

SRC=ntp-4.2.8p8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=4a8636260435b230636f053ffd070e34

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.leg.uct.ac.za/pub/packages/macports/distfiles/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dvlnx.com/docs/lfs/blfs/conglomeration/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/ntp/ntp4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
