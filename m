Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D12C54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4479.1785497623412235032
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GvseLZdA;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930f618435cso48334885a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497622; x=1786102422; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9KK2BVEDNbMORJKrds0dbs09lckmkTosfBVkf1B0i4s=;
        b=GvseLZdA18jbpC6uqeCTR1S+KOwJuRJoJNzqd9gObYERk+gJ8nEjvWg4wo3v0Xafgh
         atrglNlPhKfmyujiFc3bS+tC8s+mR2zdWDeFINU0aiZU2+h9NE8O9kvh6KzhIOO8sv1J
         q+9rqgCN9Ti5IFN5W01xUeC9k09Dw/kZwy3s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497622; x=1786102422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9KK2BVEDNbMORJKrds0dbs09lckmkTosfBVkf1B0i4s=;
        b=FQkUOk+npBBAKeI3tCpfTqD8Wt060uophLx51CEudfHDrP/m7MpBZK4daGyOyYEGTN
         PQFpCAFK5A/8oTcpR2anmZswuhHcAkfRWrOQyYf90/R6/GGvITOoZN19DtrvOdFSTxgs
         hh80grdfDJ0eGMd8jZa4Hh9S84FnlwU48NXSw5V+Ol6IDsa5pbB995rkqj9bH/nbAMRN
         9RnBPA07KM0PaZeeYJ0mMEPiFIJ/gmh+CBbanmqMaaQxtBCsJyU3qBwJidWEepVF57/f
         jJhiB56DV6jE68/mjKf8YdUPi9TthvmOk0vF9YAHBdc6TEYLVE3stFmwMOXFnUosKKis
         MQ9Q==
X-Gm-Message-State: AOJu0YyfIQWeAwjRUWwC6+n87s7LMPzwnz69M4T+DOJg9NlXjXrN5UKl
	3HoxK/RNsrIne3Ci76W2lf/1xzwKlogAV2krCTbAXeNpYKbbdP152Pl9r2jaICfya2330fILZOW
	YIft9
X-Gm-Gg: AR+sD11g5Z116ILmYbIJi42Sv2PmVfPxdvMtnoduAAzIjwsBISnoMCyiLPg8h9B6vWb
	F3bM/m0jiVOijadwvzjCUfccNnqZ0B4H+q8pa60fYCUxGzvML7x5hmUnWp6rWYaHqWaTvL1TxjN
	u8Umo1vS75rNYq450PMypoq4KE1ThzCZi7jwnxiFYRzAqIqsydCqjEITDyTjd/VJYaJuq4RXFO8
	ydw4qpc4MdumWl6/oQ6BbELARXTZVE0gPRbsrDebOJ9TCR4ePjuJ2QO38nd6UeTVnBerVOdg+yM
	lJgsNEefIWG7E45A9M4peBkknmMOhToeWMEegI9qaxoavgXNKYB/RwphbNktzvGuZ7RJfHxJh3d
	v43xqoX8uf3s3rUULzgcuSRv3WZjoRIiunpsyrA3DLRzgI1CeO/1aTd7LUM9vK5Ljq23gQxnmRS
	9ya4pk4Erjoh3LMZR8vIyFndyQa0cIKRfYXZcwa+LuALc44AvzhKQ87vuzHI4TRgcfw9rwDRzJw
	kjPbakFrL5ZorwVYA9Q5346z1G+TBrNBvGN2DB0FJTJwK2dv/1OzATtqImMd8JcQ1UuuCWtsZlt
	ydFk0uCv3hHrFs2iQTKau0Sgtg==
X-Received: by 2002:a05:620a:a188:10b0:92e:e125:55bb with SMTP id af79cd13be357-93496599d8bmr167319285a.4.1785497622084;
        Fri, 31 Jul 2026 04:33:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 30/35] rust: backport explicit-tail-calls test skips for unsupported LLVM targets
Date: Fri, 31 Jul 2026 07:33:00 -0400
Message-ID: <972e7f962d7776661005c53a94d8147af268f167.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4606

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

oe-selftest for rust fails on powerpc and other architectures where LLVM
does not fully support musttail lowering, causing:

  LLVM ERROR: failed to perform tail call elimination on musttail marked calls

Add an upstream backport patch that marks the affected explicit-tail-calls
tests as ignored on unsupported LLVM targets.

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 333595718daad21e0366cbdd3550c9a984436bb3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...lls-ignore-tests-on-unsupported-llvm.patch | 96 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch

diff --git a/recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch b/recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
new file mode 100644
index 0000000..a6b73cf
--- /dev/null
+++ b/recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
@@ -0,0 +1,96 @@
+Backport commits that disable failing tests on unsupported LLVM targets.
+
+Fixes LLVM ERROR: failed to perform tail call elimination on musttail marked calls.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/ded0aaba6ce257adf0b7e1fb6b702cad12328faf]
+
+Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
+
+---
+ src/tools/compiletest/src/directives/directive_names.rs |  3 ++
+ tests/ui/explicit-tail-calls/become-indirect-return.rs  | 21 +++++++++++++++++
+ tests/ui/explicit-tail-calls/indirect.rs               | 19 ++++++++++++++++
+ 3 files changed, 43 insertions(+)
+diff --git a/src/tools/compiletest/src/directives/directive_names.rs b/src/tools/compiletest/src/directives/directive_names.rs
+index 1234567..abcdefg 100644
+--- a/src/tools/compiletest/src/directives/directive_names.rs
++++ b/src/tools/compiletest/src/directives/directive_names.rs
+@@ -67,6 +67,7 @@ pub(crate) const KNOWN_DIRECTIVE_NAMES: &[&str] = &[
+     "ignore-coverage-map",
+     "ignore-coverage-run",
+     "ignore-cross-compile",
++    "ignore-csky",
+     "ignore-eabi",
+     "ignore-elf",
+     "ignore-emscripten",
+@@ -91,6 +92,8 @@ pub(crate) const KNOWN_DIRECTIVE_NAMES: &[&str] = &[
+     "ignore-loongarch64",
+     "ignore-macabi",
+     "ignore-macos",
++    "ignore-mips",
++    "ignore-mips64",
+     "ignore-msp430",
+     "ignore-msvc",
+     "ignore-musl",
+diff --git a/tests/ui/explicit-tail-calls/become-indirect-return.rs b/tests/ui/explicit-tail-calls/become-indirect-return.rs
+index 1234567..abcdefg 100644
+--- a/tests/ui/explicit-tail-calls/become-indirect-return.rs
++++ b/tests/ui/explicit-tail-calls/become-indirect-return.rs
+@@ -2,6 +2,27 @@
+ //@ ignore-backends: gcc
+ //@ ignore-wasm 'tail-call' feature not enabled in target wasm32-wasip1
+ //@ ignore-cross-compile
++//
++// LLVM musttail support is incomplete for these targets.
++// See https://github.com/rust-lang/rust/issues/148748 for the target test matrix.
++// See https://github.com/llvm/llvm-project/issues/63214 for AIX and PowerPC.
++// See https://github.com/llvm/llvm-project/issues/57795 for MIPS and MIPS64.
++//@ ignore-aix
++//@ ignore-csky
++//@ ignore-mips
++//@ ignore-mips64
++//@ ignore-powerpc
++//@ ignore-powerpc64
++//
++// LLVM musttail support is lacking for sret lowering on these targets.
++// Returning `[u8; 24]` uses sret lowering here.
++// See https://github.com/llvm/llvm-project/issues/157814 for RISC-V.
++// See https://github.com/llvm/llvm-project/issues/168152 for LoongArch.
++// RISC-V fix: https://github.com/llvm/llvm-project/pull/185094, should be in LLVM 23.
++// LoongArch will likely be fixed with similar changes.
++//@ ignore-riscv64
++//@ ignore-loongarch32
++//@ ignore-loongarch64
+ #![expect(incomplete_features)]
+ #![feature(explicit_tail_calls)]
+ 
+diff --git a/tests/ui/explicit-tail-calls/indirect.rs b/tests/ui/explicit-tail-calls/indirect.rs
+index 1234567..abcdefg 100644
+--- a/tests/ui/explicit-tail-calls/indirect.rs
++++ b/tests/ui/explicit-tail-calls/indirect.rs
+@@ -2,7 +2,26 @@
+ //@ ignore-backends: gcc
+ //
+ //@ ignore-wasm
++//
++// LLVM musttail support is incomplete for these targets.
++// See https://github.com/rust-lang/rust/issues/148748 for the target test matrix.
++// See https://github.com/llvm/llvm-project/issues/63214 for AIX and PowerPC.
++// See https://github.com/llvm/llvm-project/issues/57795 for MIPS and MIPS64.
++//@ ignore-aix
++//@ ignore-csky
++//@ ignore-mips
++//@ ignore-mips64
++//@ ignore-powerpc
++//@ ignore-powerpc64
++//
++// LLVM musttail support is lacking for indirect arguments that do not fit in registers.
++// See https://github.com/llvm/llvm-project/issues/157814 for RISC-V.
++// See https://github.com/llvm/llvm-project/issues/168152 for LoongArch.
++// RISC-V fix: https://github.com/llvm/llvm-project/pull/185094, should be in LLVM 23.
++// LoongArch will likely be fixed with similar changes.
+ //@ ignore-riscv64
++//@ ignore-loongarch32
++//@ ignore-loongarch64
+ #![feature(explicit_tail_calls)]
+ #![expect(incomplete_features)]
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index bb41dda..3aa3fe6 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,6 +8,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0002-Fix-rust-build-failure-with-unstable-options.patch;patchdir=${RUSTSRC} \
             file://0003-explicit-tail-calls-disable-two-tests.patch;patchdir=${RUSTSRC} \
+            file://0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "b99ce16cdf0ecfc761b585ac84d131b46733465a02f8ecd0ff2de9713c62ee09"
 
-- 
2.55.0


