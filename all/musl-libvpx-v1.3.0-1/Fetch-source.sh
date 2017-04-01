#!/bin/bash

SRC=libvpx-v1.3.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=14783a148872f2d08629ff7c694eb31f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webm.googlecode.com/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libvpx/libvpx-v1.3.0.tar.bz2/14783a148872f2d08629ff7c694eb31f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cjj.kr.distfiles.macports.org/libvpx/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/handbrake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jor1k.com/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/HandBrake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-name/multimedia/HandBrake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/pub/FreeBSD/distfiles/handbrake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
