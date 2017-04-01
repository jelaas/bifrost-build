#!/bin/bash

SRC=curl-7.51.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=09a7c5769a7eae676d5e2c86d51f167e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware-current/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware64-13.37/patches/source/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/8.x/armv7/tcz/src/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://centos.mirrors.ovh.net/ftp.slackware.com/slackware64-14.1/patches/source/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.metrocast.net/slackware/slackware64-13.37/patches/source/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-13.37/patches/source/curl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
