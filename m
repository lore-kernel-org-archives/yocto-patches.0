Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36663CD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 17:11:06 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2453.1778692263913429678
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 10:11:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=NBB3J5hL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260513171102c94fee912f00020761-_r2gci@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260513171102c94fee912f00020761
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 19:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2xyEPSRvpbkQtTRNbn65NwFLKRZ4mCUYClmlgYgBwMY=;
 b=NBB3J5hLlTUnDMs+37/VuZpvgfUk2iEwAC0YRwBS0c8c4sLXE9CRLHiumh6R8AkOrGLqIC
 G+jZhnsTMLqdOSx6wmuLOsBO2wmV5tS5syAhmRUEV6MZe8ocQhHOKprWC6wu602pgK0Xhw7P
 6/fyg/AexXyRH4A1MYDY6RvjZpGOEzl8Fq5gE7GHFMDh++tLMNsa8yd++qoyNz8FiEuWm3+J
 EghkwwRRUx5z4asdha6YOXeS2iDxSViy0irsNVk6fv2GkqutP7vTNZ2fTPzWB8ZXtiDJL0+g
 ujQaSKuoZgtiMtSgQbcgi8PK/OhQJ2H69ULbaC2pi/ycy30VDKyoW3gg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 7/7] go: upgrade 1.26.2 -> 1.26.3
Date: Wed, 13 May 2026 19:09:01 +0200
Message-ID: <20260513170902.2468061-7-peter.marko@siemens.com>
In-Reply-To: <20260513170902.2468061-1-peter.marko@siemens.com>
References: <20260513170902.2468061-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 17:11:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3989

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.2..go1.26.3
2dc996f71b (tag: go1.26.3) [release-branch.go1.26] go1.26.3
8282c628a0 [release-branch.go1.26] cmd/go: reject sumdb response lacking module hash
3baf3eec3b [release-branch.go1.26] all: avoid unsafe StringToUTF16Ptr on Windows
0bec63330d [release-branch.go1.26] net/mail: fix quadratic consumePhrase behavior
7136366ebf [release-branch.go1.26] cmd/go: invalidate test cache when -coverpkg dependencies change
722b68ceca [release-branch.go1.26] cmd/compile: keep blank nodes alive in b.loop
3ae315a8cd [release-branch.go1.26] os: avoid panic when RemoveAll fails to remove a symlink
c9f97f50c4 [release-branch.go1.26] html/template: fix escaping of URLs in meta content attributes
40fa774fff [release-branch.go1.26] cmd/pack: refuse to extract files with directory components
d9389d318b [release-branch.go1.26] net/mail: fix quadratic complexity in consumeComment
dd29b59a2b [release-branch.go1.26] cmd/compile: fix loopvar version detection with line directives
18fa391f45 [release-branch.go1.26] crypto/fips140: add package docs
e0f5c054cb [release-branch.go1.26] net: avoid double-free of cgo pointer when handling large DNS response
2992086cf8 [release-branch.go1.26] lib/fips140: add certified pointing to v1.0.0-c2097c7c
f43caf8712 [release-branch.go1.26] lib/fips140: update inprocess to v1.26.0
19d2ce3401 [release-branch.go1.26] runtime: fix timespec definition on 32bits systems
e9df527f06 [release-branch.go1.26] crypto/tls: wrap ML-KEM hybrids in fips140.WithoutEnforcement
73f417a37c [release-branch.go1.26] go/types, types2: handle unconstrained type parameters correctly in a few places
50856a181c [release-branch.go1.26] cmd/go: use MkdirTemp to create temp directory for "go bug"
e137885d68 [release-branch.go1.26] cmd/compile/internal/devirtualize: use pointer identity for type comparison
c9712872cc [release-branch.go1.26] crypto/internal/fips140/drbg: build tag out entropy generation on Wasm
cb994d85ff [release-branch.go1.26] cmd/fix: change -diff to exit 1 if diffs exist
95470667eb [release-branch.go1.26] net/http/httputil: reencode queries with many parameters in proxy
9b01c04815 [release-branch.go1.26] html/template: fix escaper bypass by treating empty script type as JavaScript
be12fe151c [release-branch.go1.26] runtime: use uname version check for 64-bit time on 32-bit arch codepaths
ec5ebece41 [release-branch.go1.26] all: update x/net to 705de46f
710f29a758 [release-branch.go1.26] runtime: add sysUnreserve to undo sysReserve
efdc0fb354 [release-branch.go1.26] cmd/compile: handle min integer step in loop
ba4554f03b [release-branch.go1.26] cmd/go: specify full path to go command when running go tool covdata
f4e425d342 [release-branch.go1.26] fix incorrect loop trip counts
0b4d5f85e6 [release-branch.go1.26] cmd/link: use bfd ld 2.36+ on linux/arm64 instead of gold

Fixes CVE-2026-42501, CVE-2026-39825, CVE-2026-39836, CVE-2026-42499,
      CVE-2026-39820, CVE-2026-39819, CVE-2026-39817, CVE-2026-33814,
      CVE-2026-39826, CVE-2026-33811 and CVE-2026-39823.

Drop patch handling gold linker as upstream implemented gold linker
availability autodetection with [3].

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.2...go1.26.3
[2] https://groups.google.com/g/golang-announce/c/qcCIEXso47M
[3] https://github.com/golang/go/commit/0b4d5f85e68ea79b61de9989f9f37a984eb11289

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 3d8258a8d3d96dc1225172c2ff9e889fd12cf6bc)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../go/{go-1.26.2.inc => go-1.26.3.inc}       |  3 +-
 ...e_1.26.2.bb => go-binary-native_1.26.3.bb} |  6 +-
 ..._1.26.2.bb => go-cross-canadian_1.26.3.bb} |  0
 ...{go-cross_1.26.2.bb => go-cross_1.26.3.bb} |  0
 ...osssdk_1.26.2.bb => go-crosssdk_1.26.3.bb} |  0
 ...runtime_1.26.2.bb => go-runtime_1.26.3.bb} |  0
 ...rcing-binutils-gold-dependency-on-aa.patch | 55 -------------------
 .../go/{go_1.26.2.bb => go_1.26.3.bb}         |  0
 8 files changed, 4 insertions(+), 60 deletions(-)
 rename recipes-devtools/go/{go-1.26.2.inc => go-1.26.3.inc} (83%)
 rename recipes-devtools/go/{go-binary-native_1.26.2.bb => go-binary-native_1.26.3.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.2.bb => go-cross-canadian_1.26.3.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.2.bb => go-cross_1.26.3.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.2.bb => go-crosssdk_1.26.3.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.2.bb => go-runtime_1.26.3.bb} (100%)
 delete mode 100644 recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
 rename recipes-devtools/go/{go_1.26.2.bb => go_1.26.3.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.2.inc b/recipes-devtools/go/go-1.26.3.inc
similarity index 83%
rename from recipes-devtools/go/go-1.26.2.inc
rename to recipes-devtools/go/go-1.26.3.inc
index 8bb10bc..db7b18e 100644
--- a/recipes-devtools/go/go-1.26.2.inc
+++ b/recipes-devtools/go/go-1.26.3.inc
@@ -15,6 +15,5 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
-    file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
 "
-SRC_URI[main.sha256sum] = "2e91ebb6947a96e9436fb2b3926a8802efe63a6d375dffec4f82aa9dbd6fd43b"
+SRC_URI[main.sha256sum] = "1c646875d0aa8799133184ed57cf79ff24bdefe8c8820470602a9d3d6d9192b8"
diff --git a/recipes-devtools/go/go-binary-native_1.26.2.bb b/recipes-devtools/go/go-binary-native_1.26.3.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.2.bb
rename to recipes-devtools/go/go-binary-native_1.26.3.bb
index f36606b..8c51339 100644
--- a/recipes-devtools/go/go-binary-native_1.26.2.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.3.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282"
-SRC_URI[go_linux_arm64.sha256sum] = "c958a1fe1b361391db163a485e21f5f228142d6f8b584f6bef89b26f66dc5b23"
-SRC_URI[go_linux_ppc64le.sha256sum] = "62b7645dd2404052535617c59e91cf03c7aa28e332dbaddbe4c0d7de7bcc6736"
+SRC_URI[go_linux_amd64.sha256sum] = "2b2cfc7148493da5e73981bffbf3353af381d5f93e789c82c79aff64962eb556"
+SRC_URI[go_linux_arm64.sha256sum] = "9d89a3ea57d141c2b22d70083f2c8459ba3890f2d9e818e7e933b75614936565"
+SRC_URI[go_linux_ppc64le.sha256sum] = "dbd82b50530ead2beb1fd72215117380df3cb16332b51467116dc35b3691dd75"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.2.bb b/recipes-devtools/go/go-cross-canadian_1.26.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.2.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.3.bb
diff --git a/recipes-devtools/go/go-cross_1.26.2.bb b/recipes-devtools/go/go-cross_1.26.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.2.bb
rename to recipes-devtools/go/go-cross_1.26.3.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.2.bb b/recipes-devtools/go/go-crosssdk_1.26.3.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.2.bb
rename to recipes-devtools/go/go-crosssdk_1.26.3.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.2.bb b/recipes-devtools/go/go-runtime_1.26.3.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.2.bb
rename to recipes-devtools/go/go-runtime_1.26.3.bb
diff --git a/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch b/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
deleted file mode 100644
index dda0f2b..0000000
--- a/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
+++ /dev/null
@@ -1,55 +0,0 @@
-From 6d265b008e3d106b2706645e5a88cd8e2fb98953 Mon Sep 17 00:00:00 2001
-From: Dirk Müller <dirk@dmllr.de>
-Date: Wed, 09 Mar 2022 17:47:23 +0100
-Subject: [PATCH 11/11] cmd/link: stop forcing binutils-gold dependency on
-  aarch64
-
-The bfd linker appears to be working just fine at least in version
-2.41 or above. Reject the known broken one instead, which
-avoids an architecture specific linker dependency that
-is cumbersome for distributions.
-
-Fixes #22040.
-
-Change-Id: I9f377e47c22ef20497479c0978c053ed5de46a38
-
-Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/391115]
----
- src/cmd/link/internal/ld/lib.go | 21 ---------------------
- 1 file changed, 21 deletions(-)
-
-diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
-index dfc72e02c0..2a2a304113 100644
---- a/src/cmd/link/internal/ld/lib.go
-+++ b/src/cmd/link/internal/ld/lib.go
-@@ -1701,27 +1701,6 @@ func (ctxt *Link) hostlink() {
- 			// Use lld to avoid errors from default linker (issue #38838)
- 			altLinker = "lld"
- 		}
--
--		if ctxt.Arch.InFamily(sys.ARM64) && buildcfg.GOOS == "linux" {
--			// On ARM64, the GNU linker will fail with
--			// -znocopyreloc if it thinks a COPY relocation is
--			// required. Switch to gold.
--			// https://sourceware.org/bugzilla/show_bug.cgi?id=19962
--			// https://go.dev/issue/22040
--			altLinker = "gold"
--
--			// If gold is not installed, gcc will silently switch
--			// back to ld.bfd. So we parse the version information
--			// and provide a useful error if gold is missing.
--			name, args := flagExtld[0], flagExtld[1:]
--			args = append(args, "-fuse-ld=gold", "-Wl,--version")
--			cmd := exec.Command(name, args...)
--			if out, err := cmd.CombinedOutput(); err == nil {
--				if !bytes.Contains(out, []byte("GNU gold")) {
--					log.Fatalf("ARM64 external linker must be gold (issue #15696, 22040), but is not: %s", out)
--				}
--			}
--		}
- 	}
- 	if ctxt.Arch.Family == sys.ARM64 && buildcfg.GOOS == "freebsd" {
- 		// Switch to ld.bfd on freebsd/arm64.
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go_1.26.2.bb b/recipes-devtools/go/go_1.26.3.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.2.bb
rename to recipes-devtools/go/go_1.26.3.bb

