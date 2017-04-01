#!/bin/bash

SRC=bind-9.7.6-P2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8570762bba843aa409f243032ba8faf5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.isc.org/isc/bind9/9.7.6-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ripe.net/mirrors/sites/ftp.isc.org/isc/bind/9.7.6-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/0/isc/bind/9.7.6-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware64-13.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns2.autopilotas.lt/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware64-13.37/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackmirror.cbpf.br/pub/slackware/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kambing.ui.ac.id/slackware/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.mirror.ac.za/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.wheel.sk/slackware/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://zmirror.ipinw.biz/slackware/slackware-12.0/patches/source/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/src/bind/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
