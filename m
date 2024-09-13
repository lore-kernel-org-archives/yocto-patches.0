Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FEAFA3747
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 11:16:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mx.groups.io with SMTP id smtpd.web11.70963.1726226153965809707
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Sep 2024 04:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=YBFlKnBh;
 spf=pass (domain: intel.com, ip: 192.198.163.19, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726226154; x=1757762154;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AjqMY4fXQxd8FzXy9G3lR1t+pjVWMdOd3jYO8yFucI4=;
  b=YBFlKnBhKcTTc2w5j+Wz/9KYRj96hHKUQBkABvb0o3Cy1FHbvbO2R+WI
   CXClhOn4dQrqd5HvvKzoaDTAecSaTZUQFrqpVAvadAhkVXKVHq6bCd+qw
   8wJMY6KK9e8K5Cxzcp0BSH2MqsdsoDVyyiIFCIqlt54Y4VH0MqUmc6DmK
   LFLYpvOPBKEnC6vcd9hKNNjT+AkYyr9d3DA3ivBFORCsMsAj3zxF6ZCQY
   GUTazPJDiLBA8epm6BBcMGIK4wyVX+t5x+A7NV6tbhQl72SUFs1lq0R27
   a9RQozuo/xyATzmpm2HFyFDO/6ng/Cbk45lRTCRdxJ0amfXRxsPtP0F31
   w==;
X-CSE-ConnectionGUID: r1KvCU89SoKPG7u8G8hdzw==
X-CSE-MsgGUID: pE1h8wqVSAaKqLcxYk7ckQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24662852"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24662852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:15:53 -0700
X-CSE-ConnectionGUID: vm/yvuONR2WAGXXinkhfxQ==
X-CSE-MsgGUID: s3b2whkGRnGRUq+yAUf+sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67873272"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2024 04:15:53 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] x86: fix build for up_squared boards
Date: Fri, 13 Sep 2024 18:32:12 +0800
Message-Id: <20240913103212.59979-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Sep 2024 11:16:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/656

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 ...ry-generation-issue-in-cross-compila.patch | 38 ++++++++++++++++---
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v3.7.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v3.7.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
index 858ef47..d563589 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v3.7.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v3.7.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
@@ -1,4 +1,4 @@
-From 770ab47f542366cecd56dc35037947679eacc5f0 Mon Sep 17 00:00:00 2001
+From 90d5e7c9c6037a030d5c0bfa4ae298da66eaf35e Mon Sep 17 00:00:00 2001
 From: Naveen Saini <naveen.kumar.saini@intel.com>
 Date: Thu, 12 Sep 2024 21:05:09 +0800
 Subject: [PATCH] x86: fix efi binary generation issue in cross compilation env
@@ -9,11 +9,13 @@ Upstream-Status: Inappropriate [Cross-compilation specific]
 
 Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
 ---
- arch/x86/zefi/zefi.py           | 5 ++++-
- boards/intel/adl/CMakeLists.txt | 1 +
- boards/intel/ehl/CMakeLists.txt | 1 +
- boards/intel/rpl/CMakeLists.txt | 1 +
- 4 files changed, 7 insertions(+), 1 deletion(-)
+ arch/x86/zefi/zefi.py                                       | 5 ++++-
+ boards/intel/adl/CMakeLists.txt                             | 1 +
+ boards/intel/ehl/CMakeLists.txt                             | 1 +
+ boards/intel/rpl/CMakeLists.txt                             | 1 +
+ boards/up-bridge-the-gap/up_squared/CMakeLists.txt          | 1 +
+ boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt | 1 +
+ 6 files changed, 9 insertions(+), 1 deletion(-)
 
 diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
 index 99c188ecd08..1cd86a21cd4 100755
@@ -67,6 +69,30 @@ diff --git a/boards/intel/rpl/CMakeLists.txt b/boards/intel/rpl/CMakeLists.txt
 index 36ddcdf9d13..4cb244a777d 100644
 --- a/boards/intel/rpl/CMakeLists.txt
 +++ b/boards/intel/rpl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/up-bridge-the-gap/up_squared/CMakeLists.txt b/boards/up-bridge-the-gap/up_squared/CMakeLists.txt
+index ddfd93807ff..8dfe7aa9cec 100644
+--- a/boards/up-bridge-the-gap/up_squared/CMakeLists.txt
++++ b/boards/up-bridge-the-gap/up_squared/CMakeLists.txt
+@@ -11,6 +11,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt b/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
+index 36ddcdf9d13..4cb244a777d 100644
+--- a/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
++++ b/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
 @@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_commands
    -o ${CMAKE_OBJCOPY}
    -i ${ZEPHYR_BASE}/include
-- 
2.37.3


