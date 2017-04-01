#!/bin/bash

SRC=ipmitool-1.8.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0f9b4758c2b7e8a7bafc2ead113b4bc6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/ipmitool/ipmitool/1.8.11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.lunar-linux.org/lunar/cache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/minix/distfiles/local/3.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://master.us.finkmirrors.net/distfiles/md5/0f9b4758c2b7e8a7bafc2ead113b4bc6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://joule.bu.edu/~hazen/CMS/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.cs.vu.nl/pub/minix/distfiles/backup/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
