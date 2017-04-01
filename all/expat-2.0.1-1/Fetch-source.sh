#!/bin/bash

SRC=expat-2.0.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ee8b492592568805593f81f8cdf2a04c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://heanet.dl.sourceforge.net/project/expat/expat/2.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/expat/expat-2.0.1.tar.gz/ee8b492592568805593f81f8cdf2a04c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/e/expat/expat-2.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sourceforge.mirrorservice.org/e/ex/expat/expat/2.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/6.3/e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.urc.ac.ru/pub/OS/FreeBSD/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ccp4.ac.uk/coot/extras/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://server1.xrdp.org/xrdp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdata.psru.ac.th/~pisut/distfiles_80/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/4.x/x86/scm/src/ffmpeg-static/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
