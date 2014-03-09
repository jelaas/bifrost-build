--- libc/sysdeps/linux/common/epoll.c.orig	Fri Sep 16 17:32:58 2011
+++ libc/sysdeps/linux/common/epoll.c	Fri Sep 16 17:34:23 2011
@@ -67,12 +67,13 @@
 int __libc_epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
 						int timeout, const sigset_t *set)
 {
+	int nsig = _NSIG / 8;
 	if (SINGLE_THREAD_P)
-		return INLINE_SYSCALL(epoll_pwait, 6, epfd, events, maxevents, timeout, set, _NSIG / 8);
+		return INLINE_SYSCALL(epoll_pwait, 6, epfd, events, maxevents, timeout, set, nsig);
 # ifdef __UCLIBC_HAS_THREADS_NATIVE__
 	else {
 		int oldtype = LIBC_CANCEL_ASYNC ();
-		int result = INLINE_SYSCALL(epoll_pwait, 6, epfd, events, maxevents, timeout, set, _NSIG / 8);
+		int result = INLINE_SYSCALL(epoll_pwait, 6, epfd, events, maxevents, timeout, set, nsig);
 		LIBC_CANCEL_RESET (oldtype);
 		return result;
 	}
