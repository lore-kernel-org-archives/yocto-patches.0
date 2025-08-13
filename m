Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CCCA0EC4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 07:29:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mx.groups.io with SMTP id smtpd.web10.95573.1755070161382304099
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 00:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=mOx/Hh1R;
 spf=pass (domain: intel.com, ip: 192.198.163.9, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070161; x=1786606161;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Vn0lhYPkpwJZ0f2cnjMQjbFKfAaOiMeQSgUa9bXNrA=;
  b=mOx/Hh1Rq0m7npi/6DeUb5IxFhE/oPyY0e5kAOEb1iiCHdUlSyA8wRw3
   DZLCS+5d6CBsyS8o1klIkWINFRW35XNjy73qXFXh+yHH4acOMzua50tGI
   Pk5/13BNzgfz9F05Z4OasSMZBTaaDhaLdszuHXqvaN6Gngmy2Rh1M07sR
   752SYZg2exoG1af3xiCN2fA+3TSPCVCfLjJ3+XcU+C69G1wK+HAXM+7pu
   gbp+5pL1jsQWWsAlKgywRzVh/dXEypsq/K9VAT018kjFSvcfEb38ABSEq
   axD1WwHA0VzTE3WkI+Cl7OEh7QSrlk7yNdMwYFuR/kX310TKtV+mk8ooo
   Q==;
X-CSE-ConnectionGUID: WaBVhLFbQ3adfQ75MVEWaA==
X-CSE-MsgGUID: BlDcSmwOSw+gIHSEsmdHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68058294"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68058294"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:29:21 -0700
X-CSE-ConnectionGUID: Id5IgHhOTVCgvAA808VlHA==
X-CSE-MsgGUID: X1JmIN+qRymJ+rZzUUt+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166672699"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2025 00:29:20 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/2] layer.conf: Update to whinlatter release series
Date: Wed, 13 Aug 2025 14:39:03 +0800
Message-Id: <20250813063904.3141303-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 07:29:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1979

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
index 60a0a80..52d9938 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
 
 LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
 
-LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrbsp = "scarthgap whinlatter"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 3482c6f..11a5bbd 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
 
 LAYERDEPENDS_zephyrcore = "core meta-python"
 
-LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrcore = "scarthgap whinlatter"
 
 PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
 
-- 
2.37.3


