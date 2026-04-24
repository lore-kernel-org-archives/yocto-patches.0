Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFADCFF8850
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1798.1777071745919284876
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 16:02:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63ON2Dbv287175;
	Fri, 24 Apr 2026 18:02:15 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, dburgener@linux.microsoft.com,
        peter.kjellerstedt@axis.com
Subject: [yocto-patches][pseudo][PATCH 1/3] Only copy xattrs on a rename if it's cross-filesystem
Date: Fri, 24 Apr 2026 18:02:11 -0500
Message-Id: <1777071733-25858-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 23:02:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3814

From: Daniel Burgener <dburgener@linux.microsoft.com>

On same file-system renames, the path update in the db means that the
xattrs are already present, and copying results in duplicates.  This was
previously masked by the bug fixed in d1db9c219abf92f15303486a409292237f1fc790, since that prevented the
xattr copying.  Now that that bug is fixed, we started observing this
issue in 1.9.3.

AI-Generated: Code fix by Claude Haiku 4.5.  Test code by me.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_db.c        |  4 +++-
 test/test-xattr.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/pseudo_db.c b/pseudo_db.c
index 9713e0c..6a33f20 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
 	found_existing = !pdb_find_file_path(oldmsg);
 	if (found_existing) {
 		/* we have an existing file entry */
-		pdb_copy_xattrs(oldmsg, msg);
+		if (oldmsg->dev != msg->dev || oldmsg->ino != msg->ino) {
+			pdb_copy_xattrs(oldmsg, msg);
+		}
 	}
 	sqlite3_bind_int(update, 1, msg->dev);
 	sqlite3_bind_int64(update, 2, signed_ino(msg->ino));
diff --git a/test/test-xattr.sh b/test/test-xattr.sh
index 6ac6b3c..89fbd35 100755
--- a/test/test-xattr.sh
+++ b/test/test-xattr.sh
@@ -65,6 +65,18 @@ then
     exit 1
 fi
 
+mv f1 f2
+attrs=`getfattr -d -m - f2 | grep -v '^#'`
+expected=$'security.dummy="test_f2"\nuser.dummy="test_f1"'
+if [ "$attrs" != "$expected" ]
+then
+	#echo "Fail, unpexected getfattr result '$attrs'"
+	rm -f f1
+	rm -f f2
+	exit 1
+fi
+
 #echo "Passed."
 rm -f f1
+rm -f f2
 exit 0
-- 
1.8.3.1


