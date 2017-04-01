#!/bin/bash

SRC=curl-7.37.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=95c627abcf6494f5abe55effe7cd6a57

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://netbsd.gw.com/pub/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fileplanet.com/lfs/pub/blfs/conglomeration/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.rtin.bz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/www/utilities/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.embeddedarm.com/ftp/mirror/yocto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jor1k.com/downloads/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
