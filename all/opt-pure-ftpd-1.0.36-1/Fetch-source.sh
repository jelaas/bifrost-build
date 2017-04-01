#!/bin/bash

SRC=pure-ftpd-1.0.36.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=7899c75c1fed7dbad0352eb31080e066

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/pure-ftpd/pure-ftpd-1.0.36.tar.bz2/7899c75c1fed7dbad0352eb31080e066/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/pure-ftpd/releases/obsolete/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.funet.fi/index/files/index/CERT/ftp.cert.dfn.de/pub/tools/net/pure-ftpd/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.belnet.be/pub/ftp.pureftpd.org/releases/obsolete/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nchu.edu.tw/Unix/FTP/PureFTPd/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.pnl.gov/macports/distfiles/pure-ftpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/quirky/quirky6/sources/t2/april/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freebsd.uct.ac.za/pub/packages/macports/distfiles/pure-ftpd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp1.fr.freebsd.org/pub/frugalware/frugalware-testing/source/network-extra/pure-ftpd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
