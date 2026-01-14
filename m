Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4901D38FF3
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 17:21:46 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15680.1768411301720519619
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Jan 2026 09:21:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60EHLbL22283891;
	Wed, 14 Jan 2026 11:21:37 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH] makewrappers: Fix EFAULT implementation
Date: Wed, 14 Jan 2026 11:21:36 -0600
Message-Id: <1768411296-19597-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Jan 2026 17:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2955

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

A bug was discovered in the makewrappers change in commit
9ce8c09980af23ebd4ebf072010469882d0459a6.

If EFAULT was returned, it would exist with signals blocked and the
function lock still held.  This would eventually deaadlock in certain
use-cases.

The change introduces a quick path exit to the makewrappers and
does a 'goto' to this quick exit in the case of the EFAULT.

A seperate issue was identified where the EFAULT code could try to
set a return code in a void function.  Fix this by using rc_decl.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 makewrappers          |  6 +++---
 templates/wrapfuncs.c |  2 ++
 test/test-statx.c     | 19 ++++++++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/makewrappers b/makewrappers
index 154b489..c9f6ad5 100755
--- a/makewrappers
+++ b/makewrappers
@@ -399,9 +399,9 @@ class Function:
                     # Emulate EFAULT when path is null
                     "if (%s == NULL) {\n"
                     "\t\t\terrno = EFAULT;\n"
-                    "\t\t\trc = -1;\n"
-                    "\t\t\t%s\n"
-                    "\t\t}\n" % (path, self.rc_return()))
+                    "\t\t\t%s -1;\n"
+                    "\t\t\tgoto quick_exit;\n"
+                    "\t\t}\n" % (path, self.rc_assign()))
             fix_paths.append(
                 "%s = pseudo_root_path(__func__, __LINE__, %s%s, %s, %s);" %
                 (path, prefix, self.dirfd, path, self.flags))
diff --git a/templates/wrapfuncs.c b/templates/wrapfuncs.c
index 93bb671..e925b6e 100644
--- a/templates/wrapfuncs.c
+++ b/templates/wrapfuncs.c
@@ -71,6 +71,8 @@ ${maybe_async_skip}
 		}
 	}
 	${variadic_end}
+quick_exit:
+	__attribute__((unused));
 	save_errno = errno;
 	pseudo_droplock();
 	sigprocmask(SIG_SETMASK, &saved, NULL);
diff --git a/test/test-statx.c b/test/test-statx.c
index 06d86af..3ea176b 100644
--- a/test/test-statx.c
+++ b/test/test-statx.c
@@ -8,13 +8,30 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <errno.h>
 
 // Passing a null pointer is the test scenario
 #pragma GCC diagnostic ignored "-Wnonnull"
 
-int main(void) {
+int statx_test() {
     if (statx(0, NULL, 0, 0, NULL) != -1) {
         return 1;
     }
+    if (errno != EFAULT) {
+        return 2;
+    }
+    return 0;
+}
+
+/* We run this multiple times to ensure that pseudo does not deadlock */
+int main(void) {
+    int rc = 0;
+
+    for (int i = 0 ; i < 5 ; i++) {
+        rc = statx_test();
+        if (rc != 0)
+            return rc;
+    }
+
     return 0;
 }
-- 
1.8.3.1


