#ifndef _LIBINTL_H
#define _LIBINTL_H	1

#define gettext(str) str
#define dgettext(dom,str) str
#define textdomain(dom) dom
#define bindtextdomain(_dom,_dir) _dom

#define ngettext(msgid,msgid_plural,n) n==1?msgid:msgid_plural
#define dngettext(domainname,msgid,msgid_plural,n) n==1?msgid:msgid_plural
#define dcngettext(domainname,msgid,msgid_plural,n,category) n==1?msgid:msgid_plural

#endif
