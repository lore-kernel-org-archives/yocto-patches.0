Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD20FF8869
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2120.1777312614822013327
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAn876837;
	Mon, 27 Apr 2026 12:56:45 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 10/11] pseudo_util.c: Fix symlink processing for symlinkat and related
Date: Mon, 27 Apr 2026 12:56:40 -0500
Message-Id: <1777312601-1393-11-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3857

From: Mark Hatle <mark.hatle@amd.com>

If the symlink is absolute (starts with a '/') we need to ensure that
it is still presented as if it was inside of the chroot.  This was
discovered by the openat2 chroot test case, but only when looking at
a symlink and helped indicate that symlinkat (and similar) users
were affected.

AI-Generated: Fixed by github copilot (claude opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/pseudo_util.c b/pseudo_util.c
index 3a06027..2b0cc04 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -729,7 +729,21 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 			linkbuf[linklen] = '\0';
 			/* absolute symlink means go back to root */
 			if (*linkbuf == '/') {
+				size_t rootlen = root - newpath;
 				current = root;
+				/* If we're in a chroot (rootlen > 0) and the
+				 * symlink target starts with the chroot prefix,
+				 * strip it.  This happens when symlinkat expanded
+				 * an absolute target to include the chroot path
+				 * on disk; without stripping, we'd double-apply
+				 * the chroot prefix during resolution.
+				 */
+				if (rootlen > 0 && (size_t)linklen > rootlen &&
+				    !memcmp(linkbuf, newpath, rootlen) &&
+				    (linkbuf[rootlen] == '/' || linkbuf[rootlen] == '\0')) {
+					memmove(linkbuf, linkbuf + rootlen, linklen - rootlen + 1);
+					linklen -= rootlen;
+				}
 			} else {
 #ifdef PSEUDO_PORT_LINUX
 				if (is_proc) {
-- 
1.8.3.1


