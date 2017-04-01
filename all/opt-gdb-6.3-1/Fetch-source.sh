#!/bin/bash

SRC=gdb-6.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=05b928f41fa5b482e49ca2c24762a0ae

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lanet.lv/ftp/GNU/gdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.arnes.si/software/gnu/gdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/gnu.old/gdb/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxfoundation.org/pub/lsb/impl/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
