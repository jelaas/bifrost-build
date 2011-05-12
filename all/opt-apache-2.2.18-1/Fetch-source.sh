#!/bin/bash

SRC=httpd-2.2.18.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC
