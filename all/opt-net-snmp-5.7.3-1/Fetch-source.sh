#!/bin/bash

SRC=net-snmp-5.7.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d4a3459e1577d0efa8d96ca70a885e53

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/"${SRC}"    \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.mirrorservice.org/sites/distfiles.macports.org/net-snmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/7.x/armv7/tcz/src/net-snmp/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/net-snmp/5.7.3/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
