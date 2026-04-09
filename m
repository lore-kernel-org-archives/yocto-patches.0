Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C1F364A4
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 16:55:18 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.137498.1775753713783697564
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 09:55:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=PLEkd1/u;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2026040916551188a868b33d00020746-xrwkes@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026040916551188a868b33d00020746
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 09 Apr 2026 18:55:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MbQLxfNb4m85qzNSUjUDTwP4FR/9a3Yo1wldPE7khOM=;
 b=PLEkd1/ujtSHc9Rjro/HK69FioVkmmKmu9OUqkrBYELUyoS39YGPsqRfUh3Bv4Prs29r1+
 dMuRhlb5mT0nk6kVW3uwz74Vs6beXkTSxcfjdkJpc5QlfMJ2cA/sOgutLJtOWqHrm1Y+ecUs
 WZx97fpSRX9VsIOUBUq29UXpXeMZepXUzMxlaVOzVHlwvwvs6lUNhGuElqm+NHH8DxfP1Trt
 j6pujlf1v/dwuyjgoz01Af/Q26W8RQwu9rzob4vej8EK8TY6AvVdg4MtGp0ebFFmBBUISSrw
 A0QKClhDQP+cobC0iiHo9fyL3aaDExkYSQVRbLRPvtH8dHQBPGc/QsXA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.1 -> 1.26.2
Date: Thu,  9 Apr 2026 18:54:28 +0200
Message-ID: <20260409165428.2968042-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 16:55:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3684

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.1..go1.26.2
9c8bf0e72a (tag: go1.26.2) [release-branch.go1.26] go1.26.2
096f21b1c5 [release-branch.go1.26] cmd/go: disallow cgo trust boundary bypass
7cafb4140d [release-branch.go1.26] crypto/tls: prevent deadlock when client sends multiple key update messages
a34b5e4d55 [release-branch.go1.26] archive/tar: limit the number of old GNU sparse format entries
c4b4bd7b3a [release-branch.go1.26] cmd/compile: fix loopbce overflow check logic
3a4577a268 [release-branch.go1.26] cmd/compile: fix mem access overlap detection
ceb4da6626 [release-branch.go1.26] crypto/x509: fix wildcard constraint map case sensitivity
babb1c32c2 [release-branch.go1.26] html/template: properly track JS template literal brace depth across contexts
b6176f459a [release-branch.go1.26] internal/syscall/unix: properly support AT_SYMLINK_NOFOLLOW on Linux
917949cc1d [release-branch.go1.26] net/url: permit colons in the host subcomponent of non-http/https URLs
7b4ed1d7d9 [release-branch.go1.26] crypto/x509: fix signature checking limit
8028a51430 [release-branch.go1.26] crypto/x509: hoist policy pruning out of loop
4ef278779f [release-branch.go1.26] runtime/race: apply LLVM zero-initialization fix
608303dd6e [release-branch.go1.26] cmd/link: skip special symbols for label symbol generation
e27183eff8 [release-branch.go1.26] cmd/compile: fix internal compiler error: bad write barrier type
98d4c11d8f [release-branch.go1.26] cmd/compile: treat all zero-sized values as SSA-able
cce667a91e [release-branch.go1.26] cmd/compile: handle zero-sized values more generally
3206e141fb [release-branch.go1.26] net/url: reattach package doc comment
82b95c14ec [release-branch.go1.26] cmd/compile: ternary rewrite of rewrite should skip, not panic
f14d3a8e91 [release-branch.go1.26] cmd/compile: skip race detector test failure for unsupported VMA
68f42c591d [release-branch.go1.26] cmd/compile: gate instrumentEnterExit on NoRaceFunc check
9fe1db7e7e [release-branch.go1.26] runtime: fix value of ENOSYS on mips from 38 to 89
08edcb8d3f [release-branch.go1.26] test/fixedbugs: remove issue46234 test timeout
895fbaecf5 [release-branch.go1.26] doc: remove template use in godebug.md
26548d4981 [release-branch.go1.26] cmd/fix: pull in CL 755980
12bf7d8cd2 [release-branch.go1.26] builtin: incorporate all feedback into doc string for new
943235a5e5 [release-branch.go1.26] builtin: update new function comment
1a44be4cec [release-branch.go1.26] internal/poll: move rsan to heap on windows
3bf3014fe7 [release-branch.go1.26] test/convert5: skip mipsle
e29f35511d [release-branch.go1.26] cmd/go/internal/cache: update trim timestamp before trimming
2b01132c9f [release-branch.go1.26] runtime/poll: fix race condition in Window's SendFile
ba8c3d07a7 [release-branch.go1.26] net/http: restore accidentally removed package doc
99df9bdb2a [release-branch.go1.26] net: correctly handle non-nil empty cmsg buffer on windows
ace2cf6652 [release-branch.go1.26] cmd/compile/internal/typecheck: simplify tcSliceHeader
1368bc269e [release-branch.go1.26] cmd/compile: fix bloop test
840d86c060 [release-branch.go1.26] runtime: fix printfloat, printcomplex buffer sizes

Fixes CVE-2026-32282, CVE-2026-32289, CVE-2026-33810, CVE-2026-27144,
      CVE-2026-27143, CVE-2026-32288, CVE-2026-32283, CVE-2026-27140,
      CVE-2026-32280 and CVE-2026-32281.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.1...go1.26.2
[2] https://groups.google.com/g/golang-announce/c/0uYbvbPZRWU

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.1.inc => go-1.26.2.inc}      | 2 +-
 ...binary-native_1.26.1.bb => go-binary-native_1.26.2.bb} | 6 +++---
 ...oss-canadian_1.26.1.bb => go-cross-canadian_1.26.2.bb} | 0
 .../go/{go-cross_1.26.1.bb => go-cross_1.26.2.bb}         | 0
 .../go/{go-crosssdk_1.26.1.bb => go-crosssdk_1.26.2.bb}   | 0
 .../go/{go-runtime_1.26.1.bb => go-runtime_1.26.2.bb}     | 0
 ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
 .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
 recipes-devtools/go/{go_1.26.1.bb => go_1.26.2.bb}        | 0
 9 files changed, 9 insertions(+), 9 deletions(-)
 rename recipes-devtools/go/{go-1.26.1.inc => go-1.26.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.26.1.bb => go-binary-native_1.26.2.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.1.bb => go-cross-canadian_1.26.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.1.bb => go-cross_1.26.2.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.1.bb => go-crosssdk_1.26.2.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.1.bb => go-runtime_1.26.2.bb} (100%)
 rename recipes-devtools/go/{go_1.26.1.bb => go_1.26.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.1.inc b/recipes-devtools/go/go-1.26.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.26.1.inc
rename to recipes-devtools/go/go-1.26.2.inc
index 2e3464e..8bb10bc 100644
--- a/recipes-devtools/go/go-1.26.1.inc
+++ b/recipes-devtools/go/go-1.26.2.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
 "
-SRC_URI[main.sha256sum] = "3172293d04b209dc1144698e7ba13f0477f6ba8c5ffd0be66c20fdbc9785dfbb"
+SRC_URI[main.sha256sum] = "2e91ebb6947a96e9436fb2b3926a8802efe63a6d375dffec4f82aa9dbd6fd43b"
diff --git a/recipes-devtools/go/go-binary-native_1.26.1.bb b/recipes-devtools/go/go-binary-native_1.26.2.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.26.1.bb
rename to recipes-devtools/go/go-binary-native_1.26.2.bb
index a21b415..67196d9 100644
--- a/recipes-devtools/go/go-binary-native_1.26.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.2.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a"
-SRC_URI[go_linux_arm64.sha256sum] = "a290581cfe4fe28ddd737dde3095f3dbeb7f2e4065cab4eae44dfc53b760c2f7"
-SRC_URI[go_linux_ppc64le.sha256sum] = "f56eed002998f5f51fa07fd4ed0c5de5e02d51cec7a4007f771c7576620d9d45"
+SRC_URI[go_linux_amd64.sha256sum] = "990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282"
+SRC_URI[go_linux_arm64.sha256sum] = "c958a1fe1b361391db163a485e21f5f228142d6f8b584f6bef89b26f66dc5b23"
+SRC_URI[go_linux_ppc64le.sha256sum] = "62b7645dd2404052535617c59e91cf03c7aa28e332dbaddbe4c0d7de7bcc6736"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.1.bb b/recipes-devtools/go/go-cross-canadian_1.26.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.2.bb
diff --git a/recipes-devtools/go/go-cross_1.26.1.bb b/recipes-devtools/go/go-cross_1.26.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.1.bb
rename to recipes-devtools/go/go-cross_1.26.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.1.bb b/recipes-devtools/go/go-crosssdk_1.26.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.1.bb
rename to recipes-devtools/go/go-crosssdk_1.26.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.1.bb b/recipes-devtools/go/go-runtime_1.26.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.1.bb
rename to recipes-devtools/go/go-runtime_1.26.2.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index af4243e..077bebe 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -109,7 +109,7 @@ index 7b073165d5..1f618be0bb 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2807,8 +2809,25 @@ func envList(key, def string) []string {
+@@ -2804,8 +2806,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -136,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2824,6 +2843,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+@@ -2821,6 +2840,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
  	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
@@ -150,7 +150,7 @@ index 7b073165d5..1f618be0bb 100644
  
  	return
  }
-@@ -2912,7 +2938,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+@@ -2909,7 +2935,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
  	cgoExe := base.Tool("cgo")
  	cgofiles = mkAbsFiles(p.Dir, cgofiles)
  
@@ -159,7 +159,7 @@ index 7b073165d5..1f618be0bb 100644
  	if err != nil {
  		return err
  	}
-@@ -3461,7 +3487,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3462,7 +3488,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index e2a0cd6..9aebc2f 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
  	if err := sh.Mkdir(buildAction.Objdir); err != nil {
  		return nil, err
  	}
-@@ -1891,6 +1908,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1888,6 +1905,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
diff --git a/recipes-devtools/go/go_1.26.1.bb b/recipes-devtools/go/go_1.26.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.1.bb
rename to recipes-devtools/go/go_1.26.2.bb

