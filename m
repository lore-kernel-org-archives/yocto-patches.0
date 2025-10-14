Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2DCCD195
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 19:36:49 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.5207.1760470599259312300
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 12:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=PvnMv799;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-202510141936334f77c72b1700020792-fn902o@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202510141936334f77c72b1700020792
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 14 Oct 2025 21:36:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CYhYbronpTk3TRPuwp229ONExggmZV5ycp1z7yrgRNs=;
 b=PvnMv799ikQwUq4PV8SFllFqC8o4StxHMydgFgztCB3YRp8AlbqZrjcwGyS7WnE5mmTfn1
 IN/jyZfqegRLHhVah/v2euzD1KV4Mlxu9Sl/SyB+YkqK9FLidf3wku2UcwXWWqqxPGEaaMrX
 fff1hp/9yn5X1MDGERZqBQqHbjT0AQLySd0PE0VsfqmX0CDVoRUZaKj05uT4I54NPJ6U4+TR
 54IiaH/jJUh2mle/l2TW79hOp2W4RxfaYKCFRSYICM35qCz3se2ShctA4dc0LSD2fe5kBXTU
 kPC/zZcVW7dcGdxhJObRuJ1KM3od/Xp1UR9+oTNtakawbHcRU7OQIoOA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	peter.marko@siemens.com,
	Randolph Sapp <rs@ti.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH 1/3] go: fix sigaction usage on i386 platforms
Date: Tue, 14 Oct 2025 21:36:31 +0200
Message-Id: <20251014193633.583798-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 19:36:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2305

From: Randolph Sapp <rs@ti.com>

In upstream the following commit [1] was submitted to resolve issues
with sigaction being used in linked libraries with cgo applications.

runtime: when using cgo on 386, call C sigaction function

This resolves potential segfaults with cgo applications that link to libraries
that intend to switch out signal handlers temporarily with sigaction.

[1] https://github.com/golang/go/commit/c5737dc21bbac9fbefc35ac9313e66291d66b382

(From OE-Core rev: 1bc7a1731b218bb5c8a08c9823c777a40e17555e)

Signed-off-by: Randolph Sapp <rs@ti.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.25.0.inc             |   1 +
 ...ng-cgo-on-386-call-C-sigaction-funct.patch | 248 ++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch

diff --git a/recipes-devtools/go/go-1.25.0.inc b/recipes-devtools/go/go-1.25.0.inc
index f562fbb..1558b46 100644
--- a/recipes-devtools/go/go-1.25.0.inc
+++ b/recipes-devtools/go/go-1.25.0.inc
@@ -16,5 +16,6 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
+    file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
 SRC_URI[main.sha256sum] = "4bd01e91297207bfa450ea40d4d5a93b1b531a5e438473b2a06e18e077227225"
diff --git a/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch b/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch
new file mode 100644
index 0000000..33e3b03
--- /dev/null
+++ b/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch
@@ -0,0 +1,248 @@
+From c5737dc21bbac9fbefc35ac9313e66291d66b382 Mon Sep 17 00:00:00 2001
+From: Ian Lance Taylor <iant@golang.org>
+Date: Fri, 5 Sep 2025 22:24:37 -0700
+Subject: [PATCH] runtime: when using cgo on 386, call C sigaction function
+
+On 386 the C sigaction function assumes that the caller does not set
+the SA_RESTORER flag. It does not copy the C sa_restorer field to
+the kernel sa_restorer field. The effect is that the kernel sees
+the SA_RESTORER flag but a NULL sa_restorer field, and the program
+crashes when returning from a signal handler.
+
+On the other hand, the C sigaction function will return the SA_RESTORER
+flag and the sa_restorer field stored in the kernel.
+
+This means that if the Go runtime installs a signal handler,
+with SA_RESTORER as is required when calling the kernel,
+and the Go program calls C code that calls the C sigaction function
+to query the current signal handler, that C code will get a result
+that it can't pass back to sigaction.
+
+This CL fixes the problem by using the C sigaction function
+for 386 programs that use cgo. This reuses the functionality
+used on amd64 and other GOARCHs to support the race detector.
+
+See #75253, or runtime/testdata/testprogcgo/eintr.go, for sample
+code that used to fail on 386. No new test case is required,
+we just remove the skip we used to have for eintr.go.
+
+Fixes #75253
+
+Change-Id: I803059b1fb9e09e9fbb43f68eccb6a59a92c2991
+Reviewed-on: https://go-review.googlesource.com/c/go/+/701375
+LUCI-TryBot-Result: Go LUCI <golang-scoped@luci-project-accounts.iam.gserviceaccount.com>
+Reviewed-by: Cherry Mui <cherryyz@google.com>
+Reviewed-by: Dmitri Shuralyov <dmitshur@google.com>
+Auto-Submit: Ian Lance Taylor <iant@golang.org>
+Upstream-Status: Backport [https://github.com/golang/go/commit/c5737dc21bbac9fbefc35ac9313e66291d66b382]
+Signed-off-by: Randolph Sapp <rs@ti.com>
+---
+ src/runtime/cgo/gcc_sigaction.c |  8 ++++----
+ src/runtime/cgo/sigaction.go    |  2 +-
+ src/runtime/cgo_sigaction.go    |  6 +++++-
+ src/runtime/crash_cgo_test.go   | 11 -----------
+ src/runtime/os_freebsd.go       |  6 ++++++
+ src/runtime/os_linux.go         | 18 +++++++++++++++++-
+ src/runtime/sigaction.go        |  2 +-
+ src/runtime/sys_linux_386.s     | 19 +++++++++++++++++++
+ 8 files changed, 53 insertions(+), 19 deletions(-)
+
+diff --git a/src/runtime/cgo/gcc_sigaction.c b/src/runtime/cgo/gcc_sigaction.c
+index 7cbef7db11..ad48a88dc1 100644
+--- a/src/runtime/cgo/gcc_sigaction.c
++++ b/src/runtime/cgo/gcc_sigaction.c
+@@ -2,7 +2,7 @@
+ // Use of this source code is governed by a BSD-style
+ // license that can be found in the LICENSE file.
+ 
+-//go:build linux && (amd64 || arm64 || loong64 || ppc64le)
++//go:build linux && (386 || amd64 || arm64 || loong64 || ppc64le)
+ 
+ #include <errno.h>
+ #include <stddef.h>
+@@ -17,7 +17,7 @@
+ // to and from struct sigaction — are specific to ${goos}/${goarch}.
+ typedef struct {
+ 	uintptr_t handler;
+-	uint64_t flags;
++	unsigned long flags;
+ #ifdef __loongarch__
+ 	uint64_t mask;
+ 	uintptr_t restorer;
+@@ -57,7 +57,7 @@ x_cgo_sigaction(intptr_t signum, const go_sigaction_t *goact, go_sigaction_t *ol
+ 				sigaddset(&act.sa_mask, (int)(i+1));
+ 			}
+ 		}
+-		act.sa_flags = (int)(goact->flags & ~(uint64_t)SA_RESTORER);
++		act.sa_flags = (int)(goact->flags & ~(unsigned long)SA_RESTORER);
+ 	}
+ 
+ 	ret = sigaction((int)signum, goact ? &act : NULL, oldgoact ? &oldact : NULL);
+@@ -79,7 +79,7 @@ x_cgo_sigaction(intptr_t signum, const go_sigaction_t *goact, go_sigaction_t *ol
+ 				oldgoact->mask |= (uint64_t)(1)<<i;
+ 			}
+ 		}
+-		oldgoact->flags = (uint64_t)oldact.sa_flags;
++		oldgoact->flags = (unsigned long)oldact.sa_flags;
+ 	}
+ 
+ 	_cgo_tsan_release();
+diff --git a/src/runtime/cgo/sigaction.go b/src/runtime/cgo/sigaction.go
+index dc3f5fd255..90034bad32 100644
+--- a/src/runtime/cgo/sigaction.go
++++ b/src/runtime/cgo/sigaction.go
+@@ -2,7 +2,7 @@
+ // Use of this source code is governed by a BSD-style
+ // license that can be found in the LICENSE file.
+ 
+-//go:build (linux && (amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
++//go:build (linux && (386 || amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
+ 
+ package cgo
+ 
+diff --git a/src/runtime/cgo_sigaction.go b/src/runtime/cgo_sigaction.go
+index 5c644587f0..f725dbef4d 100644
+--- a/src/runtime/cgo_sigaction.go
++++ b/src/runtime/cgo_sigaction.go
+@@ -3,8 +3,10 @@
+ // license that can be found in the LICENSE file.
+ 
+ // Support for sanitizers. See runtime/cgo/sigaction.go.
++// Also used on linux/386 to clear the SA_RESTORER flag
++// when using cgo; see issue #75253.
+ 
+-//go:build (linux && (amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
++//go:build (linux && (386 || amd64 || arm64 || loong64 || ppc64le)) || (freebsd && amd64)
+ 
+ package runtime
+ 
+@@ -42,6 +44,8 @@ func sigaction(sig uint32, new, old *sigactiont) {
+ 
+ 		var ret int32
+ 
++		fixSigactionForCgo(new)
++
+ 		var g *g
+ 		if mainStarted {
+ 			g = getg()
+diff --git a/src/runtime/crash_cgo_test.go b/src/runtime/crash_cgo_test.go
+index c5d7303261..b77ff8dafd 100644
+--- a/src/runtime/crash_cgo_test.go
++++ b/src/runtime/crash_cgo_test.go
+@@ -842,17 +842,6 @@ func TestEINTR(t *testing.T) {
+ 	switch runtime.GOOS {
+ 	case "plan9", "windows":
+ 		t.Skipf("no EINTR on %s", runtime.GOOS)
+-	case "linux":
+-		if runtime.GOARCH == "386" {
+-			// On linux-386 the Go signal handler sets
+-			// a restorer function that is not preserved
+-			// by the C sigaction call in the test,
+-			// causing the signal handler to crash when
+-			// returning the normal code. The test is not
+-			// architecture-specific, so just skip on 386
+-			// rather than doing a complicated workaround.
+-			t.Skip("skipping on linux-386; C sigaction does not preserve Go restorer")
+-		}
+ 	}
+ 	if runtime.GOOS == "freebsd" && race.Enabled {
+ 		t.Skipf("race + cgo freebsd not supported. See https://go.dev/issue/73788.")
+diff --git a/src/runtime/os_freebsd.go b/src/runtime/os_freebsd.go
+index ab859cfb47..68d895b95d 100644
+--- a/src/runtime/os_freebsd.go
++++ b/src/runtime/os_freebsd.go
+@@ -457,6 +457,12 @@ func sysSigaction(sig uint32, new, old *sigactiont) {
+ 	}
+ }
+ 
++// fixSigactionForCgo is needed for Linux.
++//
++//go:nosplit
++func fixSigactionForCgo(new *sigactiont) {
++}
++
+ // asmSigaction is implemented in assembly.
+ //
+ //go:noescape
+diff --git a/src/runtime/os_linux.go b/src/runtime/os_linux.go
+index c9d25a5be8..f9fe1b5f33 100644
+--- a/src/runtime/os_linux.go
++++ b/src/runtime/os_linux.go
+@@ -486,7 +486,8 @@ func setsig(i uint32, fn uintptr) {
+ 	sigfillset(&sa.sa_mask)
+ 	// Although Linux manpage says "sa_restorer element is obsolete and
+ 	// should not be used". x86_64 kernel requires it. Only use it on
+-	// x86.
++	// x86. Note that on 386 this is cleared when using the C sigaction
++	// function via cgo; see fixSigactionForCgo.
+ 	if GOARCH == "386" || GOARCH == "amd64" {
+ 		sa.sa_restorer = abi.FuncPCABI0(sigreturn__sigaction)
+ 	}
+@@ -562,6 +563,21 @@ func sysSigaction(sig uint32, new, old *sigactiont) {
+ //go:noescape
+ func rt_sigaction(sig uintptr, new, old *sigactiont, size uintptr) int32
+ 
++// fixSigactionForCgo is called when we are using cgo to call the
++// C sigaction function. On 386 the C function does not expect the
++// SA_RESTORER flag to be set, and in some cases will fail if it is set:
++// it will pass the SA_RESTORER flag to the kernel without passing
++// the sa_restorer field. Since the C function will handle SA_RESTORER
++// for us, we need not pass it. See issue #75253.
++//
++//go:nosplit
++func fixSigactionForCgo(new *sigactiont) {
++	if GOARCH == "386" && new != nil {
++		new.sa_flags &^= _SA_RESTORER
++		new.sa_restorer = 0
++	}
++}
++
+ func getpid() int
+ func tgkill(tgid, tid, sig int)
+ 
+diff --git a/src/runtime/sigaction.go b/src/runtime/sigaction.go
+index 2027ae80bf..1a99f7f3ec 100644
+--- a/src/runtime/sigaction.go
++++ b/src/runtime/sigaction.go
+@@ -2,7 +2,7 @@
+ // Use of this source code is governed by a BSD-style
+ // license that can be found in the LICENSE file.
+ 
+-//go:build (linux && !amd64 && !arm64 && !loong64 && !ppc64le) || (freebsd && !amd64)
++//go:build (linux && !386 && !amd64 && !arm64 && !loong64 && !ppc64le) || (freebsd && !amd64)
+ 
+ package runtime
+ 
+diff --git a/src/runtime/sys_linux_386.s b/src/runtime/sys_linux_386.s
+index d53be243fe..8e832687e0 100644
+--- a/src/runtime/sys_linux_386.s
++++ b/src/runtime/sys_linux_386.s
+@@ -410,6 +410,25 @@ TEXT runtime·rt_sigaction(SB),NOSPLIT,$0
+ 	MOVL	AX, ret+16(FP)
+ 	RET
+ 
++// Call the function stored in _cgo_sigaction using the GCC calling convention.
++TEXT runtime·callCgoSigaction(SB),NOSPLIT,$0-16
++	MOVL	_cgo_sigaction(SB), AX
++	MOVL	sig+0(FP), BX
++	MOVL	new+4(FP), CX
++	MOVL	old+8(FP), DX
++	MOVL	SP, SI // align stack to call C function
++	SUBL	$32, SP
++	ANDL	$~15, SP
++	MOVL	BX, 0(SP)
++	MOVL	CX, 4(SP)
++	MOVL	DX, 8(SP)
++	MOVL	SI, 12(SP)
++	CALL	AX
++	MOVL	12(SP), BX
++	MOVL	BX, SP
++	MOVL	AX, ret+12(FP)
++	RET
++
+ TEXT runtime·sigfwd(SB),NOSPLIT,$12-16
+ 	MOVL	fn+0(FP), AX
+ 	MOVL	sig+4(FP), BX
+-- 
+2.51.0
+

