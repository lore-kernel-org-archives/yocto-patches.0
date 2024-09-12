Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CAEED611
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 14:53:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mx.groups.io with SMTP id smtpd.web10.49821.1726152797289148924
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 07:53:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=iW67uB2J;
 spf=pass (domain: intel.com, ip: 198.175.65.19, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726152798; x=1757688798;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9uH9ggrOesrj6SGitqtE3iBnyDC0iAGOOVPjPLV+6lM=;
  b=iW67uB2JSIIhm4X2X34a7EEHVZtULo8OQ5tUsJ1a3fQhNXkIFQfythKo
   1V3W8xwlovW7hMKnpzjU6B0uJNglpPMRRksiUBXqYnKG/OJBgrJLiUQFo
   PFlyL07Pi6CyPy4FjpbckjXA6+TVKiI3kJmIE4ZmlJSntiHarKWAyE+tH
   IIusOyZwOtP6ZAIjNls2D5uB0xRejZLZF8lDXwponTJ63SdRV3pHY7Tcf
   w8fshCdZRZv9/x1v/T/bhVvsc7HJcSft4ZYzHLHx27oEwr/un2rWAdxws
   L55yfkx25Jbah6CVKqlUwqSJ0WwH85rcILpgOoODKEMBLwn2QjkANa9sc
   g==;
X-CSE-ConnectionGUID: WcyL1I7BSxykQKjkCBgo4Q==
X-CSE-MsgGUID: deXzJWDRTB+cmY9Qvk87lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24883022"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24883022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:53:17 -0700
X-CSE-ConnectionGUID: mAEFCJ74Q6uyAxawUOnkqg==
X-CSE-MsgGUID: wcFX0YV0RCqGm2zGNh7xlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67814383"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by fmviesa008.fm.intel.com with ESMTP; 12 Sep 2024 07:53:15 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/2] zephyr-kernel: build with v3.7.0
Date: Thu, 12 Sep 2024 22:09:48 +0800
Message-Id: <20240912140948.200432-2-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240912140948.200432-1-naveen.kumar.saini@intel.com>
References: <20240912140948.200432-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 14:53:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/647

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index 0b9baac..3b89d31 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -12,5 +12,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 S = "${WORKDIR}/git"
 
 # Default to a stable version
-PREFERRED_VERSION_zephyr-kernel ??= "3.6.0"
+PREFERRED_VERSION_zephyr-kernel ??= "3.7.0"
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION_zephyr-kernel}.inc
-- 
2.37.3


