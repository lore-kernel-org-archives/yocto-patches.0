Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6165.1794870778930009357
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nir4GEv9;
 spf=pass (domain: konsulko.com, ip: 209.85.221.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so1066213e0c.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870778; x=1795475578; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m6WYm180rnxQqfub6aQrDmhVrd8S6Sh09QcYU9povQ8=;
        b=nir4GEv9hE3YYX758em/BxZILbJW0kS4Z2/YnzSaqPxF1R+dyfIxQtfx3hAsoLHmlR
         9Tr2Xk+5nmkT3Ja/3nqiq2kV1QuMEcU5iqVKhH4r3nKSn92TDomrLfm+ZavDUkf5BFJB
         tQbOwVfirJIZeKuJcrbQkr7cz1M9h2xuXWreI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870778; x=1795475578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m6WYm180rnxQqfub6aQrDmhVrd8S6Sh09QcYU9povQ8=;
        b=BQOoe9Uzuqz2zAw435ZPVfffldHer+QanFj9jwEAF+mpR8QfKpaiECop2i9BKmBkm0
         /haZ6Aq3Tx5rkGCPH8u7DsjVWiinm3liZXktjeE88aw9fYkQln54jN5jUsfXdCAXpZod
         lOUucVVJ4p4GkrhoCIA1mFOl8twq8D28ijOLfngralt/lTi0njFoXcQttnSYc9N8ADib
         3+9zbo7Kz5BtuFTxfvBjuzkODSUYAUGola1nONEVvYIEIpafPsv+fTYbIS2A02PlFsZv
         wrq7GlhVB29yXupzU6PiOzMbWg1xpJS27CusADV/6HcUL/4KORiffuhP5dGey37jb3S1
         bIjg==
X-Gm-Message-State: APuU4Z/x9Rzt1DrPZVgBubM9iNThGvsLU3Py+2+5zk9TnR600I/7jvAu
	+LCp5AbNGuYyCVQ++ITGCOcGz/DG9FvCzgjBOQo3BsmnQ0MX7QBCxsSbAbyQnd9fBSnM7ibzIVq
	cdAhxV24=
X-Gm-Gg: AYBFou2QkuSYkiyoBLBYKh5PS90hS30NXNzmESGnP7atSxXW3rbwbbOuQdkdu9++aa4
	9t0cQ0hLhQjKytFnfi8gGslMOcmk2CHgQ4/Jt2G30t5SAV7yzfOQQDFK6qTo9S6RjdyQTox6m2B
	a/1w2KQmMTn8NUTZ3AwbQF+opjjjQ1cR3cnhN2t5FJD204kFZ5skbJT+ZzprXZ01ft1WBwOe+ci
	2R18MT9fFKtf8ql3KKvzVur8cjI0qRIrtp6nvI9J3rxc/pwPR/CF7GTsBrcCRdq3lTI9V1H5F1M
	c5JNJf5PH6nsfhy10Rr/8MbvGdbUzFGyGiwHuCGVPw9UpbmYQ9l8eRmRTQhrfNmWs3l330myEiJ
	b9FnPTBWh7LeMVN6Y8DWQ/UEaNyoUA5JKHTOm/D+NZutFCsrDGj1HTZvyUDLuKuauWCGf9wFhTz
	tY6oAxjnYaEQghlki20R4tx7Xtn3xoSXeEePShvopMZOw3HLNT5bRQzb8DgoSIwgJcQC8q7Nuux
	vUIkwg6eH6T0DeGZwFyi+VWm7bduzQnV+1PYb3ZfCBxckVoayEbJtxtcOEMz65RFLEAEmhCQUyg
	IvbYZj4h2X4hag6Ky05adyu0wTLMY//LJLteg6ZOjL+XSCFjTQDOqTyKrMCg44ypIp3m27nIEkk
	Tk0fYvt8NQZBKCoA95g47EVInveY6b1ralmhj4g2F1AJTM9iyC4d6Lu+HghNouW7YOg==
X-Received: by 2002:a05:6122:4d18:b0:5ea:e188:a5af with SMTP id 71dfb90a1353d-5ee34a5afe2mr4356602e0c.11.1794870777507;
        Mon, 16 Nov 2026 15:12:57 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:57 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 06/19] rust: keep the build host triple out of cargo unit metadata
Date: Mon, 16 Nov 2026 18:12:27 -0500
Message-ID: <89534c069b46b3383814fd2ddec6fee449c7ca5c.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5445
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
index 54502cc..a294201 100644
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
2.56.0

