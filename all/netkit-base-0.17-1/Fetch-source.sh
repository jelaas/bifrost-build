#!/bin/bash

SRC=netkit-base-0.17.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1f0193358e92559ec0f598b09ccbc0ec

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ibiblio.org/pub/linux/system/network/netkit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lanet.lv/ftp/mirror/Slackware/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.metalab.unc.edu/pub/Linux/system/network/netkit/!INDEX.short.html"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.slackware.com/pub/slackware/slackware-10.1/source/n/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.slackware.com/pub/slackware/slackware-9.0/patches/source/tcpip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxfoundation.org/pub/lsb/impl/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
