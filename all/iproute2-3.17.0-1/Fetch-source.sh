#!/bin/bash

SRC=iproute2-3.17.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e55ebbeaa2ebc307e4fd5a575d729430

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/kernel/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/Linux/kernel.org/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fccn.pt/repos/pub/kernel.org/pub/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ring.u-toyama.ac.jp/pub/linux/kernel.org/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
