Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6308.1794870782396813623
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=K+u1bx8a;
 spf=pass (domain: konsulko.com, ip: 209.85.221.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ecda93627eso1117691e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870781; x=1795475581; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BOgtdKEVAEo7sLS4s0LpJlryfJl24q9C6qkOS1t8j3Q=;
        b=K+u1bx8a6w3Raj5ikEpCo2nElJrE19Q8NygZnvgRc0q6/FfAxqn+U+xy3AzMyMKzMx
         hqFsNyFL+q/jCWWWCO8ZN0VGyA2g3LwC772nXgH2eb/dhgwWSbMezMGVxPleF+S2xe1i
         1oQLLe6LtZ5isrm31lYK5i5YClcCmos37C4YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870781; x=1795475581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BOgtdKEVAEo7sLS4s0LpJlryfJl24q9C6qkOS1t8j3Q=;
        b=JxSipqiCh5E8uisqa/ou6C/hAmfqSmLn56HKOe+x+tj7G0wKhgTPEh89QbrQ6bODii
         iI9YpHmBpJ2faAkxkBgnDdS0PzvbVEzopXwyhLKGsEAI9F1EBTA89ITu8DQQ3lIZxRvZ
         M+LVX2b2nCDDGown1hvVDfps9tr4lJpGc2zWWZtG+ENIKr0M/OXvKp8oGwXImz/OBFjp
         Og8CQQP1MolMdPGzWXx36uz2S/3aRArU2cWvL337JU/9wQUuVL2i7k6QeES85aJB4Kzz
         dXuvJePl9hOURJxJoz27MVD3iyW8cR8f026Pru8sAEfkX8sDerPJOdC9DoM4mF2pPHre
         W6eQ==
X-Gm-Message-State: APuU4Z9+bRHOw0zDNOkRmgBsczS5ttuoLDTXIVkAoQqgmIKJe6gGhRM8
	y6Mw46/9JQ1mN+suCzZQNpcIPtSQBTm6+HIZF/Q8qP8GwUWMlgLPfYLowHEjs83gkt+FcMwhFqM
	NebJ45uI=
X-Gm-Gg: AYBFou1avlRH/msApvvf37gJV/OvkqQ8RGrLk0h8ngQLUGZQl8iIFvxJ1S3BNEkuwC8
	9hFlHd138tgw4VmDGGZMLn2P2dekYOJsj1wzsEkzF2K2DZPFHRZocdDdcHBICCABPEZx9faT3x3
	mbCHVv5amtbeMHRQStF8wa74FsxVlhpmDtKGAB6o48ae21oJbWh+P/2sMjpHUoPg8ETKcTvAqUn
	r/0h86TXZTkW8DAW3vx/MhxD0j0CHHcjBTFJNjNxR3y9yUTz+QZo5fjv9AtF9SJXraoeqmd3P/G
	Ftzs2FQJkrea3sxGRx7jH3Arwecq7GWMF7qf+Sz/A+L3j0RF+yUTpj0V4FtID2IcytDd7elrYSG
	5K60y6VvUPfxjtB1EZbz8DfzPJDy5RcWXsoYKAEinhrRQbO3Ihf0wcb27dRVe0NqrqUn4SpF/ma
	YfN4mggEL6SD7EEYQNljZVQX3TDmJ3hYetO3v+7ssnlMFtOSL/Cm94XOqu0YPYlDFM27+FxtjVg
	ULbpRggP0Ya5xQwxutUoiJSdCwLXQH6S2BobLua5wUGvopRUEf/9JpWdJVyUffh33Env9X9OMj5
	GysEUenouY7klQZXXX5+h8SXNKkuM6SlM7V2OlOCNSwLo0HPv2jasgA5bVgpp63S56wrx39isuG
	TJ/SzywTRhdiBWxHs3Rb44d3VMxZsgDPlYfG6Ma1Lq87Z0hVr5a4jo55pSfdgWkDG7uM8sitxAQ
	LypJAH19Gl/6Q9
X-Received: by 2002:a05:6122:ca5:b0:5ca:fc48:5634 with SMTP id 71dfb90a1353d-5ee34a7a244mr4273667e0c.11.1794870781094;
        Mon, 16 Nov 2026 15:13:01 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 11/19] rust-cross-canadian: install target-specific env scripts and fix rustlib lookup
Date: Mon, 16 Nov 2026 18:12:32 -0500
Message-ID: <d7a7f93948b68ea4c76f6cfc1682ebc5e8a2f673.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5450
Content-Type: text/plain; charset="utf-8"

From: Harish Sadineni <Harish.Sadineni@windriver.com>

Fixes [YOCTO #15061]

Fixes 32-bit Cargo build failures when using multilib-enabled SDKs.

Store the generated environment setup script in a target-specific
subdirectory so that sourcing the SDK environment always loads the
matching script for the selected target, avoiding accidental reuse of
the 64-bit configuration when building for a 32-bit target.

Also update CARGO_TARGET_<TRIPLE>_RUSTFLAGS to add an explicit -L
search path to the target rustlib directory inside the sysroot. This
ensures Cargo can locate the correct target-specific Rust libraries
during cross-compilation with the cross-canadian toolchain.

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4ded97c2905d1c4ec7911d904cad3a5fce98255f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index f083bcd..689ffa7 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -51,14 +51,15 @@ do_install () {
     chmod +x "$outfile"
     create_sdk_wrapper "${SYS_BINDIR}/target-rust-ccld-wrapper" "CC"
 
-    ENV_SETUP_DIR=${D}${base_prefix}/environment-setup.d
-    mkdir "${ENV_SETUP_DIR}"
-    RUST_ENV_SETUP_SH="${ENV_SETUP_DIR}/${RUST_TARGET_SYS}_rust.sh"
+    ENV_SETUP_DIR=${D}${base_prefix}/environment-setup.d/${TARGET_ARCH}
+    mkdir -p "${ENV_SETUP_DIR}"
+    RUST_ENV_SETUP_SH="${ENV_SETUP_DIR}/rust.sh"
 
     RUST_TARGET_TRIPLE=`echo ${RUST_TARGET_SYS} | tr '[:lower:]' '[:upper:]' | sed 's/-/_/g'`
 
     cat <<- EOF > "${RUST_ENV_SETUP_SH}"
-	export CARGO_TARGET_${RUST_TARGET_TRIPLE}_RUSTFLAGS="--sysroot=\$OECORE_TARGET_SYSROOT/usr -C link-arg=--sysroot=\$OECORE_TARGET_SYSROOT"
+	LIB_PATH="\$OECORE_TARGET_SYSROOT/usr/${baselib}/rustlib/${RUST_TARGET_SYS}/lib"
+	export CARGO_TARGET_${RUST_TARGET_TRIPLE}_RUSTFLAGS="--sysroot=\$OECORE_TARGET_SYSROOT/usr -C link-arg=--sysroot=\$OECORE_TARGET_SYSROOT -L \$LIB_PATH"
 	export CARGO_BUILD_TARGET="${RUST_TARGET_SYS}"
 	export RUST_TARGET_PATH="\$OECORE_NATIVE_SYSROOT/usr/lib/${TARGET_SYS}/rustlib"
 	EOF
-- 
2.56.0

