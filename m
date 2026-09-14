Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE380C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:13:42 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5593.1789413215905992786
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:13:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=MVWDbsLy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-202609141913334dbf2710c400020710-4qzuvx@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202609141913334dbf2710c400020710
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0zNzVAp1D25R4YOjdgRVce27pHCaYR9j24R5d0Qxn+g=;
 b=MVWDbsLy9nHvGrIRJ1OS2vw8Ij0/e2orioSiGY2jTbz+xO7TJ6yM5ZmG048yIxIupNRaju
 nJl5nTTOvINpn6M+iGsIADiaQTb1tYbOvycIJkCayFKbvy7upjPFWHb+YfVnH/f4Wy+OsnHo
 dUIowVYv1syLtdcWdTXAU3ugNThyOAzqyGVRHkzOjQtb419EuBazq/hTR5Fm+tYfNiyEPdl4
 eLJKKdkKHl5EtY/dGEq+lLMbyIis1Ws8uXDlfHhMWhqnbjHbB7JzX3baL76gZQcnqRa30syT
 y11SwNL17MGMgsa5+YCNRc9esDCk5/y008+ujH4gyn3kVptAAEZpku9Q==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 04/11] go: add ptest support
Date: Mon, 14 Sep 2026 21:12:33 +0200
Message-ID: <20260914191240.1066469-4-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:13:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4831

From: Pratik Farkase <pratik.farkase@est.tech>

Add ptest infrastructure to test the Go standard library.

- Run 'go test -short std' via run-ptest script
- Install source tree and pkg/include headers
- Create VERSION file for architecture detection
- Exclude multi-arch binary testdata to avoid QA errors

Signed-off-by: Pratik Farkase <pratik.farkase@est.tech>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(From OE-Core rev: 9ca41405e6bca276468a3b6f67eaa328b8016485)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf                               |  2 ++
 recipes-core/images/core-image-ptest.bbappend |  6 ++++
 recipes-devtools/go/go-1.26.7.inc             |  1 +
 recipes-devtools/go/go/run-ptest              | 32 +++++++++++++++++++
 recipes-devtools/go/go_1.26.7.bb              | 27 +++++++++++++++-
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/images/core-image-ptest.bbappend
 create mode 100755 recipes-devtools/go/go/run-ptest

diff --git a/conf/layer.conf b/conf/layer.conf
index 9215c91..8b98c80 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,3 +13,5 @@ LAYERSERIES_COMPAT_lts-go-mixin = "wrynose"
 LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
+
+PTESTS_SLOW:append = " go"
diff --git a/recipes-core/images/core-image-ptest.bbappend b/recipes-core/images/core-image-ptest.bbappend
new file mode 100644
index 0000000..835487c
--- /dev/null
+++ b/recipes-core/images/core-image-ptest.bbappend
@@ -0,0 +1,6 @@
+PTEST_RUNNER_TIMEOUT:virtclass-mcextend-go = "4800"
+
+# golang go-ptest requires extra space
+IMAGE_ROOTFS_EXTRA_SPACE:virtclass-mcextend-go = "1524288"
+
+QB_MEM:virtclass-mcextend-go = "-m 4096"
diff --git a/recipes-devtools/go/go-1.26.7.inc b/recipes-devtools/go/go-1.26.7.inc
index fed8701..ed2c7a7 100644
--- a/recipes-devtools/go/go-1.26.7.inc
+++ b/recipes-devtools/go/go-1.26.7.inc
@@ -15,5 +15,6 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
+    file://run-ptest \
 "
 SRC_URI[main.sha256sum] = "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
diff --git a/recipes-devtools/go/go/run-ptest b/recipes-devtools/go/go/run-ptest
new file mode 100755
index 0000000..ac020de
--- /dev/null
+++ b/recipes-devtools/go/go/run-ptest
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+PTEST_DIR=/usr/lib/go/ptest
+GOROOT=/usr/lib/go
+
+export GOROOT
+export PATH=$GOROOT/bin:$PATH
+export ZONEINFO=/usr/share/zoneinfo
+
+ln -sf $PTEST_DIR/src $GOROOT/src
+mkdir -p $GOROOT/pkg/include
+cp $PTEST_DIR/pkg/include/* $GOROOT/pkg/include/
+cp $PTEST_DIR/VERSION $GOROOT/VERSION
+
+cd $GOROOT
+
+SKIP_PKGS="debug/dwarf debug/elf debug/pe debug/plan9obj go/types internal/xcoff net/http runtime testing time"
+
+SKIP_REGEX=$(echo "$SKIP_PKGS" | sed 's/ /|/g')
+
+for pkg in $(go list std); do
+    if echo "$pkg" | grep -qE "^($SKIP_REGEX)$"; then
+        echo "SKIP: $pkg"
+        continue
+    fi
+
+    if go test -short "$pkg" >/dev/null 2>&1; then
+        echo "PASS: $pkg"
+    else
+        echo "FAIL: $pkg"
+    fi
+done
diff --git a/recipes-devtools/go/go_1.26.7.bb b/recipes-devtools/go/go_1.26.7.bb
index 46f5fbc..35a14b8 100644
--- a/recipes-devtools/go/go_1.26.7.bb
+++ b/recipes-devtools/go/go_1.26.7.bb
@@ -1,7 +1,7 @@
 require go-${PV}.inc
 require go-target.inc
 
-inherit linuxloader
+inherit linuxloader ptest
 
 CGO_LDFLAGS:append = " -no-pie"
 
@@ -16,3 +16,28 @@ python() {
         d.appendVar('INSANE_SKIP:%s' % d.getVar('PN'), " textrel")
 }
 
+do_install_ptest() {
+    install -d ${D}${PTEST_PATH}/src
+    install -d ${D}${PTEST_PATH}/pkg/include
+
+    cp ${S}/pkg/include/* ${D}${PTEST_PATH}/pkg/include/
+    echo "go${PV}" > ${D}${PTEST_PATH}/VERSION
+
+    cd ${S}/src
+    find . -type d -exec install -d ${D}${PTEST_PATH}/src/{} \;
+    find . -type f \
+        ! -path "*/testdata/*.elf*" \
+        ! -path "*/testdata/*-x86-64*" \
+        ! -path "*/testdata/*.obj" \
+        ! -path "*/testdata/*.syso" \
+        ! -path "*/testdata/*.so" \
+        ! -path "*/testdata/*.so_" \
+        ! -path "*/testdata/*-exec" \
+        ! -path "*/testdata/test32*" \
+        ! -path "*/testdata/test64*" \
+        ! -path "*/race/*.syso" \
+        ! -path "*/boring/syso/*.syso" \
+        -exec install -m 0644 {} ${D}${PTEST_PATH}/src/{} \;
+}
+
+RDEPENDS:${PN}-ptest += "bash tzdata git packagegroup-core-buildessential"

