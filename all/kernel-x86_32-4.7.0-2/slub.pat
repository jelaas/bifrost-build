--- mm/slub.c.orig	Wed Mar 16 12:17:15 2016
+++ mm/slub.c	Wed Mar 16 12:20:07 2016
@@ -3054,7 +3054,7 @@
 	 */
 	min_objects = slub_min_objects;
 	if (!min_objects)
-		min_objects = 4 * (fls(nr_cpu_ids) + 1);
+		min_objects = 16 * (fls(nr_cpu_ids) + 1);
 	max_objects = order_objects(slub_max_order, size, reserved);
 	min_objects = min(min_objects, max_objects);
 
