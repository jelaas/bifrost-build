#!/bin/bash

SRC=nload-0.7.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3c733c528f244ca5a4f76bf185729c39

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.roland-riegel.de/nload/$SRC \"${SRC} \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.uk.freesbie.org/sites/distfiles.macports.org/nload/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.uk.freesbie.org/sites/downloads.sourceforge.net/n/nl/nload/nload/0.7.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/nload/nload-0.7.4.tar.gz/3c733c528f244ca5a4f76bf185729c39/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
