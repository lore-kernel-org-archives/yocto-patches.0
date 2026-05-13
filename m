Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC96CD4F3E
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 17:10:56 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2447.1778692248772860109
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 10:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=kXaUsovo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2026051317104646def2c74800020747-_xvo6_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026051317104646def2c74800020747
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 19:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0fbKSvMNHTyC6kzTJ9xbbZbrX3EsXBEf9Eq0W3XrgqQ=;
 b=kXaUsovoRe6SLY8UGtSSi9S3va7YsEAqEBYNR5/3kYfi0agTOC61Z21jkD5qlFx7mI1RON
 jBUX/NvX/X7HG7iKrqVPenAxoRbIisOt93kpAwBNb3vVETQB5L7rUGP5pcaopWvRnQmSU+q6
 IPSY2ddtcvX0E/F5WyaxrEJglban92TP3UIB5q6i3BWG/dEgBDda6mWUNtcee4RMpwIOcM+C
 f7VpohlEx5VmsVNoT6jb24R9GX8LNIu29qDF/fY6QKal0giJ7tTMcL4hEOqnksC4QsnwWrbo
 04PS/BY7uhyob29bZNR/7B/+guQz6h0o++gkpFXXZAqq8M38YpHIJRtg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 5/7] go: ptest: fix GOROOT detection and improve cleanup/exit handling
Date: Wed, 13 May 2026 19:08:59 +0200
Message-ID: <20260513170902.2468061-5-peter.marko@siemens.com>
In-Reply-To: <20260513170902.2468061-1-peter.marko@siemens.com>
References: <20260513170902.2468061-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 17:10:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3987

From: Pratik Farkase <pratik.farkase@est.tech>

Changes:
  - Derive GOROOT dynamically from PTEST_DIR instead of hardcoding
    /usr/lib/go, which breaks on distros using lib64.
  - Track and clean up VERSION and pkg/include files that were copied
    into GOROOT, preventing stale artifacts after ptest runs.
  - Track failures with RC variable and exit non-zero when tests fail,
    consistent with other ptest scripts.

Signed-off-by: Pratik Farkase <pratik.farkase@est.tech>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: a912153baed08d8d1d563341e29a2d596546bdb4)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go/run-ptest | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/go/go/run-ptest b/recipes-devtools/go/go/run-ptest
index b8a0805..5fc9367 100755
--- a/recipes-devtools/go/go/run-ptest
+++ b/recipes-devtools/go/go/run-ptest
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: MIT
 
 PTEST_DIR=$(cd "$(dirname "$0")" && pwd)
-GOROOT=/usr/lib/go
+GOROOT=$(dirname "$PTEST_DIR")
 
 export GOROOT
 export PATH=$GOROOT/bin:$PATH
@@ -16,11 +16,18 @@ if [ -d "$GOROOT/src" ] && [ ! -L "$GOROOT/src" ]; then
 fi
 ln -sf "$PTEST_DIR/src" "$GOROOT/src"
 
-if [ -f "$PTEST_DIR/VERSION" ]; then
+CLEANUP_VERSION=0
+if [ -f "$PTEST_DIR/VERSION" ] && [ ! -f "$GOROOT/VERSION" ]; then
     cp "$PTEST_DIR/VERSION" "$GOROOT/VERSION"
+    CLEANUP_VERSION=1
 fi
+
+CLEANUP_INCLUDE=0
 if ls "$PTEST_DIR/pkg/include/"* >/dev/null 2>&1; then
-    mkdir -p "$GOROOT/pkg/include"
+    if [ ! -d "$GOROOT/pkg/include" ]; then
+        mkdir -p "$GOROOT/pkg/include"
+        CLEANUP_INCLUDE=1
+    fi
     cp "$PTEST_DIR/pkg/include/"* "$GOROOT/pkg/include/"
 fi
 
@@ -38,6 +45,7 @@ SKIP_PKGS="debug/dwarf debug/elf debug/pe debug/plan9obj go/types internal/xcoff
 
 SKIP_REGEX=$(echo "$SKIP_PKGS" | sed 's/ /|/g')
 
+RC=0
 for pkg in $(go list std); do
     # Skip package and all its subpackages
     if echo "$pkg" | grep -qE "^($SKIP_REGEX)(/|$)"; then
@@ -52,6 +60,7 @@ for pkg in $(go list std); do
     else
         echo "FAIL: $pkg"
         echo "$output"
+        RC=1
     fi
 done
 
@@ -60,4 +69,12 @@ rm -f "$GOROOT/src"
 if [ -d "$GOROOT/src.orig" ]; then
     mv "$GOROOT/src.orig" "$GOROOT/src"
 fi
+if [ $CLEANUP_VERSION -eq 1 ]; then
+    rm -f "$GOROOT/VERSION"
+fi
+if [ $CLEANUP_INCLUDE -eq 1 ]; then
+    rm -rf "$GOROOT/pkg/include"
+fi
 rm -rf "$GOCACHE"
+
+exit $RC

