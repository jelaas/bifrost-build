#!/bin/bash

SRC=php-5.3.17.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=29ee79c941ee85d6c1555c176f12f7ef

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://static.php.net/www.php.net/distributions/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://museum.php.net/php5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing-it.nl/mirror/slackware-12.2/patches/source/php/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
