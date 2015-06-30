--- net-next-2.6/mm/slub.c.orig	2011-05-14 08:44:28.464766135 +0200
+++ net-next-2.6/mm/slub.c	2011-05-14 08:44:48.859766135 +0200
@@ -2204,7 +2204,7 @@
  * Merge control. If this is set then no merging of slab caches will occur.
  * (Could be removed. This was introduced to pacify the merge skeptics.)
  */
-static int slub_nomerge;
+static int slub_nomerge = 1;
 
 /*
  * Calculate the order of allocation given an slab object size.
