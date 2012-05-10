#!/bin/bash

SRC=argus-3.0.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://qosient.com/argus/src/$SRC
