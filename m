Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18.1794940685514334532
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Nov 2026 10:38:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=WNtMVSqg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20261117183802496279dddc000207ad-gp9bo_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261117183802496279dddc000207ad
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 17 Nov 2026 19:38:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9lwmVhQaF44Tp06w8rE69pjWhPNdTvsjONCJ46nUN7Q=;
 b=WNtMVSqgEA4m8OJLMggw7tS4hHK+hj6lHmje/qUr6XIoVbLB1HwhoBujGzS+yOFWlKpJ93
 ymXLNgrdqh/a1nYep0BuQ3YGDij09hDSIfTgxyj2TuUOOC/7uQTk6cWG6MlXUQSaVsJcFRI2
 T7C40hRJPNj8JUqPM77Lt/oOjycDqjLA4BDPHoLj9EnyVIbzh8W2rU9jT0+dwK2OmNFr0E9P
 wv8m9UhNHLTu2kae9IEU0J25R/GO1oyZEp39+hTFBKfCgTr/ePyMxBxa7D1MqqPBR5TCCpt8
 4ERTrhLPLuY5qzIEQKFfASF23gig8wFwVzhQ7J/1+OmC80V8j2/8So0g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.27.3 -> 1.27.4
Date: Tue, 17 Nov 2026 19:37:58 +0100
Message-ID: <20261117183758.3683114-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 18:38:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5465
Content-Type: text/plain; charset="utf-8"

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.27.x release [1]:

$ git --no-pager log --oneline go1.27.3..go1.27.4
7b2881024c (tag: go1.27.4) [release-branch.go1.27] go1.27.4
4c1752a033 [release-branch.go1.27] net/http: prevent HTTP/1 server crash due to MaxBytesReader header race
3eb71096dd [release-branch.go1.27] cmd/go, cmd/compile: unquote //go:cgo_ldflag and bound slice removal
e6ea940f9b [release-branch.go1.27] cmd/cgo, cmd/compile, cmd/link: validate cgo_import_dynamic library names
55515b6fe4 [release-branch.go1.27] cmd/compile, cmd/link: validate cgo symbol names and prevent export overwrite
b207530349 [release-branch.go1.27] cmd/go, cmd/link: reject .syso files with Go object or unrecognized formats
e7b9584fec [release-branch.go1.27] cmd/go: disallow pkg-config local .pc paths and inspect cgoCPPFLAGS
51dadca52c [release-branch.go1.27] cmd/go: validate .syso and linker input files against scripts and embedded options
5f05d301a7 [release-branch.go1.27] cmd/go: validate split -Wl, next-arg flags and linker script targets
0edfcc8731 [release-branch.go1.27] cmd/go: disallow separated -l flag followed by to_library
cbd457366f [release-branch.go1.27] cmd/go: disallow -gen-* and -gnat* in flag allowlists
c5426cee10 [release-branch.go1.27] cmd/go: reject GCC spec files in linker search directories
8e7ba03754 [release-branch.go1.27] cmd/go: disallow --sysroot and -target, validate -isysroot/-syslibroot, and restrict -x
251c4ee2e8 [release-branch.go1.27] runtime: match deferring function when looking for linked defers in nextFrame
1bf5d09e4f [release-branch.go1.27] crypto/tls: omit ML-DSA from signature_algorithms_cert
5f0af78b52 [release-branch.go1.27] cmd/compile: record method indices before encoding a named type
c56bcdef12 [release-branch.go1.27] crypto/internal/fips140/sha3: record legacy Keccak as non-approved
bb19eae15c [release-branch.go1.27] crypto/internal/fips140/tls12: record SHA-384 as approved in MasterSecret
96f62c8958 [release-branch.go1.27] crypto/hkdf: remove unnecessary HMAC key length allowance for HKDF-Expand
4d34001816 [release-branch.go1.27] crypto/rsa: apply FIPS 140-3 approved checks to MGF hash in OAEP
caa055b6a4 [release-branch.go1.27] crypto/internal/fips140: run CASTs when generating keys
41d6346743 [release-branch.go1.27] net: fix zero value address handling in Dialer.Dial{TCP,UDP,IP}
8b28706da8 [release-branch.go1.27] cmd/compile: teach deadstore about CondSelect
c1ff416cd8 [release-branch.go1.27] Revert "runtime: fix timespec definition on 32bits systems"
a0c618c225 [release-branch.go1.27] cmd/internal/obj/x86: clear forward-jump list on PCALIGN
62cbde4f2f [release-branch.go1.27] cmd/dist: fix GOFIPS140 toolchain compilation

Fixes CVE-2026-97054, CVE-2026-97033, CVE-2026-97034, CVE-2026-97035,
      CVE-2026-97036, CVE-2026-97037, CVE-2026-97038, CVE-2026-97039,
      CVE-2026-97040, CVE-2026-97041, CVE-2026-97042, CVE-2026-97043.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.27.3...go1.27.4
[2] https://groups.google.com/g/golang-announce/c/iY8TY0wWgbM

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 1c55f09c670898f39df7862192b536b09786b05b)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.27.3.inc => go-1.27.4.inc} |  2 +-
 ...y-native_1.27.3.bb => go-binary-native_1.27.4.bb} |  6 +++---
 ...anadian_1.27.3.bb => go-cross-canadian_1.27.4.bb} |  0
 .../go/{go-cross_1.27.3.bb => go-cross_1.27.4.bb}    |  0
 .../{go-crosssdk_1.27.3.bb => go-crosssdk_1.27.4.bb} |  0
 .../{go-runtime_1.27.3.bb => go-runtime_1.27.4.bb}   |  0
 ...ke-content-based-hash-generation-less-pedan.patch | 12 ++++++------
 ...0006-cmd-go-make-GOROOT-precious-by-default.patch |  2 +-
 ...ilter-out-build-specific-paths-from-linker-.patch |  4 ++--
 ...ear-GOROOT-for-func-ldShared-when-trimpath-.patch |  2 +-
 recipes-devtools/go/{go_1.27.3.bb => go_1.27.4.bb}   |  0
 11 files changed, 14 insertions(+), 14 deletions(-)
 rename recipes-devtools/go/{go-1.27.3.inc => go-1.27.4.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.27.3.bb => go-binary-native_1.27.4.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.27.3.bb => go-cross-canadian_1.27.4.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.27.3.bb => go-cross_1.27.4.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.27.3.bb => go-crosssdk_1.27.4.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.27.3.bb => go-runtime_1.27.4.bb} (100%)
 rename recipes-devtools/go/{go_1.27.3.bb => go_1.27.4.bb} (100%)

diff --git a/recipes-devtools/go/go-1.27.3.inc b/recipes-devtools/go/go-1.27.4.inc
similarity index 91%
rename from recipes-devtools/go/go-1.27.3.inc
rename to recipes-devtools/go/go-1.27.4.inc
index 7c906e8..3e987ea 100644
--- a/recipes-devtools/go/go-1.27.3.inc
+++ b/recipes-devtools/go/go-1.27.4.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch \
 "
-SRC_URI[main.sha256sum] = "6e7749035cf360f06b2575d162ea79df9fda8ef671889e5c375f8e50777f26bb"
+SRC_URI[main.sha256sum] = "73cfb8571aec0c01177687db87163d46aa20e9779672772891aa17654d9a6099"
diff --git a/recipes-devtools/go/go-binary-native_1.27.3.bb b/recipes-devtools/go/go-binary-native_1.27.4.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.27.3.bb
rename to recipes-devtools/go/go-binary-native_1.27.4.bb
index cc4664e..55cf81a 100644
--- a/recipes-devtools/go/go-binary-native_1.27.3.bb
+++ b/recipes-devtools/go/go-binary-native_1.27.4.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "65efbc80fdc1fa2cd2631cad5b481777a68e8725f34e89f50fc6ac714e379b40"
-SRC_URI[go_linux_arm64.sha256sum] = "a06e99309dbcbdca1a8ccd2282c3ee146e55930886e26b4f1193269587165f49"
-SRC_URI[go_linux_ppc64le.sha256sum] = "f180f01943865b7942ab3b4acbab6da6f0f669b61da999d004d16c537a49f7b5"
+SRC_URI[go_linux_amd64.sha256sum] = "7226736c2339719cda28fbf3a54d71aa63bcefe376e98cef00034268dab24840"
+SRC_URI[go_linux_arm64.sha256sum] = "3392582988a273a87ab5043ee1b2c9c17a2c3c00580bf9326c47a2e0aaaeac92"
+SRC_URI[go_linux_ppc64le.sha256sum] = "f508314644fa6f466d1935f8a34f01e7980092a4730bfb9d7fa3ffde81910d20"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.27.3.bb b/recipes-devtools/go/go-cross-canadian_1.27.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.27.3.bb
rename to recipes-devtools/go/go-cross-canadian_1.27.4.bb
diff --git a/recipes-devtools/go/go-cross_1.27.3.bb b/recipes-devtools/go/go-cross_1.27.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.27.3.bb
rename to recipes-devtools/go/go-cross_1.27.4.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.27.3.bb b/recipes-devtools/go/go-crosssdk_1.27.4.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.27.3.bb
rename to recipes-devtools/go/go-crosssdk_1.27.4.bb
diff --git a/recipes-devtools/go/go-runtime_1.27.3.bb b/recipes-devtools/go/go-runtime_1.27.4.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.27.3.bb
rename to recipes-devtools/go/go-runtime_1.27.4.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index 92e2a1b..07ae689 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -108,7 +108,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2839,8 +2841,25 @@ func envList(key, def string) []string {
+@@ -2845,8 +2847,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -135,9 +135,9 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2856,6 +2875,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
- 	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
- 		return
+@@ -2867,6 +2886,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+ 			return
+ 		}
  	}
 +	if filtered {
 +		cppflags = filterCompilerFlags(cppflags, false)
@@ -149,7 +149,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  
  	return
  }
-@@ -2944,7 +2970,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+@@ -2955,7 +2981,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
  	cgoExe := base.Tool("cgo")
  	cgofiles = mkAbsFiles(p.Dir, cgofiles)
  
@@ -158,7 +158,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if err != nil {
  		return err
  	}
-@@ -3502,7 +3528,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3523,7 +3549,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index 77b4bed..5df9e17 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -94,7 +94,7 @@ index 617b7ece73f0..46c0712c5bd0 100644
  	if err := sh.Mkdir(buildAction.Objdir); err != nil {
  		return nil, err
  	}
-@@ -1923,6 +1940,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1929,6 +1946,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index e6a5ce5..c5c4f35 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -18,7 +18,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 46c0712c5bd0..e7c0459ee4c0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1598,6 +1598,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1604,6 +1604,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -48,7 +48,7 @@ index 46c0712c5bd0..e7c0459ee4c0 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1608,7 +1631,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1614,7 +1637,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
index 6e71187..56b040a 100644
--- a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -29,7 +29,7 @@ diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
 index 49b26e15609b..7c0d2ac9e0f0 100644
 --- a/src/cmd/go/internal/work/gc.go
 +++ b/src/cmd/go/internal/work/gc.go
-@@ -721,6 +721,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+@@ -725,6 +725,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
  	// the output file path is recorded in the .gnu.version_d section.
  	dir, targetPath := filepath.Split(targetPath)
  
diff --git a/recipes-devtools/go/go_1.27.3.bb b/recipes-devtools/go/go_1.27.4.bb
similarity index 100%
rename from recipes-devtools/go/go_1.27.3.bb
rename to recipes-devtools/go/go_1.27.4.bb
