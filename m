Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71948CA5FE2
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:13:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11783.1790946818147980480
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 06:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=OB9Yqqja;
 spf=pass (domain: intel.com, ip: 198.175.65.21, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946819; x=1822482819;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=8Ohrmeqbm0+PjJ574RHtfZSVKkb3hY2BVryFVTwtQDw=;
  b=OB9YqqjaciLG5FSx/wenCtxn9oMMEJ8VKgvC2bx4xWe3ThWk9vkeVDWZ
   sWOb5urp9y2B0KIojF03cvGhh/IHmBZGDrn/nST8r7m+diRuc+3kAbbBt
   5L1KsHC1bOSc4vQgfq5cuigCgZiChbK2CLpjryS066QaKcnUQ1bEfIbmo
   qDPkSSBJCu8tnmU7vKZK9ajcg02d/176gK8AtI65VMU/uQsRbtmpYIN8S
   6MjmEOqggypTR1QybjqD1+7GQu9iHUOfpzSbZuNnTXKuECbjPwpMQHBsQ
   fE41fF2QSUBgLX0J9L98iwj16OdcqjSxONjEqQQXNHLUgtHm5/mYCuSVA
   w==;
X-CSE-ConnectionGUID: d8myai6iSxmQaxWArWrVFQ==
X-CSE-MsgGUID: a2lRdjvFSgi0EUBpfeiAvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90570606"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90570606"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:13:39 -0700
X-CSE-ConnectionGUID: 42YAmLQ/SRqwL03kGb3weg==
X-CSE-MsgGUID: aoyK9BfVRm+D6bdMAk0jGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280986556"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa004.fm.intel.com with ESMTP; 02 Oct 2026 06:13:37 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/2] zephyr-sdk: drop v0.17.4
Date: Fri,  2 Oct 2026 21:13:35 +0800
Message-ID: <20261002131335.3541596-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002131335.3541596-1-chee.yang.lee@intel.com>
References: <20261002131335.3541596-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 13:13:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4981

From: Lee Chee Yang <chee.yang.lee@intel.com>

drop this sdk version as it is for zephyr 4.3.0.

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb          | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb
deleted file mode 100644
index a3ca6c6..0000000
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb
+++ /dev/null
@@ -1,4 +0,0 @@
-require zephyr-sdk.inc
-
-SRC_URI[x86_64.sha256sum] = "83f2f327dba2d6cf2440f22f2f501041544d7f34ef8b878ecd83f4513d1116b6"
-SRC_URI[aarch64.sha256sum] = "14ed90e95a74316685c01d3ed7023646d99d69311e198a8e6930bc0ceacb8db9"
-- 
2.43.0


