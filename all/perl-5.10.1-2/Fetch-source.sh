#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
DST=/var/spool/src/$SRC
DSTB=/var/spool/src/$SRCB
MD5=b9b2fdb957f50ada62d73f43ee75d044
MD5B=1b868962b658bd87e1563ecd56498ded

[ -s "$DST" ]  || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
[ -s "$DSTB" ] || wget -O $DSTB http://www.cpan.org/authors/id/M/MS/MSERGEANT/$SRCB \
 || ../../wget-finder -O $DSTB $SRCB:$MD5B
