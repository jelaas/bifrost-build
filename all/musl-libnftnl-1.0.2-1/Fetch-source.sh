#!/bin/bash

SRC=libnftnl-1.0.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=1d3ee76b976c4a0ca233d5d5734f2728

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.netfilter.org/pub/libnftnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.zut.edu.pl/pub/linux/netfilter/libnftnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/libnftnl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
