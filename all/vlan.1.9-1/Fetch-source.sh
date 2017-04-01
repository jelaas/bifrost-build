#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5f0c6060b33956fb16e11a15467dd394

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://laas.mine.nu/srcrepo/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/linux/net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cb.spb.ru/Linux/Vlan/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/v/vlan/vlan-1.9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://admin.asparuhovo.net/free/linux/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
