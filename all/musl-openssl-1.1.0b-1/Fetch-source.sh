#!/bin/bash

SRC=openssl-1.1.0b.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=77895d5d0fbccf3172ae5b9897a0dedc

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/security/OpenSSL/old/1.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openssl.skazkaforyou.com/source/old/1.1.0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
