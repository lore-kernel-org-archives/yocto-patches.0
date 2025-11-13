Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB51CD8C8D
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23155.1763038637350289846
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=nYDNjkTm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251113125715541cc90c9d000207bc-uuyv8d@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251113125715541cc90c9d000207bc
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n+mwKAiyBqZj9P+LVnuV9Bc7vCSztiH+9cvH/HNDqoU=;
 b=nYDNjkTmmSjDEEouZgY+/BUgSfie7FSCBuRk8jmmVN03am5Pee/i9MlgUV3FjM3wkdAZri
 eudIgcHAXQzzh+79LdiHC4ssD5L767cbh0khLIXREHwTFEgo3B0U6Y7M79CHAGcMbyyrhf7A
 +wgBcHzDNTo0kRj+/9YyioulTi1JBYdY8uf2F/0+yxoezYZgnG9mBOdsLwzdg3kYgEYZA9B/
 6E0E1Z2W82/jdZF6PAa2aiF9Sn2yyOIP+xGoCd8Nt26toZ24RirU36CcdsFOlLT8Ec9J13N0
 EQ2WKunHXjIKcYWeU0gTJz2Tw3QSyIHc1HZvNXk02zB4Ais144yOSlBw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 12/34] go: Fix to work without gold on aarch64
Date: Thu, 13 Nov 2025 13:56:50 +0100
Message-Id: <20251113125712.18914-13-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2508

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If we remove gold from binutils, go-runtime fails to build. There was a
workaround in go to use gold as the bfd linker had a bug. The issue was
fixed so backport dropping the workaround fmr upstream.

(From OE-Core rev: 4636b7206b2e4247835d60956e62f5a2efea9e81)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.22.12.inc            |  1 +
 ...5b008e3d106b2706645e5a88cd8e2fb98953.patch | 49 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch

diff --git a/recipes-devtools/go/go-1.22.12.inc b/recipes-devtools/go/go-1.22.12.inc
index 05aa3a9..8d14efa 100644
--- a/recipes-devtools/go/go-1.22.12.inc
+++ b/recipes-devtools/go/go-1.22.12.inc
@@ -14,5 +14,6 @@ SRC_URI += "\
     file://0007-exec.go-filter-out-build-specific-paths-from-linker-.patch \
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
+    file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
 SRC_URI[main.sha256sum] = "012a7e1f37f362c0918c1dfa3334458ac2da1628c4b9cf4d9ca02db986e17d71"
diff --git a/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch b/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
new file mode 100644
index 0000000..d858cc6
--- /dev/null
+++ b/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
@@ -0,0 +1,49 @@
+From 6d265b008e3d106b2706645e5a88cd8e2fb98953 Mon Sep 17 00:00:00 2001
+From: Dirk Müller <dirk@dmllr.de>
+Date: Wed, 09 Mar 2022 17:47:23 +0100
+Subject: [PATCH] cmd/link: stop forcing binutils-gold dependency on aarch64
+
+The bfd linker appears to be working just fine at least in version
+2.41 or above. Reject the known broken one instead, which
+avoids an architecture specific linker dependency that
+is cumbersome for distributions.
+
+Fixes #22040.
+
+Change-Id: I9f377e47c22ef20497479c0978c053ed5de46a38
+
+Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/391115]
+---
+
+diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
+index 2d8f964..fcf0bc7 100644
+--- a/src/cmd/link/internal/ld/lib.go
++++ b/src/cmd/link/internal/ld/lib.go
+@@ -1670,27 +1670,6 @@
+ 			// Use lld to avoid errors from default linker (issue #38838)
+ 			altLinker = "lld"
+ 		}
+-
+-		if ctxt.Arch.InFamily(sys.ARM64) && buildcfg.GOOS == "linux" {
+-			// On ARM64, the GNU linker will fail with
+-			// -znocopyreloc if it thinks a COPY relocation is
+-			// required. Switch to gold.
+-			// https://sourceware.org/bugzilla/show_bug.cgi?id=19962
+-			// https://go.dev/issue/22040
+-			altLinker = "gold"
+-
+-			// If gold is not installed, gcc will silently switch
+-			// back to ld.bfd. So we parse the version information
+-			// and provide a useful error if gold is missing.
+-			name, args := flagExtld[0], flagExtld[1:]
+-			args = append(args, "-fuse-ld=gold", "-Wl,--version")
+-			cmd := exec.Command(name, args...)
+-			if out, err := cmd.CombinedOutput(); err == nil {
+-				if !bytes.Contains(out, []byte("GNU gold")) {
+-					log.Fatalf("ARM64 external linker must be gold (issue #15696, 22040), but is not: %s", out)
+-				}
+-			}
+-		}
+ 	}
+ 	if ctxt.Arch.Family == sys.ARM64 && buildcfg.GOOS == "freebsd" {
+ 		// Switch to ld.bfd on freebsd/arm64.

