#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
DST=/var/spool/src/"${SRC}"
DSTB=/var/spool/src/"${SRCB}"
MD5=b9b2fdb957f50ada62d73f43ee75d044
MD5B=1b868962b658bd87e1563ecd56498ded

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cpan.org/src/5.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://photon.ring.gr.jp/archives/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.sohu.com/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.freenet.de/pub/ftp.cpan.org/pub/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hummypkg.org.uk/hdrfoxt2/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.1und1.de/software/cpan/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/cpan/authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/perl-XML-Parser/XML-Parser-2.36.tar.gz/1b868962b658bd87e1563ecd56498ded/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/p/perl-xml-parser/perl-xml-parser-2.36/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/os/linux/0linux/archives_sources/perl-xml-parser/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/amigolinux/distro/kiss-4.0/SOURCE/perl/perl-xml-parser/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp5.us.freebsd.org/modules/by-module/POE/MSERGEANT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/perl-ext/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns2.autopilotas.lt/slackware-13.1/source/d/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/Artistic/libxml-parser-perl-native/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/pub/pub/Unix/Languages/perl/CPAN/modules/by-module/AxKit/MSERGEANT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-12.1/source/d/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://opencocon.org/get/opencocon/underdamien-20081213/sources/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.virt2real.ru/packages/buildroot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/perl-modules/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages/X/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware64-13.1/patches/source/perl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
