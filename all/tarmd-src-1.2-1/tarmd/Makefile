CC=musl-gcc-x86_32
# CFLAGS="-DUSE_ZLIB -DUSE_XZ -DUSE_BZIP2 -std=c99 -D_GNU_SOURCE" CC=gcc make -e
CFLAGS:=-Wall $(CFLAGS)
LDLIBS?=-lz -llzma -lbz2
tarmd:	tarmd.o sha256.o zstream.o arr.o
clean:
	rm -f tarmd *.o
