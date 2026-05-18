Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E48CD4F50
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 06:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2670.1779085819162090919
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 May 2026 23:30:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=AbcJtxiB;
 spf=pass (domain: intel.com, ip: 198.175.65.18, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779085821; x=1810621821;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ymvgmHaRXSB2Y9C5fP94GqfpSY4ftghxDNB5EmRRfbw=;
  b=AbcJtxiBbt7nNU7aylpCny3ScdkdKUBpYptozj9Rw2gCw4f9Bsf3GnrK
   TgM95kP7Owxum2RbJv223wYkHM3oAjaHz8UTAnSJM+OnR2CFTZ7jj4jfG
   1B7X0I3W9KdNP/VnXt6i4nHw5G4uokeyU37zFAgIQnDm7ur5VIlG0dBAh
   buaNuopGcxc9bvMYCkSWsPifyFkmtjLFWHpROj9QD8aXEdl95UFKY81Si
   q4EXN1FAky4zDpemXj1vBx3/dWZe+o581hA5nfRqf6/va+ZrIcdjMqU4i
   NyA6BHyuuKAFKNlplqgAQLftjhZxzBdOZm9itpV1pGI82A+Yh86T1kgKu
   Q==;
X-CSE-ConnectionGUID: QlNePTjoROSZgWy2OgeH4g==
X-CSE-MsgGUID: 88tNeYkJQdmCotIv1mmaag==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79979329"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79979329"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:30:21 -0700
X-CSE-ConnectionGUID: skSXPJNCQym/TcKOs9zyuA==
X-CSE-MsgGUID: pjW0z8i5S9aD0uStPypVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262852705"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa002.fm.intel.com with ESMTP; 17 May 2026 23:30:20 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr 4/4] zephyr-sdk: add v1.0.1
Date: Mon, 18 May 2026 13:14:37 +0800
Message-Id: <20260518051437.693745-4-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20260518051437.693745-1-chee.yang.lee@intel.com>
References: <20260518051437.693745-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 May 2026 06:30:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4000

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 meta-zephyr-core/conf/layer.conf                            | 2 +-
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_1.0.1.bb         | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_1.0.1.bb

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index 56e01f8..e9c97bb 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -22,4 +22,4 @@ PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages
 addpylib ${LAYERDIR}/lib oeqa
 
 PREFERRED_VERSION_zephyr-kernel ??= "4.4.0"
-PREFERRED_VERSION_zephyr-sdk-native ??= "0.17.4"
+PREFERRED_VERSION_zephyr-sdk-native ??= "1.0.1"
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_1.0.1.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_1.0.1.bb
new file mode 100644
index 0000000..1718801
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_1.0.1.bb
@@ -0,0 +1,6 @@
+require zephyr-sdk.inc
+
+SDK_ARCHIVE = "zephyr-sdk-${PV}_linux-${BUILD_ARCH}_gnu.tar.xz"
+
+SRC_URI[x86_64.sha256sum] = "37a8c5b5569c2b482d39099c65fe3ddac4e43524996c731907e1e9f5818cbba7"
+SRC_URI[aarch64.sha256sum] = "6e38018f70af5e90c18cc04c2f8ac5a91c99f5559b25692d1b0de328c3edb88a"
-- 
2.37.3


