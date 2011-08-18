#!/bin/bash

SRC=x86info-1.27.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://codemonkey.org.uk/projects/x86info/$SRC || wget -O $DST http://codemonkey.org.uk/projects/x86info/old/$SRC
