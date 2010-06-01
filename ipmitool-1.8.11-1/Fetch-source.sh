#!/bin/bash

SRC=ipmitool-1.8.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/ipmitool/ipmitool/1.8.11/$SRC
