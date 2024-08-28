Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3BC7112B
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.5846.1724875797180901766
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TK1e1WVQ;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8252bc7b00bso256030939f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875796; x=1725480596; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uCA5TJD8CldVJiYg5JpRK0xJgHekStiP5XnmsGvxZQ=;
        b=TK1e1WVQhZ0iGaq60J0dPCYpSPDkC1FHJkUCH8JJSNC8xfVT1M6lxHn0CRFEbIaSli
         1vAU26rDfcEKJINhwmS0Lp6R2ayP+lszZ+9KHp+JjgSinwsqj3lpugqDVWSjyjQBruzy
         fzehHBrJHk8e7vCDkapiELGW2G8no8MB65E/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875796; x=1725480596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uCA5TJD8CldVJiYg5JpRK0xJgHekStiP5XnmsGvxZQ=;
        b=SwxRRDJnpo1nU13CZdyI+OwEePFIgUxV4/2Vv2Thj8E7Vss2M0EP9Jp7ii6RR9ExrU
         XLOn4S1yp0DYUtr1KKiuzceG3ACYzHivAdqjyyyyIMHj4GMg3T1Jjrb4b91pSGyKN7iR
         o5798+u0S5+IWhQdx/WrJyFU/HJg5n0k1/i3XV8isKpW1L09ia7mXb0h1+n2cIYyTJwt
         xknVzvzMCD9qE7Pd+/OmCaqI6RSxRnbSg+Jn3Od17DExbt73vFo3MqL6KX4jYlO3VOkg
         NEqWk890/LrHoWI3Wh9K/XHI9c1w8/KLuuEnrteg3xndxt8lSdg4gE2sjHQgW3NVqzd7
         WshA==
X-Gm-Message-State: AOJu0Yy/ASCLzrRJSU5rewjPfCZkQQfIvDEPtM5GD/Y1DCVnIgxOMERY
	9AaJZXkp1Vsuhu35rehVq9v46F8BzHCiVYtgCiSU/Z2mIuBr+QU36SlPff6zjZ/FF2gdf7/+KNe
	o
X-Google-Smtp-Source: AGHT+IEImA0kEDOWmrQh/W6RTtH6fH5p25/5JXUrnXt8P0Ol+mmlag9PL4FYyhn6s0Mxes+4wI9mDw==
X-Received: by 2002:a05:6602:6c1c:b0:82a:10c0:700 with SMTP id ca18e2360f4ac-82a11012eb5mr81357739f.5.1724875795945;
        Wed, 28 Aug 2024 13:09:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/33] rust: correctly link rust-snapshot into build/stage0
Date: Wed, 28 Aug 2024 16:08:55 -0400
Message-ID: <adb491e29d025f8295e7e9988214988b9dc53ec6.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/576

From: Alexander Kanavin <alex@linutronix.de>

This does not seem to be used in regular builds, but is beneficial
in rust selftest, where it allows dropping a custom patch
that is unsuitable for upstream (and was rejected by them).

Also remove an obsolete comment that seems related to the code
but describes something that was resolved long time ago.

I have confirmed that the rust selftest continues to pass with just
this one commit on top of master (as the following changes do break
the selftest).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit bf5732e2b235ce06fa1f24fe8f0dbcbc068500e3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/files/cargo-path.patch | 37 --------------------
 recipes-devtools/rust/rust-source.inc        |  1 -
 recipes-devtools/rust/rust_1.75.0.bb         |  6 ++--
 3 files changed, 2 insertions(+), 42 deletions(-)
 delete mode 100644 recipes-devtools/rust/files/cargo-path.patch

diff --git a/recipes-devtools/rust/files/cargo-path.patch b/recipes-devtools/rust/files/cargo-path.patch
deleted file mode 100644
index 9a50c40..0000000
--- a/recipes-devtools/rust/files/cargo-path.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-Fix the cargo binary path error and ensure that it is fetched
-during rustc bootstrap in rust oe-selftest.
-
-======================================================================
-ERROR: test_cargoflags (bootstrap_test.BuildBootstrap)
-----------------------------------------------------------------------
-Traceback (most recent call last):
-  File "/home/build-st/tmp/work/cortexa57-poky-linux/rust/1.74.1/rustc-1.74.1-src/src/bootstrap/bootstrap_test.py", line 157, in test_cargoflags
-    args, _ = self.build_args(env={"CARGOFLAGS": "--timings"})
-  File "/home/build-st/tmp/work/cortexa57-poky-linux/rust/1.74.1/rustc-1.74.1-src/src/bootstrap/bootstrap_test.py", line 154, in build_args
-    return build.build_bootstrap_cmd(env), env
-  File "/home/build-st/tmp/work/cortexa57-poky-linux/rust/1.74.1/rustc-1.74.1-src/src/bootstrap/bootstrap.py", line 960, in build_bootstrap_cmd
-    raise Exception("no cargo executable found at `{}`".format(
-Exception: no cargo executable found at `/home/build-st/tmp/work/cortexa57-poky-linux/rust/1.74.1/rustc-1.74.1-src/build/x86_64-unknown-linux-gnu/stage0/bin/cargo`
-
-Upstream-Status: Submitted [https://github.com/rust-lang/rust/pull/120125]
-
-Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
----
-diff --git a/src/bootstrap/bootstrap.py b/src/bootstrap/bootstrap.py
---- a/src/bootstrap/bootstrap.py
-+++ b/src/bootstrap/bootstrap.py
-@@ -954,9 +954,11 @@
-         if "RUSTFLAGS_BOOTSTRAP" in env:
-             env["RUSTFLAGS"] += " " + env["RUSTFLAGS_BOOTSTRAP"]
-
--        env["PATH"] = os.path.join(self.bin_root(), "bin") + \
--            os.pathsep + env["PATH"]
--        if not os.path.isfile(self.cargo()):
-+        cargo_bin_path = os.path.join(self.bin_root(), "bin", "cargo")
-+        if not os.path.isfile(cargo_bin_path):
-+            cargo_bin_path = os.getenv("RUST_TARGET_PATH") + "rust-snapshot/bin/cargo"
-+            env["PATH"] = os.path.dirname(cargo_bin_path) + os.pathsep + env["PATH"]
-+        else:
-             raise Exception("no cargo executable found at `{}`".format(
-                 self.cargo()))
-         args = [self.cargo(), "build", "--manifest-path",
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index b14221b..c83c8ec 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,7 +7,6 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://rv32-missing-syscalls.patch;patchdir=${RUSTSRC} \
             file://rv32-rustix-libc-backend.patch;patchdir=${RUSTSRC} \
             file://rv32-cargo-rustix-0.38.19-fix.patch;patchdir=${RUSTSRC} \
-            file://cargo-path.patch;patchdir=${RUSTSRC} \
             file://custom-target-cfg.patch;patchdir=${RUSTSRC} \
             file://rustc-bootstrap.patch;patchdir=${RUSTSRC} \
             file://target-build-value.patch;patchdir=${RUSTSRC} \
diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/rust_1.75.0.bb
index 76e1fe2..8ef838e 100644
--- a/recipes-devtools/rust/rust_1.75.0.bb
+++ b/recipes-devtools/rust/rust_1.75.0.bb
@@ -35,8 +35,6 @@ RUST_ALTERNATE_EXE_PATH_NATIVE = "${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-co
 # own vendoring.
 CARGO_DISABLE_BITBAKE_VENDORING = "1"
 
-# We can't use RUST_BUILD_SYS here because that may be "musl" if
-# TCLIBC="musl". Snapshots are always -unknown-linux-gnu
 setup_cargo_environment () {
     # The first step is to build bootstrap and some early stage tools,
     # these are build for the same target as the snapshot, e.g.
@@ -54,8 +52,8 @@ do_rust_setup_snapshot () {
 
     # Some versions of rust (e.g. 1.18.0) tries to find cargo in stage0/bin/cargo
     # and fail without it there.
-    mkdir -p ${RUSTSRC}/build/${BUILD_SYS}
-    ln -sf ${WORKDIR}/rust-snapshot/ ${RUSTSRC}/build/${BUILD_SYS}/stage0
+    mkdir -p ${RUSTSRC}/build/${RUST_BUILD_SYS}
+    ln -sf ${WORKDIR}/rust-snapshot/ ${RUSTSRC}/build/${RUST_BUILD_SYS}/stage0
 
     # Need to use uninative's loader if enabled/present since the library paths
     # are used internally by rust and result in symbol mismatches if we don't
-- 
2.46.0


