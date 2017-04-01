#!/bin/bash

SRC=arpwatch.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cebfeb99c4a7c2a6cee2564770415fe7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.ee.lbl.gov/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/linux/net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.belnet.be/pub/salixos.org/sbo/14.0/network/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://iks.cs.ovgu.de/~elkner/tmp/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
