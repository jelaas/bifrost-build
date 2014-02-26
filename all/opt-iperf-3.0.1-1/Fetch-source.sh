#!/bin/bash

SRC=iperf-3.0.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://stats.es.net/software/$SRC
