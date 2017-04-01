#!/bin/bash

SRC=openldap-2.4.26.tgz
DST=/var/spool/src/openldap-2.4.26.tar.gz
MD5=f36f3086031dd56ae94f722ffae8df5e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openldap.org/software/download/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/openldap/openldap-2.4.26.tgz/f36f3086031dd56ae94f722ffae8df5e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sjtu.edu.cn/sites/ftp.openldap.org/pub/OpenLDAP/openldap-release/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sleepgate.ru/FreeBSD/ports/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdata.psru.ac.th/~pisut/Backup_takpao/distfiles90/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
