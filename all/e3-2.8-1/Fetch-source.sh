#!/bin/bash

SRC=e3-2.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://sites.google.com/site/e3editor/Home/e3-2.8.tgz
