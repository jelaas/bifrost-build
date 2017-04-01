#!/bin/bash

SRC=musl-1.1.14.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d529ce4a2f7f79d8c3fd4b8329417b57

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
