--- libavformat/movenc.c.orig	2015-01-20 14:41:08.000000000 +0100
+++ libavformat/movenc.c	2015-01-20 14:41:41.000000000 +0100
@@ -5160,7 +5160,7 @@
     .write_header      = mov_write_header,
     .write_packet      = mov_write_packet,
     .write_trailer     = mov_write_trailer,
-    .flags             = AVFMT_GLOBALHEADER | AVFMT_ALLOW_FLUSH | AVFMT_TS_NEGATIVE,
+    .flags             = AVFMT_GLOBALHEADER | AVFMT_ALLOW_FLUSH | AVFMT_TS_NEGATIVE | AVFMT_TS_NONSTRICT,
     .codec_tag         = (const AVCodecTag* const []){ ff_mp4_obj_type, 0 },
     .priv_class        = &mp4_muxer_class,
 };
