Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6166.1794870779359546509
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fuhQtU+U;
 spf=pass (domain: konsulko.com, ip: 209.85.221.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so275896e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870778; x=1795475578; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RJT/m9n6Fpi+SgSMyfsJ4TqBOqv2a3h7NITRz83Fw0Y=;
        b=fuhQtU+UEPzE/6HyZiilocny9bH2AZPPIf8ryAKQunbB8kIkQMvt/vN5Krs7Ggh8+C
         m/UjvPMUlL3RvZSj0nQwp3mwjfaII42ybCHqhAiKVy+bMk//OJoIy6kTL8ACbvDmEy32
         uF7ulcmoqCVky3IvhEmQ2xVZcvzwAim39L0ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870778; x=1795475578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RJT/m9n6Fpi+SgSMyfsJ4TqBOqv2a3h7NITRz83Fw0Y=;
        b=EndqpiAlCFEbkZFjL/43x5AdDep31JQLlg1/scc3PuSBDgLxf3EQd0ROQRwCwST9Sg
         32Hkx0PxGafUSbn7K6/ESE5lQ47Q3SxUiCY3KZiAcNlT1catVKATcD/Sku+VXTi+rOm2
         /71/5T1C0ke9wWPie6rD+BZTpzBs8luDUZadMmUeZl9KxQolw8HmqT451iif+i1ty7H7
         f2ypskBObPBPJqgCSAzER3WbYt3OHmzGvGut8ZS0uS+vNggDoQVk719WBviHlgLq0F0P
         RUqZZNJBYYr5Op/9617qSiMgOPjwn3cXjKHTB8KtnFVjLqhXl9FZ7iREReLHpVO5l6as
         3c2A==
X-Gm-Message-State: APuU4Z9CNcfoEW0EBiSFTRZkYHPRQ3YSsrT8bquWHFKTHR/XOr2uBGPf
	GeAD139sN6rwfwPYwn3OyGwF7smTk5NkN88fDrv2J+Mk8Yp4JSCMqO8LM68URCcHBPbjL2qLUvA
	ptDS+asM=
X-Gm-Gg: AZFdTZep187whmEsBKda3K+nub/4XLgapA+6KzRxbWZyxK5PeO+XiBHx5gCq9YjKE3m
	Bm9sUrKxcGSgGVNxWyZfY5LRTiMZ3dabq9Fgj3W3p63EJPJp0N0cHEeomzjAZzuUIjum8irl0Yy
	SXKO+Wj++ZHd/2stfxEfwLgr6kgk1Tm+E8+wiOm2v9zrvEPBDaAIT/ZrxbcrZRkHeF01EEztsTq
	cSLMbnOBN2LzBJhOrwd2W5+rJ5jm6zZyF1MRMppngw4xx9CXGyAt99541tRpdXcR0s8jm65Fley
	rllLjYbSx+wFYHtY05QRkj8HI0/WLHqx4BymtzZEO9I+aHSe1ePfkemRoQEiF5nzZPui70TjIhq
	A1C8n/tijCzqc7PnmODxPwYCwzF8hIR+KcBHkz7KnDHK8c78ZMeNNMFffWqZr/xAnQ4Ujk+/lNL
	uJ2GKbTnNkwLPsEBsyw0VS/gyHWn1H8xB/S/HCe/FIyQMLCokyPaagu7E0DGAiwT1yjp3KrSIf8
	kGn58PX2F9VBxGWUvplb4IzYqy851FF5XhOKBtl99p/iPDMIx9F/8EI+9w7//J2Kz7CF6fcrCtV
	MQOc10A7LZuO7SoIWlypJhZSQLfdn+nRo1Y1OVE1t8XGJSfBR92We6TPvIsgiapRr9VUEipySvL
	JnNkoQRxFLMzKBOk7Ahki4RJ42gXCJ1JSFPONFzHAXeK13iAosI5RJ4qWEBRg7TfHGw==
X-Received: by 2002:ac5:c4cf:0:b0:5ed:c029:411d with SMTP id 71dfb90a1353d-5ee5b7e9adcmr236496e0c.19.1794870778109;
        Mon, 16 Nov 2026 15:12:58 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:57 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 07/19] rust: backport deterministic DocLinkResMap serialisation
Date: Mon, 16 Nov 2026 18:12:28 -0500
Message-ID: <203375664141e8e5b9af36385df101e8c45315bd.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5446
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
index a294201..a50a3fd 100644
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
2.56.0

