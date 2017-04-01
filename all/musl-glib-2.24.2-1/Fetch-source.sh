#!/bin/bash

SRC=glib-2.24.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=8a6e45d7840460ed84288ebfd75782d4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.24/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uio.no/pub/GNOME/sources/glib/2.24/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fr2.rpmfind.net/linux/gnome.org/sources/glib/2.24/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/glib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/glib/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
