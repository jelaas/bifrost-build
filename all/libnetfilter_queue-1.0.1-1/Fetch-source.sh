#!/bin/bash

SRC=libnetfilter_queue-1.0.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=08b968cb2d36c24deb7f26a69f5d8602

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/libnetfilter_queue/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.netfilter.org/pub/libnetfilter_queue/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp2.de.freebsd.org/pub/linux/misc/netfilter/ftp/libnetfilter_queue/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://attic-distfiles.pld-linux.org/by-md5/0/8/08b968cb2d36c24deb7f26a69f5d8602/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
