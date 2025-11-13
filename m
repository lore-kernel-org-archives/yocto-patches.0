Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B303CD98DA
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:13 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2259.1763064850529812806
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SjzyZ3bz;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed82ee9e57so15597221cf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064849; x=1763669649; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=179Gq3+ef5ooWW+F00Gyr1rhyPvSvmNysiBGWL+YN8g=;
        b=SjzyZ3bzTDRslTj4GxlT5b63I6YBndBqToANtbLSwUf0uwea4N5CytXhvE6ovHMsgc
         J5N9mPmP0ilYhuGl5RzLrjH37gflYABIvVH5g1oFHkTK14NV41cQt602Dn4tSscEfTOI
         R4r2/K6icj6sFo2hP+NWCjGwoQVeIprKIPBlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064849; x=1763669649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=179Gq3+ef5ooWW+F00Gyr1rhyPvSvmNysiBGWL+YN8g=;
        b=PGwmENnWnQ4M5G1BNPN9PDnbG4tFPwvsXMqUxzksDB2FE0Gi+uhQMgTm6s2SWEpcJ2
         9DT0b542bu5Lc4LcyzXU06z9ud6b4xpO3jVlrwibxLExMH/JYYrvbxjxmBcEv5nDFaIU
         vPdmfm1L3AG4dEFo+0zIypxJ6X8BGW1W0Ns6mXsMTa8CKSjk9OUqxXovvbU+wS814LDH
         CAHY0NXw98RjVK33Z0ff8GrojRJ05/tX9y4EXL6qcHg7nGb+lzrePjryI01FV0yVs14M
         1F4Y2OZfx+WcGKvYvpmJBFiR5yK6tEYsSVo/Ca028dMzLl9E+cQLYT2k6hXLE+MGGiQg
         NBuw==
X-Gm-Message-State: AOJu0YyyLFL57BqcRetxwEmg4NuYP4aGoFQd0xKUJ7FulMd3XJv4Bkyd
	Qy82C0kPiz0TzeHqA7W1lxUEwO42w5lyH3N9NbBaRk0tlULp9M63+5t78QL+iAMq197iynn/kJT
	Q4E1x
X-Gm-Gg: ASbGncvs2cAyJjQ5UH9LKgYTEAlJp8wdIK5GAu8CeYnw4zUMWrbXuSpZb/8SUDfJdq/
	++eIZ2DsqJmvknm2wSkUuqLYeH6hNbkqgEcYGA6QYtKsXes1bm2qlCcSPChVxzGydywxJOaurBq
	W+jUqP2+1WNVbnx51ekKZp+kZu++apLtV9Vm8HIt/YRwpvAW91Od9qurmWW7HDO63s889rNaTuM
	wuKDsZGTVplU6792zKOKxeNracwO/VjtJdl++zPVVvMIVg6qFuIRI9CrQFrP6wnWjOxAU8T8U8k
	pKwrs77Qd5bpp1XCQ6JN7CUe0PjbmD9VBV9G+1wth0GQntYDSyiQZ3rWJq/9lI4uYj021pX/cIn
	PcaqG37gjF7wvN50VyeKschekthMzU0YBwrnkOhAsCyM4CSl20liTemHe9RsdFQeKatEBx3PSGS
	goG4SgqpoXMKYFqzcz5VFy3VG8IteK/hzAdl+0lZQc0izyvsC0DA+xHZ9g56hPk3c=
X-Google-Smtp-Source: AGHT+IGzoKfNfAZ3jb6gOkYWM/EkpRZFQMkaTjuln1j0mZX31WMIWI+dD8mFkfcdlPlx9nY4GbNINQ==
X-Received: by 2002:ac8:5d8c:0:b0:4ed:b63d:1655 with SMTP id d75a77b69052e-4edf20f18ecmr16711781cf.51.1763064848971;
        Thu, 13 Nov 2025 12:14:08 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:07 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/6] fail2ban: Adapt test output to Automake format for ptest compatibility
Date: Thu, 13 Nov 2025 15:13:38 -0500
Message-ID: <98c7c1c9a5c54028705c7f34af8144498141d324.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763064477.git.scott.murray@konsulko.com>
References: <cover.1763064477.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2546

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert fail2ban-testcases output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@intel-x86-64:~# ptest-runner python3-fail2ban -t 300
START: ptest-runner
2025-09-22T07:57
BEGIN: /usr/lib64/python3-fail2ban/ptest
Fail2ban 1.1.1.dev1 test suite. Python 3.12.11 (main, Jun  3 2025, 15:41:47) [GCC 13.4.0]. Please wait...
I: Skipping smtp tests: No module named 'smtpd'
I: Skipping SSL smtp tests: No module named 'aiosmtpd'
PASS: fail2ban.tests.servertestcase.Transmitter.testAction
PASS: fail2ban.tests.servertestcase.Transmitter.testAddJail
PASS: fail2ban.tests.servertestcase.Transmitter.testDatabase
PASS: fail2ban.tests.servertestcase.Transmitter.testDatePattern
PASS: fail2ban.tests.servertestcase.Transmitter.testGetNOK
PASS: fail2ban.tests.servertestcase.Transmitter.testJailAttemptIP
PASS: fail2ban.tests.servertestcase.Transmitter.testJailBanIP
...
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testBanTimeIncr
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testFlushLogs
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogLevel
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTarget
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTargetSYSLOG
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocket
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocketNOK

============================================================================
Testsuite summary
DURATION: 48
END: /usr/lib64/python3-fail2ban/ptest
2025-09-22T07:58
STOP: ptest-runner
TOTAL: 1 FAIL: 0

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...ao.unittest.TestRunner-for-ptest-out.patch | 43 +++++++++++++++++++
 .../fail2ban/python3-fail2ban_git.bb          |  9 +++-
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
new file mode 100644
index 0000000..c6729cc
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
@@ -0,0 +1,43 @@
+From 7b42974b5bf20d9db8e788e9d6817004556d660d Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Fri, 19 Sep 2025 15:03:56 +0800
+Subject: [PATCH] fail2ban: use putao.unittest.TestRunner for ptest output
+
+Switch the test runner from unittest's default TextTestRunner to
+putao.unittest.TestRunner (provided by unittest-automake-output) so
+that results are reported in Automake-compatible PASS/FAIL format.
+This enables ptest-runner to correctly parse and summarize individual
+test results.
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ bin/fail2ban-testcases | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/bin/fail2ban-testcases b/bin/fail2ban-testcases
+index 48aae4b5ffdc..20db4a01a3d6 100755
+--- a/bin/fail2ban-testcases
++++ b/bin/fail2ban-testcases
+@@ -28,7 +28,7 @@ import logging
+ import os
+ import sys
+ import time
+-import unittest
++import putao.unittest
+ 
+ # Check if local fail2ban module exists, and use if it exists by
+ # modifying the path. This is done so that tests can be used in dev
+@@ -63,7 +63,7 @@ tests = gatherTests(regexps, opts)
+ #
+ # Run the tests
+ #
+-testRunner = unittest.TextTestRunner(verbosity=verbosity)
++testRunner = putao.unittest.TestRunner() 
+ 
+ tests_results = testRunner.run(tests)
+ 
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index c85953a..4238c9f 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,7 @@ DEPENDS = "python3-native"
 
 SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch \
            file://initd \
            file://run-ptest \
            "
@@ -67,6 +68,12 @@ INSANE_SKIP:${PN}:append = "already-stripped"
 RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables python3-core python3-pyinotify"
 RDEPENDS:${PN} += "python3-sqlite3"
 RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
-RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules python3-fail2ban"
+RDEPENDS:${PN}-ptest = " \
+    python3-core \
+    python3-io \
+    python3-modules \
+    python3-fail2ban \
+    python3-unittest-automake-output \
+    "
 
 RRECOMMENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'python3-systemd', '', d)}"
-- 
2.51.0


