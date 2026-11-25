Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3151.1795645888373628979
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZuvlBa3i;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55d3563e50eso43646651cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645887; x=1796250687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EiA/oJW7UCZ2DS/h5DCD1pKwgKyEfkwdMZU5E48bPvc=;
        b=ZuvlBa3iWt1vOLFFPkeqr1LACN4Zo8cxv7xFt5k65v5ebs+v7Db/oM8tg+oE+7wOYU
         wty/u8oUyBnLNyvbm5cIYxD8wwq8vMyRAqO8tsBmx0aAGAHiWbn5nELJIxuqSMzA0jzy
         5Zq48iZNXv1yGd/bcOVZgo0m6k4wTNE6rtqto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645887; x=1796250687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EiA/oJW7UCZ2DS/h5DCD1pKwgKyEfkwdMZU5E48bPvc=;
        b=K2FPWamkDk6PhBPE4Y2+fMNMgZhL1fbTC3wv138+9uVRz/a7v0n3wjcQ7RK2na6+zk
         EVNex88ZscSuRenm4cAKXeMkylMb9joA2nxVwrxF3kCZTsePHJUbUMiMayN2g0a6irz/
         QlOHgxDSAcjjZlYEH7bp+b0/lP5B38LptuUxsJJoiFjd7rDroPTgDdNrA2FjWHabEwew
         14U5fgiyEvAI+hGa0eWPvPGbb0esEr+0W+AdamymBLwzi/PXk3y9rHExJlccPwhpFIUb
         V9CuodvKVV0iY4rRy1xxFb7UcRPdKVKzc2UREao9A91ArByMt5o62wDlTSCFh1LJ3oIj
         zBmw==
X-Gm-Message-State: APuU4Z908/Zn5ItAxzxF6igYXkRZZ8CP5A/d+z7Dtr5oTSqRQTS34nEG
	BNmue1iwmn3e6kDkfwMFH2O5FGYJlvtf0Fos6nBlPeOTwGUJXmYcwhsE4UeiMz8zTfUD+/IWFoH
	xPqHh
X-Gm-Gg: AZFdTZdowdJZrRcg4BsyDEMU0L4xZzc1AbhK+3Vg0+PXkSJYUR29U/UJfJPxF6Tt+4d
	8Ewp8Tz1X9DUb9xYLXaF4CdEcqt7RJuAjl3weVLav/XLz5gYxtRV6yg1Do1zl1HAN667Qzk3bVx
	89gG3mrqBPq3PcuSYJVu2L3H6gaOp/asH+ouxWr/GqUbgHIOkfv+tSUukFfyQ2dnsh9S5ZbbCHI
	+QTHZSS9LG0xl2TarlUrSWWhwUPff4ft+Rr4wTy5M3ZVwyDYyTp+4MxNwchH1zuNHhKhJAFKGuu
	PxGWYHej98wKzT79jJOkVHMlDhimSyGNlaqJz44MwarBJFJhMRdPdVJGCQcPQBqIpXrD41BO2V7
	tnodI2DbnbzD9HU1K2xqvj17pHUzyJDNhARbz8XA9N62xFvdanpBxAEBuqg6JNuh9QkLjrsSRQN
	PexcdeAaIH1VPwnMDlQTGt/Hc58X6OU/UqxP5Wfg+giS9wocLAAcd/rqJJF/Ly4maRWKpNnoc98
	1ctXLvE3Xrf7si91zrFZHfFifgQ0dv1Zn+HHuRhJh53PeEep+f5iz16Z8kbWQEKf7D7l4MvTbDR
	4n3DNomJLsPiSmTmxPcrT7GptxXDNERMm9iZBtzj6l3iNM9eqcEPNE49C2RZazbzS3JYTqQA2wh
	d1S29gaSBVrxYzL3bMuq0g7UJz31PadNKEZkvriwkbD3gLm7VodS2WQu+nfJUcoaJZf/hsPqj4M
	57knUiEfTMopw=
X-Received: by 2002:a05:622a:613:b0:535:b21:c997 with SMTP id d75a77b69052e-55d769314admr347120471cf.8.1795645887157;
        Wed, 25 Nov 2026 14:31:27 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/19] rust: keep the build host triple out of cargo unit metadata
Date: Wed, 25 Nov 2026 17:30:57 -0500
Message-ID: <ed052e8986724b9bad03b8fdd32e5ceee01aa215.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5525
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

cargo hashes the "host:" line of "rustc -vV" into the metadata of build
scripts and proc-macros. Every target crate that depends on one picks it
up, so the same crate gets a different -C metadata and StableCrateId on
an x86_64 and an aarch64 build host. The added patch drops the host line
from that hash.

[YOCTO #16376]

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4c0fc1948a5c4205b16923c25a071f3f87e5f1fb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...-host-triple-from-unit-metadata-hash.patch | 62 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch

diff --git a/recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch b/recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch
new file mode 100644
index 0000000..d4cb48a
--- /dev/null
+++ b/recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch
@@ -0,0 +1,62 @@
+From 5c4fd7d8b85f4de5be387777a782fc3ddd1227d8 Mon Sep 17 00:00:00 2001
+From: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
+Date: Tue, 15 Sep 2026 17:05:36 +0530
+Subject: [PATCH] rust: keep the build host triple out of cargo unit metadata
+
+cargo hashes the "host:" line of "rustc -vV" into the metadata of host
+units, that is build scripts and proc-macros. Every target crate that
+depends on one picks that up through its own metadata, so the same crate
+gets a different -C metadata and StableCrateId on an x86_64 and an aarch64
+build host. Drop the host from the hash. The same class of problem is
+reported upstream, framed as OS differences, in
+https://github.com/rust-lang/cargo/issues/8140.
+
+Patch by Alejandro Enedino Hernandez Samaniego, from his strict-version-hash
+v5 series for openembedded-core:
+https://lists.openembedded.org/g/openembedded-core/topic/120939810
+
+Upstream-Status: Inappropriate [OE-specific]
+
+Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
+Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
+---
+ .../core/compiler/build_runner/compilation_files.rs    | 10 ++--------
+ 1 file changed, 2 insertions(+), 8 deletions(-)
+
+diff --git a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.rs b/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.rs
+index 88cab85..9dbd203 100644
+--- a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.rs
++++ b/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.rs
+@@ -877,7 +877,7 @@ fn has_remap_path_prefix(args: &[String]) -> bool {
+ }
+ 
+ /// Hash the version of rustc being used during the build process.
+-fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher, unit: &Unit) {
++fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher, _unit: &Unit) {
+     let vers = &bcx.rustc().version;
+     if vers.pre.is_empty() || bcx.gctx.cli_unstable().separate_nightlies {
+         // For stable, keep the artifacts separate. This helps if someone is
+@@ -886,7 +886,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher, uni
+         // omitted since rustc should produce the same output for each target
+         // regardless of the host.
+         for line in bcx.rustc().verbose_version.lines() {
+-            if unit.kind.is_host() || !line.starts_with("host: ") {
++            if !line.starts_with("host: ") {
+                 line.hash(hasher);
+             }
+         }
+@@ -899,12 +899,6 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hasher: &mut StableHasher, uni
+     // This assumes that the first segment is the important bit ("nightly",
+     // "beta", "dev", etc.). Skip other parts like the `.3` in `-beta.3`.
+     vers.pre.split('.').next().hash(hasher);
+-    // Keep "host" since some people switch hosts to implicitly change
+-    // targets, (like gnu vs musl or gnu vs msvc). In the future, we may want
+-    // to consider hashing `unit.kind.short_name()` instead.
+-    if unit.kind.is_host() {
+-        bcx.rustc().host.hash(hasher);
+-    }
+     // None of the other lines are important. Currently they are:
+     // binary: rustc  <-- or "rustdoc"
+     // commit-hash: 38114ff16e7856f98b2b4be7ab4cd29b38bed59a
+-- 
+2.43.0
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 99ae2d9..2beec08 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,6 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch;patchdir=${RUSTSRC} \
             file://0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch;patchdir=${RUSTSRC} \
             file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
+            file://0007-cargo-omit-host-triple-from-unit-metadata-hash.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "be1816e7f6c40abb90245ad6e024bed2a7e88d7dda4561e4d5470207df616b9f"
 
-- 
2.56.1

