#!/bin/bash

SRC=mpfr-2.4.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=89e59fe665e2b3ad44a6789f40b059a0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mpfr.org/mpfr-2.4.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/mpfr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/infrastructure/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/mpfr/mpfr-2.4.2.tar.bz2/89e59fe665e2b3ad44a6789f40b059a0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
