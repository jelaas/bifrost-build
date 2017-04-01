#!/bin/bash

SRC=ffmpeg-2.7.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5a16425b0bde1b952f58cff71b569a45

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ffmpeg.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/ffmpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/ffmpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.ustc.edu.cn/macports/distfiles/ffmpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/ffmpeg/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
