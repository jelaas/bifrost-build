#!/bin/bash

V=4.1-ESV-R11
SRC=dhcp-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6f8da99b8757c4f6e1e7289ef9044a7a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.isc.org/isc/dhcp/"${V}"/"${SRC}" \"${SRC} \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.isc.org/isc/dhcp/"${SRC}"    \"${SRC} \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/network/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.isc.org/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/Unix/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://garr.mac.tucows.com/mirrors/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.isc.org/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://solaris.task.gda.pl/pub/unix/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/network/isc/dhcp/4.1-ESV-R11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.csit.parkland.edu/~cgraff1/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
