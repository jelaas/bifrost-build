#!/bin/bash

SRC=memtest86+-4.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=2144f21d4489a04149b1891b8d97e8fc

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.memtest.org/download/4.10/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/memtest86+/memtest86+-4.10.tar.gz/2144f21d4489a04149b1891b8d97e8fc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.nix.org.ua/linux/slackware-misc/people/alphageek/slackware-13.1/source/memtest86%2B/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
