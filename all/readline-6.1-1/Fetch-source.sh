#!/bin/bash

SRC=readline-6.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fc2f7e714fe792db1ce6ddc4c9fb4ef3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/readline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/readline/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
