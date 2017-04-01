#!/bin/bash

SRC=dmidecode-2.10.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=3c9c4d55a40b78600f3b43bfa64616f9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nongnu.uib.no/dmidecode/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dmidecode/dmidecode-2.10.tar.bz2/3c9c4d55a40b78600f3b43bfa64616f9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download-mirror.savannah.gnu.org/releases/dmidecode/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.fe.up.pt/pub/nongnu/dmidecode/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nchc.org.tw/Unix/NonGNU/dmidecode/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware64-13.1/source/ap/dmidecode/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-13.1/source/ap/dmidecode/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
