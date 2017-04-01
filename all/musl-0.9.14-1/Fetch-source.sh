#!/bin/bash

SRC=musl-0.9.14.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=bfb685695aa942e64c63170589e575b2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
