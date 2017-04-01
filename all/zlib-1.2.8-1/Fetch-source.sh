#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=44d667c142d7cda120332623eab69f40

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://zlib.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://78.108.103.11/MIRROR/ftp/GraphicsMagick/3rdparty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dcpomatic.com/build/windows/windows/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bin.moo0.com/software/ffmpeg/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jor1k.com/downloads/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
