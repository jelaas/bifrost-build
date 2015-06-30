--- isisd/include-netbsd/iso.h~	Tue Jun 24 07:14:20 2014
+++ isisd/include-netbsd/iso.h	Mon Jul 14 13:32:35 2014
@@ -196,8 +196,6 @@
 #define	__P(x)	x
 #define	__BEGIN_DECLS
 #define	__END_DECLS
-#else
-#include <sys/cdefs.h>
 #endif
 
 __BEGIN_DECLS
--- lib/queue.h~	Tue Jun 24 07:14:20 2014
+++ lib/queue.h	Mon Jul 14 13:30:12 2014
@@ -33,8 +33,6 @@
 #ifndef _SYS_QUEUE_H_
 #define	_SYS_QUEUE_H_
 
-#include <sys/cdefs.h>
-
 /*
  * This file defines four types of data structures: singly-linked lists,
  * singly-linked tail queues, lists and tail queues.
