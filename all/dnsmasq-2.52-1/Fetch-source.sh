#!/bin/bash

SRC=dnsmasq-2.52.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1bb32fffdb4f977ead607802b5d701d0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.thekelleys.org.uk/dnsmasq/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}"     \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bindist.wlan-si.net/mirror/"${SRC}"    \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
