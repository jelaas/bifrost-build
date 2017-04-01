#!/bin/bash

SRC=autoconf-2.65.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=46cfb40e0babf4c64f8325f03da81c9b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/autoconf/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cdimage.debian.org/mirror/gnu.org/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fireball-public.phys.wvu.edu/mirror/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.symnds.com/software/GNU/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.swin.edu.au/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dvlnx.com/software/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.reismil.ch/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uasw.edu/pub/gnu/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www-ftp.lip6.fr/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.uberglobalmirror.com/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.funet.fi/pub/linux/mirrors/ftp.gnu.org/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.download-by.net/gnu/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.download-by.net/gnu/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lstn.net/kodi/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
