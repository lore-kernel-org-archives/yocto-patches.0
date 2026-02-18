Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620EE9A02C
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 19:46:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2826.1771443999746325681
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 11:46:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=HFQSyOop;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260218194637021e1a6c6300020798-ukxgpo@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260218194637021e1a6c6300020798
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 18 Feb 2026 20:46:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=E4gHE6pFFfiPTyEd59yei+qpYM2nAm73EaqT4lGtRWI=;
 b=HFQSyOopklrttf+3H8G9Tf2LouigcKgEZQk1PY0WHcLBBRrAFLtfbMXNjmCYikB9db4UJs
 DHYwmxeNwOFwXj07VqE06kCJgu7n+/lweRcjNMMi+cq1gg1HuG65XFEtv2tWBd9JiavlZWaf
 hmwCVvaifJOZT4vbck6Jbxma5GbBjTE4IAN5DVxOer/5JE9ZiRSFOMLAdtDk7ZeuJo3Zn0BB
 L+9/klUuOdy86uhgBMs6Vf7paUi+7I9Gf3QTnpz7ogVZ0NhGulU1oG/FitBULHfcy2TADA0p
 FrObinqTu9CcCB9EQfYtB4RIR+nWdXeVFKcmUkPvw0u3g4KCFQPDZnyg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][kirkstone/go][PATCH 1/2] go: upgrade 1.25.7 -> 1.26.0
Date: Wed, 18 Feb 2026 20:46:34 +0100
Message-Id: <20260218194635.4136702-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 19:46:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3259

From: Peter Marko <peter.marko@siemens.com>

Release Announcement: [1]
Release notes: [2]
Refreshed all patches and dropped patch merged upstream.

[1] https://groups.google.com/g/golang-announce/c/uVOCkuwbiD8
[2] https://go.dev/doc/go1.26

(From OE-Core rev: 72819b9e603042ef1dcb41e64f888d2350e82e2b)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../go/{go-1.25.7.inc => go-1.26.0.inc}       |   3 +-
 ...e_1.25.7.bb => go-binary-native_1.26.0.bb} |   6 +-
 ..._1.25.7.bb => go-cross-canadian_1.26.0.bb} |   0
 ...{go-cross_1.25.7.bb => go-cross_1.26.0.bb} |   0
 ...osssdk_1.25.7.bb => go-crosssdk_1.26.0.bb} |   0
 ...runtime_1.25.7.bb => go-runtime_1.26.0.bb} |   0
 ...ent-based-hash-generation-less-pedan.patch |  30 +--
 ...ng-cgo-on-386-call-C-sigaction-funct.patch | 248 ------------------
 ...3-ld-add-soname-to-shareable-objects.patch |   6 +-
 ...dist-separate-host-and-target-builds.patch |  14 +-
 ...d-go-make-GOROOT-precious-by-default.patch |  24 +-
 ...ut-build-specific-paths-from-linker-.patch |   4 +-
 ...uild-paths-on-staticly-linked-arches.patch |   6 +-
 ...OOT-for-func-ldShared-when-trimpath-.patch |  10 +-
 ...rcing-binutils-gold-dependency-on-aa.patch |   2 +-
 .../go/{go_1.25.7.bb => go_1.26.0.bb}         |   0
 16 files changed, 51 insertions(+), 302 deletions(-)
 rename recipes-devtools/go/{go-1.25.7.inc => go-1.26.0.inc} (84%)
 rename recipes-devtools/go/{go-binary-native_1.25.7.bb => go-binary-native_1.26.0.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.7.bb => go-cross-canadian_1.26.0.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.7.bb => go-cross_1.26.0.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.7.bb => go-crosssdk_1.26.0.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.7.bb => go-runtime_1.26.0.bb} (100%)
 delete mode 100644 recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch
 rename recipes-devtools/go/{go_1.25.7.bb => go_1.26.0.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.7.inc b/recipes-devtools/go/go-1.26.0.inc
similarity index 84%
rename from recipes-devtools/go/go-1.25.7.inc
rename to recipes-devtools/go/go-1.26.0.inc
index ab58f71..7d8a68e 100644
--- a/recipes-devtools/go/go-1.25.7.inc
+++ b/recipes-devtools/go/go-1.26.0.inc
@@ -16,6 +16,5 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
-    file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "178f2832820274b43e177d32f06a3ebb0129e427dd20a5e4c88df2c1763cf10a"
+SRC_URI[main.sha256sum] = "c9132a8a1f6bd2aa4aad1d74b8231d95274950483a4950657ee6c56e6e817790"
diff --git a/recipes-devtools/go/go-binary-native_1.25.7.bb b/recipes-devtools/go/go-binary-native_1.26.0.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.7.bb
rename to recipes-devtools/go/go-binary-native_1.26.0.bb
index ec6fa10..9eb84fa 100644
--- a/recipes-devtools/go/go-binary-native_1.25.7.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.0.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "12e6d6a191091ae27dc31f6efc630e3a3b8ba409baf3573d955b196fdf086005"
-SRC_URI[go_linux_arm64.sha256sum] = "ba611a53534135a81067240eff9508cd7e256c560edd5d8c2fef54f083c07129"
-SRC_URI[go_linux_ppc64le.sha256sum] = "42124c0edc92464e2b37b2d7fcd3658f0c47ebd6a098732415a522be8cb88e3f"
+SRC_URI[go_linux_amd64.sha256sum] = "aac1b08a0fb0c4e0a7c1555beb7b59180b05dfc5a3d62e40e9de90cd42f88235"
+SRC_URI[go_linux_arm64.sha256sum] = "bd03b743eb6eb4193ea3c3fd3956546bf0e3ca5b7076c8226334afe6b75704cd"
+SRC_URI[go_linux_ppc64le.sha256sum] = "3066b2284b554da76cf664d217490792ba6f292ec0fc20bf9615e173cc0d2800"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.7.bb b/recipes-devtools/go/go-cross-canadian_1.26.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.7.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.0.bb
diff --git a/recipes-devtools/go/go-cross_1.25.7.bb b/recipes-devtools/go/go-cross_1.26.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.7.bb
rename to recipes-devtools/go/go-cross_1.26.0.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.7.bb b/recipes-devtools/go/go-crosssdk_1.26.0.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.7.bb
rename to recipes-devtools/go/go-crosssdk_1.26.0.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.7.bb b/recipes-devtools/go/go-runtime_1.26.0.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.7.bb
rename to recipes-devtools/go/go-runtime_1.26.0.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index 6d75266..af4243e 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -39,7 +39,7 @@ diff --git a/src/cmd/go/internal/envcmd/env.go b/src/cmd/go/internal/envcmd/env.
 index 7c370d427f..c2441f7695 100644
 --- a/src/cmd/go/internal/envcmd/env.go
 +++ b/src/cmd/go/internal/envcmd/env.go
-@@ -219,7 +219,7 @@ func ExtraEnvVarsCostly() []cfg.EnvVar {
+@@ -219,7 +219,7 @@ func ExtraEnvVarsCostly(loaderstate *modload.State) []cfg.EnvVar {
  		}
  	}()
  
@@ -52,7 +52,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 7b073165d5..1f618be0bb 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -237,6 +237,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
+@@ -257,6 +257,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
  	writeActionGraph()
  }
  
@@ -61,7 +61,7 @@ index 7b073165d5..1f618be0bb 100644
  // buildActionID computes the action ID for a build action.
  func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	p := a.Package
-@@ -258,7 +260,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -278,7 +280,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		if p.Module != nil {
  			fmt.Fprintf(h, "module %s@%s\n", p.Module.Path, p.Module.Version)
  		}
@@ -70,7 +70,7 @@ index 7b073165d5..1f618be0bb 100644
  		// The Go compiler always hides the exact value of $GOROOT
  		// when building things in GOROOT.
  		//
-@@ -293,9 +295,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -313,9 +315,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  	}
  	if len(p.CgoFiles)+len(p.SwigFiles)+len(p.SwigCXXFiles) > 0 {
  		fmt.Fprintf(h, "cgo %q\n", b.toolID("cgo"))
@@ -82,7 +82,7 @@ index 7b073165d5..1f618be0bb 100644
  		fmt.Fprintf(h, "CC=%q %q %q %q\n", ccExe, cppflags, cflags, ldflags)
  		// Include the C compiler tool ID so that if the C
  		// compiler changes we rebuild the package.
-@@ -305,7 +307,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -325,7 +327,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			fmt.Fprintf(h, "CC ID ERROR=%q\n", err)
  		}
  		if len(p.CXXFiles)+len(p.SwigCXXFiles) > 0 {
@@ -91,7 +91,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "CXX=%q %q\n", cxxExe, cxxflags)
  			if cxxID, _, err := b.gccToolID(cxxExe[0], "c++"); err == nil {
  				fmt.Fprintf(h, "CXX ID=%q\n", cxxID)
-@@ -314,7 +316,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -334,7 +336,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  			}
  		}
  		if len(p.FFiles) > 0 {
@@ -100,7 +100,7 @@ index 7b073165d5..1f618be0bb 100644
  			fmt.Fprintf(h, "FC=%q %q\n", fcExe, fflags)
  			if fcID, _, err := b.gccToolID(fcExe[0], "f95"); err == nil {
  				fmt.Fprintf(h, "FC ID=%q\n", fcID)
-@@ -333,7 +335,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+@@ -353,7 +355,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
  		}
  	}
  	if p.Internal.BuildInfo != nil {
@@ -109,7 +109,7 @@ index 7b073165d5..1f618be0bb 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2639,8 +2641,25 @@ func envList(key, def string) []string {
+@@ -2807,8 +2809,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -136,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2656,6 +2675,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+@@ -2824,6 +2843,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
  	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
@@ -150,23 +150,23 @@ index 7b073165d5..1f618be0bb 100644
  
  	return
  }
-@@ -2673,7 +2699,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir string, pcCFLAGS, pcLDFLAGS, cgo
- 	p := a.Package
- 	sh := b.Shell(a)
+@@ -2912,7 +2938,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+ 	cgoExe := base.Tool("cgo")
+ 	cgofiles = mkAbsFiles(p.Dir, cgofiles)
  
 -	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, cgoFFLAGS, cgoLDFLAGS, err := b.CFlags(p)
 +	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, cgoFFLAGS, cgoLDFLAGS, err := b.CFlags(p, false)
  	if err != nil {
- 		return nil, nil, err
+ 		return err
  	}
-@@ -3237,7 +3263,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3461,7 +3487,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
 -	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, _, _, err := b.CFlags(p)
 +	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, _, _, err := b.CFlags(p, false)
  	if err != nil {
- 		return "", "", err
+ 		return err
  	}
 -- 
 2.25.1
diff --git a/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch b/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch
deleted file mode 100644
index d27809a..0000000
--- a/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch
+++ /dev/null
@@ -1,248 +0,0 @@
-From c5737dc21bbac9fbefc35ac9313e66291d66b382 Mon Sep 17 00:00:00 2001
-From: Ian Lance Taylor <iant@golang.org>
-Date: Fri, 5 Sep 2025 22:24:37 -0700
-Subject: [PATCH] runtime: when using cgo on 386, call C sigaction function
-
-On 386 the C sigaction function assumes that the caller does not set
-the SA_RESTORER flag. It does not copy the C sa_restorer field to
-the kernel sa_restorer field. The effect is that the kernel sees
-the SA_RESTORER flag but a NULL sa_restorer field, and the program
-crashes when returning from a signal handler.
-
-On the other hand, the C sigaction function will return the SA_RESTORER
-flag and the sa_restorer field stored in the kernel.
-
-This means that if the Go runtime installs a signal handler,
-with SA_RESTORER as is required when calling the kernel,
-and the Go program calls C code that calls the C sigaction function
-to query the current signal handler, that C code will get a result
-that it can't pass back to sigaction.
-
-This CL fixes the problem by using the C sigaction function
-for 386 programs that use cgo. This reuses the functionality
-used on amd64 and other GOARCHs to support the race detector.
-
-See #75253, or runtime/testdata/testprogcgo/eintr.go, for sample
-code that used to fail on 386. No new test case is required,
-we just remove the skip we used to have for eintr.go.
-
-Fixes #75253
-
-Change-Id: I803059b1fb9e09e9fbb43f68eccb6a59a92c2991
-Reviewed-on: https://go-review.googlesource.com/c/go/+/701375
-LUCI-TryBot-Result: Go LUCI <golang-scoped@luci-project-accounts.iam.gserviceaccount.com>
-Reviewed-by: Cherry Mui <cherryyz@google.com>
-Reviewed-by: Dmitri Shuralyov <dmitshur@google.com>
-Auto-Submit: Ian Lance Taylor <iant@golang.org>
-Upstream-Status: Backport [https://github.com/golang/go/commit/c5737dc21bbac9fbefc35ac9313e66291d66b382]
-Signed-off-by: Randolph Sapp <rs@ti.com>
----
- src/runtime/cgo/gcc_sigaction.c |  8 ++++----
- src/runtime/cgo/sigaction.go    |  2 +-
- src/runtime/cgo_sigaction.go    |  6 +++++-
- src/runtime/crash_cgo_test.go   | 11 -----------
- src/runtime/os_freebsd.go       |  6 ++++++
- src/runtime/os_linux.go         | 18 +++++++++++++++++-
- src/runtime/sigaction.go        |  2 +-
- src/runtime/sys_linux_386.s     | 19 +++++++++++++++++++
- 8 files changed, 53 insertions(+), 19 deletions(-)
-
-diff --git a/src/runtime/cgo/gcc_sigaction.c b/src/runtime/cgo/gcc_sigaction.c
-index 7cbef7db11..ad48a88dc1 100644
---- a/src/runtime/cgo/gcc_sigaction.c
-+++ b/src/runtime/cgo/gcc_sigaction.c
-@@ -2,7 +2,7 @@
- // Use of this source code is governed by a BSD-style
- // license that can be found in the LICENSE file.
- 
--//go:build linux && (amd64 || arm64 || loong64 || ppc64le)
-+//go:build linux && (386 || amd64 || arm64 || loong64 || ppc64le)
- 
- #include <errno.h>
- #include <stddef.h>
-@@ -17,7 +17,7 @@
- // to and from struct sigaction — are specific to ${goos}/${goarch}.
- typedef struct {
- 	uintptr_t handler;
--	uint64_t flags;
-+	unsigned long flags;
- #ifdef __loongarch__
- 	uint64_t mask;
- 	uintptr_t restorer;
-@@ -57,7 +57,7 @@ x_cgo_sigaction(intptr_t signum, const go_sigaction_t *goact, go_sigaction_t *ol
- 				sigaddset(&act.sa_mask, (int)(i+1));
- 			}
- 		}
--		act.sa_flags = (int)(goact->flags & ~(uint64_t)SA_RESTORER);
-+		act.sa_flags = (int)(goact->flags & ~(unsigned long)SA_RESTORER);
- 	}
- 
- 	ret = sigaction((int)signum, goact ? &act : NULL, oldgoact ? &oldact : NULL);
-@@ -79,7 +79,7 @@ x_cgo_sigaction(intptr_t signum, const go_sigaction_t *goact, go_sigaction_t *ol
- 				oldgoact->mask |= (uint64_t)(1)<<i;
- 			}
- 		}
--		oldgoact->flags = (uint64_t)oldact.sa_flags;
-+		oldgoact->flags = (unsigned long)oldact.sa_flags;
- 	}
- 
- 	_cgo_tsan_release();
-diff --git a/src/runtime/cgo/sigaction.go b/src/runtime/cgo/sigaction.go
-index dc3f5fd255..90034bad32 100644
---- a/src/runtime/cgo/sigaction.go
-+++ b/src/runtime/cgo/sigaction.go
-@@ -2,7 +2,7 @@
- // Use of this source code is governed by a BSD-style
- // license that can be found in the LICENSE file.
- 
--//go:build (linux && (amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
-+//go:build (linux && (386 || amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
- 
- package cgo
- 
-diff --git a/src/runtime/cgo_sigaction.go b/src/runtime/cgo_sigaction.go
-index 5c644587f0..f725dbef4d 100644
---- a/src/runtime/cgo_sigaction.go
-+++ b/src/runtime/cgo_sigaction.go
-@@ -3,8 +3,10 @@
- // license that can be found in the LICENSE file.
- 
- // Support for sanitizers. See runtime/cgo/sigaction.go.
-+// Also used on linux/386 to clear the SA_RESTORER flag
-+// when using cgo; see issue #75253.
- 
--//go:build (linux && (amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
-+//go:build (linux && (386 || amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
- 
- package runtime
- 
-@@ -42,6 +44,8 @@ func sigaction(sig uint32, new, old *sigactiont) {
- 
- 		var ret int32
- 
-+		fixSigactionForCgo(new)
-+
- 		var g *g
- 		if mainStarted {
- 			g = getg()
-diff --git a/src/runtime/crash_cgo_test.go b/src/runtime/crash_cgo_test.go
-index c5d7303261..b77ff8dafd 100644
---- a/src/runtime/crash_cgo_test.go
-+++ b/src/runtime/crash_cgo_test.go
-@@ -842,17 +842,6 @@ func TestEINTR(t *testing.T) {
- 	switch runtime.GOOS {
- 	case "plan9", "windows":
- 		t.Skipf("no EINTR on %s", runtime.GOOS)
--	case "linux":
--		if runtime.GOARCH == "386" {
--			// On linux-386 the Go signal handler sets
--			// a restorer function that is not preserved
--			// by the C sigaction call in the test,
--			// causing the signal handler to crash when
--			// returning the normal code. The test is not
--			// architecture-specific, so just skip on 386
--			// rather than doing a complicated workaround.
--			t.Skip("skipping on linux-386; C sigaction does not preserve Go restorer")
--		}
- 	}
- 	if runtime.GOOS == "freebsd" && race.Enabled {
- 		t.Skipf("race + cgo freebsd not supported. See https://go.dev/issue/73788.")
-diff --git a/src/runtime/os_freebsd.go b/src/runtime/os_freebsd.go
-index ab859cfb47..68d895b95d 100644
---- a/src/runtime/os_freebsd.go
-+++ b/src/runtime/os_freebsd.go
-@@ -457,6 +457,12 @@ func sysSigaction(sig uint32, new, old *sigactiont) {
- 	}
- }
- 
-+// fixSigactionForCgo is needed for Linux.
-+//
-+//go:nosplit
-+func fixSigactionForCgo(new *sigactiont) {
-+}
-+
- // asmSigaction is implemented in assembly.
- //
- //go:noescape
-diff --git a/src/runtime/os_linux.go b/src/runtime/os_linux.go
-index c9d25a5be8..f9fe1b5f33 100644
---- a/src/runtime/os_linux.go
-+++ b/src/runtime/os_linux.go
-@@ -487,7 +487,8 @@ func setsig(i uint32, fn uintptr) {
- 	sigfillset(&sa.sa_mask)
- 	// Although Linux manpage says "sa_restorer element is obsolete and
- 	// should not be used". x86_64 kernel requires it. Only use it on
--	// x86.
-+	// x86. Note that on 386 this is cleared when using the C sigaction
-+	// function via cgo; see fixSigactionForCgo.
- 	if GOARCH == "386" || GOARCH == "amd64" {
- 		sa.sa_restorer = abi.FuncPCABI0(sigreturn__sigaction)
- 	}
-@@ -563,6 +564,21 @@ func sysSigaction(sig uint32, new, old *sigactiont) {
- //go:noescape
- func rt_sigaction(sig uintptr, new, old *sigactiont, size uintptr) int32
- 
-+// fixSigactionForCgo is called when we are using cgo to call the
-+// C sigaction function. On 386 the C function does not expect the
-+// SA_RESTORER flag to be set, and in some cases will fail if it is set:
-+// it will pass the SA_RESTORER flag to the kernel without passing
-+// the sa_restorer field. Since the C function will handle SA_RESTORER
-+// for us, we need not pass it. See issue #75253.
-+//
-+//go:nosplit
-+func fixSigactionForCgo(new *sigactiont) {
-+	if GOARCH == "386" && new != nil {
-+		new.sa_flags &^= _SA_RESTORER
-+		new.sa_restorer = 0
-+	}
-+}
-+
- func getpid() int
- func tgkill(tgid, tid, sig int)
- 
-diff --git a/src/runtime/sigaction.go b/src/runtime/sigaction.go
-index 2027ae80bf..1a99f7f3ec 100644
---- a/src/runtime/sigaction.go
-+++ b/src/runtime/sigaction.go
-@@ -2,7 +2,7 @@
- // Use of this source code is governed by a BSD-style
- // license that can be found in the LICENSE file.
- 
--//go:build (linux && !amd64 && !arm64 && !loong64 && !ppc64le) || (freebsd && !amd64)
-+//go:build (linux && !386 && !amd64 && !arm64 && !loong64 && !ppc64le) || (freebsd && !amd64)
- 
- package runtime
- 
-diff --git a/src/runtime/sys_linux_386.s b/src/runtime/sys_linux_386.s
-index d53be243fe..8e832687e0 100644
---- a/src/runtime/sys_linux_386.s
-+++ b/src/runtime/sys_linux_386.s
-@@ -410,6 +410,25 @@ TEXT runtime·rt_sigaction(SB),NOSPLIT,$0
- 	MOVL	AX, ret+16(FP)
- 	RET
- 
-+// Call the function stored in _cgo_sigaction using the GCC calling convention.
-+TEXT runtime·callCgoSigaction(SB),NOSPLIT,$0-16
-+	MOVL	_cgo_sigaction(SB), AX
-+	MOVL	sig+0(FP), BX
-+	MOVL	new+4(FP), CX
-+	MOVL	old+8(FP), DX
-+	MOVL	SP, SI // align stack to call C function
-+	SUBL	$32, SP
-+	ANDL	$~15, SP
-+	MOVL	BX, 0(SP)
-+	MOVL	CX, 4(SP)
-+	MOVL	DX, 8(SP)
-+	MOVL	SI, 12(SP)
-+	CALL	AX
-+	MOVL	12(SP), BX
-+	MOVL	BX, SP
-+	MOVL	AX, ret+12(FP)
-+	RET
-+
- TEXT runtime·sigfwd(SB),NOSPLIT,$12-16
- 	MOVL	fn+0(FP), AX
- 	MOVL	sig+4(FP), BX
--- 
-2.51.0
-
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
index 14ed617..0b5026f 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
 index 2d8f964f35..dfc72e02c0 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1628,6 +1628,7 @@ func (ctxt *Link) hostlink() {
+@@ -1652,6 +1652,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -30,7 +30,7 @@ index 2d8f964f35..dfc72e02c0 100644
  			if ctxt.HeadType == objabi.Hwindows {
  				argv = addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1643,6 +1644,7 @@ func (ctxt *Link) hostlink() {
+@@ -1667,6 +1668,7 @@ func (ctxt *Link) hostlink() {
  			argv = append(argv, "-Wl,-z,relro")
  		}
  		argv = append(argv, "-shared")
@@ -38,7 +38,7 @@ index 2d8f964f35..dfc72e02c0 100644
  	case BuildModePlugin:
  		if ctxt.HeadType == objabi.Hdarwin {
  			argv = append(argv, "-dynamiclib")
-@@ -1651,6 +1653,7 @@ func (ctxt *Link) hostlink() {
+@@ -1675,6 +1677,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
diff --git a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
index 42bfa8e..7c8923f 100644
--- a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
+++ b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
@@ -87,7 +87,7 @@ index b62e518030..0c54d82300 100644
  	xatexit(func() {
  		if files := xreaddir(goosGoarch); len(files) == 0 {
  			xremove(goosGoarch)
-@@ -1420,14 +1426,20 @@ func cmdbootstrap() {
+@@ -1415,14 +1421,20 @@ func cmdbootstrap() {
  	defer timelog("end", "dist bootstrap")
  
  	var debug, distpack, force, noBanner, noClean bool
@@ -109,7 +109,7 @@ index b62e518030..0c54d82300 100644
  
  	if noClean {
  		xprintf("warning: --no-clean is deprecated and has no effect; use 'go install std cmd' instead\n")
-@@ -1439,6 +1451,18 @@ func cmdbootstrap() {
+@@ -1434,6 +1446,18 @@ func cmdbootstrap() {
  			"Use the -force flag to build anyway.\n", goos, goarch)
  	}
  
@@ -128,7 +128,7 @@ index b62e518030..0c54d82300 100644
  	// Set GOPATH to an internal directory. We shouldn't actually
  	// need to store files here, since the toolchain won't
  	// depend on modules outside of vendor directories, but if
-@@ -1517,9 +1541,14 @@ func cmdbootstrap() {
+@@ -1512,9 +1536,14 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  
@@ -143,7 +143,7 @@ index b62e518030..0c54d82300 100644
  	goBootstrap := pathf("%s/go_bootstrap", tooldir)
  	if debug {
  		run("", ShowOutput|CheckExit, pathf("%s/compile", tooldir), "-V=full")
-@@ -1547,7 +1576,11 @@ func cmdbootstrap() {
+@@ -1542,7 +1571,11 @@ func cmdbootstrap() {
  		xprintf("\n")
  	}
  	xprintf("Building Go toolchain2 using go_bootstrap and Go toolchain1.\n")
@@ -155,7 +155,7 @@ index b62e518030..0c54d82300 100644
  	// Now that cmd/go is in charge of the build process, enable GOEXPERIMENT.
  	os.Setenv("GOEXPERIMENT", goexperiment)
  	// No need to enable PGO for toolchain2.
-@@ -1600,6 +1633,7 @@ func cmdbootstrap() {
+@@ -1595,6 +1628,7 @@ func cmdbootstrap() {
  		os.Setenv("GOCACHE", oldgocache)
  	}
  
@@ -163,7 +163,7 @@ index b62e518030..0c54d82300 100644
  	if goos == oldgoos && goarch == oldgoarch {
  		// Common case - not setting up for cross-compilation.
  		timelog("build", "toolchain")
-@@ -1643,6 +1677,42 @@ func cmdbootstrap() {
+@@ -1638,6 +1672,42 @@ func cmdbootstrap() {
  		checkNotStale(toolenv(), goBootstrap, toolchain...)
  		copyfile(pathf("%s/compile4", tooldir), pathf("%s/compile", tooldir), writeExec)
  	}
@@ -206,7 +206,7 @@ index b62e518030..0c54d82300 100644
  
  	// Check that there are no new files in $GOROOT/bin other than
  	// go and gofmt and $GOOS_$GOARCH (target bin when cross-compiling).
-@@ -1665,8 +1735,12 @@ func cmdbootstrap() {
+@@ -1660,8 +1730,12 @@ func cmdbootstrap() {
  		}
  	}
  
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index 15ffdb3..e2a0cd6 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -32,7 +32,7 @@ diff --git a/src/cmd/go/internal/work/action.go b/src/cmd/go/internal/work/actio
 index 44bb9f8c1e..87ac4e30e5 100644
 --- a/src/cmd/go/internal/work/action.go
 +++ b/src/cmd/go/internal/work/action.go
-@@ -844,6 +844,9 @@ func (b *Builder) addTransitiveLinkDeps(a, a1 *Action, shlib string) {
+@@ -1076,6 +1076,9 @@ func (b *Builder) addTransitiveLinkDeps(s *modload.State, a, a1 *Action, shlib s
  			if p1 == nil || p1.Shlib == "" || haveShlib[filepath.Base(p1.Shlib)] {
  				continue
  			}
@@ -46,16 +46,16 @@ diff --git a/src/cmd/go/internal/work/build.go b/src/cmd/go/internal/work/build.
 index 3508d51fbb..77f5e7241a 100644
 --- a/src/cmd/go/internal/work/build.go
 +++ b/src/cmd/go/internal/work/build.go
-@@ -239,6 +239,8 @@ See also: go install, go get, go clean.
- 
- const concurrentGCBackendCompilationEnabledByDefault = true
+@@ -238,6 +238,8 @@ See also: go install, go get, go clean.
+ 	`,
+ }
  
 +var goRootPrecious bool = true
 +
  func init() {
  	// break init cycle
  	CmdBuild.Run = runBuild
-@@ -293,6 +295,10 @@ func init() {
+@@ -292,6 +294,10 @@ func init() {
  	case "gc", "gccgo":
  		buildCompiler{}.Set(build.Default.Compiler)
  	}
@@ -70,8 +70,8 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 1f618be0bb..651fa64582 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -558,6 +558,23 @@ func (b *Builder) build(ctx context.Context, a *Action) (err error) {
- 		return err
+@@ -605,6 +605,23 @@ func (b *Builder) checkCacheForBuild(a, buildAction *Action, covMetaFileName str
+ 		return nil, err
  	}
  
 +	if goRootPrecious && (a.Package.Standard || a.Package.Goroot) {
@@ -82,19 +82,19 @@ index 1f618be0bb..651fa64582 100644
 +			a.buildID = b.fileHash(a.Package.Target)
 +			a.Package.Stale = false
 +			a.Package.StaleReason = "GOROOT-resident package"
-+			return nil
++			return nil, err
 +		}
 +		a.Package.Stale = true
 +		a.Package.StaleReason = "missing or invalid GOROOT-resident package"
 +		if b.IsCmdList {
-+			return nil
++			return nil, err
 +		}
 +	}
 +
- 	if err := sh.Mkdir(a.Objdir); err != nil {
- 		return err
+ 	if err := sh.Mkdir(buildAction.Objdir); err != nil {
+ 		return nil, err
  	}
-@@ -1739,6 +1756,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1891,6 +1908,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index 7fe8d9d..2598a7b 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -19,7 +19,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 651fa64582..586079afb4 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1410,6 +1410,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1563,6 +1563,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -49,7 +49,7 @@ index 651fa64582..586079afb4 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1420,7 +1443,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1573,7 +1596,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
diff --git a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
index 7bb9757..140923f 100644
--- a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
+++ b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
@@ -20,7 +20,7 @@ diff --git a/src/cmd/go/internal/load/pkg.go b/src/cmd/go/internal/load/pkg.go
 index 15f6b2e87b..47c5b865a1 100644
 --- a/src/cmd/go/internal/load/pkg.go
 +++ b/src/cmd/go/internal/load/pkg.go
-@@ -2313,6 +2313,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
+@@ -2314,6 +2314,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
  	info.Settings = append(info.Settings, debug.BuildSetting{Key: key, Value: value})
  }
  
@@ -38,7 +38,7 @@ index 15f6b2e87b..47c5b865a1 100644
  // setBuildInfo gathers build information and sets it into
  // p.Internal.BuildInfo, which will later be formatted as a string and embedded
  // in the binary. setBuildInfo should only be called on a main package with no
-@@ -2420,7 +2431,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2421,7 +2432,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
  	if gcflags := BuildGcflags.String(); gcflags != "" && cfg.BuildContext.Compiler == "gc" {
  		appendSetting("-gcflags", gcflags)
  	}
@@ -47,7 +47,7 @@ index 15f6b2e87b..47c5b865a1 100644
  		// https://go.dev/issue/52372: only include ldflags if -trimpath is not set,
  		// since it can include system paths through various linker flags (notably
  		// -extar, -extld, and -extldflags).
-@@ -2466,7 +2477,7 @@ func (p *Package) setBuildInfo(ctx context.Context, autoVCS bool) {
+@@ -2467,7 +2478,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
  	// subset of flags that are known not to be paths?
  	if cfg.BuildContext.CgoEnabled && !cfg.BuildTrimpath {
  		for _, name := range []string{"CGO_CFLAGS", "CGO_CPPFLAGS", "CGO_CXXFLAGS", "CGO_LDFLAGS"} {
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
index ac70abd..33e91bb 100644
--- a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -23,28 +23,26 @@ Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/653895]
 
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
- src/cmd/go/internal/work/gc.go | 9 ++++++++-
- 1 file changed, 8 insertions(+), 1 deletion(-)
+ src/cmd/go/internal/work/gc.go | 6 ++++++
+ 1 file changed, 6 insertions(+)
 
 diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
 index 3a173efee8..8b7a44e031 100644
 --- a/src/cmd/go/internal/work/gc.go
 +++ b/src/cmd/go/internal/work/gc.go
-@@ -727,7 +727,13 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+@@ -717,6 +717,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
  	// the output file path is recorded in the .gnu.version_d section.
  	dir, targetPath := filepath.Split(targetPath)
  
--	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
 +	// When -trimpath is used, GOROOT is cleared
 +	if cfg.BuildTrimpath {
 +		cfgChangedEnv = append(cfgChangedEnv, "GOROOT=")
 +	} else {
 +		cfgChangedEnv = append(cfgChangedEnv, "GOROOT="+cfg.GOROOT)
 +	}
-+	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
+ 	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
  }
  
- func (gcToolchain) cc(b *Builder, a *Action, ofile, cfile string) error {
 -- 
 2.25.1
 
diff --git a/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch b/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
index 8cf645c..dda0f2b 100644
--- a/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
+++ b/recipes-devtools/go/go/0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch
@@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
 index dfc72e02c0..2a2a304113 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1677,27 +1677,6 @@ func (ctxt *Link) hostlink() {
+@@ -1701,27 +1701,6 @@ func (ctxt *Link) hostlink() {
  			// Use lld to avoid errors from default linker (issue #38838)
  			altLinker = "lld"
  		}
diff --git a/recipes-devtools/go/go_1.25.7.bb b/recipes-devtools/go/go_1.26.0.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.7.bb
rename to recipes-devtools/go/go_1.26.0.bb

