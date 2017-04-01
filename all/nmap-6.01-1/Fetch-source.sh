#!/bin/bash

SRC=nmap-6.01.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=a1a71940f238abb835dbf3ee7412bcea

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nmap.org/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/local-distfiles/ohauer/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/nmap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/nmap/sourceforge/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/nmap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/?C=N;O=D"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
