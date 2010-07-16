--- yellow.c.orig	2010-07-16 13:51:29.783965653 +0200
+++ yellow.c	2010-07-16 13:59:16.751963358 +0200
@@ -41,21 +41,19 @@
 static char *cpulist(char *prefix, unsigned *cpumask, unsigned cpumasklen)
 {
 	unsigned i, k;
-	char *buf = NULL;
+	char buf[1024], str[12];
 	size_t size = 0;
-	FILE *f = open_memstream(&buf, &size);
-	if (!f)
-		Enomem();
-	fprintf(f, "%s", prefix);
+	
+	sprintf(buf, "%s", prefix);
 	k = 0;
 	for (i = 0; i < cpumasklen * 8; i++) {
 		if (test_bit(i, cpumask)) {
-			fprintf(f, "%s%u", k > 0 ? " " : "", i);
+			sprintf(str, "%s%u", k > 0 ? " " : "", i);
+			strcat(buf, str);
 			k++;
 		}
 	}
-	fclose(f);
-	return buf;
+	return strdup(buf);
 }
 
 void run_yellow_trigger(int cpu, int tnum, int lnum, char *ts, char *ls, int socket)
--- mcelog.c.orig	2010-07-16 13:53:25.670961696 +0200
+++ mcelog.c	2010-07-16 13:55:00.146960865 +0200
@@ -867,11 +867,6 @@
 		syslog_level = LOG_ERR;
 		syslog_opt = SYSLOG_ALL|SYSLOG_FORCE;
 		break;
-	case O_DAEMON:
-		daemon_mode = 1;
-		if (!(syslog_opt & SYSLOG_FORCE))
-			syslog_opt = SYSLOG_ALL;
-		break;
 	case O_FILE:
 		inputfile = optarg;
 		break;
@@ -1101,23 +1096,7 @@
 		err("MCE_GET_LOG_LEN");
 
 	d.buf = xalloc(d.recordlen * d.loglen); 
-	if (daemon_mode) {
-		check_cpu();
-		prefill_memdb();
-		if (!do_dmi)
-			closedmi();
-		server_setup();
-		page_setup();
-		drop_cred();
-		register_pollcb(fd, POLLIN, process_mcefd, &d);
-		if (!foreground && daemon(0, need_stdout()) < 0)
-			err("daemon");
-		if (pidfile)
-			write_pidfile();
-		eventloop();
-	} else {
-		process(fd, d.recordlen, d.loglen, d.buf);
-	}
+	process(fd, d.recordlen, d.loglen, d.buf);
 	trigger_wait();
 		
 	exit(0); 
