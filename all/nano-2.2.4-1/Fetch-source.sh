#!/bin/bash

SRC=nano-2.2.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6304308afb1f7ef4a5e93eb99206632a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.nano-editor.org/dist/v2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/nano/nano-2.2.4.tar.gz/6304308afb1f7ef4a5e93eb99206632a/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/momonga/updates/6/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nara.wide.ad.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
