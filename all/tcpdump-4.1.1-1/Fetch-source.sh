#!/bin/bash

SRC=tcpdump-4.1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d0dd58bbd6cd36795e05c6f1f74420b0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tcpdump.org/release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tcpdump/tcpdump-4.1.1.tar.gz/d0dd58bbd6cd36795e05c6f1f74420b0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware-current/source/n/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-13.37/source/n/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.metrocast.net/slackware//slackware-13.37/source/n/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware64-13.37/source/n/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://yandex-asia.archive.parrotsec.org/slackware/slackware64-13.37/source/n/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.voipac.com/downloads/imx/51/src/fs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nara.wide.ad.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
