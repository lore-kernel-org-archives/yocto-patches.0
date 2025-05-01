Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BAC369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.4577.1746132042111134386
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sJf3kWpj;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso15127536d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132041; x=1746736841; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8et8Xv+NETWIb13qp4v3Vg//BHU4A1UZAAXpZrjRGQs=;
        b=sJf3kWpj97FSBFGLhY4YbIr7+k+2VIgjMW7Xt7EYY148iPvJvYMsyX7WrLAKnV4aH5
         abHCz/3tbLE4V3W1UNXghmgKNYJ0MR7hwC+V1N6m23w66sXWtNDlCJZWG3uEFiced6zy
         og8WPkJyIfCUBqI2f6GrWybonARzHVz1AvWig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132041; x=1746736841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8et8Xv+NETWIb13qp4v3Vg//BHU4A1UZAAXpZrjRGQs=;
        b=HyR760Wk52CViGiJHHhQx709WQ6PbUsPPD5GA6H4Oy89E0wDdQWbrxeKhStqHjYZnc
         XtOFZRKpva6eTID82p0keHO51dqMbXQzLaCRk/RaC1lXVtQd/tcQaeSD5wApsKtpX/pV
         u9DLCoc91s4Y2WPKlu8/DrXb8yklXuW4a5o4JeT7uBe+AlwT02v7yOo6WM7mGE+Xrn6l
         RcBoiZprjtyhpE9IUgmHa3yuL55wKqZf/t/EnnV0HfWYPVX5KHsH4mVGvQoFQom8W6Vz
         VAnT0Z6sqOVkpOMOmIJ9tzK+rfZDja0hp0sIv7tZXuLS/zgR7PjtPAHa9qb7x010k4SL
         Qvtw==
X-Gm-Message-State: AOJu0Yx48uUyX+XzDJOKdMYMao2kOZzqfpLI/doFAtTA2rlBrGY9pI7s
	fYYAiq1N5j19XhD4//bqO07GbMHWQOOnXMndYKFiSrPqQUQdmqcOHnNP7j1TPML8t10qzu+7W4K
	6
X-Gm-Gg: ASbGnctcWk7QOmKOHkN1RL517YEySTpghkGy1Iq6jey2HoXdxBp9s3l02ANXbgEX6bC
	E9DsDIU+Hj9Fz7o0WxVw8nTKhQUksHT9c5klT2tMqsu0siXMrIlw9AwHX9ympayFxqgTKxB2VzL
	syIK+lr4+C8NHX+25wKecBBZGVDYTbUC4SH/+w8ZZbDHikESEJkJ8MW3JfA4DG+B6D+kYaeu6NF
	trNJ4SmPhZfXDWUvfTugqWZhz8XtXVcz72F5P3waMl+Fv83LKWaLPMzIqZSHJ08yrBpQ1afbrcM
	RCX67zmJFM6miipHyN0lo0HaInbbeDzp0Ogrba9RJCKeZ3IPh8VOfYmNAWcGJpq9AXe8EC1nk0I
	isyzfm78laoG+iaq9
X-Google-Smtp-Source: AGHT+IGEhf/UfNFvOgaSYODPxLk9C5kR7r12Uw/TEy3tQSZLWqMx+92e7/ymUjCjq+vfQ+Bv8N5XOg==
X-Received: by 2002:ad4:5d43:0:b0:6f5:113a:6901 with SMTP id 6a1803df08f44-6f51526dc0dmr9104816d6.21.1746132040855;
        Thu, 01 May 2025 13:40:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 06/38] meta/meta-selftest: Fix variable assignment whitespace
Date: Thu,  1 May 2025 16:39:42 -0400
Message-ID: <5661c775518777419aa24edd1a21dca4413be04f.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1433

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Recipes are much more readable with whitespace around the assignment operators.
Fix various assignments in OE-Core to show this is definitely the preferred
formatting.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 30ea609d3357fb3de911f2f6a5e6856c151b976a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo.bbclass                                     | 2 +-
 classes/rust.bbclass                                      | 8 ++++----
 .../packagegroups/packagegroup-rust-cross-canadian.bb     | 2 +-
 recipes-devtools/rust/rust_1.81.0.bb                      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
index b583f84..76a3966 100644
--- a/classes/cargo.bbclass
+++ b/classes/cargo.bbclass
@@ -42,7 +42,7 @@ CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} ${BUILD_MODE} --manif
 # This is based on the content of CARGO_BUILD_FLAGS and generally will need to
 # change if CARGO_BUILD_FLAGS changes.
 BUILD_DIR = "${@['release', 'debug'][d.getVar('DEBUG_BUILD') == '1']}"
-CARGO_TARGET_SUBDIR="${RUST_HOST_SYS}/${BUILD_DIR}"
+CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
 oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
diff --git a/classes/rust.bbclass b/classes/rust.bbclass
index dae25ca..e727601 100644
--- a/classes/rust.bbclass
+++ b/classes/rust.bbclass
@@ -43,9 +43,9 @@ HOST_CFLAGS   ?= "${CFLAGS}"
 HOST_CXXFLAGS ?= "${CXXFLAGS}"
 HOST_CPPFLAGS ?= "${CPPFLAGS}"
 
-rustlib_suffix="${TUNE_ARCH}${TARGET_VENDOR}-${TARGET_OS}/rustlib/${RUST_HOST_SYS}/lib"
+rustlib_suffix = "${TUNE_ARCH}${TARGET_VENDOR}-${TARGET_OS}/rustlib/${RUST_HOST_SYS}/lib"
 # Native sysroot standard library path
-rustlib_src="${prefix}/lib/${rustlib_suffix}"
+rustlib_src = "${prefix}/lib/${rustlib_suffix}"
 # Host sysroot standard library path
-rustlib="${libdir}/${rustlib_suffix}"
-rustlib:class-native="${libdir}/rustlib/${BUILD_SYS}/lib"
+rustlib = "${libdir}/${rustlib_suffix}"
+rustlib:class-native = "${libdir}/rustlib/${BUILD_SYS}/lib"
diff --git a/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb b/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
index bb10a2d..7e220d2 100644
--- a/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
+++ b/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
@@ -5,7 +5,7 @@ inherit cross-canadian packagegroup
 
 PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"
 
-RUST="rust-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+RUST = "rust-cross-canadian-${TRANSLATED_TARGET_ARCH}"
 
 RDEPENDS:${PN} = " \
     ${@all_multilib_tune_values(d, 'RUST')} \
diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index f54a497..782c37f 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -31,7 +31,7 @@ S = "${RUSTSRC}"
 RUST_CHANNEL ?= "stable"
 PV .= "${@bb.utils.contains('RUST_CHANNEL', 'stable', '', '-${RUST_CHANNEL}', d)}"
 
-export FORCE_CRATE_HASH="${BB_TASKHASH}"
+export FORCE_CRATE_HASH = "${BB_TASKHASH}"
 
 RUST_ALTERNATE_EXE_PATH ?= "${STAGING_LIBDIR}/llvm-rust/bin/llvm-config"
 RUST_ALTERNATE_EXE_PATH_NATIVE = "${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config"
-- 
2.49.0


