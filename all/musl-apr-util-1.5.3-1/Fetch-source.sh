#!/bin/bash

SRC=apr-util-1.5.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=6f3417691c7a27090f36e7cf4d94b36e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://archive.apache.org/dist/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/apr-util/apr-util-1.5.3.tar.bz2/6f3417691c7a27090f36e7cf4d94b36e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.macports.org/apr-util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/apr-util/apr-util-1.5.3.tar.bz2/md5/6f3417691c7a27090f36e7cf4d94b36e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://app.nidc.kr/linux/lib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.vbi.vt.edu/mirrors/linux/slackware/slackware64-14.1/patches/source/apr-util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/distfiles.macports.org/apr-util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-14.1/patches/source/apr-util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://reflect.cs.princeton.edu/pub/mirrors/slackware/slackware-14.1/patches/source/apr-util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
