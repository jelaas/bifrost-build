#!/bin/bash

SRC=whois_5.0.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.debian.org/debian/pool/main/w/whois/$SRC
