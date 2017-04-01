#!/bin/bash

SRC=httpd-2.2.17.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=16eadc59ea6b38af33874d300973202e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.localhost.net.ar/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/httpd/httpd-2.2.17.tar.bz2/16eadc59ea6b38af33874d300973202e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.crihan.fr/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/apache22/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
