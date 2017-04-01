#!/bin/bash

SRC=libogg-1.3.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0a7eb40b86ac050db3a789ab65fe21c2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.xiph.org/releases/ogg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libogg/libogg-1.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/handbrake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ljudmila.org/~jaromil/mirror/zshaolin/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/mingw-libogg/libogg-1.3.0.tar.gz/0a7eb40b86ac050db3a789ab65fe21c2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
