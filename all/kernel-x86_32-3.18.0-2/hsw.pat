commit 5306c31c5733cb4a79cc002e0c3ad256fd439614
Author: Andi Kleen <ak@linux.intel.com>
Date:   Tue Jan 6 14:34:35 2015 -0800

    perf/x86/uncore/hsw-ep: Handle systems with only two SBOXes
    
    There was another report of a boot failure with a #GP fault in the
    uncore SBOX initialization. The earlier work around was not enough
    for this system.
    
    The boot was failing while trying to initialize the third SBOX.
    
    This patch detects parts with only two SBOXes and limits the number
    of SBOX units to two there.
    
    Stable material, as it affects boot problems on 3.18.
    
    Tested-by: Andreas Oehler <andreas@oehler-net.de>
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: <stable@vger.kernel.org>
    Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Yan, Zheng <zheng.z.yan@intel.com>
    Link: http://lkml.kernel.org/r/1420583675-9163-1-git-send-email-andi@firstfloor.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore.h b/arch/x86/kernel/cpu/perf_event_intel_uncore.h
index 18eb78b..863d9b0 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_uncore.h
+++ b/arch/x86/kernel/cpu/perf_event_intel_uncore.h
@@ -17,7 +17,7 @@
 #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
 #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
 #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	2
+#define UNCORE_EXTRA_PCI_DEV_MAX	3
 
 /* support up to 8 sockets */
 #define UNCORE_SOCKET_MAX		8
diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c b/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c
index 745b158..21af6149e 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c
@@ -891,6 +891,7 @@ void snbep_uncore_cpu_init(void)
 enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
+	HSWEP_PCI_PCU_3,
 };
 
 static int snbep_qpi_hw_config(struct intel_uncore_box *box, struct perf_event *event)
@@ -2026,6 +2027,17 @@ void hswep_uncore_cpu_init(void)
 {
 	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+
+	/* Detect 6-8 core systems with only two SBOXes */
+	if (uncore_extra_pci_dev[0][HSWEP_PCI_PCU_3]) {
+		u32 capid4;
+
+		pci_read_config_dword(uncore_extra_pci_dev[0][HSWEP_PCI_PCU_3],
+				      0x94, &capid4);
+		if (((capid4 >> 6) & 0x3) == 0)
+			hswep_uncore_sbox.num_boxes = 2;
+	}
+
 	uncore_msr_uncores = hswep_msr_uncores;
 }
 
@@ -2287,6 +2299,11 @@ static DEFINE_PCI_DEVICE_TABLE(hswep_uncore_pci_ids) = {
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
 						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
+	{ /* PCU.3 (for Capability registers) */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fc0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   HSWEP_PCI_PCU_3),
+	},
 	{ /* end: all zeroes */ }
 };
 
