Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F99C369A7
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web10.60113.1744061441637380742
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=K7tr6ktg;
 spf=pass (domain: konsulko.com, ip: 209.85.166.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-86135aeca58so60950539f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061441; x=1744666241; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6vZnnD/d90l/pDiHfGeIGmXdEh8x/mLPRHHvImReeI=;
        b=K7tr6ktg+ma49dmY8wLRWFrIGXJ6LR4J7FNZcSTanIvPIgMhthSQkTvk8uN4cpSCrq
         QOUbWgxn0g/zq8MZLXU+EdTqFI/yNN4PKBjGt/3oTS20W512+FlSw+JtARuH+pyZOzg0
         zHXMht0O1DoZgExFOVyLQygULZOVZ5R9cYkJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061441; x=1744666241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6vZnnD/d90l/pDiHfGeIGmXdEh8x/mLPRHHvImReeI=;
        b=HXpd/mXzmPeDlPcyB/CqUymhPVkXWn+RQAq8grzoZEQJqEs5LDwC2Gf9lej11vPQtm
         y0xcTLLCatdBE0/dAL3mIx+ViWi5bPbxmdrT/VjtMsNtBn9tL3VuRJyrxWiEyte5dtla
         uJjC9pAHRLSE3t1FbZR9dgf4EcHJ0FmkO7NSU5c7Pb1oDJR8QvdvjsxMeThXo/MDZ5mN
         NYIBwZpN7wihcUKwWqgubop+j6YVGq2N8fEyATfbp7hfmSvWGB75X8PMsGv5sFi9wr/9
         7gbmKjCl0S/YxrgPOCdW60Bgp9Rr1vwxwlK74GasdrQgZYU1BbSNDA4Ei+Pf9ae7y7g7
         ZKCg==
X-Gm-Message-State: AOJu0Yxw7/4gUWqzKjAtGiXMHw9Paw0fMS01WJ5k3jQk4LWVwLO+O1uP
	LXgQA39V/g5xSEEDzhPOfQGAKIFF4hbEMZRvW2UgJv5OZrjnJ+6zNXjH5e0alWO9piGL05Jup9Q
	lTAg=
X-Gm-Gg: ASbGnctJaAc2dlktkVo1ZbgjytDc0hwO+PmjtLD2yfUOmHq/2L2hGvUIlWzQ0C3qkNo
	4vVDAXCphrn10pVqsoRWMJv4GRk9nPh+6YuR3DqBo5f4/adAhE1iCsAUdxqbQIfmSDPotZfcuDS
	rt4enLwg5OFMzXxpD5JIexaPEsM4PUg73NwjyjooyY+yzYt8mePZhu836Fn+HAsCtK/oUpLqZCv
	HSMXnhlFC+MI811dCAldAts/fQT0nuOggLBaGGwNwQwr4H4XtmDe5qvMxQSYx4/X+xVMh0e+d9g
	9MrG5SBO3Nn4fgdPcBvZOtw1+9PMWeIQ86IOwf05Ce7c6MHvH6YHHosSavf8UMU3dSSuAUdRzZN
	0dQjIKR9iCjhpDy+yp/uNu4gS7/W7jUk=
X-Google-Smtp-Source: AGHT+IH2dp4AJWArjlVIIU/chyew/o9wE/faTDJLfRHHkpsnsb+TRMbTKazQxQBeNjRrIES2+Pa0RQ==
X-Received: by 2002:a05:6602:29a9:b0:85b:46b5:6fb5 with SMTP id ca18e2360f4ac-8611c3ba34cmr1390830639f.11.1744061440585;
        Mon, 07 Apr 2025 14:30:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 03/29] rust-cross-canadian: set CC_<triple> for nativesdk
Date: Mon,  7 Apr 2025 17:29:52 -0400
Message-ID: <2f64f98a144b64588096d8af6b1683ffc9cbe0ca.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1303

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


