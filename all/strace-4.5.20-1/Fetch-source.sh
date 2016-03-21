 #!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://distro.ibiblio.org/openwall/Owl/pool/sources/strace/$SRC \
              || wget -O $DST http://slackbuilds.org/mirror/slackware/slackware-13.37/source/d/strace/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/strace/strace-4.5.20.tar.bz2/64dfe10d9db0c1e34030891695ffca4b/$SRC
