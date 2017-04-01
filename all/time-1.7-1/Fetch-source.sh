#!/bin/bash

SRC=time-1.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e38d2b8b34b1ca259cf7b053caac32b3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/time/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/time/time-1.7.tar.gz/e38d2b8b34b1ca259cf7b053caac32b3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/gnu/time/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.6/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware-4.0/source/a/bin/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ufs.ac.za/gnu/old-gnu/gnu-0.2/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
