Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E390D44C4E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.765.1768520625112525947
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjj2408772;
	Thu, 15 Jan 2026 17:43:41 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 14/20] ports/linux/pseudo_wrappers.c: Call the wrappers where possible
Date: Thu, 15 Jan 2026 17:43:30 -0600
Message-Id: <1768520616-7289-15-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2992

Using va args, call the wrapper when the syscall is invoked.  This will
allow us to implement the renameat2 and openat2 functions in the future
while keeping the syscall work unchanged.

The syscall -> wrappers should continue to be sparse into things we know
are outliers, as this could result in some maintenance work keeping the
argument processing sane.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/linux/pseudo_wrappers.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index b486c34..7c025ae 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -84,26 +84,31 @@ syscall(long number, ...) {
         }
 
 #ifdef SYS_openat2
-	/* concerns exist about trying to parse arguments because syscall(2)
-	 * specifies strange ABI behaviors. If we can get better clarity on
-	 * that, it could make sense to redirect to wrap_openat2().
-	 * There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream which
+	/* There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream which
 	 * uses syscall to access openat2() and breaks builds if we don't redirect.
 	 */
 	if (number == SYS_openat2) {
-		errno = ENOSYS;
-		return -1;
+		va_start(ap, number);
+		int dirfd = va_arg(ap, int);
+		const char * path = va_arg(ap, const char *);
+		void *how = va_arg(ap, void *);
+		size_t size = va_arg(ap, size_t);
+
+		return wrap_openat2(dirfd, path, how, size);
 	}
 #endif
 
 #ifdef SYS_renameat2
-	/* concerns exist about trying to parse arguments because syscall(2)
-	 * specifies strange ABI behaviors. If we can get better clarity on
-	 * that, it could make sense to redirect to wrap_renameat2().
-	 */
+        /* Call out wrapper, expanding the variable arguments first */
 	if (number == SYS_renameat2) {
-		errno = ENOSYS;
-		return -1;
+		va_start(ap, number);
+		int olddirfd = va_arg(ap, int);
+		const char * oldpath = va_arg(ap, const char *);
+		int newdirfd = va_arg(ap, int);
+		const char * newpath = va_arg(ap, const char *);
+		unsigned int flags = va_arg(ap, unsigned int);
+
+		return wrap_renameat2(olddirfd, oldpath, newdirfd, newpath, flags);
 	}
 #endif
 
-- 
2.43.0


