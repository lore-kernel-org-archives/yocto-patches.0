Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D4CD6E51
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23159.1763038637497306633
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=oPFQbanm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251113125715ed5cc24e4d000207a9-wz8evj@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251113125715ed5cc24e4d000207a9
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=flA3TcLbTclnmqPEWSKySCdAM4txjh6XLwOYV4OYJn0=;
 b=oPFQbanmADN5zEFR9VfupnFgMmdlorYG5J8/AZ8pFtHe09sLpaFVmd8MLtuxs+kqzvcJkU
 +MOHPwTel05pLEnpfJ0VgqNjaFwWUe0K8kuUWRDmpPL2c1wAZUc/MKTW6755WvxthowG5E40
 ozISzxdN+f9BE2v9Ehv63w8F80BxKLpTg6Cv/5uLHkae01wPg2fUFViTtwqeWgVFB1C3Sek5
 CAgP+P+6NayDmQhSh4w6Tmo5sNRGfKd8cL6k8xGOKvH9POcCoNyAwkqeupVCByBTO0cLngm4
 Mtk2A50LcJ4vazWOMbiwh3Vis/c3fV0kdLUIszHEUep2E1Kn67c/F1Ag==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 14/34] go: fix buildpath issue for go-runtime
Date: Thu, 13 Nov 2025 13:56:52 +0100
Message-Id: <20251113125712.18914-15-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2505

From: Hongxu Jia <hongxu.jia@windriver.com>

In upstream commit [cmd: remove support for GOROOT_FINAL][1], it clear
GOROOT for func ld when -trimpath is used

But it missed to do the same thing for share libarary linking which caused
building go-runtime failed with buildpath issue

|ERROR: go-runtime-1.23.4-r0 do_package_qa: QA Issue: File /usr/lib/go/pkg/
linux_amd64_dynlink/libstd.so in package go-runtime contains reference to
TMPDIR [buildpaths]

This commit applied a patch to clear GOROOT for func ldShared when
-trimpath is used and add option -trimpath to go-runtime build

[1] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98
[2] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98#diff-cab5921f94f2667bb0bc1b935d2d46b4c03541b4351b33438ab7290b94dea212R669

(From OE-Core rev: f7b05ebfdc6504a8360741f273163ef7fbb11b10)

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.24.0.inc             |  1 +
 recipes-devtools/go/go-runtime.inc            |  2 +-
 ...OOT-for-func-ldShared-when-trimpath-.patch | 51 +++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch

diff --git a/recipes-devtools/go/go-1.24.0.inc b/recipes-devtools/go/go-1.24.0.inc
index 26a4947..a52dd19 100644
--- a/recipes-devtools/go/go-1.24.0.inc
+++ b/recipes-devtools/go/go-1.24.0.inc
@@ -14,6 +14,7 @@ SRC_URI += "\
     file://0007-exec.go-filter-out-build-specific-paths-from-linker-.patch \
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
+    file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
 SRC_URI[main.sha256sum] = "d14120614acb29d12bcab72bd689f257eb4be9e0b6f88a8fb7e41ac65f8556e5"
diff --git a/recipes-devtools/go/go-runtime.inc b/recipes-devtools/go/go-runtime.inc
index 413cf6d..e5f1733 100644
--- a/recipes-devtools/go/go-runtime.inc
+++ b/recipes-devtools/go/go-runtime.inc
@@ -34,7 +34,7 @@ do_compile() {
 	if [ -n "${GO_DYNLINK}" ]; then
 		export GOTOOLDIR="${B}/pkg/tool/native_native"
 		CC="$CC_FOR_${TARGET_GOTUPLE}" GOARCH="${TARGET_GOARCH}" GOOS="${TARGET_GOOS}" GOROOT=${B} \
-			$GOTOOLDIR/go_bootstrap install -linkshared -buildmode=shared ${GO_SHLIB_LDFLAGS} std
+			$GOTOOLDIR/go_bootstrap install -linkshared -trimpath -buildmode=shared ${GO_SHLIB_LDFLAGS} std
 	fi
 	cd ${B}
 }
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
new file mode 100644
index 0000000..2c2f0cb
--- /dev/null
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -0,0 +1,51 @@
+From c4215b5ca69a7626d97cf9b7ebc460c2b5b9148b Mon Sep 17 00:00:00 2001
+From: Hongxu Jia <hongxu.jia@windriver.com>
+Date: Fri, 28 Feb 2025 19:13:18 -0800
+Subject: [PATCH 10/11] cmd/go: clear GOROOT for func ldShared when -trimpath
+ is used
+
+In commit [cmd: remove support for GOROOT_FINAL][1], it clear GOROOT
+for func ld when -trimpath is used. [2]
+
+This commit do the same thing for func ldShared, otherwise run go_bootstrap
+with -trimpath does not remove build path directory from the generated share
+libarary
+
+  $ ./make.bash --target-only --no-banner std
+  $ go_bootstrap install -linkshared -buildmode=shared -trimpath std
+  $ grep "$(pwd)" ./pkg/linux_amd64_dynlink/libstd.so
+  Binary file ./pkg/linux_amd64_dynlink/libstd.so matches
+
+[1] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98
+[2] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98#diff-cab5921f94f2667bb0bc1b935d2d46b4c03541b4351b33438ab7290b94dea212R669
+
+Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/653895]
+
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ src/cmd/go/internal/work/gc.go | 9 ++++++++-
+ 1 file changed, 8 insertions(+), 1 deletion(-)
+
+diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
+index 3a173efee8..8b7a44e031 100644
+--- a/src/cmd/go/internal/work/gc.go
++++ b/src/cmd/go/internal/work/gc.go
+@@ -728,7 +728,14 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+ 	// the output file path is recorded in the .gnu.version_d section.
+ 	dir, targetPath := filepath.Split(targetPath)
+ 
+-	return b.Shell(root).run(dir, targetPath, nil, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
++	env := []string{}
++	// When -trimpath is used, GOROOT is cleared
++	if cfg.BuildTrimpath {
++		env = append(env, "GOROOT=")
++	} else {
++		env = append(env, "GOROOT="+cfg.GOROOT)
++	}
++	return b.Shell(root).run(dir, targetPath, env, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
+ }
+ 
+ func (gcToolchain) cc(b *Builder, a *Action, ofile, cfile string) error {
+-- 
+2.25.1
+

