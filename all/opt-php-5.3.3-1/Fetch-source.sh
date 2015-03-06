#!/bin/bash

SRC=php-5.3.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=21ceeeb232813c10283a5ca1b4c87b48

[ -s "$DST" ] || wget -O $DST http://static.php.net/www.php.net/distributions/$SRC \
              || wget -O $DST http://museum.php.net/php5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
