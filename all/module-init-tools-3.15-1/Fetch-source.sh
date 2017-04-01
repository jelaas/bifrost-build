#!/bin/bash

SRC=module-init-tools-3.15.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=04f04e6f976f46c89523679c452a0324

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.europeonline.com/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.nus.edu.sg/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/m/module-init-tools/module-init-tools-3.15/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/linux/utils/kernel/module-init-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
