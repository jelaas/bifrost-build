#!/bin/bash

SRC=dialog-1.1-20100428.tgz
DST=/var/spool/src/$SRC
MD5=519c0a0cbac28ddb992111ec2c3f82aa

[ -s "$DST" ] || wget -O $DST ftp://invisible-island.net/dialog/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
