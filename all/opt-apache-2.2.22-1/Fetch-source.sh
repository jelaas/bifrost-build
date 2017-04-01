#!/bin/bash

SRC=httpd-2.2.22.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=9fe3093194c8a57f085ff7c3fc43715f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/apache22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/a/apache-httpd/apache-httpd-2.2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware-current/source/n/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/apache22/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
