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
	z->gzip = (void*)0;
	return 0;
}

static int gzip_open(struct zstream *z, int fd, char *mode)
{
	z->gzip = gzdopen(fd, mode);
	if(!z->gzip) {
		return -1;
	}
	return 0;
}

static ssize_t gzip_read(struct zstream *z, void *buf, size_t size)
{
	return gzread(z->gzip, buf, size);
}

static ssize_t gzip_write(struct zstream *z, void *buf, size_t count)
{
	return gzwrite(z->gzip, buf, count);
}

static int gzip_close(struct zstream *z)
{
	int rc = gzclose(z->gzip);
	z->gzip = (void*)0;
	return rc;
}
#endif

#ifdef USE_BZIP2
static int bzip_init(struct zstream *z)
{
	z->bz.f = (void*)0;
	z->bz.eof = 1;
	z->bz.error = 0;
	return 0;
}

static int bzip_open(struct zstream *z, int fd, char *mode)
{
	FILE *f;

	z->bz.eof = 0;

	f = fdopen(fd, mode);
	if(!f) {
		return -1;
	}
	
	if(*mode == 'w') {
		return -1;
	}
	
	if(*mode == 'r') {
		z->bz.f = BZ2_bzReadOpen(&z->bz.error, f, 0, 0, NULL, 0);
		if(z->bz.error != BZ_OK) {
			return -1;
		}
		return 0;
	}
	
	return -1;
}

static ssize_t bzip_read(struct zstream *z, void *buf, size_t size)
{
	int n;

	if(z->bz.eof) return 0;

	n = BZ2_bzRead(&z->bz.error, z->bz.f, buf, size);
	if(z->bz.error == BZ_STREAM_END) z->bz.eof = 1;
	if (z->bz.error == BZ_OK || z->bz.error == BZ_STREAM_END) {
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
	BZ2_bzReadClose(&z->bz.error, z->bz.f);
	z->bz.f = (void*)0;
	return z->bz.error;
}
#endif

#ifdef USE_XZ
static int xz_init(struct zstream *z)
{
	lzma_stream tmp = LZMA_STREAM_INIT;
	z->xz.eof = 1;
	z->xz.stream = tmp;
	z->xz.bufsize = 4096;
	z->xz.inbuf = malloc(z->xz.bufsize);
	if(!z->xz.inbuf) return -1;
	z->xz.outbuf = malloc(z->xz.bufsize);
	if(!z->xz.outbuf) return -1;
	return 0;
}

static int xz_open(struct zstream *z, int fd, char *mode)
{
	lzma_ret ret;
	
	z->xz.eof = 0;
	z->xz.fd = fd;
	if(*mode == 'w') {
		ret = lzma_easy_encoder(&z->xz.stream, 5, LZMA_CHECK_CRC64);
		if (ret == LZMA_OK)
			return 0;
		return -1;
	}
	if(*mode == 'r') {
		z->xz.stream.next_in = NULL;
		z->xz.stream.avail_in = 0;
		z->xz.stream.next_out = z->xz.outbuf;
		z->xz.stream.avail_out = z->xz.bufsize;
		
		ret = lzma_stream_decoder(&z->xz.stream, UINT64_MAX, LZMA_CONCATENATED);
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

	if(z->xz.eof) action = LZMA_FINISH;
	
	if (z->xz.stream.avail_in == 0 && (!z->xz.eof)) {
		z->xz.stream.next_in = z->xz.inbuf;
		z->xz.stream.avail_in = readall(z->xz.fd, z->xz.inbuf, z->xz.bufsize);
		if(z->xz.stream.avail_in < 0) {
			/* read error */
			return -1;
		}
		if(z->xz.stream.avail_in == 0) {
			/* EOF */
			z->xz.eof = 1;
			z->xz.stream.avail_in = 0;
			action = LZMA_FINISH;
		}
	}
	ret = lzma_code(&z->xz.stream, action);
	if (ret != LZMA_OK) {
		if (ret != LZMA_STREAM_END) {
			return -2;
		}
	}
	avail = z->xz.bufsize - z->xz.stream.avail_out;
	if (avail) {
		copysize = avail;
		if(copysize > size) {
			copysize = size;
		}
		memcpy(buf, z->xz.outbuf, copysize);
		memmove(z->xz.outbuf, z->xz.outbuf + copysize, avail - copysize);
		z->xz.stream.next_out = z->xz.outbuf + (avail - copysize);
		z->xz.stream.avail_out = z->xz.bufsize - (avail - copysize);
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
	int rc = close(z->xz.fd);
	z->xz.fd = -1;
	lzma_end(&z->xz.stream);
	return rc;
}
#endif

static int copy_init(struct zstream *z)
{
	return 0;
}

static int copy_open(struct zstream *z, int fd, char *mode)
{
	z->copy.fd = fd;
	return 0;
}

static ssize_t copy_read(struct zstream *z, void *buf, size_t size)
{
	return readall(z->copy.fd, buf, size);
}

static ssize_t copy_write(struct zstream *z, void *buf, size_t count)
{
	return write(z->copy.fd, buf, count);
}

static int copy_close(struct zstream *z)
{
	int rc = close(z->copy.fd);
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

