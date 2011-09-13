#!/bin/bash

SRC=rsync-3.0.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://rsync.samba.org/ftp/rsync/$SRC
