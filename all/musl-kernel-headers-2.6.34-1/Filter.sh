# Filter out unsupported modules

while read L; do
	n=0
	if [ -d "$L" ]; then
		mkdir -p $DSTU/$L
		mkdir -p $DSTW/$L
		continue
	fi
	for unsup in net/batman-adv net/ceph/libceph.ko block/DAC960.ko block/cciss.ko \
		     drivers/ide drivers/gpio /staging/ /virtio/ /openvswitch/ drivers/power/ \
 		     /leds/ input/misc/ input/mouse/ drivers/misc/ drivers/spi/; do
		if [[ $L =~ $unsup ]]; then
			mv $L $DSTU/$L || exit 1
		fi
		continue
	done
	for wireless in wireless net/mac80211; do
		if [[ $L =~ $wireless ]]; then
			mv $L $DSTW/$L || exit 1
			n=1
		fi
		continue
	done
	[ $n = 1 ] && continue

	for supported in kernel/arch/ kernel/crypto/ kernel/lib/ kernel/net/ kernel/fs/fat kernel/fs/nls \
			loop.ko ata_piix.ko sata_svw.ko; do
		[[ $L =~ $supported ]] && n=1
	done
	[ $n = 1 ] && continue

	for unsup in /drivers/ata/ /drivers/parport/ /block/paride/ /char/agp/ /i2c/ message/fusion \
			/mfd/ /drivers/ssb /scsi/ /target/ /uio/ /usb/gadget/; do
		if [[ $L =~ $unsup ]]; then
			mv $L $DSTU/$L || exit 1
		fi
		continue
	done

	if [[ $L =~ kernel/drivers/ ]]; then
		[[ $L =~ kernel/drivers/net/ ]] || continue
	fi

	for supported in team e1000 igb ixgbe mdio libphy tulip veth macvlan tg3 niu ixgb bonding; do
		[[ $L =~ $supported ]] && n=1
	done
	[ $n = 1 ] && continue

	mv $L $DSTU/$L || exit 1
done
