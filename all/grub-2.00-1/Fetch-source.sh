#!/bin/bash

SRC=grub-2.00.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e927540b6eda8b024fb0391eeaa4091c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wayne.edu/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.thecodefactory.org/gnu/grub/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
