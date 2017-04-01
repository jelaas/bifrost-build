#!/bin/bash

SRC=tcp_wrappers_7.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e6fa25f71226d090f34de3f6b122fb5a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.porcupine.org/pub/security/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tcp_wrappers/tcp_wrappers_7.6.tar.gz/e6fa25f71226d090f34de3f6b122fb5a/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/6.3/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cs.stanford.edu/pub/ssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-7.1/zipspeak/source/tcpip1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.vbi.vt.edu/mirrors/linux/slackware/slackware-8.1/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://reflect.cs.princeton.edu/pub/mirrors/slackware/slackware-8.1/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.metrocast.net/slackware/slackware-9.0/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/tcp_wrappers/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/slackware/slackware-8.1/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages-stable/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/tcpwrappers/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ic.ufmt.br/slackware/slackware-8.1/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mir0.gentoo-fr.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/t/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
