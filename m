Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9239FC369C2
	for <webhook@archiver.kernel.org>; Sat,  3 May 2025 20:02:03 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.17576.1746302520574263206
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 May 2025 13:02:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 543JxuJv008895;
	Sat, 3 May 2025 14:59:57 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: skandigraun@gmail.com, landervanloock@gmail.com,
        richard.purdie@linuxfoundation.org, fntoth@gmail.com
Subject: [pseudo][PATCH v3 1/3] Move ftw and ftw64 to calling ntfw and nftw64
Date: Sat,  3 May 2025 14:59:53 -0500
Message-Id: <1746302395-8723-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 03 May 2025 20:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1481

From: Mark Hatle <mark.hatle@amd.com>

The 4 functions are very similar to each other: nftw-nftw64 and ftw-ftw64 are
identical to their pair, except for the stat struct they use (stat vs stat64).

nftw is a "superset" of ftw: nftw is backwards compatible with ftw, but it
also accepts a number of extra flags to modify its behavior.

Since all the 4 functions are so similar, the same codebase is used to
implement all (which is also fairly similar to their implementation in
glibc).

[1]: https://linux.die.net/man/3/nftw

Re-implemented, but based on the ideas from Gyorgy Sarvari <skandigraun@gmail.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 guts/README              |  4 ++--
 ports/linux/guts/ftw64.c |  9 ++++++++-
 ports/unix/guts/ftw.c    | 10 +++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/guts/README b/guts/README
index 0a1fe5f..bb2e573 100644
--- a/guts/README
+++ b/guts/README
@@ -54,6 +54,8 @@ other functions:
 	__xmknod:		__xmknodat
 	__xstat64:		__fxstatat64
 	__xstat:		__fxstatat
+	ftw:			nftw
+	ftw64:			nftw64
 
 The following functions are full implementations:
 
@@ -129,8 +131,6 @@ calling the underlying routine.
 	eaccess
 	euidaccess
 	fts_open
-	ftw64
-	ftw
 	glob64
 	glob
 	lutimes
diff --git a/ports/linux/guts/ftw64.c b/ports/linux/guts/ftw64.c
index 48adb80..72e80f1 100644
--- a/ports/linux/guts/ftw64.c
+++ b/ports/linux/guts/ftw64.c
@@ -9,7 +9,14 @@
  *	int rc = -1;
  */
 
-	rc = real_ftw64(path, fn, nopenfd);
+	// 1. Set the flag argument to 0, just like glibc does.
+	// 2. The difference between ftw and nftw callback
+	//    is only the last parameter: struct FTW is only used
+	//    by nftw(), and it is missing from ftw().
+	//    However since otherwise the stacklayout for the
+	//    functions is the same, this cast should work just the
+	//    way we want it. This is also borrowed from glibc.
+	rc = wrap_nftw64(path, (void *)fn, nopenfd, 0);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/ftw.c b/ports/unix/guts/ftw.c
index 58945a1..12a17f4 100644
--- a/ports/unix/guts/ftw.c
+++ b/ports/unix/guts/ftw.c
@@ -9,7 +9,15 @@
  *	int rc = -1;
  */
 
-	rc = real_ftw(path, fn, nopenfd);
+	// 1. Set the flag argument to 0, just like glibc does.
+	// 2. The difference between ftw and nftw callback
+	//    is only the last parameter: struct FTW is only used
+	//    by nftw(), and it is missing from ftw().
+	//    However since otherwise the stacklayout for the
+	//    functions is the same, this cast should work just the
+	//    way we want it. This is also borrowed from glibc.
+
+	rc = wrap_nftw(path, (void *)fn, nopenfd, 0);
 
 /*	return rc;
  * }
-- 
2.34.1


