Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A0CF396B
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9153.1763564756992869693
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=f1XFLYmX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202511191505557083f92abe0002070f-laf_xz@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511191505557083f92abe0002070f
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1ifABYr0rHTn3JR/M0z0AZBWT9i931vdlDe1snEksgQ=;
 b=f1XFLYmXCiGEeE9GqB3tizpt+g08ww2i/m/m3t8vzioGJJq7AmZkbYJ33jD88pIji5cj15
 Iddc+nVHNRw23h/GoXHuV7+dmi4CTuRVfuETiqIwhSJVXCFi2AS79K0/iNpsWyOzsXB8Do8r
 s6Yb3GqnZM+BtZcT+DEwKrbfL4aS6yNdI49f2CzEcGMZLNwGgL1av37/KEX8272UyukqHl0m
 oXc5GsYCuk9/OS9LSY5tcG17oP2lBRmDOPx7t7VXMoOU4WlIz5WHp8pKTIHZ6kIsyRw0o2+K
 MTBNwGs3SrFKB44/TOo1vPvOpCyn8QpASEuwgx61eSiBafer6NnXpBMA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 35/35] readme: add QA chapter
Date: Wed, 19 Nov 2025 16:05:22 +0100
Message-Id: <20251119150522.15477-36-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2618

From: Peter Marko <peter.marko@siemens.com>

Describe QA done when accepting patches.

Note that oe-selftest fail when additional parameters (like -j) is not
present. When that is fixed, we can simplify the oe-selftest QA example.

Expected results:
* runtime
RESULTS - go.GoCompileTest.test_go_compile: PASSED (67.87s)
RESULTS - go.GoCompileTest.test_go_module: PASSED (6.17s)
RESULTS - go.GoHelloworldTest.test_gohelloworld: PASSED (1.24s)
RESULTS - ping.PingTest.test_ping: PASSED (0.02s)
RESULTS - ssh.SSHTest.test_ssh: PASSED (0.67s)
* sdk
RESULTS - go.GoCompileTest.test_go_build: PASSED (0.35s)
RESULTS - go.GoCompileTest.test_go_module: PASSED (0.33s)
RESULTS - go.GoHostCompileTest.test_go_cross_compile: PASSED (0.22s)
RESULTS - go.GoHostCompileTest.test_go_module_cross_compile: PASSED (0.37s)
* oe-selftest
oe-selftest - INFO - RESULTS - gotoolchain.oeGoToolchainSelfTest.test_go_dep_build: PASSED (16.55s)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README.md | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/README.md b/README.md
index 47cc7b4..080cbfe 100644
--- a/README.md
+++ b/README.md
@@ -41,3 +41,47 @@ Maintenance
 Layer maintainers:
 * Jose Quaresma <jose.quaresma@foundries.io>
 * Peter Marko <peter.marko@siemens.com>
+
+Quality Assurance
+-----------------
+
+QA tests are using original openembedded-core testsuites.
+Current plan is to backport QA test changes to openembedded-core scarthgap branch.
+When that is no longer possible, changes will picked here.
+
+Automated tests to verify go toolchain functionality are being executed with following configurations and commands:
+
+* OEQA runtime
+
+    ```
+    IMAGE_INSTALL:append = " packagegroup-core-ssh-dropbear go-helloworld packagegroup-go-sdk-target"
+    IMAGE_CLASSES += "testimage"
+    TEST_SUITES = "ping ssh go"
+    QB_MEM = "-m 2048"
+    ```
+
+    ```
+    bitbake core-image-minimal && bitbake core-image-minimal:do_testimage
+    ```
+
+* OEQA SDK
+
+    ```
+    IMAGE_CLASSES += "testimage"
+    SDK_TOOLCHAIN_LANGS = "go"
+    TESTSDK_SUITES = "go"
+    ```
+
+    ```
+    bitbake core-image-minimal:do_populate_sdk && bitbake core-image-minimal:do_testsdk
+    ```
+
+* OEQA selftest
+
+    ```
+    SANITY_TESTED_DISTROS = ""
+    ```
+
+    ```
+    oe-selftest -r gotoolchain -j $(grep -c ^processor /proc/cpuinfo)
+    ```

