#!/bin/bash

SRC=nftables-0.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=244e449ee80bbbf2b2908d861b074c7f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.netfilter.org/pub/nftables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/nftables/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/nftables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.v40.net/sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
