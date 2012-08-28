#!/bin/bash

SRC=e3-2.8.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
	pkg_install wget-1.12-2
	wget --no-check-certificate -O $DST http://sites.google.com/site/e3editor/Home/e3-2.8.tgz
fi

