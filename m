Return-Path: <antoine.lubineau@easymile.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE7CCF2E5
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 14:59:02 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36910.1792421941613595386
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 07:59:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@easymile.com header.s=easymile header.b=UbVKbgua;
 spf=pass (domain: easymile.com, ip: 209.85.221.43, mailfrom: antoine.lubineau@easymile.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso1712201f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easymile.com; s=easymile; t=1792421939; x=1793026739; darn=lists.yoctoproject.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wdTRh668ejk1ipm9NAptpLns1rP2gsTRcd8rEzA5mXI=;
        b=UbVKbguazXF47szLjSGIu+QFJOXoA7ju/O4j5U9pSTzy0kfAo46Qb0KAqDSdl2MeHO
         L3aJGBzBTr+IXW/7d8xX7J4JIva/u6z3auMZKYgQa9A2+ID9RtzpvQ2R2Iahm4X60mqV
         z4evacBQKaCLZjkY527YiajcilFpfF02cZ4R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421939; x=1793026739;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdTRh668ejk1ipm9NAptpLns1rP2gsTRcd8rEzA5mXI=;
        b=yWoOYs1VTPGbJbcIDGMx2kEdIIKOBCmZ2Z/bfbiM9m/cEfXhep+CWp0DB7XcTmjg+X
         60oQIhMObIyIEGdPth4rIcxbhgDmNPB9Gs00seFRIZGwQ0h0YeFhRC70b3yd44htxRoe
         NVeAUzdfABw1dj4z94oSFAHeWEqIFrTTac21cd4ZXw2s9fqDTrM4e9hOt6o5owSVBLgx
         tBEN24SRW8xVA829c1WXuxyIWKiTncc3/MCjXZQCTcLoM1jf/spX5CNaOeEylXybudup
         4LuKaMnw4dEcF5l9LKqGSaA62uhwjTbEpnqfYqDHUCcjTwjELcNC1gGZiXqeLF1kEaIk
         vm8g==
X-Gm-Message-State: AFq9FYI2qj3WW0/EEdm0tYH0Ik9SFshqzwICec5tL4Ye0ZAGP7As85d5
	oi4LcPHfTs5YQ/pm3harczKLKdMhBzb9zsnQmL9YpPhXlne8vT1BqEFnNBd0/eTp6tsinYDMoB6
	zClki3qWBfpvSjemwK+hUZo3tNFyrUtu/cc2ce4f2KPpjIA5ZrHgHthJFtmWKT01yvJ+7/PXWdL
	JJ+7aEynC1aLv0cGPtLWzhGsNCfD2ami9reoorc/TM4fQjeQ85oEEA4VUvCmX3RwFd6ZAItoXZB
	Ug=
X-Gm-Gg: AYBFou3DPmhNVUAJ0GHJe6eGgnfzS4R4Tck3zXZjfz3hTcut1VqWuSb/i/6mEbwW6cG
	fRw2MxB/+5nmADEs4WskeNM5uZYC+9iz8QkoyPtxrLfzHCrHWKJ2IKIjhgQ2uIRZuzyHAn9ljD6
	uQafmGP+OZvGMGDFBEdfKjQXZO9tegKh1yTh6nYxaxN1P7+TtoiHOdh7UYYNIDajU5W2yozGLUw
	xqCj7KdpoGFmN9LeIKHzTkY3GL5z2ouKJA7rynOVnqW2M0J/TWHpoqNJXIMbPUTg+Z582nB5sd6
	H5wl6gkix3FVd7pZ77d8g8Oj9JlVtvwmDx0FU/RNJSNQ5LEy8f2BM6t1VWVu/hMEEVYGDgUmEtV
	AfCnbq5TuUdd9gBKqCuuIJCn4VBt8MlEm7lMnUKm1l8IQFx5m3pnEFFWCgboiHm3pQ2KrTnOx/d
	uJeUXsp5iYRU2d8+097L2hDgC/bcu8d4Rw3j3gK0ArQoAVnU4OR+VpNG9LHB3/KbR0b0+9VbD4j
	ReKt0nX2RF9S1vNBX1RCjy0OXg=
X-Received: by 2002:adf:ffc3:0:b0:48d:f3a4:a6aa with SMTP id ffacd0b85a97d-48e07bc36e1mr11956562f8f.35.1792421939205;
        Mon, 19 Oct 2026 07:58:59 -0700 (PDT)
Received: from fr001036.intrad.rvs.em.corp ([90.83.88.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1afbf534sm2211122f8f.35.2026.10.19.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:58:58 -0700 (PDT)
From: Antoine Lubineau <antoine.lubineau@easymile.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [meta-lts-mixins][wrynose/go][PATCH 2/2] go: upgrade 1.27.1 -> 1.27.2
Date: Mon, 19 Oct 2026 16:58:53 +0200
Message-ID: <20261019145853.154403-2-antoine.lubineau@easymile.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019145853.154403-1-antoine.lubineau@easymile.com>
References: <20261019145853.154403-1-antoine.lubineau@easymile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:59:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5099

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.27.x release [1]:

$ git --no-pager log --oneline go1.27.1..go1.27.2
022c863611 (tag: go1.27.2) [release-branch.go1.27] go1.27.2
cbb0fb8b51 [release-branch.go1.27] net/http: apply header limits to Trailer=
 headers too
12acaf3086 [release-branch.go1.27] net/http/internal/http2: prevent crash d=
ue to HPACK encoder race
31dc9e2449 [release-branch.go1.27] net/http/internal/http2: avoid 2x refund=
 on stream close with buffered data
1d58cdaa10 [release-branch.go1.27] net/http/internal/http2: avoid excessive=
 work on initial window changes
ababc3cd87 [release-branch.go1.27] net/http: limit the size of range header=
s parsed in ServeContent
9636ab0f17 [release-branch.go1.27] os: correct Root junction handling on Wi=
ndows (avoid mkdir escape)
e92229e24a [release-branch.go1.27] net/http: avoid server reuse of connecti=
on after CONNECT
76875df0f3 [release-branch.go1.27] net/http, net/http/httputil: avoid post-=
CONNECT pool corruption
7c79b50a74 [release-branch.go1.27] net/textproto: enforce MIME memory limit=
 on first line
f022e61963 [release-branch.go1.27] crypto/tls: validate ECH outer extension=
 references
68fa7699a2 [release-branch.go1.27] cmd/go: always verify toolchain download=
s with sumdb
1e4f1fec6f [release-branch.go1.27] cmd/go: bundle go.sum h1 hashes for gola=
ng.org/fips140
6e2cfab0a1 [release-branch.go1.27] html/template: recognize `yield` as rege=
xp preceder keyword
b26d150e69 [release-branch.go1.27] html/template: reset JS context for temp=
late expressions
bd9992d1d1 [release-branch.go1.27] cmd/link: pass -no_fixup_chains to C lin=
ker when building plugin on macOS
ce0ff94df1 [release-branch.go1.27] cmd/cover: preserve statement counts whe=
n splitting coverage blocks
87b06e2c18 [release-branch.go1.27] runtime: create Windows threads on the s=
ystem stack
9c26a3af46 [release-branch.go1.27] cmd/internal/obj/ppc64: fix async preemp=
t safepoint bug
b73c143090 [release-branch.go1.27] cmd/compile: use a 32-bit type for rewri=
tten rotate amounts
8ada93d797 [release-branch.go1.27] encoding/json: fix UnsupportedValueError=
.Value regression
d995fb820d [release-branch.go1.27] net/http: populate Request.TLS from HTTP=
/2 connection state
322f1785b0 [release-branch.go1.27] encoding/json/v2: avoid setting with err=
ors parsing float
bc516c2b36 [release-branch.go1.27] cmd/go: include VetxOnly in the vet acti=
on ID
4e4eec75bd [release-branch.go1.27] os: preserve completion notification mod=
es for NewFile handles
359bec41ae [release-branch.go1.27] cmd/compile: support unified V5 export d=
ata (method indices)
bd8f7a67b7 [release-branch.go1.27] cmd: vendor changes for "go fix"
fa3bd01f47 [release-branch.go1.27] cmd/compile: call racefuncexit before a =
tail call
aee72efe29 [release-branch.go1.27] testing: escape framing markers only in =
test2json mode
620e2e0a1a [release-branch.go1.27] runtime: keep the working directory for =
non-bundled ios/arm64 binaries
d16d95ce1d [release-branch.go1.27] compress/flate: do not emit the preset d=
ictionary into the output
e89d44fee0 [release-branch.go1.27] os: handle unsupported OBJ_DONT_REPARSE =
on older Windows
c407a15ec8 [release-branch.go1.27] cmd/compile: don't stack-allocate a slic=
e whose element interior escapes
ff5898f7aa [release-branch.go1.27] internal/runtime/syscall/linux: sync Epo=
llEvent with the kernel header
072779d815 [release-branch.go1.27] net/http/internal/http2: delete malforme=
d framing-related headers
2e4b38eeb8 [release-branch.go1.27] net/http: discard trailer when draining =
a response body
8cd5a090e0 [release-branch.go1.27] net/http: return nil from Body.Close aft=
er a failed Read
db5314201a [release-branch.go1.27] net/http: read Response before signaling=
 eofc in readLoop
aa6fc252ed [release-branch.go1.27] net/http: fix HTTP/1 deadlock on concurr=
ent response body Read and Close
1cfd8f0112 [release-branch.go1.27] encoding/json: avoid calling MarshalText=
 on named string map keys
f8a45f672b [release-branch.go1.27] cmd/compile: fix large riscv64 move/zero
072330d2ed [release-branch.go1.27] cmd/compile: correctly mark interface ca=
lls as used for tail call wrappers
1e44a4c9d9 [release-branch.go1.27] runtime: don't add the itabs of a plugin=
 twice
2ee6421c51 [release-branch.go1.27] runtime: netpoll: fix 32-bit little-endi=
an eventfd type confusion
33c04bd7da [release-branch.go1.27] runtime: disable mutex profile during as=
ync preemption on windows
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
Signed-off-by: Antoine Lubineau <antoine.lubineau@easymile.com>
---
 recipes-devtools/go/{go-1.27.1.inc =3D> go-1.27.2.inc}      | 2 +-
 ...binary-native_1.27.1.bb =3D> go-binary-native_1.27.2.bb} | 6 +++---
 ...oss-canadian_1.27.1.bb =3D> go-cross-canadian_1.27.2.bb} | 0
 .../go/{go-cross_1.27.1.bb =3D> go-cross_1.27.2.bb}         | 0
 .../go/{go-crosssdk_1.27.1.bb =3D> go-crosssdk_1.27.2.bb}   | 0
 .../go/{go-runtime_1.27.1.bb =3D> go-runtime_1.27.2.bb}     | 0
 ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
 .../go/go/0003-ld-add-soname-to-shareable-objects.patch   | 6 +++---
 .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
 ....go-filter-out-build-specific-paths-from-linker-.patch | 4 ++--
 ...rnal-cgrouptest-skip-when-cpu.max-is-not-availab.patch | 6 +++---
 recipes-devtools/go/{go_1.27.1.bb =3D> go_1.27.2.bb}        | 0
 12 files changed, 17 insertions(+), 17 deletions(-)
 rename recipes-devtools/go/{go-1.27.1.inc =3D> go-1.27.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.27.1.bb =3D> go-binary-nati=
ve_1.27.2.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.27.1.bb =3D> go-cross-cana=
dian_1.27.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.27.1.bb =3D> go-cross_1.27.2.bb} (1=
00%)
 rename recipes-devtools/go/{go-crosssdk_1.27.1.bb =3D> go-crosssdk_1.27.2.=
bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.27.1.bb =3D> go-runtime_1.27.2.bb=
} (100%)
 rename recipes-devtools/go/{go_1.27.1.bb =3D> go_1.27.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.27.1.inc b/recipes-devtools/go/go-1.2=
7.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.27.1.inc
rename to recipes-devtools/go/go-1.27.2.inc
index d7ba03b..86598ad 100644
--- a/recipes-devtools/go/go-1.27.1.inc
+++ b/recipes-devtools/go/go-1.27.2.inc
@@ -17,4 +17,4 @@ SRC_URI +=3D "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch=
 \
     file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch=
 \
 "
-SRC_URI[main.sha256sum] =3D "4e408abae126d916b6164627193f2c54f0e3ca1312d69=
3b86db45f862ab238b1"
+SRC_URI[main.sha256sum] =3D "03495da2ba64894d40f5c4992e49454fa78b50690604f=
f92b6afff5081b76e62"
diff --git a/recipes-devtools/go/go-binary-native_1.27.1.bb b/recipes-devto=
ols/go/go-binary-native_1.27.2.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.27.1.bb
rename to recipes-devtools/go/go-binary-native_1.27.2.bb
index f909581..19482f7 100644
--- a/recipes-devtools/go/go-binary-native_1.27.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.27.2.bb
@@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
=20
 # Checksums available at https://go.dev/dl/
 SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH=
}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] =3D "63d339f0da5ab53635a56f2490a7984dfe1=
2dfcff22ad749f63edaf590168445"
-SRC_URI[go_linux_arm64.sha256sum] =3D "3450b45a3f9ee8568792736a5c5e70a1f2e=
9b36c35a8f74958c03e51d7d92bec"
-SRC_URI[go_linux_ppc64le.sha256sum] =3D "ad1ff83c24f783c2d4a025852b928a05c=
199e8742a14a5482d88de0293d2bd0d"
+SRC_URI[go_linux_amd64.sha256sum] =3D "ecbadb99091a3f46e31f5f934b068b1864e=
afa7995211b39eaddf76996045fe5"
+SRC_URI[go_linux_arm64.sha256sum] =3D "94f3e30b8e374bc285e7dadc11e0865726b=
9bc6e85b841ccceaabc0214c6b7c8"
+SRC_URI[go_linux_ppc64le.sha256sum] =3D "059d5f01b1607a724ea5ae87c5589041a=
51c577a6f3f20099e49d00f31c803fa"
=20
 UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.27.1.bb b/recipes-devt=
ools/go/go-cross-canadian_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.27.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.27.2.bb
diff --git a/recipes-devtools/go/go-cross_1.27.1.bb b/recipes-devtools/go/g=
o-cross_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.27.1.bb
rename to recipes-devtools/go/go-cross_1.27.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.27.1.bb b/recipes-devtools/g=
o/go-crosssdk_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.27.1.bb
rename to recipes-devtools/go/go-crosssdk_1.27.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.27.1.bb b/recipes-devtools/go=
/go-runtime_1.27.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.27.1.bb
rename to recipes-devtools/go/go-runtime_1.27.2.bb
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-gen=
eration-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-=
based-hash-generation-less-pedan.patch
index 6372b78..92e2a1b 100644
--- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation=
-less-pedan.patch
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation=
-less-pedan.patch
@@ -108,7 +108,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	}
 =20
  	// Configuration specific to compiler toolchain.
-@@ -2838,8 +2840,25 @@ func envList(key, def string) []string {
+@@ -2839,8 +2841,25 @@ func envList(key, def string) []string {
  	return args
  }
 =20
@@ -135,7 +135,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkComp=
ilerFlags); err !=3D nil {
  		return
  	}
-@@ -2855,6 +2874,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags=
, cflags, cxxflags, fflags, l
+@@ -2856,6 +2875,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags=
, cflags, cxxflags, fflags, l
  	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, c=
heckLinkerFlags); err !=3D nil {
  		return
  	}
@@ -149,7 +149,7 @@ index 8dcf324529f5..617b7ece73f0 100644
 =20
  	return
  }
-@@ -2943,7 +2969,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Act=
ion) error {
+@@ -2944,7 +2970,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Act=
ion) error {
  	cgoExe :=3D base.Tool("cgo")
  	cgofiles =3D mkAbsFiles(p.Dir, cgofiles)
 =20
@@ -158,7 +158,7 @@ index 8dcf324529f5..617b7ece73f0 100644
  	if err !=3D nil {
  		return err
  	}
-@@ -3501,7 +3527,7 @@ func (b *Builder) swigOne(a *Action, file, objdir st=
ring, pcCFLAGS []string, cxx
+@@ -3502,7 +3528,7 @@ func (b *Builder) swigOne(a *Action, file, objdir st=
ring, pcCFLAGS []string, cxx
  	p :=3D a.Package
  	sh :=3D b.Shell(a)
 =20
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects=
.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.pat=
ch
index 59ae99c..2e46e22 100644
--- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/li=
nk/internal/ld/lib.go
 index 9cbc12919f1d..0f33521777d1 100644
 --- a/src/cmd/link/internal/ld/lib.go
 +++ b/src/cmd/link/internal/ld/lib.go
-@@ -1672,6 +1672,7 @@ func (ctxt *Link) hostlink() {
+@@ -1680,6 +1680,7 @@ func (ctxt *Link) hostlink() {
  				argv =3D append(argv, "-Wl,-z,relro")
  			}
  			argv =3D append(argv, "-shared")
@@ -30,7 +30,7 @@ index 9cbc12919f1d..0f33521777d1 100644
  			if ctxt.HeadType =3D=3D objabi.Hwindows {
  				argv =3D addASLRargs(argv, *flagAslr)
  			} else {
-@@ -1687,6 +1688,7 @@ func (ctxt *Link) hostlink() {
+@@ -1695,6 +1696,7 @@ func (ctxt *Link) hostlink() {
  			argv =3D append(argv, "-Wl,-z,relro")
  		}
  		argv =3D append(argv, "-shared")
@@ -38,7 +38,7 @@ index 9cbc12919f1d..0f33521777d1 100644
  	case BuildModePlugin:
  		if ctxt.HeadType =3D=3D objabi.Hdarwin {
  			argv =3D append(argv, "-dynamiclib")
-@@ -1695,6 +1697,7 @@ func (ctxt *Link) hostlink() {
+@@ -1703,6 +1705,7 @@ func (ctxt *Link) hostlink() {
  				argv =3D append(argv, "-Wl,-z,relro")
  			}
  			argv =3D append(argv, "-shared")
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-def=
ault.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-def=
ault.patch
index 74fd1fa..77b4bed 100644
--- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.pa=
tch
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.pa=
tch
@@ -94,7 +94,7 @@ index 617b7ece73f0..46c0712c5bd0 100644
  	if err :=3D sh.Mkdir(buildAction.Objdir); err !=3D nil {
  		return nil, err
  	}
-@@ -1922,6 +1939,14 @@ func (b *Builder) linkShared(ctx context.Context, a=
 *Action) (err error) {
+@@ -1923,6 +1940,14 @@ func (b *Builder) linkShared(ctx context.Context, a=
 *Action) (err error) {
  		return err
  	}
 =20
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-=
paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-b=
uild-specific-paths-from-linker-.patch
index 0cc770a..e6a5ce5 100644
--- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-f=
rom-linker-.patch
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-f=
rom-linker-.patch
@@ -18,7 +18,7 @@ diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/g=
o/internal/work/exec.go
 index 46c0712c5bd0..e7c0459ee4c0 100644
 --- a/src/cmd/go/internal/work/exec.go
 +++ b/src/cmd/go/internal/work/exec.go
-@@ -1597,6 +1597,29 @@ func (b *Builder) linkActionID(a *Action) cache.Act=
ionID {
+@@ -1598,6 +1598,29 @@ func (b *Builder) linkActionID(a *Action) cache.Act=
ionID {
  	return h.Sum()
  }
 =20
@@ -48,7 +48,7 @@ index 46c0712c5bd0..e7c0459ee4c0 100644
  // printLinkerConfig prints the linker config into the hash h,
  // as part of the computation of a linker-related action ID.
  func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
-@@ -1607,7 +1630,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *=
load.Package) {
+@@ -1608,7 +1631,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *=
load.Package) {
  	case "gc":
  		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBu=
ildmode)
  		if p !=3D nil {
diff --git a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.=
max-is-not-availab.patch b/recipes-devtools/go/go/0011-internal-cgrouptest-=
skip-when-cpu.max-is-not-availab.patch
index f13cf78..cf6283b 100644
--- a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-=
not-availab.patch
+++ b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-=
not-availab.patch
@@ -21,13 +21,13 @@ Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
  1 file changed, 6 insertions(+)
=20
 diff --git a/src/internal/cgrouptest/cgrouptest_linux.go b/src/internal/cg=
rouptest/cgrouptest_linux.go
-index ad9599c..a4b9b52 100644
+index ad9599c9..a4b9b52d 100644
 --- a/src/internal/cgrouptest/cgrouptest_linux.go
 +++ b/src/internal/cgrouptest/cgrouptest_linux.go
 @@ -82,6 +82,12 @@ func InCgroupV2(t *testing.T, fn func(*CgroupV2)) {
  		}
  	}()
-
+=20
 +	// cpu.max only exists when the kernel supports CPU bandwidth control
 +	// (CONFIG_CFS_BANDWIDTH), even if the cpu controller is enabled.
 +	if _, err :=3D os.Stat(filepath.Join(path, "cpu.max")); err !=3D nil {
@@ -36,4 +36,4 @@ index ad9599c..a4b9b52 100644
 +
  	migrateTo(t, path)
  	defer migrateTo(t, orig)
-
+=20
diff --git a/recipes-devtools/go/go_1.27.1.bb b/recipes-devtools/go/go_1.27=
.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.27.1.bb
rename to recipes-devtools/go/go_1.27.2.bb
--=20
2.55.0


--=20


*This email and any attachment contains EasyMile's confidential=20
information, and must not be modified or circulated without EasyMile's=20
prior written consent. It is intended exclusively for their recipient.s. If=
=20
you received this message by mistake, please notify us promptly and=20
immediately delete this email and any of its attachments.*

*As data=20
controller, EasyMile processes personal data, in compliance with the=20
European GDPR (EU) 2016/679 of 27 April 2016. To exercise your rights, you=
=20
can contact EasyMile at privacy@easymile.com, and if necessary, you may=20
contact the local competent supervisory authority."*

*Cet e-mail et toute=20
pi=E8ce jointe contiennent des informations confidentielles d'EasyMile et n=
e=20
doivent pas =EAtre modifi=E9s ou diffus=E9s sans le consentement =E9crit pr=
=E9alable=20
d'EasyMile. Ils sont destin=E9s exclusivement =E0 leur destinataire.s. Si v=
ous=20
avez re=E7u ce message par erreur, veuillez nous en informer rapidement et=
=20
supprimer imm=E9diatement cet e-mail et toutes ses pi=E8ces jointes.  *

*En=20
tant que responsable de traitement, EasyMile traite des donn=E9es=20
personnelles, conform=E9ment au RGPD europ=E9en (UE) 2016/679 du 27 avril 2=
016.=20
Pour exercer vos droits, vous pouvez contacter EasyMile =E0=20
privacy@easymile.com <mailto:privacy@easymile.com>, et si n=E9cessaire, vou=
s=20
pouvez contacter l'autorit=E9 de contr=F4le locale comp=E9tente.*

