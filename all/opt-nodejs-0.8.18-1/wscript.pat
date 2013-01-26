--- wscript~	Mon Sep  5 08:33:58 2011
+++ wscript	Mon Sep  5 16:07:51 2011
@@ -429,7 +429,7 @@
     conf.env.append_value ('CXXFLAGS', '-threads')
     #conf.env.append_value ('LINKFLAGS', ' -threads')
   elif not sys.platform.startswith("cygwin") and not sys.platform.startswith("win32"):
-    threadflags='-pthread'
+    threadflags='-lpthread'
     conf.env.append_value ('CCFLAGS', threadflags)
     conf.env.append_value ('CXXFLAGS', threadflags)
     conf.env.append_value ('LINKFLAGS', threadflags)
