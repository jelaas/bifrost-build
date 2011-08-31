--- lxc-0.6.3/src/lxc/namespace.h~	2009-07-07 22:53:05.000000000 +0200
+++ lxc-0.6.3/src/lxc/namespace.h	2009-09-10 18:18:48.877815445 +0200
@@ -20,6 +20,9 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
+
+#include <sys/types.h>
+
 #ifndef __namespace_h
 #define __namespace_h
 
