Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE21C4450A
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 18:19:29 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.765.1784053165650281268
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 11:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=lM9Ufyd5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260714181922296d289db600020754-mfhf_s@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260714181922296d289db600020754
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 14 Jul 2026 20:19:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CUfBIe1nDc1h9ebn//yLQ7DiEKtijFStiTRBTq/Qn5Q=;
 b=lM9Ufyd50hMDv8b9Vp0qFaMeSFjrWvjCG008GO9M7skWtLQn9cejXNhAac/vjjZ1iFqoTu
 quQJZp7HuTo0rNp2a5yGXtkupQmh1/5DxwiPPurr7M2QfRVa0Upsst3CWTUtSIsPwTUBxjz7
 I3TZFSHpeRTuyQHSkuN++bF05kor+vxRpeuq3c2RrJZguHXtsgDw1NH6OUWv0DemavbcT/vO
 biYXOiDhkSHdL/KFifkRj8YxzUWGw9Iy+Gy1pOj/SCnbNbkTLeEQy5ltGiPXKGoZ/QvnIUUq
 /KS4UbQwFRUpieiIjGIqDlXLZCRs9YzsobahBoo12Pjaz/9KkG+PpTcg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.4 -> 1.26.5
Date: Tue, 14 Jul 2026 20:19:02 +0200
Message-ID: <20260714181902.5214-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 18:19:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4472

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.4..go1.26.5
c19862e5f8 (tag: go1.26.5) [release-branch.go1.26] go1.26.5
f9ef7f5598 [release-branch.go1.26] os: properly handle trailing slashes in paths in Root
ca8ca590cc [release-branch.go1.26] crypto/tls: omit PSK in ECH outer client hello
7397dd7495 [release-branch.go1.26] net: fix TestLookupCNAME
044c995af7 [release-branch.go1.26] runtime: tolerate vendor suffixes in Linux kernel release strings
814591410b [release-branch.go1.26] cmd/compile,sync/atomic: make Add And & Or SQCST on PPC64
2055b1a15d [release-branch.go1.26] syscall: add //go:norace to rawSyscall on darwin
d7c9c818f9 [release-branch.go1.26] runtime: in moveSliceNoCap, round size down to a whole multiple of element size
dc80258a97 [release-branch.go1.26] internal/runtime/gc: require AVX512DQ for greentea
6efcff6602 [release-branch.go1.26] os/signal: make NotifyContext Cause match context.Canceled
fe91cea4f2 [release-branch.go1.26] cmd/go: use fsys.ReadDir for IsStandardPackage
ec988a9af1 [release-branch.go1.26] os: notify testlog from (*File).Chdir

Fixes CVE-2026-39822 and CVE-2026-42505.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.4...go1.26.5
[2] https://groups.google.com/g/golang-announce/c/OrmQE_Yp5Sc

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: b498f6d6d93e0adb3f0e9439aa55a2abfcb9b063)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.4.inc => go-1.26.5.inc}        | 2 +-
 ...o-binary-native_1.26.4.bb => go-binary-native_1.26.5.bb} | 6 +++---
 ...cross-canadian_1.26.4.bb => go-cross-canadian_1.26.5.bb} | 0
 .../go/{go-cross_1.26.4.bb => go-cross_1.26.5.bb}           | 0
 .../go/{go-crosssdk_1.26.4.bb => go-crosssdk_1.26.5.bb}     | 0
 .../go/{go-runtime_1.26.4.bb => go-runtime_1.26.5.bb}       | 0
 recipes-devtools/go/{go_1.26.4.bb => go_1.26.5.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.4.inc => go-1.26.5.inc} (90%)
 rename recipes-devtools/go/{go-binary-native_1.26.4.bb => go-binary-native_1.26.5.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.4.bb => go-cross-canadian_1.26.5.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.4.bb => go-cross_1.26.5.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.4.bb => go-crosssdk_1.26.5.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.4.bb => go-runtime_1.26.5.bb} (100%)
 rename recipes-devtools/go/{go_1.26.4.bb => go_1.26.5.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.4.inc b/recipes-devtools/go/go-1.26.5.inc
similarity index 90%
rename from recipes-devtools/go/go-1.26.4.inc
rename to recipes-devtools/go/go-1.26.5.inc
index 8bc6f4d..a4302b2 100644
--- a/recipes-devtools/go/go-1.26.4.inc
+++ b/recipes-devtools/go/go-1.26.5.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "4f668a32fbfc1132e6a881fb968c2f1dada631492a339211735fbb255a42602d"
+SRC_URI[main.sha256sum] = "495be4bc87176ac567392e5b4116abd98466d33d7b49d41e764ccc6976b2dc42"
diff --git a/recipes-devtools/go/go-binary-native_1.26.4.bb b/recipes-devtools/go/go-binary-native_1.26.5.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.4.bb
rename to recipes-devtools/go/go-binary-native_1.26.5.bb
index 489ea0c..8ba9dd4 100644
--- a/recipes-devtools/go/go-binary-native_1.26.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.5.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "1153d3d50e0ac764b447adfe05c2bcf08e889d42a02e0fe0259bd47f6733ad7f"
-SRC_URI[go_linux_arm64.sha256sum] = "ef758ae7c6cf9267c9c0ef080b8965f453d89ab2d25d9eb22de4405925238768"
-SRC_URI[go_linux_ppc64le.sha256sum] = "53f49b8c7eace2d30389327b4a516b13321f90377fdf5929a6b63174609bc22e"
+SRC_URI[go_linux_amd64.sha256sum] = "5c2c3b16caefa1d968a94c1daca04a7ca301a496d9b086e17ad77bb81393f053"
+SRC_URI[go_linux_arm64.sha256sum] = "fe4789e92b1f33358680864bbe8704289e7bb5fc207d80623c308935bd696d49"
+SRC_URI[go_linux_ppc64le.sha256sum] = "c5d60e2b303bb612f20cd82786594b64874e73b35134025e27d3390bf284ae43"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.4.bb b/recipes-devtools/go/go-cross-canadian_1.26.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.4.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.5.bb
diff --git a/recipes-devtools/go/go-cross_1.26.4.bb b/recipes-devtools/go/go-cross_1.26.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.4.bb
rename to recipes-devtools/go/go-cross_1.26.5.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.4.bb b/recipes-devtools/go/go-crosssdk_1.26.5.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.4.bb
rename to recipes-devtools/go/go-crosssdk_1.26.5.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.4.bb b/recipes-devtools/go/go-runtime_1.26.5.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.4.bb
rename to recipes-devtools/go/go-runtime_1.26.5.bb
diff --git a/recipes-devtools/go/go_1.26.4.bb b/recipes-devtools/go/go_1.26.5.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.4.bb
rename to recipes-devtools/go/go_1.26.5.bb

