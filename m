Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93307C369C9
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 07:59:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mx.groups.io with SMTP id smtpd.web11.7597.1744963153268070655
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 00:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=QqR7ljle;
 spf=pass (domain: intel.com, ip: 192.198.163.10, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963155; x=1776499155;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hrJ2y3duke5edNS4lrujdT+8IKPeTa8bmvqIp7gkLc4=;
  b=QqR7ljlershg3QHL67mLcade+iGkuaeS8ruQxL2tiiYd1MF2mLNfwMo7
   7xFDeUop8MNEtzkL1VTLkHOM2RF3EioQrP6zIS9ggzSK6GatClfJfq2MG
   RVleTaBqubrPjloJbqodQpW+d/AyiqO5Yf8nN2BVzcuMwVTE7hZnz3SIQ
   TmyNhe7HUjra/Ci4N+6YSQh97ykaVIcZz1RHLT+uT6m9hQvdmquijIZb5
   Ei+G80p769/JAkvyljCOl/zD7heyjrLWWJT9k5/esqVf8is+LukgVx5hX
   IxbzkKzzad7TSUqew4Q5XEgOFEIitbWRgiFFwj/clsYx0r2p5P5e5wQ3/
   Q==;
X-CSE-ConnectionGUID: bwR6sqMVSLCR9wJ5l1QURQ==
X-CSE-MsgGUID: tcI0hNgBRFSv98Pxdekp8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57958470"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="57958470"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:59:15 -0700
X-CSE-ConnectionGUID: 9Kz2reR+Ssa/rAlTG+Y55g==
X-CSE-MsgGUID: Fmho+7QnRl+Ci/19iQkiBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="130804353"
Received: from saininav-desk1.png.intel.com ([10.107.249.121])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:59:14 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH v2 3/3] meta-zephyr: Fix variable assignment whitespace
Date: Fri, 18 Apr 2025 15:59:00 +0800
Message-ID: <20250418075900.309171-3-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418075900.309171-1-naveen.kumar.saini@intel.com>
References: <20250418075900.309171-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 07:59:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1382

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-core/classes/zephyr.bbclass                         | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc       | 2 +-
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb    | 2 +-
 .../zephyr-kernel/zephyr-toolchain-cross-compile.inc            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/meta-zephyr-core/classes/zephyr.bbclass b/meta-zephyr-core/classes/zephyr.bbclass
index 4f4c88d..cebde0b 100644
--- a/meta-zephyr-core/classes/zephyr.bbclass
+++ b/meta-zephyr-core/classes/zephyr.bbclass
@@ -1,7 +1,7 @@
 inherit terminal
 inherit python3native
 
-PYTHONPATH="${STAGING_DIR_HOST}${libdir}/${PYTHON_DIR}/site-packages"
+PYTHONPATH = "${STAGING_DIR_HOST}${libdir}/${PYTHON_DIR}/site-packages"
 DEPENDS += "python3-pyelftools-native python3-pyyaml-native python3-pykwalify-native ninja-native"
 
 OE_TERMINAL_EXPORTS += "HOST_EXTRACFLAGS HOSTLDFLAGS TERMINFO CROSS_CURSES_LIB CROSS_CURSES_INC"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
index 6544475..7967614 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
@@ -27,7 +27,7 @@ ZEPHYR_EXTRA_MODULES = ""
 
 EXTRA_OECMAKE:append = "  -DZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES}"
 
-export ZEPHYR_BASE="${S}/zephyr"
+export ZEPHYR_BASE = "${S}/zephyr"
 
 DEPENDS += "gperf-native"
 
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
index a635da2..b5f02a1 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
@@ -3,6 +3,6 @@ include zephyr-sample.inc
 ZEPHYR_SRC_DIR = "${ZEPHYR_BASE}/samples/subsys/display/lvgl"
 
 # TODO Once more machines and displays are supported, add a PACKAGECONFIG.
-EXTRA_OECMAKE:append =" -DSHIELD=adafruit_2_8_tft_touch_v2"
+EXTRA_OECMAKE:append = " -DSHIELD=adafruit_2_8_tft_touch_v2"
 
 COMPATIBLE_MACHINE = "(nrf52840dk-nrf52840)"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
index 2f1ea37..c599016 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
@@ -1,7 +1,7 @@
 # Additional definitions to use the cross-compile toolchain
 
 CROSS_COMPILE = "${STAGING_BINDIR_TOOLCHAIN}/${TARGET_PREFIX}"
-SYSROOT_DIR="${STAGING_DIR_TARGET}"
+SYSROOT_DIR = "${STAGING_DIR_TARGET}"
 
 EXTRA_OECMAKE:append = " \
     -DCROSS_COMPILE=${CROSS_COMPILE} \
-- 
2.37.3


