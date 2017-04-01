#!/bin/bash

SRC=grub-1.98.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=c0bcf60e524739bb64e3a2d4e3732a59

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://alpha.gnu.org/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/lookaside/pkgs/grub2/grub-1.98.tar.gz/c0bcf60e524739bb64e3a2d4e3732a59/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/alpha.gnu.org/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/alpha/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/alpha.gnu.org/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.njtu.edu.cn/clfs/conglomeration/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://l4u-00.jinr.ru/LinuxArchive/Ftp/misc/sys/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.spinellicreations.com/alpha/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnualpha.uib.no/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/g/grub/grub-1.98/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/linux/lfs/BLFS/lfs-packages/6.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.c3sl.ufpr.br/alpha/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/gnu/alpha/gnu/grub/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
