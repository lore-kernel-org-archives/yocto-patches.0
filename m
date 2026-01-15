Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735FED47CB5
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.839.1768520621951643287
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjZ2408772;
	Thu, 15 Jan 2026 17:43:39 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 04/20] test-realpath: Verify the realpath behavior matches glibc
Date: Thu, 15 Jan 2026 17:43:20 -0600
Message-Id: <1768520616-7289-5-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2980

Gauthier HADERER reported that the realpath implementation could return
the wrong value.

Create a test-case to attempt to verify realpath behavior.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-realpath.c  | 17 ++++++++++++
 test/test-realpath.sh | 63 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 test/test-realpath.c
 create mode 100755 test/test-realpath.sh

diff --git a/test/test-realpath.c b/test/test-realpath.c
new file mode 100644
index 0000000..0af92cf
--- /dev/null
+++ b/test/test-realpath.c
@@ -0,0 +1,17 @@
+/* Code contributed by Gauthier HADERER via lists.yoctoproject.org */
+
+#include <limits.h>
+#include <stdlib.h>
+#include <stdio.h>
+int main(int argc, char **argv) {
+    if (argc != 2)
+        return 2;
+    char *rpath = realpath(argv[1], NULL);
+    if (!rpath) {
+        perror("realpath");
+        return 1;
+    }
+    printf("%s\n", rpath);
+    free(rpath);
+    return 0;
+}
diff --git a/test/test-realpath.sh b/test/test-realpath.sh
new file mode 100755
index 0000000..5b42b57
--- /dev/null
+++ b/test/test-realpath.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# See Yocto Project bugzilla 16028
+#
+# Gauthier HADERER reported differences in realpath behavior
+#
+
+go_exit() {
+  if [ -n "${link}" ]; then
+    rm ${link}
+  fi
+
+  if [ -n "${file}" ]; then
+    rm ${file}
+  fi
+
+  exit $rc
+}
+
+mypath=$(dirname $0)
+
+# Verify that a missing file fails
+${mypath}/test-realpath doesnt-exist
+rc=$?
+
+if [ $rc -eq 0 ]; then
+   echo "Non-zero return code expected!"
+   rc=1
+   go_exit
+fi
+
+# Verify that a regular file passes
+file=$(mktemp test-realpath.XXXXXX)
+
+filepath=$(${mypath}/test-realpath ${file})
+rc=$?
+
+if [ $rc -ne 0 ]; then
+   echo "Zero return code expected!  Unable to find ${file}."
+   go_exit
+fi
+
+link=$(mktemp test-realpath.XXXXXX)
+rm ${link}
+ln -s ${file} ${link}
+linkpath=`${mypath}/test-realpath ${link}`
+rc=$?
+rm ${link}
+
+rm ${file}
+
+if [ $rc -ne 0 ]; then
+    echo "Zero return code expected!  Unable to find ${link}."
+    go_exit
+fi
+
+if [ "${linkpath}" != "${filepath}" ]; then
+    echo "Link didn't return to expected target!"
+    rc=1
+    go_exit
+fi
-- 
2.43.0


