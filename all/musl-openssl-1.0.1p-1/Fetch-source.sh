#!/bin/bash

SRC=openssl-1.0.1p.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7563e92327199e0067ccd0f79f436976

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.org.uk/slackware/slackware/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1p/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/openssl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
