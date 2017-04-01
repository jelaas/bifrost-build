#!/bin/bash

SRC=emacs-23.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b6691852dae0bc142b3c12749f6b7ade

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gsdview.appspot.com/nativeclient-mirror/nacl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
