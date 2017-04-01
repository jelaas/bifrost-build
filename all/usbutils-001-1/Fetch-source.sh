#!/bin/bash

SRC=usbutils-001.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=40398698053f9f735550117322430e57

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.linux.org.au/linux/utils/usb/usbutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/linux/kernel/people/gregkh/usbutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.europeonline.com/pub/linux/utils/usb/usbutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/?C=N;O=D"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.kfki.hu/linux/ftp.kernel.org/pub/linux/utils/usb/usbutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.firefighter.ru/mirrors/ftp.linux.kiev.ua/Linux/Owl/pool/sources/usbutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
