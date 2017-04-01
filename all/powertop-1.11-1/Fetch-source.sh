#!/bin/bash

SRC=powertop-1.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3498f5983c683c3a57dce7379a722082

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/slackware/pub/slackware/slackware-13.1/source/ap/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mucross.com/downloads/tonga-linux/sources/GPLv2/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-13.1/source/ap/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware64-13.1/source/ap/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/ftp/pub/linux/distributions/slackware/slackware64-13.1/source/ap/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware-13.1/source/ap/powertop/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/p/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-3.0/p/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
