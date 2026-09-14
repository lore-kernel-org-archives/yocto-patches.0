Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F259C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:24:23 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6090.1789413855610201670
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:24:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=OajfOl7T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20260914192413affc181ce500020725-bmw29f@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260914192413affc181ce500020725
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:24:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UIAUYKBRYEPxWQspY/uc0iOsZp6e0faaCn87WYCOWUk=;
 b=OajfOl7TtImwtZhqAaFR6ZFJmIRDBB9L8CTVfC7n6dWry2+mI7AxjuQcV+HLRqjVzHAVo8
 KZid7prrhABfcEEG1UamGHA/p8NzheO+lsLurB4La3u6jhtfceJhWa9rN0GnfgOjnpGeuQ3C
 +O4f4Nc+TJF+6pSq12gWwimI1VrCkqyA0JjVxwTPoW6fd/cRyEsfivGT+aEHpY8mDK7NBhhp
 QOEJzNbqKMJdKVr4f7uydIf6m5Cc6++UjPWgMNrsNElh+/skjJ9oPNMAelQA8kq9mmBmOTrW
 9b8ZGlhRtPd24jkfJk0DqVWBrTTaFsXOh9DdFXUpdVssvzXJ3EOZfn/A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 3/4] go: upgrade 1.27.0 -> 1.27.1
Date: Mon, 14 Sep 2026 21:23:14 +0200
Message-ID: <20260914192315.1067308-3-peter.marko@siemens.com>
In-Reply-To: <20260914192315.1067308-1-peter.marko@siemens.com>
References: <20260914192315.1067308-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:24:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4841

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Changelog:
go1.27.1 includes fixes to cgo, the compiler, the
runtime, the go fix command, and the database/sql, debug/elf,
encoding/json, net/http, os, simd, and simd/archsimd packages

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
(From OE-Core rev: e87255c5a3705659eedb9a9b2e4910b5218e3bd9)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../go/{go-1.27.0.inc => go-1.27.1.inc}       |  2 +-
 ..._1.27.0.bb => go-cross-canadian_1.27.1.bb} |  0
 ...{go-cross_1.27.0.bb => go-cross_1.27.1.bb} |  0
 ...osssdk_1.27.0.bb => go-crosssdk_1.27.1.bb} |  0
 ...runtime_1.27.0.bb => go-runtime_1.27.1.bb} |  0
 ...ent-based-hash-generation-less-pedan.patch | 34 ++++++++-----------
 ...OOLDIR-to-be-overridden-in-the-envir.patch | 14 +++-----
 ...3-ld-add-soname-to-shareable-objects.patch | 15 ++++----
 ...de-CC-when-building-dist-and-go_boot.patch | 10 ++----
 ...dist-separate-host-and-target-builds.patch | 31 ++++++++---------
 ...d-go-make-GOROOT-precious-by-default.patch | 23 ++++++-------
 ...ut-build-specific-paths-from-linker-.patch | 14 +++-----
 ...ldgo.go-do-not-hardcode-host-compile.patch | 11 +++---
 ...uild-paths-on-staticly-linked-arches.patch | 15 ++++----
 ...OOT-for-func-ldShared-when-trimpath-.patch | 12 +++----
 .../go/{go_1.27.0.bb => go_1.27.1.bb}         |  0
 16 files changed, 73 insertions(+), 108 deletions(-)
 rename recipes-devtools/go/{go-1.27.0.inc => go-1.27.1.inc} (90%)
 rename recipes-devtools/go/{go-cross-canadian_1.27.0.bb => go-cross-canadian_1.27.1.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.27.0.bb => go-cross_1.27.1.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.27.0.bb => go-crosssdk_1.27.1.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.27.0.bb => go-runtime_1.27.1.bb} (100%)
 rename recipes-devtools/go/{go_1.27.0.bb => go_1.27.1.bb} (100%)

diff --git a/recipes-devtools/go/go-1.27.0.inc b/recipes-devtools/go/go-1.27.1.inc
similarity index 90%
rename from recipes-devtools/go/go-1.27.0.inc
rename to recipes-devtools/go/go-1.27.1.inc
index 4162a2b..61df455 100644
--- a/recipes-devtools/go/go-1.27.0.inc
+++ b/recipes-devtools/go/go-1.27.1.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "7002403d7cc44529ef6d26f69a44818263395ead7c16c05a5808ae047ebeb0e5"
+SRC_URI[main.sha256sum] = "4e408abae126d916b6164627193f2c54f0e3ca1312d693b86db45f862ab238b1"
diff --git a/recipes-devtools/go/go-cross-canadian_1.27.0.bb b/recipes-devtools/go/go-cross-canadian_1.27.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.27.0.bb
rename to recipes-devtools/go/go-cross-canadian_1.27.1.bb
diff --git a/recipes-devtools/go/go-cross_1.27.0.bb b/recipes-devtools/go/go-cross_1.27.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.27.0.bb
rename to recipes-devtools/go/go-cross_1.27.1.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.27.0.bb b/recipes-devtools/go/go-crosssdk_1.27.1.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.27.0.bb
rename to recipes-devtools/go/go-crosssdk_1.27.1.bb
diff --git a/recipes-devtools/go/go-runtime_1.27.0.bb b/recipes-devtools/go/go-runtime_1.27.1.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.27.0.bb
rename to recipes-devtools/go/go-runtime_1.27.1.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index 077bebe..6372b78 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -1,8 +1,7 @@
-From 51c04a9a19dec5a48fa0f38324dc2480b7a859e4 Mon Sep 17 00:00:00 2001
+From a84463da5bd6dfa1e514bbac2134155275a6f0ca Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Sat, 22 Feb 2025 03:24:48 -0800
-Subject: [PATCH 01/11] cmd/go: make content-based hash generation less
- pedantic
+Subject: [PATCH] cmd/go: make content-based hash generation less pedantic
 
 Go 1.10's build tool now uses content-based hashes to
 determine when something should be built or re-built.
@@ -36,10 +35,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  2 files changed, 36 insertions(+), 10 deletions(-)
 
 diff --git a/src/cmd/go/internal/envcmd/env.go b/src/cmd/go/internal/envcmd/env.go
-index 7c370d427f..c2441f7695 100644
+index 3d72c368b088..7e4235718a3f 100644
 --- a/src/cmd/go/internal/envcmd/env.go
 +++ b/src/cmd/go/internal/envcmd/env.go
-@@ -219,7 +219,7 @@ func ExtraEnvVarsCostly(loaderstate *modload.State) []cfg.EnvVar {
+@@ -246,7 +246,7 @@ func ExtraEnvVarsCostly(ld *modload.Loader) []cfg.EnvVar {
  		}
  	}()
  
@@ -49,10 +48,10 @@ index 7c370d427f..c2441f7695 100644
  		// Should not happen - b.CFlags was given an empty package.
  		fmt.Fprintf(os.Stderr, "go: invalid cflags: %v\n", err)
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index 7b073165d5..1f618be0bb 100644
+index 8dcf324529f5..617b7ece73f0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -257,6 +257,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
+@@ -260,6 +260,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
  	writeActionGraph()
  }
  
@@ -61,7 +60,7 @@ index 7b073165d5..1f618be0bb 100644
  // buildActionID computes the action ID for a build action.
  func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	p := a.Package
-@@ -278,7 +280,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -281,7 +283,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		if p.Module != nil {
  			fmt.Fprintf(h, "module %s@%s\n", p.Module.Path, p.Module.Version)
  		}
@@ -70,7 +69,7 @@ index 7b073165d5..1f618be0bb 100644
  		// The Go compiler always hides the exact value of $GOROOT
  		// when building things in GOROOT.
  		//
-@@ -313,9 +315,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -316,9 +318,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	}
  	if len(p.CgoFiles)+len(p.SwigFiles)+len(p.SwigCXXFiles) > 0 {
  		fmt.Fprintf(h, "cgo %q\n", b.toolID("cgo"))
@@ -82,7 +81,7 @@ index 7b073165d5..1f618be0bb 100644
  		fmt.Fprintf(h, "CC=%q %q %q %q\n", ccExe, cppflags, cflags, ldflags)
  		// Include the C compiler tool ID so that if the C
  		// compiler changes we rebuild the package.
-@@ -325,7 +327,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -328,7 +330,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			fmt.Fprintf(h, "CC ID ERROR=%q\n", err)
  		}
  		if len(p.CXXFiles)+len(p.SwigCXXFiles) > 0 {
@@ -91,7 +90,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "CXX=%q %q\n", cxxExe, cxxflags)
  			if cxxID, _, err := b.gccToolID(cxxExe[0], "c++"); err == nil {
  				fmt.Fprintf(h, "CXX ID=%q\n", cxxID)
-@@ -334,7 +336,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -337,7 +339,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			}
  		}
  		if len(p.FFiles) > 0 {
@@ -100,7 +99,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "FC=%q %q\n", fcExe, fflags)
  			if fcID, _, err := b.gccToolID(fcExe[0], "f95"); err == nil {
  				fmt.Fprintf(h, "FC ID=%q\n", fcID)
-@@ -353,7 +355,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -356,7 +358,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		}
  	}
  	if p.Internal.BuildInfo != nil {
@@ -109,7 +108,7 @@ index 7b073165d5..1f618be0bb 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2804,8 +2806,25 @@ func envList(key, def string) []string {
+@@ -2838,8 +2840,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -136,7 +135,7 @@ index 7b073165d5..1f618be0bb 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2821,6 +2840,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+@@ -2855,6 +2874,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
  	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
@@ -150,7 +149,7 @@ index 7b073165d5..1f618be0bb 100644
  
  	return
  }
-@@ -2909,7 +2935,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+@@ -2943,7 +2969,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
  	cgoExe := base.Tool("cgo")
  	cgofiles = mkAbsFiles(p.Dir, cgofiles)
  
@@ -159,7 +158,7 @@ index 7b073165d5..1f618be0bb 100644
  	if err != nil {
  		return err
  	}
-@@ -3462,7 +3488,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3501,7 +3527,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
@@ -168,6 +167,3 @@ index 7b073165d5..1f618be0bb 100644
  	if err != nil {
  		return err
  	}
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
index f6767d0..e47bd53 100644
--- a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
+++ b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
@@ -1,8 +1,7 @@
-From fdad9a0ea659cf2281a0df16b0f69f179605ec9a Mon Sep 17 00:00:00 2001
+From 7c951454dc9acbb0649d38504c8237304a80fa46 Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:15:37 +0430
-Subject: [PATCH 02/11] cmd/go: Allow GOTOOLDIR to be overridden in the
- environment
+Subject: [PATCH] cmd/go: Allow GOTOOLDIR to be overridden in the environment
 
 to allow for split host/target build roots
 
@@ -20,10 +19,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  2 files changed, 8 insertions(+), 2 deletions(-)
 
 diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
-index 1f467647f5..b62e518030 100644
+index 78d55bec5599..4210466fa4ea 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -271,7 +271,9 @@ func xinit() {
+@@ -272,7 +272,9 @@ func xinit() {
  	}
  	xatexit(rmworkdir)
  
@@ -35,7 +34,7 @@ index 1f467647f5..b62e518030 100644
  	goversion := findgoversion()
  	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
 diff --git a/src/cmd/go/internal/cfg/cfg.go b/src/cmd/go/internal/cfg/cfg.go
-index 3b9f27e91d..ec043c1530 100644
+index 78cbbb949e7c..96b5fc38a495 100644
 --- a/src/cmd/go/internal/cfg/cfg.go
 +++ b/src/cmd/go/internal/cfg/cfg.go
 @@ -279,7 +279,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
@@ -51,6 +50,3 @@ index 3b9f27e91d..ec043c1530 100644
  		}
  	}
  }
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
index 0b5026f..59ae99c 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -1,7 +1,7 @@
-From 1546d837c69b654754ee137af1fa1c2f7500cfa2 Mon Sep 17 00:00:00 2001
+From 2bd7bc502c308b39ba80a8804bb4e2305acd0f62 Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:16:32 +0430
-Subject: [PATCH 03/11] ld: add soname to shareable objects
+Subject: [PATCH] ld: add soname to shareable objects
 
 so that OE's shared library dependency handling
 can find them.
@@ -19,10 +19,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 3 insertions(+)
 
 diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
-index 2d8f964f35..dfc72e02c0 100644
+index 9cbc12919f1d..0f33521777d1 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1652,6 +1652,7 @@ func (ctxt *Link) hostlink() {
+@@ -1672,6 +1672,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -30,7 +30,7 @@ index 2d8f964f35..dfc72e02c0 100644
  			if ctxt.HeadType == objabi.Hwindows {
  				argv = addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1667,6 +1668,7 @@ func (ctxt *Link) hostlink() {
+@@ -1687,6 +1688,7 @@ func (ctxt *Link) hostlink() {
  			argv = append(argv, "-Wl,-z,relro")
  		}
  		argv = append(argv, "-shared")
@@ -38,7 +38,7 @@ index 2d8f964f35..dfc72e02c0 100644
  	case BuildModePlugin:
  		if ctxt.HeadType == objabi.Hdarwin {
  			argv = append(argv, "-dynamiclib")
-@@ -1675,6 +1677,7 @@ func (ctxt *Link) hostlink() {
+@@ -1695,6 +1697,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -46,6 +46,3 @@ index 2d8f964f35..dfc72e02c0 100644
  		}
  	}
  
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
index abbb7bd..fa98120 100644
--- a/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
+++ b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
@@ -1,8 +1,7 @@
-From b41aaa851f0074682fcd4bf07c891fbdf0fdf70c Mon Sep 17 00:00:00 2001
+From ad5252b238946d7d9f21853709e6b592fb2d50e5 Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Sat, 22 Feb 2025 03:14:37 -0800
-Subject: [PATCH 04/11] make.bash: override CC when building dist and
- go_bootstrap
+Subject: [PATCH] make.bash: override CC when building dist and go_bootstrap
 
 for handling OE cross-canadian builds.
 
@@ -22,7 +21,7 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/src/make.bash b/src/make.bash
-index b67ae1529f..b59cdabd09 100755
+index d4e927dfda7c..8fc7e40888c6 100755
 --- a/src/make.bash
 +++ b/src/make.bash
 @@ -153,7 +153,7 @@ fi
@@ -43,6 +42,3 @@ index b67ae1529f..b59cdabd09 100755
  rm -f ./cmd/dist/dist
  
  # DO NOT ADD ANY NEW CODE HERE.
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
index 7c8923f..2c34ada 100644
--- a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
+++ b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
@@ -1,7 +1,7 @@
-From 12bf824f8b7e85f05434aa00e866e883a551aaeb Mon Sep 17 00:00:00 2001
+From c78ccbcf1c70e3bb27185b6a007d44d2e912466d Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Fri, 28 Feb 2025 19:09:17 -0800
-Subject: [PATCH 05/11] cmd/dist: separate host and target builds
+Subject: [PATCH] cmd/dist: separate host and target builds
 
 Change the dist tool to allow for OE-style cross-
 and cross-canadian builds:
@@ -48,10 +48,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 75 insertions(+), 1 deletion(-)
 
 diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
-index b62e518030..0c54d82300 100644
+index 4210466fa4ea..ee069148143e 100644
 --- a/src/cmd/dist/build.go
 +++ b/src/cmd/dist/build.go
-@@ -50,6 +50,7 @@ var (
+@@ -51,6 +51,7 @@ var (
  	gofips140        string
  	workdir          string
  	tooldir          string
@@ -59,7 +59,7 @@ index b62e518030..0c54d82300 100644
  	oldgoos          string
  	oldgoarch        string
  	oldgocache       string
-@@ -62,6 +63,7 @@ var (
+@@ -63,6 +64,7 @@ var (
  	rebuildall bool
  	noOpt      bool
  	isRelease  bool
@@ -67,7 +67,7 @@ index b62e518030..0c54d82300 100644
  
  	vflag int // verbosity
  )
-@@ -278,6 +280,8 @@ func xinit() {
+@@ -279,6 +281,8 @@ func xinit() {
  	goversion := findgoversion()
  	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
  		!strings.Contains(goversion, "devel")
@@ -76,7 +76,7 @@ index b62e518030..0c54d82300 100644
  }
  
  // compilerEnv returns a map from "goos/goarch" to the
-@@ -543,8 +547,10 @@ func setup() {
+@@ -558,8 +562,10 @@ func setup() {
  	goosGoarch := pathf("%s/pkg/%s_%s", goroot, gohostos, gohostarch)
  	if rebuildall {
  		xremoveall(goosGoarch)
@@ -87,7 +87,7 @@ index b62e518030..0c54d82300 100644
  	xatexit(func() {
  		if files := xreaddir(goosGoarch); len(files) == 0 {
  			xremove(goosGoarch)
-@@ -1415,14 +1421,20 @@ func cmdbootstrap() {
+@@ -1432,14 +1438,20 @@ func cmdbootstrap() {
  	defer timelog("end", "dist bootstrap")
  
  	var debug, distpack, force, noBanner, noClean bool
@@ -109,7 +109,7 @@ index b62e518030..0c54d82300 100644
  
  	if noClean {
  		xprintf("warning: --no-clean is deprecated and has no effect; use 'go install std cmd' instead\n")
-@@ -1434,6 +1446,18 @@ func cmdbootstrap() {
+@@ -1451,6 +1463,18 @@ func cmdbootstrap() {
  			"Use the -force flag to build anyway.\n", goos, goarch)
  	}
  
@@ -128,7 +128,7 @@ index b62e518030..0c54d82300 100644
  	// Set GOPATH to an internal directory. We shouldn't actually
  	// need to store files here, since the toolchain won't
  	// depend on modules outside of vendor directories, but if
-@@ -1512,9 +1536,14 @@ func cmdbootstrap() {
+@@ -1529,9 +1553,14 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  
@@ -143,7 +143,7 @@ index b62e518030..0c54d82300 100644
  	goBootstrap := pathf("%s/go_bootstrap", tooldir)
  	if debug {
  		run("", ShowOutput|CheckExit, pathf("%s/compile", tooldir), "-V=full")
-@@ -1542,7 +1571,11 @@ func cmdbootstrap() {
+@@ -1559,7 +1588,11 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  	xprintf("Building Go toolchain2 using go_bootstrap and Go toolchain1.\n")
@@ -155,7 +155,7 @@ index b62e518030..0c54d82300 100644
  	// Now that cmd/go is in charge of the build process, enable GOEXPERIMENT.
  	os.Setenv("GOEXPERIMENT", goexperiment)
  	// No need to enable PGO for toolchain2.
-@@ -1595,6 +1628,7 @@ func cmdbootstrap() {
+@@ -1612,6 +1645,7 @@ func cmdbootstrap() {
  		os.Setenv("GOCACHE", oldgocache)
  	}
  
@@ -163,7 +163,7 @@ index b62e518030..0c54d82300 100644
  	if goos == oldgoos && goarch == oldgoarch {
  		// Common case - not setting up for cross-compilation.
  		timelog("build", "toolchain")
-@@ -1638,6 +1672,42 @@ func cmdbootstrap() {
+@@ -1655,6 +1689,42 @@ func cmdbootstrap() {
  		checkNotStale(toolenv(), goBootstrap, toolchain...)
  		copyfile(pathf("%s/compile4", tooldir), pathf("%s/compile", tooldir), writeExec)
  	}
@@ -206,7 +206,7 @@ index b62e518030..0c54d82300 100644
  
  	// Check that there are no new files in $GOROOT/bin other than
  	// go and gofmt and $GOOS_$GOARCH (target bin when cross-compiling).
-@@ -1660,8 +1730,12 @@ func cmdbootstrap() {
+@@ -1677,8 +1747,12 @@ func cmdbootstrap() {
  		}
  	}
  
@@ -219,6 +219,3 @@ index b62e518030..0c54d82300 100644
  
  	if goos == "android" {
  		// Make sure the exec wrapper will sync a fresh $GOROOT to the device.
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index 9aebc2f..74fd1fa 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -1,7 +1,7 @@
-From ba3caa9f969bac2b937f8f1ffed4a3679cd16ec7 Mon Sep 17 00:00:00 2001
+From 3d48927c9fa7228445be9249d8a7e696bb6d306d Mon Sep 17 00:00:00 2001
 From: Alex Kube <alexander.j.kube@gmail.com>
 Date: Wed, 23 Oct 2019 21:18:56 +0430
-Subject: [PATCH 06/11] cmd/go: make GOROOT precious by default
+Subject: [PATCH] cmd/go: make GOROOT precious by default
 
 The go build tool normally rebuilds whatever it detects is
 stale.  This can be a problem when GOROOT is intended to
@@ -29,10 +29,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  3 files changed, 34 insertions(+)
 
 diff --git a/src/cmd/go/internal/work/action.go b/src/cmd/go/internal/work/action.go
-index 44bb9f8c1e..87ac4e30e5 100644
+index 8b3897e215ed..598e751aba4e 100644
 --- a/src/cmd/go/internal/work/action.go
 +++ b/src/cmd/go/internal/work/action.go
-@@ -1076,6 +1076,9 @@ func (b *Builder) addTransitiveLinkDeps(s *modload.State, a, a1 *Action, shlib s
+@@ -1076,6 +1076,9 @@ func (b *Builder) addTransitiveLinkDeps(s *modload.Loader, a, a1 *Action, shlib
  			if p1 == nil || p1.Shlib == "" || haveShlib[filepath.Base(p1.Shlib)] {
  				continue
  			}
@@ -43,10 +43,10 @@ index 44bb9f8c1e..87ac4e30e5 100644
  			// TODO(rsc): The use of ModeInstall here is suspect, but if we only do ModeBuild,
  			// we'll end up building an overall library or executable that depends at runtime
 diff --git a/src/cmd/go/internal/work/build.go b/src/cmd/go/internal/work/build.go
-index 3508d51fbb..77f5e7241a 100644
+index 969e0029c3e2..f80f28abff63 100644
 --- a/src/cmd/go/internal/work/build.go
 +++ b/src/cmd/go/internal/work/build.go
-@@ -238,6 +238,8 @@ See also: go install, go get, go clean.
+@@ -240,6 +240,8 @@ See also: go install, go get, go clean.
  	`,
  }
  
@@ -55,7 +55,7 @@ index 3508d51fbb..77f5e7241a 100644
  func init() {
  	// break init cycle
  	CmdBuild.Run = runBuild
-@@ -292,6 +294,10 @@ func init() {
+@@ -294,6 +296,10 @@ func init() {
  	case "gc", "gccgo":
  		buildCompiler{}.Set(build.Default.Compiler)
  	}
@@ -67,10 +67,10 @@ index 3508d51fbb..77f5e7241a 100644
  
  type BuildFlagMask int
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index 1f618be0bb..651fa64582 100644
+index 617b7ece73f0..46c0712c5bd0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -605,6 +605,23 @@ func (b *Builder) checkCacheForBuild(a, buildAction *Action, covMetaFileName str
+@@ -608,6 +608,23 @@ func (b *Builder) checkCacheForBuild(a, buildAction *Action, covMetaFileName str
  		return nil, err
  	}
  
@@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
  	if err := sh.Mkdir(buildAction.Objdir); err != nil {
  		return nil, err
  	}
-@@ -1888,6 +1905,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1922,6 +1939,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
@@ -109,6 +109,3 @@ index 1f618be0bb..651fa64582 100644
  	if err := b.Shell(a).Mkdir(a.Objdir); err != nil {
  		return err
  	}
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index 2598a7b..0cc770a 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -1,8 +1,7 @@
-From 2197f813c9cff65eedef44473872ec5ea9ced227 Mon Sep 17 00:00:00 2001
+From 0c1a5e347d722a0297328b28259c55acdd1b89c8 Mon Sep 17 00:00:00 2001
 From: Changqing Li <changqing.li@windriver.com>
 Date: Tue, 27 Feb 2024 18:06:51 +0800
-Subject: [PATCH 07/11] exec.go: filter out build-specific paths from linker
- flags
+Subject: [PATCH] exec.go: filter out build-specific paths from linker flags
 
 The flags can contain build-specific paths, breaking reproducibility.
 Filter out options that have build-specific paths.
@@ -16,10 +15,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 24 insertions(+), 1 deletion(-)
 
 diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
-index 651fa64582..586079afb4 100644
+index 46c0712c5bd0..e7c0459ee4c0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1563,6 +1563,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1597,6 +1597,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -49,7 +48,7 @@ index 651fa64582..586079afb4 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1573,7 +1596,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1607,7 +1630,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
@@ -58,6 +57,3 @@ index 651fa64582..586079afb4 100644
  		}
  
  		// GOARM, GOMIPS, etc.
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
index 59cbff1..cae95f7 100644
--- a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
+++ b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
@@ -1,8 +1,8 @@
-From e5752b239707df8ad7a72dc60420e01c5912d606 Mon Sep 17 00:00:00 2001
+From 11cab620644b3354a1bf281a1f8ca62d590ad46a Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex.kanavin@gmail.com>
 Date: Tue, 10 Nov 2020 16:33:27 +0000
-Subject: [PATCH 08/11] src/cmd/dist/buildgo.go: do not hardcode host compilers
- into target binaries
+Subject: [PATCH] src/cmd/dist/buildgo.go: do not hardcode host compilers into
+ target binaries
 
 These come from $CC/$CXX on the build host and are not useful on targets;
 additionally as they contain host specific paths, this helps reproducibility.
@@ -16,7 +16,7 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 4 insertions(+), 4 deletions(-)
 
 diff --git a/src/cmd/dist/buildgo.go b/src/cmd/dist/buildgo.go
-index 884e9d729a..2f52edacfe 100644
+index 6bd8a9ce8dfa..08f36eb0d8f1 100644
 --- a/src/cmd/dist/buildgo.go
 +++ b/src/cmd/dist/buildgo.go
 @@ -50,8 +50,8 @@ func mkzdefaultcc(dir, file string) {
@@ -41,6 +41,3 @@ index 884e9d729a..2f52edacfe 100644
  	writefile(buf.String(), file, writeSkipSame)
  }
  
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
index 140923f..dcce739 100644
--- a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
+++ b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
@@ -1,7 +1,7 @@
-From 79a1c80ed43f2a541bcab665656a4e2bb87baab3 Mon Sep 17 00:00:00 2001
+From c6f96f86e8e2619c7e1be566f717b05437838e49 Mon Sep 17 00:00:00 2001
 From: Richard Purdie <richard.purdie@linuxfoundation.org>
 Date: Sat, 2 Jul 2022 23:08:13 +0100
-Subject: [PATCH 09/11] go: Filter build paths on staticly linked arches
+Subject: [PATCH] go: Filter build paths on staticly linked arches
 
 Filter out build time paths from ldflags and other flags variables when they're
 embedded in the go binary so that builds are reproducible regardless of build
@@ -17,10 +17,10 @@ Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
  1 file changed, 13 insertions(+), 2 deletions(-)
 
 diff --git a/src/cmd/go/internal/load/pkg.go b/src/cmd/go/internal/load/pkg.go
-index 15f6b2e87b..47c5b865a1 100644
+index 2985cff67cec..f7c3f5eed9f6 100644
 --- a/src/cmd/go/internal/load/pkg.go
 +++ b/src/cmd/go/internal/load/pkg.go
-@@ -2314,6 +2314,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
+@@ -2359,6 +2359,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
  	info.Settings = append(info.Settings, debug.BuildSetting{Key: key, Value: value})
  }
  
@@ -38,7 +38,7 @@ index 15f6b2e87b..47c5b865a1 100644
  // setBuildInfo gathers build information and sets it into
  // p.Internal.BuildInfo, which will later be formatted as a string and embedded
  // in the binary. setBuildInfo should only be called on a main package with no
-@@ -2421,7 +2432,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
+@@ -2466,7 +2477,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
  	if gcflags := BuildGcflags.String(); gcflags != "" && cfg.BuildContext.Compiler == "gc" {
  		appendSetting("-gcflags", gcflags)
  	}
@@ -47,7 +47,7 @@ index 15f6b2e87b..47c5b865a1 100644
  		// https://go.dev/issue/52372: only include ldflags if -trimpath is not set,
  		// since it can include system paths through various linker flags (notably
  		// -extar, -extld, and -extldflags).
-@@ -2467,7 +2478,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
+@@ -2512,7 +2523,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
  	// subset of flags that are known not to be paths?
  	if cfg.BuildContext.CgoEnabled && !cfg.BuildTrimpath {
  		for _, name := range []string{"CGO_CFLAGS", "CGO_CPPFLAGS", "CGO_CXXFLAGS", "CGO_LDFLAGS"} {
@@ -56,6 +56,3 @@ index 15f6b2e87b..47c5b865a1 100644
  		}
  	}
  	appendSetting("GOARCH", cfg.BuildContext.GOARCH)
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
index 33e91bb..6e71187 100644
--- a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -1,8 +1,7 @@
-From c4215b5ca69a7626d97cf9b7ebc460c2b5b9148b Mon Sep 17 00:00:00 2001
+From 9a2ae8df1030046c94aa74bbd853dde5d844812d Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Fri, 28 Feb 2025 19:13:18 -0800
-Subject: [PATCH 10/11] cmd/go: clear GOROOT for func ldShared when -trimpath
- is used
+Subject: [PATCH] cmd/go: clear GOROOT for func ldShared when -trimpath is used
 
 In commit [cmd: remove support for GOROOT_FINAL][1], it clear GOROOT
 for func ld when -trimpath is used. [2]
@@ -27,10 +26,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
-index 3a173efee8..8b7a44e031 100644
+index 49b26e15609b..7c0d2ac9e0f0 100644
 --- a/src/cmd/go/internal/work/gc.go
 +++ b/src/cmd/go/internal/work/gc.go
-@@ -717,6 +717,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+@@ -721,6 +721,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
  	// the output file path is recorded in the .gnu.version_d section.
  	dir, targetPath := filepath.Split(targetPath)
  
@@ -43,6 +42,3 @@ index 3a173efee8..8b7a44e031 100644
  	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
  }
  
--- 
-2.25.1
-
diff --git a/recipes-devtools/go/go_1.27.0.bb b/recipes-devtools/go/go_1.27.1.bb
similarity index 100%
rename from recipes-devtools/go/go_1.27.0.bb
rename to recipes-devtools/go/go_1.27.1.bb

