#!/bin/bash

SRC=iptables-1.4.8.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=697ed89f37af4473a5f6349ba2700f2d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.iptables.org/projects/iptables/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.netfilter.org/pub/iptables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/iptables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.yoctoproject.org/releases/yocto/yocto-0.9/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
