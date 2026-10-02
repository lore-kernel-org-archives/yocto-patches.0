Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE4CA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:13:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11783.1790946818147980480
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 06:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=QRDBkK7Q;
 spf=pass (domain: intel.com, ip: 198.175.65.21, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946818; x=1822482818;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tthC1aTf5wAQFLZ9oCSQ4S/ACVmJnImappBAqmsbi2s=;
  b=QRDBkK7Qx44JOktSRxCX8sZmK906HVPnC6n/LTGkI4ZdPbuGEX8GjCJ8
   7/+Be8xR8T6r6preg6YH1/2s8JGGn6enJ94bi3O6Olcjw2FGj1DrjIFEn
   SoE9DEYLdpxvBw1VBTRQpx4RRqYEkAoOGbExYbWS1O1ODye+Dl0Ml8+u6
   PcO3Avlw0GfvyIvIAB33DeNwI/bYqwDeiqad8o+YvPERb4lgh9pG9gi9Q
   7ZyvDrLLp7ryb/X6EXJaxQ1sEFF1S5oXSIvDfDRXAyNZ5KJ3SwBBtPgUg
   TzoGlIlw3HeuptOFw67PHtbAOIJaReUPXxxquF4wv8qzxIW/SpKFzLBYu
   w==;
X-CSE-ConnectionGUID: 2BZBrOq7Qa2LoviQBbqkPg==
X-CSE-MsgGUID: yfuBE7gORNa3sMjV54KimA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90570604"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90570604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:13:38 -0700
X-CSE-ConnectionGUID: zwqWwy4DSwSmsd+bPlFtgw==
X-CSE-MsgGUID: J6LhT7dPSwus3pgy/vkEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280986555"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa004.fm.intel.com with ESMTP; 02 Oct 2026 06:13:36 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/2] zephyr-kernel: drop support for 4.3.0
Date: Fri,  2 Oct 2026 21:13:34 +0800
Message-ID: <20261002131335.3541596-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 13:13:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4980

From: Lee Chee Yang <chee.yang.lee@intel.com>

This version is about to EOL soon ( October 15, 2026)
Blacksail release are planned on the same month hence drop this from
blacksail series.

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 ...ry-generation-issue-in-cross-compila.patch |  85 -----
 .../zephyr-kernel/zephyr-kernel-src-4.3.0.inc | 310 ------------------
 .../zephyr-kernel-test-4.3.0.inc              |  66 ----
 3 files changed, 461 deletions(-)
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
deleted file mode 100644
index fe7b7ef..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
+++ /dev/null
@@ -1,85 +0,0 @@
-From 9a2162517de91bf085ed336615c49db06ed8585f Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Wed, 16 Apr 2025 14:51:49 +0800
-Subject: [PATCH] x86: fix efi binary generation issue in cross compilation env
-
-Set root directory for headers.
-
-Upstream-Status: Inappropriate [Cross-compilation specific]
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
-
-Rebase original patch with v4.3.0 directory structure and drop
-up_squared board changes as this is removed from v4.3.0
-
-Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
----
- arch/x86/zefi/zefi.py           | 4 +++-
- boards/intel/adl/CMakeLists.txt | 1 +
- boards/intel/ehl/CMakeLists.txt | 1 +
- boards/intel/rpl/CMakeLists.txt | 1 +
- 4 files changed, 6 insertions(+), 1 deletion(-)
-
-diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
-index b98419f8a49..790797f011a 100755
---- a/arch/x86/zefi/zefi.py
-+++ b/arch/x86/zefi/zefi.py
-@@ -115,8 +115,10 @@ def build_elf(elf_file, include_dirs):
-     includes = []
-     for include_dir in include_dirs:
-         includes.extend(["-I", include_dir])
-+    #  Pass --sysroot path for cross compilation
-+    sysrootarg = "--sysroot=" + args.sysroot
-     cmd = ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + includes +
--           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar",
-+           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar", sysrootarg,
-             "-Wl,-nostdlib", "-nostartfiles", "-T", ldscript, "-o", "zefi.elf", cfile])
-     verbose(" ".join(cmd))
-     subprocess.run(cmd, check = True)
-@@ -156,6 +157,7 @@ def parse_args():
-     parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
-     parser.add_argument("-i", "--includes", required=True, nargs="+",
-                         help="Zephyr base include directories")
-+    parser.add_argument("-s", "--sysroot", required=True, help="Cross compilation --sysroot=path")
- 
-     return parser.parse_args()
- 
-diff --git a/boards/intel/adl/CMakeLists.txt b/boards/intel/adl/CMakeLists.txt
-index 6a250ca315c..867393baac6 100644
---- a/boards/intel/adl/CMakeLists.txt
-+++ b/boards/intel/adl/CMakeLists.txt
-@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
-diff --git a/boards/intel/ehl/CMakeLists.txt b/boards/intel/ehl/CMakeLists.txt
-index 6a250ca315c..867393baac6 100644
---- a/boards/intel/ehl/CMakeLists.txt
-+++ b/boards/intel/ehl/CMakeLists.txt
-@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
-diff --git a/boards/intel/rpl/CMakeLists.txt b/boards/intel/rpl/CMakeLists.txt
-index 6a250ca315c..867393baac6 100644
---- a/boards/intel/rpl/CMakeLists.txt
-+++ b/boards/intel/rpl/CMakeLists.txt
-@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
--- 
-2.34.1
-
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc
deleted file mode 100644
index 3352986..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc
+++ /dev/null
@@ -1,310 +0,0 @@
-# Auto-generated from zephyr-kernel-src.inc.jinja
-
-SRCREV_FORMAT = "default"
-
-SRCREV_default = "3568e1b6d5cdd51a6b964a2a1d6d29200fea2056"
-SRCREV_acpica = "8d24867bc9c9d81c81eeac59391cda59333affd4"
-SRCREV_babblesim_base = "2cfac3dca2071452ae481d115d8541880568753d"
-SRCREV_babblesim_ext_2G4_channel_NtNcable = "20a38c997f507b0aa53817aab3d73a462fff7af1"
-SRCREV_babblesim_ext_2G4_channel_multiatt = "bde72a57384dde7a4310bcf3843469401be93074"
-SRCREV_babblesim_ext_2G4_device_WLAN_actmod = "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
-SRCREV_babblesim_ext_2G4_device_burst_interferer = "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
-SRCREV_babblesim_ext_2G4_device_playback = "abb48cd71ddd4e2a9022f4bf49b2712524c483e8"
-SRCREV_babblesim_ext_2G4_libPhyComv1 = "e18e41e8e3fa9f996559ed98b9238a5702dcdd36"
-SRCREV_babblesim_ext_2G4_modem_BLE_simple = "4d2379de510684cd4b1c3bbbb09bce7b5a20bc1f"
-SRCREV_babblesim_ext_2G4_modem_magic = "edfcda2d3937a74be0a59d6cd47e0f50183453da"
-SRCREV_babblesim_ext_2G4_phy_v1 = "8964ed1eb94606c2ea555340907bdc5171793e65"
-SRCREV_babblesim_ext_libCryptov1 = "da246018ebe031e4fe4a8228187fb459e9f3b2fa"
-SRCREV_bsim = "2ba22a0608ad9f46da1b96ee5121af357053c791"
-SRCREV_cmsis = "512cc7e895e8491696b61f7ba8066b4a182569b8"
-SRCREV_cmsis-dsp = "97512610ec92058f0119450b9e743eeb7e95b5c8"
-SRCREV_cmsis-nn = "e9328d612ea3ea7d0d210d3ac16ea8667c01abdd"
-SRCREV_cmsis_6 = "30a859f44ef8ab4dc8f84b03ed586fd16ccf9d74"
-SRCREV_edtt = "c282625e694f0b53ea53e13231ea6d2f49411768"
-SRCREV_fatfs = "f4ead3bf4a6dab3a07d7b5f5315795c073db568d"
-SRCREV_hal_adi = "eeb155f7382343438114605963ae64436cc53434"
-SRCREV_hal_afbr = "4e1eea7ea283db9d9ce529b0e9f89c0b5c2660e3"
-SRCREV_hal_ambiq = "5efc0228528a8adce5eae0d226fac85d2551eb3b"
-SRCREV_hal_atmel = "065e57c5013051c8b7f2256271349c6942bd9344"
-SRCREV_hal_bouffalolab = "89df8327276755b5935dc4cc2f2f68e27a8dba3d"
-SRCREV_hal_espressif = "af6cfa2e3e7098b596062ab516b80a48a7ba7332"
-SRCREV_hal_ethos_u = "fd5d5b7b36b209f2c48635de5d6c9b8dbf0bfff0"
-SRCREV_hal_gigadevice = "ee0e31302c21b2a465dc303b3ced8c606c2167c8"
-SRCREV_hal_infineon = "f3c571f772209b5970bdd1806da641244b5c4c38"
-SRCREV_hal_intel = "82a33b2de29523d9ce572b3d0110a808665cd3ff"
-SRCREV_hal_microchip = "89754d87258945ceb1cff8ecee0ddd8852396ae8"
-SRCREV_hal_nordic = "7858281d843468fe53c829995fb63f45a227387a"
-SRCREV_hal_nuvoton = "9b455fffd6dd3936c5a4eb575e4d33edbcf1b6b0"
-SRCREV_hal_nxp = "6d6ab91d5cc71c872353af1957d19f3d930df0fd"
-SRCREV_hal_openisa = "eabd530a64d71de91d907bad257cd61aacf607bc"
-SRCREV_hal_quicklogic = "bad894440fe72c814864798c8e3a76d13edffb6c"
-SRCREV_hal_renesas = "a279c14e196cb0904593035888a334dcd2c720bd"
-SRCREV_hal_rpi_pico = "09e957522da60581cf7958b31f8e625d969c69a5"
-SRCREV_hal_sifli = "7be421088b6fa2910917f3f8b656ded01e21b4e8"
-SRCREV_hal_silabs = "5d75cba8a1b0e9a747ae387d9ffbb1bf7cd8c529"
-SRCREV_hal_st = "9f81b4427e955885398805b7bca0da3a8cd9109c"
-SRCREV_hal_stm32 = "286dd285b5bb4fddafdfff27b5405264e5a61bfe"
-SRCREV_hal_tdk = "6727477af1e46fa43878102489b9672a9d24e39f"
-SRCREV_hal_telink = "4226c7fc17d5a34e557d026d428fc766191a0800"
-SRCREV_hal_ti = "cc049020152585c4e968b83c084d230234b6d852"
-SRCREV_hal_wch = "6dd313768b5f4cc69baeac4ce6e59f2038eb8ce5"
-SRCREV_hal_wurthelektronik = "7c1297ea071d03289112eb24e789c89c7095c0a2"
-SRCREV_hal_xtensa = "3cc9e3a9360be5c96c956dce84064b85439b6769"
-SRCREV_hostap = "cf05f33f594de6b62840a3b0dd435f10467a2e4c"
-SRCREV_liblc3 = "48bbd3eacd36e99a57317a0a4867002e0b09e183"
-SRCREV_libmctp = "b97860e78998551af99931ece149eeffc538bdb1"
-SRCREV_libmetal = "91d38634d1882f0a2151966f8c5c230ce1c0de7b"
-SRCREV_libsbc = "8e1beda02acb8972e29e6edbb423f7cafe16e445"
-SRCREV_littlefs = "8f5ca347843363882619d8f96c00d8dbd88a8e79"
-SRCREV_lora-basics-modem = "9a14f6772c1d6e303bacb2d594c8063bb804b6ee"
-SRCREV_loramac-node = "fb00b383072518c918e2258b0916c996f2d4eebe"
-SRCREV_lvgl = "b03edc8e6282a963cd312cd0b409eb5ce263ea75"
-SRCREV_mbedtls = "c5b06d89c9c498d8fc8659ce31f7e53137b6270f"
-SRCREV_mcuboot = "96576b341ee19f1c3af6622256b0d4f3d408e1e3"
-SRCREV_mipi-sys-t = "5a9d6055b62edc54566d6d0034d9daec91749b98"
-SRCREV_nanopb = "7307ce399b81ddcb3c3a5dc862c52d4754328d38"
-SRCREV_net-tools = "64d7acc661ae2772282570f21beab85d02f2f35c"
-SRCREV_nrf_hw_models = "26ed181181eed53e400db8f63fa83c566a05d971"
-SRCREV_nrf_wifi = "e269670cd17fb8ccc4b7004544276bc7d9578496"
-SRCREV_open-amp = "c30a6d8b92fcebdb797fc1a7698e8729e250f637"
-SRCREV_openthread = "2bc7712f57af22058770d1ef131ad3da79a0c764"
-SRCREV_percepio = "132ed87d617578a6cb70a2443f43e117c315e0f0"
-SRCREV_picolibc = "ca8b6ebba5226a75545e57a140443168a26ba664"
-SRCREV_segger = "9f08435a79d41133d7046b7c59d1b25929eda450"
-SRCREV_trusted-firmware-a = "0a29cac8fe0f7bdb835b469d9ea11b8e17377a92"
-SRCREV_trusted-firmware-m = "04aa7243e04946b5422b124bea9c0675ab6b120f"
-SRCREV_uoscore-uedhoc = "54abc109c9c0adfd53c70077744c14e454f04f4a"
-SRCREV_zcbor = "9b07780aca6fb21f82a241ba386ad9b379809337"
-
-SRC_URI_ZEPHYR ?= "git://github.com/zephyrproject-rtos/zephyr.git;protocol=https"
-SRC_URI_ZEPHYR_ACPICA ?= "git://github.com/zephyrproject-rtos/acpica;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_BASE ?= "git://github.com/BabbleSim/base;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?= "git://github.com/BabbleSim/ext_2G4_channel_NtNcable;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?= "git://github.com/BabbleSim/ext_2G4_channel_multiatt;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?= "git://github.com/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?= "git://github.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?= "git://github.com/BabbleSim/ext_2G4_device_playback;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?= "git://github.com/BabbleSim/ext_2G4_libPhyComv1;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?= "git://github.com/BabbleSim/ext_2G4_modem_BLE_simple;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?= "git://github.com/BabbleSim/ext_2G4_modem_magic;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?= "git://github.com/BabbleSim/ext_2G4_phy_v1;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?= "git://github.com/BabbleSim/ext_libCryptov1;protocol=https"
-SRC_URI_ZEPHYR_BSIM ?= "git://github.com/zephyrproject-rtos/babblesim-manifest;protocol=https"
-SRC_URI_ZEPHYR_CMSIS ?= "git://github.com/zephyrproject-rtos/cmsis;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_DSP ?= "git://github.com/zephyrproject-rtos/cmsis-dsp;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_NN ?= "git://github.com/zephyrproject-rtos/cmsis-nn;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_6 ?= "git://github.com/zephyrproject-rtos/CMSIS_6;protocol=https"
-SRC_URI_ZEPHYR_EDTT ?= "git://github.com/zephyrproject-rtos/edtt;protocol=https"
-SRC_URI_ZEPHYR_FATFS ?= "git://github.com/zephyrproject-rtos/fatfs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ADI ?= "git://github.com/zephyrproject-rtos/hal_adi;protocol=https"
-SRC_URI_ZEPHYR_HAL_AFBR ?= "git://github.com/zephyrproject-rtos/hal_afbr;protocol=https"
-SRC_URI_ZEPHYR_HAL_AMBIQ ?= "git://github.com/zephyrproject-rtos/hal_ambiq;protocol=https"
-SRC_URI_ZEPHYR_HAL_ATMEL ?= "git://github.com/zephyrproject-rtos/hal_atmel;protocol=https"
-SRC_URI_ZEPHYR_HAL_BOUFFALOLAB ?= "git://github.com/zephyrproject-rtos/hal_bouffalolab;protocol=https"
-SRC_URI_ZEPHYR_HAL_ESPRESSIF ?= "git://github.com/zephyrproject-rtos/hal_espressif;protocol=https"
-SRC_URI_ZEPHYR_HAL_ETHOS_U ?= "git://github.com/zephyrproject-rtos/hal_ethos_u;protocol=https"
-SRC_URI_ZEPHYR_HAL_GIGADEVICE ?= "git://github.com/zephyrproject-rtos/hal_gigadevice;protocol=https"
-SRC_URI_ZEPHYR_HAL_INFINEON ?= "git://github.com/zephyrproject-rtos/hal_infineon;protocol=https"
-SRC_URI_ZEPHYR_HAL_INTEL ?= "git://github.com/zephyrproject-rtos/hal_intel;protocol=https"
-SRC_URI_ZEPHYR_HAL_MICROCHIP ?= "git://github.com/zephyrproject-rtos/hal_microchip;protocol=https"
-SRC_URI_ZEPHYR_HAL_NORDIC ?= "git://github.com/zephyrproject-rtos/hal_nordic;protocol=https"
-SRC_URI_ZEPHYR_HAL_NUVOTON ?= "git://github.com/zephyrproject-rtos/hal_nuvoton;protocol=https"
-SRC_URI_ZEPHYR_HAL_NXP ?= "git://github.com/zephyrproject-rtos/hal_nxp;protocol=https"
-SRC_URI_ZEPHYR_HAL_OPENISA ?= "git://github.com/zephyrproject-rtos/hal_openisa;protocol=https"
-SRC_URI_ZEPHYR_HAL_QUICKLOGIC ?= "git://github.com/zephyrproject-rtos/hal_quicklogic;protocol=https"
-SRC_URI_ZEPHYR_HAL_RENESAS ?= "git://github.com/zephyrproject-rtos/hal_renesas;protocol=https"
-SRC_URI_ZEPHYR_HAL_RPI_PICO ?= "git://github.com/zephyrproject-rtos/hal_rpi_pico;protocol=https"
-SRC_URI_ZEPHYR_HAL_SIFLI ?= "git://github.com/zephyrproject-rtos/hal_sifli;protocol=https"
-SRC_URI_ZEPHYR_HAL_SILABS ?= "git://github.com/zephyrproject-rtos/hal_silabs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ST ?= "git://github.com/zephyrproject-rtos/hal_st;protocol=https"
-SRC_URI_ZEPHYR_HAL_STM32 ?= "git://github.com/zephyrproject-rtos/hal_stm32;protocol=https"
-SRC_URI_ZEPHYR_HAL_TDK ?= "git://github.com/zephyrproject-rtos/hal_tdk;protocol=https"
-SRC_URI_ZEPHYR_HAL_TELINK ?= "git://github.com/zephyrproject-rtos/hal_telink;protocol=https"
-SRC_URI_ZEPHYR_HAL_TI ?= "git://github.com/zephyrproject-rtos/hal_ti;protocol=https"
-SRC_URI_ZEPHYR_HAL_WCH ?= "git://github.com/zephyrproject-rtos/hal_wch;protocol=https"
-SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?= "git://github.com/zephyrproject-rtos/hal_wurthelektronik;protocol=https"
-SRC_URI_ZEPHYR_HAL_XTENSA ?= "git://github.com/zephyrproject-rtos/hal_xtensa;protocol=https"
-SRC_URI_ZEPHYR_HOSTAP ?= "git://github.com/zephyrproject-rtos/hostap;protocol=https"
-SRC_URI_ZEPHYR_LIBLC3 ?= "git://github.com/zephyrproject-rtos/liblc3;protocol=https"
-SRC_URI_ZEPHYR_LIBMCTP ?= "git://github.com/zephyrproject-rtos/libmctp;protocol=https"
-SRC_URI_ZEPHYR_LIBMETAL ?= "git://github.com/zephyrproject-rtos/libmetal;protocol=https"
-SRC_URI_ZEPHYR_LIBSBC ?= "git://github.com/zephyrproject-rtos/libsbc;protocol=https"
-SRC_URI_ZEPHYR_LITTLEFS ?= "git://github.com/zephyrproject-rtos/littlefs;protocol=https"
-SRC_URI_ZEPHYR_LORA_BASICS_MODEM ?= "git://github.com/zephyrproject-rtos/lora-basics-modem;protocol=https"
-SRC_URI_ZEPHYR_LORAMAC_NODE ?= "git://github.com/zephyrproject-rtos/loramac-node;protocol=https"
-SRC_URI_ZEPHYR_LVGL ?= "git://github.com/zephyrproject-rtos/lvgl;protocol=https"
-SRC_URI_ZEPHYR_MBEDTLS ?= "git://github.com/zephyrproject-rtos/mbedtls;protocol=https"
-SRC_URI_ZEPHYR_MCUBOOT ?= "git://github.com/zephyrproject-rtos/mcuboot;protocol=https"
-SRC_URI_ZEPHYR_MIPI_SYS_T ?= "git://github.com/zephyrproject-rtos/mipi-sys-t;protocol=https"
-SRC_URI_ZEPHYR_NANOPB ?= "git://github.com/zephyrproject-rtos/nanopb;protocol=https"
-SRC_URI_ZEPHYR_NET_TOOLS ?= "git://github.com/zephyrproject-rtos/net-tools;protocol=https"
-SRC_URI_ZEPHYR_NRF_HW_MODELS ?= "git://github.com/zephyrproject-rtos/nrf_hw_models;protocol=https"
-SRC_URI_ZEPHYR_NRF_WIFI ?= "git://github.com/zephyrproject-rtos/nrf_wifi;protocol=https"
-SRC_URI_ZEPHYR_OPEN_AMP ?= "git://github.com/zephyrproject-rtos/open-amp;protocol=https"
-SRC_URI_ZEPHYR_OPENTHREAD ?= "git://github.com/zephyrproject-rtos/openthread;protocol=https"
-SRC_URI_ZEPHYR_PERCEPIO ?= "git://github.com/zephyrproject-rtos/percepio;protocol=https"
-SRC_URI_ZEPHYR_PICOLIBC ?= "git://github.com/zephyrproject-rtos/picolibc;protocol=https"
-SRC_URI_ZEPHYR_SEGGER ?= "git://github.com/zephyrproject-rtos/segger;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?= "git://github.com/zephyrproject-rtos/trusted-firmware-a;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?= "git://github.com/zephyrproject-rtos/trusted-firmware-m;protocol=https"
-SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?= "git://github.com/zephyrproject-rtos/uoscore-uedhoc;protocol=https"
-SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=https"
-
-SRC_URI_PATCHES ?= "\
-    file://0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
-"
-
-SRC_URI = "\
-    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=${P}/zephyr \
-    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=${P}/modules/lib/acpica \
-    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=${P}/tools/bsim/components \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_NtNcable \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_multiatt \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_WLAN_actmod \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_burst_interferer \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_playback \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_libPhyComv1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_BLE_simple \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_magic \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_phy_v1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_libCryptov1 \
-    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=${P}/tools/bsim \
-    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=${P}/modules/hal/cmsis \
-    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=${P}/modules/lib/cmsis-dsp \
-    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=${P}/modules/lib/cmsis-nn \
-    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=${P}/modules/hal/cmsis_6 \
-    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=${P}/tools/edtt \
-    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=${P}/modules/fs/fatfs \
-    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=${P}/modules/hal/adi \
-    ${SRC_URI_ZEPHYR_HAL_AFBR};name=hal_afbr;nobranch=1;destsuffix=${P}/modules/hal/afbr \
-    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=${P}/modules/hal/ambiq \
-    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=${P}/modules/hal/atmel \
-    ${SRC_URI_ZEPHYR_HAL_BOUFFALOLAB};name=hal_bouffalolab;nobranch=1;destsuffix=${P}/modules/hal/bouffalolab \
-    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=hal_espressif;nobranch=1;destsuffix=${P}/modules/hal/espressif \
-    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=hal_ethos_u;nobranch=1;destsuffix=${P}/modules/hal/ethos_u \
-    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=hal_gigadevice;nobranch=1;destsuffix=${P}/modules/hal/gigadevice \
-    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=hal_infineon;nobranch=1;destsuffix=${P}/modules/hal/infineon \
-    ${SRC_URI_ZEPHYR_HAL_INTEL};name=hal_intel;nobranch=1;destsuffix=${P}/modules/hal/intel \
-    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=hal_microchip;nobranch=1;destsuffix=${P}/modules/hal/microchip \
-    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=hal_nordic;nobranch=1;destsuffix=${P}/modules/hal/nordic \
-    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=hal_nuvoton;nobranch=1;destsuffix=${P}/modules/hal/nuvoton \
-    ${SRC_URI_ZEPHYR_HAL_NXP};name=hal_nxp;nobranch=1;destsuffix=${P}/modules/hal/nxp \
-    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=hal_openisa;nobranch=1;destsuffix=${P}/modules/hal/openisa \
-    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=hal_quicklogic;nobranch=1;destsuffix=${P}/modules/hal/quicklogic \
-    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=${P}/modules/hal/renesas \
-    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=${P}/modules/hal/rpi_pico \
-    ${SRC_URI_ZEPHYR_HAL_SIFLI};name=hal_sifli;nobranch=1;destsuffix=${P}/modules/hal/sifli \
-    ${SRC_URI_ZEPHYR_HAL_SILABS};name=hal_silabs;nobranch=1;destsuffix=${P}/modules/hal/silabs \
-    ${SRC_URI_ZEPHYR_HAL_ST};name=hal_st;nobranch=1;destsuffix=${P}/modules/hal/st \
-    ${SRC_URI_ZEPHYR_HAL_STM32};name=hal_stm32;nobranch=1;destsuffix=${P}/modules/hal/stm32 \
-    ${SRC_URI_ZEPHYR_HAL_TDK};name=hal_tdk;nobranch=1;destsuffix=${P}/modules/hal/tdk \
-    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=${P}/modules/hal/telink \
-    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=${P}/modules/hal/ti \
-    ${SRC_URI_ZEPHYR_HAL_WCH};name=hal_wch;nobranch=1;destsuffix=${P}/modules/hal/wch \
-    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=${P}/modules/hal/wurthelektronik \
-    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=${P}/modules/hal/xtensa \
-    ${SRC_URI_ZEPHYR_HOSTAP};name=hostap;nobranch=1;destsuffix=${P}/modules/lib/hostap \
-    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=${P}/modules/lib/liblc3 \
-    ${SRC_URI_ZEPHYR_LIBMCTP};name=libmctp;nobranch=1;destsuffix=${P}/modules/lib/libmctp \
-    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=${P}/modules/hal/libmetal \
-    ${SRC_URI_ZEPHYR_LIBSBC};name=libsbc;nobranch=1;destsuffix=${P}/modules/lib/libsbc \
-    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=${P}/modules/fs/littlefs \
-    ${SRC_URI_ZEPHYR_LORA_BASICS_MODEM};name=lora-basics-modem;nobranch=1;destsuffix=${P}/modules/lib/lora-basics-modem \
-    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=${P}/modules/lib/loramac-node \
-    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=${P}/modules/lib/gui/lvgl \
-    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=${P}/modules/crypto/mbedtls \
-    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=${P}/bootloader/mcuboot \
-    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=${P}/modules/debug/mipi-sys-t \
-    ${SRC_URI_ZEPHYR_NANOPB};name=nanopb;nobranch=1;destsuffix=${P}/modules/lib/nanopb \
-    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=${P}/tools/net-tools \
-    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=${P}/modules/bsim_hw_models/nrf_hw_models \
-    ${SRC_URI_ZEPHYR_NRF_WIFI};name=nrf_wifi;nobranch=1;destsuffix=${P}/modules/lib/nrf_wifi \
-    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=${P}/modules/lib/open-amp \
-    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=${P}/modules/lib/openthread \
-    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=${P}/modules/debug/percepio \
-    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=${P}/modules/lib/picolibc \
-    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=${P}/modules/debug/segger \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=${P}/modules/tee/tf-a/trusted-firmware-a \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=${P}/modules/tee/tf-m/trusted-firmware-m \
-    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=${P}/modules/lib/uoscore-uedhoc \
-    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=${P}/modules/lib/zcbor \
-    ${SRC_URI_PATCHES} \
-"
-
-ZEPHYR_MODULES = "\
-${S}/modules/lib/acpica\;\
-${S}/tools/bsim/components\;\
-${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
-${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
-${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
-${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
-${S}/tools/bsim/components/ext_2G4_device_playback\;\
-${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
-${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
-${S}/tools/bsim/components/ext_2G4_modem_magic\;\
-${S}/tools/bsim/components/ext_2G4_phy_v1\;\
-${S}/tools/bsim/components/ext_libCryptov1\;\
-${S}/tools/bsim\;\
-${S}/modules/hal/cmsis\;\
-${S}/modules/lib/cmsis-dsp\;\
-${S}/modules/lib/cmsis-nn\;\
-${S}/modules/hal/cmsis_6\;\
-${S}/tools/edtt\;\
-${S}/modules/fs/fatfs\;\
-${S}/modules/hal/adi\;\
-${S}/modules/hal/afbr\;\
-${S}/modules/hal/ambiq\;\
-${S}/modules/hal/atmel\;\
-${S}/modules/hal/bouffalolab\;\
-${S}/modules/hal/espressif\;\
-${S}/modules/hal/ethos_u\;\
-${S}/modules/hal/gigadevice\;\
-${S}/modules/hal/infineon\;\
-${S}/modules/hal/intel\;\
-${S}/modules/hal/microchip\;\
-${S}/modules/hal/nordic\;\
-${S}/modules/hal/nuvoton\;\
-${S}/modules/hal/nxp\;\
-${S}/modules/hal/openisa\;\
-${S}/modules/hal/quicklogic\;\
-${S}/modules/hal/renesas\;\
-${S}/modules/hal/rpi_pico\;\
-${S}/modules/hal/sifli\;\
-${S}/modules/hal/silabs\;\
-${S}/modules/hal/st\;\
-${S}/modules/hal/stm32\;\
-${S}/modules/hal/tdk\;\
-${S}/modules/hal/telink\;\
-${S}/modules/hal/ti\;\
-${S}/modules/hal/wch\;\
-${S}/modules/hal/wurthelektronik\;\
-${S}/modules/hal/xtensa\;\
-${S}/modules/lib/hostap\;\
-${S}/modules/lib/liblc3\;\
-${S}/modules/lib/libmctp\;\
-${S}/modules/hal/libmetal\;\
-${S}/modules/lib/libsbc\;\
-${S}/modules/fs/littlefs\;\
-${S}/modules/lib/lora-basics-modem\;\
-${S}/modules/lib/loramac-node\;\
-${S}/modules/lib/gui/lvgl\;\
-${S}/modules/crypto/mbedtls\;\
-${S}/bootloader/mcuboot\;\
-${S}/modules/debug/mipi-sys-t\;\
-${S}/modules/lib/nanopb\;\
-${S}/tools/net-tools\;\
-${S}/modules/bsim_hw_models/nrf_hw_models\;\
-${S}/modules/lib/nrf_wifi\;\
-${S}/modules/lib/open-amp\;\
-${S}/modules/lib/openthread\;\
-${S}/modules/debug/percepio\;\
-${S}/modules/lib/picolibc\;\
-${S}/modules/debug/segger\;\
-${S}/modules/tee/tf-a/trusted-firmware-a\;\
-${S}/modules/tee/tf-m/trusted-firmware-m\;\
-${S}/modules/lib/uoscore-uedhoc\;\
-${S}/modules/lib/zcbor\;\
-"
-
-ZEPHYR_BRANCH = "v4.3-branch"
-PV = "4.3.0+git${SRCPV}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc
deleted file mode 100644
index 290cb58..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc
+++ /dev/null
@@ -1,66 +0,0 @@
-# Exclude tests that fail to configure
-ZEPHYRTESTS:remove = "fifo \
-    fpu_sharing \
-    lifo \
-    mbox \
-    mem_heap \
-    mem_pool \
-    mem_protect \
-    mem_slab \
-    msgq \
-    mutex \
-    pipe \
-    profiling \
-    sched \
-    semaphore \
-    stack \
-    threads \
-    tickless \
-    timer \
-    workq"
-
-# Exclude tests that are not currently compiling
-ZEPHYRTESTS:remove = "ipi_cascade ipi_optimize ipi_work mp smp smp_abort smp_boot_delay smp_suspend  spinlock"
-ZEPHYRTESTS:remove:96b-avenger96 = "cache common device poll queue sleep"
-ZEPHYRTESTS:remove:stm32mp157c-dk2 = "cache common device poll queue sleep"
-
-# List of all available kernel tests
-ZEPHYRTESTS = " \
-    cache \
-    common \
-    context \
-    device \
-    early_sleep \
-    fifo \
-    fpu_sharing \
-    ipi_cascade \
-    ipi_optimize \
-    ipi_work \
-    lifo \
-    mbox \
-    mem_heap \
-    mem_protect \
-    mem_slab \
-    mp \
-    msgq \
-    mutex \
-    obj_tracking \
-    pending \
-    pipe \
-    poll \
-    profiling \
-    queue \
-    sched \
-    semaphore \
-    sleep \
-    smp \
-    smp_abort \
-    smp_boot_delay \
-    smp_suspend \
-    spinlock \
-    stack \
-    threads \
-    tickless \
-    timer \
-    workq \
-    "
-- 
2.43.0


