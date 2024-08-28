Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16747C7113D
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:06 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.5855.1724875805314687894
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M432/t1I;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a10bd0d58so9090139f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875804; x=1725480604; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5sZVAPO45XBnB2Uh1EZtQuQV/7ZSWlnfLRxVlyebs4=;
        b=M432/t1IJv1UusSdhmWET77xVAv/4adovE0l6RTtp57ScnsioJtsbgN+Ip7A7UICht
         kMobCH5BgURHPe0Npi5VpyLo0LgS73LCeP+OTGdOgCPx/uOccvyQq2FN422/MIcW6s3v
         dMArbrx1Xdjq7gz2ogsrw4aWARgLDla4W+OC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875804; x=1725480604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5sZVAPO45XBnB2Uh1EZtQuQV/7ZSWlnfLRxVlyebs4=;
        b=v1/YwRYJY2iP5n6lq0LX8YgTgV3sCmKvUegeDNFphSjK8y959zz04iibKX+FUeTtfD
         reEOSOG1aOSVWdtRLYJeKqeAnV/7J/Sb+mzBBF+trOY1F4EjhhfxDFvWdDXHCu/NhuUE
         LuQr9LW1ZIxPljMMTkjsnRorP8qtonxLKEPRh+4/kStagJYYuD7k8az0iOZK/BtXbM+/
         NyTUNrnEm5RfzTiIHXXo8++8TpRuyj7eCreT82GwHRX0ENSi8s/JDHmENwttBJTfp9R8
         alOlmLKy7e4lwfYCn0XcvkvCVqJIu/jY5fYaT6qE2ZNPgsCAyZpgia86a9L4c+sHNX+3
         8VkQ==
X-Gm-Message-State: AOJu0YyYtHuuUxEMXYvUkV9eYvte7Hr9QClzOhunwP91aIS7ThMKx1KG
	vdTBc9hfyQ4mtv/HgLzMsqKPipcmwH/VEBx0Si8/SpAokZN7/jZ6ZtoFiyZALWgOpAxD9S2ow98
	L
X-Google-Smtp-Source: AGHT+IEgXohPlBo8jvya+EwdxdqWihSUhG0Z6t5ERkylWY8SZSQDJLmEhcpAW2zRNDAU1XaRVuyMYQ==
X-Received: by 2002:a5d:8b19:0:b0:805:2048:a492 with SMTP id ca18e2360f4ac-82a13eb1997mr15482539f.6.1724875804218;
        Wed, 28 Aug 2024 13:10:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 20/33] rust: rustdoc reproducibility issue fix
Date: Wed, 28 Aug 2024 16:09:06 -0400
Message-ID: <984b35e4dfe2870041268376e8ac3dc3236e8373.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/587

From: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>

The 'codegen-units' option split the crate into multiple compilation units for parallel compilation. Currently, this split is causing the rustdoc to generate differnt binary between the builds.
To fix this the codegen-units & the lto options are disabled.

More info about options:
https://doc.rust-lang.org/cargo/reference/profiles.html#codegen-units
https://doc.rust-lang.org/rustc/codegen-options/index.html#lto

Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 0c00875de10b171f4ff2990af351a8124ec7e972)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ue-fix-cargo-config-for-codegenunits.patch | 26 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 recipes-devtools/rust/rust_1.75.0.bb          |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch

diff --git a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
new file mode 100644
index 0000000..0aab877
--- /dev/null
+++ b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
@@ -0,0 +1,26 @@
+rust: rustdoc reproducibility issue fix
+
+rust: rustdoc reproducibility issue fix
+
+The 'codegen-units' option split the crate into multiple compilation units for parallel compilation. Currently, this split is causing the rustdoc to generate differnt binary between the builds.
+To fix this the codegen-units & the lto options are disabled.
+
+More info about options:
+https://doc.rust-lang.org/cargo/reference/profiles.html#codegen-units
+https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
+
+Upstream-Status: Inappropriate [oe specific]
+
+Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
+---
+--- a/.cargo/config.toml
++++ b/.cargo/config.toml
+@@ -3,3 +3,7 @@
+
+ [source.vendored-sources]
+ directory = "vendor"
++
++[profile.release]
++codegen-units = 1
++
+
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 20ef5e8..facf6eb 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -13,6 +13,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Handle-vendored-sources-when-remapping-paths.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-v175.patch;patchdir=${RUSTSRC} \
             file://0001-cargo-do-not-write-host-information-into-compilation.patch;patchdir=${RUSTSRC} \
+            file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "4526f786d673e4859ff2afa0bab2ba13c918b796519a25c1acce06dba9542340"
 
diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/rust_1.75.0.bb
index b041a5f..396ea9c 100644
--- a/recipes-devtools/rust/rust_1.75.0.bb
+++ b/recipes-devtools/rust/rust_1.75.0.bb
@@ -136,6 +136,7 @@ python do_configure() {
     config.add_section("rust")
     config.set("rust", "rpath", e(True))
     config.set("rust", "remap-debuginfo", e(True))
+    config.set("rust", "lto", "\"off\"")
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
 
     # Whether or not to optimize the compiler and standard library
-- 
2.46.0


