Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3152.1795645889348137058
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Dl/g+hkD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55c48582654so70625851cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645888; x=1796250688; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IY1ZM2w0XGzv7PU63zZCnuiUkwDSJUfCVI4QhllJZ4s=;
        b=Dl/g+hkD9nRjO3KUjgZk/j40y6m9HfpsBAdKW5QTC0wDVuv5aDJgxI9D51YCxXvP3W
         UTKmhdP6uke2DMboKdIg+396LuQEUk5DcsPwuh4WNiPZV/H+Dwlpj6AAfHy5Xll39UZi
         ARfA15B/UVkOk99JChB19CAJcJsogeGJ0Fork=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645888; x=1796250688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IY1ZM2w0XGzv7PU63zZCnuiUkwDSJUfCVI4QhllJZ4s=;
        b=NslTUg7hEA7Lt75e1VvyVZsnaCeAlyYpu8KYc4aOZbbPGQfHxWmxrji12E+UHl8juU
         rZwBofjCM0w0ESUxkoUZNXMYmGGFJ6yx2pPYCPA47cTfTj4pgSfLdj9Jc6OmsrcJ5DCX
         7F/FnfRXPJATACjVff8/WjhLRL8Aih4VJ8SgAhzoqjJWjjqKtmukcgK//FcAiyKDbvNj
         ZSfFqNxTZqJV7dz8Z0tA7NzMQ4ljEC0QupY/QiIFX/W1eLjUgdC9KeNXq1qsFdUGM7PK
         O5KK9oT77Cc66NzJaOWXDXcuXYjLuEOT0TtQeg026ilNDV28mYDWa2UYBc2u29PtN81J
         Dv1w==
X-Gm-Message-State: APuU4Z99+QAiRK1ZEq+ckqMnV1CxEpJI7IDMgLx00S3FWcw47KBu98AP
	+NulHtToEuS/V9QLxSstnb7+37fFwvs7jabiRI+ienQ7Mj2iflooaaKwH1HEhfwEJ0MS+VbnEpC
	up8Qr
X-Gm-Gg: AZFdTZcrIrCqC9rOaOxHCZR4ZRPM604k8q3UBQDklwO1Lh9AwQARzeZcs37+qT/7SwN
	BX2C5GX6dmAwZ4pOzp6SDJmm69RKIJBWtLR6YGWwLJ131QY4vzc/WXSA1X5m1gOiElAod5vEJL8
	LA5yC7L4iUegTWbx6nCVP458yVoPLNnDfeXUhe20nj8w0MF7ifhKxge/dq6R1zTFRSLcyPDa6x6
	Bl9Xq7UCHS/dktyDxJFxdwT2V6UVS0TAZHci/RMD4Ao+tos9qptw5S49G692vYfWlrqSB8IU/zL
	nAn1wIeHu+nciXnC8NefRNJTVuVj83Lf6Q0ZwR0AAB3+sdhzZwBwmeLgXGGMHpjIOBdC6KfXI6a
	AK+hdJBZhzjldh4q5Wz89RlLbp45H2XtqBdcmqkRHX9LXvMBhKsRtI7QYzd/kS/0C0mTd8IWxG7
	nXE/12sk/r2xMSDuf220RkDkcNaDyXFBrIaQ5Lu3Ylki59Lp9bCkbqvxgqStf1trTAlf5Ylbo3S
	5UI/dgEC5JuOVqWsZrigpBrVbZrzgT6bJtbN/ioEvGUfK25iefj3F3A9z0TIO8oqILv4MoGiLWr
	wz710VZyTSBslTP37oRppos8Cer0Y+tYDXCHf15AxWeDTp+/fh+ac3nvEXKAT0w9Uw1wjOaTx1w
	i6MpolW5FfroUkLgBAV2kgHMt/hyUyjt4QOeXslfQahh3XYe720jXOVMRN4GmsO9Pb2vM/HZe6W
	2eVda+sD/Uw+8=
X-Received: by 2002:a05:622a:14d1:b0:55d:3350:d262 with SMTP id d75a77b69052e-55d76af1864mr363480961cf.52.1795645888079;
        Wed, 25 Nov 2026 14:31:28 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:27 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/19] rust: backport deterministic DocLinkResMap serialisation
Date: Wed, 25 Nov 2026 17:30:58 -0500
Message-ID: <8f04fe22783f5c6c1c3bea39257be5ea7259ede8.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5526
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

Backport of rust-lang/rust commit f9d9939 [1] by jprochazk and mejrs.
DocLinkResMap was an UnordMap, so its iteration order varied with the
build host and that order reached the encoded rmeta. An FxIndexMap keeps
it stable. The commit is in rust 1.99, so this only carries it until the
next rust upgrade.

[1] https://github.com/rust-lang/rust/commit/f9d9939467a5185a72f0ee8da778a0b71fc966ae

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 6bc5642801f0ac8960f5f65cf47c7f24d3d565c1)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...oc-link-metadata-order-deterministic.patch | 40 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 41 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch

diff --git a/recipes-devtools/rust/files/0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch b/recipes-devtools/rust/files/0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch
new file mode 100644
index 0000000..8cd64f2
--- /dev/null
+++ b/recipes-devtools/rust/files/0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch
@@ -0,0 +1,40 @@
+From 6630363e7bc9bc0926300e242aa538b8d92cdb95 Mon Sep 17 00:00:00 2001
+From: jprochazk <pjanv42@gmail.com>
+Date: Tue, 15 Sep 2026 17:05:36 +0530
+Subject: [PATCH] make DocLinkResMap an FxIndexMap
+
+DocLinkResMap was an UnordMap, so its iteration order varied with the build
+host and that order ended up in the encoded rmeta. An FxIndexMap keeps the
+serialisation stable. Only the code change is carried here, not the
+upstream run-make test.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/f9d9939467a5185a72f0ee8da778a0b71fc966ae]
+
+Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
+---
+ compiler/rustc_hir/src/def.rs | 6 ++++--
+ 1 file changed, 4 insertions(+), 2 deletions(-)
+
+diff --git a/compiler/rustc_hir/src/def.rs b/compiler/rustc_hir/src/def.rs
+index d0300d6..e903c0c 100644
+--- a/compiler/rustc_hir/src/def.rs
++++ b/compiler/rustc_hir/src/def.rs
+@@ -4,7 +4,7 @@ use std::fmt::Debug;
+ 
+ use rustc_ast as ast;
+ use rustc_ast::NodeId;
+-use rustc_data_structures::unord::UnordMap;
++use rustc_data_structures::fx::FxIndexMap;
+ use rustc_error_messages::{DiagArgValue, IntoDiagArg};
+ use rustc_macros::{Decodable, Encodable, StableHash};
+ use rustc_span::Symbol;
+@@ -969,4 +969,6 @@ pub enum LifetimeRes {
+     ElidedAnchor { start: NodeId, end: NodeId },
+ }
+ 
+-pub type DocLinkResMap = UnordMap<(Symbol, Namespace), Option<Res<NodeId>>>;
++// FxIndexMap is necessary because its data ends up in .rmeta files, so its
++// iteration order must be consistent. See #159677 for context.
++pub type DocLinkResMap = FxIndexMap<(Symbol, Namespace), Option<Res<NodeId>>>;
+-- 
+2.43.0
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 2beec08..66fbdc6 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -10,6 +10,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch;patchdir=${RUSTSRC} \
             file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
             file://0007-cargo-omit-host-triple-from-unit-metadata-hash.patch;patchdir=${RUSTSRC} \
+            file://0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "be1816e7f6c40abb90245ad6e024bed2a7e88d7dda4561e4d5470207df616b9f"
 
-- 
2.56.1

