#!/bin/bash

SRC=aprx-2.02.svn437.tar.gz
DST=/var/spool/src/$SRC
MD5=8cfcfcf225daac8096ba252d6f62540d

[ -s "$DST" ] || wget -O $DST http://ham.zmailer.org/oh2mqk/aprx/archive2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
