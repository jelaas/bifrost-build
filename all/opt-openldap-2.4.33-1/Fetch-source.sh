#!/bin/bash

SRC=openldap-2.4.33.tgz
DST=/var/spool/src/"${SRC}"
MD5=5adae44897647c15ce5abbff313bc85a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/network/security/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/openldap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/openldap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cmsrep.cern.ch/cmssw/comp.pre.belforte/SOURCES/slc6_amd64_gcc461/external/openldap/2.4.33/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
