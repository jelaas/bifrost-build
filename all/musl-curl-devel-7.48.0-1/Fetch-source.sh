#!/bin/bash

SRC=curl-7.48.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=d42e0fc34a5cace5739631cc040974fe

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://curl.haxx.se/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://curl.askapache.com/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/lookaside/extras/R/curl-7.48.0.tar.bz2/d42e0fc34a5cace5739631cc040974fe/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware-current/source/n/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/7.x/armv7/tcz/src/curl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
