#!/bin/bash

SRC=wpa_supplicant-0.7.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC
