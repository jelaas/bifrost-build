#!/bin/bash

SRC=openssl-0.9.8zb.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=65c5f42734f8ecd58990b12a9afa6453

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/openssl/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.catn.com/pub//openssl/source/old/0.9.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware-current/source/n/openssl/openssl0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns1.casita.net/pub/skel/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
