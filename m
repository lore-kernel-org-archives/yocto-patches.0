Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D02C3ABB2
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:41 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.4572.1746132038480052488
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bbpcc59e;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so31400046d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132037; x=1746736837; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX0fJbC+zCYbJsc+FRA2GhtTRlU/v58B3ctBlbp0S1c=;
        b=bbpcc59eQfT9bnifXDAXjXRKUDlM4SgXP5l9CGHwhfGM7MgS7f4yMPlXQ/zvzgkvfN
         9dN+t+Wcufd4yWAAgpe9M/TmyfZulTf804sXzNUmypzw02z7PH3y6Lm+aw5J9KXU27yK
         Mba1ZYBt/5Vo6wYdh6MakwCSnQbwSRUYHEqYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132037; x=1746736837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX0fJbC+zCYbJsc+FRA2GhtTRlU/v58B3ctBlbp0S1c=;
        b=MFrMaR832u01mYFjtIbmD/4NDRSpd7pM3ueeupsMYJ9jQzmvIguArkp/YKhYqZdHZW
         cxpwpeRRwt/jt2UmYPRF6/KNhDvl6BcnPhDOede2qAxUnXaa42xu4iNsCRDftnU/A639
         ftPYAJiWlvcXy6JfvNx0vq/ArnYZa4hG/tk33s/PzcMJR1OQajjH3H90JgzgK9H64b7g
         lQ0ZHL1V4cbW+a69o2EZBQuCeZSZIvuVvmhTXqAh6CRujBkLavxCvIUN9mbL7OSavBNf
         7snTFheeLSPbwTd8frSh3GjZ9UHXVWyxj4bCGCLliwdUamgxo4EZHiO9SQSpPJqEN1eB
         ChUQ==
X-Gm-Message-State: AOJu0Yw2SQ2jYUhRwb7HbDAMpdp07g00wI7q4HAWiEOYQNP1UKBr6RIB
	vzbMDNXnuKKFieX2KZ1M9PyqhlIIjEQRpC+Pt5OLf3ntkvm0Dtgz8IN8gt3hQU8df73xzwaTy3W
	H
X-Gm-Gg: ASbGncu5IJ6gOpwiFfDVeTBH5fSc1SNBGWnR21a/HcxIcSPo1GPVNZenlcO6kFmaLj3
	QGv2rtAqxh5FL0bm+0zw+X7rVMWACAeJtA5hmmN8rHO+0POlyosTnjqhjTSt0TsWtbuC28cNm6o
	hfIC+yxR0hFLNxBsQHzyJqLtVY/GRWAneop4k681KUyXRs6hu8He4tgwDIgMru5ztWWhaYsLkoM
	BjBZVYsWi88vSYOv9aKyoevcN14kP63nMDW00tyqQSTiQpKfgmdiUiUtEfICneRraHazp/y945l
	dgVWt4uC94upzPImZi1ghTLpwMR8zljwEXYsx2snfV8Le6v72dicXm7ARJyLfw5SXm89PdDAL6Y
	bExrNoG8mg9Lv/Bpf
X-Google-Smtp-Source: AGHT+IGF/Y+G7WQpmKbUN83wJzlj05fXxF9PU8K7SzGquM1zuUOEl/OiuChadfAdS+uCYp5AMFfL1g==
X-Received: by 2002:a05:6214:528a:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f5155fdbc6mr10235996d6.15.1746132037127;
        Thu, 01 May 2025 13:40:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 02/38] rust: fix for rust multilib sdk configuration
Date: Thu,  1 May 2025 16:39:38 -0400
Message-ID: <766557f3e1ed94cea58120b5033129cd7b63d664.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1429

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
index 45cb402..b001259 100644
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


