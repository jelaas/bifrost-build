#!/bin/bash

SRC=rsync-3.0.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0ee8346ce16bdfe4c88a236e94c752b4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://rsync.samba.org/ftp/rsync/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/samba/pub/rsync/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.as24220.net/pub/rsync/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxbase.org/pub/lsb/app-battery/packages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/netsoftware/rsync/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hummypkg.org.uk/hdrfoxt2/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.nix.org.ua/linux/slackware-misc/people/alphageek/slackware-13.0/source/rsync/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nara.wide.ad.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
