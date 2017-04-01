#!/bin/bash

SRC=plan9port-20140306.tgz
DST=/var/spool/src/"${SRC}"
MD5=f03331f0fa0d0d6c6582ced4bc0094c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-name/system/plan9port/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
