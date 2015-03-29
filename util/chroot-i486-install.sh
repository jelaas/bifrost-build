#!/bin/sh

[ X"$(id -u)" = X"0" ] || { printf "\n  Oops, needs to be run as root due to chroot\n\n"; exit 1; }
BASEDIR="$(dirname "$(readlink -f "${0}")")"

mkdir -p $BASEDIR/mini-native-i586/var/lib
cp /etc/resolv.conf $BASEDIR/mini-native-i586/etc
cp /etc/hosts $BASEDIR/mini-native-i586/etc
setarch i486 chroot $BASEDIR/mini-native-i586 /bin/env-install.sh "${@}"
