#!/bin/bash

SRC=openssl-0.9.8y.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=47c7fb37f78c970f1d30aa2f9e9e26d8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-0.9.8y/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware-current/source/n/openssl/openssl0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware-12.2/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.mirror.ac.za/slackware-14.1/source/n/openssl/openssl0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing-it.nl/mirror/slackware-12.2/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linuxsociety.org/pub/slack-stuff/openssl-1.0.1f/openssl0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
