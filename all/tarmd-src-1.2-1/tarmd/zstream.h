#ifndef ZSTREAM_H
#define ZSTREAM_H

#include <sys/types.h>

#ifdef USE_ZLIB
#include <zlib.h>
#endif
#ifdef USE_XZ
#include <lzma.h>
#endif
#ifdef USE_BZIP2
#include <bzlib.h>
#endif
struct zstream  {
	int (*open)(struct zstream *, int, char *);
	ssize_t (*read)(struct zstream *, void *, size_t);
	ssize_t (*write)(struct zstream *, void *, size_t);
	int (*init)(struct zstream *);
	int (*close)(struct zstream *);
	union {
#ifdef USE_XZ
		struct {
			lzma_stream stream;
			int fd, eof;
			size_t bufsize;
			void *inbuf, *outbuf;
		} xz;
#endif
#ifdef USE_ZLIB
		gzFile gzip;
#endif
#ifdef USE_BZIP2
	        struct {
		        BZFILE *f;
	                int error;
		        int eof;
		} bz;
#endif
	        struct {
	                int fd;
                } copy;
	} codec;
};

int zstream(struct zstream *z, const char *codec);

#endif
