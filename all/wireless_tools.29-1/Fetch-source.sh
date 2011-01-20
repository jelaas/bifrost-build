#!/bin/bash

SRC=wireless_tools.29.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://hpl.hp.com/personal/Jean_Tourrilhes/Linux/$SRC

