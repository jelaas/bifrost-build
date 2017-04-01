#!/bin/bash

SRC=gnupg-1.4.10.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=dcf7ed712997888d616e029637bfc303

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnupg.org/gcrypt/gnupg/$SRC \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gd.tuwien.ac.at/pub/gnupg/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnome.org/mirror/archive/ftp.sunet.se/pub/security/gnupg/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://core.ring.gr.jp/pub/net/gnupg/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nchu.edu.tw/Unix/Security/GnuPG/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxbase.org/pub/lsb/app-battery/packages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.1/source/n/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/pub/slackware/slackware-current/source/n/gnupg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/amigolinux/distro/kiss-4.0/SOURCE/net/gnupg/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
