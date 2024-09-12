Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793BAEED610
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 14:53:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mx.groups.io with SMTP id smtpd.web10.49821.1726152797289148924
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 07:53:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=bRCh+bRP;
 spf=pass (domain: intel.com, ip: 198.175.65.19, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726152797; x=1757688797;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vweq7dKxptfX23Q7/rmK0U25S5FK2zqnrPd9J7VPFT0=;
  b=bRCh+bRPYnTk557gTvSbEwZbeuPQwClKV5StfCLNKXy0vQMxeRjZZZqp
   RlwYvGlhoqJHhR32urts4YuIQEkUmuDcnOOqrasZ77pg8pHqjxV5nEqdV
   DDeHACgE4SUvQCj7YXYcjrvlhMTAP8cNKg8wUMUMMWV2xzuLAo3F9TQaD
   xaB3cucQXehWMigixFePaK+2pfmGBxJy9KKwFgJUHJkfSufbtpStYt3qh
   WktF5Fw79Pt6iVlHRlROZvylGNP2hrK74a1L/oTfMIAr1FwOtGZXU+gLM
   /7H4dzFOaYzD0r48j47MNTfNPJ1J+FAo5cIKSbibzXJEA4u35Ta4Dpb/4
   A==;
X-CSE-ConnectionGUID: oEzJPE3fR2ueQa8K2uEZJQ==
X-CSE-MsgGUID: oA5xeLETTDqfL0qBeaxhYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24883020"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24883020"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:53:15 -0700
X-CSE-ConnectionGUID: np6XfRb2SdO9FH6dmpSG5Q==
X-CSE-MsgGUID: azLXT1pVRPKKWoDrrHACbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67814378"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by fmviesa008.fm.intel.com with ESMTP; 12 Sep 2024 07:53:14 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/2] zephyr-image.inc: fix runqemu failure
Date: Thu, 12 Sep 2024 22:09:47 +0800
Message-Id: <20240912140948.200432-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 14:53:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/646

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index c747095..403c8d9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -10,7 +10,8 @@ do_install() {
     for output in ${ZEPHYR_MAKE_OUTPUT}; do
         if [ -f ${B}/zephyr/${output} ];
         then
-          install -D ${B}/zephyr/${output} ${D}/firmware/
+          output_img=$(echo ${output} | sed -e "s/zephyr/${PN}/g")
+          install -D ${B}/zephyr/${output} ${D}/firmware/${output_img}
         fi
     done
 }
-- 
2.37.3


