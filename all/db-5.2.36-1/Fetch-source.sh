#!/bin/bash

SRC=db-5.2.36.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=88466dd6c13d5d8cddb406be8a1d4d92

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.oracle.com/berkeley-db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libdb/db-5.2.36.tar.gz/88466dd6c13d5d8cddb406be8a1d4d92/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tiger2.net/distfiles/bdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/bdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/bdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/grimoire/database/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jaran.undip.ac.id/freebsd/distfiles/bdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/linux/lfs/LFS/conglomeration/db/V"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sunfreeware.cs.pu.edu.tw/BSD/FreeBSD/distfiles/bdb/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
