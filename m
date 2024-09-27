Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46848CEBF71
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 02:48:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mx.groups.io with SMTP id smtpd.web10.60797.1727405297394162759
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Sep 2024 19:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=LFxK3LGT;
 spf=pass (domain: intel.com, ip: 198.175.65.14, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727405298; x=1758941298;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8zKEY5NgLHgx5l65uBmWX4i2KELPgfDhDY4MxfOO7Rc=;
  b=LFxK3LGTRQv1hBHRngCQgGW2h+nXqrv0LnznoS/H4PCvdExl7oXuDV6V
   27zW4B3I4bSkmnCdmO6hxdVsa+xdLIVv61ZjrCjDJt87hX0wzB4rzdYi+
   o9lNPZ3QiZlUh/c1NxjcFUg9jhKBmgj8KnU9+g84xcosgNU/dJW2N0h2o
   mqT66oA119RZVxBRdefAX1/QioWtomsVjUIzLzZI9TlRz8gEEVwxi5E57
   WxRUt1f0/a5nB908Bq/XcLJfRO30wk/koT5LmDWiWrnpC1KyrifckFHcz
   yua2KkQWsz+bc2CFlfh8lx3ZIYVx3Ox3WAZVLmj5vSqi9++2BauBvKWOz
   w==;
X-CSE-ConnectionGUID: WfjUPTfQSFuKe39vc4rBKQ==
X-CSE-MsgGUID: ZxsKKTpXTFuecUd0fA5C5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30330044"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="30330044"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 19:48:17 -0700
X-CSE-ConnectionGUID: ROW2keaAQMW9K0LrrdK/KA==
X-CSE-MsgGUID: ImTI6t+MQ7OdFzaOjXT9Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72538317"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by fmviesa008.fm.intel.com with ESMTP; 26 Sep 2024 19:48:16 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/2] libgloss: add bbappend
Date: Fri, 27 Sep 2024 10:03:53 +0800
Message-Id: <20240927020354.3338858-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 02:48:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/676

It carries patch to disable warnings as error for x86 32-bit
(qemu-x86) machine.

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 ...loss-i386-Disable-warnings-as-errors.patch | 41 +++++++++++++++++++
 .../recipes-core/newlib/libgloss_git.bbappend |  2 +
 2 files changed, 43 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch
 create mode 100644 meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend

diff --git a/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch b/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch
new file mode 100644
index 0000000..c512dde
--- /dev/null
+++ b/meta-zephyr-core/recipes-core/newlib/files/0001-libgloss-i386-Disable-warnings-as-errors.patch
@@ -0,0 +1,41 @@
+From 5dd8c118c904f5dd956ac754a10faddd35d22df2 Mon Sep 17 00:00:00 2001
+From: Naveen Saini <naveen.kumar.saini@intel.com>
+Date: Thu, 26 Sep 2024 16:43:43 +0800
+Subject: [PATCH] libgloss/i386: Disable warnings as errors
+
+i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:109:21: warning: implicit declaration of function 'sbrk' [-Wimplicit-function-declaration]
+  109 |   buffer = (char *) sbrk (monsize);
+      |                     ^~~~
+i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:112:7: warning: implicit declaration of function 'write'; did you mean 'fwrite'? [-Wimplicit-function-declaration]
+  112 |       write (2, MSG , sizeof(MSG));
+      |       ^~~~~
+      |       fwrite
+i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:113:7: warning: 'return' with no value, in function returning non-void [-Wreturn-mismatch]
+  113 |       return;
+      |       ^~~~~~
+i586-yocto-elf/libgloss/4.4.0+git/git/libgloss/i386/cygmon-gmon.c:198:1: warning: return type defaults to 'int' [-Wimplicit-int]
+  198 | _mcount()
+
+Upstream-Status: Inappropriate  [OE-Specific]
+
+Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
+---
+ libgloss/i386/Makefile.in | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/libgloss/i386/Makefile.in b/libgloss/i386/Makefile.in
+index 7ed0b075f..729f33d90 100644
+--- a/libgloss/i386/Makefile.in
++++ b/libgloss/i386/Makefile.in
+@@ -69,7 +69,7 @@ OBJCOPY = `if [ -f ${objroot}/../binutils/objcopy ] ; \
+ CRT0 = cygmon-crt0.o
+ CYGMON_OBJS = cygmon-salib.o cygmon-gmon.o
+ 
+-CFLAGS = -g
++CFLAGS = @CFLAGS@ -Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-error=return-mismatch
+ 
+ GCC_LDFLAGS = `if [ -d ${objroot}/../gcc ] ; \
+ 	then echo -L${objroot}/../gcc ; fi`
+-- 
+2.37.3
+
diff --git a/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend b/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend
new file mode 100644
index 0000000..756ef35
--- /dev/null
+++ b/meta-zephyr-core/recipes-core/newlib/libgloss_git.bbappend
@@ -0,0 +1,2 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+SRC_URI:append:qemu-x86 = " file://0001-libgloss-i386-Disable-warnings-as-errors.patch"
-- 
2.37.3


