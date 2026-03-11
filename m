Return-Path: <dburgener@linux.microsoft.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF21125863
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 17:59:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2572.1773251952840540240
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 10:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@linux.microsoft.com header.s=default header.b=oMIl/nxS;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: dburgener@linux.microsoft.com)
Received: from DESKTOP-NVB873J.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A21120B710C
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 10:59:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A21120B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773251952;
	bh=rP3LlOZh8yTNm4ZOBSvmqED9NBSS5TBFc6/lZFvvIn4=;
	h=From:To:Subject:Date:From;
	b=oMIl/nxSXtGaQ4mDgBzxmHnZZYbO4JrcsXOCU00jUSUohkLE64JDDL1WDVFU/U3dw
	 6g7OOsEtZmLcTxM8zLHDMWIDTxtDP1ZJ10/oG7MTbWmAU653y2p8uzdVnoK6Kq7xju
	 BIiClM5akOHE3++DqcXyMfIQlWn6QftOhl9XCYko=
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo] [PATCH] Only copy xattrs on a rename if it's cross-filesystem
Date: Wed, 11 Mar 2026 13:59:06 -0400
Message-Id: <20260311175906.193167-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 17:59:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3434

On same file-system renames, the path update in the db means that the
xattrs are already present, and copying results in duplicates.  This was
previously masked by the bug fixed in d1db9c219abf92f15303486a409292237f1=
fc790, since that prevented the
xattr copying.  Now that that bug is fixed, we started observing this
issue in 1.9.3.

AI-Generated: Code fix by Claude Haiku 4.5.  Test code by me.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 pseudo_db.c        |  4 +++-
 test/test-xattr.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/pseudo_db.c b/pseudo_db.c
index 9713e0c..6a33f20 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
 	found_existing =3D !pdb_find_file_path(oldmsg);
 	if (found_existing) {
 		/* we have an existing file entry */
-		pdb_copy_xattrs(oldmsg, msg);
+		if (oldmsg->dev !=3D msg->dev || oldmsg->ino !=3D msg->ino) {
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
=20
+mv f1 f2
+attrs=3D`getfattr -d -m - f2 | grep -v '^#'`
+expected=3D$'security.dummy=3D"test_f2"\nuser.dummy=3D"test_f1"'
+if [ "$attrs" !=3D "$expected" ]
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
--=20
2.34.1


