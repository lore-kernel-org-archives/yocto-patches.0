Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6183CD4F24
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.613.1778624449003553644
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiF01619785;
	Tue, 12 May 2026 17:20:46 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 3/5] renameat2/renameat: only ignore when both old and new path are not in PSEUDO_INCLUDE_PATHS
Date: Tue, 12 May 2026 17:20:41 -0500
Message-Id: <1778624443-20857-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3980

From: Changqing Li <changqing.li@windriver.com>

The patch is for fixing failure in the following scenario:
[snip of recipe]
    do_install() {
        mv ${B}/hello.txt ${D}/hello.txt
        ln ${D}/hello.txt ${D}/hello2.txt
    }
    FILES:${PN} += "/hello2.txt /hello.txt"
[snip of recipe]

do_package will failed with pseudo abort error.

Root Cause:
For command mv, when oldpath is not in PSEUDO_INCLUDE_PATHS, the renameat2
will skip the wrapper and call real renameat2, and no entry is inserted
in files.db. Then command ln, insert an entry for hello2.txt in
files.db, which with the same inode with hello.txt. During do_package
stage, when stat for hello.txt, it will find a path mismatch failure
like:
path mismatch [2 links]: ino 190860603 db 'hello2.txt' req 'hello.txt'

Fixed by:
For renameat2/renameat, change to only ignore wraper call when both old
and new path are not in PSEUDO_INCLUDE_PATHS. In guts/renameat.c, when
oldpath is not in PSEUDO_INCLUDE_PATHS and has no existing db entry,
OP_LINK on oldpath is silently dropped by pseudo_client_op, making the
subsequent OP_RENAME a no-op in files.db, so change renameat to create
the entry directly at newpath via OP_LINK when oldpath is ignored,
skipping the pointless LINK+RENAME sequence for oldpath

Helped-by: Paul Barker <paul@pbarker.dev>
Signed-off-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 makewrappers               |  4 +++-
 ports/unix/guts/renameat.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/makewrappers b/makewrappers
index df405fc..83f5ca6 100755
--- a/makewrappers
+++ b/makewrappers
@@ -430,7 +430,9 @@ class Function:
             return "0"
 
         mainpath = None
-        if "oldpath" in self.paths_to_munge:
+        if "oldpath" in self.paths_to_munge and "newpath" in self.paths_to_munge:
+            return "(pseudo_client_ignore_path(oldpath) && pseudo_client_ignore_path(newpath))"
+        elif "oldpath" in self.paths_to_munge:
             mainpath = "oldpath"
         elif "newpath" in self.paths_to_munge:
             mainpath = "newpath"
diff --git a/ports/unix/guts/renameat.c b/ports/unix/guts/renameat.c
index 5ac63f9..69130c6 100644
--- a/ports/unix/guts/renameat.c
+++ b/ports/unix/guts/renameat.c
@@ -113,14 +113,32 @@
 				oldbuf.st_ino = newbuf.st_ino;
 			}
 		}
-		pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] to rename\n",
-			oldpath, (unsigned long long) oldbuf.st_ino);
-		pseudo_client_op(OP_LINK, 0, -1, olddirfd, oldpath, &oldbuf);
+		if (pseudo_client_ignore_path(oldpath)) {
+			/* oldpath is ignored (not in INCLUDE_PATHS), so
+			 * OP_LINK on it would be silently dropped and the
+			 * subsequent OP_RENAME would be a no-op. Instead,
+			 * create the entry directly at newpath.
+			 * OP_LINK does not override uid/gid with pseudo_fuid/
+			 * pseudo_fgid (unlike OP_CREAT), so set them explicitly
+			 * to avoid recording the host user's real ids.
+			 */
+			oldbuf.st_uid = pseudo_fuid;
+			oldbuf.st_gid = pseudo_fgid;
+			pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] directly at newpath (oldpath ignored)\n",
+				newpath, (unsigned long long) oldbuf.st_ino);
+			pseudo_client_op(OP_LINK, 0, -1, newdirfd, newpath, &oldbuf);
+		} else {
+			pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] to rename\n",
+				oldpath, (unsigned long long) oldbuf.st_ino);
+			pseudo_client_op(OP_LINK, 0, -1, olddirfd, oldpath, &oldbuf);
+			pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
+		}
+	} else {
+		/* special case: use 'fd' for olddirfd, because
+		 * we know it has no other meaning for RENAME
+		 */
+		pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
 	}
-	/* special case: use 'fd' for olddirfd, because
-	 * we know it has no other meaning for RENAME
-	 */
-	pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
 
 	errno = save_errno;
 /*	return rc;
-- 
1.8.3.1


