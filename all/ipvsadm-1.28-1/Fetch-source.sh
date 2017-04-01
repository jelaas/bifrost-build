#!/bin/bash

SRC=ipvsadm-1.28.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9b449f0b2cc1dc486c70a5911f8319e1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.kernel.org/pub/linux/utils/kernel/ipvsadm/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stust.edu.tw/pub/Linux/kernel/linux/utils/kernel/ipvsadm/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/linux/utils/kernel/ipvsadm/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
