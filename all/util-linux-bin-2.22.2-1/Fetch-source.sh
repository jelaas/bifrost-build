#!/bin/bash

SRC=util-linux-2.22.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=3e379b4d8b9693948d751c154614c73e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/kernel/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.nus.edu.sg/pub/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.amlogic.com:8000/download/GPL_code_release/ThirdParty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kernel.securehost.com/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yandex.ru/pub/linux/utils/util-linux/v2.22/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
