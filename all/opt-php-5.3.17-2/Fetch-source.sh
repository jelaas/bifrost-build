#!/bin/bash

SRC=php-5.3.17.tar.bz2
DST=/var/spool/src/$SRC
MD5=29ee79c941ee85d6c1555c176f12f7ef

[ -s "$DST" ] || wget -O $DST http://static.php.net/www.php.net/distributions/$SRC \
              || wget -O $DST http://museum.php.net/php5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
