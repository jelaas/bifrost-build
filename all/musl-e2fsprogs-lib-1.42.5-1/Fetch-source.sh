#!/bin/bash

SRC=e2fsprogs-1.42.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=aca828bb4bcca20991a442deb950b670

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.42.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/e2fsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stust.edu.tw/pub/Linux/linux/kernel/people/tytso/e2fsprogs/v1.42.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nchc.org.tw/Unix/Kernel/linux/kernel/people/tytso/e2fsprogs/v1.42.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tcrc.edu.tw/Unix/Kernel/linux/kernel/people/tytso/e2fsprogs/v1.42.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hummypkg.org.uk/hdrfoxt2/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/7.2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
