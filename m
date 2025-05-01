Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29FC3ABAC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.4666.1746132066277764136
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pVi9Sylz;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso26830826d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132065; x=1746736865; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrZ0tczolU7klT9E7N+pG7+sBa3vxD4pUyUVCikxUlo=;
        b=pVi9SylzlSkAtqmLzdv4uNlFBoLVnOK2TCuToJv/zHGvvgi6PUphksCSC+pN+vY0+m
         gZahD/gZGen3hAlGP+6fZa6/7sv0AQq57Hoi14Pi17w8A1Ld4QqFPq1E0kHTeYuLTQ48
         99p5+Is242B0AJNdWjcfv45cgUm0Ay+TVTpMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132065; x=1746736865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrZ0tczolU7klT9E7N+pG7+sBa3vxD4pUyUVCikxUlo=;
        b=OJS1We7RvlYqZu/MqOBNUY23vi/QTJqb8fMC1AOVbyUZHK/ImyMrcRQ/Ydkt9roLe6
         PKMSFFgFD6xe3mjeCrJ01KqRlesKZKC2plQMqqzM4y/9g6k/fr2jmdBZifw2rowHQbzl
         jo02dVThhEjMVP5x+JNMyuLqgCo3P/tg6lVJabuIaOUMaoVhGgxMNdc0ny6pCDUDSDNT
         T5LJYiGK5k/M/L841u3CERYeAiZNlqz12wjMjJ21C5hcv13+fXO4t6xSdC072GHcvLBK
         FoJKmIcoKahOWLAv67y5/zwL07HCyw9g2Qkyi0xGhZrAj4vXG1eFpe8jrSdf7s/F1ak3
         zoOQ==
X-Gm-Message-State: AOJu0YxE+SoXg3akAz26AA7uQHxdgw0Z947AFQqkd7hnrq1tnPepg4oF
	xPYP+CPqKDp8uP3Tm4NZlLCGGyvvvlCICtkTcXWMyC3VHi/Zzxv+MduoRSwz6DAfUpLDUo9+v07
	W
X-Gm-Gg: ASbGncvXFUDqR0OAlPs/7vQexarwQdDwDPyAdeXJLu4S1+f6IZtvhFs+VG7iOvvlx7x
	z4NxOSoPyVX8cP4c1NzKc9zCC5S7QzNI1drNfMB2/IVyYkmETYF7e/wuHbV7M7pMgAXlXPYO+fh
	AjRmalF32RvIxtxchQY4iSJi8u0zbQIoV29TjT4emX2BlTx6NjHgYWB3KkVcXR+xyjpkUHLtNcD
	Vb4+ywbKSL19mey6DqtR3OhCqyUja45QMoDMRgwuoBZOg1txk1jkbjwutw2wmMjBVRw2I8Bwzei
	XwxJE+gc2ENKSuei0nnNN8OoNAYv6SO4ua/WfJU4F1nfEX2JJvx5kFgQkezvZznkI7S39iBx4wZ
	aWGDXLWcVM/7xqsOT01myUZhB1o8=
X-Google-Smtp-Source: AGHT+IG3neC7MD4Eq2zgzpYFu4yBQcoG0PQUYZShaUg0rKUOOlcCIH9m89bt3TX1ZBgvqz5xci+6rQ==
X-Received: by 2002:a05:6214:c23:b0:6f4:cdca:2a6e with SMTP id 6a1803df08f44-6f51565004amr9536806d6.45.1746132064979;
        Thu, 01 May 2025 13:41:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 30/38] rust: Upgrade 1.85.0->1.85.1
Date: Thu,  1 May 2025 16:40:06 -0400
Message-ID: <c0794922957a6e5df23e6f4922bd252adb5f5d80.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1456

From: Yash Shinde <Yash.Shinde@windriver.com>

Rust stable version updated to 1.85.1
https://blog.rust-lang.org/2025/03/18/Rust-1.85.1.html

Dropped patches:
downgrade-bootstrap-cc.patch since it's merged with v1.85.1.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b141115b9c8e052df096e55d92972b1db4c84f4e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  2 +-
 .../rust/{cargo_1.85.0.bb => cargo_1.85.1.bb} |  0
 .../rust/files/downgrade-bootstrap-cc.patch   | 41 -------------------
 ...ibstd-rs_1.85.0.bb => libstd-rs_1.85.1.bb} |  0
 ....85.0.bb => rust-cross-canadian_1.85.1.bb} |  0
 ...ust-llvm_1.85.0.bb => rust-llvm_1.85.1.bb} |  0
 recipes-devtools/rust/rust-source.inc         |  3 +-
 .../rust/{rust_1.85.0.bb => rust_1.85.1.bb}   |  0
 8 files changed, 2 insertions(+), 44 deletions(-)
 rename recipes-devtools/rust/{cargo_1.85.0.bb => cargo_1.85.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
 rename recipes-devtools/rust/{libstd-rs_1.85.0.bb => libstd-rs_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.85.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.85.0.bb => rust-llvm_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.85.0.bb => rust_1.85.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7eda5ad..281eeca 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.85.0%"
+RUSTVERSION ?= "1.85.1%"
 
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.85.0.bb b/recipes-devtools/rust/cargo_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.85.0.bb
rename to recipes-devtools/rust/cargo_1.85.1.bb
diff --git a/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch b/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
deleted file mode 100644
index 3ae6872..0000000
--- a/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-Downgrade bootstrap cc version
-
-In rust v1.85.0, the upgraded cc version causes bootstrap
-to fail on custom targets. Downgrading the cc version fixes
-the error. This commit is merged with v1.85.1 and the patch
-can be dropped when upgraded to it.
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/137460/commits/e4ca11f87ffca8c63aa56d45b46e62b6acc58bd7]
-
-Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
-diff --git a/src/bootstrap/Cargo.lock b/src/bootstrap/Cargo.lock
-index a47f3af60cb..890e64e2bab 100644
---- a/src/bootstrap/Cargo.lock
-+++ b/src/bootstrap/Cargo.lock
-@@ -88,9 +88,9 @@ dependencies = [
-
- [[package]]
- name = "cc"
--version = "1.2.0"
-+version = "1.1.22"
- source = "registry+https://github.com/rust-lang/crates.io-index"
--checksum = "1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"
-+checksum = "9540e661f81799159abee814118cc139a2004b3a3aa3ea37724a1b66530b90e0"
- dependencies = [
-  "shlex",
- ]
-diff --git a/src/bootstrap/Cargo.toml b/src/bootstrap/Cargo.toml
-index ed51862390d..2c1d85b01e6 100644
---- a/src/bootstrap/Cargo.toml
-+++ b/src/bootstrap/Cargo.toml
-@@ -37,7 +37,9 @@ test = false
- # Most of the time updating these dependencies requires modifications to the
- # bootstrap codebase(e.g., https://github.com/rust-lang/rust/issues/124565);
- # otherwise, some targets will fail. That's why these dependencies are explicitly pinned.
--cc = "=1.2.0"
-+#
-+# Do not upgrade this crate unless https://github.com/rust-lang/cc-rs/issues/1317 is fixed.
-+cc = "=1.1.22"
- cmake = "=0.1.48"
-
- build_helper = { path = "../build_helper" }
diff --git a/recipes-devtools/rust/libstd-rs_1.85.0.bb b/recipes-devtools/rust/libstd-rs_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.85.0.bb
rename to recipes-devtools/rust/libstd-rs_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.85.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.85.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.85.0.bb b/recipes-devtools/rust/rust-llvm_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.85.0.bb
rename to recipes-devtools/rust/rust-llvm_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index a1ec808..86e1ede 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,9 +8,8 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
-            file://downgrade-bootstrap-cc.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "d542c397217b5ba5bac7eb274f5ca62d031f61842c3ba4cc5328c709c38ea1e7"
+SRC_URI[rust.sha256sum] = "b1fbf809efe9f036939401e142631c201a53bcf43ec1696bd9f5290ba236a266"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.85.0.bb b/recipes-devtools/rust/rust_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.85.0.bb
rename to recipes-devtools/rust/rust_1.85.1.bb
-- 
2.49.0


