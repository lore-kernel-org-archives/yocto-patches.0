Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E14C71135
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.5966.1724875797734114297
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T2KMTzeg;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a0c156a79so31962739f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875797; x=1725480597; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/NfpguG2h4Uo3+ReD5OYZhoHYO+s/dJNgm+0yx5lJA=;
        b=T2KMTzegso2ofCrb5iPlHHb2sAaIh6BIfR2J6+MaGX+yho3SGI2KgVZKci9NeGzXrW
         6yshpWOwj+lXXnj/n1XbC4GiBfb/jbaFlu+I93P4PujFTpbdu0kAPK5ftBknyI2TNrow
         2KD1YZquCXsZ6tC6ImNtTnrjQ0aTV4xZAEwmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875797; x=1725480597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/NfpguG2h4Uo3+ReD5OYZhoHYO+s/dJNgm+0yx5lJA=;
        b=ViIk1AUqUCB8Yjesys5os1fKrEw+lX/VW2MwPv+c/T1Z7QMQYGmeAAYKjMUHTkKlP9
         YewjXxhMo/x/33ryXn5CG8Z/HrYu3tejUJtRSv2HEhqYV+i6sBGBWeTEDSPuv7k8mb6f
         xkPMGBrDVZkj8XGtKYkNmDihobyVmY6gwjuNC+RhZ5KqFy0HcstPrv/4Txw71pCgAq3L
         W3lELS7uO+hz9w+/+tTFJgL8i7qogDTeAL0AxLUJMDuIE/whT+7D0NO1alZi2/5xdigz
         IXM5ds+PZjI96y6zQVZ6pe3BfxRhID9huNtDqJATF2zULhzxSxTPBiQ6/S3GfkY2zz2Z
         ge/w==
X-Gm-Message-State: AOJu0YyTUaR3CUo6JCt96TtBmS9bp/lv+S6siFgVk45vYJ9YU08W9n2b
	HWfaqwK+qHzzJ0Sf0+ldMwxCiTQ3xVUnrUMAabYEjVY6IrKe2Sv1A7HvFe8grbvHzasWIdVDsgS
	u
X-Google-Smtp-Source: AGHT+IFn4U03cZl+kF3y4OjcfYmEmzL4lCd2BP0dvzovi6g/0KaiXeQP/Y6WS8vphosjHZYSjumbbQ==
X-Received: by 2002:a05:6602:b8d:b0:824:dae5:8455 with SMTP id ca18e2360f4ac-82a110536a6mr72628639f.10.1724875796529;
        Wed, 28 Aug 2024 13:09:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 10/33] rust: add reproducibility patch to eliminate host leakage
Date: Wed, 28 Aug 2024 16:08:56 -0400
Message-ID: <98e84201314b2f212ab44a0b4e9ec29b2edbd02d.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/577

From: Alexander Kanavin <alex@linutronix.de>

[YOCTO #15185]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 924df18b47e9a69fa295bafe37bdb39d8eaea2bb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...te-host-information-into-compilation.patch | 51 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch

diff --git a/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch b/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
new file mode 100644
index 0000000..a6ee867
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
@@ -0,0 +1,51 @@
+From 065d7c263091118437465d714d8a29dbb6296921 Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Mon, 13 May 2024 14:57:54 +0200
+Subject: [PATCH] cargo: do not write host information into compilation unit
+ hashes
+
+This breaks reproducibility in cross-builds where the cross-target
+can be the same, but build hosts are different, as seen with
+"rustc --version -v":
+...
+host: x86_64-unknown-linux-gnu
+
+vs.
+
+host: aarch64-unknown-linux-gnu
+
+This can possibly be improved by only hashing host info if the build
+is a native one (e.g. there's no --target option passed to cargo
+invocation) but I'm not sure how.
+
+Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/cargo/issues/13922]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ .../src/cargo/core/compiler/context/compilation_files.rs      | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/src/tools/cargo/src/cargo/core/compiler/context/compilation_files.rs b/src/tools/cargo/src/cargo/core/compiler/context/compilation_files.rs
+index d83dbf10c..b2ad8d9f3 100644
+--- a/src/tools/cargo/src/cargo/core/compiler/context/compilation_files.rs
++++ b/src/tools/cargo/src/cargo/core/compiler/context/compilation_files.rs
+@@ -652,7 +652,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher) {
+     if vers.pre.is_empty() || bcx.config.cli_unstable().separate_nightlies {
+         // For stable, keep the artifacts separate. This helps if someone is
+         // testing multiple versions, to avoid recompiles.
+-        bcx.rustc().verbose_version.hash(hasher);
++        //bcx.rustc().verbose_version.hash(hasher);
+         return;
+     }
+     // On "nightly"/"beta"/"dev"/etc, keep each "channel" separate. Don't hash
+@@ -665,7 +665,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher) {
+     // Keep "host" since some people switch hosts to implicitly change
+     // targets, (like gnu vs musl or gnu vs msvc). In the future, we may want
+     // to consider hashing `unit.kind.short_name()` instead.
+-    bcx.rustc().host.hash(hasher);
++    //bcx.rustc().host.hash(hasher);
+     // None of the other lines are important. Currently they are:
+     // binary: rustc  <-- or "rustdoc"
+     // commit-hash: 38114ff16e7856f98b2b4be7ab4cd29b38bed59a
+-- 
+2.39.2
+
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index c83c8ec..20ef5e8 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -12,6 +12,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://target-build-value.patch;patchdir=${RUSTSRC} \
             file://0001-Handle-vendored-sources-when-remapping-paths.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-v175.patch;patchdir=${RUSTSRC} \
+            file://0001-cargo-do-not-write-host-information-into-compilation.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "4526f786d673e4859ff2afa0bab2ba13c918b796519a25c1acce06dba9542340"
 
-- 
2.46.0


