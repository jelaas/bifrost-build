#!/bin/bash

SRC=tar-1.23.tar.bz2
DST=/var/spool/src/$SRC
MD5=41e2ca4b924ec7860e51b43ad06cdb7e

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/tar/$SRC \
              || wget -O $DST http://ftp.clfs.org/pub/clfs/conglomeration/tar/$SRC \
              || wget -O $DST http://ftp.acc.umu.se/mirror/gnu.org/gnu/tar/$SRC \
              || wget -O $DST ftp://gnu.mirror.iweb.com/tar/$SRC \
              || wget -O $DST http://mirror.frgl.pw/gnu/tar/$SRC \
              || wget -O $DST http://ca.mirror.babylon.network/gnu/$SRC \
              || wget -O $DST ftp://reflection.oss.ou.edu/gnu/tar/$SRC \
              || wget -O $DST ftp://ftp.unicamp.br/pub/gnu/tar/$SRC \
              || wget -O $DST http://mirror.cedia.org.ec/gnu/tar/$SRC \
              || wget -O $DST http://mirrors.ustc.edu.cn/gnu/tar/$SRC \
              || wget -O $DST http://ftp.kaist.ac.kr/gnu/tar/$SRC \
              || wget -O $DST http://www.artfiles.org/gnu.org/tar/$SRC \
              || wget -O $DST ftp://ftp.wrz.de/pub/gnu/tar/$SRC \
              || wget -O $DST http://ftp.rediris.es/mirror/GNU/tar/$SRC \
              || wget -O $DST http://gnuftp.uib.no/tar/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
