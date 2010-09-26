#!/bin/bash

SRC=dnsmasq-2.52.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.thekelleys.org.uk/dnsmasq/$SRC
