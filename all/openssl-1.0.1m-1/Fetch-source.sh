#!/bin/bash

SRC=openssl-1.0.1m.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d143d1555d842a069cb7cc34ba745a06

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1m/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/security/OpenSSL/old/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bsdserwis.com/pub/FreeBSD/ports/distfiles/openssl-1.0.1m/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://roadster.agcl.us/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.pccc.com/downloads/apache/current/?C=N;O=D"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
