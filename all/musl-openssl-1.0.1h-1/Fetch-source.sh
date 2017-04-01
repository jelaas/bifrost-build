#!/bin/bash

SRC=openssl-1.0.1h.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8d6d684a9430d5cc98a62a5d8fbda8cf

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.macports.org/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1h/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/security/OpenSSL/old/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dcpomatic.com/build/windows/windows/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/6.x/armv6/tcz/src/openssl-1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linuxsociety.org/pub/slack-stuff/openssl-1.0.1h-wrong/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jor1k.com/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.osuosl.org/pub/blfs/conglomeration/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/linux/lfs/LFS/conglomeration/openssl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
