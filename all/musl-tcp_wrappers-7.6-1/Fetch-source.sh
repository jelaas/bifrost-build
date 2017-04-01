#!/bin/bash

SRC=tcp_wrappers_7.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e6fa25f71226d090f34de3f6b122fb5a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.porcupine.org/pub/security/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdiis.unizar.es/pub/unix/security/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tcp_wrappers/tcp_wrappers_7.6.tar.gz/e6fa25f71226d090f34de3f6b122fb5a/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/6.3/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/ftp.slackware.com/pub/slackware/slackware-8.1/patches/source/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-7.1/zipspeak/source/tcpip1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.wiretapped.net/pub/security/network-monitoring/tcp_wrappers/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
