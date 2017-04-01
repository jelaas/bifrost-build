#!/bin/bash

SRC=mailutils-2.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=834d2f616b922856127ecfe6c2de7d1a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nephtys.lip6.fr/pub/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.keystealth.org/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.parentinginformed.com/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://debian.mcc.ac.uk/.f/pub/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ocw.nust.na/ftp.gnu.org/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.nbtelecom.com.br/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/gnu/mailutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/mailutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
