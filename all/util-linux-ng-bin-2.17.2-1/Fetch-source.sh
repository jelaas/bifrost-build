#!/bin/bash

SRC=util-linux-ng-2.17.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=4635725a3eef1c57090bac8ea5e082e6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/kernel/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/utils/util-linux-ng/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/util-linux-ng/util-linux-ng-2.17.2.tar.bz2/4635725a3eef1c57090bac8ea5e082e6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackintosh.workaround.ch/pub/slackintosh/current/source/a/util-linux-ng/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kernel.securehost.com/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sjtu.edu.cn/sites/ftp.kernel.org/pub/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mi.rro.rs/kernel.org/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
