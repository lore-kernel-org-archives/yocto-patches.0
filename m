Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2575.1794370866636441874
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lx2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:06 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 13/34] ports/linux: Drop redundant PSEUDO_LINK_SYMLINK_BEHAVIOR override
Date: Tue, 10 Nov 2026 22:20:41 -0600
Message-Id: <1794370862-30908-14-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5273
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

ports/linux/portdefs.h redefined PSEUDO_LINK_SYMLINK_BEHAVIOR to 0,
the default already set in pseudo.h.  Remove it, and move its note that
0 means not following symlinks, because linkat() rejects
AT_SYMLINK_NOFOLLOW, into the comment in pseudo.h.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/portdefs.h | 9 ---------
 pseudo.h               | 3 ++-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 3ac9466..97ddcb6 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -15,15 +15,6 @@
 #define base_stat real_stat64
 #define base_fstatat(dirfd, path, buf, flags) real___fxstatat64(_STAT_VER, dirfd, path, buf, flags)
 #define PSEUDO_LINKPATH_SEPARATOR " "
-/* Linux NEVER follows symlinks for link(2)... except on old kernels
- * I don't care about.
- */
-#undef PSEUDO_LINK_SYMLINK_BEHAVIOR
-/* Note: 0, here, really means AT_SYMLINK_NOFOLLOW, but specifying that
- * causes errors; you have to leave it empty or specify AT_SYMLINK_FOLLOW.
- */
-#define PSEUDO_LINK_SYMLINK_BEHAVIOR 0
-
 /* There were symbol changes that can cause the linker to request
  * newer versions of glibc, which causes problems occasionally on
  * older hosts if pseudo is built against a newer glibc and then
diff --git a/pseudo.h b/pseudo.h
index d83281c..13249bf 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -155,7 +155,8 @@ extern char *pseudo_version;
  * would ever do that? Well, Linux did, and possibly as a result, linkat()
  * does by default too; if you are on a host with the historical Unix
  * behavior of following symlinks to find the link target, you will want
- * to set this to AT_SYMLINK_FOLLOW.
+ * to set this to AT_SYMLINK_FOLLOW.  0 means not following them; it can't
+ * be AT_SYMLINK_NOFOLLOW, as linkat() rejects that flag.
  */
 #define PSEUDO_LINK_SYMLINK_BEHAVIOR 0
 
-- 
1.8.3.1

