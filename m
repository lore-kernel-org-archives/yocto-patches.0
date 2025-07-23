Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E247C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:06:09 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.23590.1753297560403651067
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:06:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q6VQQJLo;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e29d5f7672so23348785a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297559; x=1753902359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNqxo28ILZ92eV6buGbDsyl3YtCsfnHxvrLra7lJNks=;
        b=Q6VQQJLo497MjNkuA8Aei0MmNtYXxWlu5H5vqoLiov4t59k4zQXaOUMRR3TJt5HrPU
         X5IkwcD9aO9ZFcQO0IhcMgR5ybjkYAWPyJfY+WMfzMiW2paYZn653LCj4k16y/LsYfQF
         vnvO3WE7xFQskCWuMZnE2UIy3/c8Df7gZ4Ros=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297559; x=1753902359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNqxo28ILZ92eV6buGbDsyl3YtCsfnHxvrLra7lJNks=;
        b=k6JMF2CYX3t++LpNt7d4xLClooFzPKGMu36pixbazD6ChN3ndDPSWGPQDH3ah56gS4
         j2wCxxj9KRMVotH3GFwOwcW4jLg0VQdcn32VfoTa4lURAyuVgWw6pYvU9Se1++FVSjro
         xceB5ZO7L8D4mdxDt1JusW6lmUcBlLOOBVZVbs4OvfEtk1vE/wOXNXV46VeGpZ431FIX
         5F0zrkaEw7chOO77wynDEBHxC3BEPMu2F2j4bC7WXlTXY3FvdXivOquoj1OyOBfzODPT
         bAetw6BOXAmcgUEakPSTYH+dlrTo60cLMYqF9aM/bl6tg/8U1JT5ckEu5jWq/j3j1BQF
         26XQ==
X-Gm-Message-State: AOJu0Yy9VQTs1QF4UFJUmHbdjryfAvJuwPVS1T6unMFTUHbQkG5/X0CV
	ug9qKJ9ANzyUUtlBmSlKg5r4oJbkc4xUlQ4IED4OjBQmXlPWP2J5qhbwR1I1yEwLmuvVuGl3L6j
	cIC4d
X-Gm-Gg: ASbGncv3hPDEt0q5wozGQ8GmzKwD5Wl+A4JrPA7un+DqIg1aRP8Ce33uFknNZMr6pm3
	OEmEgRWFmiSe1QFq/vtT6OIbDxsOA+2WRgvsNO34l0p1pZvyU5kXtW9YVGFdbgwJ/oidi8NKQ9n
	zshKaiOPYJuPpOZTpZBTdRWupnWA6cGPrjCE/R5TXUTLFFs7zBR2B4I/5esHh6D7jT7z5Jt8QZB
	WfHKS8MlsRCfexcn9jaOKHr3Z4fI7Ij6G7cwaJ+N++ks4QJoCb471cgK5kL22qEjSs0BQZQpx59
	Yx0WoFn2TfPdJGyUDUfwRpAFRvV0M+YpqP/WXL5FYMy8jmsYqtQzj/LlPZQ/CS0VgpHiqDyoCq2
	VBgw4LhBtyL/O6cbsB7e7qQw+yN8BoLZe0Ez7qnbNN4EufGhby7MiAMY3EiQ0pBJ38gdGMQ30+A
	==
X-Google-Smtp-Source: AGHT+IHWPe5Bpv6kkJ5HNuip2oALXck6i6vdzqmtm8J8A4/DPM0B97CS4kd5VAy6Tzm6LDq596L0ZQ==
X-Received: by 2002:a05:620a:5b:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7e62a18e848mr497642585a.58.1753297556355;
        Wed, 23 Jul 2025 12:05:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 11/13] rust: Drop obsolete rust-lld and extended tools dependencies
Date: Wed, 23 Jul 2025 15:05:30 -0400
Message-ID: <2b4e7856ccbf00377934fa9da4484c8147ceb4b4.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:06:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1852

From: Yash Shinde <Yash.Shinde@windriver.com>

Some dependencies introduced during the v1.86 upgrade
were needed only for rust-lld and certain LLVM extended tools,
not for the Rust compiler itself.

Since rust-lld and the extended tools are now disabled, these
dependencies have become obsolete. Additionally, related tasks
such as packaging zsh files and removing cargo binaries are no longer relevant.
They can be re-enabled later if needed.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 42141da566c9512b338900967e7e81e9e8b49150)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.86.0.bb | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.86.0.bb b/recipes-devtools/rust/rust_1.86.0.bb
index 6f6d7e5..8cfc2bd 100644
--- a/recipes-devtools/rust/rust_1.86.0.bb
+++ b/recipes-devtools/rust/rust_1.86.0.bb
@@ -7,13 +7,13 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=11a3899825f4376896e438c8c753f8dc"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "rust-llvm pkgconfig-native openssl ninja-native"
+DEPENDS += "rust-llvm"
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
 DEPENDS:append:class-target = " cargo-native rust-native"
 DEPENDS:append:class-nativesdk = " cargo-native rust-native"
 
-RDEPENDS:${PN}:append:class-target = " gcc g++ binutils bash"
+RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
 
 # Otherwise we'll depend on what we provide
 INHIBIT_DEFAULT_RUST_DEPS:class-native = "1"
@@ -237,11 +237,10 @@ do_test_compile () {
 
 ALLOW_EMPTY:${PN} = "1"
 
-PACKAGES =+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt ${PN}-zsh-completion"
+PACKAGES =+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt"
 FILES:${PN}-rustdoc = "${bindir}/rustdoc"
 FILES:${PN}-tools-clippy = "${bindir}/cargo-clippy ${bindir}/clippy-driver"
 FILES:${PN}-tools-rustfmt = "${bindir}/rustfmt"
-FILES:${PN}-zsh-completion = "${datadir}/zsh"
 
 RDEPENDS:${PN}-rustdoc = "${PN}"
 RDEPENDS:${PN}-tools-clippy = "${PN}"
@@ -258,10 +257,6 @@ rust_do_install() {
     rust_runx install
 }
 
-rust_do_install:append:class-native () {
-    rm -f ${D}${bindir}/cargo
-}
-
 rust_do_install:class-nativesdk() {
     export PSEUDO_UNLOAD=1
     rust_runx install
-- 
2.50.0


