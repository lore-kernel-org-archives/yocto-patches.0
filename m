Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34006C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:46:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.web11.41486.1745819203237765351
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 27 Apr 2025 22:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=nEW7M2cQ;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745819204; x=1777355204;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oACTFvL0es6Z+sLUyP6+Z7jodwxqv+ympYvrPDwrnsU=;
  b=nEW7M2cQ5ytn9e7HcCeEcDmVZ9vL3qDXq61pPDIFjU0tbdEhr4AE/MMN
   zzqWnZ8p0HQ7sBUde5LxtMvXbY5D8sPOnEPsGpFL/l14CZdItyU7efOiA
   gylYj4DGazqgNyZVllbKhajtbKUmRO7bnxsJtNgHecJF17npNPFiA5tYO
   KlWZ5rscFT004VIJyeM8p045QP/J5b+Ki2o/YErF7H/q5WElfy05QAGi6
   6tIHv7ynFhA6ySjROuOucaUDgbVg5m9g7irAC1Cv2SUTfKofAfVHcJrfP
   vDUUYLimPDj1WPiTZykRL+dZm7WJYO+f4MNBaE2m/9PpsZhoGEr3nFoSw
   g==;
X-CSE-ConnectionGUID: LgsibiLHT9OZO6AvklPWPw==
X-CSE-MsgGUID: vmA7EbzmRqGdRSA4H+modg==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="58378499"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="58378499"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 22:46:42 -0700
X-CSE-ConnectionGUID: BNraXJwPRMaEi+2ERKccmA==
X-CSE-MsgGUID: kVeA8O0uRS201T7fFyKOhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="134391043"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by orviesa008.jf.intel.com with ESMTP; 27 Apr 2025 22:46:41 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] zephyr-toolchain-zephyr.inc: Fix variable assignment whitespace
Date: Mon, 28 Apr 2025 12:56:30 +0800
Message-Id: <20250428045630.777977-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 05:46:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1402

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
index cd5920d..e265883 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
@@ -3,7 +3,7 @@
 # Configure usage of the Zephyr SDK
 INHIBIT_DEFAULT_DEPS = "1"
 DEPENDS += "zephyr-sdk-native"
-export ZEPHYR_SDK_INSTALL_DIR="${STAGING_DIR_NATIVE}${prefix}/zephyr-sdk"
+export ZEPHYR_SDK_INSTALL_DIR = "${STAGING_DIR_NATIVE}${prefix}/zephyr-sdk"
 OE_TERMINAL_EXPORTS += "ZEPHYR_SDK_INSTALL_DIR"
 
 # The Zephyr SDK does not require a CMake toolchain file
-- 
2.37.3


