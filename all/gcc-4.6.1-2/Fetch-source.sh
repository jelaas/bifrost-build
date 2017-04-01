#!/bin/bash

SRC=gcc-core-4.6.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0c0e7e35d2215e19de9c97efba507553

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.parentingamerica.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.skazkaforyou.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/avr-gcc/gcc-core-4.6.1.tar.bz2/0c0e7e35d2215e19de9c97efba507553/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"

SRC=gcc-g++-4.6.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0d75ca7ca35b1e7f252223f9d23a6ad1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.vexxhost.com/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.parentingamerica.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.skazkaforyou.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.skazkaforyou.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
