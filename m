Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB68C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:13:13 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5578.1789413183822141740
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=C9+AX0hS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202609141913000523f900870002075e-ulw8vj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202609141913000523f900870002075e
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=cyMHwxq7rLTS4XdLDtzyuy8tsqMWT7ceyeIVnEir2WU=;
 b=C9+AX0hSBy/DjdN/PsBO/ujgLZvsIfFeZrW2zfRb1l072A1JLvoed0wR1/z2o+PjGJtL8f
 qljYhooPR5Pdm2P2nZiOaiycwwWLd8oic9LetdLjmoX0ENohF3aU46XYBi3jHz6rFn+zXk2C
 I8hEY3fJ0uQNmoRzQvl8DvNo0l6EtoJagMp4rmWa75Cr51qJCZpGHKDlQVR29UNL5EdqSdaX
 krLRGTpxZtK0yT2ADfotxVSWctfRpjpvBRuGifI1uLAJjTUn0ypm34VOshpGfQdy6tRxWfLx
 lv+0uald74imt6hE5FzF4OYfPkO1mW3buJLHqtYJufqXea/OgRXarjNg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 01/11] Initial commit: add license, readme, gitignore and layer config
Date: Mon, 14 Sep 2026 21:12:30 +0200
Message-ID: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4828

From: Peter Marko <peter.marko@siemens.com>

This is a copy of these files from scarthgap/go branch modified for
wrynose release:
* switch scarthgap to wrynose
* drop extra configurations fro layer.conf

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .gitignore      |  1 +
 COPYING.MIT     | 17 ++++++++++
 README.md       | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 conf/layer.conf | 15 +++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 COPYING.MIT
 create mode 100644 README.md
 create mode 100644 conf/layer.conf

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0d20b64
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+*.pyc
diff --git a/COPYING.MIT b/COPYING.MIT
new file mode 100644
index 0000000..fb950dc
--- /dev/null
+++ b/COPYING.MIT
@@ -0,0 +1,17 @@
+Permission is hereby granted, free of charge, to any person obtaining a copy 
+of this software and associated documentation files (the "Software"), to deal 
+in the Software without restriction, including without limitation the rights 
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
+copies of the Software, and to permit persons to whom the Software is 
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in 
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
+THE SOFTWARE.
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..7330b8c
--- /dev/null
+++ b/README.md
@@ -0,0 +1,86 @@
+meta-mixins-lts - wrynose/go
+============================
+
+"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
+
+At the time Wrynose was released in April 2026, Go 1.26 was the latest version
+and officially Wrynose supports only that. This thin special-purpose mixin
+layer is meant to address this issue by backporting Go recipes from the master
+branch of openembedded-core.
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git  
+  layers: meta  
+  branch: wrynose
+
+Contributing
+------------
+
+The patches can be backported from openembedded-core with:
+
+ git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
+ git am --signoff -p4 --directory=recipes-devtools/go
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
+for questions, comments and patch review. It is subscriber only, so please
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][wrynose/go]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][wrynose/go][PATCH'
+
+Maintenance
+-----------
+
+Layer maintainers:
+* Jose Quaresma <jose.quaresma@foundries.io>
+* Peter Marko <peter.marko@siemens.com>
+
+Quality Assurance
+-----------------
+
+QA tests are using original openembedded-core testsuites.
+Current plan is to backport QA test changes to openembedded-core wrynose branch.
+When that is no longer possible, changes will picked here.
+
+Automated tests to verify go toolchain functionality are being executed with following configurations and commands:
+
+* OEQA runtime
+
+    ```
+    IMAGE_INSTALL:append = " cgo-helloworld go-helloworld packagegroup-go-sdk-target"
+    IMAGE_CLASSES += "testimage"
+    TEST_SUITES:append = " go go_mixin"
+    ```
+
+    ```
+    bitbake core-image-ptest-go && bitbake core-image-ptest-go:do_testimage
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
diff --git a/conf/layer.conf b/conf/layer.conf
new file mode 100644
index 0000000..9215c91
--- /dev/null
+++ b/conf/layer.conf
@@ -0,0 +1,15 @@
+# We have a conf and classes directory, append to BBPATH
+BBPATH .= ":${LAYERDIR}"
+
+# We have a recipes directory, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "lts-go-mixin"
+BBFILE_PATTERN_lts-go-mixin := "^${LAYERDIR}/"
+BBFILE_PRIORITY_lts-go-mixin = "6"
+
+LAYERSERIES_COMPAT_lts-go-mixin = "wrynose"
+
+LAYERDEPENDS_lts-go-mixin = " \
+    core \
+"

