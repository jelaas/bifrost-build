#!/bin/bash

SRC=openssh-6.1p1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3345cbf4efe90ffb06a78670ab2d05d5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.eu.openbsd.org/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/OpenSSH/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/security/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/openssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/security/tools/ssh/openssh/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/openssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-14.0/source/n/openssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.securehost.com/openssh/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.esc7.net/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.one.com/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.polytechnic.edu.na/pub/OpenBSD/OpenSSH/portable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
