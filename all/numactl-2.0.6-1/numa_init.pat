--- memhog.c.orig	Wed Jan 26 11:42:02 2011
+++ memhog.c	Wed Jan 26 11:42:12 2011
@@ -67,6 +67,8 @@
 	int i;
 	int fd = -1;
 
+	numa_init();
+
 	nodes = numa_allocate_nodemask();
 	gnodes = numa_allocate_nodemask();
 
--- migratepages.c.orig	Wed Jan 26 11:40:12 2011
+++ migratepages.c	Wed Jan 26 11:40:30 2011
@@ -65,6 +65,8 @@
 	struct bitmask *fromnodes;
 	struct bitmask *tonodes;
 
+	numa_init();
+
 	while ((c = getopt_long(argc,argv,"h", opts, NULL)) != -1) {
 		switch (c) {
 		default:
--- migspeed.c.orig	Wed Jan 26 11:41:41 2011
+++ migspeed.c	Wed Jan 26 11:41:53 2011
@@ -72,6 +72,8 @@
 	struct bitmask *from;
 	struct bitmask *to;
 
+	numa_init();
+
 	pagesize = getpagesize();
 
 	/* Command line processing */
--- numactl.c.orig	Wed Jan 26 11:38:42 2011
+++ numactl.c	Wed Jan 26 11:39:25 2011
@@ -364,6 +364,8 @@
 	char shortopts[array_len(opts)*2 + 1];
 	struct bitmask *mask = NULL;
 
+	numa_init();
+
 	get_short_opts(opts,shortopts);
 	while ((c = getopt_long(ac, av, shortopts, opts, NULL)) != -1) {
 		switch (c) {
