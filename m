Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03803C3ABB5
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:52 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.4581.1746132044074218022
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bb4TbMoP;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0ad74483fso17597086d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132043; x=1746736843; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=701OwC5UG1TQJmcEBrwnU4OmzWEB2OBCuVSTwUgCRFY=;
        b=bb4TbMoP7VUENjPR8CIkcxKULz1TiwZINmoZv6m5tuqHgIwRzjIWI2+/yMkM5rzmEM
         f59EYFvu2aWTulMUkd9XnmU1lrNoQ4uNHLJODVcOTzs9kWOj8u1XIZvmzkwz3S8tAmTh
         OTqkhdnrgXveG8Ywdv6wYqpSdwZNRWqde3Ff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132043; x=1746736843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=701OwC5UG1TQJmcEBrwnU4OmzWEB2OBCuVSTwUgCRFY=;
        b=OoAljM34jQlSzGmCBbST5lm/fuCOJmBXIYZFElyUHmVF4pGeeXhi47Xs7TyBVHihXg
         +4kfw9BkrbmzJfOAHw03nfqRmEjrU6spPsYD/HMrOOXCAh0WZ/jJZbr4M3JRr3V8HGCC
         QKOy083P3a04xCmVZc5Dnjtods6FbC0FuJTbgSm9rBO5AFvsBj6h13dwr1mFDQ57qkHb
         e/1hQSuS8AH/ZQ7RrtWEPSz7NhB3JP5pYsevvpKWu8Vh+yELk+FGqYaz/IvsqhZNyYTD
         DI1faARUXzWg3lNgOkpYlh5DXyz9VKNp958Sg2RXpE/hyYhKtBVn7ng53Aikzik7VT+d
         p0sA==
X-Gm-Message-State: AOJu0Yy2D9Gnsr7MQAvHzuV+B0VlwjhhYJE1y6Ut9HIIAOxYitzPfLS8
	j/f8Tz6XOMIHXsMKLuLpG5gkoF5GiQvLYf46oW2R2QSfsDgXXv6ifHrrN2+m0scY7P+8QoRWT4T
	J
X-Gm-Gg: ASbGnct/X5Xw1v2Bicjquxr6cMxiYSDzgkUQfXxsu6IO6K114G49RVzCC5Pky8XOFPN
	p2KGYApTiHXxHeR85BEe5W856ZF4w62lf4jeOxdiPCe8ekXmj50eVXKzOOTlg8oR48JMWlqOQkX
	dZGBtGM2FcY92LGc8uZ+SwevHdMcHSsV8NmucihkdAd2DWmirWVt44HRMdr+K1ufFNAqRbM3hvM
	L8Yc1cJBiGnlESHIGlTywkDsrjeaqfKxGLF30CkCJP5Zhnpg6ruoTbC38lGbx6Zu0JSx3KhpGw1
	zM0ywUjedqeoABsd9aD4FHNYA564hsEo4Vx2J4KfR4Z/7tmvaJSqDjko3yay7HuMEyqok7RX52T
	mRnhqnShqPykkYi7CEOGSUswIWu4=
X-Google-Smtp-Source: AGHT+IESrE06nA7QDystvVcRjSykNMuP6a4ug8/aJBjLAmXI/654c7fQoaGh13blHMYET2rPgMkJow==
X-Received: by 2002:a05:6214:1c07:b0:6f4:c9a6:b53a with SMTP id 6a1803df08f44-6f5154a2797mr10545236d6.26.1746132042587;
        Thu, 01 May 2025 13:40:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/38] rust: restore parallel builds, disable lto only for rustdoc
Date: Thu,  1 May 2025 16:39:44 -0400
Message-ID: <3c160d7db9b0a90a0ce904ee5487a53f0c77b2aa.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1435

From: Alexander Kanavin <alex@linutronix.de>

The original reproducibility fix was problematic for a couple reasons:

- disabling both lto and parallel builds had an unfortunate effect of nearly
doubling rust-native and rust build times (which are slow to begin with).
Disabling lto hurts runtime performance too.

- both of these things were done for the *entire build*, while the only
problematic item is the librustdoc crate.

- lto=off option in config.toml has an effect only on building rustc
(the compiler itself), and doesn't help with rustdoc reproducibility.
Actual fix is the codegen-units setting, which indirectly disables
lto via giving llvm only one unit to work with at a time.

After some digging, here's a more targeted fix for the problem.

Why librustdoc is non-reproducible, but not anything else
remains a mystery, hidden deep in rust-llvm's lto optimization code.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a1977407a88a2004c3a6d2dba1d5bfe1aa1664b2)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...teps-tool.rs-switch-off-lto-for-rust.patch | 46 +++++++++++++++++++
 ...ue-fix-cargo-config-for-codegenunits.patch | 26 -----------
 recipes-devtools/rust/rust-source.inc         |  2 +-
 recipes-devtools/rust/rust_1.81.0.bb          |  1 -
 4 files changed, 47 insertions(+), 28 deletions(-)
 create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
 delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch

diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
new file mode 100644
index 0000000..e63cfb0
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
@@ -0,0 +1,46 @@
+From ce68809d41291f671b440abce41f8f71c95428aa Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Mon, 3 Feb 2025 20:06:46 +0100
+Subject: [PATCH] src/core/build_steps/tool.rs: switch off lto for rustdoc
+
+For reasons currently unknown, librustdoc binary ends up with
+non-reproducible .llvm.<number> suffixes in its symbols - but
+not any other binary.
+
+Disabling lto avoids creating these suffixes. More info about the option:
+https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
+
+As seen below, there's a comment in the source tree saying not to tweak the options
+but this only creates a mix of lto and non-lto optimized binary objects from
+various crates, which should be safe to mix.
+
+Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/rust/issues/134589]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ src/bootstrap/src/core/build_steps/tool.rs | 3 ++-
+ 1 file changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/src/bootstrap/src/core/build_steps/tool.rs b/src/bootstrap/src/core/build_steps/tool.rs
+index 087df2f8a..00790affb 100644
+--- a/src/bootstrap/src/core/build_steps/tool.rs
++++ b/src/bootstrap/src/core/build_steps/tool.rs
+@@ -635,7 +635,7 @@ impl Step for Rustdoc {
+         }
+ 
+         // NOTE: Never modify the rustflags here, it breaks the build cache for other tools!
+-        let cargo = prepare_tool_cargo(
++        let mut cargo = prepare_tool_cargo(
+             builder,
+             build_compiler,
+             Mode::ToolRustc,
+@@ -645,6 +645,7 @@ impl Step for Rustdoc {
+             SourceType::InTree,
+             features.as_slice(),
+         );
++        cargo.rustflag("-Clto=off");
+ 
+         let _guard = builder.msg_tool(
+             Kind::Build,
+-- 
+2.39.5
+
diff --git a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
deleted file mode 100644
index 0aab877..0000000
--- a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
+++ /dev/null
@@ -1,26 +0,0 @@
-rust: rustdoc reproducibility issue fix
-
-rust: rustdoc reproducibility issue fix
-
-The 'codegen-units' option split the crate into multiple compilation units for parallel compilation. Currently, this split is causing the rustdoc to generate differnt binary between the builds.
-To fix this the codegen-units & the lto options are disabled.
-
-More info about options:
-https://doc.rust-lang.org/cargo/reference/profiles.html#codegen-units
-https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
-
-Upstream-Status: Inappropriate [oe specific]
-
-Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
----
---- a/.cargo/config.toml
-+++ b/.cargo/config.toml
-@@ -3,3 +3,7 @@
-
- [source.vendored-sources]
- directory = "vendor"
-+
-+[profile.release]
-+codegen-units = 1
-+
-
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 342d56c..0eb68b5 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -4,10 +4,10 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://zlib-off64_t.patch;patchdir=${RUSTSRC} \
             file://rv32-rustix-libc-backend.patch;patchdir=${RUSTSRC} \
             file://rv32-cargo-rustix-0.38.28-fix.patch;patchdir=${RUSTSRC} \
-            file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
+            file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "36217ef7e32f40a180e3d79bd666b4dfdaed49dd381023a5fb765fd12d0092ce"
 
diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index 782c37f..8cb4558 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -136,7 +136,6 @@ python do_configure() {
     config.add_section("rust")
     config.set("rust", "rpath", e(True))
     config.set("rust", "remap-debuginfo", e(True))
-    config.set("rust", "lto", "\"off\"")
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
 
     # Whether or not to optimize the compiler and standard library
-- 
2.49.0


