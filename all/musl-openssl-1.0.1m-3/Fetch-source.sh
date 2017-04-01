#!/bin/bash

SRC=openssl-1.0.1m.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d143d1555d842a069cb7cc34ba745a06

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackmirror.cbpf.br/pub/slackware/slackware64-14.0/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.embeddedarm.com/ftp/mirror/yocto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://autobuilder.yoctoproject.org/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
