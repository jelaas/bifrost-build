#!/bin/bash

SRC=tcl8.5.10-src.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a08eaf8467c0631937067c1948dd326b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://prdownloads.sourceforge.net/tcl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-hannover.de/tcl/tcl8_5/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-4.0/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fileplanet.com/lfs/pub/blfs/conglomeration/tcl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages-4.0/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/lookaside/pkgs/tcl/tcl8.5.10-src.tar.gz/a08eaf8467c0631937067c1948dd326b/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
