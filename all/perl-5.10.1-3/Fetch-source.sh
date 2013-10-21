#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
SRCC=IO-Socket-SSL-1.84.tar.gz
SRCD=Net-SSLeay-1.36.tar.gz
DST=/var/spool/src/$SRC
DSTB=/var/spool/src/$SRCB
DSTC=/var/spool/src/$SRCC
DSTD=/var/spool/src/$SRCD

[ -s "$DST" ] || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC
[ -s "$DSTB" ] || wget -O $DSTB http://www.cpan.org/authors/id/M/MS/MSERGEANT/$SRCB
[ -s "$DSTC" ] || wget -O $DSTC http://search.cpan.org/CPAN/authors/id/S/SU/SULLR/$SRCC
[ -s "$DSTD" ] || wget -O $DSTD http://www.cpan.org/authors/id/F/FL/FLORA/$SRCD
