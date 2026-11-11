Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.563.1794413716220502794
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 08:15:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ABGFDdn2529923
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 10:15:15 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][pseudo-1.9]PATCH 08/10] test-parallel-ops: Add a parallel create/rename/link/chmod test
Date: Wed, 11 Nov 2026 10:15:10 -0600
Message-Id: <1794413712-18072-9-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 16:15:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5306
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Four workers repeatedly create, rename onto, chmod, chown, symlink,
hard link and remove the same names in one directory.  The test fails
if any of the operations fail, or if the server logged an inode or path
mismatch while it ran.

Without the path lock in the create, metadata and open wrappers, the
server reports mismatches and occasionally aborts a client.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
(cherry picked from commit 7f582310cb7eb67da9b20ceb3082331518f6d4fb)
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-parallel-ops.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 test/test-parallel-ops.sh

diff --git a/test/test-parallel-ops.sh b/test/test-parallel-ops.sh
new file mode 100755
index 0000000..2fccd30
--- /dev/null
+++ b/test/test-parallel-ops.sh
@@ -0,0 +1,53 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Several clients create, rename, link, chmod and remove the same names in
+# one directory at once.  pseudo must not let one client's operation land in
+# the middle of another client's change to the same name, or the server
+# finds the database out of step with the filesystem.  It then logs an
+# "inode mismatch" or "path mismatch" error, and may abort a client.
+#
+# The temporary tree has to live below $PWD so that pseudo tracks it.
+
+tmpdir="$(mktemp -d -p "$PWD" parallel_ops_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+log="${PSEUDO_LOCALSTATEDIR:-$PWD/var/pseudo}/pseudo.log"
+mismatches() {
+    grep -c "mismatch" "$log" 2>/dev/null || true
+}
+before=$(mismatches)
+
+cd "$tmpdir" || exit 1
+: > target
+
+worker() {
+    for i in $(seq 50); do
+        echo "$1 $i" > "tmp.$1"            || echo "FAILED: create tmp.$1" >> failed
+        mv -f "tmp.$1" target              || echo "FAILED: mv tmp.$1 target" >> failed
+        chmod 640 target 2>/dev/null
+        chown 0:0 target 2>/dev/null
+        ln -sf target lnk                  || echo "FAILED: ln -sf target lnk" >> failed
+        mkdir dir 2>/dev/null; rmdir dir 2>/dev/null
+        mkfifo "f.$1" && mv -f "f.$1" fifo || echo "FAILED: mkfifo/mv f.$1" >> failed
+        ln -f target "hard.$1" 2>/dev/null && rm -f "hard.$1"
+    done
+}
+
+for w in 1 2 3 4; do
+    worker $w &
+done
+wait
+
+rc=0
+if [ -e failed ]; then
+    sort failed | uniq -c
+    rc=1
+fi
+after=$(mismatches)
+if [ "${after:-0}" -ne "${before:-0}" ]; then
+    echo "FAILED: $((after - before)) mismatch error(s) in $log"
+    rc=1
+fi
+exit $rc
-- 
1.8.3.1

