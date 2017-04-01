#!/bin/bash

SRC=curl-7.20.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=244b16b2a38c70e47130c8494b7371b9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.1/source/n/curl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
