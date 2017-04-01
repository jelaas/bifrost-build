#!/bin/bash

SRC=libusb-1.0.8.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=37d34e6eaa69a4b645a19ff4ca63ceef

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/libusb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libusb1/libusb1-1.0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libusb/libusb-1.0.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
