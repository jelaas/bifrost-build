#!/bin/bash

SRC=parted-3.1.tar.xz
DST=/var/spool/src/"${SRC}"
MD5=5d89d64d94bcfefa9ce8f59f4b81bdcb

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.systemimager.org/stable/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.ussg.iu.edu/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.5/p/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.opencompute.org/onie/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linuxsociety.org/pub/slack-stuff/parted-3.1-slackpack/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux4u.jinr.ru/pub/misc/jobc/batch/SARA/sali/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ufs.ac.za/gnu/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.reismil.ch/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ocw.nust.na/ftp.gnu.org/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.uberglobalmirror.com/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/parted/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://clfs.org/files/packages/2.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/gnu/parted/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
