#!/bin/bash

SRC=gawk-3.1.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=35937a0f83f0efe7a8c2dee635624784

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/gawk/gawk-3.1.8.tar.gz/35937a0f83f0efe7a8c2dee635624784/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ussg.iu.edu/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uasw.edu/pub/gnu/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ocw.nust.na/ftp.gnu.org/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.parentinginformed.com/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.gnu.org/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.uberglobalmirror.com/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.swin.edu.au/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.otenet.gr/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.spinellicreations.com/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xemacs.cdpa.nsysu.edu.tw/gnu/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yandex.ru/mirrors/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.team-cymru.org/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.internode.on.net/pub/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.squ.edu.om/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://debian.mcc.ac.uk/.f/pub/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://http.pl.scene.org/pub/gnu/gawk/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://roadster.agcl.us/downloads/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
