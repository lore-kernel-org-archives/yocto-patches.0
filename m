Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A1C369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 07:59:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mx.groups.io with SMTP id smtpd.web11.7597.1744963153268070655
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 00:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=Wff6gc8Z;
 spf=pass (domain: intel.com, ip: 192.198.163.10, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963154; x=1776499154;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dwIZZV0Q6nuHR8TmqjUdO01axe9NLoKRc04YxPIDyZA=;
  b=Wff6gc8Z4aRzgTFYJ2BPipsdCPdakB/EbiXBs97XsuSadI/tsGWyDcpV
   XWzr4Dx3DWLRQyGE8EGcCrKUEx3da+R1ocNy329vobsKK24udR5LGJl/e
   muV1/wKJ0x1kEp4epHDVEqehYVLGctCSAtT6hBcr3ZmcpwnhbSHWF2rzC
   qqGxd5SKk+3HgvN2gaV5htDsF6AF6eUUfVO/zwZF4rJgx9KC+iOsrH8PB
   QKvT7jBaqIN4xs1HRXwh1MUzjQPJnP1g8j8F9oqrb7+tLuhCJ+zs/VLhH
   KT6Z9wxHiJO/FMA7sRnJ4aMI0fbEAt2X5IkzBzEJ4813dh4IEAqXUMLbr
   g==;
X-CSE-ConnectionGUID: FPvye88VSIivGq1E18PSCA==
X-CSE-MsgGUID: GbN1YRscRmK49ouBBGHwcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57958465"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="57958465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:59:14 -0700
X-CSE-ConnectionGUID: VBy2rIIMQI+lnBLCh7drfA==
X-CSE-MsgGUID: mRzLDwm+TE6L0n38z6EnXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="130804344"
Received: from saininav-desk1.png.intel.com ([10.107.249.121])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:59:13 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH v2 2/3] zephyr-kernel: drop support for v3.5.0 and v3.6.0
Date: Fri, 18 Apr 2025 15:58:59 +0800
Message-ID: <20250418075900.309171-2-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418075900.309171-1-naveen.kumar.saini@intel.com>
References: <20250418075900.309171-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 07:59:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1381

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 ...ry-generation-issue-in-cross-compila.patch |  93 ------
 .../zephyr-kernel/zephyr-kernel-src-3.5.0.inc | 270 ------------------
 .../zephyr-kernel/zephyr-kernel-src-3.6.0.inc | 270 ------------------
 .../zephyr-kernel/zephyr-kernel-src-dev.inc   |  17 --
 4 files changed, 650 deletions(-)
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.5.0.inc
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.6.0.inc
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-dev.inc

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
deleted file mode 100644
index f1b2b9f..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
+++ /dev/null
@@ -1,93 +0,0 @@
-From 25cf09358eebde64474cbf0759974e2087d4dcc6 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Tue, 31 Oct 2023 16:57:31 +0800
-Subject: [PATCH] x86: fix efi binary generation issue in cross compilation env
-
-Set root directory for headers.
-
-Upstream-Status: Inappropriate [Cross-compilation specific]
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- arch/x86/zefi/zefi.py                | 5 ++++-
- boards/x86/intel_adl/CMakeLists.txt  | 1 +
- boards/x86/intel_ehl/CMakeLists.txt  | 1 +
- boards/x86/intel_rpl/CMakeLists.txt  | 1 +
- boards/x86/up_squared/CMakeLists.txt | 1 +
- 5 files changed, 8 insertions(+), 1 deletion(-)
-
-diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
-index 99c188ecd0..1cd86a21cd 100755
---- a/arch/x86/zefi/zefi.py
-+++ b/arch/x86/zefi/zefi.py
-@@ -109,8 +109,10 @@ def build_elf(elf_file, include_dirs):
-     includes = []
-     for include_dir in include_dirs:
-         includes.extend(["-I", include_dir])
-+    #  Pass --sysroot path for cross compilation
-+    sysrootarg = "--sysroot=" + args.sysroot
-     cmd = ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + includes +
--           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar",
-+           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar", sysrootarg,
-             "-Wl,-nostdlib", "-T", ldscript, "-o", "zefi.elf", cfile])
-     verbose(" ".join(cmd))
-     subprocess.run(cmd, check = True)
-@@ -150,6 +152,7 @@ def parse_args():
-     parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
-     parser.add_argument("-i", "--includes", required=True, nargs="+",
-                         help="Zephyr base include directories")
-+    parser.add_argument("-s", "--sysroot", required=True, help="Cross compilation --sysroot=path")
- 
-     return parser.parse_args()
- 
-diff --git a/boards/x86/intel_adl/CMakeLists.txt b/boards/x86/intel_adl/CMakeLists.txt
-index 2dc5afcc32..7981e576f2 100644
---- a/boards/x86/intel_adl/CMakeLists.txt
-+++ b/boards/x86/intel_adl/CMakeLists.txt
-@@ -6,6 +6,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
-diff --git a/boards/x86/intel_ehl/CMakeLists.txt b/boards/x86/intel_ehl/CMakeLists.txt
-index 2dc5afcc32..7981e576f2 100644
---- a/boards/x86/intel_ehl/CMakeLists.txt
-+++ b/boards/x86/intel_ehl/CMakeLists.txt
-@@ -6,6 +6,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
-diff --git a/boards/x86/intel_rpl/CMakeLists.txt b/boards/x86/intel_rpl/CMakeLists.txt
-index 2dc5afcc32..7981e576f2 100644
---- a/boards/x86/intel_rpl/CMakeLists.txt
-+++ b/boards/x86/intel_rpl/CMakeLists.txt
-@@ -6,6 +6,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
-diff --git a/boards/x86/up_squared/CMakeLists.txt b/boards/x86/up_squared/CMakeLists.txt
-index 2dc5afcc32..7981e576f2 100644
---- a/boards/x86/up_squared/CMakeLists.txt
-+++ b/boards/x86/up_squared/CMakeLists.txt
-@@ -6,6 +6,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
-   -o ${CMAKE_OBJCOPY}
-   -i ${ZEPHYR_BASE}/include
-   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
-+  -s ${SYSROOT_DIR}
-   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
-   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
- )
--- 
-2.34.1
-
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.5.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.5.0.inc
deleted file mode 100644
index f91c37d..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.5.0.inc
+++ /dev/null
@@ -1,270 +0,0 @@
-# Auto-generated from zephyr-kernel-src.inc.jinja
-
-SRCREV_FORMAT = "default"
-
-SRCREV_default = "a6eef0ba3755f2530c5ce93524e5ac4f5be30194"
-SRCREV_acpica = "0333c2af13179f9b33d495cf7cb9a509f751cbb1"
-SRCREV_bsim = "384a091445c57b44ac8cbd18ebd245b47c71db94"
-SRCREV_babblesim_base = "19d62424c0802c6c9fc15528febe666e40f372a1"
-SRCREV_babblesim_ext_2G4_libPhyComv1 = "9018113a362fa6c9e8f4b9cab9e5a8f12cc46b94"
-SRCREV_babblesim_ext_2G4_phy_v1 = "d47c6dd90035b41b14f6921785ccb7b8484868e2"
-SRCREV_babblesim_ext_2G4_channel_NtNcable = "20a38c997f507b0aa53817aab3d73a462fff7af1"
-SRCREV_babblesim_ext_2G4_channel_multiatt = "bde72a57384dde7a4310bcf3843469401be93074"
-SRCREV_babblesim_ext_2G4_modem_magic = "cb70771794f0bf6f262aa474848611c68ae8f1ed"
-SRCREV_babblesim_ext_2G4_modem_BLE_simple = "809ab073159c9ab6686c2fea5749b0702e0909f7"
-SRCREV_babblesim_ext_2G4_device_burst_interferer = "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
-SRCREV_babblesim_ext_2G4_device_WLAN_actmod = "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
-SRCREV_babblesim_ext_2G4_device_playback = "85c645929cf1ce995d8537107d9dcbd12ed64036"
-SRCREV_babblesim_ext_libCryptov1 = "eed6d7038e839153e340bd333bc43541cb90ba64"
-SRCREV_canopennode = "dec12fa3f0d790cafa8414a4c2930ea71ab72ffd"
-SRCREV_cmsis = "5a00331455dd74e31e80efa383a489faea0590e3"
-SRCREV_cmsis-dsp = "ff7b5fd1ea5f094665c090c343ec44e74dc0b193"
-SRCREV_cmsis-nn = "0c8669d81381ccf3b1a01d699f3b68b50134a99f"
-SRCREV_edtt = "64e5105ad82390164fb73fc654be3f73a608209a"
-SRCREV_fatfs = "427159bf95ea49b7680facffaa29ad506b42709b"
-SRCREV_hal_altera = "0d225ddd314379b32355a00fb669eacf911e750d"
-SRCREV_hal_ambiq = "0a7c99325aa73a1ef777501da91c2c6608661e56"
-SRCREV_hal_atmel = "5ab43007eda3f380c125f957f03638d2e8d1144d"
-SRCREV_hal_espressif = "31fc5758f3507f8f0af00b1dea1a0df7af99bfc0"
-SRCREV_hal_ethos_u = "90ada2ea5681b2a2722a10d2898eac34c2510791"
-SRCREV_hal_gigadevice = "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
-SRCREV_hal_infineon = "815e84a5150f95627201f192779a0180d5052de7"
-SRCREV_hal_intel = "b3b43d4e3da7ba483611bbbea7ef8af92c69df31"
-SRCREV_hal_microchip = "5d079f1683a00b801373bbbbf5d181d4e33b30d5"
-SRCREV_hal_nordic = "d054a315eb888ba70e09e5f6decd4097b0276d1f"
-SRCREV_hal_nuvoton = "3e0a4c4d3328b2f72b164219add19d5308b53cb5"
-SRCREV_hal_nxp = "ad142f5612d927e29b1f9606e8edade871b8a526"
-SRCREV_hal_openisa = "d1e61c0c654d8ca9e73d27fca3a7eb3b7881cb6a"
-SRCREV_hal_quicklogic = "b3a66fe6d04d87fd1533a5c8de51d0599fcd08d0"
-SRCREV_hal_renesas = "a6cf2af9140e014fbbc48d2b6deb802231dd369f"
-SRCREV_hal_rpi_pico = "fba7162cc7bee06d0149622bbcaac4e41062d368"
-SRCREV_hal_silabs = "d191d981c4eb20c0c7445a4061fcdbcfa686113a"
-SRCREV_hal_st = "fb8e79d1a261fd02aadff7c142729f1954163cf3"
-SRCREV_hal_stm32 = "89ef0a3383edebf661073073bcdf6e2836fe90ee"
-SRCREV_hal_telink = "38573af589173259801ae6c2b34b7d4c9e626746"
-SRCREV_hal_ti = "b85f86e51fc4d47c4c383d320d64d52d4d371ae4"
-SRCREV_hal_wurthelektronik = "24ca9873c3d608fad1fea0431836bc8f144c132e"
-SRCREV_hal_xtensa = "e6da34fc07dfe96161ab8743f5dbeb6e6307ab93"
-SRCREV_libmetal = "b91611a6f47dd29fb24c46e5621e797557f80ec6"
-SRCREV_liblc3 = "448f3de31f49a838988a162ef1e23a89ddf2d2ed"
-SRCREV_littlefs = "ca583fd297ceb48bced3c2548600dc615d67af24"
-SRCREV_loramac-node = "842413c5fb98707eb5f26e619e8e792453877897"
-SRCREV_lvgl = "8a6a2d1d29d17d1e4bdc94c243c146a39d635fdd"
-SRCREV_mbedtls = "c38dc78d9a8dcbe43b898cc1171ab33ba3e6fc26"
-SRCREV_mcuboot = "13767d0b72eb14ce42eb8aad1e5a133ef66afc54"
-SRCREV_mipi-sys-t = "a819419603a2dfcb47f7f39092e1bc112e45d1ef"
-SRCREV_net-tools = "d68ee9d17648a1bb3729c2023abfcb735dfe92fa"
-SRCREV_nrf_hw_models = "f4595802d32d103718bf50b3d390b7a450895843"
-SRCREV_open-amp = "42b7c577714b8f22ce82a901e19c1814af4609a8"
-SRCREV_openthread = "d62167ee34b091e7025c9ec2820aae71e17a3944"
-SRCREV_percepio = "a3728efccc47dd372f40e6313589ca4c5cc7d5e9"
-SRCREV_picolibc = "d07c38ff051386f8e09a143ea0a6c1d6d66dd1d8"
-SRCREV_segger = "9d0191285956cef43daf411edc2f1a7788346def"
-SRCREV_tinycrypt = "3e9a49d2672ec01435ffbf0d788db6d95ef28de0"
-SRCREV_trusted-firmware-m = "b168d92c7ed3c77c94d7ce3362bdde5dbffe8424"
-SRCREV_trusted-firmware-a = "421dc050278287839f5c70019bd6aec617f2bbdb"
-SRCREV_uoscore-uedhoc = "5fe2cb613bd7e4590bd1b00c2adf181ac0229379"
-SRCREV_zcbor = "67fd8bb88d3136738661fa8bb5f9989103f4599e"
-
-SRC_URI_ZEPHYR ?= "git://github.com/zephyrproject-rtos/zephyr.git;protocol=https"
-SRC_URI_ZEPHYR_ACPICA ?= "git://github.com/zephyrproject-rtos/acpica;protocol=https"
-SRC_URI_ZEPHYR_BSIM ?= "git://github.com/zephyrproject-rtos/babblesim-manifest;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_BASE ?= "git://github.com/BabbleSim/base.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?= "git://github.com/BabbleSim/ext_2G4_libPhyComv1.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?= "git://github.com/BabbleSim/ext_2G4_phy_v1.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?= "git://github.com/BabbleSim/ext_2G4_channel_NtNcable.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?= "git://github.com/BabbleSim/ext_2G4_channel_multiatt.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?= "git://github.com/BabbleSim/ext_2G4_modem_magic.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?= "git://github.com/BabbleSim/ext_2G4_modem_BLE_simple.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?= "git://github.com/BabbleSim/ext_2G4_device_burst_interferer.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?= "git://github.com/BabbleSim/ext_2G4_device_WLAN_actmod.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?= "git://github.com/BabbleSim/ext_2G4_device_playback.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?= "git://github.com/BabbleSim/ext_libCryptov1.git;protocol=https"
-SRC_URI_ZEPHYR_CANOPENNODE ?= "git://github.com/zephyrproject-rtos/canopennode;protocol=https"
-SRC_URI_ZEPHYR_CMSIS ?= "git://github.com/zephyrproject-rtos/cmsis;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_DSP ?= "git://github.com/zephyrproject-rtos/cmsis-dsp;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_NN ?= "git://github.com/zephyrproject-rtos/cmsis-nn;protocol=https"
-SRC_URI_ZEPHYR_EDTT ?= "git://github.com/zephyrproject-rtos/edtt;protocol=https"
-SRC_URI_ZEPHYR_FATFS ?= "git://github.com/zephyrproject-rtos/fatfs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ALTERA ?= "git://github.com/zephyrproject-rtos/hal_altera;protocol=https"
-SRC_URI_ZEPHYR_HAL_AMBIQ ?= "git://github.com/zephyrproject-rtos/hal_ambiq;protocol=https"
-SRC_URI_ZEPHYR_HAL_ATMEL ?= "git://github.com/zephyrproject-rtos/hal_atmel;protocol=https"
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
-SRC_URI_ZEPHYR_HAL_SILABS ?= "git://github.com/zephyrproject-rtos/hal_silabs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ST ?= "git://github.com/zephyrproject-rtos/hal_st;protocol=https"
-SRC_URI_ZEPHYR_HAL_STM32 ?= "git://github.com/zephyrproject-rtos/hal_stm32;protocol=https"
-SRC_URI_ZEPHYR_HAL_TELINK ?= "git://github.com/zephyrproject-rtos/hal_telink;protocol=https"
-SRC_URI_ZEPHYR_HAL_TI ?= "git://github.com/zephyrproject-rtos/hal_ti;protocol=https"
-SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?= "git://github.com/zephyrproject-rtos/hal_wurthelektronik;protocol=https"
-SRC_URI_ZEPHYR_HAL_XTENSA ?= "git://github.com/zephyrproject-rtos/hal_xtensa;protocol=https"
-SRC_URI_ZEPHYR_LIBMETAL ?= "git://github.com/zephyrproject-rtos/libmetal;protocol=https"
-SRC_URI_ZEPHYR_LIBLC3 ?= "git://github.com/zephyrproject-rtos/liblc3;protocol=https"
-SRC_URI_ZEPHYR_LITTLEFS ?= "git://github.com/zephyrproject-rtos/littlefs;protocol=https"
-SRC_URI_ZEPHYR_LORAMAC_NODE ?= "git://github.com/zephyrproject-rtos/loramac-node;protocol=https"
-SRC_URI_ZEPHYR_LVGL ?= "git://github.com/zephyrproject-rtos/lvgl;protocol=https"
-SRC_URI_ZEPHYR_MBEDTLS ?= "git://github.com/zephyrproject-rtos/mbedtls;protocol=https"
-SRC_URI_ZEPHYR_MCUBOOT ?= "git://github.com/zephyrproject-rtos/mcuboot;protocol=https"
-SRC_URI_ZEPHYR_MIPI_SYS_T ?= "git://github.com/zephyrproject-rtos/mipi-sys-t;protocol=https"
-SRC_URI_ZEPHYR_NET_TOOLS ?= "git://github.com/zephyrproject-rtos/net-tools;protocol=https"
-SRC_URI_ZEPHYR_NRF_HW_MODELS ?= "git://github.com/zephyrproject-rtos/nrf_hw_models;protocol=https"
-SRC_URI_ZEPHYR_OPEN_AMP ?= "git://github.com/zephyrproject-rtos/open-amp;protocol=https"
-SRC_URI_ZEPHYR_OPENTHREAD ?= "git://github.com/zephyrproject-rtos/openthread;protocol=https"
-SRC_URI_ZEPHYR_PERCEPIO ?= "git://github.com/zephyrproject-rtos/percepio;protocol=https"
-SRC_URI_ZEPHYR_PICOLIBC ?= "git://github.com/zephyrproject-rtos/picolibc;protocol=https"
-SRC_URI_ZEPHYR_SEGGER ?= "git://github.com/zephyrproject-rtos/segger;protocol=https"
-SRC_URI_ZEPHYR_TINYCRYPT ?= "git://github.com/zephyrproject-rtos/tinycrypt;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?= "git://github.com/zephyrproject-rtos/trusted-firmware-m;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?= "git://github.com/zephyrproject-rtos/trusted-firmware-a;protocol=https"
-SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?= "git://github.com/zephyrproject-rtos/uoscore-uedhoc;protocol=https"
-SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=https"
-
-SRC_URI_PATCHES ?= "\
-    file://0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
-"
-
-SRC_URI = "\
-    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=git/zephyr \
-    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=git/modules/lib/acpica \
-    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=git/tools/bsim \
-    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=git/tools/bsim/components \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_libPhyComv1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_phy_v1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_NtNcable \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_multiatt \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_magic \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_BLE_simple \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_burst_interferer \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_WLAN_actmod \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_playback \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=git/tools/bsim/components/ext_libCryptov1 \
-    ${SRC_URI_ZEPHYR_CANOPENNODE};name=canopennode;nobranch=1;destsuffix=git/modules/lib/canopennode \
-    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=git/modules/hal/cmsis \
-    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=git/modules/lib/cmsis-dsp \
-    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=git/modules/lib/cmsis-nn \
-    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=git/tools/edtt \
-    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=git/modules/fs/fatfs \
-    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=hal_altera;nobranch=1;destsuffix=git/modules/hal/altera \
-    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=git/modules/hal/ambiq \
-    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=git/modules/hal/atmel \
-    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=hal_espressif;nobranch=1;destsuffix=git/modules/hal/espressif \
-    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=hal_ethos_u;nobranch=1;destsuffix=git/modules/hal/ethos_u \
-    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=hal_gigadevice;nobranch=1;destsuffix=git/modules/hal/gigadevice \
-    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=hal_infineon;nobranch=1;destsuffix=git/modules/hal/infineon \
-    ${SRC_URI_ZEPHYR_HAL_INTEL};name=hal_intel;nobranch=1;destsuffix=git/modules/hal/intel \
-    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=hal_microchip;nobranch=1;destsuffix=git/modules/hal/microchip \
-    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=hal_nordic;nobranch=1;destsuffix=git/modules/hal/nordic \
-    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=hal_nuvoton;nobranch=1;destsuffix=git/modules/hal/nuvoton \
-    ${SRC_URI_ZEPHYR_HAL_NXP};name=hal_nxp;nobranch=1;destsuffix=git/modules/hal/nxp \
-    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=hal_openisa;nobranch=1;destsuffix=git/modules/hal/openisa \
-    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=hal_quicklogic;nobranch=1;destsuffix=git/modules/hal/quicklogic \
-    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=git/modules/hal/renesas \
-    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=git/modules/hal/rpi_pico \
-    ${SRC_URI_ZEPHYR_HAL_SILABS};name=hal_silabs;nobranch=1;destsuffix=git/modules/hal/silabs \
-    ${SRC_URI_ZEPHYR_HAL_ST};name=hal_st;nobranch=1;destsuffix=git/modules/hal/st \
-    ${SRC_URI_ZEPHYR_HAL_STM32};name=hal_stm32;nobranch=1;destsuffix=git/modules/hal/stm32 \
-    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=git/modules/hal/telink \
-    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=git/modules/hal/ti \
-    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=git/modules/hal/wurthelektronik \
-    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=git/modules/hal/xtensa \
-    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=git/modules/hal/libmetal \
-    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=git/modules/lib/liblc3 \
-    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=git/modules/fs/littlefs \
-    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=git/modules/lib/loramac-node \
-    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=git/modules/lib/gui/lvgl \
-    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=git/modules/crypto/mbedtls \
-    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=git/bootloader/mcuboot \
-    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=git/modules/debug/mipi-sys-t \
-    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=git/tools/net-tools \
-    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=git/modules/bsim_hw_models/nrf_hw_models \
-    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=git/modules/lib/open-amp \
-    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=git/modules/lib/openthread \
-    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=git/modules/debug/percepio \
-    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=git/modules/lib/picolibc \
-    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=git/modules/debug/segger \
-    ${SRC_URI_ZEPHYR_TINYCRYPT};name=tinycrypt;nobranch=1;destsuffix=git/modules/crypto/tinycrypt \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=git/modules/tee/tf-m/trusted-firmware-m \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=git/modules/tee/tf-a/trusted-firmware-a \
-    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=git/modules/lib/uoscore-uedhoc \
-    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=git/modules/lib/zcbor \
-    ${SRC_URI_PATCHES} \
-"
-
-ZEPHYR_MODULES = "\
-${S}/modules/lib/acpica\;\
-${S}/tools/bsim\;\
-${S}/tools/bsim/components\;\
-${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
-${S}/tools/bsim/components/ext_2G4_phy_v1\;\
-${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
-${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
-${S}/tools/bsim/components/ext_2G4_modem_magic\;\
-${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
-${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
-${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
-${S}/tools/bsim/components/ext_2G4_device_playback\;\
-${S}/tools/bsim/components/ext_libCryptov1\;\
-${S}/modules/lib/canopennode\;\
-${S}/modules/hal/cmsis\;\
-${S}/modules/lib/cmsis-dsp\;\
-${S}/modules/lib/cmsis-nn\;\
-${S}/tools/edtt\;\
-${S}/modules/fs/fatfs\;\
-${S}/modules/hal/altera\;\
-${S}/modules/hal/ambiq\;\
-${S}/modules/hal/atmel\;\
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
-${S}/modules/hal/silabs\;\
-${S}/modules/hal/st\;\
-${S}/modules/hal/stm32\;\
-${S}/modules/hal/telink\;\
-${S}/modules/hal/ti\;\
-${S}/modules/hal/wurthelektronik\;\
-${S}/modules/hal/xtensa\;\
-${S}/modules/hal/libmetal\;\
-${S}/modules/lib/liblc3\;\
-${S}/modules/fs/littlefs\;\
-${S}/modules/lib/loramac-node\;\
-${S}/modules/lib/gui/lvgl\;\
-${S}/modules/crypto/mbedtls\;\
-${S}/bootloader/mcuboot\;\
-${S}/modules/debug/mipi-sys-t\;\
-${S}/tools/net-tools\;\
-${S}/modules/bsim_hw_models/nrf_hw_models\;\
-${S}/modules/lib/open-amp\;\
-${S}/modules/lib/openthread\;\
-${S}/modules/debug/percepio\;\
-${S}/modules/lib/picolibc\;\
-${S}/modules/debug/segger\;\
-${S}/modules/crypto/tinycrypt\;\
-${S}/modules/tee/tf-m/trusted-firmware-m\;\
-${S}/modules/tee/tf-a/trusted-firmware-a\;\
-${S}/modules/lib/uoscore-uedhoc\;\
-${S}/modules/lib/zcbor\;\
-"
-
-ZEPHYR_BRANCH = "v3.5-branch"
-PV = "3.5.0+git${SRCPV}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.6.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.6.0.inc
deleted file mode 100644
index 5b09aac..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.6.0.inc
+++ /dev/null
@@ -1,270 +0,0 @@
-# Auto-generated from zephyr-kernel-src.inc.jinja
-
-SRCREV_FORMAT = "default"
-
-SRCREV_default = "468eb56cf242eedba62006ee758700ee6148763f"
-SRCREV_acpica = "da5f2721e1c7f188fe04aa50af76f4b94f3c3ea3"
-SRCREV_bsim = "384a091445c57b44ac8cbd18ebd245b47c71db94"
-SRCREV_babblesim_base = "19d62424c0802c6c9fc15528febe666e40f372a1"
-SRCREV_babblesim_ext_2G4_libPhyComv1 = "9018113a362fa6c9e8f4b9cab9e5a8f12cc46b94"
-SRCREV_babblesim_ext_2G4_phy_v1 = "d47c6dd90035b41b14f6921785ccb7b8484868e2"
-SRCREV_babblesim_ext_2G4_channel_NtNcable = "20a38c997f507b0aa53817aab3d73a462fff7af1"
-SRCREV_babblesim_ext_2G4_channel_multiatt = "bde72a57384dde7a4310bcf3843469401be93074"
-SRCREV_babblesim_ext_2G4_modem_magic = "cb70771794f0bf6f262aa474848611c68ae8f1ed"
-SRCREV_babblesim_ext_2G4_modem_BLE_simple = "809ab073159c9ab6686c2fea5749b0702e0909f7"
-SRCREV_babblesim_ext_2G4_device_burst_interferer = "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
-SRCREV_babblesim_ext_2G4_device_WLAN_actmod = "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
-SRCREV_babblesim_ext_2G4_device_playback = "85c645929cf1ce995d8537107d9dcbd12ed64036"
-SRCREV_babblesim_ext_libCryptov1 = "eed6d7038e839153e340bd333bc43541cb90ba64"
-SRCREV_cmsis = "4b96cbb174678dcd3ca86e11e1f24bc5f8726da0"
-SRCREV_cmsis-dsp = "6489e771e9c405f1763b52d64a3f17a1ec488ace"
-SRCREV_cmsis-nn = "0c8669d81381ccf3b1a01d699f3b68b50134a99f"
-SRCREV_edtt = "64e5105ad82390164fb73fc654be3f73a608209a"
-SRCREV_fatfs = "427159bf95ea49b7680facffaa29ad506b42709b"
-SRCREV_hal_altera = "0d225ddd314379b32355a00fb669eacf911e750d"
-SRCREV_hal_ambiq = "ff4ca358d730536addf336c40c3faa4ebf1df00a"
-SRCREV_hal_atmel = "aad79bf530b69b72712d18873df4120ad052d921"
-SRCREV_hal_espressif = "67fa60bdffca7ba8ed199aecfaa26f485f24878b"
-SRCREV_hal_ethos_u = "90ada2ea5681b2a2722a10d2898eac34c2510791"
-SRCREV_hal_gigadevice = "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
-SRCREV_hal_infineon = "69c883d3bd9fac8a18dd8384624b8c472a68d06f"
-SRCREV_hal_intel = "7b4c25669f1513b0d6d6ee78ee42340d91958884"
-SRCREV_hal_microchip = "5d079f1683a00b801373bbbbf5d181d4e33b30d5"
-SRCREV_hal_nordic = "dce8519f7da37b0a745237679fd3f88250b495ff"
-SRCREV_hal_nuvoton = "68a91bb343ff47e40dbd9189a7d6e3ee801a7135"
-SRCREV_hal_nxp = "d45b14c198d778658b7853b48378d2e132a6c4be"
-SRCREV_hal_openisa = "eabd530a64d71de91d907bad257cd61aacf607bc"
-SRCREV_hal_quicklogic = "b3a66fe6d04d87fd1533a5c8de51d0599fcd08d0"
-SRCREV_hal_renesas = "0b1f2fdb99d6386f125a8dba72083e3c56aecc2b"
-SRCREV_hal_rpi_pico = "fba7162cc7bee06d0149622bbcaac4e41062d368"
-SRCREV_hal_silabs = "b11b29167f3f9a0fd0c34a8eeeb36b0c1d218917"
-SRCREV_hal_st = "0643d20ae85b32c658ad11036f7c964a860ddefe"
-SRCREV_hal_stm32 = "60c9634f61c697e1c310ec648d33529712806069"
-SRCREV_hal_telink = "38573af589173259801ae6c2b34b7d4c9e626746"
-SRCREV_hal_ti = "b85f86e51fc4d47c4c383d320d64d52d4d371ae4"
-SRCREV_hal_wurthelektronik = "e5bcb2eac1bb9639ce13b4dafc78eb254e014342"
-SRCREV_hal_xtensa = "08325d6fb7190a105f5382d35e64ed2812c57cf4"
-SRCREV_hostap = "dee924caf7218d0ee2c2698c217559b1292a46d0"
-SRCREV_libmetal = "243eed541b9c211a2ce8841c788e62ddce84425e"
-SRCREV_liblc3 = "1a5938ebaca4f13fe79ce074f5dee079783aa29f"
-SRCREV_littlefs = "408c16a909dd6cf128874a76f21c793798c9e423"
-SRCREV_loramac-node = "842413c5fb98707eb5f26e619e8e792453877897"
-SRCREV_lvgl = "2b76c641749725ac90c6ac7959ca7718804cf356"
-SRCREV_mbedtls = "6ec4abdcda78dfc47315af568f93e5ad4398dea0"
-SRCREV_mcuboot = "a4eda30f5b0cfd0cf15512be9dcd559239dbfc91"
-SRCREV_mipi-sys-t = "a819419603a2dfcb47f7f39092e1bc112e45d1ef"
-SRCREV_net-tools = "3a677d355cc7f73e444801a6280d0ccec80a1957"
-SRCREV_nrf_hw_models = "52d0b4b7b7431d8da6222cc3b17a8afdcb099baf"
-SRCREV_open-amp = "da78aea63159771956fe0c9263f2e6985b66e9d5"
-SRCREV_openthread = "7761b81d23b10b3d5ee21b8504c67535cde10896"
-SRCREV_percepio = "0fbc5b72aeab8a6434523a3a7bc8111c17f0bc73"
-SRCREV_picolibc = "764ef4e401a8f4c6a86ab723533841f072885a5b"
-SRCREV_segger = "9d0191285956cef43daf411edc2f1a7788346def"
-SRCREV_tinycrypt = "3e9a49d2672ec01435ffbf0d788db6d95ef28de0"
-SRCREV_trusted-firmware-m = "0b898c9b72171b0a260c0bb64a92ea4713f9e931"
-SRCREV_trusted-firmware-a = "421dc050278287839f5c70019bd6aec617f2bbdb"
-SRCREV_uoscore-uedhoc = "150f4eb2955eaf36ac0f9519d4f4f58d5ade5740"
-SRCREV_zcbor = "d3093b5684f62268c7f27f8a5079f166772619de"
-
-SRC_URI_ZEPHYR ?= "git://github.com/zephyrproject-rtos/zephyr.git;protocol=https"
-SRC_URI_ZEPHYR_ACPICA ?= "git://github.com/zephyrproject-rtos/acpica;protocol=https"
-SRC_URI_ZEPHYR_BSIM ?= "git://github.com/zephyrproject-rtos/babblesim-manifest;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_BASE ?= "git://github.com/BabbleSim/base.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?= "git://github.com/BabbleSim/ext_2G4_libPhyComv1.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?= "git://github.com/BabbleSim/ext_2G4_phy_v1.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?= "git://github.com/BabbleSim/ext_2G4_channel_NtNcable.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?= "git://github.com/BabbleSim/ext_2G4_channel_multiatt.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?= "git://github.com/BabbleSim/ext_2G4_modem_magic.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?= "git://github.com/BabbleSim/ext_2G4_modem_BLE_simple.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?= "git://github.com/BabbleSim/ext_2G4_device_burst_interferer.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?= "git://github.com/BabbleSim/ext_2G4_device_WLAN_actmod.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?= "git://github.com/BabbleSim/ext_2G4_device_playback.git;protocol=https"
-SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?= "git://github.com/BabbleSim/ext_libCryptov1.git;protocol=https"
-SRC_URI_ZEPHYR_CMSIS ?= "git://github.com/zephyrproject-rtos/cmsis;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_DSP ?= "git://github.com/zephyrproject-rtos/cmsis-dsp;protocol=https"
-SRC_URI_ZEPHYR_CMSIS_NN ?= "git://github.com/zephyrproject-rtos/cmsis-nn;protocol=https"
-SRC_URI_ZEPHYR_EDTT ?= "git://github.com/zephyrproject-rtos/edtt;protocol=https"
-SRC_URI_ZEPHYR_FATFS ?= "git://github.com/zephyrproject-rtos/fatfs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ALTERA ?= "git://github.com/zephyrproject-rtos/hal_altera;protocol=https"
-SRC_URI_ZEPHYR_HAL_AMBIQ ?= "git://github.com/zephyrproject-rtos/hal_ambiq;protocol=https"
-SRC_URI_ZEPHYR_HAL_ATMEL ?= "git://github.com/zephyrproject-rtos/hal_atmel;protocol=https"
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
-SRC_URI_ZEPHYR_HAL_SILABS ?= "git://github.com/zephyrproject-rtos/hal_silabs;protocol=https"
-SRC_URI_ZEPHYR_HAL_ST ?= "git://github.com/zephyrproject-rtos/hal_st;protocol=https"
-SRC_URI_ZEPHYR_HAL_STM32 ?= "git://github.com/zephyrproject-rtos/hal_stm32;protocol=https"
-SRC_URI_ZEPHYR_HAL_TELINK ?= "git://github.com/zephyrproject-rtos/hal_telink;protocol=https"
-SRC_URI_ZEPHYR_HAL_TI ?= "git://github.com/zephyrproject-rtos/hal_ti;protocol=https"
-SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?= "git://github.com/zephyrproject-rtos/hal_wurthelektronik;protocol=https"
-SRC_URI_ZEPHYR_HAL_XTENSA ?= "git://github.com/zephyrproject-rtos/hal_xtensa;protocol=https"
-SRC_URI_ZEPHYR_HOSTAP ?= "git://github.com/zephyrproject-rtos/hostap;protocol=https"
-SRC_URI_ZEPHYR_LIBMETAL ?= "git://github.com/zephyrproject-rtos/libmetal;protocol=https"
-SRC_URI_ZEPHYR_LIBLC3 ?= "git://github.com/zephyrproject-rtos/liblc3;protocol=https"
-SRC_URI_ZEPHYR_LITTLEFS ?= "git://github.com/zephyrproject-rtos/littlefs;protocol=https"
-SRC_URI_ZEPHYR_LORAMAC_NODE ?= "git://github.com/zephyrproject-rtos/loramac-node;protocol=https"
-SRC_URI_ZEPHYR_LVGL ?= "git://github.com/zephyrproject-rtos/lvgl;protocol=https"
-SRC_URI_ZEPHYR_MBEDTLS ?= "git://github.com/zephyrproject-rtos/mbedtls;protocol=https"
-SRC_URI_ZEPHYR_MCUBOOT ?= "git://github.com/zephyrproject-rtos/mcuboot;protocol=https"
-SRC_URI_ZEPHYR_MIPI_SYS_T ?= "git://github.com/zephyrproject-rtos/mipi-sys-t;protocol=https"
-SRC_URI_ZEPHYR_NET_TOOLS ?= "git://github.com/zephyrproject-rtos/net-tools;protocol=https"
-SRC_URI_ZEPHYR_NRF_HW_MODELS ?= "git://github.com/zephyrproject-rtos/nrf_hw_models;protocol=https"
-SRC_URI_ZEPHYR_OPEN_AMP ?= "git://github.com/zephyrproject-rtos/open-amp;protocol=https"
-SRC_URI_ZEPHYR_OPENTHREAD ?= "git://github.com/zephyrproject-rtos/openthread;protocol=https"
-SRC_URI_ZEPHYR_PERCEPIO ?= "git://github.com/zephyrproject-rtos/percepio;protocol=https"
-SRC_URI_ZEPHYR_PICOLIBC ?= "git://github.com/zephyrproject-rtos/picolibc;protocol=https"
-SRC_URI_ZEPHYR_SEGGER ?= "git://github.com/zephyrproject-rtos/segger;protocol=https"
-SRC_URI_ZEPHYR_TINYCRYPT ?= "git://github.com/zephyrproject-rtos/tinycrypt;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?= "git://github.com/zephyrproject-rtos/trusted-firmware-m;protocol=https"
-SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?= "git://github.com/zephyrproject-rtos/trusted-firmware-a;protocol=https"
-SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?= "git://github.com/zephyrproject-rtos/uoscore-uedhoc;protocol=https"
-SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=https"
-
-SRC_URI_PATCHES ?= "\
-    file://0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
-"
-
-SRC_URI = "\
-    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=git/zephyr \
-    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=git/modules/lib/acpica \
-    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=git/tools/bsim \
-    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=git/tools/bsim/components \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_libPhyComv1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_phy_v1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_NtNcable \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_multiatt \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_magic \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_BLE_simple \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_burst_interferer \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_WLAN_actmod \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_playback \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=git/tools/bsim/components/ext_libCryptov1 \
-    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=git/modules/hal/cmsis \
-    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=git/modules/lib/cmsis-dsp \
-    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=git/modules/lib/cmsis-nn \
-    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=git/tools/edtt \
-    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=git/modules/fs/fatfs \
-    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=hal_altera;nobranch=1;destsuffix=git/modules/hal/altera \
-    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=git/modules/hal/ambiq \
-    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=git/modules/hal/atmel \
-    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=hal_espressif;nobranch=1;destsuffix=git/modules/hal/espressif \
-    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=hal_ethos_u;nobranch=1;destsuffix=git/modules/hal/ethos_u \
-    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=hal_gigadevice;nobranch=1;destsuffix=git/modules/hal/gigadevice \
-    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=hal_infineon;nobranch=1;destsuffix=git/modules/hal/infineon \
-    ${SRC_URI_ZEPHYR_HAL_INTEL};name=hal_intel;nobranch=1;destsuffix=git/modules/hal/intel \
-    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=hal_microchip;nobranch=1;destsuffix=git/modules/hal/microchip \
-    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=hal_nordic;nobranch=1;destsuffix=git/modules/hal/nordic \
-    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=hal_nuvoton;nobranch=1;destsuffix=git/modules/hal/nuvoton \
-    ${SRC_URI_ZEPHYR_HAL_NXP};name=hal_nxp;nobranch=1;destsuffix=git/modules/hal/nxp \
-    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=hal_openisa;nobranch=1;destsuffix=git/modules/hal/openisa \
-    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=hal_quicklogic;nobranch=1;destsuffix=git/modules/hal/quicklogic \
-    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=git/modules/hal/renesas \
-    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=git/modules/hal/rpi_pico \
-    ${SRC_URI_ZEPHYR_HAL_SILABS};name=hal_silabs;nobranch=1;destsuffix=git/modules/hal/silabs \
-    ${SRC_URI_ZEPHYR_HAL_ST};name=hal_st;nobranch=1;destsuffix=git/modules/hal/st \
-    ${SRC_URI_ZEPHYR_HAL_STM32};name=hal_stm32;nobranch=1;destsuffix=git/modules/hal/stm32 \
-    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=git/modules/hal/telink \
-    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=git/modules/hal/ti \
-    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=git/modules/hal/wurthelektronik \
-    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=git/modules/hal/xtensa \
-    ${SRC_URI_ZEPHYR_HOSTAP};name=hostap;nobranch=1;destsuffix=git/modules/lib/hostap \
-    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=git/modules/hal/libmetal \
-    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=git/modules/lib/liblc3 \
-    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=git/modules/fs/littlefs \
-    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=git/modules/lib/loramac-node \
-    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=git/modules/lib/gui/lvgl \
-    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=git/modules/crypto/mbedtls \
-    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=git/bootloader/mcuboot \
-    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=git/modules/debug/mipi-sys-t \
-    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=git/tools/net-tools \
-    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=git/modules/bsim_hw_models/nrf_hw_models \
-    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=git/modules/lib/open-amp \
-    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=git/modules/lib/openthread \
-    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=git/modules/debug/percepio \
-    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=git/modules/lib/picolibc \
-    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=git/modules/debug/segger \
-    ${SRC_URI_ZEPHYR_TINYCRYPT};name=tinycrypt;nobranch=1;destsuffix=git/modules/crypto/tinycrypt \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=git/modules/tee/tf-m/trusted-firmware-m \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=git/modules/tee/tf-a/trusted-firmware-a \
-    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=git/modules/lib/uoscore-uedhoc \
-    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=git/modules/lib/zcbor \
-    ${SRC_URI_PATCHES} \
-"
-
-ZEPHYR_MODULES = "\
-${S}/modules/lib/acpica\;\
-${S}/tools/bsim\;\
-${S}/tools/bsim/components\;\
-${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
-${S}/tools/bsim/components/ext_2G4_phy_v1\;\
-${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
-${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
-${S}/tools/bsim/components/ext_2G4_modem_magic\;\
-${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
-${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
-${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
-${S}/tools/bsim/components/ext_2G4_device_playback\;\
-${S}/tools/bsim/components/ext_libCryptov1\;\
-${S}/modules/hal/cmsis\;\
-${S}/modules/lib/cmsis-dsp\;\
-${S}/modules/lib/cmsis-nn\;\
-${S}/tools/edtt\;\
-${S}/modules/fs/fatfs\;\
-${S}/modules/hal/altera\;\
-${S}/modules/hal/ambiq\;\
-${S}/modules/hal/atmel\;\
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
-${S}/modules/hal/silabs\;\
-${S}/modules/hal/st\;\
-${S}/modules/hal/stm32\;\
-${S}/modules/hal/telink\;\
-${S}/modules/hal/ti\;\
-${S}/modules/hal/wurthelektronik\;\
-${S}/modules/hal/xtensa\;\
-${S}/modules/lib/hostap\;\
-${S}/modules/hal/libmetal\;\
-${S}/modules/lib/liblc3\;\
-${S}/modules/fs/littlefs\;\
-${S}/modules/lib/loramac-node\;\
-${S}/modules/lib/gui/lvgl\;\
-${S}/modules/crypto/mbedtls\;\
-${S}/bootloader/mcuboot\;\
-${S}/modules/debug/mipi-sys-t\;\
-${S}/tools/net-tools\;\
-${S}/modules/bsim_hw_models/nrf_hw_models\;\
-${S}/modules/lib/open-amp\;\
-${S}/modules/lib/openthread\;\
-${S}/modules/debug/percepio\;\
-${S}/modules/lib/picolibc\;\
-${S}/modules/debug/segger\;\
-${S}/modules/crypto/tinycrypt\;\
-${S}/modules/tee/tf-m/trusted-firmware-m\;\
-${S}/modules/tee/tf-a/trusted-firmware-a\;\
-${S}/modules/lib/uoscore-uedhoc\;\
-${S}/modules/lib/zcbor\;\
-"
-
-ZEPHYR_BRANCH = "v3.6-branch"
-PV = "3.6.0+git${SRCPV}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-dev.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-dev.inc
deleted file mode 100644
index da2a5d5..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-dev.inc
+++ /dev/null
@@ -1,17 +0,0 @@
-SRCREV_FORMAT = "default_cmsis"
-SRCREV_default = "72bb75a360ce05bfc94ff0fbecda2e2d094e3d84"
-SRCREV_cmsis = "c3bd2094f92d574377f7af2aec147ae181aa5f8e"
-SRCREV_nordic = "00fd2aa97a22ea1052d9dabe1b18ab396daab93a"
-SRCREV_stm32 = "4200321ef1cd27cacc37b0439389424156bb1267"
-SRCREV_open-amp = "6010f0523cbc75f551d9256cf782f173177acdef"
-SRCREV_openthread = "542b14a5bc5b38f29e2cab892c66da670a524b05"
-SRCREV_libmetal = "39d049d4ae68e6f6d595fce7de1dcfc1024fb4eb"
-SRCREV_tinycrypt = "3e9a49d2672ec01435ffbf0d788db6d95ef28de0"
-SRCREV_mbedtls = "5765cb7f75a9973ae9232d438e361a9d7bbc49e7"
-
-ZEPHYR_BRANCH = "main"
-PV = "2.6.0+git${SRCPV}"
-
-SRC_URI:append = " file://0001-cmake-add-yocto-toolchain.patch \
-                    file://0001-x86-fix-efi-binary-generation-issue-in-cross-compila.patch \
-                    "
-- 
2.37.3


