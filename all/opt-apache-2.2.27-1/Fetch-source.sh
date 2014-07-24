#!/bin/bash

SRC=httpd-2.2.27.tar.bz2
DST=/var/spool/src/$SRC

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC
