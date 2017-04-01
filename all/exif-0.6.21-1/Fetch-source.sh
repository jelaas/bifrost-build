#!/bin/bash

SRC=exif-0.6.21.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9321c409a3e588d4a99d63063ef4bbb7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/libexif/exif/0.6.21/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://her.gr.distfiles.macports.org/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cjj.kr.distfiles.macports.org/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org//l/project/li/libexif/exif/0.6.21/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.pnl.gov/macports/distfiles/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.ustc.edu.cn/macports/distfiles/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/macports-distfiles/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/FreeBSD/ports/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirror.yandex.ru/macports/distfiles/exif/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
