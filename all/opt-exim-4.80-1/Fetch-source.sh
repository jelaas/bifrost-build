#!/bin/bash

SRC=exim-4.80.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=de93a242e9e148de28d67056e5c1b34f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.exim.org/pub/exim/exim4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cs.stanford.edu/pub/exim/exim/exim4/old/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/exim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://washitake.com/mail/exim/mirror/exim/exim4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/exim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/exim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wa.co.za/pub/exim/exim4/old/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
