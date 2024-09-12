Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3DEEB590
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 11:03:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mx.groups.io with SMTP id smtpd.web11.45413.1726139023927652617
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 04:03:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=Q/71t7kw;
 spf=pass (domain: intel.com, ip: 192.198.163.8, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726139024; x=1757675024;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oUeFy8fwU6f0SuUBX2EElnJIz9hc9lLPioUa4srEJZc=;
  b=Q/71t7kwllmm0x4+Da8zDHU7RtXJUC5/U2PUlHpNX0aEAEjt3CFAFN1G
   +xKQtqrfH+ep6XAwrN8btX2uoZtZazaPPia02hOLjaOTKoF6kK4eor2Rh
   E8aBLm66U7eSXCIM7QVmUX2GTOth2TYy3RxMrncMniLtBa01xvG0nS1/o
   MZ7yE1eldDfiO5AZsxdrXE8267qJf8/B21cgn56/Eu/ZRjfwSVa6OVVYn
   qOiY3C2GI3vlY1f1OVvt7ggyMoghrGXrhLx/Fpap0ikl9eURRAeHql48V
   sq1nW71XIakhXHCp8ZTww3lU5elOLBeJJgjSyVhvT575gZ6wW4VfsJzzy
   Q==;
X-CSE-ConnectionGUID: OEZ6iXYJQxydmRgcJ1k5mQ==
X-CSE-MsgGUID: LB1uWAlJQN2nXjoWTVL4LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42498849"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="42498849"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:03:44 -0700
X-CSE-ConnectionGUID: YhoQN02dR9KNDOwA+GqFyA==
X-CSE-MsgGUID: 8L233JykSkWAoN0lj5cOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="68450131"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by orviesa008.jf.intel.com with ESMTP; 12 Sep 2024 04:03:43 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] layer.conf: update LAYERSERIES_COMPAT to use styhead
Date: Thu, 12 Sep 2024 18:20:18 +0800
Message-Id: <20240912102018.3652774-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 11:03:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/645

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
index 28577b2..26960d5 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
 
 LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
 
-LAYERSERIES_COMPAT_zephyrbsp = "kirkstone scarthgap"
+LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 40db3b6..66b2191 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -19,7 +19,7 @@ LAYERVERSION_zephyrcore = "1"
 
 LAYERDEPENDS_zephyrcore = "core meta-python"
 
-LAYERSERIES_COMPAT_zephyrcore = "kirkstone scarthgap"
+LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead"
 
 PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
 
-- 
2.37.3


