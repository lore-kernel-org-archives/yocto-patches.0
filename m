Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A49CA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:30:01 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.56803.1755451792456659751
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q5v/tb0T;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87067b15aso433520185a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451791; x=1756056591; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4+3WEYLxhK0cVqJqCnKTh0R6h6Wgq2BPXvzltUYDKo=;
        b=Q5v/tb0Tmry2TTYt36xd0io5rAaDfHZuept1k4nRX5DFJuaB8VjY16r1H5lOQye6Fe
         XJsqGM08JoVOw/MGG3RAAVAd5mnAANuCUoWAMcU6lH2+z0GvEc+w1OUxVDvpeQtvgfH2
         krfnUvUNPUNp9gv8Hixvzej67EDnO8hkUERf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451791; x=1756056591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4+3WEYLxhK0cVqJqCnKTh0R6h6Wgq2BPXvzltUYDKo=;
        b=FMiDxtOFYX3B97372Bdr6PiHWi7fXJ04sasGkm3FXJbS0582jUv+Cj3BbffVZMoKO9
         2mXZ3dPClnp7ezre36PHqmqiMpSuds6iAP57hXnlEnTgGuBfaRTycUCB/OobjMKSRVH3
         KdvDwW9/7WGOipClp5sJJytQRsZG1RsffgKootVdT5LMivJcDzdV8Rg4d8OOmAsXSwWE
         nXEgEN5FHM9M5+LdBhuIcfoWgXTrkFQWwvyfEJp9I9pXBic27tjMqgWlLkkAibO0VxtV
         +TMMdNIu4jfo8H3nVA2d40JNdqn/HfJNSi+f2ixCetlyDJ8TzsEoFVdCd5q5dgCUDz3X
         /kFw==
X-Gm-Message-State: AOJu0Yz0vDrnko7KyBsGp9O3cCq45ZQ8FP/B4X3KGcTsD3tQ3M9RUkak
	aabXWDwSCrn6w4TxVLYJ0rM8jh12IX5rafP/ypIouRkc8tqXhjZ11ZleX23Nk8DIOUq8AqAXFWt
	l7IdR
X-Gm-Gg: ASbGncsMGv/7VTvFKBQ9QCj702K8O75upG7KzuIfUY+qbc4nVjfI53+qU/jET/v3Y89
	ZhEeTQBGLENd6+/Nqw6C7Xh0lLgF978dl/QcIEPnMAD83XCUx043Bku4UpjkwXd0B2O1ZSUSUH2
	z2IQXoI0dObINXk48dm1cJc5weCMiF/CBnYYRRNuwJ/LUqoCOainnfUiSI3bmWTh3PkSogRkEcQ
	tBEitV56WQP2d5ht61py0O7krDeBngZtu0ITRfOCvgsdBsn1RL0gj69g6ndzyuBMiJjw2WitNgQ
	IbdtyvdkWmu5ZHrhZfGtDm/x8wbABD1nTtbRvQm7RfLAHHhMYNuA4KCBsmbMlpKkfjnplVCfQO6
	G/A/cod6DVUD5LuDOi2PIYBmURlvRqgJuZaANYlHesSTelipk20pB6n8EoDi0j9UC2Cuq4vesqw
	==
X-Google-Smtp-Source: AGHT+IGNZ5qHNJWaIC91lYF7kJJfoknmqrFQeRT54qos83ubk08pz9Keoo3GsJ+l5BO8eAivoPG0tA==
X-Received: by 2002:a05:620a:3912:b0:7e6:8f41:2047 with SMTP id af79cd13be357-7e87df501c9mr1307183485a.6.1755451791065;
        Sun, 17 Aug 2025 10:29:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 7/7] rust: backport cstring-merging test fix for PowerPC targets
Date: Sun, 17 Aug 2025 13:29:31 -0400
Message-ID: <cc35d7af3a34676e898980e1e1abbb29f5fe2860.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:30:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2011

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

The Rust cstring-merging assembly test was failing on PowerPC targets due to
LLVM's GlobalMerge optimization pass merging all global string constants into
a single merged global. This caused the test's CHECK directives to fail as
they expected separate .Lanon labels for each string literal ("foo", "bar",
"baz").

The test verifies that C-style string literals are correctly placed in
mergeable read-only sections (.rodata.str1.1) with proper section flags
(aMS - Allocatable, Merge, Strings) for linker optimization.

This backports the upstream fix that disables the GlobalMerge pass
(-Cllvm-args=-enable-global-merge=0) specifically for this test, allowing
it to verify the expected assembly structure without interference from
the optimization.

Fixes test failure:
- tests/assembly/cstring-merging.rs on powerpc-poky-linux-gnu

Backport of https://github.com/rust-lang/rust/commit/2d51acd2fbcbadb6f30709c5dd305494d413d388

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Tested-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2435b16b050ebdca0f70fe9ed1eebfdd3bacf19d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../backport-fix-test-string-merging.patch    | 27 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch

diff --git a/recipes-devtools/rust/files/backport-fix-test-string-merging.patch b/recipes-devtools/rust/files/backport-fix-test-string-merging.patch
new file mode 100644
index 0000000..1e72c10
--- /dev/null
+++ b/recipes-devtools/rust/files/backport-fix-test-string-merging.patch
@@ -0,0 +1,27 @@
+From 2d51acd2fbcbadb6f30709c5dd305494d413d388 Mon Sep 17 00:00:00 2001
+From: Jens Reidel <adrian@travitia.xyz>
+Date: Fri, 18 Jul 2025 19:44:20 +0200
+Subject: [PATCH] tests: assembly: cstring-merging: Disable GlobalMerge pass
+
+The test relies on LLVM not merging all the globals into one and would
+currently otherwise fail on powerpc64le.
+
+Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/2d51acd2fbcbadb6f30709c5dd305494d413d388]
+---
+ tests/assembly/cstring-merging.rs | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/tests/assembly/cstring-merging.rs b/tests/assembly/cstring-merging.rs
+index f7d0775f7affd..03688e0068b79 100644
+--- a/tests/assembly/cstring-merging.rs
++++ b/tests/assembly/cstring-merging.rs
+@@ -2,7 +2,7 @@
+ // other architectures (including ARM and x86-64) use the prefix `.Lanon.`
+ //@ only-linux
+ //@ assembly-output: emit-asm
+-//@ compile-flags: --crate-type=lib -Copt-level=3
++//@ compile-flags: --crate-type=lib -Copt-level=3 -Cllvm-args=-enable-global-merge=0
+ //@ edition: 2024
+ 
+ use std::ffi::CStr;
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index c664baa..99a37eb 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,6 +11,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Disable-libunwind-cross-architecture-unwinding.patch;patchdir=${RUSTSRC} \
             file://triagebot.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
+            file://backport-fix-test-string-merging.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "0c1dcbb4f762513d021e1a282c0ac58c0a423642b3a6bf581cafb5414df4193e"
 
-- 
2.50.1


