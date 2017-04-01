#!/bin/bash

SRC=m4-1.4.14.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f0542d58f94c7d0ce0d01224e447be66

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www-uxsup.csx.cam.ac.uk/pub/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ibiblio.org/gnu/ftp/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dvlnx.com/software/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/packages/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xemacs.cdpa.nsysu.edu.tw/gnu/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.easyname.ch/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/m4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/m4/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
