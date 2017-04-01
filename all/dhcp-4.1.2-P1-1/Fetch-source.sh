#!/bin/bash

SRC=dhcp-4.1.2-P1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7e02b70429cc327dac8e6057467192e4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/network/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.fi.netbsd.org/pub/unix/tcpip/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://netfilter.kfki.hu/packages/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.dei.uc.pt/pub/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.internode.on.net/pub/isc/dhcp/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
