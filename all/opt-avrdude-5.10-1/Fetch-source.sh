#!/bin/bash

SRC=avrdude-5.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://nongnu.askapache.com/avrdude/$SRC
