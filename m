Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1774.1792707524125846801
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 15:18:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=KPfd2kUr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-202610222218428acc66d318000207eb-cro4hz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202610222218428acc66d318000207eb
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 23 Oct 2026 00:18:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q4I6T/u+anjoEplJ6sqg6WI7DtzUrifInUGnMaEXuAA=;
 b=KPfd2kUruzU7B1Ck1E6COmoG5b27C9VvE38fpvwMx6Qph1jgscGOm1T8IMJbLL3gg2hqOA
 8Ty3fJ3fQck9HK0Rp1XXFNXd6Oywq1FCzpnykf7fwhX0KJa6ZF9l5IyxFHMiQK1NJ89Ly06R
 0xJ0u1PQ3YkkWJ6XasZ79JE43rV4Yjl7G7uT+mJIfdmFVevDl7zpxPnFfnoqHcL0IULF9P24
 +eoR1BYraAqiI2AunX6ovQGjws4eXi3e/YvgdnUUkkWu0ziHg0CQq9ebFZLfywIxxHtP/bNR
 OnFXWMVPkZq6zztklMmrm4FczMlPojPorQ/ApXA6w5HAQVtNC7y7WuvA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 2/3] go: upgrade 1.27.1 -> 1.27.2
Date: Fri, 23 Oct 2026 00:17:57 +0200
Message-ID: <20261022221758.3539336-2-peter.marko@siemens.com>
In-Reply-To: <20261022221758.3539336-1-peter.marko@siemens.com>
References: <20261022221758.3539336-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 22:18:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5138
Content-Type: text/plain; charset="utf-8"

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.27.x release [1]:

$ git --no-pager log --oneline go1.27.1..go1.27.2
022c863611 (tag: go1.27.2) [release-branch.go1.27] go1.27.2
cbb0fb8b51 [release-branch.go1.27] net/http: apply header limits to Trailer headers too
12acaf3086 [release-branch.go1.27] net/http/internal/http2: prevent crash due to HPACK encoder race
31dc9e2449 [release-branch.go1.27] net/http/internal/http2: avoid 2x refund on stream close with buffered data
1d58cdaa10 [release-branch.go1.27] net/http/internal/http2: avoid excessive work on initial window changes
ababc3cd87 [release-branch.go1.27] net/http: limit the size of range headers parsed in ServeContent
9636ab0f17 [release-branch.go1.27] os: correct Root junction handling on Windows (avoid mkdir escape)
e92229e24a [release-branch.go1.27] net/http: avoid server reuse of connection after CONNECT
76875df0f3 [release-branch.go1.27] net/http, net/http/httputil: avoid post-CONNECT pool corruption
7c79b50a74 [release-branch.go1.27] net/textproto: enforce MIME memory limit on first line
f022e61963 [release-branch.go1.27] crypto/tls: validate ECH outer extension references
68fa7699a2 [release-branch.go1.27] cmd/go: always verify toolchain downloads with sumdb
1e4f1fec6f [release-branch.go1.27] cmd/go: bundle go.sum h1 hashes for golang.org/fips140
6e2cfab0a1 [release-branch.go1.27] html/template: recognize `yield` as regexp preceder keyword
b26d150e69 [release-branch.go1.27] html/template: reset JS context for template expressions
bd9992d1d1 [release-branch.go1.27] cmd/link: pass -no_fixup_chains to C linker when building plugin on macOS
ce0ff94df1 [release-branch.go1.27] cmd/cover: preserve statement counts when splitting coverage blocks
87b06e2c18 [release-branch.go1.27] runtime: create Windows threads on the system stack
9c26a3af46 [release-branch.go1.27] cmd/internal/obj/ppc64: fix async preempt safepoint bug
b73c143090 [release-branch.go1.27] cmd/compile: use a 32-bit type for rewritten rotate amounts
8ada93d797 [release-branch.go1.27] encoding/json: fix UnsupportedValueError.Value regression
d995fb820d [release-branch.go1.27] net/http: populate Request.TLS from HTTP/2 connection state
322f1785b0 [release-branch.go1.27] encoding/json/v2: avoid setting with errors parsing float
bc516c2b36 [release-branch.go1.27] cmd/go: include VetxOnly in the vet action ID
4e4eec75bd [release-branch.go1.27] os: preserve completion notification modes for NewFile handles
359bec41ae [release-branch.go1.27] cmd/compile: support unified V5 export data (method indices)
bd8f7a67b7 [release-branch.go1.27] cmd: vendor changes for "go fix"
fa3bd01f47 [release-branch.go1.27] cmd/compile: call racefuncexit before a tail call
aee72efe29 [release-branch.go1.27] testing: escape framing markers only in test2json mode
620e2e0a1a [release-branch.go1.27] runtime: keep the working directory for non-bundled ios/arm64 binaries
d16d95ce1d [release-branch.go1.27] compress/flate: do not emit the preset dictionary into the output
e89d44fee0 [release-branch.go1.27] os: handle unsupported OBJ_DONT_REPARSE on older Windows
c407a15ec8 [release-branch.go1.27] cmd/compile: don't stack-allocate a slice whose element interior escapes
ff5898f7aa [release-branch.go1.27] internal/runtime/syscall/linux: sync EpollEvent with the kernel header
072779d815 [release-branch.go1.27] net/http/internal/http2: delete malformed framing-related headers
2e4b38eeb8 [release-branch.go1.27] net/http: discard trailer when draining a response body
8cd5a090e0 [release-branch.go1.27] net/http: return nil from Body.Close after a failed Read
db5314201a [release-branch.go1.27] net/http: read Response before signaling eofc in readLoop
aa6fc252ed [release-branch.go1.27] net/http: fix HTTP/1 deadlock on concurrent response body Read and Close
1cfd8f0112 [release-branch.go1.27] encoding/json: avoid calling MarshalText on named string map keys
f8a45f672b [release-branch.go1.27] cmd/compile: fix large riscv64 move/zero
072330d2ed [release-branch.go1.27] cmd/compile: correctly mark interface calls as used for tail call wrappers
1e44a4c9d9 [release-branch.go1.27] runtime: don't add the itabs of a plugin twice
2ee6421c51 [release-branch.go1.27] runtime: netpoll: fix 32-bit little-endian eventfd type confusion
33c04bd7da [release-branch.go1.27] runtime: disable mutex profile during async preemption on windows
113a7a0a0f [release-branch.go1.27] crypto/mlkem: fix FIPS 130-3 CAST

Fixes CVE-2026-97032, CVE-2026-78659, CVE-2026-97031, CVE-2026-94444,
      CVE-2026-94447, CVE-2026-94448, CVE-2026-97030, CVE-2026-94440,
      CVE-2026-56866, CVE-2026-94439, CVE-2026-78669, CVE-2026-78660,
      CVE-2026-56857, CVE-2026-78667 and CVE-2026-78663.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.27.1...go1.27.2
[2] https://groups.google.com/g/golang-announce/c/U2fTuyDJznI

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 9908e0891f364a598365b86a9dd48b1ef1606e47)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.27.1.inc => go-1.27.2.inc}      | 2 +-
 ...binary-native_1.27.1.bb => go-binary-native_1.27.2.bb} | 6 +++---
 ...oss-canadian_1.27.1.bb => go-cross-canadian_1.27.2.bb} | 0
 .../go/{go-cross_1.27.1.bb => go-cross_1.27.2.bb}         | 0
 .../go/{go-crosssdk_1.27.1.bb => go-crosssdk_1.27.2.bb}   | 0
 .../go/{go-runtime_1.27.1.bb => go-runtime_1.27.2.bb}     | 0
 ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
 .../go/go/0003-ld-add-soname-to-shareable-objects.patch   | 6 +++---
 .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
 ....go-filter-out-build-specific-paths-from-linker-.patch | 4 ++--
 ...rnal-cgrouptest-skip-when-cpu.max-is-not-availab.patch | 6 +++---
 recipes-devtools/go/{go_1.27.1.bb => go_1.27.2.bb}        | 0
 12 files changed, 17 insertions(+), 17 deletions(-)
 rename recipes-devtools/go/{go-1.27.1.inc => go-1.27.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.27.1.bb => go-binary-native_1.27.2.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.27.1.bb => go-cross-canadian_1.27.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.27.1.bb => go-cross_1.27.2.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.27.1.bb => go-crosssdk_1.27.2.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.27.1.bb => go-runtime_1.27.2.bb} (100%)
 rename recipes-devtools/go/{go_1.27.1.bb => go_1.27.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.27.1.inc b/recipes-devtools/go/go-1.27.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.27.1.inc
rename to recipes-devtools/go/go-1.27.2.inc
index d7ba03b..86598ad 100644
--- a/recipes-devtools/go/go-1.27.1.inc
+++ b/recipes-devtools/go/go-1.27.2.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch \
 "
-SRC_URI[main.sha256sum] = "4e408abae126d916b6164627193f2c54f0e3ca1312d693b86db45f862ab238b1"
+SRC_URI[main.sha256sum] = "03495da2ba64894d40f5c4992e49454fa78b50690604ff92b6afff5081b76e62"
diff --git a/recipes-devtools/go/go-binary-native_1.27.1.bb b/recipes-devtools/go/go-binary-native_1.27.2.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.27.1.bb
rename to recipes-devtools/go/go-binary-native_1.27.2.bb
index 57267b5..d4cb9f3 100644
--- a/recipes-devtools/go/go-binary-native_1.27.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.27.2.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "63d339f0da5ab53635a56f2490a7984dfe12dfcff22ad749f63edaf590168445"
-SRC_URI[go_linux_arm64.sha256sum] = "3450b45a3f9ee8568792736a5c5e70a1f2e9b36c35a8f74958c03e51d7d92bec"
-SRC_URI[go_linux_ppc64le.sha256sum] = "ad1ff83c24f783c2d4a025852b928a05c199e8742a14a5482d88de0293d2bd0d"
+SRC_URI[go_linux_amd64.sha256sum] = "ecbadb99091a3f46e31f5f934b068b1864eafa7995211b39eaddf76996045fe5"
+SRC_URI[go_linux_arm64.sha256sum] = "94f3e30b8e374bc285e7dadc11e0865726b9bc6e85b841ccceaabc0214c6b7c8"
+SRC_URI[go_linux_ppc64le.sha256sum] = "059d5f01b1607a724ea5ae87c5589041a51c577a6f3f20099e49d00f31c803fa"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.27.1.bb b/recipes-devtools/go/go-cross-canadian_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.27.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.27.2.bb
diff --git a/recipes-devtools/go/go-cross_1.27.1.bb b/recipes-devtools/go/go-cross_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.27.1.bb
rename to recipes-devtools/go/go-cross_1.27.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.27.1.bb b/recipes-devtools/go/go-crosssdk_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.27.1.bb
rename to recipes-devtools/go/go-crosssdk_1.27.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.27.1.bb b/recipes-devtools/go/go-runtime_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.27.1.bb
rename to recipes-devtools/go/go-runtime_1.27.2.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
index 6372b78..92e2a1b 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -108,7 +108,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	}
  
  	// Configuration specific to compiler toolchain.
-@@ -2838,8 +2840,25 @@ func envList(key, def string) []string {
+@@ -2839,8 +2841,25 @@ func envList(key, def string) []string {
  	return args
  }
  
@@ -135,7 +135,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
  		return
  	}
-@@ -2855,6 +2874,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+@@ -2856,6 +2875,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
  	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
  		return
  	}
@@ -149,7 +149,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  
  	return
  }
-@@ -2943,7 +2969,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+@@ -2944,7 +2970,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
  	cgoExe := base.Tool("cgo")
  	cgofiles = mkAbsFiles(p.Dir, cgofiles)
  
@@ -158,7 +158,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if err != nil {
  		return err
  	}
-@@ -3501,7 +3527,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+@@ -3502,7 +3528,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
  	p := a.Package
  	sh := b.Shell(a)
  
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
index 59ae99c..2e46e22 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
 index 9cbc12919f1d..0f33521777d1 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1672,6 +1672,7 @@ func (ctxt *Link) hostlink() {
+@@ -1680,6 +1680,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
@@ -30,7 +30,7 @@ index 9cbc12919f1d..0f33521777d1 100644
  			if ctxt.HeadType == objabi.Hwindows {
  				argv = addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1687,6 +1688,7 @@ func (ctxt *Link) hostlink() {
+@@ -1695,6 +1696,7 @@ func (ctxt *Link) hostlink() {
  			argv = append(argv, "-Wl,-z,relro")
  		}
  		argv = append(argv, "-shared")
@@ -38,7 +38,7 @@ index 9cbc12919f1d..0f33521777d1 100644
  	case BuildModePlugin:
  		if ctxt.HeadType == objabi.Hdarwin {
  			argv = append(argv, "-dynamiclib")
-@@ -1695,6 +1697,7 @@ func (ctxt *Link) hostlink() {
+@@ -1703,6 +1705,7 @@ func (ctxt *Link) hostlink() {
  				argv = append(argv, "-Wl,-z,relro")
  			}
  			argv = append(argv, "-shared")
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
index 74fd1fa..77b4bed 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -94,7 +94,7 @@ index 617b7ece73f0..46c0712c5bd0 100644
  	if err := sh.Mkdir(buildAction.Objdir); err != nil {
  		return nil, err
  	}
-@@ -1922,6 +1939,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+@@ -1923,6 +1940,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
  		return err
  	}
  
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
index 0cc770a..e6a5ce5 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -18,7 +18,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
 index 46c0712c5bd0..e7c0459ee4c0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1597,6 +1597,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+@@ -1598,6 +1598,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
  	return h.Sum()
  }
  
@@ -48,7 +48,7 @@ index 46c0712c5bd0..e7c0459ee4c0 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1607,7 +1630,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1608,7 +1631,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
  		if p != nil {
diff --git a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch
index f13cf78..cf6283b 100644
--- a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch
+++ b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch
@@ -21,13 +21,13 @@ Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/src/internal/cgrouptest/cgrouptest_linux.go b/src/internal/cgrouptest/cgrouptest_linux.go
-index ad9599c..a4b9b52 100644
+index ad9599c9..a4b9b52d 100644
 --- a/src/internal/cgrouptest/cgrouptest_linux.go
 +++ b/src/internal/cgrouptest/cgrouptest_linux.go
 @@ -82,6 +82,12 @@ func InCgroupV2(t *testing.T, fn func(*CgroupV2)) {
  		}
  	}()
-
+ 
 +	// cpu.max only exists when the kernel supports CPU bandwidth control
 +	// (CONFIG_CFS_BANDWIDTH), even if the cpu controller is enabled.
 +	if _, err := os.Stat(filepath.Join(path, "cpu.max")); err != nil {
@@ -36,4 +36,4 @@ index ad9599c..a4b9b52 100644
 +
  	migrateTo(t, path)
  	defer migrateTo(t, orig)
-
+ 
diff --git a/recipes-devtools/go/go_1.27.1.bb b/recipes-devtools/go/go_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.27.1.bb
rename to recipes-devtools/go/go_1.27.2.bb
