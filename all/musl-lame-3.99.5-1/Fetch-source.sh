#!/bin/bash

SRC=lame-3.99.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=84835b313d4a8b68f5349816d33e07ce

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/lame/lame/3.99/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/lame/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/l/la/lame/lame/3.99/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/6.x/x86_64/tcz/src/lame/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/lame/lame-3.99.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/7.9/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/slackware/people/alien/restricted_slackbuilds/lame/build/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bin.moo0.com/software/ffmpeg/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
