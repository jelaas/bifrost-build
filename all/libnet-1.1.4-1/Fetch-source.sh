#!/bin/bash

SRC=libnet-1.1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libnet-dev/$SRC
