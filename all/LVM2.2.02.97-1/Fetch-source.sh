#!/bin/bash

SRC=LVM2.2.02.97.tgz
DST=/var/spool/src/"${SRC}"
MD5=d18bd01334309db1c422b9bf6b181057

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://sources.redhat.com/pub/lvm2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://vesta.informatik.rwth-aachen.de/ftp/pub/mirror/sourceware.org/lvm2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/lvm2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/lvm2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.amlogic.com:8000/download/GPL_code_release/ThirdParty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.webos-ports.org/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tinycorelinux.net/4.x/x86/scm/src/gentoo-buildhost/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux2.mathematik.tu-darmstadt.de/pub/linux/mirrors/misc/lvm2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
