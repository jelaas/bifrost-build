/*
 * File: vers.c
 * Implements: versionsorting of names
 *
 * Copyright: Jens Låås, 2011
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <libgen.h>
#include <stdlib.h>

#include "jelist.h"

struct pkg {
	struct jlhead *l;
	int vers_idx;
	char *name, *vers, *prettyname;
};

struct {
	int usepath;
} conf;

int parse(struct jlhead *l, const char *n, int delim)
{
	char *p, *s;

//	printf("parse: %s\n", n);
	p = strchr(n, delim);
	if(l->len == 0) {
		s = strchr(n, '_');
		if(p) {
			if(s && (s < p))
				p = s;
		} else
			p = s;
	}
	if(!p || (p == n+strlen(n)-1)) {
		jl_ins(l, strdup(n));
		return 0;
	}
	if(isalpha(*n)) {
		parse(l, strndup(n, p-n+1), '.');
	} else
		jl_ins(l, strndup(n, p-n+1));
	parse(l, p+1, '-');
	
	return 0;
}

int isnamechar(int c)
{
	if(conf.usepath) {
		if(isalpha(c))
			return 1;
		if(c == '/')
			return 1;
		return 0;
	}
	return isalpha(c);
}

int find_vers_idx(struct jlhead *l)
{
	int n = 0;
	char *p;
	
	jl_foreach(l, p) {
		if(isnamechar(*p))
			n++;
		else
			break;
	}
	return n;
}

char *pkg_name(const struct pkg *pkg)
{
	char buf[512];
	int i;

	buf[0] = 0;
	
	for(i=0;i<pkg->vers_idx;i++)
		strcat(buf, jl_at(pkg->l, i));
	return strdup(buf);
}

char *pkg_prettyname(const struct pkg *pkg)
{
	char buf[512];
	int i;

	buf[0] = 0;
	
	for(i=0;i<pkg->vers_idx;i++)
		strcat(buf, jl_at(pkg->l, i));
	if(buf[0]) {
		if(!isalnum(buf[strlen(buf)-1]))
			buf[strlen(buf)-1] = 0;
	}
	return strdup(buf);
}

char *pkg_vers(const struct pkg *pkg)
{
	char *p;
	char buf[512];
	int i;

	buf[0] = 0;
	
	for(i=pkg->vers_idx;;i++) {
		p = jl_at(pkg->l, i);
		if(!p) break;
		strcat(buf, p);
	}
	return strdup(buf);
}

#define ALPHA 1
#define NUMERIC 2
#define DELIM 3

int vtype(int c)
{
	if(isalpha(c)) return ALPHA;
	if(isdigit(c)) return NUMERIC;
	return DELIM;
}

struct jlhead *vsplit(const char *s, const char *delimiters)
{
	/* split alpha and subversions */
	struct jlhead *l;
	int state = 0;
	const char *start = s;

	l = jl_new();

	state = vtype(*s);
	
	while(*s) {
		if(vtype(*s) != state) {
			/* end of element */
			jl_ins(l, strndup(start, s-start));
			state = vtype(*s);
			start = s;
		}
		s++;
	}
	
	if(s > start)
		jl_ins(l, strndup(start, s-start));
	return l;
}

int vcmp(char *s1, char *s2)
{
	struct jlhead *l1, *l2;
	int i, d;
	char *e1, *e2;

//	printf("vcmp: %s - %s\n", s1, s2);
	
	l1 = vsplit(s1, "._");
	l2 = vsplit(s2, "._");
	
	/* compare element by element */
	for(i=0;;i++) {
		e1 = jl_at(l1, i);
		e2 = jl_at(l2, i);
		if(!e1 && e2)
			return -1;
		if(!e2 && e1)
			return 1;
		if(!e1 && !e2)
			return 0;
		if(isdigit(*e1) && isdigit(*e2)) {
			d = atoi(e1) - atoi(e2);
			if(d) return d;
		} else {
			d = strcmp(e1, e2);
			if(d) return d;
		}
	}
	return 0;
}

int vers_cmp(const struct pkg *p1, const struct pkg *p2)
{
	int m, i, d;

//	printf("vers_cmp: %s%s - %s%s\n", p1->name, p1->vers, p2->name, p2->vers);
	
	m = p1->l->len;
	if(m > p2->l->len)
		m = p2->l->len;
	
	for(i=p1->vers_idx;i<m;i++) {
		d = vcmp(jl_at(p1->l, i), jl_at(p2->l, i));
		if(d) return d;
	}
	if(i < p1->l->len)
		return 1;
	if(i < p2->l->len)
		return -1;
	return 0;
}

int pkg_cmp(const void *i1, const void *i2)
{
	int d;
	
	const struct pkg *p1 = i1;
	const struct pkg *p2 = i2;
	d = strcmp(p1->name, p2->name);
	if(d) return d;
	return vers_cmp(p1, p2);
}

int main(int argc, char **argv)
{
	struct pkg *pkg, *prev=NULL;
	struct jlhead *l, *pkglist;
	int latest = 0, names = 0;
	conf.usepath = 0;

	while(argc > 1) {
		if(*argv[1] != '-') break;
		if(!strcmp(argv[1], "-h") ||
		   !strcmp(argv[1], "--help")) {
			printf("vers [-l] [-n] argument ..\n"
			       "Sorts arguments by version.\n"
			       "By default the argument is assumed to be a filename and the path is stripped from the name.\n"
			       " -l       only print highest versions\n"
			       " -n       only print names\n"
			       " -p       keep path part of argument\n"
				);
			exit(0);
		}
		if(!strcmp(argv[1], "-l")) {
			latest = 1;
			argc--;
			argv++;
			continue;
		}
		if(!strcmp(argv[1], "-n")) {
			names = 1;
			argc--;
			argv++;
			continue;
		}
		if(!strcmp(argv[1], "-p")) {
			conf.usepath = 1;
			argc--;
			argv++;
			continue;
		}
		break;
	}

	pkglist = jl_new();
	jl_sort(pkglist, pkg_cmp);

	while(--argc) {
		l = jl_new();
		parse(l, conf.usepath?strdup(argv[argc]):basename(strdup(argv[argc])), '-');
		pkg = malloc(sizeof(struct pkg));
		pkg->l = l;
		pkg->vers_idx = find_vers_idx(l);
		pkg->name = pkg_name(pkg);
		pkg->prettyname = pkg_prettyname(pkg);
		pkg->vers = pkg_vers(pkg);
		jl_ins(pkglist, pkg);
	}

	jl_foreach(pkglist, pkg) {
		if(latest) {
			if(prev && strcmp(pkg->name, prev->name)) {
				if(names)
					printf("%s\n", prev->prettyname);
				else
					printf("%s%s\n", prev->name, prev->vers);
				prev = pkg;
			}
			if(!prev) prev = pkg;
		} else {
			if(names)
				printf("%s\n", pkg->prettyname);
			else
				printf("%s%s\n", pkg->name, pkg->vers);
		}
	}
	if(prev) {
		if(names)
			printf("%s\n", prev->prettyname);
		else
			printf("%s%s\n", prev->name, prev->vers);
	}
	
	return 0;
}
