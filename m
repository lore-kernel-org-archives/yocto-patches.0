Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706D7CD8C90
	for <webhook@archiver.kernel.org>; Sun,  7 Jun 2026 19:30:39 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39317.1780860630153281586
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Jun 2026 12:30:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=ZO2enpLF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20260607193027e2b229003d000207c5-uy8mgc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260607193027e2b229003d000207c5
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 07 Jun 2026 21:30:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=InNxukLJQ9dIjTtgfUH5Nx4/LgeDgxhu0OpvIUuI92Q=;
 b=ZO2enpLF4VMceku68+4HkaR3Or3+IBS3PvI0NlsyQE9pCooZeFs+sjx/fVeWZ0UFBG0BPp
 7I+WRHwVTkQOFRJrzeRH4VXiefaLn2Ggp1M/pYG/ws70LYX3LysZ8oHE0P9DcKUbjFCRY5ms
 pay51R3GO0LuVbPl2/M2zjLr6qyqi62Ql5EO/R7iETtDhsIaRjscp1hhOfpOiK2dgbNTGaiq
 wL+ynAV7iGIV6XV3aqfX6k0sIpzmwhVk/yGIWaubk4BkXzsw0MFRIasD0zcXPBDoBiTx1QOA
 9erO5rY3ZQQ2DdSTNhK4GI5VERvVjnlx7YWQI3urzYpEL7qEdx7KcYww==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 2/4] cgo-helloworld: init add
Date: Sun,  7 Jun 2026 21:29:32 +0200
Message-ID: <20260607192934.156036-2-peter.marko@siemens.com>
In-Reply-To: <20260607192934.156036-1-peter.marko@siemens.com>
References: <20260607192934.156036-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 07 Jun 2026 19:30:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4171

From: Changqing Li <changqing.li@windriver.com>

* Add a go example recipe with cgo enabled, Flush the stdio buffer so
  that piped stdout can read the output before the program exits.

  This is for covering go reproducibility with cgo enabled. The test
  coverage is provided by the reproducibility world build.

  Related to the following commit [1]:
  [0642d23230 go.bbclass: change GOTMPDIR to improve reproducibility]

* cgo-helloworld is a complement for go-helloworld, also add it in
  runtime case for go and gotools

[1] https://git.openembedded.org/openembedded-core/commit/?id=0642d2323072f561a4d0eeb9266213387b2997fc

[YOCTO #16100]

Signed-off-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 204e4f7398ca0e8847a026c5b4f46685760af90a)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 lib/oeqa/runtime/cases/go_mixin.py            | 15 ++++++++++++
 .../packagegroup-core-tools-testapps.bbappend |  4 ++++
 .../cgo-helloworld/cgo-helloworld.go          |  9 ++++++++
 .../go-examples/cgo-helloworld_1.0.bb         | 23 +++++++++++++++++++
 .../go-examples/cgo-helloworld_1.0.bbappend   |  2 ++
 5 files changed, 53 insertions(+)
 create mode 100644 lib/oeqa/runtime/cases/go_mixin.py
 create mode 100644 recipes-core/packagegroups/packagegroup-core-tools-testapps.bbappend
 create mode 100644 recipes-extended/go-examples/cgo-helloworld/cgo-helloworld.go
 create mode 100644 recipes-extended/go-examples/cgo-helloworld_1.0.bb
 create mode 100644 recipes-extended/go-examples/cgo-helloworld_1.0.bbappend

diff --git a/lib/oeqa/runtime/cases/go_mixin.py b/lib/oeqa/runtime/cases/go_mixin.py
new file mode 100644
index 0000000..9e94cfa
--- /dev/null
+++ b/lib/oeqa/runtime/cases/go_mixin.py
@@ -0,0 +1,15 @@
+from oeqa.runtime.case import OERuntimeTestCase
+from oeqa.core.decorator.depends import OETestDepends
+from oeqa.runtime.decorator.package import OEHasPackage
+
+class CgoHelloworldTest(OERuntimeTestCase):
+    @OETestDepends(['ssh.SSHTest.test_ssh'])
+    @OEHasPackage(['cgo-helloworld'])
+    def test_cgohelloworld(self):
+        cmd = "cgo-helloworld"
+        status, output = self.target.run(cmd)
+        msg = 'Exit status was not 0. Output: %s' % output
+        self.assertEqual(status, 0, msg=msg)
+
+        msg = 'Incorrect output: %s' % output
+        self.assertEqual(output, "Hello, world!", msg=msg)
diff --git a/recipes-core/packagegroups/packagegroup-core-tools-testapps.bbappend b/recipes-core/packagegroups/packagegroup-core-tools-testapps.bbappend
new file mode 100644
index 0000000..e5dca6f
--- /dev/null
+++ b/recipes-core/packagegroups/packagegroup-core-tools-testapps.bbappend
@@ -0,0 +1,4 @@
+GOTOOLS = "\
+    go-helloworld \
+    cgo-helloworld \
+    "
diff --git a/recipes-extended/go-examples/cgo-helloworld/cgo-helloworld.go b/recipes-extended/go-examples/cgo-helloworld/cgo-helloworld.go
new file mode 100644
index 0000000..0c1f9d4
--- /dev/null
+++ b/recipes-extended/go-examples/cgo-helloworld/cgo-helloworld.go
@@ -0,0 +1,9 @@
+package main
+
+// #include <stdio.h>
+// void hello() { printf("Hello, world!\n"); fflush(stdout);}
+import "C"
+
+func main() {
+	C.hello()
+}
diff --git a/recipes-extended/go-examples/cgo-helloworld_1.0.bb b/recipes-extended/go-examples/cgo-helloworld_1.0.bb
new file mode 100644
index 0000000..9ca1e16
--- /dev/null
+++ b/recipes-extended/go-examples/cgo-helloworld_1.0.bb
@@ -0,0 +1,23 @@
+SUMMARY = "A simple CGO example that calls C to print hello world"
+SECTION = "examples"
+HOMEPAGE = "https://golang.org/"
+
+LICENSE = "MIT"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
+
+SRC_URI = "file://cgo-helloworld.go"
+
+S = "${UNPACKDIR}"
+
+GO_IMPORT = "cgo-helloworld"
+GO_INSTALL = "${GO_IMPORT}"
+
+inherit go
+
+export GO111MODULE = "off"
+export CGO_ENABLED = "1"
+
+do_configure:prepend() {
+    mkdir -p ${S}/src/${GO_IMPORT}
+    cp ${UNPACKDIR}/cgo-helloworld.go ${S}/src/${GO_IMPORT}/main.go
+}
diff --git a/recipes-extended/go-examples/cgo-helloworld_1.0.bbappend b/recipes-extended/go-examples/cgo-helloworld_1.0.bbappend
new file mode 100644
index 0000000..6d8a9ee
--- /dev/null
+++ b/recipes-extended/go-examples/cgo-helloworld_1.0.bbappend
@@ -0,0 +1,2 @@
+# UNPACKDIR does not exist yet in scarthgap
+UNPACKDIR = "${WORKDIR}"

