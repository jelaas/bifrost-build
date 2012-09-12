#!/bin/bash

SRC=wpa_supplicant-1.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC
