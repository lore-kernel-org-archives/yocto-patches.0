Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB94C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:13:52 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5600.1789413226007800041
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:13:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=eFSu3CMY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260914191344769fdf564f00020740-eyf1_j@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260914191344769fdf564f00020740
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:13:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TSwgaY3IiL6yfjiJ3UVFuaVTc6dKy1db617odHtXyUY=;
 b=eFSu3CMYWyUgBh/G3t7/tYLx0hrZFh48UUlSbcAr/oGjucqa5cihXaw2B6dvHRo8W8wEHk
 ucUyXPKjjm6wHxb/863L89Ozs1/QLfaAgqPaooXfHtbkDZBZOA+po9gas28x7i9tFFCMZHzs
 t9qoI5SJ3BN0PHrk+usyaVoAEnvvgqMGF+wpb9oQQw1eDTlhRevbrCJCp+pylLRQTi5cFzCy
 akj0/FvTxjk0Pdp2cBeFk8P1skek5w7vrt664Zax5eeib/XSTmfbBfiQ+GrJshdX/eYCrb8m
 u/xH0O1eHOhhFf2EZQh6DtITR3H0EKhWRLgsaRSOZO9sz00Q9jn0DTuQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 05/11] go: ptest: improvements and multiple fixes in golang ptest
Date: Mon, 14 Sep 2026 21:12:34 +0200
Message-ID: <20260914191240.1066469-5-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4832

From: Pratik Farkase <pratik.farkase@est.tech>

Summary of Changelog:

- run-ptest permanently modified the installed GOROOT by symlinking src/
    and copying files without cleanup, corrupting the Go installation
  - Sub-package skip regex used exact match (^pkg$) so subpackages like
    net/http/httptest and runtime/debug were not skipped and would fail
  - Test output was completely suppressed (>/dev/null 2>&1), making
    failures impossible to diagnose
  - go was missing from RDEPENDS, allowing ptest to be installed without
    the toolchain it needs
  - bash was in RDEPENDS despite the script using #!/bin/sh with no
    bash-isms
  - file://run-ptest was in the shared .inc, affecting go-cross and
    go-native which don't inherit ptest
  - cp pkg/include/* would fail if the directory was empty

Fix by saving/restoring GOROOT/src, using (/|$) in the skip regex,
printing output on failure, correcting RDEPENDS, moving run-ptest to
the target .bb, and guarding the glob.

Tested on qemux86-64: all tests pass, 0 failures (~63 min).

Signed-off-by: Pratik Farkase <pratik.farkase@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: a359aed2a8b94ad395a259a2009347e97185cbbc)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.26.7.inc |  1 -
 recipes-devtools/go/go/run-ptest  | 47 +++++++++++++++++++++++++------
 recipes-devtools/go/go_1.26.7.bb  |  8 ++++--
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/recipes-devtools/go/go-1.26.7.inc b/recipes-devtools/go/go-1.26.7.inc
index ed2c7a7..fed8701 100644
--- a/recipes-devtools/go/go-1.26.7.inc
+++ b/recipes-devtools/go/go-1.26.7.inc
@@ -15,6 +15,5 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
-    file://run-ptest \
 "
 SRC_URI[main.sha256sum] = "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
diff --git a/recipes-devtools/go/go/run-ptest b/recipes-devtools/go/go/run-ptest
index ac020de..b8a0805 100755
--- a/recipes-devtools/go/go/run-ptest
+++ b/recipes-devtools/go/go/run-ptest
@@ -1,32 +1,63 @@
 #!/bin/sh
+# SPDX-License-Identifier: MIT
 
-PTEST_DIR=/usr/lib/go/ptest
+PTEST_DIR=$(cd "$(dirname "$0")" && pwd)
 GOROOT=/usr/lib/go
 
 export GOROOT
 export PATH=$GOROOT/bin:$PATH
+export GOCACHE=$(mktemp -d)
 export ZONEINFO=/usr/share/zoneinfo
 
-ln -sf $PTEST_DIR/src $GOROOT/src
-mkdir -p $GOROOT/pkg/include
-cp $PTEST_DIR/pkg/include/* $GOROOT/pkg/include/
-cp $PTEST_DIR/VERSION $GOROOT/VERSION
+# Link ptest source tree into GOROOT for testing.
+# Save and restore any existing src directory.
+if [ -d "$GOROOT/src" ] && [ ! -L "$GOROOT/src" ]; then
+    mv "$GOROOT/src" "$GOROOT/src.orig"
+fi
+ln -sf "$PTEST_DIR/src" "$GOROOT/src"
 
-cd $GOROOT
+if [ -f "$PTEST_DIR/VERSION" ]; then
+    cp "$PTEST_DIR/VERSION" "$GOROOT/VERSION"
+fi
+if ls "$PTEST_DIR/pkg/include/"* >/dev/null 2>&1; then
+    mkdir -p "$GOROOT/pkg/include"
+    cp "$PTEST_DIR/pkg/include/"* "$GOROOT/pkg/include/"
+fi
 
+cd "$GOROOT" || exit 1
+
+# Packages skipped due to known issues in the ptest environment:
+#   debug/dwarf, debug/elf, debug/pe, debug/plan9obj, internal/xcoff:
+#       require binary testdata files excluded to avoid QA errors
+#   go/types: extremely slow, exceeds ptest timeout
+#   net/http: requires network access unavailable in qemu
+#   runtime: requires cgo rebuild and race detector setup
+#   testing: circular dependency when testing the test framework
+#   time: requires writable GOROOT for timezone data
 SKIP_PKGS="debug/dwarf debug/elf debug/pe debug/plan9obj go/types internal/xcoff net/http runtime testing time"
 
 SKIP_REGEX=$(echo "$SKIP_PKGS" | sed 's/ /|/g')
 
 for pkg in $(go list std); do
-    if echo "$pkg" | grep -qE "^($SKIP_REGEX)$"; then
+    # Skip package and all its subpackages
+    if echo "$pkg" | grep -qE "^($SKIP_REGEX)(/|$)"; then
         echo "SKIP: $pkg"
         continue
     fi
 
-    if go test -short "$pkg" >/dev/null 2>&1; then
+    output=$(go test -short "$pkg" 2>&1)
+    ret=$?
+    if [ $ret -eq 0 ]; then
         echo "PASS: $pkg"
     else
         echo "FAIL: $pkg"
+        echo "$output"
     fi
 done
+
+# Cleanup: restore original src directory
+rm -f "$GOROOT/src"
+if [ -d "$GOROOT/src.orig" ]; then
+    mv "$GOROOT/src.orig" "$GOROOT/src"
+fi
+rm -rf "$GOCACHE"
diff --git a/recipes-devtools/go/go_1.26.7.bb b/recipes-devtools/go/go_1.26.7.bb
index 35a14b8..2e18ce0 100644
--- a/recipes-devtools/go/go_1.26.7.bb
+++ b/recipes-devtools/go/go_1.26.7.bb
@@ -3,6 +3,8 @@ require go-target.inc
 
 inherit linuxloader ptest
 
+SRC_URI += "file://run-ptest"
+
 CGO_LDFLAGS:append = " -no-pie"
 
 export GO_LDSO = "${@get_linuxloader(d)}"
@@ -20,7 +22,9 @@ do_install_ptest() {
     install -d ${D}${PTEST_PATH}/src
     install -d ${D}${PTEST_PATH}/pkg/include
 
-    cp ${S}/pkg/include/* ${D}${PTEST_PATH}/pkg/include/
+    if ls ${S}/pkg/include/* >/dev/null 2>&1; then
+        cp ${S}/pkg/include/* ${D}${PTEST_PATH}/pkg/include/
+    fi
     echo "go${PV}" > ${D}${PTEST_PATH}/VERSION
 
     cd ${S}/src
@@ -40,4 +44,4 @@ do_install_ptest() {
         -exec install -m 0644 {} ${D}${PTEST_PATH}/src/{} \;
 }
 
-RDEPENDS:${PN}-ptest += "bash tzdata git packagegroup-core-buildessential"
+RDEPENDS:${PN}-ptest += "go tzdata git packagegroup-core-buildessential"

