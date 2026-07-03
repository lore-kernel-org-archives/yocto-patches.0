Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB26C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82813.1783039588987251402
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1M069650;
	Thu, 2 Jul 2026 19:46:25 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 23/23] test: various: Move to makefile compilation
Date: Thu,  2 Jul 2026 19:46:18 -0500
Message-Id: <1783039578-31531-24-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4384

From: Mark Hatle <mark.hatle@amd.com>

Removal local gcc call from test environment, the makefile is more suited
to building the tests.  This ensures they can be built properly in a cross
compile environment.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-chroot.c         | 10 ++++++++++
 test/test-chroot.sh        | 14 +-------------
 test/test-execl.c          |  4 ++++
 test/test-execl.sh         | 13 +------------
 test/test-linkat-chroot.sh |  4 +---
 test/test-reexec-chroot.c  | 10 ++++++++++
 test/test-reexec-chroot.sh | 14 +-------------
 7 files changed, 28 insertions(+), 41 deletions(-)
 create mode 100644 test/test-chroot.c
 create mode 100644 test/test-execl.c
 create mode 100644 test/test-reexec-chroot.c

diff --git a/test/test-chroot.c b/test/test-chroot.c
new file mode 100644
index 0000000..7b18946
--- /dev/null
+++ b/test/test-chroot.c
@@ -0,0 +1,10 @@
+/* Return vals: 2 - invalid arg list
+ *              1 - chroot failed
+ *              0 - chroot succeeded
+ */
+#include <unistd.h>
+int main(int argc, char *argv[]) {
+        if (argc != 2)
+          return 2;
+        return (chroot(argv[1]) == -1);
+}
diff --git a/test/test-chroot.sh b/test/test-chroot.sh
index faa4ffe..a7778ba 100755
--- a/test/test-chroot.sh
+++ b/test/test-chroot.sh
@@ -6,25 +6,13 @@
 # Return vals: 2 - invalid arg list
 #              1 - chroot failed
 #              0 - chroot succeeded
-cat > chroot_test.c << EOF
-#include <unistd.h>
-int main(int argc, char *argv[]) {
-        if (argc != 2)
-          return 2;
-        return (chroot(argv[1]) == -1);
-}
-EOF
 
-gcc -o chroot_test chroot_test.c
-
-./chroot_test `pwd`
+$(dirname "$0")/test-chroot `pwd`
 
 if [ "$?" = "0" ]
 then
     #echo "Passed."
-    rm -f chroot_test chroot_test.c
     exit 0
 fi
 #echo "Failed"
-rm -f chroot_test chroot_test.c
 exit 1
diff --git a/test/test-execl.c b/test/test-execl.c
new file mode 100644
index 0000000..31b803c
--- /dev/null
+++ b/test/test-execl.c
@@ -0,0 +1,4 @@
+#include <unistd.h>
+int main() {
+        return execl("/usr/bin/env", "/usr/bin/env", "A=A", "B=B", "C=C", NULL);
+}
diff --git a/test/test-execl.sh b/test/test-execl.sh
index 134055b..8715822 100755
--- a/test/test-execl.sh
+++ b/test/test-execl.sh
@@ -2,23 +2,12 @@
 #
 # SPDX-License-Identifier: LGPL-2.1-only
 #
-cat > execl_test.c << EOF
-#include <unistd.h>
-int main() {
-        return execl("/usr/bin/env", "/usr/bin/env", "A=A", "B=B", "C=C", NULL);
-}
-EOF
-
-gcc -o execl_test execl_test.c
-
-./execl_test | grep -q "C=C"
+$(dirname "$0")/test-execl | grep -q "C=C"
 
 if [ "$?" = "0" ]
 then
     #echo "Passed."
-    rm -f execl_test execl_test.c
     exit 0
 fi
 #echo "Failed"
-rm -f execl_test execl_test.c
 exit 1
diff --git a/test/test-linkat-chroot.sh b/test/test-linkat-chroot.sh
index 247a6d7..4f990c7 100755
--- a/test/test-linkat-chroot.sh
+++ b/test/test-linkat-chroot.sh
@@ -14,6 +14,4 @@ mkdir -p "$CHROOTDIR"
 touch "$CHROOTDIR/a"
 trap "rm -rf $(pwd)/linkat_chroot_test test-linkat-chroot" 0
 
-gcc -o test-linkat-chroot test/test-linkat-chroot.c
-
-./test-linkat-chroot "$CHROOTDIR"
+$(dirname "$0")/test-linkat-chroot "$CHROOTDIR"
diff --git a/test/test-reexec-chroot.c b/test/test-reexec-chroot.c
new file mode 100644
index 0000000..7b18946
--- /dev/null
+++ b/test/test-reexec-chroot.c
@@ -0,0 +1,10 @@
+/* Return vals: 2 - invalid arg list
+ *              1 - chroot failed
+ *              0 - chroot succeeded
+ */
+#include <unistd.h>
+int main(int argc, char *argv[]) {
+        if (argc != 2)
+          return 2;
+        return (chroot(argv[1]) == -1);
+}
diff --git a/test/test-reexec-chroot.sh b/test/test-reexec-chroot.sh
index f6412bc..0666caf 100755
--- a/test/test-reexec-chroot.sh
+++ b/test/test-reexec-chroot.sh
@@ -8,26 +8,14 @@
 # Return vals: 2 - invalid arg list
 #              1 - chroot failed
 #              0 - chroot succeeded
-cat > chroot_test.c << EOF
-#include <unistd.h>
-int main(int argc, char *argv[]) {
-        if (argc != 2)
-          return 2;
-        return (chroot(argv[1]) == -1);
-}
-EOF
-
-gcc -o chroot_test chroot_test.c
 
 # The following should just run chroot_test since pseudo is already loaded
-./bin/pseudo ./chroot_test `pwd`
+./bin/pseudo $(dirname "$0")/test-reexec-chroot `pwd`
 
 if [ "$?" = "0" ]
 then
     #echo "Passed."
-    rm -f chroot_test chroot_test.c
     exit 0
 fi
 #echo "Failed"
-rm -f chroot_test chroot_test.c
 exit 1
-- 
2.53.0


