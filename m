Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3BFCD6E78
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23164.1763038637500312911
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=NQh0UP5p;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202511131257158ab9f294f2000207ac-_ytxts@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202511131257158ab9f294f2000207ac
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CcYa0XM2cEB56DtZji2PkuIOTtt8GNV69Gbo0etrCpc=;
 b=NQh0UP5pC6msut8r3ZSF14GpIWrIlYet7PSP9SK8QnprenHEnq6l25bSm+9n1dm1stsb4y
 plvVanr2MCVKXpHolwP74dMIxXtLnNHJ5/q6tyBMuFItlXlZMrqSaZAftWjG7x7m89wE2ZiA
 TyBTtwnb17Sc0r0submt8moDFNXvrQgS2VRl7qFcmREy9boNFhwRmbbh1EFEmRWwwN2dSCyR
 B016wxKj0XHq0w3Hz8FZe/dkWiCDy1Yscd1r5v+6kGjOwxmqoK01/6TghlqIqCHNyBYzeE7u
 Ho+xOI2l+rujwCM+O+MEE+o/kjhsaUDSlpjsc0bmEsaZ/pfU5XbsY9oQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 13/34] go: upgrade 1.22.12 -> 1.24.0
Date: Thu, 13 Nov 2025 13:56:51 +0100
Message-Id: <20251113125712.18914-14-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2523

From: Hongxu Jia <hongxu.jia@windriver.com>

Refresh patches

See [1] for Go 1.24 Release Notes

License-Update: update per Google Legal [2]

[1] https://go.dev/doc/go1.24
[2] https://github.com/golang/go/commit/760b722c344d312ab62a5c2f94865a869ce0bab9

(From OE-Core rev: fc6625e934d9b098359103c82cdbcd0c7ce6caee)

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../go/{go-1.22.12.inc => go-1.24.0.inc}      |  4 +-
 ..._1.22.12.bb => go-binary-native_1.24.0.bb} |  8 ++--
 ...1.22.12.bb => go-cross-canadian_1.24.0.bb} |  0
 ...go-cross_1.22.12.bb => go-cross_1.24.0.bb} |  0
 ...sssdk_1.22.12.bb => go-crosssdk_1.24.0.bb} |  0
 ...untime_1.22.12.bb => go-runtime_1.24.0.bb} |  0
 ...ent-based-hash-generation-less-pedan.patch | 39 +++++++++++--------
 ...OOLDIR-to-be-overridden-in-the-envir.patch | 16 +++++---
 ...3-ld-add-soname-to-shareable-objects.patch | 15 ++++---
 ...de-CC-when-building-dist-and-go_boot.patch | 33 +++++++++-------
 ...dist-separate-host-and-target-builds.patch | 38 ++++++++++--------
 ...d-go-make-GOROOT-precious-by-default.patch | 23 ++++++-----
 ...ut-build-specific-paths-from-linker-.patch | 14 ++++---
 ...ldgo.go-do-not-hardcode-host-compile.patch | 11 ++++--
 ...uild-paths-on-staticly-linked-arches.patch | 15 ++++---
 ...5b008e3d106b2706645e5a88cd8e2fb98953.patch |  9 ++++-
 .../go/{go_1.22.12.bb => go_1.24.0.bb}        |  0
 17 files changed, 135 insertions(+), 90 deletions(-)
 rename recipes-devtools/go/{go-1.22.12.inc => go-1.24.0.inc} (82%)
 rename recipes-devtools/go/{go-binary-native_1.22.12.bb => go-binary-native_1.24.0.bb} (73%)
 rename recipes-devtools/go/{go-cross-canadian_1.22.12.bb => go-cross-canadian_1.24.0.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.22.12.bb => go-cross_1.24.0.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.22.12.bb => go-crosssdk_1.24.0.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.22.12.bb => go-runtime_1.24.0.bb} (100%)
 rename recipes-devtools/go/{go_1.22.12.bb => go_1.24.0.bb} (100%)

diff --git a/recipes-devtools/go/go-1.22.12.inc b/recipes-devtools/go/go-1.24.0.inc
similarity index 82%
rename from recipes-devtools/go/go-1.22.12.inc
rename to recipes-devtools/go/go-1.24.0.inc
index 8d14efa..26a4947 100644
--- a/recipes-devtools/go/go-1.22.12.inc
+++ b/recipes-devtools/go/go-1.24.0.inc
@@ -2,7 +2,7 @@ require go-common.inc
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/go:"
 
-LIC_FILES_CHKSUM = "file://LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
 
 SRC_URI += "\
     file://0001-cmd-go-make-content-based-hash-generation-less-pedan.patch \
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "012a7e1f37f362c0918c1dfa3334458ac2da1628c4b9cf4d9ca02db986e17d71"
+SRC_URI[main.sha256sum] = "d14120614acb29d12bcab72bd689f257eb4be9e0b6f88a8fb7e41ac65f8556e5"
diff --git a/recipes-devtools/go/go-binary-native_1.22.12.bb b/recipes-devtools/go/go-binary-native_1.24.0.bb
similarity index 73%
rename from recipes-devtools/go/go-binary-native_1.22.12.bb
rename to recipes-devtools/go/go-binary-native_1.24.0.bb
index 747737f..d9eebb9 100644
--- a/recipes-devtools/go/go-binary-native_1.22.12.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.0.bb
@@ -3,15 +3,15 @@
 SUMMARY = "Go programming language compiler (upstream binary for bootstrap)"
 HOMEPAGE = " http://golang.org/"
 LICENSE = "BSD-3-Clause"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
 
 PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "4fa4f869b0f7fc6bb1eb2660e74657fbf04cdd290b5aef905585c86051b34d43"
-SRC_URI[go_linux_arm64.sha256sum] = "fd017e647ec28525e86ae8203236e0653242722a7436929b1f775744e26278e7"
-SRC_URI[go_linux_ppc64le.sha256sum] = "9573d30003b0796717a99d9e2e96c48fddd4fc0f29d840f212c503b03d7de112"
+SRC_URI[go_linux_amd64.sha256sum] = "dea9ca38a0b852a74e81c26134671af7c0fbe65d81b0dc1c5bfe22cf7d4c8858"
+SRC_URI[go_linux_arm64.sha256sum] = "c3fa6d16ffa261091a5617145553c71d21435ce547e44cc6dfb7470865527cc7"
+SRC_URI[go_linux_ppc64le.sha256sum] = "a871a43de7d26c91dd90cb6e0adacb214c9e35ee2188c617c91c08c017efe81a"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.22.12.bb b/recipes-devtools/go/go-cross-canadian_1.24.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.22.12.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.0.bb
diff --git a/recipes-devtools/go/go-cross_1.22.12.bb b/recipes-devtools/go/go-cross_1.24.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.22.12.bb
rename to recipes-devtools/go/go-cross_1.24.0.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.22.12.bb b/recipes-devtools/go/go-crosssdk_1.24.0.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.22.12.bb
rename to recipes-devtools/go/go-crosssdk_1.24.0.bb
diff --git a/recipes-devtools/go/go-runtime_1.22.12.bb b/recipes-devtools/go/go-runtime_1.24.0.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.22.12.bb
rename to recipes-devtools/go/go-runtime_1.24.0.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index a8e5d6e..86e941b 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -1,7 +1,8 @@
-From 9b3ebef0356594a447906f00fe80584952c08289 Mon Sep 17 00:00:00 2001
+From 51c04a9a19dec5a48fa0f38324dc2480b7a859e4 Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
-Date: Mon, 28 Mar 2022 10:59:03 -0700
-Subject: [PATCH] cmd/go: make content-based hash generation less pedantic
+Date: Sat, 22 Feb 2025 03:24:48 -0800
+Subject: [PATCH 01/11] cmd/go: make content-based hash generation less
+ pedantic
 
 Go 1.10's build tool now uses content-based hashes to
 determine when something should be built or re-built.
@@ -26,16 +27,19 @@ Signed-off-by: Alex Kube <alexander.j.kube@gmail.com>
 Signed-off-by: Matt Madison <matt@madison.systems>
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
 Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.23.4
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  src/cmd/go/internal/envcmd/env.go |  2 +-
  src/cmd/go/internal/work/exec.go  | 44 ++++++++++++++++++++++++-------
  2 files changed, 36 insertions(+), 10 deletions(-)
 
 diff --git a/src/cmd/go/internal/envcmd/env.go b/src/cmd/go/internal/envcmd/env.go
-index c7c2e83..4a90d9d 100644
+index 7c370d427f..c2441f7695 100644
 --- a/src/cmd/go/internal/envcmd/env.go
 +++ b/src/cmd/go/internal/envcmd/env.go
-@@ -189,7 +189,7 @@ func ExtraEnvVarsCostly() []cfg.EnvVar {
+@@ -219,7 +219,7 @@ func ExtraEnvVarsCostly() []cfg.EnvVar {
  		}
  	}()
  
@@ -45,10 +49,10 @@ index c7c2e83..4a90d9d 100644
  		// Should not happen - b.CFlags was given an empty package.
  		fmt.Fprintf(os.Stderr, "go: invalid cflags: %v\n", err)
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index e05471b..9724cd0 100644
+index 7b073165d5..1f618be0bb 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -232,6 +232,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
+@@ -237,6 +237,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
  	writeActionGraph()
  }
  
@@ -57,7 +61,7 @@ index e05471b..9724cd0 100644
  // buildActionID computes the action ID for a build action.
  func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	p := a.Package
-@@ -253,7 +255,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -258,7 +260,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		if p.Module != nil {
  			fmt.Fprintf(h, "module %s@%s\n", p.Module.Path, p.Module.Version)
  		}
@@ -66,7 +70,7 @@ index e05471b..9724cd0 100644
  		// The Go compiler always hides the exact value of $GOROOT
  		// when building things in GOROOT.
  		//
-@@ -285,9 +287,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -293,9 +295,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	}
  	if len(p.CgoFiles)+len(p.SwigFiles)+len(p.SwigCXXFiles) > 0 {
  		fmt.Fprintf(h, "cgo %q\n", b.toolID("cgo"))
@@ -78,7 +82,7 @@ index e05471b..9724cd0 100644
  		fmt.Fprintf(h, "CC=%q %q %q %q\n", ccExe, cppflags, cflags, ldflags)
  		// Include the C compiler tool ID so that if the C
  		// compiler changes we rebuild the package.
-@@ -295,14 +297,14 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -303,14 +305,14 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			fmt.Fprintf(h, "CC ID=%q\n", ccID)
  		}
  		if len(p.CXXFiles)+len(p.SwigCXXFiles) > 0 {
@@ -95,7 +99,7 @@ index e05471b..9724cd0 100644
  			fmt.Fprintf(h, "FC=%q %q\n", fcExe, fflags)
  			if fcID, _, err := b.gccToolID(fcExe[0], "f95"); err == nil {
  				fmt.Fprintf(h, "FC ID=%q\n", fcID)
-@@ -319,7 +321,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -327,7 +329,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		}
  	}
  	if p.Internal.BuildInfo != nil {
@@ -104,7 +108,7 @@ index e05471b..9724cd0 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2679,8 +2681,25 @@ func envList(key, def string) []string {
+@@ -2659,8 +2661,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -131,8 +135,8 @@ index e05471b..9724cd0 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2696,6 +2715,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
- 	if ldflags, err = buildFlags("LDFLAGS", defaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
+@@ -2676,6 +2695,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+ 	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
 +	if filtered {
@@ -145,7 +149,7 @@ index e05471b..9724cd0 100644
  
  	return
  }
-@@ -2713,7 +2739,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir string, pcCFLAGS, pcLDFLAGS, cgo
+@@ -2693,7 +2719,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir string, pcCFLAGS, pcLDFLAGS, cgo
  	p := a.Package
  	sh := b.Shell(a)
  
@@ -154,7 +158,7 @@ index e05471b..9724cd0 100644
  	if err != nil {
  		return nil, nil, err
  	}
-@@ -3268,7 +3294,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3256,7 +3282,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
@@ -163,3 +167,6 @@ index e05471b..9724cd0 100644
  	if err != nil {
  		return "", "", err
  	}
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
index a69ada4..7e86d8c 100644
--- a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
+++ b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
@@ -1,7 +1,8 @@
-From 687ff9d17f756145f9a58413070cccbd488d1ea2 Mon Sep 17 00:00:00 2001
+From fdad9a0ea659cf2281a0df16b0f69f179605ec9a Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:15:37 +0430
-Subject: [PATCH] cmd/go: Allow GOTOOLDIR to be overridden in the environment
+Subject: [PATCH 02/11] cmd/go: Allow GOTOOLDIR to be overridden in the
+ environment
 
 to allow for split host/target build roots
 
@@ -19,10 +20,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  2 files changed, 8 insertions(+), 2 deletions(-)
 
 diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
-index 32e59b4..06ee4de 100644
+index 1f467647f5..b62e518030 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -259,7 +259,9 @@ func xinit() {
+@@ -280,7 +280,9 @@ func xinit() {
  	}
  	xatexit(rmworkdir)
  
@@ -34,10 +35,10 @@ index 32e59b4..06ee4de 100644
  	goversion := findgoversion()
  	isRelease = strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")
 diff --git a/src/cmd/go/internal/cfg/cfg.go b/src/cmd/go/internal/cfg/cfg.go
-index a8daa2d..393ada3 100644
+index 3b9f27e91d..ec043c1530 100644
 --- a/src/cmd/go/internal/cfg/cfg.go
 +++ b/src/cmd/go/internal/cfg/cfg.go
-@@ -230,7 +230,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
+@@ -248,7 +248,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
  			// This matches the initialization of ToolDir in go/build, except for
  			// using ctxt.GOROOT and the installed GOOS and GOARCH rather than the
  			// GOROOT, GOOS, and GOARCH reported by the runtime package.
@@ -50,3 +51,6 @@ index a8daa2d..393ada3 100644
  		}
  	}
  }
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
index abc5faa..86a4bb1 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -1,7 +1,7 @@
-From 01fe178b292db12d811811ff2d8d56b225e4b5e8 Mon Sep 17 00:00:00 2001
+From 1546d837c69b654754ee137af1fa1c2f7500cfa2 Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:16:32 +0430
-Subject: [PATCH] ld: add soname to shareable objects
+Subject: [PATCH 03/11] ld: add soname to shareable objects
 
 so that OE's shared library dependency handling
 can find them.
@@ -19,10 +19,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 3 insertions(+)
 
 diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
-index eab74dc..ae9bbc9 100644
+index 2d8f964f35..dfc72e02c0 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1576,6 +1576,7 @@ func (ctxt *Link) hostlink() {
+@@ -1624,6 +1624,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -30,7 +30,7 @@ index eab74dc..ae9bbc9 100644
  			if ctxt.HeadType == objabi.Hwindows {
  				argv = addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1591,6 +1592,7 @@ func (ctxt *Link) hostlink() {
+@@ -1639,6 +1640,7 @@ func (ctxt *Link) hostlink() {
  			argv = append(argv, "-Wl,-z,relro")
  		}
  		argv = append(argv, "-shared")
@@ -38,7 +38,7 @@ index eab74dc..ae9bbc9 100644
  	case BuildModePlugin:
  		if ctxt.HeadType == objabi.Hdarwin {
  			argv = append(argv, "-dynamiclib")
-@@ -1599,6 +1601,7 @@ func (ctxt *Link) hostlink() {
+@@ -1647,6 +1649,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -46,3 +46,6 @@ index eab74dc..ae9bbc9 100644
  		}
  	}
  
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
index 9df43c4..abbb7bd 100644
--- a/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
+++ b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
@@ -1,7 +1,8 @@
-From e47d157631d1b97403f253c63d361b7380b32c22 Mon Sep 17 00:00:00 2001
+From b41aaa851f0074682fcd4bf07c891fbdf0fdf70c Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
-Date: Wed, 23 Oct 2019 21:17:16 +0430
-Subject: [PATCH] make.bash: override CC when building dist and go_bootstrap
+Date: Sat, 22 Feb 2025 03:14:37 -0800
+Subject: [PATCH 04/11] make.bash: override CC when building dist and
+ go_bootstrap
 
 for handling OE cross-canadian builds.
 
@@ -13,24 +14,27 @@ Upstream-Status: Inappropriate [OE specific]
 
 Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
 Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.23.4
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  src/make.bash | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/src/make.bash b/src/make.bash
-index 76ad516..074e129 100755
+index b67ae1529f..b59cdabd09 100755
 --- a/src/make.bash
 +++ b/src/make.bash
-@@ -198,7 +198,7 @@ if [[ "$GOROOT_BOOTSTRAP" == "$GOROOT" ]]; then
- 	exit 1
- fi
- rm -f cmd/dist/dist
--GOROOT="$GOROOT_BOOTSTRAP" nogoenv "$GOROOT_BOOTSTRAP/bin/go" build -o cmd/dist/dist ./cmd/dist
-+CC="${BUILD_CC:-${CC}}" GOROOT="$GOROOT_BOOTSTRAP" nogoenv "$GOROOT_BOOTSTRAP/bin/go" build -o cmd/dist/dist ./cmd/dist
+@@ -153,7 +153,7 @@ fi
+ export GOROOT_BOOTSTRAP
  
- # -e doesn't propagate out of eval, so check success by hand.
- eval $(./cmd/dist/dist env -p || echo FAIL=true)
-@@ -223,7 +223,7 @@ fi
+ bootstrapenv() {
+-	GOROOT="$GOROOT_BOOTSTRAP" GO111MODULE=off GOENV=off GOOS= GOARCH= GOEXPERIMENT= GOFLAGS= "$@"
++	CC="${BUILD_CC:-${CC}}" GOROOT="$GOROOT_BOOTSTRAP" GO111MODULE=off GOENV=off GOOS= GOARCH= GOEXPERIMENT= GOFLAGS= "$@"
+ }
+ 
+ export GOROOT="$(cd .. && pwd)"
+@@ -216,7 +216,7 @@ fi
  # Run dist bootstrap to complete make.bash.
  # Bootstrap installs a proper cmd/dist, built with the new toolchain.
  # Throw ours, built with the bootstrap toolchain, away after bootstrap.
@@ -39,3 +43,6 @@ index 76ad516..074e129 100755
  rm -f ./cmd/dist/dist
  
  # DO NOT ADD ANY NEW CODE HERE.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
index bc25d08..f7c3108 100644
--- a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
+++ b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
@@ -1,7 +1,7 @@
-From bae1cec790ff17c4c93a2f8fda27036e5e021f6d Mon Sep 17 00:00:00 2001
+From 12bf824f8b7e85f05434aa00e866e883a551aaeb Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
-Date: Wed, 23 Oct 2019 21:18:12 +0430
-Subject: [PATCH] cmd/dist: separate host and target builds
+Date: Fri, 28 Feb 2025 19:09:17 -0800
+Subject: [PATCH 05/11] cmd/dist: separate host and target builds
 
 Change the dist tool to allow for OE-style cross-
 and cross-canadian builds:
@@ -40,23 +40,26 @@ Upstream-Status: Inappropriate [OE specific]
 
 Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
 Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.24.0
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  src/cmd/dist/build.go | 76 ++++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 75 insertions(+), 1 deletion(-)
 
 diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
-index 06ee4de..016b1dd 100644
+index b62e518030..0c54d82300 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -46,6 +46,7 @@ var (
- 	goexperiment     string
+@@ -49,6 +49,7 @@ var (
+ 	gofips140        string
  	workdir          string
  	tooldir          string
 +	build_tooldir    string
  	oldgoos          string
  	oldgoarch        string
  	oldgocache       string
-@@ -58,6 +59,7 @@ var (
+@@ -61,6 +62,7 @@ var (
  	rebuildall bool
  	noOpt      bool
  	isRelease  bool
@@ -64,7 +67,7 @@ index 06ee4de..016b1dd 100644
  
  	vflag int // verbosity
  )
-@@ -265,6 +267,8 @@ func xinit() {
+@@ -286,6 +288,8 @@ func xinit() {
  
  	goversion := findgoversion()
  	isRelease = strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")
@@ -73,7 +76,7 @@ index 06ee4de..016b1dd 100644
  }
  
  // compilerEnv returns a map from "goos/goarch" to the
-@@ -499,8 +503,10 @@ func setup() {
+@@ -547,8 +551,10 @@ func setup() {
  	goosGoarch := pathf("%s/pkg/%s_%s", goroot, gohostos, gohostarch)
  	if rebuildall {
  		xremoveall(goosGoarch)
@@ -84,7 +87,7 @@ index 06ee4de..016b1dd 100644
  	xatexit(func() {
  		if files := xreaddir(goosGoarch); len(files) == 0 {
  			xremove(goosGoarch)
-@@ -1338,14 +1344,20 @@ func cmdbootstrap() {
+@@ -1411,14 +1417,20 @@ func cmdbootstrap() {
  	defer timelog("end", "dist bootstrap")
  
  	var debug, distpack, force, noBanner, noClean bool
@@ -106,7 +109,7 @@ index 06ee4de..016b1dd 100644
  
  	if noClean {
  		xprintf("warning: --no-clean is deprecated and has no effect; use 'go install std cmd' instead\n")
-@@ -1357,6 +1369,18 @@ func cmdbootstrap() {
+@@ -1430,6 +1442,18 @@ func cmdbootstrap() {
  			"Use the -force flag to build anyway.\n", goos, goarch)
  	}
  
@@ -125,7 +128,7 @@ index 06ee4de..016b1dd 100644
  	// Set GOPATH to an internal directory. We shouldn't actually
  	// need to store files here, since the toolchain won't
  	// depend on modules outside of vendor directories, but if
-@@ -1434,9 +1458,14 @@ func cmdbootstrap() {
+@@ -1513,9 +1537,14 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  
@@ -140,7 +143,7 @@ index 06ee4de..016b1dd 100644
  	goBootstrap := pathf("%s/go_bootstrap", tooldir)
  	if debug {
  		run("", ShowOutput|CheckExit, pathf("%s/compile", tooldir), "-V=full")
-@@ -1464,7 +1493,11 @@ func cmdbootstrap() {
+@@ -1543,7 +1572,11 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  	xprintf("Building Go toolchain2 using go_bootstrap and Go toolchain1.\n")
@@ -152,7 +155,7 @@ index 06ee4de..016b1dd 100644
  	// Now that cmd/go is in charge of the build process, enable GOEXPERIMENT.
  	os.Setenv("GOEXPERIMENT", goexperiment)
  	// No need to enable PGO for toolchain2.
-@@ -1517,6 +1550,7 @@ func cmdbootstrap() {
+@@ -1596,6 +1629,7 @@ func cmdbootstrap() {
  		os.Setenv("GOCACHE", oldgocache)
  	}
  
@@ -160,7 +163,7 @@ index 06ee4de..016b1dd 100644
  	if goos == oldgoos && goarch == oldgoarch {
  		// Common case - not setting up for cross-compilation.
  		timelog("build", "toolchain")
-@@ -1560,6 +1594,42 @@ func cmdbootstrap() {
+@@ -1639,6 +1673,42 @@ func cmdbootstrap() {
  		checkNotStale(toolenv(), goBootstrap, toolchain...)
  		copyfile(pathf("%s/compile4", tooldir), pathf("%s/compile", tooldir), writeExec)
  	}
@@ -203,7 +206,7 @@ index 06ee4de..016b1dd 100644
  
  	// Check that there are no new files in $GOROOT/bin other than
  	// go and gofmt and $GOOS_$GOARCH (target bin when cross-compiling).
-@@ -1582,8 +1652,12 @@ func cmdbootstrap() {
+@@ -1661,8 +1731,12 @@ func cmdbootstrap() {
  		}
  	}
  
@@ -216,3 +219,6 @@ index 06ee4de..016b1dd 100644
  
  	if goos == "android" {
  		// Make sure the exec wrapper will sync a fresh $GOROOT to the device.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index 4a57b07..b29da33 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -1,7 +1,7 @@
-From a31db6f78d851741aea1e76132a84a24138a5bc6 Mon Sep 17 00:00:00 2001
+From ba3caa9f969bac2b937f8f1ffed4a3679cd16ec7 Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:18:56 +0430
-Subject: [PATCH] cmd/go: make GOROOT precious by default
+Subject: [PATCH 06/11] cmd/go: make GOROOT precious by default
 
 The go build tool normally rebuilds whatever it detects is
 stale.  This can be a problem when GOROOT is intended to
@@ -29,10 +29,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  3 files changed, 34 insertions(+)
 
 diff --git a/src/cmd/go/internal/work/action.go b/src/cmd/go/internal/work/action.go
-index a59072e..9e35ebd 100644
+index 44bb9f8c1e..87ac4e30e5 100644
 --- a/src/cmd/go/internal/work/action.go
 +++ b/src/cmd/go/internal/work/action.go
-@@ -754,6 +754,9 @@ func (b *Builder) addTransitiveLinkDeps(a, a1 *Action, shlib string) {
+@@ -837,6 +837,9 @@ func (b *Builder) addTransitiveLinkDeps(a, a1 *Action, shlib string) {
  			if p1 == nil || p1.Shlib == "" || haveShlib[filepath.Base(p1.Shlib)] {
  				continue
  			}
@@ -43,10 +43,10 @@ index a59072e..9e35ebd 100644
  			// TODO(rsc): The use of ModeInstall here is suspect, but if we only do ModeBuild,
  			// we'll end up building an overall library or executable that depends at runtime
 diff --git a/src/cmd/go/internal/work/build.go b/src/cmd/go/internal/work/build.go
-index 408edb5..3d60252 100644
+index 3508d51fbb..77f5e7241a 100644
 --- a/src/cmd/go/internal/work/build.go
 +++ b/src/cmd/go/internal/work/build.go
-@@ -233,6 +233,8 @@ See also: go install, go get, go clean.
+@@ -238,6 +238,8 @@ See also: go install, go get, go clean.
  
  const concurrentGCBackendCompilationEnabledByDefault = true
  
@@ -55,7 +55,7 @@ index 408edb5..3d60252 100644
  func init() {
  	// break init cycle
  	CmdBuild.Run = runBuild
-@@ -246,6 +248,10 @@ func init() {
+@@ -251,6 +253,10 @@ func init() {
  		AddCoverFlags(CmdBuild, nil)
  		AddCoverFlags(CmdInstall, nil)
  	}
@@ -67,10 +67,10 @@ index 408edb5..3d60252 100644
  
  // Note that flags consulted by other parts of the code
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index 9724cd0..544df46 100644
+index 1f618be0bb..651fa64582 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -544,6 +544,23 @@ func (b *Builder) build(ctx context.Context, a *Action) (err error) {
+@@ -552,6 +552,23 @@ func (b *Builder) build(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
@@ -94,7 +94,7 @@ index 9724cd0..544df46 100644
  	if err := sh.Mkdir(a.Objdir); err != nil {
  		return err
  	}
-@@ -1737,6 +1754,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1747,6 +1764,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
@@ -109,3 +109,6 @@ index 9724cd0..544df46 100644
  	if err := b.Shell(a).Mkdir(a.Objdir); err != nil {
  		return err
  	}
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index 2fdd529..9a701c7 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -1,7 +1,8 @@
-From 1097a07b097043e15fe29a85326dbd196401244a Mon Sep 17 00:00:00 2001
+From 2197f813c9cff65eedef44473872ec5ea9ced227 Mon Sep 17 00:00:00 2001
 From: Changqing Li <changqing.li@windriver.com>
 Date: Tue, 27 Feb 2024 18:06:51 +0800
-Subject: [PATCH] exec.go: filter out build-specific paths from linker flags
+Subject: [PATCH 07/11] exec.go: filter out build-specific paths from linker
+ flags
 
 The flags can contain build-specific paths, breaking reproducibility.
 Filter out options that have build-specific paths.
@@ -15,10 +16,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 24 insertions(+), 1 deletion(-)
 
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index 544df46..c8f297c 100644
+index 651fa64582..586079afb4 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1401,6 +1401,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1426,6 +1426,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -48,7 +49,7 @@ index 544df46..c8f297c 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1411,7 +1434,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1436,7 +1459,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
@@ -57,3 +58,6 @@ index 544df46..c8f297c 100644
  		}
  
  		// GOARM, GOMIPS, etc.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
index 4c1f0ca..a9cb2a4 100644
--- a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
+++ b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
@@ -1,8 +1,8 @@
-From e5af6155f2d6e0758d11d6c12d6f47ea8e65b141 Mon Sep 17 00:00:00 2001
+From e5752b239707df8ad7a72dc60420e01c5912d606 Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex.kanavin@gmail.com>
 Date: Tue, 10 Nov 2020 16:33:27 +0000
-Subject: [PATCH] src/cmd/dist/buildgo.go: do not hardcode host compilers into
- target binaries
+Subject: [PATCH 08/11] src/cmd/dist/buildgo.go: do not hardcode host compilers
+ into target binaries
 
 These come from $CC/$CXX on the build host and are not useful on targets;
 additionally as they contain host specific paths, this helps reproducibility.
@@ -16,7 +16,7 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 4 insertions(+), 4 deletions(-)
 
 diff --git a/src/cmd/dist/buildgo.go b/src/cmd/dist/buildgo.go
-index 884e9d7..2f52eda 100644
+index 884e9d729a..2f52edacfe 100644
 --- a/src/cmd/dist/buildgo.go
 +++ b/src/cmd/dist/buildgo.go
 @@ -51,8 +51,8 @@ func mkzdefaultcc(dir, file string) {
@@ -41,3 +41,6 @@ index 884e9d7..2f52eda 100644
  	writefile(buf.String(), file, writeSkipSame)
  }
  
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
index d939cb4..d47c4b1 100644
--- a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
+++ b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
@@ -1,7 +1,7 @@
-From 6bdd6405ce63c7aa4b35cd85833d03c7f1b9109a Mon Sep 17 00:00:00 2001
+From 79a1c80ed43f2a541bcab665656a4e2bb87baab3 Mon Sep 17 00:00:00 2001
 From: Richard Purdie <richard.purdie@linuxfoundation.org>
 Date: Sat, 2 Jul 2022 23:08:13 +0100
-Subject: [PATCH] go: Filter build paths on staticly linked arches
+Subject: [PATCH 09/11] go: Filter build paths on staticly linked arches
 
 Filter out build time paths from ldflags and other flags variables when they're
 embedded in the go binary so that builds are reproducible regardless of build
@@ -17,10 +17,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 13 insertions(+), 2 deletions(-)
 
 diff --git a/src/cmd/go/internal/load/pkg.go b/src/cmd/go/internal/load/pkg.go
-index 1549800..f41fb2c 100644
+index 15f6b2e87b..47c5b865a1 100644
 --- a/src/cmd/go/internal/load/pkg.go
 +++ b/src/cmd/go/internal/load/pkg.go
-@@ -2277,6 +2277,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
+@@ -2291,6 +2291,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
  	info.Settings = append(info.Settings, debug.BuildSetting{Key: key, Value: value})
  }
  
@@ -38,7 +38,7 @@ index 1549800..f41fb2c 100644
  // setBuildInfo gathers build information and sets it into
  // p.Internal.BuildInfo, which will later be formatted as a string and embedded
  // in the binary. setBuildInfo should only be called on a main package with no
-@@ -2384,7 +2395,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2398,7 +2409,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
  	if gcflags := BuildGcflags.String(); gcflags != "" && cfg.BuildContext.Compiler == "gc" {
  		appendSetting("-gcflags", gcflags)
  	}
@@ -47,7 +47,7 @@ index 1549800..f41fb2c 100644
  		// https://go.dev/issue/52372: only include ldflags if -trimpath is not set,
  		// since it can include system paths through various linker flags (notably
  		// -extar, -extld, and -extldflags).
-@@ -2427,7 +2438,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2444,7 +2455,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
  	// subset of flags that are known not to be paths?
  	if cfg.BuildContext.CgoEnabled && !cfg.BuildTrimpath {
  		for _, name := range []string{"CGO_CFLAGS", "CGO_CPPFLAGS", "CGO_CXXFLAGS", "CGO_LDFLAGS"} {
@@ -56,3 +56,6 @@ index 1549800..f41fb2c 100644
  		}
  	}
  	appendSetting("GOARCH", cfg.BuildContext.GOARCH)
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch b/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
index d858cc6..58bd00f 100644
--- a/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
+++ b/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
@@ -14,12 +14,14 @@ Change-Id: I9f377e47c22ef20497479c0978c053ed5de46a38
 
 Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/391115]
 ---
+ src/cmd/link/internal/ld/lib.go | 21 ---------------------
+ 1 file changed, 21 deletions(-)
 
 diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
-index 2d8f964..fcf0bc7 100644
+index dfc72e02c0..2a2a304113 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1670,27 +1670,6 @@
+@@ -1673,27 +1673,6 @@ func (ctxt *Link) hostlink() {
  			// Use lld to avoid errors from default linker (issue #38838)
  			altLinker = "lld"
  		}
@@ -47,3 +49,6 @@ index 2d8f964..fcf0bc7 100644
  	}
  	if ctxt.Arch.Family == sys.ARM64 && buildcfg.GOOS == "freebsd" {
  		// Switch to ld.bfd on freebsd/arm64.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go_1.22.12.bb b/recipes-devtools/go/go_1.24.0.bb
similarity index 100%
rename from recipes-devtools/go/go_1.22.12.bb
rename to recipes-devtools/go/go_1.24.0.bb

