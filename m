Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35746D3ABF9
	for <webhook@archiver.kernel.org>; Sat,  6 Dec 2025 08:20:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2305.1765009202810851128
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Dec 2025 00:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=I88zB4KP;
 spf=pass (domain: intel.com, ip: 192.198.163.15, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765009202; x=1796545202;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lKOK6M6W/vAuGufHO171aKkvLl7ycRpS7wDjEX2Ys4U=;
  b=I88zB4KP07g22lC6O7/iWNUs7g5kU1MgkVGFWw/xZcdh8/sIS+IoW2QV
   yhBTMhwY4pbbFwzWNhJsGcaRF8c1gg07wobSSJgIlTW2eoAFgphsk4yfo
   5T5NWp/gVOqmmgp3xQcqGhC5bqWLzokhjNvjcNf/NA6OLjukTPIVqU6O8
   R8Uw4pQQcsh9rjA8czwEK6cNvz1hqADjN4MQG5PrfKUMDyDLKbkAbPIMG
   iLyF8aLaSxx0YAAEwNA0Amu/uVvhgPfjyUOAnlF12snb50/mpTZmMuCgB
   dDwmjrZG7W5wkYetMYj4Vt3igQIgZOI8fKQeIMq/FdAHX3v85jnaF8gK8
   w==;
X-CSE-ConnectionGUID: peZBfvHLSKS3V9eDAe3Z3Q==
X-CSE-MsgGUID: l0bMAAs/QSK7fzusHcMeFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67112370"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="67112370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 00:20:02 -0800
X-CSE-ConnectionGUID: NCH1NVZLTjyOvBaON1VdBw==
X-CSE-MsgGUID: mk2JiNEbQFaZYdd1l65RVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="194550831"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by orviesa006.jf.intel.com with ESMTP; 06 Dec 2025 00:20:01 -0800
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] README: drop reference to poky
Date: Sat,  6 Dec 2025 15:09:23 +0800
Message-Id: <20251206070923.2254134-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Dec 2025 08:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2747

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 README.md | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 669e921..cd60bca 100644
--- a/README.md
+++ b/README.md
@@ -6,7 +6,10 @@ This layer enables building Zephyr using Yocto Project.
 
 This layer depends on:
 
-	URI: https://git.yoctoproject.org/poky
+	URI: https://git.openembedded.org/bitbake
+	branch: master
+
+	URI: https://git.openembedded.org/openembedded-core
 	layers: meta
 	branch: master
 
@@ -23,17 +26,19 @@ https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
 > **Pre-requisites:**
 1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/singleindex.html#yocto-project-quick-build) documentation.
 
-2. Clone and add following layers to BBLAYERS
+2. Clone required repo, refer to [Yocto Release](https://wiki.yoctoproject.org/wiki/Releases) for compatible branch name and bitbake branch.
+    * bitbake
+    * openembedded-core
     * meta-openembedded/meta-oe
     * meta-openembedded/meta-python
     * meta-zephyr-core
     * meta-zephyr-bsp
 ```
-    $ mkdir sources
-    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
+    $ git clone -b <bitbake-branch> https://git.openembedded.org/bitbake
+    $ git clone -b <branch-name> https://git.openembedded.org/openembedded-core
     $ git clone -b <branch-name> https://git.openembedded.org/meta-openembedded
     $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
-    $ source poky/oe-init-build-env
+    $ source openembedded-core/oe-init-build-env
     $ bitbake-layers add-layer ../meta-openembedded/meta-oe
     $ bitbake-layers add-layer ../meta-openembedded/meta-python
     $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core
-- 
2.37.3


