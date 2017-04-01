#!/bin/bash

SRC=wget-1.15.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=506df41295afc6486662cc47470b4618

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www-uxsup.csx.cam.ac.uk/pub/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://pup-src.pedigree-project.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
