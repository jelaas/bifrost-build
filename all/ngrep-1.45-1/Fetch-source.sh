#!/bin/bash

SRC=ngrep-1.45.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=bc8150331601f3b869549c94866b4f1c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/ngrep/ngrep/1.45/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/ngrep/ngrep-1.45.tar.bz2/bc8150331601f3b869549c94866b4f1c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dl.t2-project.org/mirror/8.0/n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.vicidial.com/required-apps/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.wiretapped.net/pub/security/packet-capture/ngrep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/n/ng/ngrep/ngrep/1.45/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/ngrep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/ngrep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/n/ng/ngrep/ngrep/1.45/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/slacky/slackware-12.0/network/net_tools/20070823/src/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cjj.kr.distfiles.macports.org/ngrep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freebsd.uct.ac.za/pub/packages/macports/distfiles/ngrep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.heanet.ie/mirrors/ftp.openbsd.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
