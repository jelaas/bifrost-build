#!/bin/bash

SRC=subversion-1.9.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=243036eb28b50ce517fc228eb3250add

[ -s "$DST" ] || wget -O $DST http://apache.mirrors.spacedump.net/subversion/$SRC \
              || wget -O $DST http://distfiles.macports.org/subversion/$SRC \
              || wget -O $DST http://mirror.23media.de/apache/subversion/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
