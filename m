Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E1C3ABAA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:41 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web11.4640.1746132040125087997
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=B7CQUxZv;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c9677cd6d7so164491685a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132039; x=1746736839; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6vZnnD/d90l/pDiHfGeIGmXdEh8x/mLPRHHvImReeI=;
        b=B7CQUxZvM8nlXvboYeDmRNIYvncD2Ix5AcHyrwb/jIKRPD+u+OQlsWwigPwcugHYRG
         x2vuwIYxSl34ylwUWaUg2A1L4azsJHuOa/hsXeVjP1SIaYqjfXSAKQLdt6tddz01BMSA
         EuoJo+wDfV/KlVR9rcRadHzlfwMuA2jvhV83M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132039; x=1746736839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6vZnnD/d90l/pDiHfGeIGmXdEh8x/mLPRHHvImReeI=;
        b=GlNcLXthhtpOhaY6NaDScpiuqbOPubt45l7tU2LN1rVryw332zsY0y99GRzzI68LBN
         l8dhDvRA+fX5jlBiUYaFL5MaZmw7zEyEohlr0VUFcffKshj68AXhO7zgS3BDI5xMblil
         II+SerG9YCPgJjvxh/pfCyjaf7YCB9UaOhoEurRTaMPgj/gHoQFYC1F8W8YgN/ueN0/R
         j6PZwwk5KQIYsUA0eOMEo7u3sOMBYsml/fGn71FpkrCI1TcYuiMiEd/LansrofTVy+4Z
         Dl6HRo5Q2AFC9K3auJTHVnOp4xnwfN/8TEp8ad2sC/YB40w8yzq5+hlHHniVfZdtlMym
         RVxg==
X-Gm-Message-State: AOJu0Yykfvq36tx53wa+ohm7N9oaZnT+/6W+/R+nwYfboacDRiTQn6V0
	nEYgDJdP/rHcE3J/R3J5ERDnH1zmI6evNC491KQsrHGr+toMLuiTzeLqkOHVRM/2lVuSkrYGNvC
	o
X-Gm-Gg: ASbGnct0hvC/7/zRWS45BJZNzyjb+IJnuZY09m3nxIKN2uagIeDlqqlou9pgE8BfgRT
	zMQ8U24QuQVo2RuweLhFqOz7gqo9KPRJtxX1n5IDXCBCcgW4IcsSB7qH8gaAm137CtVKPIQcY0x
	LdRCrJ9mOJzIHs6hGHknHqdrzE4vYLBoFYMzaiHAlwgjhHVzKVmJOpZAQQKRBOB+7Uj0vf+IXvQ
	Lc6DvJhYgZTNUAMsMjpbCLIE/kcjNI3EFj3hxxTjslGXnI7Xjw4anvPY+XoW091d2Ia+fG1s2o5
	YCchd0nt/75ZpH37tPeFjtcSBi4dxcq/3OeeWY5sKMFEg1CiHyTaTpw2eYl8deTaNk9pi3le36u
	gZhraW0Kv0kQb7enFFtylXXdGmMQ=
X-Google-Smtp-Source: AGHT+IHx8lGmIKZz6+cYDaGF6dGyPhHbUFyOM2B5Fg17I40t2Yt6z1xWYL1CesaJRjkzFdycjnY/kA==
X-Received: by 2002:a05:620a:4414:b0:7c7:a55d:bd0 with SMTP id af79cd13be357-7cad5b263bbmr79701285a.5.1746132038888;
        Thu, 01 May 2025 13:40:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/38] rust-cross-canadian: set CC_<triple> for nativesdk
Date: Thu,  1 May 2025 16:39:40 -0400
Message-ID: <3a18322b3d6f57b3fab6cc5d77df233f607a6379.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1431

From: Sean Nyekjaer <sean@geanix.com>

This fixes build errors when building rust bindings for C dependencies
for the sdk host.
This will allow us to build and run rust programs on the sdk host.

Before:
% cargo build --target x86_64-oesdk-linux-gnu -vv
[...]
   Compiling zstd-sys v2.0.13+zstd.1.5.6 (zstd-rs/zstd-safe/zstd-sys)
[zstd-sys 2.0.13+zstd.1.5.6] CC_x86_64-oesdk-linux-gnu =3D None
[zstd-sys 2.0.13+zstd.1.5.6] CC =3D Some(arm-oe-linux-gnueabi-gcc  -mthumb =
-mfpu=3Dneon -mfloat-abi=3Dhard -mcpu=3Dcortex-a7 -D_TIME_BITS=3D64 -D_FILE=
_OFFSET_BITS=3D64 --sysroot=3D/usr/local/sdk/sysroots/cortexa7t2hf-neon-oe-=
linux-gnueabi)
[zstd-sys 2.0.13+zstd.1.5.6] cargo:warning=3DToolExecError: Command LC_ALL=
=3D"C" "arm-oe-linux-gnueabi-gcc" "-mthumb" "-mfpu=3Dneon" "-mfloat-abi=3Dh=
ard" "-mcpu=3Dcortex-a7" "-D_TIME_BITS=3D64" "-D_FILE_OFFSET_BITS=3D64" "--=
sysroot=3D/usr/local/cc-sdk/sysroots/cortexa7t2hf-neon-oe-linux-gnueabi" "-=
O0" "-ffunction-sections" "-fdata-sections" "-fPIC" "-gdwarf-4" "-fno-omit-=
frame-pointer" "-m64" "-I" "zstd/lib/" "-I" "zstd/lib/common" "-I" "zstd/li=
b/legacy" "-O2" "-pipe" "-g" "-feliminate-unused-debug-types" "-flto" "-ffa=
t-lto-objects" "-fuse-linker-plugin" "-fvisibility=3Dhidden" "-DZSTD_LIB_DE=
PRECATED=3D0" "-DXXH_PRIVATE_API=3D" "-DZSTDLIB_VISIBILITY=3D" "-DZDICTLIB_=
VISIBILITY=3D" "-DZSTDERRORLIB_VISIBILITY=3D" "-DZSTD_LEGACY_SUPPORT=3D1" "=
-o" "zstd-rs/target/x86_64-oesdk-linux-gnu/debug/build/zstd-sys-b2560022e17=
2eec3/out/44ff4c55aa9e5133-debug.o" "-c" "zstd/lib/common/debug.c" with arg=
s arm-oe-linux-gnueabi-gcc did not execute successfully (status code exit s=
tatus: 1).cargo:warning=3Darm-oe-linux-gnueabi-gcc: error: unrecognized com=
mand-line option '-m64'

After:
% cargo build --target x86_64-oesdk-linux-gnu -vv
[...]
   Compiling zstd-sys v2.0.13+zstd.1.5.6 (zstd-rs/zstd-safe/zstd-sys)
[zstd-sys 2.0.13+zstd.1.5.6] CC_x86_64_oesdk_linux_gnu =3D Some(x86_64-oesd=
k-linux-gcc)
[...]
   Compiling zstd v0.13.2 (zstd-rs)
    Finished dev [unoptimized + debuginfo] target(s) in 14.67s

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 3c8fedd6e5a3251b7a7a73cc92b153d8e68cb8e5)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.81.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/r=
ust_1.81.0.bb
index 4efdcff..f54a497 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -277,10 +277,12 @@ rust_do_install:class-nativesdk() {
     mkdir "${ENV_SETUP_DIR}"
     RUST_ENV_SETUP_SH=3D"${ENV_SETUP_DIR}/rust.sh"
     RUST_HOST_TRIPLE=3D`echo ${RUST_HOST_SYS} | tr '[:lower:]' '[:upper:]'=
 | sed 's/-/_/g'`
+    RUST_HOST_CC=3D`echo ${RUST_HOST_SYS} | sed 's/-/_/g'`
     SDKLOADER=3D${@bb.utils.contains('SDK_ARCH', 'x86_64', 'ld-linux-x86-6=
4.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'i686', 'ld-linux.so.2', '=
', d)}${@bb.utils.contains('SDK_ARCH', 'aarch64', 'ld-linux-aarch64.so.1', =
'', d)}${@bb.utils.contains('SDK_ARCH', 'ppc64le', 'ld64.so.2', '', d)}${@b=
b.utils.contains('SDK_ARCH', 'riscv64', 'ld-linux-riscv64-lp64d.so.1', '', =
d)}
=20
     cat <<- EOF > "${RUST_ENV_SETUP_SH}"
 	export CARGO_TARGET_${RUST_HOST_TRIPLE}_RUNNER=3D"\$OECORE_NATIVE_SYSROOT=
/lib/${SDKLOADER}"
+	export CC_$RUST_HOST_CC=3D"${CCACHE}${HOST_PREFIX}gcc"
 	EOF
 }
=20
--=20
2.49.0


