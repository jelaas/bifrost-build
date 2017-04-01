#!/bin/bash

V=4.1-ESV-R6; SRC=dhcp-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5a228dc9bf49649d49c91a5bed272963

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.isc.org/isc/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.isc.org/isc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/Unix/isc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.isc.org/isc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ripe.net/mirrors/sites/ftp.isc.org/isc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/network/isc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.task.gda.pl/site/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware-13.1/patches/source/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux.mathematik.tu-darmstadt.de/pub/linux/mirrors/misc/dhcp/4.1-ESV-R6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing-it.nl/mirror/slackware-12.2/patches/source/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware-13.1/patches/source/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware64-13.1/patches/source/dhcp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apt2.dilos.org/dilos/srcarch/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
