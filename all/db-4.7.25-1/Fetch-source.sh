#!/bin/bash

SRC=db-4.7.25.tar.gz
DST=/var/spool/src/$SRC
MD5=ec2b87e833779681a0c3a814aa71359e

[ -s "$DST" ] || wget -O $DST http://download.oracle.com/berkeley-db/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
