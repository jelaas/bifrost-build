#!/bin/bash

SRC=libmnl-1.0.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=7d95fc3bea3365bc03c48e484224f65f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.netfilter.org/pub/libmnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libmnl/libmnl-1.0.3.tar.bz2/7d95fc3bea3365bc03c48e484224f65f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/linux-netfilter/libmnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.zut.edu.pl/pub/linux/netfilter/libmnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bindist.wlan-si.net/mirror/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
