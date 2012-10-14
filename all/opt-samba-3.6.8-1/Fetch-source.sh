#!/bin/bash

SRC=samba-3.6.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.samba.org/samba/ftp/stable/$SRC
