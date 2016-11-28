diff --git a/extensions/libxt_connlabel.c b/extensions/libxt_connlabel.c
--- a/extensions/libxt_connlabel.c
+++ b/extensions/libxt_connlabel.c
@@ -29,11 +29,26 @@ static const struct xt_option_entry connlabel_mt_opts[] = {
 	XTOPT_TABLEEND,
 };
 
+/* cannot do this via _init, else static builds might spew error message
+ * for every iptables invocation.
+ */
+static void connlabel_open(void)
+{
+	if (map)
+		return;
+
+	map = nfct_labelmap_new(NULL);
+	if (!map && errno)
+		xtables_error(RESOURCE_PROBLEM, "cannot open connlabel.conf: %s\n",
+			strerror(errno));
+}
+
 static void connlabel_mt_parse(struct xt_option_call *cb)
 {
 	struct xt_connlabel_mtinfo *info = cb->data;
 	int tmp;
 
+	connlabel_open();
 	xtables_option_parse(cb);
 
 	switch (cb->entry->id) {
@@ -54,7 +69,11 @@ static void connlabel_mt_parse(struct xt_option_call *cb)
 
 static const char *connlabel_get_name(int b)
 {
-	const char *name = nfct_labelmap_get_name(map, b);
+	const char *name;
+
+	connlabel_open();
+
+	name = nfct_labelmap_get_name(map, b);
 	if (name && strcmp(name, ""))
 		return name;
 	return NULL;
@@ -114,11 +133,5 @@ static struct xtables_match connlabel_mt_reg = {
 
 void _init(void)
 {
-	map = nfct_labelmap_new(NULL);
-	if (!map) {
-		fprintf(stderr, "cannot open connlabel.conf, not registering '%s' match: %s\n",
-			connlabel_mt_reg.name, strerror(errno));
-		return;
-	}
 	xtables_register_match(&connlabel_mt_reg);
 }
