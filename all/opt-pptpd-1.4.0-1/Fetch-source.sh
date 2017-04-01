#!/bin/bash

SRC=pptpd-1.4.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=36f9f45c6ffa92bc3b6e24ae2d053505

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/poptop/pptpd/pptpd-1.4.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/pptpd/pptpd-1.4.0.tar.gz/36f9f45c6ffa92bc3b6e24ae2d053505/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/p/po/poptop/pptpd/pptpd-1.4.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www4.frugalware.org/pub/linux/distributions/frugalware/frugalware-stable/source/network-extra/pptpd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
