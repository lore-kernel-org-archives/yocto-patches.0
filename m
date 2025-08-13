Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EACC87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 07:29:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mx.groups.io with SMTP id smtpd.web10.95573.1755070161382304099
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 00:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=PlEb5JjF;
 spf=pass (domain: intel.com, ip: 192.198.163.9, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070162; x=1786606162;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=iCSnSzAT9rPHi+alYCmH2bZuIYOOUqsoFqU5dQtTzHQ=;
  b=PlEb5JjFEq3bV3hT2g0xGvDdPJ7N2vXfJl00ZhIx8f+gsy9UUAsUbvsL
   G6CaQGgzaxrAwh/vIr9gE8+FJ0YLCyEoHDZt07t4IDRD1iT3wqY2sTddn
   3SVS5aojWgyJYVpNCd6STZspnMiZKLnAmAsrbCAKILmNDNXsPZgFAMOs4
   7STTOFsvctCBRIi477f2ld0/qsb5KrsaQLNjrMWB8esbb32/dTThGgitB
   uBM0PK7Hi4EigLCG87IFuvWNVs6gSxZ27GoMgahiqGq/FDbEIUwjhFqAN
   LQkJR2hhkznGFs7Gi3+rFZMc7yWQIoRmPV0T5icwKi7DQdJRuC+K65llw
   Q==;
X-CSE-ConnectionGUID: gwgEoHLfQrGYVAv3spLV8w==
X-CSE-MsgGUID: xejJz+lnTcaUmEMwbtwn+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68058295"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68058295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:29:22 -0700
X-CSE-ConnectionGUID: s09evmLSSc6K/cbx7Cfm9Q==
X-CSE-MsgGUID: k3CWNtO8RxW9QAX/6xZ5MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166672703"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2025 00:29:21 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/2] recipes: update to match S/UNPACKDIR changes
Date: Wed, 13 Aug 2025 14:39:04 +0800
Message-Id: <20250813063904.3141303-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250813063904.3141303-1-chee.yang.lee@intel.com>
References: <20250813063904.3141303-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 07:29:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1980

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 .../bossa/bossa-native_git.bb                 |   2 -
 .../zephyr-sdk/zephyr-sdk_0.16.9.bb           |   3 -
 .../zephyr-kernel/zephyr-kernel-src-3.7.0.inc | 128 ++++++++--------
 .../zephyr-kernel/zephyr-kernel-src-4.1.0.inc | 138 +++++++++---------
 .../zephyr-kernel/zephyr-kernel-src.inc       |   1 -
 5 files changed, 133 insertions(+), 139 deletions(-)

diff --git a/meta-zephyr-core/recipes-devtools/bossa/bossa-native_git.bb b/meta-zephyr-core/recipes-devtools/bossa/bossa-native_git.bb
index b645ecf..df855a3 100644
--- a/meta-zephyr-core/recipes-devtools/bossa/bossa-native_git.bb
+++ b/meta-zephyr-core/recipes-devtools/bossa/bossa-native_git.bb
@@ -9,8 +9,6 @@ SRC_URI = "git://github.com/arduino/BOSSA.git;protocol=https;branch=nrf"
 PV = "1.9.1+git${SRCPV}"
 SRCREV = "89f3556a761833522cd93c199581265ad689310b"
 
-S = "${WORKDIR}/git"
-
 inherit native
 
 do_compile() {
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
index 57fe777..b749763 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -17,9 +17,6 @@ SRC_URI = "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${PV}
 SRC_URI[x86_64.sha256sum] = "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2a74229907b6421fb859a8"
 SRC_URI[aarch64.sha256sum] = "a8c1731ad602553304e539a7ade9cdb34caabc1850d581585cbba0372a7493b2"
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
-
 do_configure[noexec] = "1"
 do_compile[noexec] = "1"
 
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc
index 67481ba..9facbff 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc
@@ -137,70 +137,70 @@ SRC_URI_PATCHES ?= "\
 "
 
 SRC_URI = "\
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
-    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=git/modules/hal/adi \
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
+    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=${P}/zephyr \
+    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=${P}/modules/lib/acpica \
+    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=${P}/tools/bsim \
+    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=${P}/tools/bsim/components \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_libPhyComv1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_phy_v1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_NtNcable \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_channel_multiatt \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_magic \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_modem_BLE_simple \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_burst_interferer \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_WLAN_actmod \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_2G4_device_playback \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=${P}/tools/bsim/components/ext_libCryptov1 \
+    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=${P}/modules/hal/cmsis \
+    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=${P}/modules/lib/cmsis-dsp \
+    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=${P}/modules/lib/cmsis-nn \
+    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=${P}/tools/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=${P}/modules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=${P}/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=hal_altera;nobranch=1;destsuffix=${P}/modules/hal/altera \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=${P}/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=${P}/modules/hal/atmel \
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
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=${P}/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=${P}/modules/hal/rpi_pico \
+    ${SRC_URI_ZEPHYR_HAL_SILABS};name=hal_silabs;nobranch=1;destsuffix=${P}/modules/hal/silabs \
+    ${SRC_URI_ZEPHYR_HAL_ST};name=hal_st;nobranch=1;destsuffix=${P}/modules/hal/st \
+    ${SRC_URI_ZEPHYR_HAL_STM32};name=hal_stm32;nobranch=1;destsuffix=${P}/modules/hal/stm32 \
+    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=${P}/modules/hal/telink \
+    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=${P}/modules/hal/ti \
+    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=${P}/modules/hal/wurthelektronik \
+    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=${P}/modules/hal/xtensa \
+    ${SRC_URI_ZEPHYR_HOSTAP};name=hostap;nobranch=1;destsuffix=${P}/modules/lib/hostap \
+    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=${P}/modules/hal/libmetal \
+    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=${P}/modules/lib/liblc3 \
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=${P}/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=${P}/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=${P}/modules/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=${P}/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=${P}/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=${P}/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=${P}/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=${P}/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=${P}/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=${P}/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=${P}/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=${P}/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=${P}/modules/debug/segger \
+    ${SRC_URI_ZEPHYR_TINYCRYPT};name=tinycrypt;nobranch=1;destsuffix=${P}/modules/crypto/tinycrypt \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=${P}/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=${P}/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=${P}/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=${P}/modules/lib/zcbor \
     ${SRC_URI_PATCHES} \
 "
 
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc
index 5b13fea..911fabf 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.1.0.inc
@@ -147,75 +147,75 @@ SRC_URI_PATCHES ?= "\
 "
 
 SRC_URI = "\
-    ${SRC_URI_ZEPHYR};branch=${ZEPHYR_BRANCH};name=default;destsuffix=git/zephyr \
-    ${SRC_URI_ZEPHYR_ACPICA};name=acpica;nobranch=1;destsuffix=git/modules/lib/acpica \
-    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=babblesim_base;nobranch=1;destsuffix=git/tools/bsim/components \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=babblesim_ext_2G4_channel_NtNcable;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_NtNcable \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=babblesim_ext_2G4_channel_multiatt;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_channel_multiatt \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=babblesim_ext_2G4_device_WLAN_actmod;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_WLAN_actmod \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=babblesim_ext_2G4_device_burst_interferer;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_burst_interferer \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=babblesim_ext_2G4_device_playback;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_device_playback \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=babblesim_ext_2G4_libPhyComv1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_libPhyComv1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=babblesim_ext_2G4_modem_BLE_simple;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_BLE_simple \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=babblesim_ext_2G4_modem_magic;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_modem_magic \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=babblesim_ext_2G4_phy_v1;nobranch=1;destsuffix=git/tools/bsim/components/ext_2G4_phy_v1 \
-    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=babblesim_ext_libCryptov1;nobranch=1;destsuffix=git/tools/bsim/components/ext_libCryptov1 \
-    ${SRC_URI_ZEPHYR_BSIM};name=bsim;nobranch=1;destsuffix=git/tools/bsim \
-    ${SRC_URI_ZEPHYR_CMSIS};name=cmsis;nobranch=1;destsuffix=git/modules/hal/cmsis \
-    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=cmsis-dsp;nobranch=1;destsuffix=git/modules/lib/cmsis-dsp \
-    ${SRC_URI_ZEPHYR_CMSIS_NN};name=cmsis-nn;nobranch=1;destsuffix=git/modules/lib/cmsis-nn \
-    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=git/modules/lib/cmsis_6 \
-    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=git/tools/edtt \
-    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=git/modules/fs/fatfs \
-    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=git/modules/hal/adi \
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
-    ${SRC_URI_ZEPHYR_HAL_TDK};name=hal_tdk;nobranch=1;destsuffix=git/modules/hal/tdk \
-    ${SRC_URI_ZEPHYR_HAL_TELINK};name=hal_telink;nobranch=1;destsuffix=git/modules/hal/telink \
-    ${SRC_URI_ZEPHYR_HAL_TI};name=hal_ti;nobranch=1;destsuffix=git/modules/hal/ti \
-    ${SRC_URI_ZEPHYR_HAL_WCH};name=hal_wch;nobranch=1;destsuffix=git/modules/hal/wch \
-    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=hal_wurthelektronik;nobranch=1;destsuffix=git/modules/hal/wurthelektronik \
-    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=hal_xtensa;nobranch=1;destsuffix=git/modules/hal/xtensa \
-    ${SRC_URI_ZEPHYR_HOSTAP};name=hostap;nobranch=1;destsuffix=git/modules/lib/hostap \
-    ${SRC_URI_ZEPHYR_LIBLC3};name=liblc3;nobranch=1;destsuffix=git/modules/lib/liblc3 \
-    ${SRC_URI_ZEPHYR_LIBMCTP};name=libmctp;nobranch=1;destsuffix=git/modules/lib/libmctp \
-    ${SRC_URI_ZEPHYR_LIBMETAL};name=libmetal;nobranch=1;destsuffix=git/modules/hal/libmetal \
-    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=git/modules/fs/littlefs \
-    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=git/modules/lib/loramac-node \
-    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=git/modules/lib/gui/lvgl \
-    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=git/modules/crypto/mbedtls \
-    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=git/bootloader/mcuboot \
-    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=git/modules/debug/mipi-sys-t \
-    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=git/tools/net-tools \
-    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=git/modules/bsim_hw_models/nrf_hw_models \
-    ${SRC_URI_ZEPHYR_NRF_WIFI};name=nrf_wifi;nobranch=1;destsuffix=git/modules/lib/nrf_wifi \
-    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=git/modules/lib/open-amp \
-    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=git/modules/lib/openthread \
-    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=git/modules/debug/percepio \
-    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=git/modules/lib/picolibc \
-    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=git/modules/debug/segger \
-    ${SRC_URI_ZEPHYR_TINYCRYPT};name=tinycrypt;nobranch=1;destsuffix=git/modules/crypto/tinycrypt \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=git/modules/tee/tf-a/trusted-firmware-a \
-    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=git/modules/tee/tf-m/trusted-firmware-m \
-    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=git/modules/lib/uoscore-uedhoc \
-    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=git/modules/lib/zcbor \
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
+    ${SRC_URI_ZEPHYR_CMSIS_6};name=cmsis_6;nobranch=1;destsuffix=${P}/modules/lib/cmsis_6 \
+    ${SRC_URI_ZEPHYR_EDTT};name=edtt;nobranch=1;destsuffix=${P}/tools/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=fatfs;nobranch=1;destsuffix=${P}/modules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=hal_adi;nobranch=1;destsuffix=${P}/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=hal_altera;nobranch=1;destsuffix=${P}/modules/hal/altera \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=hal_ambiq;nobranch=1;destsuffix=${P}/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=hal_atmel;nobranch=1;destsuffix=${P}/modules/hal/atmel \
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
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=hal_renesas;nobranch=1;destsuffix=${P}/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=hal_rpi_pico;nobranch=1;destsuffix=${P}/modules/hal/rpi_pico \
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
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=littlefs;nobranch=1;destsuffix=${P}/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=loramac-node;nobranch=1;destsuffix=${P}/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=lvgl;nobranch=1;destsuffix=${P}/modules/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=mbedtls;nobranch=1;destsuffix=${P}/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=mcuboot;nobranch=1;destsuffix=${P}/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=mipi-sys-t;nobranch=1;destsuffix=${P}/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=net-tools;nobranch=1;destsuffix=${P}/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=nrf_hw_models;nobranch=1;destsuffix=${P}/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_NRF_WIFI};name=nrf_wifi;nobranch=1;destsuffix=${P}/modules/lib/nrf_wifi \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=open-amp;nobranch=1;destsuffix=${P}/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=openthread;nobranch=1;destsuffix=${P}/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=percepio;nobranch=1;destsuffix=${P}/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=picolibc;nobranch=1;destsuffix=${P}/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_SEGGER};name=segger;nobranch=1;destsuffix=${P}/modules/debug/segger \
+    ${SRC_URI_ZEPHYR_TINYCRYPT};name=tinycrypt;nobranch=1;destsuffix=${P}/modules/crypto/tinycrypt \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=trusted-firmware-a;nobranch=1;destsuffix=${P}/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=trusted-firmware-m;nobranch=1;destsuffix=${P}/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=uoscore-uedhoc;nobranch=1;destsuffix=${P}/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=zcbor;nobranch=1;destsuffix=${P}/modules/lib/zcbor \
     ${SRC_URI_PATCHES} \
 "
 
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index f703896..cf1b593 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -9,7 +9,6 @@ inherit cmake
 # having an explicit path to the patches directory, will make bitbake fail to
 # find the patch(es) in SRC_URI.
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
-S = "${WORKDIR}/git"
 
 # Default to a stable version
 PREFERRED_VERSION_zephyr-kernel ??= "4.1.0"
-- 
2.37.3


