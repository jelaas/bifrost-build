/*
TAR Message Digest
------------------

Make or verify a message digest for a TAR-file.

tarmd [-v] SHA512 OFILE CMD CMDARGS
tarmd [-v] -g|--generate OFILE CMD CMDARGS
tarmd 5646546546 $DST wget -O- URL/$SRC

Forks and execs CMD. Expects CMD to output TARFILE on stdout.
Starts download to OFILE.unverified.$$
CMD exits fail = remove OFILE.unverified.$$
Digest computed on the fly.

	create list of all files in archive: [name, digest]
sort list
make digest over all digests in sorted list.
compare.
*/

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

#include "zstream.h"
#include "sha256.h"
#include "arr.h"

struct tar_header {
	char name[100];
	char mode[8];
	char uid[8];
	char gid[8];
	char size[12];
	char mtime[12];
	char chksum[8];
	char typeflag;
	char linkname[100];
	char magic[6];
	char version[2];
	char uname[32];
	char gname[32];
	char devmajor[8];
	char devminor[8];
	char prefix[155];
	char filler[12];
};

struct pax {
	char *name;
	char *uid;
	char *gid;
	char *mtime;
	char *linkname;
	char *uname;
	char *gname;
};

struct {
	char *sha;
	char *ofile, *ofilesuff;
	char *fmt;
	int verbose, generate, force, usestdout;
	struct {
		int regfile, dirfile, linkfile, specfile;
		int filename, linkname, typeflag, mode, pmode, owner, powner, mtime, size, content, dev;
	} filter;
} conf;

struct {
	int cmdpipe[2];
	int detpipe[2];
	int inputfd;
	pid_t cmdpid;
	pid_t detpid;
	char *compressor;
} var;

static int pax_parse(struct pax *pax, char *data, size_t datasize)
{
	char *p = data, *key, *value;
	size_t siz;
	
	/* "%d %s=%s\n", <length>, <keyword>, <value> */

	while(p && *p) {
		siz = strtoul(p,0,10);
		if(siz < 1) return -1;
		if( (p+siz) > data+datasize) return -1;

		for(key=p; key < (p+siz); key++) {
			if(*key == ' ') break;
		}
		if(*key != ' ') return -1;

		key++;
		for(value=key; value < (p+siz); value++) {
			if(*value == '=') break;
		}
		if(*value != '=') return -1;
		*value = 0;
		value++;
		*(p+siz-1) = 0;
		p+=siz;
		
		if(!strcmp(key, "comment")) {
			continue;
		}
		if(!strcmp(key, "atime")) {
			continue;
		}
		if(!strcmp(key, "ctime")) {
			continue;
		}
		if(!strcmp(key, "uid")) {
			if(pax->uid) {
				free(pax->uid);
				pax->uid = (void*)0;
			}
			if(*value) pax->uid = strdup(value);
			continue;
		}
		if(!strcmp(key, "gid")) {
			if(pax->gid) {
				free(pax->gid);
				pax->gid = (void*)0;
			}
			if(*value) pax->gid = strdup(value);
			continue;
		}
		if(!strcmp(key, "mtime")) {
			if(pax->mtime) {
				free(pax->mtime);
				pax->mtime = (void*)0;
			}
			if(*value) pax->mtime = strdup(value);
			continue;
		}
		if(!strcmp(key, "uname")) {
			if(pax->uname) {
				free(pax->uname);
				pax->uname = (void*)0;
			}
			if(*value) pax->uname = strdup(value);
			continue;
		}
		if(!strcmp(key, "gname")) {
			if(pax->gname) {
				free(pax->gname);
				pax->gname = (void*)0;
			}
			if(*value) pax->gname = strdup(value);
			continue;
		}
		if(!strcmp(key, "path")) {
			if(pax->name) {
				free(pax->name);
				pax->name = (void*)0;
			}
			if(*value) pax->name = strdup(value);
		}
		if(!strcmp(key, "linkpath")) {
			if(pax->linkname) {
				free(pax->linkname);
				pax->linkname = (void*)0;
			}
			if(*value) pax->linkname = strdup(value);
			continue;
		}
		return -1;
	}
	
	return 0;
}

static ssize_t zreadall(struct zstream *z, char *buf, size_t len)
{
	ssize_t n;
	ssize_t got=0;
	
	while(len) {
		n = z->read(z, buf, len);
		if(n < 1) {
			if(!got) return n;
			return got;
		}
		len -= n;
		got += n;
	        buf += n;
	}
	return got;
}

static int untar(struct zstream *z, char **err)
{
	struct mdfile md;
	unsigned char hbuf[520];
	char buf[1024];
	struct tar_header *th;
	struct pax glob;
	struct pax ext;
	struct {
		char mode[32];
		char uid[32];
		char gid[32];
		char mtime[32];
		char *linkname;
		char *uname;
		char *gname;
		char devmajor[32];
		char devminor[32];
	} norm;
	ssize_t siz, nulsiz;
	int mode, pmode, powner, oldhdr, chksum;
	char pmodestr[4], pownerstr[2];
	struct arrarr aa;
	struct sha256_ctx sha256;
	unsigned char sumsha256[SHA256_DIGEST_LENGTH];
	
	arr_init(&aa);
	
	memset(&glob, 0, sizeof(glob));
	memset(&ext, 0, sizeof(ext));
	memset(&norm, 0, sizeof(norm));

	while(zreadall(z,(char*)hbuf,512)==512) {
		if(norm.linkname) free(norm.linkname);
		if(norm.uname) free(norm.uname);
		if(norm.gname) free(norm.gname);
		memset(&norm, 0, sizeof(norm));
		oldhdr = 0;
		md.filename[0] = 0;
		th=(struct tar_header*)hbuf;
		if(th->name[0] == 0) break;

		if(conf.verbose) fprintf(stderr, "tarmd: chksum: '%s'\n", th->chksum);
		chksum = strtoull(th->chksum,0,8);
		{
			int i;
			unsigned int sum=0;
			for(i=0;i<148;i++) sum+=hbuf[i];
			for(i=0;i<8;i++) sum+=32;
			for(i=156;i<512;i++) sum+=hbuf[i];
			if(conf.verbose) fprintf(stderr, "tarmd: calc chksum: '%o'\n", sum);
			if(chksum != sum) {
				*err = "checksum";
				fprintf(stderr, "tarmd: header checksum failed\n");
				return -1;
			}
		}
		
		if(strncmp(th->magic, "ustar", 5)) {
			if(conf.verbose > 1) fprintf(stderr, "tarmd: magic: '%s' %s\n", th->magic, th->name);
			oldhdr = 1;
			th->prefix[0] = 0;
		}
		
		th->name[99] = 0;
		th->prefix[154] = 0;
		th->linkname[99] = 0;
		th->uid[7] = 0;
		th->gid[7] = 0;
		th->mtime[11] = 0;
		th->size[11] = 0;

		if(!oldhdr) {
			th->uname[31] = 0;
			th->gname[31] = 0;
			th->devmajor[7] = 0;
			th->devminor[7] = 0;
		}

		if(ext.name) {
			strncpy(md.filename, ext.name, sizeof(md.filename));
			md.filename[sizeof(md.filename)-1] = 0;
			free(ext.name);
			ext.name = (void*)0;
		} else {
			if (th->prefix[0]) strcat(md.filename, th->prefix);
			strcat(md.filename, th->name);			
		}
		
		snprintf(norm.mode, sizeof(norm.mode), "%llu", strtoull(th->mode,0,8));
		norm.mode[sizeof(norm.mode)-1] = 0;
		
		snprintf(norm.uid, sizeof(norm.uid), "%llu", strtoull(th->uid,0,8));
		if(glob.uid) strncpy(norm.uid, glob.uid, sizeof(norm.uid));
		if(ext.uid) {
			strncpy(norm.uid, ext.uid, sizeof(norm.uid));
			free(ext.uid);
			ext.uid = (void*)0;
		}
		norm.uid[sizeof(norm.uid)-1] = 0;
		
		snprintf(norm.gid, sizeof(norm.gid), "%llu", strtoull(th->gid,0,8));
		if(glob.gid) strncpy(norm.gid, glob.gid, sizeof(norm.gid));
		if(ext.gid) {
			strncpy(norm.gid, ext.gid, sizeof(norm.gid));
			free(ext.gid);
			ext.gid = (void*)0;
		}
		norm.gid[sizeof(norm.gid)-1] = 0;
		
		snprintf(norm.mtime, sizeof(norm.mtime), "%llu", strtoull(th->mtime,0,8));
		if(glob.mtime) strncpy(norm.mtime, glob.mtime, sizeof(norm.mtime));
		if(ext.mtime) {
			strncpy(norm.mtime, ext.mtime, sizeof(norm.mtime));
			free(ext.mtime);
			ext.mtime = (void*)0;
		}
		norm.mtime[sizeof(norm.mtime)-1] = 0;

		norm.linkname = strdup(th->linkname);
		if(ext.linkname) {
			norm.linkname = ext.linkname;
			ext.linkname = (void*)0;
		}
		
		if(!oldhdr) {
			norm.uname = strdup(th->uname);
			if(glob.uname) norm.uname = strdup(glob.uname);
			if(ext.uname) {
				norm.uname = ext.uname;
				ext.uname = (void*)0;
			}
			norm.gname = strdup(th->gname);
			if(glob.gname) norm.gname = strdup(glob.gname);
			if(ext.gname) {
				norm.gname = ext.gname;
				ext.gname = (void*)0;
			}
		
			snprintf(norm.devmajor, sizeof(norm.devmajor), "%llu", strtoull(th->devmajor,0,8));
			norm.devmajor[sizeof(norm.devmajor)-1] = 0;
			
			snprintf(norm.devminor, sizeof(norm.devminor), "%llu", strtoull(th->devminor,0,8));
			norm.devminor[sizeof(norm.devminor)-1] = 0;
		}
		
		siz=strtoull(th->size,0,8);
		
		/* pmode: aggregates access flags. if one of user group or other is 1 then the result is 1. */
		mode=strtoul(norm.mode,0,10);
		pmode = 0;
		if(mode & 0111) pmode += 1;
		if(mode & 0222) pmode += 2;
		if(mode & 0444) pmode += 4;
		if(mode & 077000) pmode += 8;
		memset(pmodestr, 0, sizeof(pmodestr));
		sprintf(pmodestr, "%d", pmode);
		
		/* "R" if uid or gid = root. "U" if both uid and gid > 0 */
		powner = strtoul(norm.uid,0,10);
		if(powner) powner = strtoul(norm.gid,0,10);
		if(powner) {
			strcpy(pownerstr, "U");
		} else {
			strcpy(pownerstr, "R");
		}
		
		if(conf.verbose) fprintf(stderr, "tarmd: read %s %s/%s %s size=%s\n", md.filename, norm.uid, norm.gid, norm.mtime, th->size);
		
		sha256_init_ctx(&sha256);
		
		if(conf.filter.filename) sha256_process_bytes(md.filename, strlen(md.filename), &sha256);
		if(conf.filter.pmode) sha256_process_bytes(pmodestr, 4, &sha256);
		if(conf.filter.mode) sha256_process_bytes(norm.mode, strlen(norm.mode), &sha256);
		if(conf.filter.typeflag) sha256_process_bytes(&th->typeflag, 1, &sha256);
		if(conf.filter.mtime) sha256_process_bytes(norm.mtime, strlen(norm.mtime), &sha256);
		if(conf.filter.powner) sha256_process_bytes(pownerstr, 1, &sha256);
		if(conf.filter.owner) {
			sha256_process_bytes(norm.uid, strlen(norm.uid), &sha256);
			sha256_process_bytes(norm.gid, strlen(norm.gid), &sha256);
		}
		if(conf.filter.size) {
			sha256_process_bytes(th->size, 11, &sha256);
		}
		if(th->typeflag == 2) {
			if(conf.filter.linkname) sha256_process_bytes(norm.linkname, strlen(norm.linkname), &sha256);
		}
		if(th->typeflag == 3 || th->typeflag == 4) {
			if(conf.filter.dev) sha256_process_bytes(norm.devmajor, strlen(norm.devmajor), &sha256);
			if(conf.filter.dev) sha256_process_bytes(norm.devminor, strlen(norm.devminor), &sha256);
		}

		if(siz) {
			ssize_t n;
			size_t extdatasize;
			char *p, *extdata;
			
			nulsiz = ((siz+511) & ~511) - siz;
			
			/* Allocate memory buffer to hold extension data, if any */
			extdata = (void*) 0;
			if(th->typeflag == 'g' || th->typeflag == 'x' || th->typeflag == 'L' || th->typeflag == 'K' ) {
				extdata = malloc(siz+1);
				if(!extdata) {
					*err = "extension data OOM";
					return -1;
				}
				extdatasize = siz+1;
			}
			p = extdata;
			
			if(conf.verbose > 1) fprintf(stderr, "tarmd: reading size %zd bytes\n", siz);
			
			while(siz) {
				n = zreadall(z,buf,siz > sizeof(buf) ? sizeof(buf):siz);
				if(n < 1) {
					fprintf(stderr, "tarmd: unexpected EOF when reading file %s\n", md.filename);
					*err = "tar";
					return -1;
				}
				siz -= n;
				if(conf.filter.content) sha256_process_bytes(buf, n, &sha256);
				if(extdata) {
					memcpy(p, buf, n);
					p += n;
					*p = 0;
				}
				
				if(n < sizeof(buf)) {
					buf[n] = 0;
				} else {
					buf[sizeof(buf)-1] = 0;
				}
			}
			if(conf.verbose > 2 && extdata)
				fprintf(stderr, "extension data: '%s'\n", extdata);
			
			// throw away excess
			if(conf.verbose > 1) fprintf(stderr, "tarmd: reading nulsize %zd bytes\n", nulsiz);
			while(nulsiz) {
				n = zreadall(z,buf,nulsiz > sizeof(buf) ? sizeof(buf):nulsiz);
				if(n < 1) {
					fprintf(stderr, "tarmd: unexpected EOF when reading nulsize %s\n", md.filename);
					*err = "tar";
					return -1;
				}
				nulsiz -= n;
			}

			/* Parse extension data */
			if(extdata && th->typeflag == 'K') {
				ext.linkname = strdup(extdata);
			}
			if(extdata && th->typeflag == 'L') {
				ext.name = strdup(extdata);
			}
			if(extdata && th->typeflag == 'g') {
				/* pax global header */
				if(pax_parse(&glob, extdata, extdatasize)) {
					*err = "pax global data error";
					return -1;
				}
			}
			if(extdata && th->typeflag == 'x') {
				/* pax extension header */
				if(pax_parse(&ext, extdata, extdatasize)) {
					*err = "pax extension data error";
					return -1;
				}
			}
			if(extdata) free(extdata);
		}

		{
			int i;
			unsigned u;
			char *p;
			sha256_finish_ctx(&sha256, sumsha256);
			p = md.sha256;
			for(i=0;i<SHA256_DIGEST_LENGTH;i++) {
				u = sumsha256[i] >> 4;
				if(u < 10) *p++ = u + '0';
				if(u >= 10) *p++ = u + 'a' - 10;
				u = sumsha256[i] & 0xf;
				if(u < 10) *p++ = u + '0';
				if(u >= 10) *p++ = u + 'a' - 10;
			}
			if(conf.verbose > 1) fprintf(stderr, "tarmd: sha256: %.64s\n", md.sha256);
		}
		
		if(th->typeflag == 0 || (th->typeflag >= '0' && th->typeflag <= '5')) {
			int addflag;

			addflag = 0;
			if(conf.filter.regfile && (th->typeflag == 0 || (th->typeflag == '0'))) addflag=1;
			if(conf.filter.dirfile && (th->typeflag == '5')) addflag=1;
			if(conf.filter.linkfile && (th->typeflag == '1')) addflag=1;
			if(conf.filter.specfile && (th->typeflag == '3' || th->typeflag == '4'|| th->typeflag == '6' )) addflag=1;
			
			if(addflag) {
				if(arr_ins(&aa, &md)) {
					fprintf(stderr, "tarmd: arr_ins failed for %s\n", md.filename);
					*err = "out of memory";
					return -1;
				}
				if(conf.verbose) fprintf(stderr, "tarmd: digest %s\n", md.filename);
			}
			continue;
		}

		if(th->typeflag == 'g') {
			if(conf.verbose) fprintf(stderr, "skipping pax global header\n");
			continue;
		}
		if(th->typeflag == 'x') {
			if(conf.verbose) fprintf(stderr, "skipping pax extended header\n");
			continue;
		}
		if(th->typeflag == 'L') {
			if(conf.verbose) fprintf(stderr, "read 'L' (longname) extended header\n");
			continue;
		}
		if(th->typeflag == 'K') {
			if(conf.verbose) fprintf(stderr, "read 'K' (longlink) extended header\n");
			continue;
		}
		fprintf(stderr, "tarmd: unhandled: %d/'%c' %s\n", th->typeflag, th->typeflag, md.filename);
		*err = "tar support";
		return -1;
	}

	if(!aa.list) {
		*err = "empty tar";
		return -1;
	}
	
	// sort list
	arr_sort(&aa);
	
	// calc checksum over checksums
	sha256_init_ctx(&sha256);
	while(arr_iter(&aa, &md)) {
		if(conf.verbose > 2) fprintf(stderr, "tarmd: cumulative digest %s\n", md.filename);
		sha256_process_bytes(md.sha256, sizeof(md.sha256), &sha256);
	}
	sha256_finish_ctx(&sha256, sumsha256);

	{
		int i;
		unsigned u;
		char shastr[SHA256_DIGEST_LENGTH*2+1];
		char *p;
		sha256_finish_ctx(&sha256, sumsha256);
		p = shastr;
		for(i=0;i<SHA256_DIGEST_LENGTH;i++) {
			u = sumsha256[i] >> 4;
			if(u < 10) *p++ = u + '0';
			if(u >= 10) *p++ = u + 'a' - 10;
			u = sumsha256[i] & 0xf;
			if(u < 10) *p++ = u + '0';
			if(u >= 10) *p++ = u + 'a' - 10;
		}
		*p=0;
		if(conf.verbose) fprintf(stderr, "tarmd: result cumulative digest sha256: %.64s\n", shastr);
		if(conf.generate) {
			if(conf.usestdout)
				fprintf(stderr, "%.64s\n", shastr);
			else
				printf("%.64s\n", shastr);
		} else {
			if(strcasecmp(shastr, conf.sha)) {
				if(conf.verbose) fprintf(stderr, "tarmd: SHA256 mismatch!\n");
				sprintf(buf, "SHA256 %s", shastr);
				*err = buf;
				return 1;
			}
		}
	}
	
	return 0;
}

int lookup(char *namebuf, size_t bufsize, const char *name)
{
	char *path, *sep;
	size_t len;
	struct stat buf;
	path = getenv("PATH");
	if(!path) return -1;
	
	while(path && *path) {
		sep = strchr(path, ':');
		if(sep)
			len = sep - path;
		else
			len = strlen(path);
		if( (len + strlen(name) + 2) < bufsize ) {
			strncpy(namebuf, path, len);
			strcpy(namebuf + len, "/");
			strcpy(namebuf + len + 1, name);
			if(conf.verbose > 3) fprintf(stderr, "tarmd: lookup '%s'\n", namebuf);
			if(stat(namebuf, &buf) == 0) {
				return 0;
			}
		}
		path += len;
		if(*path) path++;
	}
	
	return -1;
}


int main(int argc, char **argv, char **envp)
{
	while(argc > 1) {
		if(!strcmp(argv[1], "-f")) {
			conf.force += 1;
			argc--;
			argv++;
			continue;
		}
		if(!strcmp(argv[1], "-v")) {
			conf.verbose += 1;
			argc--;
			argv++;
			continue;
		}
		if(!strcmp(argv[1], "-g")) {
			conf.generate = 1;
			argc--;
			argv++;
			continue;
		}
		if(*(argv[1]) == '+') {
			conf.fmt = argv[1] + 1;
			argc--;
			argv++;
			continue;
		}
		if(!strcmp(argv[1], "-h")) {
			printf("tarmd [-f] [-v] [-h] [+FMT] SHA256 OFILE [CMD [ARG]*]\n"
			       "tarmd [-f] [-v] [-h] [+FMT] -g OFILE [CMD [ARG]*]\n"
			       "\n"
			       " -f      Force overwrite of existing file.\n"
			       " -v      Increase verbosity\n"
			       " -h      Help\n"
			       " -g      Generate SHA256 digest\n"
			       " +FMT    Specify what to include in digest\n"
			       "\nSupports uncompressed, xz, gzip, bzip2 tar archives.\n"
			       "Expects archive on stdin or as output from CMD.\n"
			       "If OFILE is '-' then outputs archive to stdout.\n"
			       "Archive is saved to file $(OFILE).unverified.$$\n"
			       "If checksum matches the file is renamed to $(OFILE)\n"
			       "Exit code 0 if digest matched.\n"
			       "Exit code 1 if digest did not match.\n"
			       "Exit code 2 on error.\n"
			       "\n"
			       "Default FMT is \"rdlsFLTCM\"\n"
			       " FMT = [FILETYPE]*[DATA]*\n"
			       " FILETYPE = r|d|l|s\n"
			       " DATA = F|L|T|C|M|E|S|I|O|W|D\n"
			       " r = regular file\n"
			       " d = directory\n"
			       " l = link\n"
			       " s = special file (char or block device)\n"
			       " F = filename\n"
			       " L = link target\n"
			       " T = file type flag\n"
			       " C = file content\n"
			       " M = simplified mode. Boolean OR of user, group, other.\n"
			       " E = mode\n"
			       " S = size\n"
			       " I = mtime\n"
			       " O = owner uid,gid\n"
			       " W = simplified owner. Root or user\n"
			       " D = dev major minor\n"
				);
			exit(0);
		}
		break;
	}
	if(conf.fmt) {
		if(strchr(conf.fmt, 's')) conf.filter.specfile = 1;
		if(strchr(conf.fmt, 'l')) conf.filter.linkfile = 1;
		if(strchr(conf.fmt, 'd')) conf.filter.dirfile = 1;
		if(strchr(conf.fmt, 'r')) conf.filter.specfile = 1;
		if(strchr(conf.fmt, 'L')) conf.filter.linkname = 1;
		if(strchr(conf.fmt, 'F')) conf.filter.filename = 1;
		if(strchr(conf.fmt, 'D')) conf.filter.dev = 1;
		if(strchr(conf.fmt, 'O')) conf.filter.owner = 1;
		if(strchr(conf.fmt, 'I')) conf.filter.mtime = 1;
		if(strchr(conf.fmt, 'S')) conf.filter.size = 1;
		if(strchr(conf.fmt, 'E')) conf.filter.mode = 1;
		if(strchr(conf.fmt, 'M')) conf.filter.pmode = 1;
		if(strchr(conf.fmt, 'C')) conf.filter.content = 1;
		if(strchr(conf.fmt, 'T')) conf.filter.typeflag = 1;
	}
	if(!conf.fmt) {
		conf.filter.regfile = 1;
		conf.filter.dirfile = 1;
		conf.filter.linkfile = 1;
		conf.filter.specfile = 1;
		
		conf.filter.filename = 1;
		conf.filter.linkname = 1;
		conf.filter.typeflag = 1;
		conf.filter.content = 1;
		conf.filter.pmode = 1;
	}
	if(argc <= 1) {
		fprintf(stderr, "tarmd: missing arg\n");
		exit(1);
	}
	if(!conf.generate) {
		conf.sha=strdup(argv[1]);
		argc--; argv++;
	}
	if(argc <= 1) {
		fprintf(stderr, "tarmd: missing arg\n");
		exit(1);
	}
	conf.ofile=strdup(argv[1]);
	argc--; argv++;

	if(!strcmp(conf.ofile, "-")) conf.usestdout = 1;
	
	if(!conf.force) {
		struct stat statb;
		if(stat(conf.ofile, &statb) == 0) {
			fprintf(stderr, "tarmd: %s already exists\n", conf.ofile);
			_exit(2);
		}
	}
	
	/* fork and exec cmd */
	if(argc > 1) {
		pipe(var.cmdpipe);
		if( (var.cmdpid = fork()) ) {
			/* parent */
			if(var.cmdpid == -1) exit(2);
			close(var.cmdpipe[1]);
			var.inputfd = var.cmdpipe[0];
		} else {
			int fd;
			char **cmdargv;
			int i;
			
			cmdargv = malloc(sizeof(char*)*(argc+1));
			for(i=0; i < argc; i++) {
				cmdargv[i] = argv[i+1];
			}
			cmdargv[argc] = (void*)0;
			
			if(cmdargv[0][0] != '/' && cmdargv[0][0] != '.') {
				char namebuf[256];
				if(lookup(namebuf, sizeof(namebuf), cmdargv[0]) == 0) {
					cmdargv[0] = namebuf;
				}
			}
			
			/* child */
			close(var.cmdpipe[0]);
			fd = open("/dev/null", O_RDONLY);
			dup2(fd, 0);
			dup2(var.cmdpipe[1], 1);
			execve(cmdargv[0], cmdargv, envp);
			fprintf(stderr, "tarmd: failed execve %s\n", cmdargv[0]);
			exit(2);
		}
	} else {
		var.inputfd = 0;
	}

	/* fork and exec compression detector: cmd on input, checks for magic */
	{
		int fd = -1;
		char pidstr[16];
		
		pipe(var.detpipe);
		
#define SUFFIX ".unverified."
		
		snprintf(pidstr, sizeof(pidstr), "%u", getpid());
		conf.ofilesuff = malloc(strlen(conf.ofile)+strlen(SUFFIX)+strlen(pidstr)+1);
		if(!conf.ofilesuff) exit(2);
		sprintf(conf.ofilesuff, "%s%s%s", conf.ofile, SUFFIX, pidstr);
		
		if(conf.usestdout) {
			fd = 1;
		}
		if(fd < 0) {
			fd = open(conf.ofilesuff, O_WRONLY|O_CREAT|O_EXCL, 0644);
		}
		if(fd < 0) {
			if(conf.force) {
				fd = open(conf.ofilesuff, O_WRONLY, 0644);
			}
		}
		if(fd < 0) {
			fprintf(stderr, "Failed to open output file '%s'\n", conf.ofilesuff);
			exit(2);
		}
		
		if( (var.detpid = fork()) ) {
			/* parent */
			close(fd);
			close(var.inputfd);
			close(var.detpipe[1]);
			if(var.detpid == -1) goto errout;
		} else {
			/* child */
			char buf[256];
			ssize_t n;
			
			close(var.detpipe[0]);
			
			n = read(var.inputfd, buf, 6);
			if(n != 6) _exit(1);
			
			write(var.detpipe[1], buf, n);
			if(write(var.detpipe[1], buf, n)!=n) {
				fprintf(stderr, "write(%d, %zd) failed\n", var.detpipe[1], n);
			}
			if(write(fd, buf, n)!=n) {
				fprintf(stderr, "write(%d, %zd) failed\n", fd, n);
			}

			while(1) {
				n = read(var.inputfd, buf, sizeof(buf));
				if(n <= 0) break;
				if(write(var.detpipe[1], buf, n)!=n) {
					fprintf(stderr, "write(%d, %zd) failed\n", var.detpipe[1], n);
				}
				if(write(fd, buf, n)!=n) {
					fprintf(stderr, "write(%d, %zd) failed\n", fd, n);
				}
			}
			close(fd);
			_exit(0);
		}

	}

	/* read first output from compression detector which reports compression algo */
	{
		char buf[256];
		ssize_t n;
		uint8_t XZ_MAGIC[6] = { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
		uint8_t GZIP_MAGIC[2] = { 0x1F, 0x8B };
		uint8_t BZIP2_MAGIC[2] = { 'B', 'Z' };

		n = read(var.detpipe[0], buf, 6);
		if(n != 6) goto errout;
		
		var.compressor = "copy";
		if(memcmp(buf, XZ_MAGIC, 6)==0) var.compressor = "xz";
		if(memcmp(buf, GZIP_MAGIC, 2)==0) var.compressor = "gzip";
		if(memcmp(buf, BZIP2_MAGIC, 2)==0) var.compressor = "bzip2";
	}

	if(conf.verbose) fprintf(stderr, "tarmd: detected %s compression\n", var.compressor);

	/* zstream init */
	{
		struct zstream z;
		char *err = "Unknown error";
		int rc;

		if(zstream(&z, var.compressor)) {
			fprintf(stderr, "zstream init failed\n");
			goto errout;
		}
		z.init(&z);
		if(z.open(&z, var.detpipe[0], "r")) {
			fprintf(stderr, "zstream open failed\n");
			goto errout;
		}
		
		if((rc = untar(&z, &err))) {
			fprintf(stderr, "tarmd: %s failed\n", err);
			if(rc < 0) goto errout;
			if(!conf.usestdout) {
				if(unlink(conf.ofilesuff)) {
					fprintf(stderr, "tarmd: unlink %s failed\n", conf.ofilesuff);
				}
			}
			_exit(1);
		}
	}
	
	if(!conf.usestdout) {
		if(rename(conf.ofilesuff, conf.ofile)) {
			fprintf(stderr, "tarmd: rename %s failed, unlinking\n", conf.ofilesuff);
			if(unlink(conf.ofilesuff)) {
				fprintf(stderr, "tarmd: unlink %s failed\n", conf.ofilesuff);
			}
			_exit(2);
		}
	}

	return 0;
errout:
	if(!conf.usestdout) {
		if(unlink(conf.ofilesuff)) {
			fprintf(stderr, "tarmd: unlink %s failed\n", conf.ofilesuff);
		}
	}
	_exit(2);
}
