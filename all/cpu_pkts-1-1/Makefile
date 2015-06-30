CC=diet gcc
CFLAGS=-nostdinc -Os -Wall -march=i586
LDFLAGS=-static
cpu_pkts:	cpu_pkts.o
	$(CC) $(LDFLAGS) -o cpu_pkts cpu_pkts.o
clean:
	rm -f *.o cpu_pkts
