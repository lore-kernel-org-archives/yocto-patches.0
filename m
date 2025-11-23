Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA495CFD342
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5050.1763941544916846400
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qu78bbCc;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2d7c38352so506495585a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941544; x=1764546344; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHaSva1QYCV6XV9jozSRT/Bhm1xiecw0M1WgnZwUJL0=;
        b=qu78bbCcdcVnzZMi57P9mjHOBT6t2sdr8vb/KLkeHDZ4n6d2m2xlDdITNoHxbEjUMa
         XTmUuwBPFl3lrGU2o4TLvWu7kFosHES6XioBkS2Am6l+ay5olsf++wvM3rIZXOI+c6HH
         NZksDXDrQIf9yq66rSUexv/XM/Xv5ba/SLtp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941544; x=1764546344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHaSva1QYCV6XV9jozSRT/Bhm1xiecw0M1WgnZwUJL0=;
        b=CYaW9Hbi9oFFQ4OiJH3AeXSQRnlGP+dkVY5uZMv+anJ3mrBDvfA6z5Vb/k2zkxFVnn
         ChKOKZzjAPUCXKbD98BK6QmfF1EczQlaPl/h4mDxHgVR80hV4FeharKRg76SDT3xZ+3c
         V10SmZdTbPmRwDvDpSNqVonMIpQdF2kq044tWZi9qMrQwUf3mhB4GwSPRA1QpThO/3cD
         WxA5WFit/RH8BgLIIsCTz0UbfU1N7hDt4xRB4p598X4Ot0zhAk/9Jul+llzuj8Eal5Yu
         vuIhrKVlyxW00+ZEQxWxcGtQi8x1LwMN8LmFpsBXedzmdLx7uoyu7WBZGY5XBXMYoCLs
         HtvQ==
X-Gm-Message-State: AOJu0YxSLglif8xjKK5OeGfunTiTbBQ1TQUh2M22V9dKHrpI3ShZPaKI
	x8jJ/5HJhKxSmVWtcgp4nMQdcBjAEw4HpZrYIDVUSTvMEciZzdZchmkb++rAJ4kaH7f9dhq057J
	WFBxw
X-Gm-Gg: ASbGncskzJ568jSENLDyqmrw//dB/aSI1tsWcON+k/kQ4GvwA0JR6BS1ntSph81UUQ4
	urNeWnG4yfuFdVwMn0251BfkTrBWNHZFMqygVJiBFoGx2gM3d+CewjZg/AiGzlo1dfm9WV6a5c5
	fxTF7wcalnmpCURKBOlVUYXDtI1GQROgTZJ1kGYChToi0wMVDYOkHt/s+mttNssLM5PvaYogKa3
	ovDO4UQTO+ojusgOTBQ7BAfJzbMw7eNxITGnl1iHsgHvcPnqLSQlIUopaPu2MUcVvaf1BqeEioT
	oTJogHP+PDWiC438kioUGe/w8bjRvY9eXjlgmqIZaEinUxIICex/IZbfwJA8xqkgT+Pi8UAVbeH
	9a2x1Fx2pWpOoJkbSwKdqsk9gPtnbdJZxzQic9Q/c5mLOpe5Q+9FFmPTJnijtO6kPrdTjFYxR9g
	hWu5orkfH7itvHLSLNlgGDytH9/QVV2gH4+GCtvSsa3KxCfcQ9UVUTaqKxoIDEBw8=
X-Google-Smtp-Source: AGHT+IEpl2lx7dvpjQt5ehnmFCO4UBAvLCTHln9jdu2w6BH6GlaqeZM2I5pgB+g9TRF+voQ3cjiavA==
X-Received: by 2002:a05:620a:109c:b0:8a3:90cb:9224 with SMTP id af79cd13be357-8b32ab88d50mr1633451185a.2.1763941543383;
        Sun, 23 Nov 2025 15:45:43 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:42 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 25/32] fail2ban: Adapt test output to Automake format for ptest compatibility
Date: Sun, 23 Nov 2025 18:45:05 -0500
Message-ID: <2fb507fc9a060cc8a7405b8aae23af46bfb4ecf2.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2683

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
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
index eb20a88..72a932b 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -15,6 +15,7 @@ SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
            file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
            file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
+           file://0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch \
            file://initd \
            file://run-ptest \
            "
@@ -71,6 +72,12 @@ INSANE_SKIP:${PN}:append = "already-stripped"
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
2.47.3


