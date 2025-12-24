Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B68E7491C
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 06:47:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115949.1766558823446130229
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 22:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=HoW/YRbo;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766558823; x=1798094823;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UX3LCLSe8Yq/4yPkP2pfLXexeeUqzywEGbTwF2ENMcI=;
  b=HoW/YRboJaulK4UQBP+PncllNQ2PkbxPW+tuoZEpFyz42mrb+2rBBr3i
   ouvY0erM2vnvGs8dINYFuuceQMTgaS9BPgj4UWvOYPIYDtqLlZMxn/9o/
   i910m0lSIDwFBNh0ohsp7thZ8LlKWcO14m6YqlLnR8oG572aZ/nCzejdU
   OPukfQ3hQHpMLtf0ShqfA4DpuIphbXPC0ztavqzehJ2Fl4EB4/n1NWzjk
   Z+tg4sO6Am9iYkzPTBMT29D4Dce6cgUG3/5J5B4qfySK6u8T+X8foEhdg
   7nmVFU1NS/FvntZ56Ea6G+r9YxsZJ4MG8rf/eRHk/ngc/98HZ/X2Q0j4x
   Q==;
X-CSE-ConnectionGUID: X16pUMKMR8CqMORIDRYJlA==
X-CSE-MsgGUID: yb7EOCWLQKiMlj7jyFEKyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79518829"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79518829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:47:02 -0800
X-CSE-ConnectionGUID: VeGQPYQURvuAgjG19iZaTg==
X-CSE-MsgGUID: MWAqMWMQTuSsuej5Br7qXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="230614379"
Received: from cheeyang-desk4.png.intel.com ([10.107.249.123])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2025 22:47:01 -0800
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/4] libgloss: update bbappend to match 4.5.0
Date: Wed, 24 Dec 2025 14:46:32 +0800
Message-ID: <20251224064635.1187089-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 06:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2867

From: Lee Chee Yang <chee.yang.lee@intel.com>

the patch no longer applies, remove it and append the build
flags to CFLAGS

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 ...loss-i386-Disable-warnings-as-errors.patch | 41 -------------------
 .../recipes-core/newlib/libgloss_git.bbappend |  4 +-
 2 files changed, 2 insertions(+), 43 deletions(-)
 delete mode 100644 meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch

diff --git a/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch b/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch
deleted file mode 100644
index c512dde..0000000
--- a/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-From 5dd8c118c904f5dd956ac754a10faddd35d22df2 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Thu, 26 Sep 2024 16:43:43 +0800
-Subject: [PATCH] libgloss/i386: Disable warnings as errors
-
-i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:109:21: warning: implicit declaration of function 'sbrk' [-Wimplicit-function-declaration]
-  109 |   buffer = (char *) sbrk (monsize);
-      |                     ^~~~
-i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:112:7: warning: implicit declaration of function 'write'; did you mean 'fwrite'? [-Wimplicit-function-declaration]
-  112 |       write (2, MSG , sizeof(MSG));
-      |       ^~~~~
-      |       fwrite
-i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:113:7: warning: 'return' with no value, in function returning non-void [-Wreturn-mismatch]
-  113 |       return;
-      |       ^~~~~~
-i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:198:1: warning: return type defaults to 'int' [-Wimplicit-int]
-  198 | _mcount()
-
-Upstream-Status: Inappropriate  [OE-Specific]
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- libgloss/i386/Makefile.in | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/libgloss/i386/Makefile.in b/libgloss/i386/Makefile.in
-index 7ed0b075f..729f33d90 100644
---- a/libgloss/i386/Makefile.in
-+++ b/libgloss/i386/Makefile.in
-@@ -69,7 +69,7 @@ OBJCOPY = `if [ -f ${objroot}/../binutils/objcopy ] ; \
- CRT0 = cygmon-crt0.o
- CYGMON_OBJS = cygmon-salib.o cygmon-gmon.o
- 
--CFLAGS = -g
-+CFLAGS = @CFLAGS@ -Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-error=return-mismatch
- 
- GCC_LDFLAGS = `if [ -d ${objroot}/../gcc ] ; \
- 	then echo -L${objroot}/../gcc ; fi`
--- 
-2.37.3
-
diff --git a/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend b/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend
index 756ef35..6488e53 100644
--- a/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend
+++ b/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend
@@ -1,2 +1,2 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
-SRC_URI:append:qemu-x86 = " file://0001-libgloss-i386-Disable-warnings-as-errors.patch"
+CFLAGS:append:qemu-x86 = " -Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-error=return-mismatch "
+
-- 
2.43.0


