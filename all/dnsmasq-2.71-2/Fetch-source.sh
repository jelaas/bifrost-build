#!/bin/bash

SRC=dnsmasq-2.71.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=15a68f7f6cc0119e843f67d2f79598f1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.thekelleys.org.uk/dnsmasq/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}"     \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bindist.wlan-si.net/mirror/"${SRC}"    \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
