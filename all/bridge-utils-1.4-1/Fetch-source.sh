#!/bin/bash

SRC=bridge-utils-1.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0182fcac3a2b307113bbec34e5f1c673

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-13.37/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://slackbuilds.org/mirror/slackware/slackware-14.1/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/pub/slackware/slackware-current/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-14.1/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.metrocast.net/slackware//slackware-13.37/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.slackware.com/pub/slackware/slackware-14.0/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware64-14.0/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-14.1/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.belnet.be/packages/slackware/slackware/source/n/bridge-utils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
