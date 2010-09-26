#!/bin/bash

SRC=perl-5.10.1.tar.gz
DST=/var/spool/src/$SRC
[ -s "$DST" ] || wget -O $DST http://ftp.funet.fi/pub/CPAN/src/$SRC
