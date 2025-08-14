Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F9CA0ED1
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 04:12:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mx.groups.io with SMTP id smtpd.web11.15209.1755144754964687122
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 21:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=PC6TNqCj;
 spf=pass (domain: intel.com, ip: 192.198.163.12, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755144755; x=1786680755;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=blbWTIUGyOLnFY3Z9s6yafE7BIdmYMe0ufUjJb75sHg=;
  b=PC6TNqCjs/sFy75oI/1of0DIp2aIIpM6+Wl91VPPm3tlIEcLJLlx/Olg
   cK6tEF107/XN9uX/2RXeYkSgKNixfv+oEq2bTwGU+WsMfW6iLq3BodRfK
   DxsXOOYByW3W+QS/z/eyKxPomtSnFO6BaxsDiOYs7bzfA6Ah0ZHPVfJIv
   vajG1fIc+SRJneTcD5OBlIJWylE3vC5ofBC42GfcfJPPL/99Y6j0FIpze
   0YJB9cqztJWJLFDEmbM7isulUukJaTR3rZ2aeF3qfqs2w9V6rm5y4+DZc
   W9iFtec2gsXXZeWo/PCbMgtkCutk0Ey0DiYJw2SSOk9ezmCrFF4puiBxH
   A==;
X-CSE-ConnectionGUID: TtstQqfcQpSUVeKwO1rRCg==
X-CSE-MsgGUID: RVP3UbJNTPStOxFn9M8k+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61258152"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61258152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 21:12:35 -0700
X-CSE-ConnectionGUID: 79WQ1eggSnmSbIlB3CbzqA==
X-CSE-MsgGUID: oh+i/ZzrQlaOgobWtZKBhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170859497"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 21:12:34 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][Patch v2] layer.conf: Update to whinlatter release series
Date: Thu, 14 Aug 2025 11:22:17 +0800
Message-Id: <20250814032217.3574830-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Aug 2025 04:12:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1987

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
v2: removed scarthgap

 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
index 60a0a80..6c16722 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
 
 LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
 
-LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrbsp = "whinlatter"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 3482c6f..5afec0f 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
 
 LAYERDEPENDS_zephyrcore = "core meta-python"
 
-LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrcore = "whinlatter"
 
 PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
 
-- 
2.37.3


