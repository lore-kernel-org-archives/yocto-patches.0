Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49586C369A6
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.59595.1744061443306917525
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SfQxp1YD;
 spf=pass (domain: konsulko.com, ip: 209.85.166.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d57143ee39so39252585ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061442; x=1744666242; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3ZOIq3Gy+CyanC6ptd67GaUey65BH/utmTCtVpUJFs=;
        b=SfQxp1YD04ju01xLmCRfBb8R9qQqyuT/hWXKcaernlvxXqNrWqEFL+C0HfhQJODPlh
         OGIJCXz1G/DgRAOyFHjQPar7qRlaF73OE9XmBl/mTQcuBfA3D6pbq6a4fqjhP2v6+AoW
         U/i7+dMBFjCrB0PMjFQ+T5LIkIgVdCkfJY5Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061442; x=1744666242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3ZOIq3Gy+CyanC6ptd67GaUey65BH/utmTCtVpUJFs=;
        b=aOFDFEpEDTn0lt3CQbAt1ppXADbuBjMzDOnG8coUelP0D/I5JuxHkX3q4wig9hHu+M
         TiMUn6T2/UqIIob/SY9cB3e/yn6j1OCiEy3qHWO6QpSbqBrZNvrFoeyFbN0nilcsuY6t
         pti/DbiExcKzV+dzNlOcorbcz6UyrQinRbKV9C3Ybdv46mP4Cmf+nRP0rqHn1gczWtNV
         /ITHgNV1l2tHMiD2YMqdpt+Wvg/8/dCZnFL/pcH8RO/G/zJEqEThfpVrr3z0edPpcquE
         Bhr7BdclfWzjA/BugPbVGTf/16nm4K3V2OgMdGGJt9orp7Imq1OW6E2Xzbfkumodh75C
         ULXg==
X-Gm-Message-State: AOJu0YxK446ehVJBFfIMn1bgaZ9PM9fBGka3OG4T57fqSDdLcGnPLbhK
	NdXrIrIMDoB8i6ujt4T5qt7wLsUsWLxr4pMjfLvG1nB2kUNoLBPhNcQG4L7rzV4k69CCQk9mj1W
	NX4k=
X-Gm-Gg: ASbGnctBPd6bPGfR0SUw7yyXgXSbaSaEzOv6DX4/U6YxfquYrN1i0UAQIrZ3gEyYDSQ
	w8wd+Wn2ErOElV6/U9Mh5+va13GGKJJB/AmFlnpZtr/3tNGU95JBWkPAC6jWQpUhg6Pmsxl9Jj0
	+lx4e7ClTGTBET6KHiWYGDd6lJOurd5lCAIYjPetB8LCpjP7iEOa3RoL/YWXTgelfma4lobYZOy
	bVpGS1tT7q+UlQKY6e3yiN8731JW9piX61HZciJ2utNYaGqViASbkCLBUxCA3iBgEOw7uzlACTE
	3E7C9C5sBxUBbYSwXRu7vO1P0fTJZ33ojrM6lCgQsVfNUCj7U3mp/82NFmnPY7R0HJ3p35P6eNV
	p3dPiMf5MMUfykj16Sf0k
X-Google-Smtp-Source: AGHT+IHXrHR+wwMYN91asH4eP29GHeUEr2I+pJ5PEY+hAnJ26mWlOMJ+A9o7cvvNzNeaISCevS/2EQ==
X-Received: by 2002:a05:6e02:1a85:b0:3d4:3fbf:966e with SMTP id e9e14a558f8ab-3d6e3f653a1mr132825985ab.14.1744061442285;
        Mon, 07 Apr 2025 14:30:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/29] meta/meta-selftest: Fix variable assignment whitespace
Date: Mon,  7 Apr 2025 17:29:54 -0400
Message-ID: <9c27ba0d4bb4724ecd47ebf0a2cca77e40ad3431.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1305

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Recipes are much more readable with whitespace around the assignment operators.
Fix various assignments in OE-Core to show this is definitely the preferred
formatting.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 30ea609d3357fb3de911f2f6a5e6856c151b976a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass         | 2 +-
 classes-recipe/rust.bbclass          | 8 ++++----
 recipes-devtools/rust/rust_1.81.0.bb | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index b583f84..76a3966 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -42,7 +42,7 @@ CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} ${BUILD_MODE} --manif
 # This is based on the content of CARGO_BUILD_FLAGS and generally will need to
 # change if CARGO_BUILD_FLAGS changes.
 BUILD_DIR = "${@['release', 'debug'][d.getVar('DEBUG_BUILD') == '1']}"
-CARGO_TARGET_SUBDIR="${RUST_HOST_SYS}/${BUILD_DIR}"
+CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
 oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
diff --git a/classes-recipe/rust.bbclass b/classes-recipe/rust.bbclass
index dae25ca..e727601 100644
--- a/classes-recipe/rust.bbclass
+++ b/classes-recipe/rust.bbclass
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


