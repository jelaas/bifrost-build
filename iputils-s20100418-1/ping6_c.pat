--- ping6.c.orig	Sun Jun 20 10:20:38 2010
+++ ping6.c	Sun Jun 20 10:21:35 2010
@@ -246,7 +246,6 @@
 static int niquery_option_ipv4_handler(int index, const char *arg);
 static int niquery_option_ipv4_flag_handler(int index, const char *arg);
 static int niquery_option_subject_addr_handler(int index, const char *arg);
-static int niquery_option_subject_name_handler(int index, const char *arg);
 char *ni_groupaddr(const char *name);
 
 struct niquery_option niquery_options[] = {
@@ -262,8 +261,6 @@
 	NIQUERY_OPTION("ipv4-all",		0,	NI_IPV4ADDR_F_ALL,		niquery_option_ipv4_flag_handler),
 	NIQUERY_OPTION("subject-ipv6",		1,	NI_SUBJ_IPV6,			niquery_option_subject_addr_handler),
 	NIQUERY_OPTION("subject-ipv4",		1,	NI_SUBJ_IPV4,			niquery_option_subject_addr_handler),
-	NIQUERY_OPTION("subject-name",		1,	0,				niquery_option_subject_name_handler),
-	NIQUERY_OPTION("subject-fqdn",		1,	-1,				niquery_option_subject_name_handler),
 	{},
 };
 
@@ -385,63 +382,6 @@
 			count++;
 	}
 	return count;
-}
-
-static int niquery_option_subject_name_handler(int index, const char *arg)
-{
-	unsigned char *dnptrs[2], **dpp, **lastdnptr;
-	int n;
-	char *name, *p;
-	unsigned char *buf;
-	size_t buflen = strlen(arg) + 1;
-	int fqdn = niquery_options[index].data;
-
-	if (niquery_set_subject_type(NI_SUBJ_NAME) < 0)
-		return -1;
-
-	if (fqdn == 0) {
-		/* guess if hostname is FQDN */
-		fqdn = niquery_count_dots(arg) ? 1 : -1;
-	}
-
-	name = strdup(arg);
-	buf = malloc(buflen + 1);
-	if (!name || !buf) {
-		free(name);
-		free(buf);
-		fprintf(stderr, "ping6: out of memory.\n");
-		exit(1);
-	}
-
-	ni_group = ni_groupaddr(name);
-
-	p = strchr(name, '%');
-	if (p)
-		*p = '\0';
-
-	dpp = dnptrs;
-	lastdnptr = &dnptrs[ARRAY_SIZE(dnptrs)];
-
-	*dpp++ = (unsigned char *)buf;
-	*dpp++ = NULL;
-
-	n = dn_comp(name, (unsigned char *)buf, buflen, dnptrs, lastdnptr);
-	if (n < 0) {
-		fprintf(stderr, "ping6: Inappropriate subject name: %s\n", buf);
-		free(name);
-		free(buf);
-		exit(1);
-	}
-
-	if (fqdn < 0)
-		buf[n] = 0;
-
-	free(ni_subject);
-	ni_subject = buf;
-	ni_subject_len = n + (fqdn < 0);
-
-	free(name);
-	return 0;
 }
 
 int niquery_option_handler(const char *opt_arg)
