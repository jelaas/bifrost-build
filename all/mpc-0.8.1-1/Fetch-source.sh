#!/bin/bash

SRC=mpc-0.8.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5b34aa804d514cc295414a963aedb6bf

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://gcc.gnu.org/pub/gcc/infrastructure/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libmpc/mpc-0.8.1.tar.gz/5b34aa804d514cc295414a963aedb6bf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/infrastructure/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/m/mpc/mpc-0.8.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp8.de.freebsd.org/pub/mirror/sourceware.org/gcc/infrastructure/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.sigrand.ru/dl/misc/midge-depot/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
