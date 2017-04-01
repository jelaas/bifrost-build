#!/bin/bash

SRC=libssh2-1.3.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6425331899ccf1015f1ed79448cb4709

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.libssh2.org/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nara.wide.ad.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/local-distfiles/sbz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdata.psru.ac.th/~pisut/Backup_takpao/distfiles90/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
