Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FFC27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 05:03:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mx.groups.io with SMTP id smtpd.web11.4348.1718341392866931353
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 22:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=VfDl4Tfv;
 spf=pass (domain: intel.com, ip: 192.198.163.15, mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718341392; x=1749877392;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zj1HpLHvc9S02DN8rdXdndJMhx82oTFcHgyBLJjn6ow=;
  b=VfDl4Tfv52x9BwaEhoxoLhy+/yti4cGcF0067JOt6cpD7b8jhmHrTdOk
   9avzqA+NmY1NDyX6Gu/CLgN08tQV7rOn0AO/HVAgRDG5NVlAwjM9V+qaO
   IazoGERHy8J+RbTjKH+4zo78ETZibtLoA9KPDF6RZDm0amH8tNf43HRfm
   Cu7odYCnrrS90UE7+OvcPGZ0k+dmN2VFgCk+VqGgKzxc6R3/oVbucrLmY
   e2+pTQPlIMA4nosjuOlAXJ1kUhrZ3GUTZlkEu2STDT6pK/3PPY2qZrDzK
   evWpwlM3diHyDBwAimgVXnh5ADPVFW+6fqKp1RcBfOpMLj3PF4R8wHDZ0
   A==;
X-CSE-ConnectionGUID: Qg4mEK8mTpGEuu5MfVauAw==
X-CSE-MsgGUID: eWXOdd2GRYy1cuB2NPXGhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15371715"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15371715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 22:03:12 -0700
X-CSE-ConnectionGUID: aI+rJRBoRRiCXciwnwc50g==
X-CSE-MsgGUID: CnZSL/ATSnaUKZLe/QdQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71160949"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO anmitta2-mobl4.intel.com) ([10.247.118.113])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 22:03:11 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-tensorflow][PATCH] bazel-native: fix build with gcc14
Date: Fri, 14 Jun 2024 13:03:05 +0800
Message-ID: <20240614050305.246809-1-anuj.mittal@intel.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 05:03:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/328

Backport patch to fix errors while building zlib. Fixes:

| external/bazel_tools/third_party/zlib/gzwrite.c: In function 'gz_comp':
| external/bazel_tools/third_party/zlib/gzwrite.c:89:20: error: implicit declaration of function 'write'; did you mean 'fwrite'? [-Wimplicit-function-declaration]
|    89 |             writ = write(state->fd, strm->next_in, put);
|       |                    ^~~~~
|       |                    fwrite
| external/bazel_tools/third_party/zlib/gzwrite.c: In function 'gzclose_w':
| external/bazel_tools/third_party/zlib/gzwrite.c:673:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
|   673 |     if (close(state->fd) == -1)
|       |         ^~~~~
|       |         pclose

Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
 ...3ed4ac717b814d02a0d125f160ddabe78003.patch | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index c930054..29abd0e 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
@@ -11,6 +11,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
            file://0001-cutsomize-native-toolchains-for-Yocto.patch \
            file://0001-fix-compile-failure-on-gcc-13.patch \
+           file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
 "
 
 inherit python3native
diff --git a/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch b/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
new file mode 100644
index 0000000..abacf87
--- /dev/null
+++ b/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
@@ -0,0 +1,57 @@
+From 1f2b3ed4ac717b814d02a0d125f160ddabe78003 Mon Sep 17 00:00:00 2001
+From: Yun Peng <pcloudy@google.com>
+Date: Wed, 5 Apr 2023 15:13:26 +0200
+Subject: [PATCH] Patch zlib to fix compatibility with latest Xcode
+
+Fixes https://github.com/bazelbuild/bazel/issues/17956
+
+Partial commit for third_party/*, see #17987.
+
+Closes #17987
+
+Signed-off-by: Yun Peng <pcloudy@google.com>
+
+Upstream-Status: Backport [https://github.com/bazelbuild/bazel/commit/1f2b3ed4ac717b814d02a0d125f160ddabe78003]
+Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
+---
+ third_party/zlib/gzguts.h   |  4 ++++
+ third_party/zlib/zlib.patch | 15 +++++++++++++++
+ 2 files changed, 19 insertions(+)
+ create mode 100644 third_party/zlib/zlib.patch
+
+diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
+index 57faf37165a354..54f668fcb20536 100644
+--- a/third_party/zlib/gzguts.h
++++ b/third_party/zlib/gzguts.h
+@@ -3,6 +3,10 @@
+  * For conditions of distribution and use, see copyright notice in zlib.h
+  */
+ 
++#ifndef _WIN32
++  #include <unistd.h>
++#endif
++
+ #ifdef _LARGEFILE64_SOURCE
+ #  ifndef _LARGEFILE_SOURCE
+ #    define _LARGEFILE_SOURCE 1
+diff --git a/third_party/zlib/zlib.patch b/third_party/zlib/zlib.patch
+new file mode 100644
+index 00000000000000..7181d44aa9f9b1
+--- /dev/null
++++ b/third_party/zlib/zlib.patch
+@@ -0,0 +1,15 @@
++diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
++index 57faf37165..54f668fcb2 100644
++--- a/third_party/zlib/gzguts.h
+++++ b/third_party/zlib/gzguts.h
++@@ -3,6 +3,10 @@
++  * For conditions of distribution and use, see copyright notice in zlib.h
++  */
++ 
+++#ifndef _WIN32
+++  #include <unistd.h>
+++#endif
+++
++ #ifdef _LARGEFILE64_SOURCE
++ #  ifndef _LARGEFILE_SOURCE
++ #    define _LARGEFILE_SOURCE 1

