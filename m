Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A2EC369CB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 07:03:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mx.groups.io with SMTP id smtpd.web11.11443.1745910197989855976
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 00:03:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=bd5VruL2;
 spf=pass (domain: intel.com, ip: 198.175.65.14, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745910198; x=1777446198;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WOF2FmfH3xSBpA6lnM+6Zxi9UJ4k/LBKkvIlhhkX0RA=;
  b=bd5VruL2AnsCaM4Wya2EZphvCLnBXBmCfdEHYHkV6lJKjOsM2kW5dzr1
   byS5rT6RBD8qCgUWT3o4E6Ot8KEkL8F3AeCLJ2t7MMFvoae5Cexz9TWI1
   n77170cbMr6SFPNC8zzaGdUME4QYh/uRhl41n+oAWs3OAvwc+C8LsLq9i
   uKwS46v0kpjrBtscMdQ6648YfHIokodmNiFOSQGYwP3wbhu9YKzytcHA2
   rKIFK7kIcz5FhBc8ChD0Em8yBsDvePBb26+XRJzoTzT5I+l4Hv6sUnEv+
   Go1uGPelZbsIvcLHJHVmHLS+lcBYh/vRiBxgcY7I60syo6isquTGJrjMy
   Q==;
X-CSE-ConnectionGUID: eeVSo3mERc65vzNEM2Ar+g==
X-CSE-MsgGUID: 0IX5YLgJTlyzPFS9mEOpNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51338434"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="51338434"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 00:03:18 -0700
X-CSE-ConnectionGUID: 7MGAOcm/SR2DZORpWEFFEw==
X-CSE-MsgGUID: whhqghHBTb+vUV1iWd5HZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="138551477"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by fmviesa005.fm.intel.com with ESMTP; 29 Apr 2025 00:03:16 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][walnascar][PATCH 1/2] layer.conf: Prepare for release, drop scarthgap styhead LAYERSERIES
Date: Tue, 29 Apr 2025 14:13:02 +0800
Message-Id: <20250429061303.3703928-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 07:03:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1417

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
index 60a0a80..b9a913b 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
 
 LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
 
-LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrbsp = "walnascar"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 3482c6f..5817c11 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
 
 LAYERDEPENDS_zephyrcore = "core meta-python"
 
-LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
+LAYERSERIES_COMPAT_zephyrcore = "walnascar"
 
 PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
 
-- 
2.37.3


