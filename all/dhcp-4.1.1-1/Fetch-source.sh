#!/bin/bash

SRC=dhcp-4.1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=38a74c89d8913b9b5f33737047623c18

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/isc/dhcp/dhcp-4.1-history/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dhcp/dhcp-4.1.1.tar.gz/38a74c89d8913b9b5f33737047623c18/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.fi.netbsd.org/pub/unix/tcpip/dhcp/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
