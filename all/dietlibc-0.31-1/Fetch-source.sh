#!/bin/bash

SRC=dietlibc-0.31.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=acb98d469ee932d902fdf6de07802b7c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/libs/dietlibc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://korg.cs.utah.edu/pub/linux/libs/dietlibc/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dietlibc/dietlibc-0.31.tar.bz2/acb98d469ee932d902fdf6de07802b7c/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
