#!/bin/bash

SRC=perl-5.10.1.tar.gz
DST=/var/spool/src/$SRC
MD5=b9b2fdb957f50ada62d73f43ee75d044

[ -s "$DST" ] || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
