Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8DCD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 06:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2670.1779085819162090919
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 May 2026 23:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=Advlj7fw;
 spf=pass (domain: intel.com, ip: 198.175.65.18, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779085820; x=1810621820;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=w1UTBfzhbwf08BneV9DaKVB1GbIF58QUvQTJgJ1feu8=;
  b=Advlj7fwNEE8vG3T8ana+cM3EQgjpXK/lt+s9a+SF1OnrEF2fou2SCV8
   x1DsUXKzomqVzXrlFu2GCrW8iW6OkHqRxTfTq/AHpxnns2YpG0hrQxBUL
   EfmpsiS10TEJNJqRJxwA7M8OxPksVSmkQj9BUpjgcLQ9teC4xkwZiolWR
   42+hTedSgRoe1TMc5zGPvSTqa2cUyTc9rIYABWO8dIHYZ4GMbe4jd9bbm
   oSWwdGyLq21n+aZqXC9tAbWziAZdNrAJhi8LLEU1KlVEgsd36LzS+ctpD
   i45E1u7laXT/+lXD0FdAgXYsfjty+zjvdFzVXdm9V5PUBoFEm9IhRK7dg
   w==;
X-CSE-ConnectionGUID: PeaZd17oTb+94njEubolqw==
X-CSE-MsgGUID: hJvb0CzpTFCsNO+On2OuQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79979323"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79979323"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:30:20 -0700
X-CSE-ConnectionGUID: OYNXejGGSBGEXXfBXKq9HQ==
X-CSE-MsgGUID: E0g2XM2GSmOP+Iodqvxq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262852691"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa002.fm.intel.com with ESMTP; 17 May 2026 23:30:19 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr 3/4] zephyr-kernel: add support for v4.4.0
Date: Mon, 18 May 2026 13:14:36 +0800
Message-Id: <20260518051437.693745-3-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20260518051437.693745-1-chee.yang.lee@intel.com>
References: <20260518051437.693745-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 May 2026 06:30:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3999

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 meta-zephyr-core/conf/layer.conf              |   2 +-
 ...ry-generation-issue-in-cross-compila.patch | 119 ++++++
 .../zephyr-kernel/zephyr-kernel-src-4.4.0.inc | 338 ++++++++++++++++++
 .../zephyr-kernel-test-4.4.0.inc              |  86 +++++
 4 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.4.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.4.0.inc
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.4.0.inc

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 29bc671..56e01f8 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -21,5 +21,5 @@ PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages
 
 addpylib ${LAYERDIR}/lib oeqa
 
-PREFERRED_VERSION_zephyr-kernel ??= "4.3.0"
+PREFERRED_VERSION_zephyr-kernel ??= "4.4.0"
 PREFERRED_VERSION_zephyr-sdk-native ??= "0.17.4"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.4.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.4.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
new file mode 100644
index 0000000..2f9a752
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.4.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
@@ -0,0 +1,119 @@
+From 3e437034cd2b2a5a96314115ef738284217f8fbd Mon Sep 17 00:00:00 2001
+From: Naveen Saini <naveen.kumar.saini@intel.com>
+Date: Wed, 16 Apr 2025 14:51:49 +0800
+Subject: [PATCH] x86: fix efi binary generation issue in cross compilation env
+
+Set root directory for headers.
+
+Upstream-Status: Inappropriate [Cross-compilation specific]
+
+Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
+---
+ arch/x86/zefi/zefi.py           | 4 +++-
+ boards/intel/adl/CMakeLists.txt | 1 +
+ boards/intel/btl/CMakeLists.txt | 1 +
+ boards/intel/ehl/CMakeLists.txt | 1 +
+ boards/intel/ptl/CMakeLists.txt | 1 +
+ boards/intel/rpl/CMakeLists.txt | 1 +
+ boards/intel/wcl/CMakeLists.txt | 1 +
+ 7 files changed, 9 insertions(+), 1 deletion(-)
+
+diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
+index b98419f8a49..790797f011a 100755
+--- a/arch/x86/zefi/zefi.py
++++ b/arch/x86/zefi/zefi.py
+@@ -115,8 +115,10 @@ def build_elf(elf_file, include_dirs):
+     includes = []
+     for include_dir in include_dirs:
+         includes.extend(["-I", include_dir])
++    #  Pass --sysroot path for cross compilation
++    sysrootarg = "--sysroot=" + args.sysroot
+     cmd = ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + includes +
+-           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar",
++           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar", sysrootarg,
+             "-Wl,-nostdlib", "-nostartfiles", "-T", ldscript, "-o", "zefi.elf", cfile])
+     verbose(" ".join(cmd))
+     subprocess.run(cmd, check = True)
+@@ -156,6 +157,7 @@ def parse_args():
+     parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
+     parser.add_argument("-i", "--includes", required=True, nargs="+",
+                         help="Zephyr base include directories")
++    parser.add_argument("-s", "--sysroot", required=True, help="Cross compilation --sysroot=path")
+ 
+     return parser.parse_args()
+ 
+diff --git a/boards/intel/adl/CMakeLists.txt b/boards/intel/adl/CMakeLists.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/adl/CMakeLists.txt
++++ b/boards/intel/adl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/btl/CMakeLists.txt b/boards/intel/btl/CMakeLists.txt
+index ee5e7343e83..2e5a0d75442 100644
+--- a/boards/intel/btl/CMakeLists.txt
++++ b/boards/intel/btl/CMakeLists.txt
+@@ -8,6 +8,7 @@ if(CONFIG_BUILD_OUTPUT_EFI)
+     -o ${CMAKE_OBJCOPY}
+     -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+     -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++    -s ${SYSROOT_DIR}
+     $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+     WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+   )
+diff --git a/boards/intel/ehl/CMakeLists.txt b/boards/intel/ehl/CMakeLists.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/ehl/CMakeLists.txt
++++ b/boards/intel/ehl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/ptl/CMakeLists.txt b/boards/intel/ptl/CMakeLists.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/ptl/CMakeLists.txt
++++ b/boards/intel/ptl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/rpl/CMakeLists.txt b/boards/intel/rpl/CMakeLists.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/rpl/CMakeLists.txt
++++ b/boards/intel/rpl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/wcl/CMakeLists.txt b/boards/intel/wcl/CMakeLists.txt
+index 8ea6bcd46e1..59541ba6e0f 100644
+--- a/boards/intel/wcl/CMakeLists.txt
++++ b/boards/intel/wcl/CMakeLists.txt
+@@ -12,6 +12,7 @@ if(CONFIG_BUILD_OUTPUT_EFI)
+       -o ${CMAKE_OBJCOPY}
+       -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+       -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++      -s ${SYSROOT_DIR}
+       $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+     WORKING_DIRECTORY
+       ${PROJECT_BINARY_DIR}
+-- 
+2.37.3
+
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.4.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.4.0.inc
new file mode 100644
index 0000000..c071573
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.4.0.inc
@@ -0,0 +1,338 @@
+# Auto-generated from zephyr-kernel-src.inc.jinja
+
+SRCREV_FORMAT = "default"
+
+SRCREV_default = "684c9e8f32e4373a21098559f748f06915f950c9"
+SRCREV_acpica = "8d24867bc9c9d81c81eeac59391cda59333affd4"
+SRCREV_babblesim_base = "1cce925c72805cfdbb6341ca8c0755c7d42699d3"
+SRCREV_babblesim_ext_2G4_channel_NtNcable = "20a38c997f507b0aa53817aab3d73a462fff7af1"
+SRCREV_babblesim_ext_2G4_channel_multiatt = "bde72a57384dde7a4310bcf3843469401be93074"
+SRCREV_babblesim_ext_2G4_device_WLAN_actmod = "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
+SRCREV_babblesim_ext_2G4_device_burst_interferer = "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
+SRCREV_babblesim_ext_2G4_device_playback = "abb48cd71ddd4e2a9022f4bf49b2712524c483e8"
+SRCREV_babblesim_ext_2G4_libPhyComv1 = "23e7a84f5bc452a361ab30acf3abb9dbdb57e9a8"
+SRCREV_babblesim_ext_2G4_modem_BLE_simple = "3712283f0bd3a982f620908579c99af35e969554"
+SRCREV_babblesim_ext_2G4_modem_magic = "d8281acb634895c8a769489c27146bdfe1a54938"
+SRCREV_babblesim_ext_2G4_phy_v1 = "b0e49ae3dd4d6d0f2286fd1392cee1b5206f5bbc"
+SRCREV_babblesim_ext_libCryptov1 = "da246018ebe031e4fe4a8228187fb459e9f3b2fa"
+SRCREV_bsim = "7e10d556b5dd04360756cdf1f4b80d4f5bcac6cf"
+SRCREV_cmsis = "512cc7e895e8491696b61f7ba8066b4a182569b8"
+SRCREV_cmsis-dsp = "97512610ec92058f0119450b9e743eeb7e95b5c8"
+SRCREV_cmsis-nn = "d20117c9e88cf9018d6fa06744dddac700c3e3a1"
+SRCREV_cmsis_6 = "30a859f44ef8ab4dc8f84b03ed586fd16ccf9d74"
+SRCREV_dhara = "6f163ca05e174b168b4d148160b50eeaeeb561fc"
+SRCREV_edtt = "c282625e694f0b53ea53e13231ea6d2f49411768"
+SRCREV_fatfs = "f4ead3bf4a6dab3a07d7b5f5315795c073db568d"
+SRCREV_hal_adi = "44545c0b31a765c702132f22e797271c3f111eae"
+SRCREV_hal_afbr = "1abf6947457380934e27f92508ec5532ddedfc6d"
+SRCREV_hal_ambiq = "21565be7baa02f03d27a734bf9939c0dcb3cfec9"
+SRCREV_hal_atmel = "8cd575049f04131e333558072484bfc6334c19c4"
+SRCREV_hal_bouffalolab = "c71e1197e7e9e0fd7be801844e09533c030b56a9"
+SRCREV_hal_espressif = "b7953b8019361d09e613f7011d2ccc41b984d087"
+SRCREV_hal_ethos_u = "03567073fe2b9802c0bd73f9534da6f8a03924d1"
+SRCREV_hal_gigadevice = "ee0e31302c21b2a465dc303b3ced8c606c2167c8"
+SRCREV_hal_infineon = "3ae25facf70c296145f6e12aa10b4810d49c2b33"
+SRCREV_hal_intel = "2ddab7fe5bfe85c7af8b87a490c4a0e560dc1078"
+SRCREV_hal_microchip = "86f3ea6b389d860332bd81ae8b97543def619395"
+SRCREV_hal_nordic = "44fd3d44b15cb75f80a25b4679f91d2787e28664"
+SRCREV_hal_nuvoton = "fe26f3a5b3b85fb6b61cc3f744f195e3ab391194"
+SRCREV_hal_nxp = "2c2f28ac333e995d7279777409817c4b4f92c1ec"
+SRCREV_hal_openisa = "eabd530a64d71de91d907bad257cd61aacf607bc"
+SRCREV_hal_quicklogic = "bad894440fe72c814864798c8e3a76d13edffb6c"
+SRCREV_hal_realtek = "84a7fd556d95a411ee3cbf4ed29478eced58fb35"
+SRCREV_hal_renesas = "06282060fa20cbd21d4ebbc7d46a1fc9533fd24e"
+SRCREV_hal_rpi_pico = "562b41e10a1d8b1a761b253b107c5c6a84cf4535"
+SRCREV_hal_sifli = "86fa0e9433fda1a760e0077c19b8407ecceea2f9"
+SRCREV_hal_silabs = "f5201210afa1319ed8dd8dbe21682bcb63b25771"
+SRCREV_hal_st = "7a792882847223c72944791e0c48eed6101e6569"
+SRCREV_hal_stm32 = "39130f29ae37c1db34095478ca02b6419b70dcdc"
+SRCREV_hal_tdk = "fa54cb65535b0ed69564423c9e0bf4e7ee47dcb1"
+SRCREV_hal_telink = "4226c7fc17d5a34e557d026d428fc766191a0800"
+SRCREV_hal_ti = "afbcfffd393be03ca2c9b41f9ce8d94a4c2f2fbd"
+SRCREV_hal_wch = "dd3855ea624b05de7e6e95584789615d2058a0f3"
+SRCREV_hal_wurthelektronik = "7c1297ea071d03289112eb24e789c89c7095c0a2"
+SRCREV_hal_xtensa = "0495a1afd300b644d3ec8dd2c3bd11007e69a892"
+SRCREV_hostap = "aa993679725360c1e370c9695960c6730cb07e8b"
+SRCREV_liblc3 = "48bbd3eacd36e99a57317a0a4867002e0b09e183"
+SRCREV_libmctp = "b97860e78998551af99931ece149eeffc538bdb1"
+SRCREV_libmetal = "66e084293b2a7ced5a73fbd247deddba8915883a"
+SRCREV_libsbc = "8e1beda02acb8972e29e6edbb423f7cafe16e445"
+SRCREV_littlefs = "8f5ca347843363882619d8f96c00d8dbd88a8e79"
+SRCREV_lora-basics-modem = "a8ddc544043e72807cf7db532478e1dda734ae7c"
+SRCREV_loramac-node = "fb00b383072518c918e2258b0916c996f2d4eebe"
+SRCREV_lvgl = "85aa60d18b3d5e5588d7b247abf90198f07c8a63"
+SRCREV_mbedtls = "a3e190fe44c78d1ba67f55979e1257328cc7d0d8"
+SRCREV_mbedtls-3.6 = "a00e23de17b6b0a0de28e180cb186da6f0008836"
+SRCREV_mcuboot = "ee39e2d694bd827ffd1bebbce2f571a9154e6ec2"
+SRCREV_mipi-sys-t = "5a9d6055b62edc54566d6d0034d9daec91749b98"
+SRCREV_mldsa-native = "3fc19982839305d305071f0de0c540bc9c9bea8a"
+SRCREV_nanopb = "5499fd4c9a478f8139eeb07a82c3b4468d6067f7"
+SRCREV_net-tools = "64d7acc661ae2772282570f21beab85d02f2f35c"
+SRCREV_nrf_hw_models = "158b9710d6e10c57b2c623f8f4178f0bbc85c23f"
+SRCREV_nrf_wifi = "cebea8e27ceb91a7d4580d17db65f93669befe72"
+SRCREV_open-amp = "5efe7974f9546582e99f5a842a816ea4b65f5227"
+SRCREV_openthread = "e4d97681c53ec1cc34af1404ad2960adda4ba691"
+SRCREV_percepio = "f9159fe3c79578e8d90c8593e83f9862d9b8962c"
+SRCREV_picolibc = "01254932e8e81085817ed61fd858648584ffe37c"
+SRCREV_psa-arch-tests = "6e8219237435112df33bbcf37b7f5657fcfb9cff"
+SRCREV_segger = "50892fdbcf2f570e67baa72b8894a66b16946f72"
+SRCREV_tf-m-tests = "cde5b6ed540d3ff5a09564fded6b39b0a70ad3bf"
+SRCREV_tf-psa-crypto = "dc575a2ddcc8cb16275d24c42a52eaf79ebe2231"
+SRCREV_trusted-firmware-a = "4aef38a5bf03edfa615c1f8af5a49e7065f9fb3f"
+SRCREV_trusted-firmware-m = "9a4cb1a280b63a5e66bd469e82eb75f2b3e05a78"
+SRCREV_uoscore-uedhoc = "dc0ab6345450668de3f9597320a48c5a2d409bb6"
+SRCREV_zcbor = "9164bd18dcd88ff9d9ef98279501fc1093571017"
+
+SRC_URI_ZEPHYR ?= "git://github.com/zephyrproject-rtos/zephyr.git;protocol=https"
+SRC_URI_ZEPHYR_ACPICA ?= "git://github.com/zephyrproject-rtos/acpica;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_BASE ?= "git://github.com/BabbleSim/base;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?= "git://github.com/BabbleSim/ext_2G4_channel_NtNcable;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?= "git://github.com/BabbleSim/ext_2G4_channel_multiatt;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?= "git://github.com/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?= "git://github.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?= "git://github.com/BabbleSim/ext_2G4_device_playback;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?= "git://github.com/BabbleSim/ext_2G4_libPhyComv1;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?= "git://github.com/BabbleSim/ext_2G4_modem_BLE_simple;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?= "git://github.com/BabbleSim/ext_2G4_modem_magic;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?= "git://github.com/BabbleSim/ext_2G4_phy_v1;protocol=https"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?= "git://github.com/BabbleSim/ext_libCryptov1;protocol=https"
+SRC_URI_ZEPHYR_BSIM ?= "git://github.com/zephyrproject-rtos/babblesim-manifest;protocol=https"
+SRC_URI_ZEPHYR_CMSIS ?= "git://github.com/zephyrproject-rtos/cmsis;protocol=https"
+SRC_URI_ZEPHYR_CMSIS_DSP ?= "git://github.com/zephyrproject-rtos/cmsis-dsp;protocol=https"
+SRC_URI_ZEPHYR_CMSIS_NN ?= "git://github.com/zephyrproject-rtos/cmsis-nn;protocol=https"
+SRC_URI_ZEPHYR_CMSIS_6 ?= "git://github.com/zephyrproject-rtos/CMSIS_6;protocol=https"
+SRC_URI_ZEPHYR_DHARA ?= "git://github.com/zephyrproject-rtos/dhara;protocol=https"
+SRC_URI_ZEPHYR_EDTT ?= "git://github.com/zephyrproject-rtos/edtt;protocol=https"
+SRC_URI_ZEPHYR_FATFS ?= "git://github.com/zephyrproject-rtos/fatfs;protocol=https"
+SRC_URI_ZEPHYR_HAL_ADI ?= "git://github.com/zephyrproject-rtos/hal_adi;protocol=https"
+SRC_URI_ZEPHYR_HAL_AFBR ?= "git://github.com/zephyrproject-rtos/hal_afbr;protocol=https"
+SRC_URI_ZEPHYR_HAL_AMBIQ ?= "git://github.com/zephyrproject-rtos/hal_ambiq;protocol=https"
+SRC_URI_ZEPHYR_HAL_ATMEL ?= "git://github.com/zephyrproject-rtos/hal_atmel;protocol=https"
+SRC_URI_ZEPHYR_HAL_BOUFFALOLAB ?= "git://github.com/zephyrproject-rtos/hal_bouffalolab;protocol=https"
+SRC_URI_ZEPHYR_HAL_ESPRESSIF ?= "git://github.com/zephyrproject-rtos/hal_espressif;protocol=https"
+SRC_URI_ZEPHYR_HAL_ETHOS_U ?= "git://github.com/zephyrproject-rtos/hal_ethos_u;protocol=https"
+SRC_URI_ZEPHYR_HAL_GIGADEVICE ?= "git://github.com/zephyrproject-rtos/hal_gigadevice;protocol=https"
+SRC_URI_ZEPHYR_HAL_INFINEON ?= "git://github.com/zephyrproject-rtos/hal_infineon;protocol=https"
+SRC_URI_ZEPHYR_HAL_INTEL ?= "git://github.com/zephyrproject-rtos/hal_intel;protocol=https"
+SRC_URI_ZEPHYR_HAL_MICROCHIP ?= "git://github.com/zephyrproject-rtos/hal_microchip;protocol=https"
+SRC_URI_ZEPHYR_HAL_NORDIC ?= "git://github.com/zephyrproject-rtos/hal_nordic;protocol=https"
+SRC_URI_ZEPHYR_HAL_NUVOTON ?= "git://github.com/zephyrproject-rtos/hal_nuvoton;protocol=https"
+SRC_URI_ZEPHYR_HAL_NXP ?= "git://github.com/zephyrproject-rtos/hal_nxp;protocol=https"
+SRC_URI_ZEPHYR_HAL_OPENISA ?= "git://github.com/zephyrproject-rtos/hal_openisa;protocol=https"
+SRC_URI_ZEPHYR_HAL_QUICKLOGIC ?= "git://github.com/zephyrproject-rtos/hal_quicklogic;protocol=https"
+SRC_URI_ZEPHYR_HAL_REALTEK ?= "git://github.com/zephyrproject-rtos/hal_realtek;protocol=https"
+SRC_URI_ZEPHYR_HAL_RENESAS ?= "git://github.com/zephyrproject-rtos/hal_renesas;protocol=https"
+SRC_URI_ZEPHYR_HAL_RPI_PICO ?= "git://github.com/zephyrproject-rtos/hal_rpi_pico;protocol=https"
+SRC_URI_ZEPHYR_HAL_SIFLI ?= "git://github.com/zephyrproject-rtos/hal_sifli;protocol=https"
+SRC_URI_ZEPHYR_HAL_SILABS ?= "git://github.com/zephyrproject-rtos/hal_silabs;protocol=https"
+SRC_URI_ZEPHYR_HAL_ST ?= "git://github.com/zephyrproject-rtos/hal_st;protocol=https"
+SRC_URI_ZEPHYR_HAL_STM32 ?= "git://github.com/zephyrproject-rtos/hal_stm32;protocol=https"
+SRC_URI_ZEPHYR_HAL_TDK ?= "git://github.com/zephyrproject-rtos/hal_tdk;protocol=https"
+SRC_URI_ZEPHYR_HAL_TELINK ?= "git://github.com/zephyrproject-rtos/hal_telink;protocol=https"
+SRC_URI_ZEPHYR_HAL_TI ?= "git://github.com/zephyrproject-rtos/hal_ti;protocol=https"
+SRC_URI_ZEPHYR_HAL_WCH ?= "git://github.com/zephyrproject-rtos/hal_wch;protocol=https"
+SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?= "git://github.com/zephyrproject-rtos/hal_wurthelektronik;protocol=https"
+SRC_URI_ZEPHYR_HAL_XTENSA ?= "git://github.com/zephyrproject-rtos/hal_xtensa;protocol=https"
+SRC_URI_ZEPHYR_HOSTAP ?= "git://github.com/zephyrproject-rtos/hostap;protocol=https"
+SRC_URI_ZEPHYR_LIBLC3 ?= "git://github.com/zephyrproject-rtos/liblc3;protocol=https"
+SRC_URI_ZEPHYR_LIBMCTP ?= "git://github.com/zephyrproject-rtos/libmctp;protocol=https"
+SRC_URI_ZEPHYR_LIBMETAL ?= "git://github.com/zephyrproject-rtos/libmetal;protocol=https"
+SRC_URI_ZEPHYR_LIBSBC ?= "git://github.com/zephyrproject-rtos/libsbc;protocol=https"
+SRC_URI_ZEPHYR_LITTLEFS ?= "git://github.com/zephyrproject-rtos/littlefs;protocol=https"
+SRC_URI_ZEPHYR_LORA_BASICS_MODEM ?= "git://github.com/zephyrproject-rtos/lora-basics-modem;protocol=https"
+SRC_URI_ZEPHYR_LORAMAC_NODE ?= "git://github.com/zephyrproject-rtos/loramac-node;protocol=https"
+SRC_URI_ZEPHYR_LVGL ?= "git://github.com/zephyrproject-rtos/lvgl;protocol=https"
+SRC_URI_ZEPHYR_MBEDTLS ?= "git://github.com/zephyrproject-rtos/mbedtls;protocol=https"
+SRC_URI_ZEPHYR_MBEDTLS_3.6 ?= "git://github.com/zephyrproject-rtos/mbedtls;protocol=https"
+SRC_URI_ZEPHYR_MCUBOOT ?= "git://github.com/zephyrproject-rtos/mcuboot;protocol=https"
+SRC_URI_ZEPHYR_MIPI_SYS_T ?= "git://github.com/zephyrproject-rtos/mipi-sys-t;protocol=https"
+SRC_URI_ZEPHYR_MLDSA_NATIVE ?= "git://github.com/zephyrproject-rtos/mldsa-native;protocol=https"
+SRC_URI_ZEPHYR_NANOPB ?= "git://github.com/zephyrproject-rtos/nanopb;protocol=https"
+SRC_URI_ZEPHYR_NET_TOOLS ?= "git://github.com/zephyrproject-rtos/net-tools;protocol=https"
+SRC_URI_ZEPHYR_NRF_HW_MODELS ?= "git://github.com/zephyrproject-rtos/nrf_hw_models;protocol=https"
+SRC_URI_ZEPHYR_NRF_WIFI ?= "git://github.com/zephyrproject-rtos/nrf_wifi;protocol=https"
+SRC_URI_ZEPHYR_OPEN_AMP ?= "git://github.com/zephyrproject-rtos/open-amp;protocol=https"
+SRC_URI_ZEPHYR_OPENTHREAD ?= "git://github.com/zephyrproject-rtos/openthread;protocol=https"
+SRC_URI_ZEPHYR_PERCEPIO ?= "git://github.com/zephyrproject-rtos/percepio;protocol=https"
+SRC_URI_ZEPHYR_PICOLIBC ?= "git://github.com/zephyrproject-rtos/picolibc;protocol=https"
+SRC_URI_ZEPHYR_PSA_ARCH_TESTS ?= "git://github.com/zephyrproject-rtos/psa-arch-tests;protocol=https"
+SRC_URI_ZEPHYR_SEGGER ?= "git://github.com/zephyrproject-rtos/segger;protocol=https"
+SRC_URI_ZEPHYR_TF_M_TESTS ?= "git://github.com/zephyrproject-rtos/tf-m-tests;protocol=https"
+SRC_URI_ZEPHYR_TF_PSA_CRYPTO ?= "git://github.com/zephyrproject-rtos/tf-psa-crypto;protocol=https"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?= "git://github.com/zephyrproject-rtos/trusted-firmware-a;protocol=https"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?= "git://github.com/zephyrproject-rtos/trusted-firmware-m;protocol=https"
+SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?= "git://github.com/zephyrproject-rtos/uoscore-uedhoc;protocol=https"
+SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=https"
+
+SRC_URI_PATCHES ?= "\
+    file://0001-v4.4.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
+"
+
+SRC_URI = "\
+    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=${P}/zephyr \
+    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=${P}/modules/lib/acpica \
+    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=${P}/tools/bsim/components \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_NtNcable \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_multiatt \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_WLAN_actmod \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_burst_interferer \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_playback \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_libPhyComv1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_BLE_simple \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_magic \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_phy_v1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_libCryptov1 \
+    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=${P}/tools/bsim \
+    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=${P}/modules/hal/cmsis \
+    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=${P}/modules/lib/cmsis-dsp \
+    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=${P}/modules/lib/cmsis-nn \
+    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=${P}/modules/hal/cmsis_6 \
+    ${SRC_URI_ZEPHYR_DHARA};name=dhara;nobranch=1;destsuffix=${P}/modules/lib/dhara \
+    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=${P}/tools/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=${P}/modules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=${P}/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_AFBR};name=hal_afbr;nobranch=1;destsuffix=${P}/modules/hal/afbr \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=${P}/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=${P}/modules/hal/atmel \
+    ${SRC_URI_ZEPHYR_HAL_BOUFFALOLAB};name=hal_bouffalolab;nobranch=1;destsuffix=${P}/modules/hal/bouffalolab \
+    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=hal_espressif;nobranch=1;destsuffix=${P}/modules/hal/espressif \
+    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=hal_ethos_u;nobranch=1;destsuffix=${P}/modules/hal/ethos_u \
+    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=hal_gigadevice;nobranch=1;destsuffix=${P}/modules/hal/gigadevice \
+    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=hal_infineon;nobranch=1;destsuffix=${P}/modules/hal/infineon \
+    ${SRC_URI_ZEPHYR_HAL_INTEL};name=hal_intel;nobranch=1;destsuffix=${P}/modules/hal/intel \
+    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=hal_microchip;nobranch=1;destsuffix=${P}/modules/hal/microchip \
+    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=hal_nordic;nobranch=1;destsuffix=${P}/modules/hal/nordic \
+    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=hal_nuvoton;nobranch=1;destsuffix=${P}/modules/hal/nuvoton \
+    ${SRC_URI_ZEPHYR_HAL_NXP};name=hal_nxp;nobranch=1;destsuffix=${P}/modules/hal/nxp \
+    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=hal_openisa;nobranch=1;destsuffix=${P}/modules/hal/openisa \
+    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=hal_quicklogic;nobranch=1;destsuffix=${P}/modules/hal/quicklogic \
+    ${SRC_URI_ZEPHYR_HAL_REALTEK};name=hal_realtek;nobranch=1;destsuffix=${P}/modules/hal/realtek \
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=${P}/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=${P}/modules/hal/rpi_pico \
+    ${SRC_URI_ZEPHYR_HAL_SIFLI};name=hal_sifli;nobranch=1;destsuffix=${P}/modules/hal/sifli \
+    ${SRC_URI_ZEPHYR_HAL_SILABS};name=hal_silabs;nobranch=1;destsuffix=${P}/modules/hal/silabs \
+    ${SRC_URI_ZEPHYR_HAL_ST};name=hal_st;nobranch=1;destsuffix=${P}/modules/hal/st \
+    ${SRC_URI_ZEPHYR_HAL_STM32};name=hal_stm32;nobranch=1;destsuffix=${P}/modules/hal/stm32 \
+    ${SRC_URI_ZEPHYR_HAL_TDK};name=hal_tdk;nobranch=1;destsuffix=${P}/modules/hal/tdk \
+    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=${P}/modules/hal/telink \
+    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=${P}/modules/hal/ti \
+    ${SRC_URI_ZEPHYR_HAL_WCH};name=hal_wch;nobranch=1;destsuffix=${P}/modules/hal/wch \
+    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=${P}/modules/hal/wurthelektronik \
+    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=${P}/modules/hal/xtensa \
+    ${SRC_URI_ZEPHYR_HOSTAP};name=hostap;nobranch=1;destsuffix=${P}/modules/lib/hostap \
+    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=${P}/modules/lib/liblc3 \
+    ${SRC_URI_ZEPHYR_LIBMCTP};name=libmctp;nobranch=1;destsuffix=${P}/modules/lib/libmctp \
+    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=${P}/modules/hal/libmetal \
+    ${SRC_URI_ZEPHYR_LIBSBC};name=libsbc;nobranch=1;destsuffix=${P}/modules/lib/libsbc \
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=${P}/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORA_BASICS_MODEM};name=lora-basics-modem;nobranch=1;destsuffix=${P}/modules/lib/lora-basics-modem \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=${P}/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=${P}/modules/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=${P}/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MBEDTLS_3.6};name=mbedtls-3.6;nobranch=1;destsuffix=${P}/modules/crypto/mbedtls-3.6 \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=${P}/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=${P}/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_MLDSA_NATIVE};name=mldsa-native;nobranch=1;destsuffix=${P}/modules/crypto/mldsa-native \
+    ${SRC_URI_ZEPHYR_NANOPB};name=nanopb;nobranch=1;destsuffix=${P}/modules/lib/nanopb \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=${P}/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=${P}/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_NRF_WIFI};name=nrf_wifi;nobranch=1;destsuffix=${P}/modules/lib/nrf_wifi \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=${P}/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=${P}/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=${P}/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=${P}/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_PSA_ARCH_TESTS};name=psa-arch-tests;nobranch=1;destsuffix=${P}/modules/tee/tf-m/psa-arch-tests \
+    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=${P}/modules/debug/segger \
+    ${SRC_URI_ZEPHYR_TF_M_TESTS};name=tf-m-tests;nobranch=1;destsuffix=${P}/modules/tee/tf-m/tf-m-tests \
+    ${SRC_URI_ZEPHYR_TF_PSA_CRYPTO};name=tf-psa-crypto;nobranch=1;destsuffix=${P}/modules/crypto/tf-psa-crypto \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=${P}/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=${P}/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=${P}/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=${P}/modules/lib/zcbor \
+    ${SRC_URI_PATCHES} \
+"
+
+ZEPHYR_MODULES = "\
+${S}/modules/lib/acpica\;\
+${S}/tools/bsim/components\;\
+${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
+${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
+${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
+${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
+${S}/tools/bsim/components/ext_2G4_device_playback\;\
+${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
+${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
+${S}/tools/bsim/components/ext_2G4_modem_magic\;\
+${S}/tools/bsim/components/ext_2G4_phy_v1\;\
+${S}/tools/bsim/components/ext_libCryptov1\;\
+${S}/tools/bsim\;\
+${S}/modules/hal/cmsis\;\
+${S}/modules/lib/cmsis-dsp\;\
+${S}/modules/lib/cmsis-nn\;\
+${S}/modules/hal/cmsis_6\;\
+${S}/modules/lib/dhara\;\
+${S}/tools/edtt\;\
+${S}/modules/fs/fatfs\;\
+${S}/modules/hal/adi\;\
+${S}/modules/hal/afbr\;\
+${S}/modules/hal/ambiq\;\
+${S}/modules/hal/atmel\;\
+${S}/modules/hal/bouffalolab\;\
+${S}/modules/hal/espressif\;\
+${S}/modules/hal/ethos_u\;\
+${S}/modules/hal/gigadevice\;\
+${S}/modules/hal/infineon\;\
+${S}/modules/hal/intel\;\
+${S}/modules/hal/microchip\;\
+${S}/modules/hal/nordic\;\
+${S}/modules/hal/nuvoton\;\
+${S}/modules/hal/nxp\;\
+${S}/modules/hal/openisa\;\
+${S}/modules/hal/quicklogic\;\
+${S}/modules/hal/realtek\;\
+${S}/modules/hal/renesas\;\
+${S}/modules/hal/rpi_pico\;\
+${S}/modules/hal/sifli\;\
+${S}/modules/hal/silabs\;\
+${S}/modules/hal/st\;\
+${S}/modules/hal/stm32\;\
+${S}/modules/hal/tdk\;\
+${S}/modules/hal/telink\;\
+${S}/modules/hal/ti\;\
+${S}/modules/hal/wch\;\
+${S}/modules/hal/wurthelektronik\;\
+${S}/modules/hal/xtensa\;\
+${S}/modules/lib/hostap\;\
+${S}/modules/lib/liblc3\;\
+${S}/modules/lib/libmctp\;\
+${S}/modules/hal/libmetal\;\
+${S}/modules/lib/libsbc\;\
+${S}/modules/fs/littlefs\;\
+${S}/modules/lib/lora-basics-modem\;\
+${S}/modules/lib/loramac-node\;\
+${S}/modules/lib/gui/lvgl\;\
+${S}/modules/crypto/mbedtls\;\
+${S}/modules/crypto/mbedtls-3.6\;\
+${S}/bootloader/mcuboot\;\
+${S}/modules/debug/mipi-sys-t\;\
+${S}/modules/crypto/mldsa-native\;\
+${S}/modules/lib/nanopb\;\
+${S}/tools/net-tools\;\
+${S}/modules/bsim_hw_models/nrf_hw_models\;\
+${S}/modules/lib/nrf_wifi\;\
+${S}/modules/lib/open-amp\;\
+${S}/modules/lib/openthread\;\
+${S}/modules/debug/percepio\;\
+${S}/modules/lib/picolibc\;\
+${S}/modules/tee/tf-m/psa-arch-tests\;\
+${S}/modules/debug/segger\;\
+${S}/modules/tee/tf-m/tf-m-tests\;\
+${S}/modules/crypto/tf-psa-crypto\;\
+${S}/modules/tee/tf-a/trusted-firmware-a\;\
+${S}/modules/tee/tf-m/trusted-firmware-m\;\
+${S}/modules/lib/uoscore-uedhoc\;\
+${S}/modules/lib/zcbor\;\
+"
+
+ZEPHYR_BRANCH = "v4.4-branch"
+PV = "4.4.0+git${SRCPV}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.4.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.4.0.inc
new file mode 100644
index 0000000..080cff4
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.4.0.inc
@@ -0,0 +1,86 @@
+# Exclude tests that fail to configure
+ZEPHYRTESTS:remove = " condvar \
+    events \
+    fatal \
+    fifo \
+    fpu_sharing \
+    lifo \
+    mbox \
+    mem_heap \
+    mem_pool \
+    mem_protect \
+    mem_slab \
+    msgq \
+    mutex \
+    pipe \
+    profiling \
+    sched \
+    semaphore \
+    stack \
+    threads \
+    tickless \
+    timer \
+    usage \
+    workq"
+
+# Exclude tests that are not currently compiling
+ZEPHYRTESTS:remove = "ipi_cascade \
+    ipi_optimize \
+    ipi_work \
+    mp \
+    smp \
+    smp_abort \
+    smp_boot_delay \
+    smp_metairq \
+    smp_suspend  \
+    spinlock"
+
+ZEPHYRTESTS:remove:96b-avenger96 = "cache common device poll queue sleep"
+ZEPHYRTESTS:remove:stm32mp157c-dk2 = "cache common device poll queue sleep"
+
+# List of all available kernel tests
+ZEPHYRTESTS = " \
+    cache \
+    cleanup \
+    common \
+    condvar \
+    context \
+    device \
+    early_sleep \
+    events \
+    fatal \
+    fifo \
+    fpu_sharing \
+    ipi_cascade \
+    ipi_optimize \
+    ipi_work \
+    lifo \
+    mbox \
+    mem_heap \
+    mem_protect \
+    mem_slab \
+    mp \
+    msgq \
+    mutex \
+    obj_tracking \
+    pending \
+    pipe \
+    poll \
+    profiling \
+    queue \
+    sched \
+    semaphore \
+    sleep \
+    smp \
+    smp_abort \
+    smp_boot_delay \
+    smp_metairq \
+    smp_suspend \
+    spinlock \
+    stack \
+    threads \
+    tickless \
+    timer \
+    usage \
+    workq \
+    "
-- 
2.37.3


