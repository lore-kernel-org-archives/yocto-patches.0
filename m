Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77686C88E64
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:53 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48449.1789157631028840013
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AZTE/PBC;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so3184711cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157630; x=1789762430; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IKE6DfFNoxIPKg8ZaoN5Wmq9Zq+3aH3Bqr5dJWVRD6s=;
        b=AZTE/PBCnVN1YMhxNO8Rs1TdDVEFMp5TWDAmfeK4GU4h4jt9oNyfGhkgtTKFyaCrgx
         FLaEzEyeL6BjSYGzMAzyyDa37cZ+3KHPkiinywMRN5NoOmPC4V7k1zuakyMfgeTvSxKr
         emSWzJ1ZH+rsYXitQsq6z9lksCEEaq3QOrsY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157630; x=1789762430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IKE6DfFNoxIPKg8ZaoN5Wmq9Zq+3aH3Bqr5dJWVRD6s=;
        b=YeHb2xUcNPObr0ilyNpL3bE8U4ysgf4BtpFPf1lSMxYn3enOajRebk/LtBkPab3iuS
         rL+W0l34dJiNzVAJGvsD3SE9XcIfmFBzaszdhx8+ppZXa1iAS722r1HF+LbKoGftjOIw
         O1hoPyXInZqAutx5oWQ3BbC5tJ6+clVamOnUhp40hhVdlRLO3q3cR9iA6805+Xm7FbfU
         OsJGjUf2Gd1RQAofpwMLEI5C+hIUSYe0MVS7Nf85qZlkZZDDDJ5J3xNB692YUjf6neA7
         YzVRME3C7FJWIdDEgnQeXpQ0+2nsoalDqJ2I/QPH6dr6vfbiOAddzOXVFd80I97XLQwc
         /g/g==
X-Gm-Message-State: AFuF++lTp/7nkAjTHzUuSFPGbbTN1ogtS98OV5H6RXQpH4YporiqhnLY
	0qjI4EImSPjSwY6HhBqDhvVOOidNU8CBxDSiczFLbTxUuBG7e2q+cZtXzo3w4d40uhlrm3TCNWc
	elssO
X-Gm-Gg: AYBFou08booORfZODmmzLC/g4neF8Kfm7Aifllr23usBuLCpZnkJ5PGXLvlafEx7pBp
	OnawN2pyYHZIzVRPVaW16EmnPRavun0wnCshZQtqaVO0jkP25p3YlANnMdtuYSDh/OaNeh8B13N
	YxqmLPnkv9eRZGYzfB68k0NtcxhbtTUPc90WgNrBIx2PKAdUTz5xXpwE7V8bMH5ySnhpIfQ2waO
	wKasHnU06g0Q65LhlonexUKR+snMproyoaoKj7w7hAvjBwiakKZg2zW/CfIwAfunb0zCK1vfViO
	EiMa/62KBnzytO1UPBqicOPkW7dEIA4Nr8sNlDusdG9pYoirzyHH8F5rzpSQQeKxf8g3UXLBtOi
	86zGOg9bnvAjr5WxUp8Gom2uJqKsc2OWsog5KvpquTp93AMCRfFulYW0gjW5m3zBXEPTaz51eJf
	M4IE6THPOY3XQRWLJmLeYn3/8mA0VXowvmoNV7ax2n2KT/eLq7ZkqlfDXQCLUCKvdeezH2lbUmr
	8DdYaNeheWDli5LQrAtwWUu4b8vUEdXTtktezw5dU+7GOIRyEWtu/JpxMz0UEw2C4NoU8yIH8TB
	EgmFeh6Wx6BVIEeqzT0YSo7eLoVgbBF82hA=
X-Received: by 2002:a05:622a:1652:b0:530:787e:7373 with SMTP id d75a77b69052e-530c8563c86mr104749461cf.14.1789157629824;
        Fri, 11 Sep 2026 13:13:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 12/37] cargo: centralise anti-vendoring environment variables
Date: Fri, 11 Sep 2026 16:12:58 -0400
Message-ID: <d2b5f157ecb8e879e3a21132841c6dda48b31dbe.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4778

From: Ross Burton <ross.burton@arm.com>

The cargo recipe has exports to stop the libssh2-sys (and git2-sys, but
disabled) crate from vendoring the C code into the built binary and
instead link to the shared libraries that we already have built.

This is desirable because it means that we have a single copy of say
libssh2 on the system that can be updated easily, instead of potentially
multiple different versions embedded in rust binaries.

This isn't specific to cargo, so move it into cargo_common so that all
recipes that build crates don't vendor C code.

The git2-sys linking was disabled due to incompatibilities with older
versions, but this appears to be historical now and git2-sys will link
dynamically if the library can be found. Force this by exporting the
variable so it refuses to build if it can't link.

Add anti-vendoring exports for libsqlite3-sys, openssl-sys, and
zstd-sys.  Also explicitly tell pkg-config-sys that we'd prefer to never
build vendorered code, and link dynamically not statically.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 6634a9a273e59a9671ce37d8ec84bb67b08b74d6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass   | 23 +++++++++++++++++++++++
 recipes-devtools/rust/cargo_1.96.1.bb |  9 ---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 34fd1e7..7ff2351 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -226,6 +226,29 @@ oe_cargo_fix_env () {
 	export HOST_CFLAGS="${BUILD_CFLAGS}"
 	export HOST_CXXFLAGS="${BUILD_CXXFLAGS}"
 	export HOST_AR="${BUILD_AR}"
+
+	# Tell crates to use system libraries instead of vendoring C code
+
+	# git2-rs
+	export LIBGIT2_NO_VENDOR="1"
+
+	# libssh2-sys
+	export LIBSSH2_SYS_USE_PKG_CONFIG="1"
+
+	# libsqlite3-sys
+	export LIBSQLITE3_SYS_USE_PKG_CONFIG="1"
+
+	# openssl-sys
+	export OPENSSL_NO_VENDOR="1"
+
+	# pkg-config-rs. Crates can still override the dynamic linking
+	# but try to dynamically link to system libraries.
+	# https://docs.rs/pkg-config/latest/pkg_config/
+	export SYSTEM_DEPS_BUILD_INTERNAL="never"
+	export PKG_CONFIG_ALL_DYNAMIC="1"
+
+	# zstd-sys
+	export ZSTD_SYS_USE_PKG_CONFIG="1"
 }
 
 EXTRA_OECARGO_PATHS ??= ""
diff --git a/recipes-devtools/rust/cargo_1.96.1.bb b/recipes-devtools/rust/cargo_1.96.1.bb
index 35e9cf9..99cac69 100644
--- a/recipes-devtools/rust/cargo_1.96.1.bb
+++ b/recipes-devtools/rust/cargo_1.96.1.bb
@@ -73,15 +73,6 @@ do_install:append:class-nativesdk() {
 
 FILES:${PN} += "${base_prefix}/environment-setup.d"
 
-# Disabled due to incompatibility with libgit2 0.28.x (https://github.com/rust-lang/git2-rs/issues/458, https://bugs.gentoo.org/707746#c1)
-# as shipped by Yocto Dunfell.
-# According to https://github.com/rust-lang/git2-rs/issues/458#issuecomment-522567539, there are no compatibility guarantees between
-# libgit2-sys and arbitrary system libgit2 versions, so better keep this turned off.
-#export LIBGIT2_SYS_USE_PKG_CONFIG = "1"
-
-# Needed for pkg-config to be used
-export LIBSSH2_SYS_USE_PKG_CONFIG = "1"
-
 # When building cargo-native we don't have cargo-native to use and depend on,
 # so we must use the locally set up snapshot to bootstrap the build.
 BASEDEPENDS:remove:class-native = "cargo-native"
-- 
2.55.0


