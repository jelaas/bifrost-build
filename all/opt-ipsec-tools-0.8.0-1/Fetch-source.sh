#!/bin/bash

SRC=ipsec-tools-0.8.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=b79aae3055a51f8de5c0f1b8ca6cf619

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sunet.dl.sourceforge.net/project/ipsec-tools/ipsec-tools/0.8.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tku.edu.tw/NetBSD/misc/ipsec-tools/0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/NetBSD/misc/ipsec-tools/0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-erlangen.de/netbsd/misc/ipsec-tools/0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.neti.ee/pub/NetBSD/misc/ipsec-tools/0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.alpinelinux.org/archive/acf-ipsec-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.linuxgrill.com/anonymous/ipsec-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
