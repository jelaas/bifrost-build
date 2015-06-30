--- lib/fuse.c.orig	Thu May  3 10:34:23 2012
+++ lib/fuse.c	Thu May  3 10:35:38 2012
@@ -2537,8 +2537,6 @@
 	fuse_get_context()->private_data = fs->user_data;
 	if (fs->op.destroy)
 		fs->op.destroy(fs->user_data);
-	if (fs->m)
-		fuse_put_module(fs->m);
 	free(fs);
 }
 
@@ -4542,21 +4540,6 @@
 	if (fuse_opt_parse(args, &f->conf, fuse_lib_opts,
 			   fuse_lib_opt_proc) == -1)
 		goto out_free_fs;
-
-	if (f->conf.modules) {
-		char *module;
-		char *next;
-
-		for (module = f->conf.modules; module; module = next) {
-			char *p;
-			for (p = module; *p && *p != ':'; p++);
-			next = *p ? p + 1 : NULL;
-			*p = '\0';
-			if (module[0] &&
-			    fuse_push_module(f, module, args) == -1)
-				goto out_free_fs;
-		}
-	}
 
 	if (!f->conf.ac_attr_timeout_set)
 		f->conf.ac_attr_timeout = f->conf.attr_timeout;
