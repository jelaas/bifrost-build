#!/bin/bash

SRC=php-7.1.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://static.php.net/www.php.net/distributions/$SRC || wget -O $DST http://museum.php.net/php5/$SRC
