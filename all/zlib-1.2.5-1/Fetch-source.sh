#!/bin/bash

SRC=zlib-1.2.5.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=be1e89810e66150f5b0327984d8625a0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.zlib.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/os/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/zlib/zlib-1.2.5.tar.bz2/be1e89810e66150f5b0327984d8625a0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/l/li/libpng/zlib/1.2.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnome.org/mirror/imagemagick.org/ftp/delegates/ffmpeg/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
