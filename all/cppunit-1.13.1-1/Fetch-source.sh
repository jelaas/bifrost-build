#!/bin/bash

SRC=cppunit-1.13.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://dev-www.libreoffice.org/src/fa9aa839145cdf860bf596532bb8af97-cppunit-1.13.1.tar.gz
