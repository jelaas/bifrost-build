#!/bin/bash

SRC=gmp-4.3.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=dd60683d7057917e34630b4a787932e8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/gmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/gmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/gmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.opencompute.org/onie/crosstool-NG/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.parentingamerica.com/infrastructure/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/gmp/gmp-4.3.2.tar.bz2/dd60683d7057917e34630b4a787932e8/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
