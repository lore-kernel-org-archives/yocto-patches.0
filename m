Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3157.1795645892709399501
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EnmFMND2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5495d549924so67850101cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645891; x=1796250691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gk1qRY0h/ceK2rMMWM/22tNXziL0BYkT86rfk+0YXt0=;
        b=EnmFMND23EWFFY4DVbcpVdgLxlljtt7+pHhrKRkKnNiUPg/KDfFEBaU3etL+GP3EFN
         qjhEODHIJsIuZFckZ5pixMitd356UypZ6YCaJ58Y0kAsf0shJyJHBti52tOshzb1dCLj
         2sc/FupVKhcrRmm3czxoKf6ODIetT1Q40K/xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645891; x=1796250691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Gk1qRY0h/ceK2rMMWM/22tNXziL0BYkT86rfk+0YXt0=;
        b=ZfT7PS2MmxUOJvZnrgBsvFmTWgt3QE+UKUm0A/4C/nI2YPw8zwh5q5JZqavzq0fepS
         DEG2uHdJW/5AwIrQnq25HD4tiOVpQ15PbB2TFM+ABoE1fZwud6OgkWOcQEZFvGkEy30F
         yJ9psSB8Qzd4FwG71WOm0fc1xJS9V+10cz6Wm4bDNw5Pw8oy2dMJ8jfEYNK2hVegdiZT
         2tbWBTwlngXcV0Wavaxcs08hgijwo+XCju8/zGZUiuSkxP1c0HERoS5XH/QXSO/kEMTf
         2i4N8EU9Frcp6k7zEJfmnlhnGhHxY6APs8CzyWRkPWmJbtDZ8amlB5TaHwGbLhxXVHnd
         db2g==
X-Gm-Message-State: APuU4Z+QnV+Fpmiiukj6jOc1l5r3lxHcvnDjh4aauimv1/3jomUs6kbe
	95Jl5WK0sTbYOOH5joAbr8aSQzPf1iRCxSuxGLSDnI8A2i6ZPssv/W8YBTiTbKb1kqKcG0Ng8dK
	rNwhp
X-Gm-Gg: AZFdTZfMZlb/GK+YF8YDbIp4zQM3WS6VnF/tmi+JEP0RsqaGffs7PHEj5UvNB9uIpDN
	EzSqzdl9Fyx3AFPWbU8pOJKqpJ5QFpju96+5YBxirxAAHZDOuYpCf12OXyoHdv5YK0PC0rV/733
	5YeDTTNfEIzQq5nDhLfr3paHA6dwOnlXmnjkQ53D+Bq1u7yywkjAMdE3FMpwnK1yMLCTTT7ecyx
	400I3c00430YVwYdXd1PkeIRE4lSQFLHLgSOW5sWJwK1lP2nB8lxSxUwC3VOKOd6K/r+XME2SZB
	F9V5eqNeZ4pw6tahXyu1Kr1sCB0caEXqg/ASdNCDuVmgsuiRG3QYtCC9xz2tgzYFkd2lk1AdYuP
	Bmhd0zHOnq1IVI/85QnMslEMAae6PlW+D3wEf0XGBI03voJAhAacmeaHZbkjyNQZQ426CKzld2p
	nv0BNjBsc5YzbMli4k3Tt7dNXXhPuh+clMqDzJHbx3JQ9HVkWKzVAUGkmpYaWp1VETu6MCiiun2
	BKRoPq5E8mDl8cGE+SqCOQWWXryuCuh8DHyw7jUAFvY+WVIldNxlGdiZ/YSseFki04WZv1SUMcs
	yH/oDzYXxfimoXlPv1YJXJRDBoGi6PqGyPI9wKj2wp3nywYtyCMpslqkg5tUvck5Pa6tjYITi/c
	J9ilGIJQPnSWofdYhyPbZFrW0zQgTKAzs6rX0J/SPvYdQqFrNanHYE/idvpSxvJ4IJA==
X-Received: by 2002:a05:622a:1f18:b0:55d:3198:255e with SMTP id d75a77b69052e-55d768a4886mr349022081cf.8.1795645891451;
        Wed, 25 Nov 2026 14:31:31 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:31 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/19] rust-cross-canadian: install target-specific env scripts and fix rustlib lookup
Date: Wed, 25 Nov 2026 17:31:02 -0500
Message-ID: <63591a2922a02af9ca2420c46ea4b306844841bd.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5530
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
index 5a152bd..235402a 100644
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
2.56.1

