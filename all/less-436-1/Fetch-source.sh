#!/bin/bash

SRC=less-436.tar.gz
DST=/var/spool/src/$SRC
MD5=817bf051953ad2dea825a1cdf460caa4

[ -s "$DST" ] || wget -O $DST http://www.greenwoodsoftware.com/less/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
