Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ADE7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 07:09:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mx.groups.io with SMTP id smtpd.web11.10402.1734073777096650426
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 23:09:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=jukVMDdv;
 spf=pass (domain: intel.com, ip: 198.175.65.14, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734073777; x=1765609777;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bbzo+L2f1fgGgZqVD6U7ofbX4d0Ab5qkl29fRUaU+8=;
  b=jukVMDdvV79vp9hMKB1xb6VuVeKh/rQWfpDtuCtvUy6tAvqo4ffHqMR8
   x4zKXxpGGZNnHM51WFd0ll5i2byZr+UXjNvqO/kBPv9J0dL+fmzoUzH+O
   6N65wmntN6hvwCWfbwW2Cx23XIeLzIPBWIeDAaqgqPZFecGN/qXXSd06t
   VPKD/zGu57dOfbGgjTTy3x2O1kRiqpL+ZtWyj2ZXyx/wnpbWYVUOBftrR
   HRX5HLRmP8QwG6lTINh1ZUIUuHU+FpDuoTR7PV5qKOrqk9go5hItJWe7d
   3zlUa27NqXhi1PmPLr9Kf3Djb+XY7LMSmM9Qk3yQUZui3dk/kzpkpdv0x
   A==;
X-CSE-ConnectionGUID: uok1H8yuQ1uU9n1L2EK+sw==
X-CSE-MsgGUID: DJimQc+kSMmPmx/ZjRxA0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38298831"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="38298831"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:09:36 -0800
X-CSE-ConnectionGUID: s8PQtfesQb+VfXZpC8rYaw==
X-CSE-MsgGUID: YpZKXaC4RP+9uaAWAjWpKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101034097"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by fmviesa005.fm.intel.com with ESMTP; 12 Dec 2024 23:09:35 -0800
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] zephyr-sdk: fix COMPATIBLE_HOST build failure
Date: Fri, 13 Dec 2024 14:20:32 +0800
Message-Id: <20241213062032.220169-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:09:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/892

ERROR: Nothing PROVIDES 'zephyr-sdk'
zephyr-sdk was skipped: incompatible with host i586-yocto-elf (not in COMPATIBLE_HOST)

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb            | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
index 57fe777..da30b17 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Zephyr SDK Bundle"
 DESCRIPTION = "Official SDK built using crosstool-ng, distributed by the \
 Zephyr project"
-COMPATIBLE_HOST = "(x86_64|aarch64).*-linux"
+COMPATIBLE_HOST = "(x86_64|aarch64).*-(linux|elf)"
 
 LICENSE = "Apache-2.0"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"
-- 
2.37.3


