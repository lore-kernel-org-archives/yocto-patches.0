Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2BD47CAE
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.841.1768520622234886550
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbje2408772;
	Thu, 15 Jan 2026 17:43:40 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 09/20] ports/unix/guts/realpath.c: realpath fails if the resolved path doesn't exist
Date: Thu, 15 Jan 2026 17:43:25 -0600
Message-Id: <1768520616-7289-10-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2984

From: Gauthier HADERER <ghaderer@wyplay.com>

The pseudo implementation of `realpath()' may return a path which doesn't
exist. This is not POSIX compliant and causes troubles with uutils (coreutils
in Rust).

For example, the tail commands tries to determine the file path of its standard
input file descriptor by calling `realpath("/dev/fd/0")'. When the input is a
pipe, the GNU C library returns NULL but pseudo returns
`/proc/<pid>/fd/pipe:[xxxxxx]'. As it got a path, the tail command tries to
open it and fails.

Contributed-by: Gauthier HADERER <ghaderer@wyplay.com> via
yocto-patches@lists.yoctoproject.org

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/realpath.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ports/unix/guts/realpath.c b/ports/unix/guts/realpath.c
index 8d8118b..c13eb93 100644
--- a/ports/unix/guts/realpath.c
+++ b/ports/unix/guts/realpath.c
@@ -14,6 +14,15 @@
 		errno = ENAMETOOLONG;
 		return NULL;
 	}
+
+	/* We must fail if the target path doesn't exist. */
+	PSEUDO_STATBUF buf;
+
+	if (base_lstat(rname, &buf) == -1) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 		len = strlen(rname);
 		char *ep = rname + len - 1;
 		while (ep > rname && *ep == '/') {
-- 
2.43.0


