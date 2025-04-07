Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC66C369A5
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.59592.1744061439588656414
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NA5iyIZP;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso56461639f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061438; x=1744666238; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krfGJMkezWKgxTAf2jh0YlprqBmgB369ch2AYvpKJvI=;
        b=NA5iyIZPCa/+SXRIvPqWxuqa4lrFFPEQCeiamU6o/sqyoXJlK5y0exVx/zL2O2FrsI
         ufyPlVFW8AZVw12Q8+nUuDviggn3Mfig+EcpcfxdQb4A+A3lbAISnhrDWiBPMNoOup35
         W43gbczB1O1EqYFs+AE4dZeZGwALb/mQMtlho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061438; x=1744666238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krfGJMkezWKgxTAf2jh0YlprqBmgB369ch2AYvpKJvI=;
        b=GZUl3R+NPTVpkyw0LM2ugmLaGAuXxGr+IZq3BtS2m/cQm2K9NMBdXdcBpYF4pep+Xy
         1+HTWP5ZqJQvdWlTAO6ZlRLnEK5s7bIee572VSa6vG812VuUk+f0vxfM1xdERZjOraUq
         uYblcyhwv2Afo9y3uzq6vSoJGWwTAQ27Ez9cIjo93hdJhpZt48krCYAr5LbPamBqYuNQ
         9suBdAKT7bpX0OoIt8bsQaOtQwxiPlNIvWoEclKuwk/D4AbVhBeWhuOxvO70z8YlH8SU
         lGwZnKj/Dykj8YAwSkhPeA8vYDEe8v8LwQLQpk5aeYmxM0dRgibPjG0BwXgIdVs7Un8X
         FMxw==
X-Gm-Message-State: AOJu0YwquTcdNOw95g4fSpa7GJI49qflE2+X5Lee/Vh+ec05vISAjQs8
	ehKfPNmtJKizEGDv8VxAxeaZ2OCU0zV1/mGhGV8xlZaD1ToB8YEoUOGUFErEtVJ0if+ynLvP2mj
	dycA=
X-Gm-Gg: ASbGncu1Gfc1bJUQF4olNbcOKhfKTY41Zo+Gx40jsC3zpw+AE76RnXiSBy4cezeGjB2
	vtby2c/OpPSKPvyeOKv3g0MqKnnp02rfhs0Z6unf9Ne6dnDMVcNN7FsbVwW44UVfB+UyCW2M/8k
	UfvwUGIxcCX0OUKeaOgS7wewIAEJAp95zjRwOq7RpyAEnsxD3SRLT2ZMe69lOkBM3qA52Jc8sQ7
	At+TEE88e8HLol9THNmdN9sl5QXjMbINlvvHgXVhTk6db4rESZ44Wzl6lZAQ3zsqpxPu/XJJuLJ
	rcH1TDDxtj16jglccLNv7ZQkeKLVV5pE+Ragl4tIW+VamG/ATdrhTPxH9Ogs3T/iHFK+SyAXfvJ
	GtMEwQ6gydpHMlcb8hZM9
X-Google-Smtp-Source: AGHT+IHq2u4p7yXMn2CPs00AZpf5HAn5t1RiQ8ZIvUYfpNTSQ+Mp+htOxUunOwrtG1bYsJ9QpvIf5A==
X-Received: by 2002:a05:6602:2083:b0:861:1cd8:3b4a with SMTP id ca18e2360f4ac-8611cd83c04mr1240696639f.0.1744061438318;
        Mon, 07 Apr 2025 14:30:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 01/29] rust: fix for rust multilib sdk configuration
Date: Mon,  7 Apr 2025 17:29:50 -0400
Message-ID: <1692ac7c4047cd3c31954e2d7ca9974b802d02a8.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1301

From: Harish Sadineni <Harish.Sadineni@windriver.com>

YOCTO [#15061]
The rust sdk installs both 'rust.sh' and 'cargo.sh' for lib32 and lib64 in the same location.
This causes below error while installing the lib32 & lib64 binaries:

Error: Transaction test error:
  file /usr/local/oe-sdk-hardcoded-buildpath/sysroots/x86_64-pokysdk-linux/environment-setup.d/cargo.sh
conflicts between attempted installs of rust-cross-canadian-arm-1.67.1-r0.x86_64_nativesdk and
 rust-cross-canadian-aarch64-1.67.1-r0.x86_64_nativesdk
  file /usr/local/oe-sdk-hardcoded-buildpath/sysroots/x86_64-pokysdk-linux/environment-setup.d/rust.sh
conflicts between attempted installs of rust-cross-canadian-arm-1.67.1-r0.x86_64_nativesdk and
rust-cross-canadian-aarch64-1.67.1-r0.x86_64_nativesdk
ERROR: Task (virtual:multilib:lib32:/media/build/poky/recipes-sato/images/core-image-sato.bb:do_populate_sdk)
failed with exit code '1'

The change includes:
- Prepending '${RUST_TARGET_SYS}' to 'rust.sh' to differentiate between target systems.
- Moving the non-target-specific environment variables to 'nativesdk-cargo' and 'nativesdk-rust',
instead of being managed by the cross-canadian recipe.

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 40eb4bfe2f100ba5301046ca25110fcc55a640bb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo_1.81.0.bb         | 13 +++++++++++++
 recipes-devtools/rust/rust-cross-canadian.inc | 10 +---------
 recipes-devtools/rust/rust_1.81.0.bb          | 12 ++++++++++++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/recipes-devtools/rust/cargo_1.81.0.bb b/recipes-devtools/rust/cargo_1.81.0.bb
index 50b7e7c..a6d3f17 100644
--- a/recipes-devtools/rust/cargo_1.81.0.bb
+++ b/recipes-devtools/rust/cargo_1.81.0.bb
@@ -50,8 +50,21 @@ do_install:append:class-nativesdk() {
 	# sets to libdir but not base_libdir leading to symbol mismatches depending on the
 	# host OS. Fully set LD_LIBRARY_PATH to contain both to avoid this.
 	create_wrapper ${D}/${bindir}/cargo LD_LIBRARY_PATH=${libdir}:${base_libdir}
+	
+	ENV_SETUP_DIR=${D}${base_prefix}/environment-setup.d
+	mkdir "${ENV_SETUP_DIR}"
+	CARGO_ENV_SETUP_SH="${ENV_SETUP_DIR}/cargo.sh"
+	
+	cat <<- EOF > "${CARGO_ENV_SETUP_SH}"
+	# Keep the below off as long as HTTP/2 is disabled.
+	export CARGO_HTTP_MULTIPLEXING=false
+	
+	export CARGO_HTTP_CAINFO="\$OECORE_NATIVE_SYSROOT/etc/ssl/certs/ca-certificates.crt"
+	EOF
 }
 
+FILES:${PN} += "${base_prefix}/environment-setup.d"
+
 # Disabled due to incompatibility with libgit2 0.28.x (https://github.com/rust-lang/git2-rs/issues/458, https://bugs.gentoo.org/707746#c1)
 # as shipped by Yocto Dunfell.
 # According to https://github.com/rust-lang/git2-rs/issues/458#issuecomment-522567539, there are no compatibility guarantees between
diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index af9f2d6..e233861 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -53,15 +53,12 @@ do_install () {
 
     ENV_SETUP_DIR=${D}${base_prefix}/environment-setup.d
     mkdir "${ENV_SETUP_DIR}"
-    RUST_ENV_SETUP_SH="${ENV_SETUP_DIR}/rust.sh"
+    RUST_ENV_SETUP_SH="${ENV_SETUP_DIR}/${RUST_TARGET_SYS}_rust.sh"
 
     RUST_TARGET_TRIPLE=`echo ${RUST_TARGET_SYS} | tr '[:lower:]' '[:upper:]' | sed 's/-/_/g'`
-    RUST_HOST_TRIPLE=`echo ${RUST_HOST_SYS} | tr '[:lower:]' '[:upper:]' | sed 's/-/_/g'`
-    SDKLOADER=${@bb.utils.contains('SDK_ARCH', 'x86_64', 'ld-linux-x86-64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'i686', 'ld-linux.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'aarch64', 'ld-linux-aarch64.so.1', '', d)}${@bb.utils.contains('SDK_ARCH', 'ppc64le', 'ld64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'riscv64', 'ld-linux-riscv64-lp64d.so.1', '', d)}
 
     cat <<- EOF > "${RUST_ENV_SETUP_SH}"
 	export CARGO_TARGET_${RUST_TARGET_TRIPLE}_RUSTFLAGS="--sysroot=\$OECORE_TARGET_SYSROOT/usr -C link-arg=--sysroot=\$OECORE_TARGET_SYSROOT"
-	export CARGO_TARGET_${RUST_HOST_TRIPLE}_RUNNER="\$OECORE_NATIVE_SYSROOT/lib/${SDKLOADER}"
 	export RUST_TARGET_PATH="\$OECORE_NATIVE_SYSROOT/usr/lib/${TARGET_SYS}/rustlib"
 	EOF
 
@@ -80,11 +77,6 @@ do_install () {
 		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config"
 		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config"
     fi
-
-	# Keep the below off as long as HTTP/2 is disabled.
-	export CARGO_HTTP_MULTIPLEXING=false
-
-	export CARGO_HTTP_CAINFO="\$OECORE_NATIVE_SYSROOT/etc/ssl/certs/ca-certificates.crt"
 	EOF
 }
 
diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index cc00053..4efdcff 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -272,8 +272,20 @@ rust_do_install:class-nativesdk() {
     rm ${D}${libdir}/rustlib/install.log
     rm ${D}${libdir}/rustlib/manifest*
     rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
+
+    ENV_SETUP_DIR=${D}${base_prefix}/environment-setup.d
+    mkdir "${ENV_SETUP_DIR}"
+    RUST_ENV_SETUP_SH="${ENV_SETUP_DIR}/rust.sh"
+    RUST_HOST_TRIPLE=`echo ${RUST_HOST_SYS} | tr '[:lower:]' '[:upper:]' | sed 's/-/_/g'`
+    SDKLOADER=${@bb.utils.contains('SDK_ARCH', 'x86_64', 'ld-linux-x86-64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'i686', 'ld-linux.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'aarch64', 'ld-linux-aarch64.so.1', '', d)}${@bb.utils.contains('SDK_ARCH', 'ppc64le', 'ld64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'riscv64', 'ld-linux-riscv64-lp64d.so.1', '', d)}
+
+    cat <<- EOF > "${RUST_ENV_SETUP_SH}"
+	export CARGO_TARGET_${RUST_HOST_TRIPLE}_RUNNER="\$OECORE_NATIVE_SYSROOT/lib/${SDKLOADER}"
+	EOF
 }
 
+FILES:${PN} += "${base_prefix}/environment-setup.d"
+
 EXTRA_TOOLS ?= "cargo-clippy clippy-driver rustfmt"
 rust_do_install:class-target() {
     export PSEUDO_UNLOAD=1
-- 
2.49.0


