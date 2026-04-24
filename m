Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE3FDEE5C
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 01:51:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12462.1776995471659794286
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 18:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=B5HZT3fI;
 spf=pass (domain: intel.com, ip: 198.175.65.16, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776995473; x=1808531473;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UWregZzW9endZOSIRJSqZ9geEM9Y7h8gtKHmw/ldjBQ=;
  b=B5HZT3fIEmUseNuZInZ8FiWTlginGf12K6XKfMkxNRRIuwttY88LpAgc
   kh2faCqs0FLCI7K+5FJkC7ZXtFW8bigR3gRZc/5QQSrYfFVgvYEssCnpF
   ainqDYOPBSQ0VQ/c77HYyQ94DTG7bmQXGPP7JVFCtpDtxWwB3vgvxXE/M
   n52YFfln53R6KrJdgMNEpEebwxriPiJojzBKINdJAjxDNmE2ruqTzTxU0
   7eGU6q5IUMC3Ky2BurjVkhkK5LfoGyQ/uhrEv7GZ8STMARfUUvVwY2Aey
   /yI10zIWNRVDAXKUMIJ3/GCPSBqFDKYr22c9zXhubOOFKcQ98IrTSZJYZ
   Q==;
X-CSE-ConnectionGUID: xoZrvJobTFmoKt1ePm0K/A==
X-CSE-MsgGUID: SprDDderTQaDIaDc+aA96g==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78164936"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="78164936"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 18:51:12 -0700
X-CSE-ConnectionGUID: HahJpF5HRf+mtopWVb33Dw==
X-CSE-MsgGUID: 1kZCz/zfQi6M6ptJcW9zXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="237812140"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa005.fm.intel.com with ESMTP; 23 Apr 2026 18:51:10 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr 2/2] zephyr-kernel-test: split ZEPHYRTESTS by version
Date: Fri, 24 Apr 2026 08:35:32 +0800
Message-Id: <20260424003532.1493655-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20260424003532.1493655-1-chee.yang.lee@intel.com>
References: <20260424003532.1493655-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 01:51:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3784

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 ...-test.inc => zephyr-kernel-test-3.7.0.inc} |  0
 .../zephyr-kernel-test-4.3.0.inc              | 66 +++++++++++++++++++
 .../zephyr-kernel/zephyr-kernel-test-all.bb   |  2 +-
 .../zephyr-kernel/zephyr-kernel-test.bb       |  2 +-
 4 files changed, 68 insertions(+), 2 deletions(-)
 rename meta-zephyr-core/recipes-kernel/zephyr-kernel/{zephyr-kernel-test.inc => zephyr-kernel-test-3.7.0.inc} (100%)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-3.7.0.inc
similarity index 100%
rename from meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
rename to meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-3.7.0.inc
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc
new file mode 100644
index 0000000..290cb58
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-4.3.0.inc
@@ -0,0 +1,66 @@
+# Exclude tests that fail to configure
+ZEPHYRTESTS:remove = "fifo \
+    fpu_sharing \
+    lifo \
+    mbox \
+    mem_heap \
+    mem_pool \
+    mem_protect \
+    mem_slab \
+    msgq \
+    mutex \
+    pipe \
+    profiling \
+    sched \
+    semaphore \
+    stack \
+    threads \
+    tickless \
+    timer \
+    workq"
+
+# Exclude tests that are not currently compiling
+ZEPHYRTESTS:remove = "ipi_cascade ipi_optimize ipi_work mp smp smp_abort smp_boot_delay smp_suspend  spinlock"
+ZEPHYRTESTS:remove:96b-avenger96 = "cache common device poll queue sleep"
+ZEPHYRTESTS:remove:stm32mp157c-dk2 = "cache common device poll queue sleep"
+
+# List of all available kernel tests
+ZEPHYRTESTS = " \
+    cache \
+    common \
+    context \
+    device \
+    early_sleep \
+    fifo \
+    fpu_sharing \
+    ipi_cascade \
+    ipi_optimize \
+    ipi_work \
+    lifo \
+    mbox \
+    mem_heap \
+    mem_protect \
+    mem_slab \
+    mp \
+    msgq \
+    mutex \
+    obj_tracking \
+    pending \
+    pipe \
+    poll \
+    profiling \
+    queue \
+    sched \
+    semaphore \
+    sleep \
+    smp \
+    smp_abort \
+    smp_boot_delay \
+    smp_suspend \
+    spinlock \
+    stack \
+    threads \
+    tickless \
+    timer \
+    workq \
+    "
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb
index d9dbb40..faaf403 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb
@@ -1,7 +1,7 @@
 LICENSE = "Apache-2.0"
 INHIBIT_DEFAULT_DEPS = "1"
 
-require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test-${PREFERRED_VERSION_zephyr-kernel}.inc
 
 addtask testimage
 deltask compile
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
index 75b1757..13532b6 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
@@ -1,4 +1,4 @@
 require recipes-kernel/zephyr-kernel/zephyr-image.inc
-require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test-${PREFERRED_VERSION_zephyr-kernel}.inc
 
 BBCLASSEXTEND = '${@" ".join(["zephyrtest:" + x for x in d.getVar("ZEPHYRTESTS", True).split()])}'
-- 
2.37.3


