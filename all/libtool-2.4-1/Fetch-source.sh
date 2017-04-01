#!/bin/bash

SRC=libtool-2.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b32b04148ecdd7344abc6fe8bd1bb021

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/libtool/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/libtool/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/libtool/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/libtool/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/libtool/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/haiku/releases/r1alpha3/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.directadmin.com/services/custombuild/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
