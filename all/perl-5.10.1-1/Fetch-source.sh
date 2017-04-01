#!/bin/bash

SRC=perl-5.10.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b9b2fdb957f50ada62d73f43ee75d044

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.funet.fi/pub/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cpan.org/src/5.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://photon.ring.gr.jp/archives/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.sohu.com/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.neu.edu.cn/CPAN/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.up.pt/CPAN/authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub2/openpkg1/sources/CPY/perl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.funet.fi/pub/languages/perl/CPAN/modules/by-authors/id/D/DA/DAPM/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ring.ksc.gr.jp/archives/lang/perl/CPAN/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
