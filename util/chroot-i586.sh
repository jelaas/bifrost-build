mkdir -p /home/build/mini-native-i586/var/lib
cp /etc/resolv.conf /home/build/mini-native-i586/etc
cp /etc/hosts /home/build/mini-native-i586/etc
setarch i586 chroot /home/build/mini-native-i586 /bin/chroot-setup.sh
