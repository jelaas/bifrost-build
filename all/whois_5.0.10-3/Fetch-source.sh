#!/bin/bash

SRC=whois_5.0.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d7626a3f789da85e70e4b931b6b34a26

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.debian.org/debian/pool/main/w/whois/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnome.org/mirror/cdimage/snapshot/20050323/Debian/pool/main/w/whois/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lmde-mirror.gwendallebihan.net/latest/pool/main/w/whois/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourcearchive.raspbian.org/main/w/whois/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
