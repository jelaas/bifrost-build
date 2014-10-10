#!/bin/bash

SRC=jansson-2.7.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.digip.org/jansson/releases/$SRC
