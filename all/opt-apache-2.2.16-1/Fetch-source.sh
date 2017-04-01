#!/bin/bash

SRC=httpd-2.2.16.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=c8ff2a07c884300bc7766a2e7f662d33

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/apache22/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
