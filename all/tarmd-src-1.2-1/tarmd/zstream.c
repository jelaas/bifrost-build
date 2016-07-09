#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include "zstream.h"

// http://stackoverflow.com/questions/3912157/how-do-i-extract-all-the-data-from-a-bzip2-archive-with-c

static ssize_t readall(int fd, void *buf, size_t count)
{
	ssize_t n;
	ssize_t got=0;
	
	while(count) {
		n = read(fd, buf, count);
		if(n < 1) {
			if(!got) return n;
			return got;
		}
		count -= n;
		got += n;
		buf += n;
	}
	return got;
}

#ifdef USE_ZLIB
static int gzip_init(struct zstream *z)
{
	z->codec.gzip = (void*)0;
	return 0;
}

static int gzip_open(struct zstream *z, int fd, char *mode)
{
	z->codec.gzip = gzdopen(fd, mode);
	if(!z->codec.gzip) {
		return -1;
	}
	return 0;
}

static ssize_t gzip_read(struct zstream *z, void *buf, size_t size)
{
	return gzread(z->codec.gzip, buf, size);
}

static ssize_t gzip_write(struct zstream *z, void *buf, size_t count)
{
	return gzwrite(z->codec.gzip, buf, count);
}

static int gzip_close(struct zstream *z)
{
	int rc = gzclose(z->codec.gzip);
	z->codec.gzip = (void*)0;
	return rc;
}
#endif

#ifdef USE_BZIP2
static int bzip_init(struct zstream *z)
{
	z->codec.bz.f = (void*)0;
	z->codec.bz.eof = 1;
	z->codec.bz.error = 0;
	return 0;
}

static int bzip_open(struct zstream *z, int fd, char *mode)
{
	FILE *f;

	z->codec.bz.eof = 0;

	f = fdopen(fd, mode);
	if(!f) {
		return -1;
	}
	
	if(*mode == 'w') {
		return -1;
	}
	
	if(*mode == 'r') {
		z->codec.bz.f = BZ2_bzReadOpen(&z->codec.bz.error, f, 0, 0, NULL, 0);
		if(z->codec.bz.error != BZ_OK) {
			return -1;
		}
		return 0;
	}
	
	return -1;
}

static ssize_t bzip_read(struct zstream *z, void *buf, size_t size)
{
	int n;

	if(z->codec.bz.eof) return 0;

	n = BZ2_bzRead(&z->codec.bz.error, z->codec.bz.f, buf, size);
	if(z->codec.bz.error == BZ_STREAM_END) z->codec.bz.eof = 1;
	if (z->codec.bz.error == BZ_OK || z->codec.bz.error == BZ_STREAM_END) {
		return n;
	}
	return -1;
}

static ssize_t bzip_write(struct zstream *z, void *buf, size_t count)
{
	return -1;
}

static int bzip_close(struct zstream *z)
{
	BZ2_bzReadClose(&z->codec.bz.error, z->codec.bz.f);
	z->codec.bz.f = (void*)0;
	return z->codec.bz.error;
}
#endif

#ifdef USE_XZ
static int xz_init(struct zstream *z)
{
	lzma_stream tmp = LZMA_STREAM_INIT;
	z->codec.xz.eof = 1;
	z->codec.xz.stream = tmp;
	z->codec.xz.bufsize = 4096;
	z->codec.xz.inbuf = malloc(z->codec.xz.bufsize);
	if(!z->codec.xz.inbuf) return -1;
	z->codec.xz.outbuf = malloc(z->codec.xz.bufsize);
	if(!z->codec.xz.outbuf) return -1;
	return 0;
}

static int xz_open(struct zstream *z, int fd, char *mode)
{
	lzma_ret ret;
	
	z->codec.xz.eof = 0;
	z->codec.xz.fd = fd;
	if(*mode == 'w') {
		ret = lzma_easy_encoder(&z->codec.xz.stream, 5, LZMA_CHECK_CRC64);
		if (ret == LZMA_OK)
			return 0;
		return -1;
	}
	if(*mode == 'r') {
		z->codec.xz.stream.next_in = NULL;
		z->codec.xz.stream.avail_in = 0;
		z->codec.xz.stream.next_out = z->codec.xz.outbuf;
		z->codec.xz.stream.avail_out = z->codec.xz.bufsize;
		
		ret = lzma_stream_decoder(&z->codec.xz.stream, UINT64_MAX, LZMA_CONCATENATED);
		if (ret == LZMA_OK)
			return 0;
		return -1;
	}

	return -1;
}

static ssize_t xz_read(struct zstream *z, void *buf, size_t size)
{
	size_t avail, copysize;
	lzma_ret ret;
	lzma_action action = LZMA_RUN;

	if(z->codec.xz.eof) action = LZMA_FINISH;
	
	if (z->codec.xz.stream.avail_in == 0 && (!z->codec.xz.eof)) {
		z->codec.xz.stream.next_in = z->codec.xz.inbuf;
		z->codec.xz.stream.avail_in = readall(z->codec.xz.fd, z->codec.xz.inbuf, z->codec.xz.bufsize);
		if(z->codec.xz.stream.avail_in < 0) {
			/* read error */
			return -1;
		}
		if(z->codec.xz.stream.avail_in == 0) {
			/* EOF */
			z->codec.xz.eof = 1;
			z->codec.xz.stream.avail_in = 0;
			action = LZMA_FINISH;
		}
	}
	ret = lzma_code(&z->codec.xz.stream, action);
	if (ret != LZMA_OK) {
		if (ret != LZMA_STREAM_END) {
			return -2;
		}
	}
	avail = z->codec.xz.bufsize - z->codec.xz.stream.avail_out;
	if (avail) {
		copysize = avail;
		if(copysize > size) {
			copysize = size;
		}
		memcpy(buf, z->codec.xz.outbuf, copysize);
		memmove(z->codec.xz.outbuf, z->codec.xz.outbuf + copysize, avail - copysize);
		z->codec.xz.stream.next_out = z->codec.xz.outbuf + (avail - copysize);
		z->codec.xz.stream.avail_out = z->codec.xz.bufsize - (avail - copysize);
		return copysize;
	}

	return 0;
}

static ssize_t xz_write(struct zstream *z, void *buf, size_t count)
{
	return -1;
}

static int xz_close(struct zstream *z)
{
	int rc = close(z->codec.xz.fd);
	z->codec.xz.fd = -1;
	lzma_end(&z->codec.xz.stream);
	return rc;
}
#endif

static int copy_init(struct zstream *z)
{
	return 0;
}

static int copy_open(struct zstream *z, int fd, char *mode)
{
	z->codec.copy.fd = fd;
	return 0;
}

static ssize_t copy_read(struct zstream *z, void *buf, size_t size)
{
	return readall(z->codec.copy.fd, buf, size);
}

static ssize_t copy_write(struct zstream *z, void *buf, size_t count)
{
	return write(z->codec.copy.fd, buf, count);
}

static int copy_close(struct zstream *z)
{
	int rc = close(z->codec.copy.fd);
	return rc;
}

int zstream(struct zstream *z, const char *codec)
{
	if(!strcmp(codec, "copy")) {
		z->init = copy_init;
		z->open = copy_open;
		z->read = copy_read;
		z->write = copy_write;
		z->close = copy_close;
		return 0;
	}
#ifdef USE_ZLIB
	if(!strcmp(codec, "gzip")) {
		z->init = gzip_init;
		z->open = gzip_open;
		z->read = gzip_read;
		z->write = gzip_write;
		z->close = gzip_close;
		return 0;
	}
#endif
#ifdef USE_XZ
	if(!strcmp(codec, "xz")) {
		z->init = xz_init;
		z->open = xz_open;
		z->read = xz_read;
		z->write = xz_write;
		z->close = xz_close;
		return 0;
	}
#endif
#ifdef USE_BZIP2
	if( (!strcmp(codec, "bzip2")) || (!strcmp(codec, "bz2")) ) {
		z->init = bzip_init;
		z->open = bzip_open;
		z->read = bzip_read;
		z->write = bzip_write;
		z->close = bzip_close;
		return 0;
	}
#endif
	return -1;
}

