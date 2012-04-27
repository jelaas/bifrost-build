#!/bin/bash

SRC=aprx-2.02.svn437.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ham.zmailer.org/oh2mqk/aprx/aprx-2.02.svn437.tar.gz
