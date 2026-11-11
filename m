Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2580.1794370869495018894
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mE2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 28/34] ports/linux: Don't require <linux/mount.h>
Date: Tue, 10 Nov 2026 22:20:56 -0600
Message-Id: <1794370862-30908-29-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5283
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

<linux/mount.h> only exists in kernel headers from 5.2, so pseudo no
longer built on older hosts such as CentOS 7.  pseudo only needs
OPEN_TREE_CLONE, which already has a fallback, and struct mount_attr,
which is only used through pointers, so declare it instead of including
the header.  The forward declaration is also needed without the header,
or each prototype using the struct declares a different type.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/portdefs.h             | 7 +++++--
 test/test-open_tree_attr-syscall.c | 1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 97ddcb6..255b2ec 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -34,7 +34,6 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #include <sys/prctl.h>
 #include <linux/seccomp.h>
 #include <sys/mount.h>
-#include <linux/mount.h>
 
 /* close_range()'s flags, and unshare(), are only declared by glibc under
  * _GNU_SOURCE, which pseudo does not build with. <linux/close_range.h> is
@@ -93,11 +92,15 @@ extern int unshare(int flags);
 #define SYS_open_tree __NR_open_tree
 #endif
 
-/* OPEN_TREE_CLONE may be missing from older host headers.
+/* The new mount API is only in <sys/mount.h> from glibc 2.36, and
+ * <linux/mount.h> is missing from older kernel headers (before 5.2), so
+ * don't rely on either.  OPEN_TREE_CLONE is kernel ABI, and struct
+ * mount_attr is only used through pointers, so it can stay incomplete.
  */
 #ifndef OPEN_TREE_CLONE
 #define OPEN_TREE_CLONE (1U << 0)
 #endif
+struct mount_attr;
 
 #ifndef SYS_open_tree_attr
 
diff --git a/test/test-open_tree_attr-syscall.c b/test/test-open_tree_attr-syscall.c
index e4e652e..aead9d4 100644
--- a/test/test-open_tree_attr-syscall.c
+++ b/test/test-open_tree_attr-syscall.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
-#include <linux/mount.h>
 #include <sys/stat.h>
 
 #ifndef SYS_open_tree_attr
-- 
1.8.3.1

