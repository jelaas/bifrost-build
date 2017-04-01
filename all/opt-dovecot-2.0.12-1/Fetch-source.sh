#!/bin/bash

SRC=dovecot-2.0.12.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=689e1a8863d4fb2fd252e1a6121dd181

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dovecot/dovecot-2.0.12.tar.gz/689e1a8863d4fb2fd252e1a6121dd181/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
