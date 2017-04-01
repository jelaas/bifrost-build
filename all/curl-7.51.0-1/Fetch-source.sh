#!/bin/bash

SRC=curl-7.51.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=09a7c5769a7eae676d5e2c86d51f167e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware-current/source/n/curl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
