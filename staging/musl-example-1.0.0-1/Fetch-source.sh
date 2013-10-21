#!/bin/bash

SRC=example.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://source.on.internet/$SRC || wget -O $DST http://bifrost-repo/$SRC
