#!/bin/bash

SRC=dhcp-4.1-ESV-R2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=70ff4cc73b9110f65218858fa7ae4f6f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/network/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware-13.1/patches/source/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.fi.netbsd.org/pub/unix/tcpip/dhcp/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
