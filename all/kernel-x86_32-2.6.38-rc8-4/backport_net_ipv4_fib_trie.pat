From: Julian Anastasov <ja@ssi.bg>
Date: Sat, 26 Mar 2011 03:33:23 +0000 (-0700)
Subject: ipv4: do not ignore route errors
X-Git-Url: http://git2.kernel.org/?p=linux%2Fkernel%2Fgit%2Fdavem%2Fnet-2.6.git;a=commitdiff_plain;h=1fbc78439291627642517f15b9b91f3125588143

ipv4: do not ignore route errors

	The "ipv4: Inline fib_semantic_match into check_leaf"
change forgets to return the route errors. check_leaf should
return the same results as fib_table_lookup.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 90a3ff6..b92c86f 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1365,9 +1365,9 @@ static int check_leaf(struct fib_table *tb, struct trie *t, struct leaf *l,
 			err = fib_props[fa->fa_type].error;
 			if (err) {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
-				t->stats.semantic_match_miss++;
+				t->stats.semantic_match_passed++;
 #endif
-				return 1;
+				return err;
 			}
 			if (fi->fib_flags & RTNH_F_DEAD)
 				continue;
