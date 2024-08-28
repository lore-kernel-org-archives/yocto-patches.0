Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C500C71134
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:06 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web10.5968.1724875798495946780
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uL95kwZ/;
 spf=pass (domain: konsulko.com, ip: 209.85.166.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-829e8718502so137511339f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875797; x=1725480597; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ1BOrVPCxbcofBdDQCr1/eCB8x16Q1WdHxzd2phCFs=;
        b=uL95kwZ/MItX65CD6GU9ILElZSdgkMwKuVdV1/P8eIljtp/3NqtZ/XblEUmKMHEXp6
         J8R7ABJl4Ck+Fotla9Z77Wx4wkn9eVvFYh+LhZg56XfgVcDxkc9agvXGE8jvtZjyofPT
         STfB5kqPZ2xt4BUv+qG5L4dVuqVQ9ZckhAKnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875797; x=1725480597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ1BOrVPCxbcofBdDQCr1/eCB8x16Q1WdHxzd2phCFs=;
        b=nPGEt1SYc8HehpK9CwMvxvSVgIwdLqNz17nyBtP2MhdnLcvSiI0vLsuJDaOvf1jQln
         EjIDAFmOc7yOw/RIj0kjSZQgmx01GINZhLONNfGtJG1e3B5+FG45acqYIuTIPWrz7BVO
         lDowqxsofmTunvuPwqZXvyuFgruC1fWwdHEQa+EYy4ARcq6Zx47W37UL8MQYrfz+OAVl
         6Maw6fXQmXtdv8REOsWW0dQD+1fB6AqSAhi9/Iesz6TQCAHxywoC3Srp+iDPuEm6F/3A
         3nXh1zGKdmIMrZsmAM0ExtEEu/aG3GfcAN2rEgEdgdhBwQ5++Nl7aHQL1GfprTymlPp0
         a6Nw==
X-Gm-Message-State: AOJu0YwclMP7L1OvTjpgnj/dpPbb4Nx6JCmwRVxUHN0+vxgkGjKz6dsi
	PtjYlXhThkAxxbjn3ffjMenxeXdT9gzte36hlVBbJTo/YcEUQfebvmkM5yQxh+83u4vw8iR22l7
	n
X-Google-Smtp-Source: AGHT+IHTEigygDmMzVONjtS+ft5C2MKXwTiRz/NGfWqfMZn87CeHnegkoiZbWjmiy3dyk8CIiqaYeQ==
X-Received: by 2002:a05:6602:6d8c:b0:81f:9f79:2b37 with SMTP id ca18e2360f4ac-82a110a23ebmr86224939f.16.1724875797509;
        Wed, 28 Aug 2024 13:09:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 11/33] rust: use rust-snapshot binaries only in rust-native
Date: Wed, 28 Aug 2024 16:08:57 -0400
Message-ID: <542e03174adedf82202c9ac254c3a2463e13a777.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/578

From: Alexander Kanavin <alex@linutronix.de>

Otherwise, use rust-native and cargo-native binaries as that allows
our native tweaks in them to be used for target/nativesdk rust -
same as for everything else written in rust.

In particular, this allows building target rust with
cargo-native that includes important reproducibility tweaks.

Unfortunately, this also breaks rust selftest, and that
is partially addressed by the following commit.

[YOCTO #15185]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8f2230cb51fe22ef4711a56fecfab4858c04e35b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.75.0.bb | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/rust_1.75.0.bb
index 8ef838e..e82a739 100644
--- a/recipes-devtools/rust/rust_1.75.0.bb
+++ b/recipes-devtools/rust/rust_1.75.0.bb
@@ -11,6 +11,11 @@ DEPENDS += "file-native python3-native"
 DEPENDS:append:class-native = " rust-llvm-native"
 DEPENDS:append:class-nativesdk = " nativesdk-rust-llvm"
 
+# native rust uses cargo/rustc from binary snapshots to bootstrap
+# but everything else should use our native builds
+DEPENDS:append:class-target = " cargo-native rust-native"
+DEPENDS:append:class-nativesdk = " cargo-native rust-native"
+
 DEPENDS += "rust-llvm (=${PV})"
 
 RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
@@ -68,6 +73,11 @@ addtask do_test_compile after do_configure do_rust_gen_targets
 do_rust_setup_snapshot[dirs] += "${WORKDIR}/rust-snapshot"
 do_rust_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
 
+RUSTC_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/rustc"
+CARGO_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/cargo"
+RUSTC_BOOTSTRAP:class-native = "${WORKDIR}/rust-snapshot/bin/rustc"
+CARGO_BOOTSTRAP:class-native = "${WORKDIR}/rust-snapshot/bin/cargo"
+
 python do_configure() {
     import json
     import configparser
@@ -141,10 +151,10 @@ python do_configure() {
     config.set("build", "docs", e(False))
     config.set("build", "tools", ["rust-demangler",])
 
-    rustc = d.expand("${WORKDIR}/rust-snapshot/bin/rustc")
+    rustc = d.getVar('RUSTC_BOOTSTRAP')
     config.set("build", "rustc", e(rustc))
 
-    cargo = d.expand("${WORKDIR}/rust-snapshot/bin/cargo")
+    cargo = d.getVar('CARGO_BOOTSTRAP')
     config.set("build", "cargo", e(cargo))
 
     config.set("build", "vendor", e(True))
-- 
2.46.0


