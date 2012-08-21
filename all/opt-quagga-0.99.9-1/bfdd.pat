--- bfdd/bfdd.c~	Mon Aug 20 13:04:09 2012
+++ bfdd/bfdd.c	Mon Aug 20 13:18:20 2012
@@ -526,8 +526,9 @@
 bfd_neightbl_ldisc_add (struct bfd_neigh *neighp)
 {
   struct bfd_neigh *find;
+  int i;
 
-  for (int i = 0; i < BFD_NEIGH_MAX; i++)
+  for (i = 0; i < BFD_NEIGH_MAX; i++)
     if ((find = (struct bfd_neigh *) hash_lookup (neightbl->ldisc, neighp)))
       {
 	neighp->ldisc = bfd_get_mydisc ();
