Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDBCA0EDC
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:32:22 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.56862.1755451931834381579
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:32:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q7Y7CWtw;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e86faa158fso425195685a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451931; x=1756056731; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HycNToIvgINImms/KabDbMoqNDZFNIWN001OycVhofk=;
        b=Q7Y7CWtwQA5lRRb2swRhXhAwojll1IJncfX8yoBN1b6z3l7Lp0c4PxQtgoh4sN8Ay8
         ebRpQ34+t20KAH/NIW3NSWpAqsKKrfdeEs7Jllp5Wt1Qss2CJ3gWDqmRTv1m5PfehFgX
         zhlAYzAEwXFe2FJDesEkzFQ/ZKsjdO3i51Gj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451931; x=1756056731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HycNToIvgINImms/KabDbMoqNDZFNIWN001OycVhofk=;
        b=bsC6GgqmXZkWRemdC3VSaOwphOrdEPkmU30moAPPx7YLX94JgqImY0kdlh1J0ob2Hc
         g5kZ1qcBaNOh+G+6NQHgHf7hawaAfcEjJwwJ7fYb7+aL8bUxTDxUccDVhy9uPYz/uwsC
         t9J1//u7Vw8/4yXFuMgW734QOLY4BZx9N6vd/LbdXvSwIikNgKBcU/d3VO9btcS2ssju
         L7bXwAu3MuNX6nbQuRTuztNq+S3PYjIITU12FUp7XajwxWYOBXePeNoJBXL7TZT4YI0U
         qH+7iTASeWI7sqGHqc0q+OQRD930s2rJXZLx4Gmd4pxwO7TbGbwgec1VRUJRpvgldkdt
         1P6w==
X-Gm-Message-State: AOJu0Yx4h3S0+74WJg+nx1/F/DyFvxbsnZMBrhU9JVVcxytJV1kpZIAZ
	Bll290Opac3wypDqLGV3TnD7BPw6sPHxX7BjHsMVeOu8O4OXo7xzEkaF7Kb9V2hg9tssxCg5nJe
	2Gxrh
X-Gm-Gg: ASbGncu/yVRFn204pkPVTVW5q3c/sMS/v7CNAghp3QjngxkueItRnhc1/+0/N4pWSx+
	u+u/G7KhgvGKDZY50s5A96g6MkxjLla/ykgehBmggQZjEFUU0uBD1tK1NIHgEV/ttTe627J8bpE
	HpycOMG9MyJWdeaPrE5qUUqZp1AQftyjmH7xYvTApMAzc/h8ulYhLotBg32EwfhYQTH7OVP6TjA
	SH3y+i3rI9ciVL0KcQeKk01Xic0I1ZQ1zeftGY+KOVoP3MkA7FhXYOJkgosOP2Yxf2iopIcRH2O
	ZJ+YvgI1SL/2mH44AgFovLHKATDuz9Kragz4xi+MjQNdpwycGWYsPhL53fgAW8q9qWkRKtwvXg7
	+l7SGJ/ngwmh6E0sYb4EWTFH1I1NFtxOvfEPfvofyB9d3fbAoc/008dFT3FNokDjhY78JP/F0P/
	KsyC9Hb/pC
X-Google-Smtp-Source: AGHT+IGaKfMnRpt22uROGnrvRDFUynkRfJiOTuVAdnaQYhNbuCHy0qWHCUL2hhmbhfqZ6jb6+kW4eA==
X-Received: by 2002:a05:620a:4728:b0:7e6:911e:89cb with SMTP id af79cd13be357-7e87dc83650mr1271298685a.28.1755451930528;
        Sun, 17 Aug 2025 10:32:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm450093185a.36.2025.08.17.10.32.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:32:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 8/8] rust: backport cstring-merging test fix for PowerPC targets
Date: Sun, 17 Aug 2025 13:31:57 -0400
Message-ID: <96deb45139df027473faf0938fe006d33c45c375.1755451833.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451833.git.scott.murray@konsulko.com>
References: <cover.1755451833.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:32:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2020

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
index 6174a3a..73aa14b 100644
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


