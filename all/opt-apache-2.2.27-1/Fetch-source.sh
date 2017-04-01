#!/bin/bash

SRC=httpd-2.2.27.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=8faef0decf3fa7e69b2568eb2105a3d8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.issp.co.th/apache/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freebsd.csie.nctu.edu.tw/pub/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/pub/FreeBSD/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/distfiles.macports.org/apache2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware64-13.1/patches/source/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware-13.1/patches/source/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
