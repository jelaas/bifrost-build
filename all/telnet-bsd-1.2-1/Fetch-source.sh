#!/bin/bash

SRC=telnet-bsd-1.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=72d72c65e7796dfec999f347da1c295f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/suse/people/kukuk/ipv6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.suse.com/pub/people/kukuk/ipv6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.isr.ist.utl.pt/pub/MIRRORS/ftp.suse.com/people/kukuk/ipv6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mir0.gentoo-fr.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
