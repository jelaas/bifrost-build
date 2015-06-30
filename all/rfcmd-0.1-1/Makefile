CC=diet gcc
CFLAGS=-nostdinc -Os -Wall -march=i586
LDFLAGS=-static
rfcmd:	rfcmd.o
	$(CC) $(LDFLAGS) -o rfcmd rfcmd.o
clean:
	rm -f *.o rfcmd
