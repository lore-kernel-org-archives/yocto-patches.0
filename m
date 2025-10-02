Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C472FCAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 06:41:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mx.groups.io with SMTP id smtpd.web10.2776.1759387291679285643
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 23:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=LainntQh;
 spf=pass (domain: intel.com, ip: 192.198.163.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759387292; x=1790923292;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lN/9R5DBLc+EvjHNT0z5pkTDz/s0eV9SFt1FxIv7Zx0=;
  b=LainntQhAhz1ur9/E0LOBumLSgT9wka6fD37Da3XGFRurRYwC9SNGqG5
   ECsW6spKBeNA+pXQNtH35ja5lEqrDce1FIHzup4ZRiZvx6pRu7NXD9rTV
   dXi3+MvhPitfkS/DfaLA6S/QimhwlFiKhdebC8yr88Cwj3vZc4rwaEKH3
   1tMazo3xuzpnC6IINhXpClqL21T5PLKO9K82i7p1ZrFRyY6sXG3zZdqgp
   dIj4EcOE4U96O08E3Xx79aJccBHcOwCvQyyrKlL2Z+G/EVbC9jZHIdr0S
   CPcEwMod6iIY9j3hsRgXMaOnrxNalapGlTmLTw+ra/I1rNNlQ0Q795KnV
   Q==;
X-CSE-ConnectionGUID: 2WWh57XFSX2M7rWXk2XKfQ==
X-CSE-MsgGUID: 6XTPhTxhRf6j8sPrQMynSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="64287454"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="64287454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 23:41:32 -0700
X-CSE-ConnectionGUID: RrzNy8I9QzKIdS3+T5WtFQ==
X-CSE-MsgGUID: QZmsUfFnQImbDRypKbfotw==
X-ExtLoop1: 1
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 23:41:31 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr 2/2] zephyr-sdk: update to 0.17.4
Date: Thu,  2 Oct 2025 13:36:05 +0800
Message-Id: <20251002053605.1310630-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20251002053605.1310630-1-chee.yang.lee@intel.com>
References: <20251002053605.1310630-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Oct 2025 06:41:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2270

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb          | 4 ----
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb          | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
deleted file mode 100644
index ba20341..0000000
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
+++ /dev/null
@@ -1,4 +0,0 @@
-require zephyr-sdk.inc
-
-SRC_URI[x86_64.sha256sum] = "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2a74229907b6421fb859a8"
-SRC_URI[aarch64.sha256sum] = "a8c1731ad602553304e539a7ade9cdb34caabc1850d581585cbba0372a7493b2"
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb
new file mode 100644
index 0000000..a3ca6c6
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.17.4.bb
@@ -0,0 +1,4 @@
+require zephyr-sdk.inc
+
+SRC_URI[x86_64.sha256sum] = "83f2f327dba2d6cf2440f22f2f501041544d7f34ef8b878ecd83f4513d1116b6"
+SRC_URI[aarch64.sha256sum] = "14ed90e95a74316685c01d3ed7023646d99d69311e198a8e6930bc0ceacb8db9"
-- 
2.37.3


