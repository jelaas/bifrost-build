#!/bin/bash

SRC=perl-5.10.1.tar.gz
SRCB=XML-Parser-2.36.tar.gz
SRCC=IO-Socket-SSL-1.84.tar.gz
SRCD=Net-SSLeay-1.36.tar.gz
DST=/var/spool/src/$SRC
DSTB=/var/spool/src/$SRCB
DSTC=/var/spool/src/$SRCC
DSTD=/var/spool/src/$SRCD
MD5=b9b2fdb957f50ada62d73f43ee75d044
MD5B=1b868962b658bd87e1563ecd56498ded
MD5C=3878d8c84c1e8a611f4d0d9b3574ce35
MD5D=54061638720dd6a325395331c77f21d8

[ -s "$DST" ]  || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC \
  || ../../wget-finder -O $DST $SRC:$MD5
[ -s "$DSTB" ] || wget -O $DSTB http://www.cpan.org/authors/id/M/MS/MSERGEANT/$SRCB \
  || ../../wget-finder -O $DSTB $SRCB:$MD5B
[ -s "$DSTC" ] || wget -O $DSTC http://search.cpan.org/CPAN/authors/id/S/SU/SULLR/$SRCC \
  || ../../wget-finder -O $DSTC $SRCC:$MD5C
[ -s "$DSTD" ] || wget -O $DSTD http://www.cpan.org/authors/id/F/FL/FLORA/$SRCD \
  || ../../wget-finder -O $DSTD $SRCD:$MD5D
