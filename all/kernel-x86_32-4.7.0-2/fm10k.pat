From: Jacob Keller <jacob.e.keller@intel.com>

The index calculated when looping through the indir array passed to
fm10k_write_reta was incorrectly calculated as the first part i needs to
be multiplied by 4.

Fixes: 0cfea7a65738 ("fm10k: fix possible null pointer deref after kcalloc", 2016-04-13)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 9c0d875..9b51954 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -983,9 +983,10 @@ void fm10k_write_reta(struct fm10k_intfc *interface, const u32 *indir)
 		/* generate a new table if we weren't given one */
 		for (j = 0; j < 4; j++) {
 			if (indir)
-				n = indir[i + j];
+				n = indir[4 * i + j];
 			else
-				n = ethtool_rxfh_indir_default(i + j, rss_i);
+				n = ethtool_rxfh_indir_default(4 * i + j,
+							       rss_i);
 
 			table[j] = n;
 		}
-- 
