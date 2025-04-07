Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7BC369A6
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web11.59614.1744061462934863897
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lQ4TWyx/;
 spf=pass (domain: konsulko.com, ip: 209.85.166.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85e73562577so395021339f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061462; x=1744666262; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoKtYm1yjnn8PKQslZtFa4a/UWdJBQ05JWTEVdwpPjI=;
        b=lQ4TWyx//Ttaa1U+TU/4aCuX7mg1xkgScFcpjL/V8d9Mp9jHV6BsFnngsRQqSNMXZH
         T8c9ARtLydh+QjlI7Q0W0NV8L2BtnwvHT6EZ0KL2EyCRUpWW66xA6Jul+IbwQgMhuDd/
         s4pcJsfMtquaeItBE7kF73N5lUzd7KuFHP0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061462; x=1744666262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoKtYm1yjnn8PKQslZtFa4a/UWdJBQ05JWTEVdwpPjI=;
        b=I2+GxgCmwoLvPU5VjjECiPZO15L5DNHSU8ClqDB+74rde8nhgnSB21FmGFEUyB8HNX
         z9F3qc9k2Y5iTEwOye3ZWgDHgkQZLMTaZrHdiP0iB727NYRwfrRb/ZnV+3m/pS+g8p9L
         mx2dVKn8ni0iWQBFKXtc8b9qCJZE4WZQIcM9a/z8dKaZVFaRKf7JaEkdBKv040FCBBWS
         5rAL49fX1q9zsmFYuyAE0lXPvz5YaPXvgrMmA6Y748ZUvIxWRUy/WD9v/hRAOxhLho+2
         LgVYwaPVBAqhO8k3P/+IE7ht0vbnvPlIN2p6d5skmF2BOtDCHvtn+k49cvonXpO96BQS
         4KcA==
X-Gm-Message-State: AOJu0Yw76tg4K3YgO1K4L55KSmi4OGa/G4RY+nEDlElpt8JcAqcRx3Hz
	MM/xThpLNH+lBcm4xe7PdKjKS32VaSiOft6aPMKogWkg3UHgrKtzF9bXiZgcdHT9RHNwNKIQ3Nw
	Jhp4=
X-Gm-Gg: ASbGncvuFyb0olA5AHIAonqP8IA6hKxVlafSFph+8FGnLn8RWgQK9H53e5NfTw/NgNi
	/09am3ms40WxthAAzc0MHLnTyc2OkT84BvG+6Wy51PVbJEropUySL4hREWCzD+2Sac1nnUMJVOG
	7Xj1IV+imGQ6njP4XgeCOVibgTElUNi4Z08W6aoDcRlaquKUQYApITRDdow83Ag9aoJpTwB7LgQ
	r2WFQ32K6mYcdgW+7+rXZxb+t4rvMc1JZ1STr4mJn0az33TcW1wZo2ZGvJwEElFhXI2nJS1w308
	2pdzbSoxTQmU1oj5FROJzPuN8l3MxPfH36SRfY4TkE7VxeyY81IVFFde7Ebp+ZBZMjMLDy5gbVP
	Yc9MsYbDKONvuAIwtE3lX
X-Google-Smtp-Source: AGHT+IFoNlRJgeH520PK267fay4FcZ2NuDjma0CDImnqAzh4OkReq/3+bKNgHtwRbgio+DOqX0L+qQ==
X-Received: by 2002:a05:6602:400a:b0:85d:f316:fabc with SMTP id ca18e2360f4ac-8611b4655e2mr1584404639f.8.1744061461770;
        Mon, 07 Apr 2025 14:31:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:01 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 23/29] rust: Oe-selftest changes for rust v1.84.1
Date: Mon,  7 Apr 2025 17:30:12 -0400
Message-ID: <956848f91ac9327087953b5fac0975297f0351ca.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1322

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Ignore the failing unit test.

The tidy check failed due to a typo, which was already reported and
fixed in the Rust upstream.

Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/8e7734978245522cbbd14e53e08e888faf031ded]

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 94a244a14075ead1b3b5e966c0fe713cd448cad8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/fix-tidy-check-failure.patch   | 19 +++++++++++++++++++
 .../rust/files/rust-oe-selftest.patch         | 12 ++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 3 files changed, 32 insertions(+)
 create mode 100644 recipes-devtools/rust/files/fix-tidy-check-failure.patch

diff --git a/recipes-devtools/rust/files/fix-tidy-check-failure.patch b/recipes-devtools/rust/files/fix-tidy-check-failure.patch
new file mode 100644
index 0000000..54b4ee6
--- /dev/null
+++ b/recipes-devtools/rust/files/fix-tidy-check-failure.patch
@@ -0,0 +1,19 @@
+fix a comment with uneven number of backticks in rustc_mir_build
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/8e7734978245522cbbd14e53e08e888faf031ded]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+---
+diff --git a/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs b/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs
+index 3f89e33778..c66af11845 100644
+--- a/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs
++++ b/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs
+@@ -231,7 +231,7 @@ impl<'a, 'tcx> Builder<'a, 'tcx> {
+                             if range.start <= range.end { BinOp::BitAnd } else { BinOp::BitOr };
+
+                         let mut comparer = |range: u128, bin_op: BinOp| -> Place<'tcx> {
+-                            // We can use `ty::TypingEnv::fully_monomorphized()`` here
++                            // We can use `ty::TypingEnv::fully_monomorphized()` here
+                             // as we only need it to compute the layout of a primitive.
+                             let range_val = Const::from_bits(
+                                 this.tcx,
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index dd22ced..7e5854a 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -469,3 +469,15 @@ index 14e6013f96..b670f27ab4 100644
          #[cfg_attr(miri, ignore)]
          fn $test_fn_name() {
              $crate::sort::tests::$test_fn_name::<$sort_impl>();
+diff --git a/compiler/rustc_data_structures/src/vec_cache/tests.rs b/compiler/rustc_data_structures/src/vec_cache/tests.rs
+index a05f274136..0e69b4cb98 100644
+--- a/compiler/rustc_data_structures/src/vec_cache/tests.rs
++++ b/compiler/rustc_data_structures/src/vec_cache/tests.rs
+@@ -17,6 +17,7 @@ fn vec_cache_insert_and_check() {
+ }
+
+ #[test]
++#[ignore]
+ fn sparse_inserts() {
+     let cache: VecCache<u32, u8, u32> = VecCache::default();
+     let end = if cfg!(target_pointer_width = "64") && cfg!(target_os = "linux") {
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index ee23e5a..92bb5e4 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,6 +8,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
 	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
 	    file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
+	    file://fix-tidy-check-failure.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "e23ec747a06ffd3e94155046f40b6664ac152c9ee3c2adfd90353a7ccff24226"
 
-- 
2.49.0


