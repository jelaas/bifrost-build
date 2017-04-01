#!/bin/bash

SRC=libnfsidmap-0.20.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9233cb77876eb642374a0d2bcaba1170

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnome.org/mirror/archive/ftp.sunet.se/pub/Linux/distributions/rootlinux/ports/net/libnfsidmap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/momonga/5/Everything/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
