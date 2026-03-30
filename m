Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54A0FD0052
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 09:02:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46844.1774861322538621306
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 02:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=CB0g4Rxz;
 spf=pass (domain: intel.com, ip: 198.175.65.20, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774861323; x=1806397323;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LZQKSan57/9yv2/PryuDi4y+RHo5nMqt2TiX3MZWzeY=;
  b=CB0g4RxzzVP+b/lffObo0QqiQSnMyh0JghvIIWsqqhBeD32I3rJEnG2h
   jFahZ4uDAqIHLwzcX+yQUxksMewVyv+zZHHHIzV9H1au8RYVJMC+6a1JX
   xcwECwWAYMLOIuA+C5L3H8lLhqxmh3UNZU5PTHLxuJc1VKB8JDv12wSQR
   IJQHzvyVYtrp6A97pGLhOwjchCVJtTXcoVZ4LF+jSUowIPIJ8RHF5DAhG
   AMZONnvHBbzu1j4uA6bmNNrFJpiWIEiyvTXWFtr5Grt/pvXmOqQHif0Xt
   rwJ/qmHOPsxqnD1FxBYDt96gyn+Qj3EdhvPcR7ou9oqDKx7DLP12t7KMv
   A==;
X-CSE-ConnectionGUID: ca7GNem+QySmCIXLKMtm/w==
X-CSE-MsgGUID: TYCaEHDZQL2+x0d5ZILshg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75559316"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75559316"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:02:03 -0700
X-CSE-ConnectionGUID: CjR8OHKpQQOdiN2DSs7nag==
X-CSE-MsgGUID: ZXh+xrCNRN+MATiEe95Kcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225992887"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by orviesa008.jf.intel.com with ESMTP; 30 Mar 2026 02:02:02 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/2] README: update for testimage and machine
Date: Mon, 30 Mar 2026 15:46:26 +0800
Message-Id: <20260330074626.3818977-2-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20260330074626.3818977-1-chee.yang.lee@intel.com>
References: <20260330074626.3818977-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 09:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3582

From: Lee Chee Yang <chee.yang.lee@intel.com>

remove reference to qemu-nios2

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 README.md | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 4a7d75a..e66f158 100644
--- a/README.md
+++ b/README.md
@@ -163,12 +163,12 @@ metadata, you can also inject its value from command line with something like:
 
 ## Building and Running Zephyr Tests
 
-Presently only toolchains for ARM, x86, IAMCU and Nios2 are supported.
+Presently only toolchains for ARM, x86 and IAMCU are supported.
 (For ARM we use CortexM3 toolchain)
 
 To run Zephyr Test using Yocto Image Tests, ensure following in local.conf:
 ```
-    INHERIT += "testimage"
+    IMAGE_CLASSES += "testimage"
 ```
 
 You can build and test an individual existing Zephyr test.
@@ -187,9 +187,6 @@ zephyr-kernel-test.inc). For example:
 or 
     $ MACHINE=qemu-cortex-m3 bitbake zephyr-kernel-test-all
     $ MACHINE=qemu-cortex-m3 bitbake zephyr-kernel-test-all -c testimage
-or 
-    $ MACHINE=qemu-nios2 bitbake zephyr-kernel-test-all
-    $ MACHINE=qemu-nios2 bitbake zephyr-kernel-test-all -c testimage
 ```
 
 ## Generating OE Machines based on Zephyr board definitions
-- 
2.37.3


