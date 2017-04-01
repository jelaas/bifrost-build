#!/bin/bash

SRC=groff-1.21.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8b8cd29385b97616a0f0d96d0951c5bf

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ustc.edu.cn/gnu/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.distributed.net/pub/gnu/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.iweb.com/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.thecodefactory.org/gnu//groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yandex.ru/mirrors/gnu/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fallingrocks.ocf.berkeley.edu/gnu/groff/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.cypherpunks.ru/groff/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
