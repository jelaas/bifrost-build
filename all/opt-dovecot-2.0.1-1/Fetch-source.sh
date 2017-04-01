#!/bin/bash

SRC=dovecot-2.0.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f58749dae7826d82b96fccf2c9e3bbf7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dovecot/dovecot-2.0.1.tar.gz/f58749dae7826d82b96fccf2c9e3bbf7/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
