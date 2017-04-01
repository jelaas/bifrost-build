#!/bin/bash

SRC=libpcap-1.1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1bca27d206970badae248cfa471bbb47

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tcpdump.org/release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/zenwalk/source/l/libpcap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libpcap/libpcap-1.1.1.tar.gz/1bca27d206970badae248cfa471bbb47/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/libpcap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/tcpdump/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-current/source/l/libpcap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.37/source/l/libpcap/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
