#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
SRCC=IO-Socket-SSL-1.84.tar.gz
SRCD=Net-SSLeay-1.36.tar.gz
DST=/var/spool/src/"${SRC}"
DSTB=/var/spool/src/"${SRCB}"
DSTC=/var/spool/src/"${SRCC}"
DSTD=/var/spool/src/"${SRCD}"
MD5=b9b2fdb957f50ada62d73f43ee75d044
MD5B=1b868962b658bd87e1563ecd56498ded
MD5C=3878d8c84c1e8a611f4d0d9b3574ce35
MD5D=54061638720dd6a325395331c77f21d8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cpan.org/src/5.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://photon.ring.gr.jp/archives/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.sohu.com/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://backpan.perl.org/authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.uwsg.iu.edu/perl/CPAN/modules/by-authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.up.pt/CPAN/authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/perl-XML-Parser/XML-Parser-2.36.tar.gz/1b868962b658bd87e1563ecd56498ded/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/p/perl-xml-parser/perl-xml-parser-2.36/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/amigolinux/distro/kiss-4.0/SOURCE/perl/perl-xml-parser/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/os/linux/0linux/archives_sources/perl-xml-parser/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/perl-ext/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp5.us.freebsd.org/modules/by-module/XML/MSERGEANT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/Artistic/libxml-parser-perl-native/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns2.autopilotas.lt/slackware-12.2/source/d/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-12.1/source/d/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/pub/pub/Unix/Languages/perl/CPAN/modules/by-module/AxKit/MSERGEANT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/pub/lang/CPAN/authors/id/M/MS/MSERGEANT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/perl-modules/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://opencocon.org/get/opencocon/underdamien-20081213/sources/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.virt2real.ru/packages/buildroot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/CPAN/modules/by-category/07_Database_Interfaces/DBD/MSERGEANT/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://search.cpan.org/CPAN/authors/id/S/SU/SULLR/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.funet.fi/pub/languages/perl/CPAN/modules/by-authors/id/S/SU/SULLR/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.is.co.za/pub/cpan/modules/by-module/IO/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.go.jp/pub/lang/CPAN/modules/by-module/IO/SULLR/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cpan.nust.na/CPAN/authors/id/S/SU/SULLR/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cpan.org/authors/id/F/FL/FLORA/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/perl-Net-SSLeay/Net-SSLeay-1.36.tar.gz/md5/54061638720dd6a325395331c77f21d8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://files.kolab.org/server/development-2.2/externals/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mexmat.sgu.ru/soft/Linux/distributions/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portage.macrolan.co.za/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kobyla.info/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.lunar-linux.org/lunar/cache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.openindiana.org/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
