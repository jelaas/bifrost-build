#!/bin/bash

SRC=net-snmp-5.7.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d4a3459e1577d0efa8d96ca70a885e53

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/net-snmp/net-snmp-5.7.3.tar.gz/d4a3459e1577d0efa8d96ca70a885e53/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/net-snmp/5.7.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/7.x/x86/tcz/src/net-snmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/n/project/ne/net-snmp/net-snmp/5.7.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.libreelec.tv/mirror/net-snmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.freenas.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
