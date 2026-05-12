Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC9ACD4F3D
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:52 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.612.1778624448195174400
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiF11619785;
	Tue, 12 May 2026 17:20:46 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 4/5] rename: only ignore when both old and new path are not in PSEUDO_INCLUDE_PATHS
Date: Tue, 12 May 2026 17:20:42 -0500
Message-Id: <1778624443-20857-5-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3976

From: Mark Hatle <mark.hatle@amd.com>

While testing the fix for renameat, it was noted that rename had a similar
logic pattern.  Fix rename as well, this is based on the fix:

Author: Changqing Li <changqing.li@windriver.com>
Date:   Tue May 12 16:33:57 2026 +0800

    renameat2/renameat: only ignore when both old and new path are not in PSEUDO_INCLUDE_PATHS

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
 ports/unix/guts/rename.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ports/unix/guts/rename.c b/ports/unix/guts/rename.c
index 80bbf41..f065c6e 100644
--- a/ports/unix/guts/rename.c
+++ b/ports/unix/guts/rename.c
@@ -101,11 +101,29 @@
 				oldbuf.st_ino = newbuf.st_ino;
 			}
 		}
-		pseudo_debug(PDBGF_FILE, "creating new '%s' [%llu] to rename\n",
-			oldpath, (unsigned long long) oldbuf.st_ino);
-		pseudo_client_op(OP_LINK, 0, -1, -1, oldpath, &oldbuf);
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
+			pseudo_client_op(OP_LINK, 0, -1, -1, newpath, &oldbuf);
+		} else {
+			pseudo_debug(PDBGF_FILE, "creating new '%s' [%llu] to rename\n",
+				oldpath, (unsigned long long) oldbuf.st_ino);
+			pseudo_client_op(OP_LINK, 0, -1, -1, oldpath, &oldbuf);
+			pseudo_client_op(OP_RENAME, 0, -1, -1, newpath, &oldbuf, oldpath);
+		}
+	} else {
+		pseudo_client_op(OP_RENAME, 0, -1, -1, newpath, &oldbuf, oldpath);
 	}
-	pseudo_client_op(OP_RENAME, 0, -1, -1, newpath, &oldbuf, oldpath);
 
 	errno = save_errno;
 /*	return rc;
-- 
1.8.3.1


