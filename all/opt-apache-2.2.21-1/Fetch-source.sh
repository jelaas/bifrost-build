#!/bin/bash

SRC=httpd-2.2.21.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC
