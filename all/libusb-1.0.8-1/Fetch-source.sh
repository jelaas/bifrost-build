#!/bin/bash

SRC=libusb-1.0.8.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/$SRC
