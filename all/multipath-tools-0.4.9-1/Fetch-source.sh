#!/bin/bash

SRC=multipath-tools-0.4.9.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://christophe.varoqui.free.fr/multipath-tools/$SRC
