Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B66E6B25D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 22:54:19 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90710.1766444056223182145
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 14:54:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 5BMMsEAP687292;
	Mon, 22 Dec 2025 16:54:14 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: ghaderer@wyplay.com
Subject: [pseudo][PATCH] pseudo_util.c: Skip realpath like expansion for /proc
Date: Mon, 22 Dec 2025 16:54:13 -0600
Message-Id: <1766444053-25346-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 22:54:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2860

From: Mark Hatle <mark.hatle@amd.com>

See: Yocto Project bugzilla 16028

Gauthier HADERER (see comment 23) reported an issue where realpath like
behavior of pseudo_fix_path function resulted in a failure of the rust
based tail command.

It was determined that the behavior could be emulated by doing:

echo "test" | tail /dev/fd/0

(tail, cat or any other similar command would result in the same failure)

This results in:
  /dev/fd/0 -> /proc/self/fd/0
  /proc/self/fd/0 -> /proc/1475524/fd/0
  /proc/1475524/fd/0 -> /proc/1475524/fd/pipe:[1177004485]

with an eventual failure of unable to open /proc/1475524/fd/pipe:[1177004485]

This change resolves the issue by detecting the path has been resolved into
the /proc filesystem and then forcing the system to stop resolving
additional path elements.  This ensures that special /proc behavior can be
maintained.

It is still unclear to me why the original code path fails, but in proc
there is clearly a symlink for the pipe, but the pipe itself is not present
which is triggering the failure condition.  Accessing the pipe via
/proc/self/fd/0 appears to work reliably and consistently while not
introducing issues with the special path resolution required for chroot
emulation.

Reported-by: Gauthier HADERER <ghaderer@wyplay.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c          | 15 +++++++++++++++
 test/test-proc-pipe.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100755 test/test-proc-pipe.sh

diff --git a/pseudo_util.c b/pseudo_util.c
index a94a4da..5f4b356 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -620,6 +620,21 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 		pseudo_diag("pseudo_append_element: invalid args.\n");
 		return -1;
 	}
+
+	/* If we end up resolving a path into /proc, it has special meaning.
+	 * For instance, /dev/fd/0 -> /proc/self/fd/0 ->
+	 *    /proc/1475524/fd/0 -> /proc/1475524/fd/pipe:[1177004485]
+	 * Trying to access the resolved name "pipe:[....]" may fail.
+	 * Instead, once we enter /proc, we stop expanding symlinks.
+	 *
+	 * This now results in /dev/fd/0 -> /proc/self/fd/0
+	 */
+	if (strncmp(newpath, "/proc", 5) == 0) {
+		pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "paes: %s in /proc\n",
+			newpath ? newpath : "<nil>");
+                leave_this = 1;
+	}
+
 	current = *pcurrent;
 	pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "pae: '%s', + '%.*s', is_dir %d\n",
 		newpath, (int) elen, element, is_dir);
diff --git a/test/test-proc-pipe.sh b/test/test-proc-pipe.sh
new file mode 100755
index 0000000..30b6880
--- /dev/null
+++ b/test/test-proc-pipe.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# See Yocto Project bugzilla 16028
+#
+# It was determined that a utility that use /dev/fd may fail when run under
+# pseudo, while working properly outside.
+#
+# For example: echo "test" | cat /dev/fd/0
+
+# Tests
+result=$(echo "test" | cat 2>&1)
+rc=$?
+if [ $rc -ne 0 -o "$result" != "test" ]; then
+    echo Failed simple echo pipe test - $rc:
+    echo $result
+    exit 1
+fi
+
+result=$(echo "test" | cat /dev/fd/0 2>&1)
+rc=$?
+if [ $rc -ne 0 -o "$result" != "test" ]; then
+    echo Failed /dev/fd/0 echo pipe test - $rc:
+    echo $result
+    exit 1
+fi
-- 
1.8.3.1


