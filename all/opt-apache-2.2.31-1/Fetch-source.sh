#!/bin/bash

SRC=httpd-2.2.31.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=6c10e15835ab214464228a9beb7afba8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.23media.de/apache/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.bjtu.edu.cn/apache/httpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
