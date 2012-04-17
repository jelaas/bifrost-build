#!/bin/bash

SRC=inetutils-1.9.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/gnu/inetutils/$SRC

