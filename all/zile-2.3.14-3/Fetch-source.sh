#!/bin/bash

SRC=zile-2.3.14.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=88322abbb8146f3c4e7bb31fa4d351c6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.ussg.iu.edu/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.raffsoftware.com/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.easyname.at/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.spinellicreations.com/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.parentinginformed.com/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.bjtu.edu.cn/gnu//zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.internode.on.net/pub/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.squ.edu.om/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.dotsrc.org/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.debian.mcc.ac.uk/.f/pub/gnu/zile/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://http.pl.scene.org/pub/gnu/zile/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
