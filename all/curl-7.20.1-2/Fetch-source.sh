#!/bin/bash

SRC=curl-7.20.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=244b16b2a38c70e47130c8494b7371b9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware64-13.1/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.rtin.bz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/www/utilities/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing-it.nl/mirror/slackware64-13.1/patches/source/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp8.de.freebsd.org/pub/comp/Linux/slackware/slackware-13.1/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://web.mit.edu/jhawk/mnt/spo/git/tarballs/old/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
