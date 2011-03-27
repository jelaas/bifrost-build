CC=gcc
CFLAGS=-Wall -Os -march=i586
LDFLAGS=-static
all:	blockdev-populate usbdev-populate
blockdev-populate:	blkdevpop.o jelopt.o jelist.o daemonize.o
	$(CC) $(LDFLAGS) -o blockdev-populate blkdevpop.o jelopt.o jelist.o daemonize.o
usbdev-populate:	usbdevpop.o jelopt.o jelist.o daemonize.o
	$(CC) $(LDFLAGS) -o usbdev-populate usbdevpop.o jelopt.o jelist.o daemonize.o

clean:	
	rm -f *.o blockdev-populate usbdev-populate
