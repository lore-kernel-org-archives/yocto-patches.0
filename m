Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8830ED47CBB
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.754.1768520620774151045
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjX2408772;
	Thu, 15 Jan 2026 17:43:39 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 02/20] test: Cleanup test output
Date: Thu, 15 Jan 2026 17:43:18 -0600
Message-Id: <1768520616-7289-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2976

Change 'make test' to be simple test results.
Add new 'make test-verbose' for verbose results.

Adjust the run_test.sh to capture logs and only output when in verbose
mode.  Also capture failure and skip counts.  (rc of 255 indicates test
was skipped.)

Adjust test cases to indicate skipped tests when a command is unavailable.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 Makefile.in        |  3 +++
 run_tests.sh       | 24 +++++++++++++++++++-----
 test/test-acl.sh   | 16 ++++++++++++++++
 test/test-xattr.sh | 17 +++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 6447be4..3b60cf8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -76,6 +76,9 @@ TABLES=table_templates/pseudo_tables.c table_templates/pseudo_tables.h
 all: $(LIBPSEUDO) $(PSEUDO) $(PSEUDODB) $(PSEUDOLOG) $(PSEUDO_PROFILE)
 
 test: all $(TESTS) | $(BIN) $(LIB)
+	./run_tests.sh
+
+test-verbose: all $(TESTS) | $(BIN) $(LIB)
 	./run_tests.sh -v
 
 test/test-%: test/test-%.c
diff --git a/run_tests.sh b/run_tests.sh
index c637c27..3d0920f 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -31,22 +31,36 @@ export PSEUDO_PREFIX=${PWD}
 
 num_tests=0
 num_passed_tests=0
+num_skipped_tests=0
+num_failed_tests=0
+
+tmplog="$(mktemp pseudo.log.XXXXXXXX)"
 
 for file in test/test*.sh
 do
     filename=${file#test/}
     let num_tests++
     mkdir -p var/pseudo
-    ./bin/pseudo $file ${opt_verbose}
-    if [ "$?" -eq "0" ]; then
+    ./bin/pseudo $file ${opt_verbose} >${tmplog} 2>&1
+    rc=$?
+    if [ "${opt_verbose}" = "-v" ]; then
+        echo
+        cat ${tmplog}
+    fi
+    if [ "$rc" -eq "0" ]; then
         let num_passed_tests++
-        if [ "${opt_verbose}" == "-v" ]; then
-            echo "${filename%.sh}: Passed."
-        fi
+        echo "${filename%.sh}: Passed."
+    elif [ "$rc" -eq "255" ]; then
+        let num_skipped_tests++
+        echo "${filename%.sh}: Skipped."
     else
+        let num_failed_tests++
         echo "${filename/%.sh}: Failed."
     fi
     rm -rf var/pseudo/*
 done
+echo "${num_failed_tests}/${num_tests} test(s) failed."
+echo "${num_skipped_tests}/${num_tests} test(s) skipped."
 echo "${num_passed_tests}/${num_tests} test(s) passed."
 
+rm ${tmplog}
diff --git a/test/test-acl.sh b/test/test-acl.sh
index fb7d5ec..fa2ed45 100755
--- a/test/test-acl.sh
+++ b/test/test-acl.sh
@@ -6,11 +6,27 @@
 # Return vals: 2 - Unable to run ACL commands, assertion failure
 #              1 - Invalid return value
 #              0 - Pass
+#              255 - acl programs unavailable, skip
 
 # NOTE: these test exclusively test setfacl -m
 
 set -u
 
+rc=0
+which getfacl 2>/dev/null
+if [ $? -ne 0 ]; then
+    echo "getfacl command missing"
+    rc=255
+fi
+which setfacl 2>/dev/null
+if [ $? -ne 0 ]; then
+    echo "setfacl command missing"
+    rc=255
+fi
+if [ $rc -ne 0 ]; then
+    exit $rc
+fi
+
 check_owner () {
     local file="$1"
     local expected="$2"
diff --git a/test/test-xattr.sh b/test/test-xattr.sh
index 09cd6b0..6ac6b3c 100755
--- a/test/test-xattr.sh
+++ b/test/test-xattr.sh
@@ -7,6 +7,23 @@
 #              1 - Invalid return value
 #              0 - Pass
 
+set -u
+
+rc=0
+which getfattr 2>/dev/null
+if [ $? -ne 0 ]; then
+    echo "getfattr command missing"
+    rc=255
+fi
+which setfattr 2>/dev/null
+if [ $? -ne 0 ]; then
+    echo "setfattr command missing"
+    rc=255
+fi
+if [ $rc -ne 0 ]; then
+    exit $rc
+fi
+
 touch f1
 attrs=`getfattr -d f1 | grep -v '^#'`
 if [ -n "$attrs" ]
-- 
2.43.0


