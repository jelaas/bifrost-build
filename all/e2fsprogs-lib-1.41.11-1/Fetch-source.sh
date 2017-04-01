#!/bin/bash

SRC=e2fsprogs-1.41.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fb507a40c2706bc38306f150d069e345

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://surfnet.dl.sourceforge.net/project/e2fsprogs/e2fsprogs/1.41.11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/kernel/people/tytso/e2fsprogs/older_releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/e/e2/e2fsprogs/e2fsprogs/1.41.11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/e/e2fsprogs/e2fsprogs-1.41.11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.sigrand.ru/dl/misc/midge-depot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/4.x/x86_64/src/3.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
