#!/bin/bash

SRC=logrotate-3.7.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ibiblio.download.sourcemage.org/pub/linux/distributions/sourcemage/mirror/$SRC || wget -O $DST http://dbg.download.sourcemage.org/mirror/$SRC
