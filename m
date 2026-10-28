Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41577.1793190008900116475
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 05:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=Ud36OL4w;
 spf=pass (domain: baylibre.com, ip: 74.125.224.52, mailfrom: ddrake@baylibre.com)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679e6ab6471so1952657d50.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793190008; x=1793794808; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pbus3l5Qp8lp0Urp85i9O3r+6Lp8sKcpzBA+Zltun+Q=;
        b=Ud36OL4wRzjCFcKmypq9HIavoJTLkwxBsGdE2szavms2NNogI5dH/yJNR3Yxj/Cxz0
         CwKORFZ4nyoOIBPGSEbNWKLEGdRptMX1+TE7SlzF0yt3myRbjfrd0wooWJ9qEPb0hwZl
         oA2if7oywMBydJMicN62QQ6pyr0eo3hat8SuQY0Minf+h5SMs14H0gmxLOTM3quYrAx0
         4l0o7U3vATY8Jyy1WD1JQikgXvYR+OF0KJD64ac5N5uxtEX/QR4WuKem17sxos6QqsjV
         Ax1wsw2xfZhgxUptvvZ1/OpZk99f8ZNbzp6gQFbHkoCHDN6u/h848qskLdOPgkhPuh1f
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793190008; x=1793794808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pbus3l5Qp8lp0Urp85i9O3r+6Lp8sKcpzBA+Zltun+Q=;
        b=g+3YkSK09FKcSrCEnkOAo6hWuS0h1vU5WW6ylHtZn4ncSuENlPoNIuaKTN8W3wM0KV
         fzaRaxrdmc9thVKwIt/VwNdywbUQTAQ7ePjWMd3yLp8N32bbC2IDfj59W3c64dU3EzqR
         GJRvKuT/uotOUqY8k56PtB3FIB+bShoegQzf9HoKmcslIr01RGEE/vHrn1ivLTD/PQW9
         CeMrqYmV51mhmYev4jSuhjk9bK/1vNyIlvzjKow38r4d+HPysUs4TXKdhZc1PUwIjxH9
         GhtRab8X/nnTK1/R6bUuPIAWSqkWfsaNEdhstH1M3zI0gC7UhVzij/eo6GOrVHjiM/wB
         Wgpw==
X-Gm-Message-State: AFq9FYKwJC2K2fFOpeho8DyGVxAZNmKkfnmembfF1u0bj41sTHyE/as4
	j6Y70kcbsDVId8cgC4Cd9Wc/85lAAs0ot/W0nY41sutxFTSnwve0OwQefBtpb6gXxCJNQE0EbWD
	A8h62QyF1zw==
X-Gm-Gg: AYBFou08XgHuA8Y5RU9yVR0822ixUYZooGv2SF9xeAW7awJFR4t21rgN4PRvYrJy98E
	GmDx42PEjpeKuGFIMKngj8NM3oh1ABJFKOBdSXNnG+uzAKzBSwwwjKlD8q7/eZHq0FUBoIgCR/9
	5Ns6s00zSxCDldiIxABhFMrrGG6Dle1iLkOrcniSrc+K22XfBZR4BLqp6y2FtpsKnsn+6QbUlQY
	iv+BibhmMXArWe+msPaE78kBFqsOveL51sUjVyEvEPoZuV+Kh1YfxBpvdna/ttzeZjaXOglj3Pu
	Z8fCpVwxfn3bZeOg3UGxUvdNg7+t35MJwL8+Bz4JKObojSbhTb2ofsAbQ3Tb4AGQ36x7HzY1pWI
	Luo9I07lbmCu51U/zN/lKiufcuKvNPYdH1UbtA6e9AeJdskkCtDJgLYBFs3tPjo/WXLUh5wy8Xz
	dQUaPgmJWr/6jMj3c3cpx235LvEq9WppnvALe9sfvDU9SM2IeAn2HW8QAR+eYdgEEmQsTVQBveO
	P3E3zth6ni/4ftoAAtPKTDCk3PG3mCHZH/thr/FIqSGNdyQFo/Qf7F3+stLXP6Pi6qBN+3TetNz
	dvGjhlUhTusomVLuvEoWslYZvDY=
X-Received: by 2002:a05:690e:414a:b0:679:a190:cf32 with SMTP id 956f58d0204a3-67a6de9d74cmr3866715d50.3.1793190007762;
        Wed, 28 Oct 2026 05:20:07 -0700 (PDT)
Return-Path: <ddrake@baylibre.com>
Received: from numbers ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a0c7da1sm1543904d50.12.2026.10.28.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:20:07 -0700 (PDT)
From: Daniel Drake <ddrake@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hongxu Jia <jiahongxujia@163.com>,
	Hongxu Jia <hongxujia83@gmail.com>,
	Daniel Drake <ddrake@baylibre.com>
Subject: [meta-tensorflow][PATCH] tensorflow.inc: fix fetch of LLVM for XLA
Date: Wed, 28 Oct 2026 12:20:04 +0000
Message-ID: <20261028122004.93109-1-ddrake@baylibre.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 12:20:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5170
Content-Type: text/plain; charset="utf-8"

Building tensorflow-lite fails in do_compile when Bazel fetches llvm-raw:

  WARNING: Download from https://storage.googleapis.com/mirror.tensorflow.org/github.com/llvm/llvm-project/archive/909041e4802c4b9a2223ca04099f35bf1dbbd460.tar.gz
  failed: class java.io.FileNotFoundException GET returned 404 Not Found
  ...
  Error in download_and_extract: java.io.IOException: Error downloading [...]:
  Checksum was 00b1077e029fa57e6f2d9ac24936a49acf23ebc051b04f487131116258be6248
  but wanted 3f986184ee126677dbd77edb16d6b82c057ec869fefd7a9871979941e52e837a

The archive pinned by XLA is not on mirror.tensorflow.org, and the archive
GitHub now generates for the same LLVM commit has a different checksum, so
the pin can no longer be satisfied from either URL.

Pin the checksum of the archive GitHub currently serves. Future upstream
releases will point to a newer LLVM commit.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 ...01-xla-update-sha256-of-LLVM-archive.patch | 28 +++++++++++++++++++
 recipes-framework/tensorflow/tensorflow.inc   |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-framework/tensorflow/files/0001-xla-update-sha256-of-LLVM-archive.patch

diff --git a/recipes-framework/tensorflow/files/0001-xla-update-sha256-of-LLVM-archive.patch b/recipes-framework/tensorflow/files/0001-xla-update-sha256-of-LLVM-archive.patch
new file mode 100644
index 0000000..3a6cc72
--- /dev/null
+++ b/recipes-framework/tensorflow/files/0001-xla-update-sha256-of-LLVM-archive.patch
@@ -0,0 +1,28 @@
+From: Daniel Drake <ddrake@baylibre.com>
+Subject: [PATCH] xla: update sha256 of LLVM archive
+
+Bazel can no longer fetch llvm-raw. The mirror.tensorflow.org copy of the
+archive returns 404, and the archive GitHub now generates for the same LLVM
+commit has a different checksum than the one pinned here.
+
+Pin the checksum of the archive GitHub currently serves. The LLVM commit is
+unchanged.
+
+Upstream-Status: Inappropriate [workaround for a regenerated GitHub archive; upstream master pins a newer LLVM commit]
+Signed-off-by: Daniel Drake <ddrake@baylibre.com>
+---
+ third_party/xla/third_party/llvm/workspace.bzl | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/third_party/xla/third_party/llvm/workspace.bzl b/third_party/xla/third_party/llvm/workspace.bzl
+--- a/third_party/xla/third_party/llvm/workspace.bzl
++++ b/third_party/xla/third_party/llvm/workspace.bzl
+@@ -5,7 +5,7 @@
+ def repo(name):
+     """Imports LLVM."""
+     LLVM_COMMIT = "909041e4802c4b9a2223ca04099f35bf1dbbd460"
+-    LLVM_SHA256 = "3f986184ee126677dbd77edb16d6b82c057ec869fefd7a9871979941e52e837a"
++    LLVM_SHA256 = "00b1077e029fa57e6f2d9ac24936a49acf23ebc051b04f487131116258be6248"
+ 
+     tf_http_archive(
+         name = name,
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index e337519..69bfefc 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -27,6 +27,7 @@ SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.21;protocol=http
     file://0001-set-x83_64-to-arch-of-whl.patch \
     file://0001-fix-compile-failed-with-clang-21.patch \
     file://0001-fix-clang-22.patch \
+    file://0001-xla-update-sha256-of-LLVM-archive.patch \
 "
 
 DEPENDS += " \
-- 
2.56.0

