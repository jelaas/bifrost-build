#!/bin/bash

SRC=krb5-1.8.1-signed.tar
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://web.mit.edu/kerberos/www/dist/krb5/1.8/$SRC
