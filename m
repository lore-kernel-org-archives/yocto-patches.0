Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDEC36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 06:33:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mx.groups.io with SMTP id smtpd.web10.2352.1744180372608093745
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 23:32:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=hRYPgjJU;
 spf=pass (domain: intel.com, ip: 198.175.65.9, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744180373; x=1775716373;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=neLMIVOZ+cl1Z2STTXGSioSdxufHPEt5I5nUdTlwz80=;
  b=hRYPgjJUXrO93jaM4gxGOU2OO4TTjHMEbjH4DmfAqXiA42H0UnREOsM7
   yrR8WtefkADjhLAeke0vzkf2pRv+AIpsskhAzYcmHDl7ZZVCue/yrZ8hW
   l7bVvXrHdDO+zWVJ7YKBgYHFTcB3aSiBDmpFMv5TCEf201U+ncmGCAler
   z1GEyLn7Vk1Q5H9Wqb9PGM5CZAayC9yHOGMnAx9fUAMC2D+0sDrJqsqI9
   GIC0kOAoPOjGCFVBwV1R85S0kt8umqXwjmcGhDRtC8Wyvf4PfJ/QUN1C3
   6o1XIP/x/MRKezN1xKWIJaLhHfqTsTcVd9EsVOorEc/15Zn3fpBJMOWkf
   Q==;
X-CSE-ConnectionGUID: TwZzDcAFRoi+SwqNBnUD8w==
X-CSE-MsgGUID: r3megjezSqig45nEfMf57w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68118311"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68118311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:32:52 -0700
X-CSE-ConnectionGUID: 4XmmNH77S8e3rif63rRcFw==
X-CSE-MsgGUID: TnbwbFagSjeu0201VFtqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="159479490"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by orviesa002.jf.intel.com with ESMTP; 08 Apr 2025 23:32:51 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] layer.conf: update LAYERSERIES_COMPAT to use walnascar
Date: Wed,  9 Apr 2025 13:42:42 +0800
Message-Id: <20250409054242.1983473-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 06:33:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1337

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
index 26960d5..60a0a80 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
 
 LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
 
-LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead"
+LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 4f6f642..3482c6f 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
 
 LAYERDEPENDS_zephyrcore = "core meta-python"
 
-LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead"
+LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
 
 PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
 
-- 
2.37.3


