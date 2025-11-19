Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0199CF396A
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9151.1763564756836769542
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=dmGLA1/h;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202511191505557e3457b3cd00020778-a9emof@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202511191505557e3457b3cd00020778
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vsYsOITiOkKkxpOm1l0TxCkSZsw4JYxDWRAIozDILR8=;
 b=dmGLA1/hafCV/FyyZXPp256Mlg1hump2J3TbpeB2fBbdj8f3IYscpPPA+S/392kTUkQ0KY
 S1Rfu++GALlMUgLNPaKxu4LRu2WVTP8VnwlQdfm09ZIoK4xCkaqttFZmTpmRbBFQBIAwPfin
 dgjxbv2bBxXyZlsnPtH22m5vBH2i+2aUCQ7Q/sqj0hJPlNG5J5h18KshuIiiFG5DdSR4Sngf
 gzKwtpvV4mjJdB0SFgp3UaaaNwb0Sq5JVwP6Et4W43VNFwT98C1tVZIJC27uL9NhgqfQGXkw
 vXJFje8V+9RV0bcV+JTxzAFdIPaGyEdAK1waZpHsRwKU4qat/l/LZHfg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 27/35] go: upgrade 1.24.6 -> 1.25.0
Date: Wed, 19 Nov 2025 16:05:14 +0100
Message-Id: <20251119150522.15477-28-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2619

From: Peter Marko <peter.marko@siemens.com>

Release Announcement: [1]
Release notes: [2]
Refreshes all patches.

[1] https://groups.google.com/g/golang-announce/c/BVrdugXW05c
[2] https://go.dev/doc/go1.25

(From OE-Core rev: 89770e94434253f1b08cea542cd7bb0d553dac09)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../go/{go-1.24.6.inc => go-1.25.0.inc}       |  4 +--
 ...e_1.24.6.bb => go-binary-native_1.25.0.bb} |  6 ++---
 ..._1.24.6.bb => go-cross-canadian_1.25.0.bb} |  0
 ...{go-cross_1.24.6.bb => go-cross_1.25.0.bb} |  0
 ...osssdk_1.24.6.bb => go-crosssdk_1.25.0.bb} |  0
 ...runtime_1.24.6.bb => go-runtime_1.25.0.bb} |  0
 ...ent-based-hash-generation-less-pedan.patch | 15 ++++++-----
 ...OOLDIR-to-be-overridden-in-the-envir.patch |  6 ++---
 ...3-ld-add-soname-to-shareable-objects.patch |  6 ++---
 ...dist-separate-host-and-target-builds.patch | 26 +++++++++----------
 ...d-go-make-GOROOT-precious-by-default.patch | 16 ++++++------
 ...ut-build-specific-paths-from-linker-.patch |  4 +--
 ...ldgo.go-do-not-hardcode-host-compile.patch |  4 +--
 ...uild-paths-on-staticly-linked-arches.patch |  6 ++---
 ...OOT-for-func-ldShared-when-trimpath-.patch | 11 ++++----
 ...cing-binutils-gold-dependency-on-aa.patch} |  5 ++--
 .../go/{go_1.24.6.bb => go_1.25.0.bb}         |  0
 17 files changed, 55 insertions(+), 54 deletions(-)
 rename recipes-devtools/go/{go-1.24.6.inc => go-1.25.0.inc} (83%)
 rename recipes-devtools/go/{go-binary-native_1.24.6.bb => go-binary-native_1.25.0.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.6.bb => go-cross-canadian_1.25.0.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.6.bb => go-cross_1.25.0.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.6.bb => go-crosssdk_1.25.0.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.6.bb => go-runtime_1.25.0.bb} (100%)
 rename recipes-devtools/go/go/{6d265b008e3d106b2706645e5a88cd8e2fb98953.patch => 0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch} (93%)
 rename recipes-devtools/go/{go_1.24.6.bb => go_1.25.0.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.6.inc b/recipes-devtools/go/go-1.25.0.inc
similarity index 83%
rename from recipes-devtools/go/go-1.24.6.inc
rename to recipes-devtools/go/go-1.25.0.inc
index a3933c2..f562fbb 100644
--- a/recipes-devtools/go/go-1.24.6.inc
+++ b/recipes-devtools/go/go-1.25.0.inc
@@ -15,6 +15,6 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
-    file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
+    file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
 "
-SRC_URI[main.sha256sum] = "e1cb5582aab588668bc04c07de18688070f6b8c9b2aaf361f821e19bd47cfdbd"
+SRC_URI[main.sha256sum] = "4bd01e91297207bfa450ea40d4d5a93b1b531a5e438473b2a06e18e077227225"
diff --git a/recipes-devtools/go/go-binary-native_1.24.6.bb b/recipes-devtools/go/go-binary-native_1.25.0.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.24.6.bb
rename to recipes-devtools/go/go-binary-native_1.25.0.bb
index 86a3ad8..8e61787 100644
--- a/recipes-devtools/go/go-binary-native_1.24.6.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.0.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "bbca37cc395c974ffa4893ee35819ad23ebb27426df87af92e93a9ec66ef8712"
-SRC_URI[go_linux_arm64.sha256sum] = "124ea6033a8bf98aa9fbab53e58d134905262d45a022af3a90b73320f3c3afd5"
-SRC_URI[go_linux_ppc64le.sha256sum] = "63fc9559a3d6dfd63aa902f714375b879bbc848466181c035c122489b9646e27"
+SRC_URI[go_linux_amd64.sha256sum] = "2852af0cb20a13139b3448992e69b868e50ed0f8a1e5940ee1de9e19a123b613"
+SRC_URI[go_linux_arm64.sha256sum] = "05de75d6994a2783699815ee553bd5a9327d8b79991de36e38b66862782f54ae"
+SRC_URI[go_linux_ppc64le.sha256sum] = "0f18a89e7576cf2c5fa0b487a1635d9bcbf843df5f110e9982c64df52a983ad0"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.6.bb b/recipes-devtools/go/go-cross-canadian_1.25.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.6.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.0.bb
diff --git a/recipes-devtools/go/go-cross_1.24.6.bb b/recipes-devtools/go/go-cross_1.25.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.6.bb
rename to recipes-devtools/go/go-cross_1.25.0.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.6.bb b/recipes-devtools/go/go-crosssdk_1.25.0.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.6.bb
rename to recipes-devtools/go/go-crosssdk_1.25.0.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.6.bb b/recipes-devtools/go/go-runtime_1.25.0.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.6.bb
rename to recipes-devtools/go/go-runtime_1.25.0.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index 86e941b..b55ad1e 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -82,8 +82,8 @@ index 7b073165d5..1f618be0bb 100644
  		fmt.Fprintf(h, "CC=%q %q %q %q\n", ccExe, cppflags, cflags, ldflags)
  		// Include the C compiler tool ID so that if the C
  		// compiler changes we rebuild the package.
-@@ -303,14 +305,14 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
- 			fmt.Fprintf(h, "CC ID=%q\n", ccID)
+@@ -305,7 +307,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 			fmt.Fprintf(h, "CC ID ERROR=%q\n", err)
  		}
  		if len(p.CXXFiles)+len(p.SwigCXXFiles) > 0 {
 -			cxxExe := b.cxxExe()
@@ -91,6 +91,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "CXX=%q %q\n", cxxExe, cxxflags)
  			if cxxID, _, err := b.gccToolID(cxxExe[0], "c++"); err == nil {
  				fmt.Fprintf(h, "CXX ID=%q\n", cxxID)
+@@ -314,7 +316,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			}
  		}
  		if len(p.FFiles) > 0 {
@@ -99,7 +100,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "FC=%q %q\n", fcExe, fflags)
  			if fcID, _, err := b.gccToolID(fcExe[0], "f95"); err == nil {
  				fmt.Fprintf(h, "FC ID=%q\n", fcID)
-@@ -327,7 +329,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -333,7 +335,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		}
  	}
  	if p.Internal.BuildInfo != nil {
@@ -108,7 +109,7 @@ index 7b073165d5..1f618be0bb 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2659,8 +2661,25 @@ func envList(key, def string) []string {
+@@ -2631,8 +2633,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -135,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2676,6 +2695,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+@@ -2648,6 +2667,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
  	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
@@ -149,7 +150,7 @@ index 7b073165d5..1f618be0bb 100644
  
  	return
  }
-@@ -2693,7 +2719,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir string, pcCFLAGS, pcLDFLAGS, cgo
+@@ -2665,7 +2691,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir string, pcCFLAGS, pcLDFLAGS, cgo
  	p := a.Package
  	sh := b.Shell(a)
  
@@ -158,7 +159,7 @@ index 7b073165d5..1f618be0bb 100644
  	if err != nil {
  		return nil, nil, err
  	}
-@@ -3256,7 +3282,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3229,7 +3255,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
diff --git a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
index 7e86d8c..f6767d0 100644
--- a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
+++ b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
@@ -23,7 +23,7 @@ diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
 index 1f467647f5..b62e518030 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -280,7 +280,9 @@ func xinit() {
+@@ -271,7 +271,9 @@ func xinit() {
  	}
  	xatexit(rmworkdir)
  
@@ -33,12 +33,12 @@ index 1f467647f5..b62e518030 100644
 +	}
  
  	goversion := findgoversion()
- 	isRelease = strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")
+ 	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
 diff --git a/src/cmd/go/internal/cfg/cfg.go b/src/cmd/go/internal/cfg/cfg.go
 index 3b9f27e91d..ec043c1530 100644
 --- a/src/cmd/go/internal/cfg/cfg.go
 +++ b/src/cmd/go/internal/cfg/cfg.go
-@@ -248,7 +248,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
+@@ -279,7 +279,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
  			// This matches the initialization of ToolDir in go/build, except for
  			// using ctxt.GOROOT and the installed GOOS and GOARCH rather than the
  			// GOROOT, GOOS, and GOARCH reported by the runtime package.
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
index 86a4bb1..14ed617 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
 index 2d8f964f35..dfc72e02c0 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1624,6 +1624,7 @@ func (ctxt *Link) hostlink() {
+@@ -1628,6 +1628,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -30,7 +30,7 @@ index 2d8f964f35..dfc72e02c0 100644
  			if ctxt.HeadType == objabi.Hwindows {
  				argv = addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1639,6 +1640,7 @@ func (ctxt *Link) hostlink() {
+@@ -1643,6 +1644,7 @@ func (ctxt *Link) hostlink() {
  			argv = append(argv, "-Wl,-z,relro")
  		}
  		argv = append(argv, "-shared")
@@ -38,7 +38,7 @@ index 2d8f964f35..dfc72e02c0 100644
  	case BuildModePlugin:
  		if ctxt.HeadType == objabi.Hdarwin {
  			argv = append(argv, "-dynamiclib")
-@@ -1647,6 +1649,7 @@ func (ctxt *Link) hostlink() {
+@@ -1651,6 +1653,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
diff --git a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
index f7c3108..42bfa8e 100644
--- a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
+++ b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
@@ -51,7 +51,7 @@ diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
 index b62e518030..0c54d82300 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -49,6 +49,7 @@ var (
+@@ -50,6 +50,7 @@ var (
  	gofips140        string
  	workdir          string
  	tooldir          string
@@ -59,7 +59,7 @@ index b62e518030..0c54d82300 100644
  	oldgoos          string
  	oldgoarch        string
  	oldgocache       string
-@@ -61,6 +62,7 @@ var (
+@@ -62,6 +63,7 @@ var (
  	rebuildall bool
  	noOpt      bool
  	isRelease  bool
@@ -67,16 +67,16 @@ index b62e518030..0c54d82300 100644
  
  	vflag int // verbosity
  )
-@@ -286,6 +288,8 @@ func xinit() {
- 
+@@ -278,6 +280,8 @@ func xinit() {
  	goversion := findgoversion()
- 	isRelease = strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")
+ 	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
+ 		!strings.Contains(goversion, "devel")
 +
 +	build_tooldir = pathf("%s/pkg/tool/native_native", goroot)
  }
  
  // compilerEnv returns a map from "goos/goarch" to the
-@@ -547,8 +551,10 @@ func setup() {
+@@ -543,8 +547,10 @@ func setup() {
  	goosGoarch := pathf("%s/pkg/%s_%s", goroot, gohostos, gohostarch)
  	if rebuildall {
  		xremoveall(goosGoarch)
@@ -87,7 +87,7 @@ index b62e518030..0c54d82300 100644
  	xatexit(func() {
  		if files := xreaddir(goosGoarch); len(files) == 0 {
  			xremove(goosGoarch)
-@@ -1411,14 +1417,20 @@ func cmdbootstrap() {
+@@ -1420,14 +1426,20 @@ func cmdbootstrap() {
  	defer timelog("end", "dist bootstrap")
  
  	var debug, distpack, force, noBanner, noClean bool
@@ -109,7 +109,7 @@ index b62e518030..0c54d82300 100644
  
  	if noClean {
  		xprintf("warning: --no-clean is deprecated and has no effect; use 'go install std cmd' instead\n")
-@@ -1430,6 +1442,18 @@ func cmdbootstrap() {
+@@ -1439,6 +1451,18 @@ func cmdbootstrap() {
  			"Use the -force flag to build anyway.\n", goos, goarch)
  	}
  
@@ -128,7 +128,7 @@ index b62e518030..0c54d82300 100644
  	// Set GOPATH to an internal directory. We shouldn't actually
  	// need to store files here, since the toolchain won't
  	// depend on modules outside of vendor directories, but if
-@@ -1513,9 +1537,14 @@ func cmdbootstrap() {
+@@ -1517,9 +1541,14 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  
@@ -143,7 +143,7 @@ index b62e518030..0c54d82300 100644
  	goBootstrap := pathf("%s/go_bootstrap", tooldir)
  	if debug {
  		run("", ShowOutput|CheckExit, pathf("%s/compile", tooldir), "-V=full")
-@@ -1543,7 +1572,11 @@ func cmdbootstrap() {
+@@ -1547,7 +1576,11 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  	xprintf("Building Go toolchain2 using go_bootstrap and Go toolchain1.\n")
@@ -155,7 +155,7 @@ index b62e518030..0c54d82300 100644
  	// Now that cmd/go is in charge of the build process, enable GOEXPERIMENT.
  	os.Setenv("GOEXPERIMENT", goexperiment)
  	// No need to enable PGO for toolchain2.
-@@ -1596,6 +1629,7 @@ func cmdbootstrap() {
+@@ -1600,6 +1633,7 @@ func cmdbootstrap() {
  		os.Setenv("GOCACHE", oldgocache)
  	}
  
@@ -163,7 +163,7 @@ index b62e518030..0c54d82300 100644
  	if goos == oldgoos && goarch == oldgoarch {
  		// Common case - not setting up for cross-compilation.
  		timelog("build", "toolchain")
-@@ -1639,6 +1673,42 @@ func cmdbootstrap() {
+@@ -1643,6 +1677,42 @@ func cmdbootstrap() {
  		checkNotStale(toolenv(), goBootstrap, toolchain...)
  		copyfile(pathf("%s/compile4", tooldir), pathf("%s/compile", tooldir), writeExec)
  	}
@@ -206,7 +206,7 @@ index b62e518030..0c54d82300 100644
  
  	// Check that there are no new files in $GOROOT/bin other than
  	// go and gofmt and $GOOS_$GOARCH (target bin when cross-compiling).
-@@ -1661,8 +1731,12 @@ func cmdbootstrap() {
+@@ -1665,8 +1735,12 @@ func cmdbootstrap() {
  		}
  	}
  
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index b29da33..5117379 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -32,7 +32,7 @@ diff --git a/src/cmd/go/internal/work/action.go b/src/cmd/go/internal/work/actio
 index 44bb9f8c1e..87ac4e30e5 100644
 --- a/src/cmd/go/internal/work/action.go
 +++ b/src/cmd/go/internal/work/action.go
-@@ -837,6 +837,9 @@ func (b *Builder) addTransitiveLinkDeps(a, a1 *Action, shlib string) {
+@@ -844,6 +844,9 @@ func (b *Builder) addTransitiveLinkDeps(a, a1 *Action, shlib string) {
  			if p1 == nil || p1.Shlib == "" || haveShlib[filepath.Base(p1.Shlib)] {
  				continue
  			}
@@ -46,7 +46,7 @@ diff --git a/src/cmd/go/internal/work/build.go b/src/cmd/go/internal/work/build.
 index 3508d51fbb..77f5e7241a 100644
 --- a/src/cmd/go/internal/work/build.go
 +++ b/src/cmd/go/internal/work/build.go
-@@ -238,6 +238,8 @@ See also: go install, go get, go clean.
+@@ -239,6 +239,8 @@ See also: go install, go get, go clean.
  
  const concurrentGCBackendCompilationEnabledByDefault = true
  
@@ -55,9 +55,9 @@ index 3508d51fbb..77f5e7241a 100644
  func init() {
  	// break init cycle
  	CmdBuild.Run = runBuild
-@@ -251,6 +253,10 @@ func init() {
- 		AddCoverFlags(CmdBuild, nil)
- 		AddCoverFlags(CmdInstall, nil)
+@@ -293,6 +295,10 @@ func init() {
+ 	case "gc", "gccgo":
+ 		buildCompiler{}.Set(build.Default.Compiler)
  	}
 +
 +	if x := os.Getenv("GOROOT_OVERRIDE"); x != "" {
@@ -65,12 +65,12 @@ index 3508d51fbb..77f5e7241a 100644
 +	}
  }
  
- // Note that flags consulted by other parts of the code
+ type BuildFlagMask int
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 1f618be0bb..651fa64582 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -552,6 +552,23 @@ func (b *Builder) build(ctx context.Context, a *Action) (err error) {
+@@ -558,6 +558,23 @@ func (b *Builder) build(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
@@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
  	if err := sh.Mkdir(a.Objdir); err != nil {
  		return err
  	}
-@@ -1747,6 +1764,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1731,6 +1748,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index 9a701c7..7fe8d9d 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -19,7 +19,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 651fa64582..586079afb4 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1426,6 +1426,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1410,6 +1410,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -49,7 +49,7 @@ index 651fa64582..586079afb4 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1436,7 +1459,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1420,7 +1443,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
diff --git a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
index a9cb2a4..59cbff1 100644
--- a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
+++ b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
@@ -19,7 +19,7 @@ diff --git a/src/cmd/dist/buildgo.go b/src/cmd/dist/buildgo.go
 index 884e9d729a..2f52edacfe 100644
 --- a/src/cmd/dist/buildgo.go
 +++ b/src/cmd/dist/buildgo.go
-@@ -51,8 +51,8 @@ func mkzdefaultcc(dir, file string) {
+@@ -50,8 +50,8 @@ func mkzdefaultcc(dir, file string) {
  		fmt.Fprintf(&buf, "package cfg\n")
  		fmt.Fprintln(&buf)
  		fmt.Fprintf(&buf, "const DefaultPkgConfig = `%s`\n", defaultpkgconfig)
@@ -30,7 +30,7 @@ index 884e9d729a..2f52edacfe 100644
  		writefile(buf.String(), file, writeSkipSame)
  		return
  	}
-@@ -62,8 +62,8 @@ func mkzdefaultcc(dir, file string) {
+@@ -61,8 +61,8 @@ func mkzdefaultcc(dir, file string) {
  	fmt.Fprintf(&buf, "package main\n")
  	fmt.Fprintln(&buf)
  	fmt.Fprintf(&buf, "const defaultPkgConfig = `%s`\n", defaultpkgconfig)
diff --git a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
index d47c4b1..7bb9757 100644
--- a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
+++ b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
@@ -20,7 +20,7 @@ diff --git a/src/cmd/go/internal/load/pkg.go b/src/cmd/go/internal/load/pkg.go
 index 15f6b2e87b..47c5b865a1 100644
 --- a/src/cmd/go/internal/load/pkg.go
 +++ b/src/cmd/go/internal/load/pkg.go
-@@ -2291,6 +2291,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
+@@ -2313,6 +2313,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
  	info.Settings = append(info.Settings, debug.BuildSetting{Key: key, Value: value})
  }
  
@@ -38,7 +38,7 @@ index 15f6b2e87b..47c5b865a1 100644
  // setBuildInfo gathers build information and sets it into
  // p.Internal.BuildInfo, which will later be formatted as a string and embedded
  // in the binary. setBuildInfo should only be called on a main package with no
-@@ -2398,7 +2409,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2420,7 +2431,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
  	if gcflags := BuildGcflags.String(); gcflags != "" && cfg.BuildContext.Compiler == "gc" {
  		appendSetting("-gcflags", gcflags)
  	}
@@ -47,7 +47,7 @@ index 15f6b2e87b..47c5b865a1 100644
  		// https://go.dev/issue/52372: only include ldflags if -trimpath is not set,
  		// since it can include system paths through various linker flags (notably
  		// -extar, -extld, and -extldflags).
-@@ -2444,7 +2455,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2466,7 +2477,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
  	// subset of flags that are known not to be paths?
  	if cfg.BuildContext.CgoEnabled && !cfg.BuildTrimpath {
  		for _, name := range []string{"CGO_CFLAGS", "CGO_CPPFLAGS", "CGO_CXXFLAGS", "CGO_LDFLAGS"} {
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
index 2c2f0cb..ac70abd 100644
--- a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -30,19 +30,18 @@ diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
 index 3a173efee8..8b7a44e031 100644
 --- a/src/cmd/go/internal/work/gc.go
 +++ b/src/cmd/go/internal/work/gc.go
-@@ -728,7 +728,14 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+@@ -727,7 +727,13 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
  	// the output file path is recorded in the .gnu.version_d section.
  	dir, targetPath := filepath.Split(targetPath)
  
--	return b.Shell(root).run(dir, targetPath, nil, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
-+	env := []string{}
+-	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
 +	// When -trimpath is used, GOROOT is cleared
 +	if cfg.BuildTrimpath {
-+		env = append(env, "GOROOT=")
++		cfgChangedEnv = append(cfgChangedEnv, "GOROOT=")
 +	} else {
-+		env = append(env, "GOROOT="+cfg.GOROOT)
++		cfgChangedEnv = append(cfgChangedEnv, "GOROOT="+cfg.GOROOT)
 +	}
-+	return b.Shell(root).run(dir, targetPath, env, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
++	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
  }
  
  func (gcToolchain) cc(b *Builder, a *Action, ofile, cfile string) error {
diff --git a/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch b/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
similarity index 93%
rename from recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
rename to recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
index 58bd00f..8cf645c 100644
--- a/recipes-devtools/go/go/6d265b008e3d106b2706645e5a88cd8e2fb98953.patch
+++ b/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
@@ -1,7 +1,8 @@
 From 6d265b008e3d106b2706645e5a88cd8e2fb98953 Mon Sep 17 00:00:00 2001
 From: Dirk Müller <dirk@dmllr.de>
 Date: Wed, 09 Mar 2022 17:47:23 +0100
-Subject: [PATCH] cmd/link: stop forcing binutils-gold dependency on aarch64
+Subject: [PATCH 11/11] cmd/link: stop forcing binutils-gold dependency on
+  aarch64
 
 The bfd linker appears to be working just fine at least in version
 2.41 or above. Reject the known broken one instead, which
@@ -21,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
 index dfc72e02c0..2a2a304113 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1673,27 +1673,6 @@ func (ctxt *Link) hostlink() {
+@@ -1677,27 +1677,6 @@ func (ctxt *Link) hostlink() {
  			// Use lld to avoid errors from default linker (issue #38838)
  			altLinker = "lld"
  		}
diff --git a/recipes-devtools/go/go_1.24.6.bb b/recipes-devtools/go/go_1.25.0.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.6.bb
rename to recipes-devtools/go/go_1.25.0.bb

