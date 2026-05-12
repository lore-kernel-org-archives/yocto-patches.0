Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61DFCD4F39
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.621.1778624449003957825
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiEw1619785;
	Tue, 12 May 2026 17:20:45 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 1/5] run_tests.sh: Allow the user to specify specific tests to run
Date: Tue, 12 May 2026 17:20:39 -0500
Message-Id: <1778624443-20857-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3979

From: Mark Hatle <mark.hatle@amd.com>

AI-Generated: Implemented with the assistance of github CoPilot (Claude Opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 run_tests.sh | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index 1b6cfb9..306a561 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -4,11 +4,15 @@
 #
 
 opt_verbose=
+test_args=()
 
 usage()
 {
     echo >&2 "usage:"
-    echo >&2 "  run_tests [-v|--verbose]"
+    echo >&2 "  run_tests [-v|--verbose] [test ...]"
+    echo >&2 ""
+    echo >&2 "If no tests are specified, all tests are run."
+    echo >&2 "Tests can be specified as filenames (test-fstat.sh) or basenames (test-fstat)."
     exit 1
 }
 
@@ -19,9 +23,15 @@ do
         -v | --verbose)
                 opt_verbose=-v
                 ;;
-        *)
+        -h | --help)
+                usage
+                ;;
+        -*)
                 usage
                 ;;
+        *)
+                test_args+=("$arg")
+                ;;
         esac
 done
 
@@ -36,7 +46,23 @@ num_failed_tests=0
 
 tmplog="$(mktemp pseudo.log.XXXXXXXX)"
 
-for file in test/test*.sh
+if [ ${#test_args[@]} -gt 0 ]; then
+    test_files=()
+    for t in "${test_args[@]}"; do
+        # Strip directory prefix and ensure .sh suffix
+        t="${t##*/}"
+        t="${t%.sh}.sh"
+        if [ -f "test/$t" ]; then
+            test_files+=("test/$t")
+        else
+            echo >&2 "Warning: test/$t not found, skipping."
+        fi
+    done
+else
+    test_files=(test/test*.sh)
+fi
+
+for file in "${test_files[@]}"
 do
     filename=${file#test/}
     let num_tests++
-- 
1.8.3.1


