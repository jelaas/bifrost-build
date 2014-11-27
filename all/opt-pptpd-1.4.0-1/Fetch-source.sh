#!/bin/bash

SRC=pptpd-1.4.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/poptop/pptpd/pptpd-1.4.0/$SRC
