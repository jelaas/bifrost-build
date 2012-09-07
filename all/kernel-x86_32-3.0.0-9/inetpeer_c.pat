                                                                                                                                                                                                                                                               
Delivered-To: jelaas@gmail.com
Received: by 10.229.79.21 with SMTP id n21cs93375qck;
        Tue, 24 May 2011 19:45:15 -0700 (PDT)
Received: by 10.42.221.3 with SMTP id ia3mr11847922icb.181.1306291504823;
        Tue, 24 May 2011 19:45:04 -0700 (PDT)
Return-Path: <netdev-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
        by mx.google.com with ESMTP id lk8si2362355icb.61.2011.05.24.19.44.42;
        Tue, 24 May 2011 19:45:04 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of netdev-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) client-ip=209.132.180.67;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of netdev-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mail=netdev-owner@vger.kernel.org; dkim=neutral (body hash did not verify) header.i=@gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab1EYCog (ORCPT <rfc822;vishwakarma.deepak@gmail.com>
	+ 99 others); Tue, 24 May 2011 22:44:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42486 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab1EYCof (ORCPT
	<rfc822;netdev@vger.kernel.org>); Tue, 24 May 2011 22:44:35 -0400
Received: by wya21 with SMTP id 21so5446417wya.19
        for <multiple recipients>; Tue, 24 May 2011 19:44:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=x5g2HvI4LRvO32ngUQ/dz0OXri7gAYIzZEMq5IP6juU=;
        b=M8uJ9vjP84Y/qPAHknysZvn1+SOzT/ZJ/fgRvbIy+M1pMFlIYOlzN5YsE08UVGjUFr
         wJ+lhXHNOMHGngCXXqi9gsTUcyQ/X5gIqNdaQg2LyblezW9VytZijxCZZp79jwoN7BDQ
         Y4d8itaW3zSPqfjvpG4rc4UGXLZIKtcg0+zRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=T+MdLKdCl6UZEqtLUiLISSUTt/vje0UJdhWjJ1tqks0+oNGC64tZWDzCkrJn6PMvrb
         C0J1hTR4NGbHuywpF5GIr0f5DDviq389s6M5Vv7cSXsVQI6mZeB7v0E0mF+q46P0HeRl
         wXDdNlz6mI58fwDqXIrAADorV9hSgdpfoaxs0=
Received: by 10.227.11.137 with SMTP id t9mr4050723wbt.32.1306291474309;
        Tue, 24 May 2011 19:44:34 -0700 (PDT)
Received: from [10.150.51.210] (gw0.net.jmsp.net [212.23.165.14])
        by mx.google.com with ESMTPS id ex2sm66430wbb.39.2011.05.24.19.44.31
        (version=SSLv3 cipher=OTHER);
        Tue, 24 May 2011 19:44:32 -0700 (PDT)
Subject: Re: Kernel crash after using new Intel NIC (igb)
From:	Eric Dumazet <eric.dumazet@gmail.com>
To:	Arun Sharma <asharma@fb.com>
Cc:	Maximilian Engelhardt <maxi@daemonizer.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	StuStaNet Vorstand <vorstand@stusta.mhn.de>
In-Reply-To: <20110524213327.GA3917@dev1756.snc6.facebook.com>
References: <201104250033.03401.maxi@daemonizer.de>
	 <1303878240.2699.41.camel@edumazet-laptop>
	 <1303878771.2699.44.camel@edumazet-laptop>
	 <201104271352.00601.maxi@daemonizer.de>
	 <20110512211033.GA3468@dev1756.snc6.facebook.com>
	 <1305234953.2831.2.camel@edumazet-laptop>
	 <20110524213327.GA3917@dev1756.snc6.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Date:	Wed, 25 May 2011 04:44:29 +0200
Message-ID: <1306291469.3305.11.camel@edumazet-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 8bit
Sender:	netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List:	netdev@vger.kernel.org

Le mardi 24 mai 2011 à 14:33 -0700, Arun Sharma a écrit :
> On Thu, May 12, 2011 at 11:15:53PM +0200, Eric Dumazet wrote:
> > 
> > Probably not.
> > 
> > What gives slub_nomerge=1   for you ?
> > 
> 
> It took me a while to get a new kernel on a large enough sample
> of machines to get some data.
> 
> Like you observed in the other thread, this is unlikely to be a random
> memory corruption.
> 
> The panics stopped after we moved the list_empty() check under the lock.
> 
> --- a/net/ipv4/inetpeer.c
> +++ b/net/ipv4/inetpeer.c
> @@ -154,11 +154,11 @@ void __init inet_initpeers(void)
>  /* Called with or without local BH being disabled. */
>  static void unlink_from_unused(struct inet_peer *p)
>  {
> +	spin_lock_bh(&unused_peers.lock);
>  	if (!list_empty(&p->unused)) {
> -		spin_lock_bh(&unused_peers.lock);
>  		list_del_init(&p->unused);
> -		spin_unlock_bh(&unused_peers.lock);
>  	}
> +	spin_unlock_bh(&unused_peers.lock);
>  }
>  
>  static int addr_compare(const struct inetpeer_addr *a,
> 
> The idea being that the list gets corrupted under some kind of a race
> condition. Two threads racing on list_empty() and executing
> list_del_init() seems harmless.
> 
> There is probably a different race condition that is mitigated by doing
> the list_empty() check under the lock.
> 

Hmm, thanks for the report. Are you running x86 or another arch ?

We probably need some sort of memory barrier.

However, locking this central lock makes the thing too slow, I'll try to
use an atomic_inc_return on p->refcnt instead. (and then lock
unused_peers.lock if we got a 0->1 transition)

I am testing following patch :


diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 9df4e63..43aacbf 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -154,11 +154,9 @@ void __init inet_initpeers(void)
 /* Called with or without local BH being disabled. */
 static void unlink_from_unused(struct inet_peer *p)
 {
-	if (!list_empty(&p->unused)) {
-		spin_lock_bh(&unused_peers.lock);
-		list_del_init(&p->unused);
-		spin_unlock_bh(&unused_peers.lock);
-	}
+	spin_lock_bh(&unused_peers.lock);
+	list_del_init(&p->unused);
+	spin_unlock_bh(&unused_peers.lock);
 }
 
 static int addr_compare(const struct inetpeer_addr *a,
@@ -213,10 +211,11 @@ static int addr_compare(const struct inetpeer_addr *a,
  * We exit from this function if number of links exceeds PEER_MAXDEPTH
  */
 static struct inet_peer *lookup_rcu(const struct inetpeer_addr *daddr,
-				    struct inet_peer_base *base)
+				    struct inet_peer_base *base,
+				    int *newrefcnt)
 {
 	struct inet_peer *u = rcu_dereference(base->root);
-	int count = 0;
+	int old, new, count = 0;
 
 	while (u != peer_avl_empty) {
 		int cmp = addr_compare(daddr, &u->daddr);
@@ -226,8 +225,16 @@ static struct inet_peer *lookup_rcu(const struct inetpeer_addr *daddr,
 			 * distinction between an unused entry (refcnt=0) and
 			 * a freed one.
 			 */
-			if (unlikely(!atomic_add_unless(&u->refcnt, 1, -1)))
-				u = NULL;
+			while (1) {
+				old = atomic_read(&u->refcnt);
+				if (old == -1)
+					return NULL;
+				new = old + 1;
+				if (atomic_cmpxchg(&u->refcnt,
+						   old, new) == old)
+					break;
+			}
+			*newrefcnt = new;
 			return u;
 		}
 		if (cmp == -1)
@@ -465,14 +472,14 @@ struct inet_peer *inet_getpeer(struct inetpeer_addr *daddr, int create)
 	struct inet_peer_base *base = family_to_base(daddr->family);
 	struct inet_peer *p;
 	unsigned int sequence;
-	int invalidated;
+	int invalidated, newrefcnt = 0;
 
 	/* Look up for the address quickly, lockless.
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
 	rcu_read_lock();
 	sequence = read_seqbegin(&base->lock);
-	p = lookup_rcu(daddr, base);
+	p = lookup_rcu(daddr, base, &newrefcnt);
 	invalidated = read_seqretry(&base->lock, sequence);
 	rcu_read_unlock();
 
@@ -480,7 +487,8 @@ struct inet_peer *inet_getpeer(struct inetpeer_addr *daddr, int create)
 		/* The existing node has been found.
 		 * Remove the entry from unused list if it was there.
 		 */
-		unlink_from_unused(p);
+		if (newrefcnt == 1)
+			unlink_from_unused(p);
 		return p;
 	}
 
@@ -494,10 +502,11 @@ struct inet_peer *inet_getpeer(struct inetpeer_addr *daddr, int create)
 	write_seqlock_bh(&base->lock);
 	p = lookup(daddr, stack, base);
 	if (p != peer_avl_empty) {
-		atomic_inc(&p->refcnt);
+		newrefcnt = atomic_inc_return(&p->refcnt);
 		write_sequnlock_bh(&base->lock);
 		/* Remove the entry from unused list if it was there. */
-		unlink_from_unused(p);
+		if (newrefcnt == 1)
+			unlink_from_unused(p);
 		return p;
 	}
 	p = create ? kmem_cache_alloc(peer_cachep, GFP_ATOMIC) : NULL;


--
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
