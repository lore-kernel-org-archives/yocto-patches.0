Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A339C55177
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4589.1785497608099303763
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SY+vL3x9;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-934974844ffso21611685a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497607; x=1786102407; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZhiFVn11yNCWGSECAa8vnoMxEySuTmFE52xurNoHYbg=;
        b=SY+vL3x9w1YVXgOw41v7LHo2BGD5LuWdDjeuuTjkndNk4jRIoCreb52rk8egoG/qKk
         5yLwTPqIWx61ztqGYBJGbxIqO1cuIUOZOs0ExSkAhMHDVyOlR5yop2gCXTad7osryZDS
         IBLC8AMtibpQlp9VMJzU5X6ejBOJWx67ODnag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497607; x=1786102407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZhiFVn11yNCWGSECAa8vnoMxEySuTmFE52xurNoHYbg=;
        b=kJd8lNyr/Hfh/OcLLILJiupQ1wJw/E2LRssrIxxE77G+YuX5+xr4TnmJYEL71wrmyf
         1eH3stNJowd+rGQ7fqUdIS0YV14mnCGK1V9NaWR9s98pZUXmMI7IvAl2403tdeM7Sbs5
         czNJhf0iyfAzG7GHdvWIR9ejwsrw3yFobEJbM0munxXa/UUuVLe+vHBfEMujCODLWoV9
         F5JMJwtANCXfPfpqU9PvNsxSBzFnx3KmrRTXaqP1zmbGyo2LMj+6ApcZ2v3QKRi/BYhy
         94nP2EzZ9jpwJ/HHUzBfQPk6ttCdTZ/p4RS6GaFw9lpeKqh9O6cup4elnK+Cbw1tDPt0
         c0hQ==
X-Gm-Message-State: AOJu0Yy/r4WgiELLf1+Ntzk5hZB0EChdG0Bu1VxBrzxXJxuu1HMD3Ex+
	LX/kbLEXHOqR/5lpj8OmUX7QNvVoItWc1YT5JWpQ6rvqZScvzf2OPETpn2mC26VI9g5l4XasCdz
	D1/Yf
X-Gm-Gg: AR+sD10W8PobAfi3FuhGPr/7DwTmlZsOQVmRx9cxWMhEUdy6/3XDpVyl/dcO6BTUdWO
	HwGi30FwYYhIUI4ecShby9lyXkMUWjgeCekIp6tHMEJ3c9hzlPmDJD8rWZj1mTAmfWXIZcCnfW/
	LKk3CORUUhUf1sm9H8EwAo6/Jxbb7IXBlV5rQLcCMAr4bmOkTqchS4YDUTeAkgGyHi9h/N8RqTE
	dZ7zLncTv0ivrIY6Abyv8jp68AKVZJJdsONAoydibIb2KpzOdv13jQ8obeTVm/9bnkzZRXEgRNX
	v+ON8y8oOkTCcjju3uBydjkcNAzddErryZL2UG0sut6bTCq1EhPQD122CZH4TIdbw1wBLx6kLsS
	qyNCkkLiHSRP/90c/+0WybUx+ogd61dWEeZ+8dgQQyjKglkjuCPDZ9FVe4pA2UoimXKfG31MOGA
	GFQGlVtPVfwijTJdzLrP85xGv/PvdErWeEN6IeDDUwac/qoGEuTgjnSU8S9n8VC35lWxJWXSG6+
	XK+exuEMs42b3CSdcTvRX7K0E9sIUNSQsIhCgh6my3ZwDgdQcmW3jwNbLud8TFW2eUoQ/kwXsRj
	qA6alRIsY/1pk+fh9X1BbgCzTQ==
X-Received: by 2002:a05:620a:4041:b0:92e:57ae:3a53 with SMTP id af79cd13be357-934982cb028mr152956885a.9.1785497606812;
        Fri, 31 Jul 2026 04:33:26 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:26 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 12/35] rust: Fix build with llvm-22
Date: Fri, 31 Jul 2026 07:32:42 -0400
Message-ID: <74815a8c24f455ebdd1276b2f10d05358cafb406.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4588

From: Khem Raj <khem.raj@oss.qualcomm.com>

Backport patch to update data layout for amdgpu

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
(adapted from oe-core commit 2f92d8c9d7cb23d990e0fc286451600823cf21b4)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-Update-amdgpu-data-layout.patch      | 44 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch

diff --git a/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch b/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
new file mode 100644
index 0000000..1c09cd8
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
@@ -0,0 +1,44 @@
+From bf3ac98d6930ba4e258cf33240c2fe7c99d19eae Mon Sep 17 00:00:00 2001
+From: Nikita Popov <npopov@redhat.com>
+Date: Tue, 6 Jan 2026 11:51:33 +0100
+Subject: [PATCH] Update amdgpu data layout
+
+This changed in:
+https://github.com/llvm/llvm-project/commit/853760bca6aa7a960b154cef8c61f87271870b8a
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/bf3ac98d6930ba4e258cf33240c2fe7c99d19eae]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ compiler/rustc_codegen_llvm/src/context.rs                  | 5 +++++
+ compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs | 2 +-
+ 2 files changed, 6 insertions(+), 1 deletion(-)
+
+diff --git a/compiler/rustc_codegen_llvm/src/context.rs b/compiler/rustc_codegen_llvm/src/context.rs
+index 4b2544b7efd..4328b15c73f 100644
+--- a/compiler/rustc_codegen_llvm/src/context.rs
++++ b/compiler/rustc_codegen_llvm/src/context.rs
+@@ -215,6 +215,11 @@ pub(crate) unsafe fn create_module<'ll>(
+             // LLVM 22 updated the ABI alignment for double on AIX: https://github.com/llvm/llvm-project/pull/144673
+             target_data_layout = target_data_layout.replace("-f64:32:64", "");
+         }
++        if sess.target.arch == Arch::AmdGpu {
++            // LLVM 22 specified ELF mangling in the amdgpu data layout:
++            // https://github.com/llvm/llvm-project/pull/163011
++            target_data_layout = target_data_layout.replace("-m:e", "");
++        }
+     }
+
+     // Ensure the data-layout values hardcoded remain the defaults.
+diff --git a/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs b/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
+index 828d853ac65..d6a2cfc2aab 100644
+--- a/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
++++ b/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
+@@ -5,7 +5,7 @@
+ pub(crate) fn target() -> Target {
+     Target {
+         arch: Arch::AmdGpu,
+-        data_layout: "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9".into(),
++        data_layout: "e-m:e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9".into(),
+         llvm_target: "amdgcn-amd-amdhsa".into(),
+         metadata: TargetMetadata {
+             description: Some("AMD GPU".into()),
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index b9077c3..c3e2ca7 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,6 +8,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
             file://0001-Fix-flaky-assertions-in-oneshot-tests.patch;patchdir=${RUSTSRC} \
+            file://0001-Update-amdgpu-data-layout.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600"
 
-- 
2.55.0


