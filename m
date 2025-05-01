Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C024C3ABBA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.4659.1746132059602087971
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ALAt2BHf;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5b2472969so147313685a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132058; x=1746736858; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrdJax7GMZx6GB0aDsbYK8t0M1/Ttde2UdA1TZn0aKc=;
        b=ALAt2BHfTEv+xYWQYVf264P9sbILkLZ+oq3EP42neZHu3d3fkhKtbq8dv4xyYGf+hk
         Iixvx/HgUVZe1O7zlH41nus4t8P2QbNkTSoutid3ihwMyxnqXuV6M8mXMaQgemyUzcpi
         j6iFPCf355qUcKoCzTRfHoQIFjAzvKboXzeJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132058; x=1746736858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrdJax7GMZx6GB0aDsbYK8t0M1/Ttde2UdA1TZn0aKc=;
        b=KH0KF1yO0DB1JhdHgrx2j9HJoEyh4zTcMJuUxRcs9k3bn4eVmhxE35B60BM85ocrTh
         VsNTJr+78rlK2Mw8EYTCKTg84+BCIptpP+Ld77D0pdabpJiW9GSl6bNva3YNlSnCrgRf
         /ElaoqJbJUv3cffzsbDFF2tQQWhGh1XXFrJKDyosMIbdSjAXNHrTv1RKWQgnQvF5fpnU
         NrxVkUQtTXbXlQKAP0wdv0GeKHZ92JAe+L1WDHy8XJyWjClYxKoTdAgS7RigEIHy66hG
         4phjF4NNG+gStLzN+z8lDEnws+rCEeCxCqfZG7UzWCXIZOTAKPddCQImlmYmqpJOzE9X
         B3dA==
X-Gm-Message-State: AOJu0YzFmY7Z8kY8wi1c50xo2egJBU82sTO7OVhaGtFDLBNt1suDvy1z
	cEP4+EUJOyDf0HXjW4GvRaES5gKYHKCCQwXf0Ko9xFaqcQtbkJO1CuACrOSnbxabYI+FCX64Nuv
	0
X-Gm-Gg: ASbGnctxG8htwF3VzpgHhcdckzDgl8GKkF71POoH+OvuUXQR5ehj93PeokkIUY50wS/
	+kv/O23Hl/J3tLTjiktCsFoiP/cHc6J06XgPV4/175j6z8x6qGQp2cY78i1TcD2RpgqYOnvxJXI
	3SbIRrnzvXw+imgFvuXfulE/jlhqdJYhqFA2naKkvZvEjmiSJJchNqjof3vh0Ap1SESlNymDgNE
	ayulT2DYTNLNNKViBa4Ody2fVbBkHZIAb2KZ51vor4I5T2+6P8uXambIx9jgG8as07tnbeJ/Sqh
	PISkuHOExXIFhBb5i0AN0YUSWpQSbSRc/aNSgDmpPrKFHv4rUvTGczg4xa+VnDl+u9qHsE529mp
	LFswV6OT12Rj92FT4CMT7QypoXOw=
X-Google-Smtp-Source: AGHT+IE1VL+rSUvKiblYxxKmqAvPEzteu5F/d1gSGccxPNbRlpuvC620WyipSgdMGxdH8yyDUvpCsw==
X-Received: by 2002:a05:6214:124d:b0:6f2:b14e:46e6 with SMTP id 6a1803df08f44-6f51526d362mr11416026d6.17.1746132058274;
        Thu, 01 May 2025 13:40:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 24/38] rust: Fix build failure when multilibs are enabled
Date: Thu,  1 May 2025 16:40:00 -0400
Message-ID: <c57d00022e2abeeefcc518fe4808bf5739613659.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1450

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

When multilibs are enabled, building rust is failing because of the following commit
https://github.com/rust-lang/rust/commit/68034f837a39387e49fc7d7c5b088f5372a1127e
with stage1/rustc cannot able to find dependent *.so files. The issue is
been fixed inrust-master with the following commit by passing the necessary library
paths before executing stage1/rustc

Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/139d6ba054a1a4cc5fe64981ad46fd5547bd4916]

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ab29b970ba7e08eabca92018d103af5f249ed2c5)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../Zdual-proc-macros-additional-check.patch  | 31 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch

diff --git a/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch b/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
new file mode 100644
index 0000000..6bb1738
--- /dev/null
+++ b/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
@@ -0,0 +1,31 @@
+Fix bootstrap failure when multilibs are enabled.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/139d6ba054a1a4cc5fe64981ad46fd5547bd4916]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+---
+diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/core/builder/cargo.rs
+index 066e6bf53f..a2f6fac4b1 100644
+--- a/src/bootstrap/src/core/builder/cargo.rs
++++ b/src/bootstrap/src/core/builder/cargo.rs
+@@ -646,7 +646,10 @@ impl Builder<'_> {
+                 // Build proc macros both for the host and the target unless proc-macros are not
+                 // supported by the target.
+                 if target != compiler.host && cmd_kind != Kind::Check {
+-                    let error = command(self.rustc(compiler))
++                    let mut rustc_cmd = command(self.rustc(compiler));
++                    self.add_rustc_lib_path(compiler, &mut rustc_cmd);
++
++                    let error = rustc_cmd
+                         .arg("--target")
+                         .arg(target.rustc_target_arg())
+                         .arg("--print=file-names")
+@@ -654,6 +657,7 @@ impl Builder<'_> {
+                         .arg("-")
+                         .run_capture(self)
+                         .stderr();
++
+                     let not_supported = error
+                         .lines()
+                         .any(|line| line.contains("unsupported crate type `proc-macro`"));
+
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index b32f9ac..6c35805 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,6 +7,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
 	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
+	    file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "e23ec747a06ffd3e94155046f40b6664ac152c9ee3c2adfd90353a7ccff24226"
 
-- 
2.49.0


