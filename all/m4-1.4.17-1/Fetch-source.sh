#!/bin/bash

SRC=m4-1.4.17.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a5e9954b1dae036762f7b13673a2cf76

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdiis.unizar.es/pub/unix/prog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cdimage.debian.org/mirror/xbmc.org/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/multimedia/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://grey.colorado.edu/emergent_ftp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
