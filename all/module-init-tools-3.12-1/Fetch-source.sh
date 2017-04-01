#!/bin/bash

SRC=module-init-tools-3.12.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=8b2257ce9abef74c4a44d825d23140f3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.europeonline.com/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/kernel.org/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.nus.edu.sg/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
