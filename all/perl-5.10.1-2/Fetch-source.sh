#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
DST=/var/spool/src/$SRC
DSTB=/var/spool/src/$SRCB

[ -s "$DST" ] || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC
[ -s "$DSTB" ] || wget -O $DSTB http://www.cpan.org/authors/id/M/MS/MSERGEANT/$SRCB
