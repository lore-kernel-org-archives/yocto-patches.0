Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F043C88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:50 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48444.1789157625767175093
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AROjM1wF;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5303932c4f3so7983961cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157625; x=1789762425; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b9DuWibvrg7lggRja+n2N8BjfmwYRNk2CcSgiT9gkpw=;
        b=AROjM1wFynd6Mvty5w53MmjnEBEZhVqH66oeF+CX8DJUTXq3cGhe/G28ncucNcidhE
         2l3rsyP1D3GeqBhRfo0/J58yXX/U1NVTzoWcw2LDhTIOy39j47BXhpdXWM6Avn1WhbPE
         78HKhPAGjRB9l4nAOv6GevsuRPGthcr/xmSRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157625; x=1789762425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b9DuWibvrg7lggRja+n2N8BjfmwYRNk2CcSgiT9gkpw=;
        b=CtpCLxw6J9HLmGxJpuF1DneV6P21hFdodIdLvEGi+YaA6xfbDqHySBDsSZ8QJwx9bJ
         zaah70jVjuj49SJzqnSRjLXlQLVfgmCpYbGNTfFdJ3+F3S7EWu741jMKipr8ASFfhvjP
         ZcfTqu3e6KH4P21Lq2MU0SF18T2mpIo+t+W7JbS8Esr5oBGLCA1by76D23AKQCy6QOm5
         X6HW8SvuLzwSnAgyszGGenIN4rf+E7Qr7IyE22h8MLLh3mYKqD3MGUSRGN48yuGBXR1I
         JFAKx60obwPOLTRx2+L6/W3VnHDbJV5lSHU9TpaI4vfouXcQBBiy5+WlrCPigGjLniJz
         UhUA==
X-Gm-Message-State: AFuF++n5P4FmrmlSv/kuaIB4jeKbQtYfol/wF0s3PrnP+/8OeczpDBIZ
	V0ZbRQ4SvmOHKVywh9kvfdTm3JbbTt0gPbjA6HOd0WWKRbgrrzTQU8lEuEmjrwuKDOl7i2uNVuK
	dKjQ9
X-Gm-Gg: AYBFou2guOEF3oPKuJVfM69IoiGeOnJCzn50U8/DmxCt/boI13x6bO92fWAj5hfWO06
	t8RQERpE3bFopqaYjSgZHtK4GSf+EtnTGHElttPmXAz6kLepjmRre7foqtg41mgw5N+zBmkiFqZ
	RSy1RRPyRc/wFf/ynDmkzWZGlgf8Z0SRthZ+40tw3VTJQ8Dt6YMXnhxyawoFyqEV0a+UFJAwbcB
	t5pSP3mXznTOYiSU1YEXhf5EDI6yuC1ObxWPOFecn9zotH6CPP2PJqxnhjjQCLSZxfLQz5gBHE0
	MqwW18kAs5dru9XbCtB07I5GoxrFZqXbOwJXMd9VOfivlMQIemSTO7C1svvjDyX1TUNhH+sxDsz
	thqR/4vrCTESlh7twNTDobcZ7Mz6LRtDxHt5wAEeKO/T6cZDjtSt+uoknhhYiS9TVbBCc0JSwU7
	nvzB2Is2OKLySrhdH3DG4+h8gdpch7dK0NQC++44ZJf5AIFeqGiuG/BNzRNouenYbqBm3l3jguK
	hEpkByop8nRacJo/sXVeGAHfuSlD8YVbXzTbej+gPvSEuQAmG+o+iuzD3Jnitbk7pXwsaYhj09o
	ZXLsS13rv7wPF9MyEEpxQy6/K/YQRlHeB4Q=
X-Received: by 2002:a05:622a:1821:b0:52d:9c11:8937 with SMTP id d75a77b69052e-530c8533cfbmr92170911cf.26.1789157624435;
        Fri, 11 Sep 2026 13:13:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/37] rust: Fix reproducibility with shared source trees
Date: Fri, 11 Sep 2026 16:12:53 -0400
Message-ID: <1713358da2f46bd23627b018a21e07d037654f2f.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4773

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Backport an upstream Rust commit to fix a reproducibility
issue when Rust family recipes share the same source tree.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d69cab54234d2aec01f964f8ae0fc3ff97bfbdb6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ild-script-path-leakage-in-artifacts.patch | 28 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch

diff --git a/recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch b/recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch
new file mode 100644
index 0000000..8c93624
--- /dev/null
+++ b/recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch
@@ -0,0 +1,28 @@
+Backport a commit that remap OUT_DIR paths to fix build script path leakage in artifacts
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/e743a4db62336027dcc1f1a755f4ca35f56b67df]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+
+diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/core/builder/cargo.rs
+index f785254..0264667 100644
+--- a/src/bootstrap/src/core/builder/cargo.rs
++++ b/src/bootstrap/src/core/builder/cargo.rs
+@@ -1077,6 +1077,8 @@ impl Builder<'_> {
+                         // rustc creates absolute paths (in part bc of the `rust-src` unremap
+                         // and for working directory) so let's remap the build directory as well.
+                         format!("{}={map_to}", self.build.src.display()),
++                        // remap OUT_DIR so they don't leak into artifacts.
++                        format!("{}={map_to}/out", self.build.out.display()),
+                     ]
+                     .join("\t");
+                     cargo.env("RUSTC_DEBUGINFO_MAP", map);
+@@ -1097,6 +1099,8 @@ impl Builder<'_> {
+                         // rustc creates absolute paths (in part bc of the `rust-src` unremap
+                         // and for working directory) so let's remap the build directory as well.
+                         format!("{}={map_to}", self.build.src.display()),
++                        // remap OUT_DIR so they don't leak into artifacts.
++                        format!("{}={map_to}/out", self.build.out.display()),
+                     ]
+                     .join("\t");
+                     cargo.env("RUSTC_DEBUGINFO_MAP", map);
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index cc2de41..a5d1568 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,6 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0002-Fix-rust-build-failure-with-unstable-options.patch;patchdir=${RUSTSRC} \
             file://0003-explicit-tail-calls-disable-two-tests.patch;patchdir=${RUSTSRC} \
             file://0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch;patchdir=${RUSTSRC} \
+            file://0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "77a6ff3003a4ad0cb00697b043c879e3e1a15d945b1a1f63818903bfc3fa8b98"
 
-- 
2.55.0


