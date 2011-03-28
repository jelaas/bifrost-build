#!/bin/bash

SRC=cpuid-20110305.src.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.etallen.com/cpuid/$SRC
