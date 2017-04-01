#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cce05daf61a64501ef6cd8da1f727ec6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/ncurses/ncurses-5.7.tar.gz/cce05daf61a64501ef6cd8da1f727ec6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lyx.org/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://invisible-mirror.net/archives/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-13.0/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.clarkson.edu/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.oasis.onnetcorp.com/FreeBSD/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.b-tronic.net/source/src/MIT/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13684/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware64-13.0/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/MIT/ncurses-native/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.voipac.com/downloads/imx/25/src/fs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kanebebe.dip.jp/download/ARM9-2440-DVD/Linux/apache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware64-13.1/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.easyname.ch/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.download-by.net/gnu/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://spinellicreations.com/download/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xemacs.cdpa.nsysu.edu.tw/gnu/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.airnet.ne.jp/archives/GNU/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/ftp/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.math.princeton.edu/pub/slackware/slackware64-13.0/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.debian.mcc.ac.uk/.f/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
