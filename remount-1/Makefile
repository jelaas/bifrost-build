CC=diet gcc
CFLAGS=-nostdinc -Os -Wall -march=i586
LDFLAGS=-static
remount:	remount.o
	$(CC) $(LDFLAGS) -o remount remount.o
clean:
	rm -f *.o remount
