#!/bin/bash

SRC=krb5-1.8.1-signed.tar
DST=/var/spool/src/"${SRC}"
MD5=e29a78b108c4687f7e7937110d1d0415

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://web.mit.edu/kerberos/www/dist/krb5/1.8/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
