#!/bin/bash

SRC=wireless_tools.29.tar.gz
DST=/var/spool/src/$SRC
MD5=e06c222e186f7cc013fd272d023710cb

[ -s "$DST" ] || wget -O $DST http://hpl.hp.com/personal/Jean_Tourrilhes/Linux/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
