#!/bin/bash

SRC=git-2.10.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=45e8b30a9e7c1b734128cc0fc6663619

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.kernel.org/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/kernel/software/scm/git/?C=M"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tux.rainside.sk/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
