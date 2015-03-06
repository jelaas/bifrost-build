#!/bin/bash

SRC=php-5.3.14.tar.bz2
DST=/var/spool/src/$SRC
MD5=7caac4f71e2f21426c11ac153e538392

[ -s "$DST" ] || wget -O $DST http://static.php.net/www.php.net/distributions/$SRC \
              || wget -O $DST http://museum.php.net/php5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
