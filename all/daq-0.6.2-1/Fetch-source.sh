#!/bin/bash

SRC=daq-0.6.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.procyonlabs.com/mirrors/snort/$SRC || wget -O http://ftp.psu.ac.th/pub/snort/$SRC
