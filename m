Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B00C87FCD
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web11.23030.1753296043868982666
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uKmXESj+;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab82eb33f9so3418001cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296043; x=1753900843; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNqxo28ILZ92eV6buGbDsyl3YtCsfnHxvrLra7lJNks=;
        b=uKmXESj+FdCoj+18AeVZDtmzW6ouyUAb7F7UvPXjvFOWyIVVQ9bTfydDPjWWSZ+7Ih
         XvC74nI9TKbElpksLZh+4Jv1cs5QOEGGOjBrQjSol1VbdIi07WoMVi484BG0IBDnyjNV
         lJkFSZMiaHwwT4LmTxMoUZ8zyezFk8Ea3W/J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296043; x=1753900843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNqxo28ILZ92eV6buGbDsyl3YtCsfnHxvrLra7lJNks=;
        b=wC8zslVKQBDk6v4YUxjMFozq4XtRIEqsfYjch5yR1IGejS9ll38ViAjyEPPS91eJhz
         nmN01uwDh24UTiFDmUpLVQYlFbxdbSq8fQtnopzJr9oqkynUTYsWA8L2XM3Ds/nHi8ya
         seiC74+IpxfyYimPO7J9AHZZM+V9+PHSed2Husd9K+8HsLi5290YgvVNmcqregRIJ+wt
         mzh6Ulgl+uDctEV9FGCbdTQut1Q4tUGMI9eFTClMl0nIl4C5XjLCJ92rlceiM7KDxYMn
         NzQWn3rBSYuTLpTUwFn9AcXMbwPor9W6gOxysQnwuwOwVZ6LXK5WqFt7dRPbQouJeLGu
         BvFg==
X-Gm-Message-State: AOJu0YygDB9W4HvPnkWjLGDsdOkhuPz37YxOMw3wgh7ERdKjZNEkYyp7
	T2YADzy8URtR7J212YIBN2Cs3FqgDN7LHqAvBy6dtJDjcgUUpb4v5AfzzBaZYVrWqk9WbNcPRpF
	sWspJ
X-Gm-Gg: ASbGncsufPEFOWuyjEKeG0YowJTJtxgikG3Oz6AKnlrEGSnjIBTo4DeJ7axzHSEOADg
	Ox7sb8aNhkg6boy4LdZr2wPMTFptnSwXzVIQBHqlTKrRJjny8q4doEJ3COe54C4B26gYXoOyJa0
	oRhdVT8hpoaKUuHipOAn4ygm7oAV7gjChFpr3QH+Quuv8OJCS9X1dDshD4bbigNGVOwz3juQsP4
	qmvyUxVBSOb6Zw4A8CaNWh8NM7CKuakDQxGwTG8ukK/uGJA6mmmeRH3YWa3xR8pPsLKk/EveoU1
	hHuYIXG2IpkGIdDzpWH+eQohFUvdhp2Rm4hEd/gEa+0kN7dojpgxGAnl8ac5NrCeAJAGBcy48OM
	Gjp8HXR9mQydbDyFVTvPvupYCJSbdcnRS1H+3WQH3Tpjcz66MzUpveVkqAnXG+pJ8SSIcyUX8qg
	==
X-Google-Smtp-Source: AGHT+IFmO1NRUqf8nyhslXZid8N2wTeEaps9PwaosYUdpu7XoL/qMGKd2m1RHTy1/DRtaXMmFfkoxQ==
X-Received: by 2002:a05:6214:29cb:b0:704:9a37:7e07 with SMTP id 6a1803df08f44-7070067ee0amr60065296d6.36.1753296042285;
        Wed, 23 Jul 2025 11:40:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/13] rust: Drop obsolete rust-lld and extended tools dependencies
Date: Wed, 23 Jul 2025 14:40:10 -0400
Message-ID: <8538a40240e45bb3e4f05856d03c7976d45fa86e.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1836

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


