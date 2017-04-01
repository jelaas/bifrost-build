#!/bin/bash

SRC=openldap-2.4.44.tgz
DST=/var/spool/src/"${SRC}"
MD5=693ac26de86231f8dcae2b4e9d768e51

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openldap.org/software/download/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/openldap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/openldap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.voidlinux.eu/openldap-2.4.44/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sjtu.edu.cn/sites/ftp.openldap.org/pub/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/openldap/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
