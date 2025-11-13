Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39435CD6E5D
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23136.1763038637495754408
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=oFJCpdHE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251113125715b76ea9aaa00002077f-lx0yty@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251113125715b76ea9aaa00002077f
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tEio6jxmI7xzXSYaT8CAao+eJeFaXDQ/2D0Otw6k+fo=;
 b=oFJCpdHE0bE/YRmnwouIvwW1AdTHjxwedOFI/MrriEaikbtpUik1tbABiIyBE0dwlFMMQC
 aRubOwV3rT6pgZlJRRn3KRdatbrEVIZ3YfKAeWf6XOgG88uEr+quStlDzzZZQ6L8rB8S7PXh
 PHmkUtWuUZHx8M+Huj4oQ06AD65x4MwGio4oNVo79/uVXrhmPmRelLPKL0f0kPewE57Ptm72
 eUN8EzoMi2M4ZQPZ9dj13UpzWSvqxE7oFx7g1JU+bzP/NyeyhYr5ZNO88nsJgWHqYGNgRyJO
 YoxJH9qeVKdskRGYrMYaN0mtYSaoqnKbuKtIi8h04IacbyQWEuUY30aQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 34/34] readme: add QA chapter
Date: Thu, 13 Nov 2025 13:57:12 +0100
Message-Id: <20251113125712.18914-35-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2533

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
2025-11-13 11:55:23,485 - oe-selftest - INFO - gotoolchain.oeGoToolchainSelfTest.test_go_dep_build (subunit.RemotedTestCase)
2025-11-13 11:55:23,485 - oe-selftest - INFO -  ... ok
2025-11-13 11:55:23,485 - oe-selftest - INFO - 0: 1/1 1/1 (3.17s) (0 failed) (gotoolchain.oeGoToolchainSelfTest.test_go_dep_build)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README.md | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/README.md b/README.md
index e316fc6..06a948d 100644
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

