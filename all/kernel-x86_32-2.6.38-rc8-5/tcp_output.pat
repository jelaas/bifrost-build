From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
Date: Sat, 2 Apr 2011 04:47:41 +0000 (-0700)
Subject: tcp: len check is unnecessarily devastating, change to WARN_ON
X-Git-Tag: v2.6.39-rc2~7^2~2
X-Git-Url: http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git;a=commitdiff_plain;h=2fceec13375e5d98

tcp: len check is unnecessarily devastating, change to WARN_ON

All callers are prepared for alloc failures anyway, so this error
can safely be boomeranged to the callers domain without super
bad consequences. ...At worst the connection might go into a state
where each RTO tries to (unsuccessfully) re-fragment with such
a mis-sized value and eventually dies.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dfa5beb..8b0d016 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1003,7 +1003,8 @@ int tcp_fragment(struct sock *sk, struct sk_buff *skb, u32 len,
 	int nlen;
 	u8 flags;
 
-	BUG_ON(len > skb->len);
+	if (WARN_ON(len > skb->len))
+		return -EINVAL;
 
 	nsize = skb_headlen(skb) - len;
 	if (nsize < 0)
