#!/bin/bash

SRC=libvorbis-1.3.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6b1a36f0d72332fae5130688e65efe1f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.xiph.org/releases/vorbis/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.csclub.uwaterloo.ca/xiph/releases/vorbis/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/xiph/vorbis/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bin.moo0.com/software/ffmpeg/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.virt2real.ru/packages/buildroot/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
