#!/bin/bash
SRC=jpegsrc.v9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b397211ddfd506b92cd5e02a22ac924d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ijg.org/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://download.videolan.org/pub/contrib/jpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/jpeg/www.ijg.org/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/custombuild/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://netbsd.gw.com/pub/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://r.research.att.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/b397211ddfd506b92cd5e02a22ac924d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://shoes.mvmanila.com/public/shoesdeps/mingw/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://so.liuxinxiu.com/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.thzhost.com/directadmin/services/custombuild/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sigrand.ru/dl/misc/src-depot/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
