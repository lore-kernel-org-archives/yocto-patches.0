Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F88CFF886C
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2121.1777312614338263232
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAl876837;
	Mon, 27 Apr 2026 12:56:45 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 08/11] ports/unix: realpath: Fix chroot processing
Date: Mon, 27 Apr 2026 12:56:38 -0500
Message-Id: <1777312601-1393-9-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3855

From: Mark Hatle <mark.hatle@amd.com>

When running realpath from within a chroot, the returned path must be
sanitized to appear as if it's within the chroot.  Use the existing
pseudo_chroot settings to identify and clear the path.

AI-Generated: Fix suggested by github copilot (claude opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/realpath.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ports/unix/guts/realpath.c b/ports/unix/guts/realpath.c
index 62a92b2..4f91220 100644
--- a/ports/unix/guts/realpath.c
+++ b/ports/unix/guts/realpath.c
@@ -30,6 +30,21 @@
 		*(ep--) = '\0';
 	}
 
+	/* If in a chroot, strip the chroot prefix so the caller sees
+	 * a path relative to the chroot root.
+	 */
+	if (pseudo_chroot_len &&
+	    (size_t)len >= pseudo_chroot_len &&
+	    !memcmp(rname, pseudo_chroot, pseudo_chroot_len) &&
+	    (rname[pseudo_chroot_len] == '/' || rname[pseudo_chroot_len] == '\0')) {
+		rname += pseudo_chroot_len;
+		len -= pseudo_chroot_len;
+		if (len == 0) {
+			rname = "/";
+			len = 1;
+		}
+	}
+
 	if (len >= pseudo_sys_path_max()) {
 		errno = ENAMETOOLONG;
 		return NULL;
-- 
1.8.3.1


