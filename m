Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D6E74ADE
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 06:47:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115949.1766558823446130229
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 22:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=AUg8Kxc0;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766558824; x=1798094824;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xGmo5U99tC99kVfjG4zczUuHkOL9eRtW9rxt0FqYmww=;
  b=AUg8Kxc0zqhV00+2GBdu/1gzdCg+SpSAPSrlL66+kiJp43KMaevokTwZ
   9F2UXJgjpe2omuAmho8lfmT3obOudyUBiAEt1TVzy7rIetnYid25CqecX
   e3CHOvTEt3725Zx3dlfubXXoD5dg+GplqXmuoY2+NiZ65L68GtHVBNZMa
   yrV+QDsYlLvMUeUKPgCvOuS3JDDz1nv3DWk5aP1iNzOQX1O5JxuUnS62w
   arkOWdAEqb9gMFwK3URyB9fn8Q2ricZYD/qnUODBBtCzyVCcbdWXlafqS
   B3DZtn5FQQSYbyt4dFYJ3YtnOjSWBgAa/oSc34SkGsR12AgjpnhNdtypH
   A==;
X-CSE-ConnectionGUID: uetW7zp5SweNO9IrlbSmRQ==
X-CSE-MsgGUID: 2KoR/PlCSKOX0zK5LQRrcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79518833"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79518833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:47:04 -0800
X-CSE-ConnectionGUID: zgoWrsT7TLGhwQPTFjfLhw==
X-CSE-MsgGUID: L8maorqpQIqtaxBSjwi/jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="230614383"
Received: from cheeyang-desk4.png.intel.com ([10.107.249.123])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2025 22:47:02 -0800
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/4] zephyr-kernel-4.2.0: fix unable to find gen_kobject_list.py
Date: Wed, 24 Dec 2025 14:46:33 +0800
Message-ID: <20251224064635.1187089-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224064635.1187089-1-chee.yang.lee@intel.com>
References: <20251224064635.1187089-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 06:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2868

From: Lee Chee Yang <chee.yang.lee@intel.com>

Fix error when build using Yocto toolchain.

| Run Build Command(s): ninja -v -j 22 all
| ninja: error: 'zephyr/GEN_KOBJECT_LIST-NOTFOUND', needed by 'zephyr/include/generated/zephyr/driver-validation.h', missing and no known rule to make it

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 ...-fix-unable-find-gen_kobject_list.py.patch | 30 +++++++++++++++++++
 .../zephyr-kernel/zephyr-kernel-src-4.2.0.inc |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-fix-unable-find-gen_kobject_list.py.patch

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-fix-unable-find-gen_kobject_list.py.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-fix-unable-find-gen_kobject_list.py.patch
new file mode 100644
index 0000000..f5c550c
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-fix-unable-find-gen_kobject_list.py.patch
@@ -0,0 +1,30 @@
+From 0a9f8fedd237c4783ca3bf5c5721a1c940988984 Mon Sep 17 00:00:00 2001
+From: Lee Chee Yang <chee.yang.lee@intel.com>
+Date: Wed, 17 Dec 2025 12:27:39 +0800
+Subject: [PATCH] fix unable find gen_kobject_list.py
+
+| Run Build Command(s): ninja -v -j 22 all
+| ninja: error: 'zephyr/GEN_KOBJECT_LIST-NOTFOUND', needed by 'zephyr/include/generated/zephyr/driver-validation.h', missing and no known rule to make it
+
+Upstream-Status: Inappropriate [Cross-compilation specific]
+
+Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
+---
+ cmake/kobj.cmake | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/cmake/kobj.cmake b/cmake/kobj.cmake
+index 6ccb85245fc..fa757509cfa 100644
+--- a/cmake/kobj.cmake
++++ b/cmake/kobj.cmake
+@@ -1,6 +1,6 @@
+ # SPDX-License-Identifier: Apache-2.0
+ 
+-find_program(GEN_KOBJECT_LIST NAMES gen_kobject_list gen_kobject_list.py PATHS ${ZEPHYR_BASE}/scripts/build)
++find_program(GEN_KOBJECT_LIST NAMES gen_kobject_list gen_kobject_list.py PATHS ${ZEPHYR_BASE}/scripts/build NO_CMAKE_FIND_ROOT_PATH)
+ message(STATUS "Found gen_kobject_list: ${GEN_KOBJECT_LIST}")
+ if(GEN_KOBJECT_LIST MATCHES "\.py$")
+   set(GEN_KOBJECT_LIST_INTERPRETER ${PYTHON_EXECUTABLE})
+-- 
+2.43.0
+
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
index 40bfb6c..9ec8c88 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0.inc
@@ -146,6 +146,7 @@ SRC_URI_ZEPHYR_ZCBOR ?= "git://github.com/zephyrproject-rtos/zcbor;protocol=http
 
 SRC_URI_PATCHES ?= "\
     file://0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch;patchdir=zephyr \
+    file://0001-fix-unable-find-gen_kobject_list.py.patch;patchdir=zephyr \
 "
 
 SRC_URI = "\
-- 
2.43.0


