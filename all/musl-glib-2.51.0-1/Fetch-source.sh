#!/bin/bash

SRC=glib-2.51.0.tar.xz
DST=/var/spool/src/"${SRC}"
MD5=9721b74ba1d1047305d58971556aa2b8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.51/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/glib2/glib-2.51.0.tar.xz/9721b74ba1d1047305d58971556aa2b8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/pub/gnome/sources/glib/2.51/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/gnome/sources/glib/2.51/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://meetings-archive.debian.net/mirror/gnome.org/sources/glib/2.51/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/8.x/armv7/tcz/src/glib2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.math.princeton.edu/pub/gnome/core/3.23/3.23.3/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/Unix/X/GNOME/sources/glib/2.51/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lug.udel.edu/pub/gnome/core/3.23/3.23.1/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
