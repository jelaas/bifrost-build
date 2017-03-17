#!/bin/bash

SRC=php-7.1.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=ec1d51abaea07e4a84f9dca856a0fa81

[ -s "$DST" ] || wget -O $DST http://static.php.net/www.php.net/distributions/$SRC \
              || wget -O $DST http://museum.php.net/php5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
