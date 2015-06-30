--- libavformat/mux.c.orig	Tue Oct 29 18:39:18 2013
+++ libavformat/mux.c	Tue Oct 29 18:39:57 2013
@@ -457,9 +457,9 @@
 
     if (st->cur_dts && st->cur_dts != AV_NOPTS_VALUE &&
         ((!(s->oformat->flags & AVFMT_TS_NONSTRICT) &&
-          st->cur_dts >= pkt->dts) || st->cur_dts > pkt->dts)) {
+          st->cur_dts > pkt->dts) || st->cur_dts > pkt->dts)) {
         av_log(s, AV_LOG_ERROR,
-               "Application provided invalid, non monotonically increasing dts to muxer in stream %d: %s >= %s\n",
+               "Application provided invalid, non monotonically increasing dts to muxer in stream %d: %s > %s\n",
                st->index, av_ts2str(st->cur_dts), av_ts2str(pkt->dts));
         return AVERROR(EINVAL);
     }
