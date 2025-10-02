Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7941CCA472
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 06:41:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mx.groups.io with SMTP id smtpd.web10.2776.1759387291679285643
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 23:41:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=GkcCWzhD;
 spf=pass (domain: intel.com, ip: 192.198.163.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759387292; x=1790923292;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qhcazAcDzsCifdid1OnvBFejGY5cTOyDl8RDsljfX+M=;
  b=GkcCWzhDrYmXI7/zNr+kg296reefOUs4SNqlL77vlbXVomHLtn+gslhd
   UNEJoy4VKs8JX2h0wyPVUHQK9AAOLrdIhor+oVoZTjZ/jLvw5/X0/1VNK
   L9cvxnFhH6+Ttm7I3YGtdQ87Q5X+N2SZCn/OTHF4dPcsC+DFmxSoM7Xxx
   Xtqh51Iv7B1jj5V5H70hkREAo+BTpc9XPCJR0u9mPa4dGuUMlnZ8qDuPP
   DEKm9DnrBVncgdIxZi+uXgbn+k5lMMCmbPBs+OzbA6lRTbYyUTgOUExM+
   D9o+gA4y+yAVprLV+g5nq2bpgCE7QraVjRdPKqhBG2BNAISOL1izV5KP3
   Q==;
X-CSE-ConnectionGUID: n2Vkdl4wSw6NrvFoQ3Y4hA==
X-CSE-MsgGUID: NhrQRP1KSy2pRBkNtjqeKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="64287452"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="64287452"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 23:41:31 -0700
X-CSE-ConnectionGUID: WCN3X19DSHOjti1ZvSrjfg==
X-CSE-MsgGUID: e38vOi+PSpKLpOZuafTChw==
X-ExtLoop1: 1
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 23:41:30 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr 1/2] zephyr-kernel: update to 4.2.0
Date: Thu,  2 Oct 2025 13:36:04 +0800
Message-Id: <20251002053605.1310630-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Oct 2025 06:41:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2269

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 meta-zephyr-core/conf/layer.conf              |  2 +-
 ...y-generation-issue-in-cross-compila.patch} |  0
 ...-4.1.0.inc => zephyr-kernel-src-4.2.0.inc} | 94 ++++++++++---------
 3 files changed, 50 insertions(+), 46 deletions(-)
 rename meta-zephyr-core/recipes-kernel/zephyr-kernel/files/{0001-v4.1.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch => 0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch} (100%)
 rename meta-zephyr-core/recipes-kernel/zephyr-kernel/{zephyr-kernel-src-4.1.0.inc => zephyr-kernel-src-4.2.0.inc} (85%)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index c04088f..e5d0ae3 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -21,5 +21,5 @@ PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages
 
 addpylib ${LAYERDIR}/lib oeqa
 
-PREFERRED_VERSION_zephyr-kernel ??= "4.1.0"
+PREFERRED_VERSION_zephyr-kernel ??= "4.2.0"
 PREFERRED_VERSION_zephyr-sdk ??= "0.16.9"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.1.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
similarity index 100%
rename from meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.1.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
rename to meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
similarity index 85%
rename from meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc
rename to meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
index 911fabf..40bfb6c 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
@@ -2,73 +2,74 @@
 
 SRCREV_FORMAT = "default"
 
-SRCREV_default = "7823374e872145b5bd018bfe447839eb36042611"
+SRCREV_default = "413b789deb391d3a37d06b463288a5fe765ee57e"
 SRCREV_acpica = "8d24867bc9c9d81c81eeac59391cda59333affd4"
-SRCREV_babblesim_base = "153101c61ce7106f6ba8b108b5c6488efdc1151a"
+SRCREV_babblesim_base = "2cfac3dca2071452ae481d115d8541880568753d"
 SRCREV_babblesim_ext_2G4_channel_NtNcable = "20a38c997f507b0aa53817aab3d73a462fff7af1"
 SRCREV_babblesim_ext_2G4_channel_multiatt = "bde72a57384dde7a4310bcf3843469401be93074"
 SRCREV_babblesim_ext_2G4_device_WLAN_actmod = "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
 SRCREV_babblesim_ext_2G4_device_burst_interferer = "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
 SRCREV_babblesim_ext_2G4_device_playback = "abb48cd71ddd4e2a9022f4bf49b2712524c483e8"
-SRCREV_babblesim_ext_2G4_libPhyComv1 = "15ae0f87fa049e04cbec48a866f3bc37d903f950"
+SRCREV_babblesim_ext_2G4_libPhyComv1 = "e18e41e8e3fa9f996559ed98b9238a5702dcdd36"
 SRCREV_babblesim_ext_2G4_modem_BLE_simple = "4d2379de510684cd4b1c3bbbb09bce7b5a20bc1f"
 SRCREV_babblesim_ext_2G4_modem_magic = "edfcda2d3937a74be0a59d6cd47e0f50183453da"
-SRCREV_babblesim_ext_2G4_phy_v1 = "62e797b2c518e5bb6123a198382ed2b64b8c068e"
+SRCREV_babblesim_ext_2G4_phy_v1 = "8964ed1eb94606c2ea555340907bdc5171793e65"
 SRCREV_babblesim_ext_libCryptov1 = "da246018ebe031e4fe4a8228187fb459e9f3b2fa"
-SRCREV_bsim = "a88d3353451387ca490a6a7f7c478a90c4ee05b7"
-SRCREV_cmsis = "d1b8b20b6278615b00e136374540eb1c00dcabe7"
+SRCREV_bsim = "2ba22a0608ad9f46da1b96ee5121af357053c791"
+SRCREV_cmsis = "512cc7e895e8491696b61f7ba8066b4a182569b8"
 SRCREV_cmsis-dsp = "d80a49b2bb186317dc1db4ac88da49c0ab77e6e7"
 SRCREV_cmsis-nn = "e9328d612ea3ea7d0d210d3ac16ea8667c01abdd"
-SRCREV_cmsis_6 = "783317a3072554acbac86cca2ff24928cbf98d30"
+SRCREV_cmsis_6 = "06d952b6713a2ca41c9224a62075e4059402a151"
 SRCREV_edtt = "b9ca3c7030518f07b7937dacf970d37a47865a76"
 SRCREV_fatfs = "16245c7c41d2b79e74984f49b5202551786b8a9b"
-SRCREV_hal_adi = "633fcecf3717aaa22079cf6121627a879f24df51"
-SRCREV_hal_altera = "4fe4df959d4593ce66e676aeba0b57f546dba0fe"
-SRCREV_hal_ambiq = "87a188b91aca22ce3ce7deb4a1cbf7780d784673"
-SRCREV_hal_atmel = "da767444cce3c1d9ccd6b8a35fd7c67dc82d489c"
-SRCREV_hal_espressif = "202c59552dc98e5cd02386313e1977ecb17a131f"
+SRCREV_hal_adi = "16829b77264678f31a2d077a870af7bdca2d39bd"
+SRCREV_hal_afbr = "4e1eea7ea283db9d9ce529b0e9f89c0b5c2660e3"
+SRCREV_hal_ambiq = "84ccbfc0b6041ba9f5688337c78bad99da5448ce"
+SRCREV_hal_atmel = "ca7e4c6920f44b9d677ed5995ffa169f18a54cdf"
+SRCREV_hal_bouffalolab = "5811738e2be348f30dc97d78280f2735d5d14084"
+SRCREV_hal_espressif = "f3453bdeced28642424692aae32cce4eec3f2d7f"
 SRCREV_hal_ethos_u = "50ddffca1cc700112f25ad9bc077915a0355ee5d"
 SRCREV_hal_gigadevice = "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
-SRCREV_hal_infineon = "468e955eb49b8a731474ff194ca17b6e6a08c2d9"
-SRCREV_hal_intel = "0355bb816263c54eed23c7781034447af5d8200c"
-SRCREV_hal_microchip = "fa2431a906ffb560160d40739d7cf04169551103"
-SRCREV_hal_nordic = "37ca068d7b013fb65a2acc9306bffa48a3e72839"
-SRCREV_hal_nuvoton = "466c3eed9c98453fb23953bf0e0427fea01924be"
-SRCREV_hal_nxp = "9dc7449014a7380355612453b31be479cb3a6833"
+SRCREV_hal_infineon = "1030915af885cffc8cedc49a62291dd279a9e81e"
+SRCREV_hal_intel = "0447cd22e74d7ca243653f21cfd6e38c016630c6"
+SRCREV_hal_microchip = "32a79d481c056b2204a5701d5a5799f9e5130dd7"
+SRCREV_hal_nordic = "9587b1dcb83d24ab74e89837843a5f7d573f7059"
+SRCREV_hal_nuvoton = "be1042dc8a96ebe9ea4c5d714f07c617539106d6"
+SRCREV_hal_nxp = "7a52cbb7cb56db3a276cbd617db3ea7cc3435d12"
 SRCREV_hal_openisa = "eabd530a64d71de91d907bad257cd61aacf607bc"
 SRCREV_hal_quicklogic = "bad894440fe72c814864798c8e3a76d13edffb6c"
-SRCREV_hal_renesas = "3204903bdc5eda6869a40363560a69369c8d0e22"
+SRCREV_hal_renesas = "0769fe1520f6c14e6301188588da758a609f181d"
 SRCREV_hal_rpi_pico = "7b57b24588797e6e7bf18b6bda168e6b96374264"
-SRCREV_hal_silabs = "8a173e9e566a396a19d18da4661cb54ce098f268"
-SRCREV_hal_st = "05fd4533730a9aea845261c5d24ed9832a6f0b6e"
-SRCREV_hal_stm32 = "55043bcc35fffa3b4a8c75a696d932b5020aad09"
+SRCREV_hal_silabs = "190a144a16bed9a938a94543ed5bbc70c0552e0f"
+SRCREV_hal_st = "9f81b4427e955885398805b7bca0da3a8cd9109c"
+SRCREV_hal_stm32 = "1e753266ddfb4b07a8a0b1ec566e9637ea45d5ef"
 SRCREV_hal_tdk = "6727477af1e46fa43878102489b9672a9d24e39f"
 SRCREV_hal_telink = "4226c7fc17d5a34e557d026d428fc766191a0800"
-SRCREV_hal_ti = "258652a3ac5d7df68ba8df20e4705c3bd98ede38"
-SRCREV_hal_wch = "1de9d3e406726702ce7cfc504509a02ecc463554"
+SRCREV_hal_ti = "bc8e7b99bb668cc51a3aa384448a48c48a33f8e2"
+SRCREV_hal_wch = "6dd313768b5f4cc69baeac4ce6e59f2038eb8ce5"
 SRCREV_hal_wurthelektronik = "e3e2797b224fc48fdef1bc3e5a12a7c73108bba2"
-SRCREV_hal_xtensa = "baa56aa3e119b5aae43d16f9b2d2c8112e052871"
-SRCREV_hostap = "697fd2cf5cbbd0c5375fc34761b6a9d7489a67d2"
+SRCREV_hal_xtensa = "b38620c7cc61e349e192ed86a54940a5cd0636b7"
+SRCREV_hostap = "e942f86e865d5b24bbbe8b0c333f030cbbe62bfb"
 SRCREV_liblc3 = "48bbd3eacd36e99a57317a0a4867002e0b09e183"
 SRCREV_libmctp = "b97860e78998551af99931ece149eeffc538bdb1"
-SRCREV_libmetal = "3e8781aae9d7285203118c05bc01d4eb0ca565a7"
-SRCREV_littlefs = "ed0531d59ee37f5fb2762bcf2fc8ba4efaf82656"
+SRCREV_libmetal = "91d38634d1882f0a2151966f8c5c230ce1c0de7b"
+SRCREV_littlefs = "8f5ca347843363882619d8f96c00d8dbd88a8e79"
 SRCREV_loramac-node = "fb00b383072518c918e2258b0916c996f2d4eebe"
-SRCREV_lvgl = "1ed1ddd881c3784049a92bb9fe37c38c6c74d998"
-SRCREV_mbedtls = "4952e1328529ee549d412b498ea71c54f30aa3b1"
-SRCREV_mcuboot = "346f7374ff4467e40b5594658f8ac67a5e9813c9"
+SRCREV_lvgl = "b03edc8e6282a963cd312cd0b409eb5ce263ea75"
+SRCREV_mbedtls = "85440ef5fffa95d0e9971e9163719189cf34d979"
+SRCREV_mcuboot = "4eba8087fa606db801455f14d185255bc8c49467"
 SRCREV_mipi-sys-t = "33e5c23cbedda5ba12dbe50c4baefb362a791001"
-SRCREV_net-tools = "93acc8bac4661e74e695eb1aea94c7c5262db2e2"
-SRCREV_nrf_hw_models = "73a5d5827a94820be65b7d276d28173ec10bab9f"
-SRCREV_nrf_wifi = "e35f707a782b7c4c0eb83a3b06ca4e6eb693f29f"
-SRCREV_open-amp = "52bb1783521c62c019451cee9b05b8eda9d7425f"
+SRCREV_net-tools = "986bfeb040df3d9029366de8aea4ce1f84e93780"
+SRCREV_nrf_hw_models = "6e5961223f81aa2707c555db138819a5c1b7942c"
+SRCREV_nrf_wifi = "5f59c2336c69f28ae83f93812a1d726f9fceabfe"
+SRCREV_open-amp = "c30a6d8b92fcebdb797fc1a7698e8729e250f637"
 SRCREV_openthread = "3ae741f95e7dfb391dec35c48742862049eb62e8"
 SRCREV_percepio = "49e6dc202aa38c2a3edbafcc2dab85dec6aee973"
-SRCREV_picolibc = "82d62ed1ac55b4e34a12d0390aced2dc9af13fc9"
+SRCREV_picolibc = "560946f26db075c296beea5b39d99e6de43c9010"
 SRCREV_segger = "cf56b1d9c80f81a26e2ac5727c9cf177116a4692"
 SRCREV_tinycrypt = "1012a3ebee18c15ede5efc8332ee2fc37817670f"
 SRCREV_trusted-firmware-a = "713ffbf96c5bcbdeab757423f10f73eb304eff07"
-SRCREV_trusted-firmware-m = "918f32d9fce5e0ee59fc33844b5317b7626ce37a"
+SRCREV_trusted-firmware-m = "021e2bbd50c215e41710a72e05abce3224f074a7"
 SRCREV_uoscore-uedhoc = "54abc109c9c0adfd53c70077744c14e454f04f4a"
 SRCREV_zcbor = "9b07780aca6fb21f82a241ba386ad9b379809337"
 
@@ -93,9 +94,10 @@ SRC_URI_ZEPHYR_CMSIS_6 ?= "git://github.com/zephyrproject-rtos/CMSIS_6;protocol=
 SRC_URI_ZEPHYR_EDTT ?= "git://github.com/zephyrproject-rtos/edtt;protocol=https"
 SRC_URI_ZEPHYR_FATFS ?= "git://github.com/zephyrproject-rtos/fatfs;protocol=https"
 SRC_URI_ZEPHYR_HAL_ADI ?= "git://github.com/zephyrproject-rtos/hal_adi;protocol=https"
-SRC_URI_ZEPHYR_HAL_ALTERA ?= "git://github.com/zephyrproject-rtos/hal_altera;protocol=https"
+SRC_URI_ZEPHYR_HAL_AFBR ?= "git://github.com/zephyrproject-rtos/hal_afbr;protocol=https"
 SRC_URI_ZEPHYR_HAL_AMBIQ ?= "git://github.com/zephyrproject-rtos/hal_ambiq;protocol=https"
 SRC_URI_ZEPHYR_HAL_ATMEL ?= "git://github.com/zephyrproject-rtos/hal_atmel;protocol=https"
+SRC_URI_ZEPHYR_HAL_BOUFFALOLAB ?= "git://github.com/zephyrproject-rtos/hal_bouffalolab;protocol=https"
 SRC_URI_ZEPHYR_HAL_ESPRESSIF ?= "git://github.com/zephyrproject-rtos/hal_espressif;protocol=https"
 SRC_URI_ZEPHYR_HAL_ETHOS_U ?= "git://github.com/zephyrproject-rtos/hal_ethos_u;protocol=https"
 SRC_URI_ZEPHYR_HAL_GIGADEVICE ?= "git://github.com/zephyrproject-rtos/hal_gigadevice;protocol=https"
@@ -143,7 +145,7 @@ SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?= "git://github.com/zephyrproject-rtos/uoscore-ue
 SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=https"
 
 SRC_URI_PATCHES ?= "\
-    file://0001-v4.1.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
+    file://0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
 "
 
 SRC_URI = "\
@@ -164,13 +166,14 @@ SRC_URI = "\
     ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=${P}/modules/hal/cmsis \
     ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=${P}/modules/lib/cmsis-dsp \
     ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=${P}/modules/lib/cmsis-nn \
-    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=${P}/modules/lib/cmsis_6 \
+    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=${P}/modules/hal/cmsis_6 \
     ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=${P}/tools/edtt \
     ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=${P}/modules/fs/fatfs \
     ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=${P}/modules/hal/adi \
-    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=hal_altera;nobranch=1;destsuffix=${P}/modules/hal/altera \
+    ${SRC_URI_ZEPHYR_HAL_AFBR};name=hal_afbr;nobranch=1;destsuffix=${P}/modules/hal/afbr \
     ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=${P}/modules/hal/ambiq \
     ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=${P}/modules/hal/atmel \
+    ${SRC_URI_ZEPHYR_HAL_BOUFFALOLAB};name=hal_bouffalolab;nobranch=1;destsuffix=${P}/modules/hal/bouffalolab \
     ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=hal_espressif;nobranch=1;destsuffix=${P}/modules/hal/espressif \
     ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=hal_ethos_u;nobranch=1;destsuffix=${P}/modules/hal/ethos_u \
     ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=hal_gigadevice;nobranch=1;destsuffix=${P}/modules/hal/gigadevice \
@@ -236,13 +239,14 @@ ${S}/tools/bsim\;\
 ${S}/modules/hal/cmsis\;\
 ${S}/modules/lib/cmsis-dsp\;\
 ${S}/modules/lib/cmsis-nn\;\
-${S}/modules/lib/cmsis_6\;\
+${S}/modules/hal/cmsis_6\;\
 ${S}/tools/edtt\;\
 ${S}/modules/fs/fatfs\;\
 ${S}/modules/hal/adi\;\
-${S}/modules/hal/altera\;\
+${S}/modules/hal/afbr\;\
 ${S}/modules/hal/ambiq\;\
 ${S}/modules/hal/atmel\;\
+${S}/modules/hal/bouffalolab\;\
 ${S}/modules/hal/espressif\;\
 ${S}/modules/hal/ethos_u\;\
 ${S}/modules/hal/gigadevice\;\
@@ -290,5 +294,5 @@ ${S}/modules/lib/uoscore-uedhoc\;\
 ${S}/modules/lib/zcbor\;\
 "
 
-ZEPHYR_BRANCH = "v4.1-branch"
-PV = "4.1.0+git${SRCPV}"
+ZEPHYR_BRANCH = "v4.2-branch"
+PV = "4.2.0+git${SRCPV}"
-- 
2.37.3


