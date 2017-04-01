#!/bin/bash

SRC=curl-7.49.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=6bb1f7af5b58b30e4e6414b8c1abccab

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware-current/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware64-14.2/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/8.x/armv7/tcz/src/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.amlogic.com:8000/download/GPL_code_release/ThirdParty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/curl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
