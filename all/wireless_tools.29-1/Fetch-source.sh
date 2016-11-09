#!/bin/bash

SRC=wireless_tools.29.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://hpl.hp.com/personal/Jean_Tourrilhes/Linux/$SRC

