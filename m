Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E354ECD4F51
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 06:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2670.1779085819162090919
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 May 2026 23:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=hln5zTFw;
 spf=pass (domain: intel.com, ip: 198.175.65.18, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779085819; x=1810621819;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4endzldL3tyQ3rWEmno4Ea1p16vz6cQK5rt9kL+izvw=;
  b=hln5zTFwK63gjfvy2OcXg9bOLCwzZQuIgpMS8wpl0EN3utXsBQ1UAP3w
   bxTmYl1PTG1J/O7TpYsD4m8ZaNWE6ecqdYPPuWs0k/XSadsXNbMnGvVWL
   nq1pLX4JncVtrsB0rr2eM78uTU2/ljaoQPwXWJ+JTUncaJLaAYKOmXICA
   a1Rm4pAMTGt1wpwgUbmS3hO+JhsbjLLDHyhHHeiHYEAmSwWNRU4t3uwiz
   jKJmR9Ax9RX67Ngpzf/Y1MAGCpwKSv+cc7OhEEyFlOlRczfPMK8SIVx+Q
   jjVJdPcSeHrdF+kYYmsThC6dHY/v8MzZt5Ci9uU2PhDLHK0td5HcrIMAq
   w==;
X-CSE-ConnectionGUID: MjmwEcZ0TnWbXKJdLd4Muw==
X-CSE-MsgGUID: zJMCHKgwQUaPPHtr9EEJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79979315"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79979315"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:30:18 -0700
X-CSE-ConnectionGUID: oyRZUEb1Tqi2uCTBUOYTKA==
X-CSE-MsgGUID: 4dMWYTeMQcyTDTujR4aecA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262852687"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa002.fm.intel.com with ESMTP; 17 May 2026 23:30:18 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr 2/4] zephyr-kernel: fix cross compilation
Date: Mon, 18 May 2026 13:14:35 +0800
Message-Id: <20260518051437.693745-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20260518051437.693745-1-chee.yang.lee@intel.com>
References: <20260518051437.693745-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 May 2026 06:30:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3998

From: Lee Chee Yang <chee.yang.lee@intel.com>

set CONFIG_STATIC_INIT_GNU=y when cross-compile toochain selected.

Fix:
| /data/wrynose/bitbake-builds/zephyr-master/build/tmp/work/i586-yocto-elf/zephyr-helloworld/4.3.0+git/recipe-sysroot-native/usr/bin/i586-yocto-elf/i586-yocto-elf-ld.bfd: GNU-style constructors required but STATIC_INIT_GNU not enabled
| /data/wrynose/bitbake-builds/zephyr-master/build/tmp/work/i586-yocto-elf/zephyr-helloworld/4.3.0+git/recipe-sysroot-native/usr/bin/i586-yocto-elf/i586-yocto-elf-ld.bfd: warning: zephyr/zephyr_pre0.elf has a LOAD segment with RWX permissions
| collect2: error: ld returned 1 exit status
| ninja: build stopped: subcommand failed.

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
index 3a8a4da..eb8f224 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
@@ -26,6 +26,7 @@ EXTRA_OECMAKE = "\
     -DSOC_ROOT=${SOC_ROOT} \
     -DZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT} \
     -DZEPHYR_MODULES=${ZEPHYR_MODULES} \
+    ${@bb.utils.contains('ZEPHYR_TOOLCHAIN_VARIANT', 'cross-compile', '-DCONFIG_STATIC_INIT_GNU=y', '', d)} \
     "
 
 ZEPHYR_EXTRA_MODULES = ""
-- 
2.37.3


