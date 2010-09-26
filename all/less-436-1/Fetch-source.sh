#!/bin/bash

SRC=less-436.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.greenwoodsoftware.com/less/$SRC
