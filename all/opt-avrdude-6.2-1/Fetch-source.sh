#!/bin/bash

SRC=avrdude-6.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://nongnu.askapache.com/avrdude/$SRC
