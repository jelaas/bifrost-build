#!/bin/bash

SRC=powertop-1.11.tar.gz
DST=/var/spool/src/$SRC
MD5=3498f5983c683c3a57dce7379a722082

[ -s "$DST" ] || wget -O $DST http://ftp.heanet.ie/mirrors/slackware/pub/slackware/slackware-13.1/source/ap/powertop/$SRC \
              || wget -O $DST http://slackware.mirrors.tds.net/pub/slackware/slackware64-13.1/source/ap/powertop/$SRC     \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/powertop/powertop-1.11.tar.gz/3498f5983c683c3a57dce7379a722082/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
