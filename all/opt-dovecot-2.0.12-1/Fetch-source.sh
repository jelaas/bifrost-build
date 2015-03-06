#!/bin/bash

SRC=dovecot-2.0.12.tar.gz
DST=/var/spool/src/$SRC
MD5=689e1a8863d4fb2fd252e1a6121dd181

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
