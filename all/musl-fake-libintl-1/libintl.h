#ifndef _LIBINTL_H
#define _LIBINTL_H	1

#define gettext(str) str
#define dgettext(dom,str) str
#define textdomain(dom) dom
#define bindtextdomain(_dom,_dir) _dom

#endif
