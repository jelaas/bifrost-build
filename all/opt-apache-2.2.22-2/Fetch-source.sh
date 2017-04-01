#!/bin/bash

SRC=httpd-2.2.22.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=9fe3093194c8a57f085ff7c3fc43715f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/httpd/httpd-2.2.22.tar.bz2/9fe3093194c8a57f085ff7c3fc43715f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/a/apache-httpd/apache-httpd-2.2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freebsd.csie.nctu.edu.tw/pub/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/linux/slackware/slackware-current/source/n/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-12.0/patches/source/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.chariot.net.au/apache/httpd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
