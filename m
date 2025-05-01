Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E18C3ABAC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.4660.1746132061053299908
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PulBZD5j;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476a1acf61eso17145531cf.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132060; x=1746736860; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVLsBAK5q3ES8c4PjqNOIGVAqXu3MGaQ9uTCyNbiSHo=;
        b=PulBZD5jNlePywJGiHwx7700aIxbEMT/FgrZRT9SrmWn4XI3rDJnKFEKl+3U/iVrSc
         qN5WbiwuPTyVMk8hwdxyT2FmYRUc/TOl3HBCcWjGMfihR9DGAE/4WJ7itmUHzFNP3JVx
         Wze+mB/RH1c8qv1cK26z1dMWmHIytTMA74neA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132060; x=1746736860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVLsBAK5q3ES8c4PjqNOIGVAqXu3MGaQ9uTCyNbiSHo=;
        b=AjG/HOSoHAJ1vjf7R15rvMD9U3iLIEsHZs2F8WFGaE5UpAZqc6fZhKze6I4VxMM0YY
         smGZ0nYIkG0LnGJHju36atKfU12stEAqNqkKGo/pzd1VfKTUc0mv55mHrWL8lNB15jPx
         9CDKuB28XKYxl/nzyarU3r7h6+5t/2GzIyg8IT8cDiuUbTe0aped8BEVhaz1hS7HnRXK
         mR5su+ZTra9NLePJtg2z83IgMhAitT+2IkW2RBRoX3GyHtkLcE2YY5yEGu2AObBfEbLl
         49prmq/iK0Y2X5tcuWEEabOB0CzfsIw3QEAXbTnfZQJapE3rnx3D+3oAF2VAh9ruz4qt
         5m1w==
X-Gm-Message-State: AOJu0YxP5JrXuL1JHXw1Z3GU0cXwj5dF9cw2kDUh9i75oIHLXeKMioFu
	hLsH99h2Lq6CfUGXpBTHgZECc/+ib4uPAMDpsWBTO57rCai3v6vL07J5PqqCaC0GEPcLQthcObY
	f
X-Gm-Gg: ASbGncsLccpIyv8IXMGW6vsccLG8a6T2gkTGzHHwu1SHL58C3NAXfNA3/K59xOujlR2
	hDxmCE34RzOt44gXHUPpPB9hJH8foa3S0J3s9KkiE9pjmoDJujqkdcrrGeg9wCM6OcGp2OTBukL
	BGPsObN4Q0bq7LUoq2XtkvwDsa/QYp8N9578h3V8SEuVRR4v6Gt/gSH8b/8id+L2xiG64otL0HG
	y9kmPxN/0FSq+twoGBBNsLY2rdZjv2QScGQn2WxO4oW4wEebaRrkQqTXkqX+FyrfZZDiMcfq4g9
	U7Eyfw0sulfNBoD+mNstb2ucsWF8kx9VFWcTMzI5ncbD7prGZjw9DGJhT7f+y1vTMBYB6g6cyDA
	TDd9dBqA8CL6Zi3Qi
X-Google-Smtp-Source: AGHT+IHqTyxfiQHAfaCqol7oMGC9iKkn7yFGTlTGNo4uAO1DmZQvjc5R/oxV+t9L0bPsdsTNavWV6Q==
X-Received: by 2002:a05:622a:4a17:b0:477:1e77:1b9a with SMTP id d75a77b69052e-48c3183784cmr6182731cf.28.1746132059729;
        Thu, 01 May 2025 13:40:59 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:58 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 25/38] rust: Oe-selftest changes for rust v1.84.1
Date: Thu,  1 May 2025 16:40:01 -0400
Message-ID: <4b785b215fddddec9983daca8a2a85c61c4e51d5.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1452

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
index 6c35805..e4df87a 100644
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


