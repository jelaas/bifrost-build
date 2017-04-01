#!/bin/bash

SRC=vim-7.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5b9510a17074e2b37d8bb38ae09edbf2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.vim.org/pub/vim/unix/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.bjtu.edu.cn/clfs/conglomeration/vim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/v/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/vim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.psu.ac.th/vim/unix/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/vim/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/packages/editors/vim/unix/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://vim.mirror.fr/unix/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
