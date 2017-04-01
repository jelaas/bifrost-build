#!/bin/bash

SRC=libiconv-1.13.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7ab33ebd26687c744a37264a330bbe9a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/pub/gnu/libiconv/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/libiconv/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ustc.edu.cn/gnu/libiconv/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/libiconv/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/custombuild/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlab.jp/puppylinux/download/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.infobiotics.org/files/contrib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://reistlin.com/download/linux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org.ua/gnu/libiconv/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.vlcapp.com/pub/videolan/contrib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.thzhost.com/directadmin/services/custombuild/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
