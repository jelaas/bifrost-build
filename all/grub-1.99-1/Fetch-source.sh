#!/bin/bash

SRC=grub-1.99.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ca9f2a2d571b57fc5c53212d1d22e2b5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yzu.edu.tw/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ibiblio.org/gnu/ftp/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wayne.edu/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/gnu/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.thecodefactory.org/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ussg.iu.edu/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.otenet.gr/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org.ua/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xemacs.cdpa.nsysu.edu.tw/gnu/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/7.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.kitepilot.com/LFS/7.1/x86_64/pkgs/grub-1.99/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.reismil.ch/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.download-by.net/gnu/gnu/grub/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
