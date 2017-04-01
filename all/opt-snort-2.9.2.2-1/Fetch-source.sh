#!/bin/bash

SRC=snort-2.9.2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=4254389550e3be31afebc70e64e6002f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/downloads.sourceforge.net/s/sn/snort.mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.psu.ac.th/pub/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://val.bmstu.ru/unix/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/ftp.kernel.org/pub/dist/devil-linux/devel/sources/1.6/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
