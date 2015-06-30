X-Git-Url: http://git2.kernel.org/?p=linux%2Fkernel%2Fgit%2Fdavem%2Fnet-2.6.git;a=blobdiff_plain;f=net%2Fipv4%2Fraw.c;h=2d3c72e5bbbf054b16f88d50b606d22673f1e5b5;hp=e837ffd3edc3dd0f9b2d9d03d82489b1464146c2;hb=4910ac6c526d2868adcb5893e0c428473de862b5;hpb=673e63c688f43104c73aad8ea4237f7ad41fa14d

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e837ffd..2d3c72e 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -569,6 +569,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
 		rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
+			rt = NULL;
 			goto done;
 		}
 	}
