Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F0D3CC95
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 01:10:19 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25988.1768439409031964481
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Jan 2026 17:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60F1A4H92303376;
	Wed, 14 Jan 2026 19:10:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 2/4] ports/linux/pseudo_wrappers.c: Reorder the syscall operations
Date: Wed, 14 Jan 2026 19:10:01 -0600
Message-Id: <1768439403-23665-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768439403-23665-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768439403-23665-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 01:10:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2956

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

The seccomp wrap always takes effect when pseudo is running, this will
prevent various behavior, even if pseudo is generally considered to be
disabled, but in memory.

The openat2 and renameat2 however should only run if pseudo is enabled.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 ports/linux/pseudo_wrappers.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 6b54083..b486c34 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -65,19 +65,6 @@ syscall(long number, ...) {
 		return rc;
 	}
 
-#ifdef SYS_renameat2
-	/* concerns exist about trying to parse arguments because syscall(2)
-	 * specifies strange ABI behaviors. If we can get better clarity on
-	 * that, it could make sense to redirect to wrap_renameat2().
-	 */
-	if (number == SYS_renameat2) {
-		errno = ENOSYS;
-		return -1;
-	}
-#else
-	(void) number;
-#endif
-
 #ifdef SYS_seccomp
 	/* pseudo and seccomp are incompatible as pseudo uses different syscalls
 	 * so pretend to enable seccomp but really do nothing */
@@ -92,6 +79,10 @@ syscall(long number, ...) {
 	}
 #endif
 
+        if (pseudo_disabled) {
+                goto call_syscall;
+        }
+
 #ifdef SYS_openat2
 	/* concerns exist about trying to parse arguments because syscall(2)
 	 * specifies strange ABI behaviors. If we can get better clarity on
@@ -105,6 +96,18 @@ syscall(long number, ...) {
 	}
 #endif
 
+#ifdef SYS_renameat2
+	/* concerns exist about trying to parse arguments because syscall(2)
+	 * specifies strange ABI behaviors. If we can get better clarity on
+	 * that, it could make sense to redirect to wrap_renameat2().
+	 */
+	if (number == SYS_renameat2) {
+		errno = ENOSYS;
+		return -1;
+	}
+#endif
+
+call_syscall:
 	/* gcc magic to attempt to just pass these args to syscall. we have to
 	 * guess about the number of args; the docs discuss calling conventions
 	 * up to 7, so let's try that?
-- 
1.8.3.1


