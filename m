Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14168CAC58F
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:30 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.2987.1757443461123378072
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bgPBMFBr;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8127215a4c6so400794685a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443460; x=1758048260; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzBlNufTl0TaEKLHMFZzF6/VAEW0fVj/wjNdWBjg43o=;
        b=bgPBMFBrUI6CfxXt3vxNXkRGM0rdurOns6OE/+lxbkRHexQkX41/+FpuJ1dYbifX+/
         OAQKPUt8zd5q1aKcS7WeLzsTU6Gv656HQXiHv52wNcUHZhFo73B5VfFsGY2nSUt5M1T+
         09AR1tKe4XKUWq7SMubcjw60F++5hqqAX/UC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443460; x=1758048260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzBlNufTl0TaEKLHMFZzF6/VAEW0fVj/wjNdWBjg43o=;
        b=jl4DxJi6XIl/Trhi0NR0/vouxWn/mHcwNGE6UKK5k4IltnLC6ulRB2JOQfa2T4kEq0
         Xd+5QBYIonVXdNYu5uBMpQgtz0JPPZl2Q18zbKNaDZsm3Enb8au0rRlfqinHDPKiove6
         NP6FJxHojZ5oFX6eBBl3dr3SztilhFjPYm9RMC/0G6nertzbpBbH+xF3txVrQwUrSfuB
         sYboUoevPD5+e9ooxD5yFK0k5L+JxCXyjugKtPJojfWTOPwcibaJV+mVOUUXDAtISV5n
         mqsIiY5LohwnNpEzvR7d+/FPVS2847vAYt5ePnmvq67boutAj3GNJVz32RjuYw4h1LDh
         ywcQ==
X-Gm-Message-State: AOJu0Yxz90DI68gKqe1HmU7AJaWwrpS5yIAFoKv4AKS0R0eKH+j42VHt
	4df+pw9rfW1GPvuXiVyWslpvFaFWHmf2FLPhgilK/sKnX8aThzU6GJXBLL6GgboEipA4WVpFUkM
	aj+Sc
X-Gm-Gg: ASbGncvkpUA7+WKXxhQofIVnUmxOMsssaI5s3oSaqNFx90UP/G6D9b6qVMqAId/tRut
	hW0yf6JNsXl2kTQXGsGaBcvnd0KXPZYcPMZYU19JJWwpM8qaXZadQsSlggMOvidg2pzPpxfqekg
	hAxYsiDoA5t6aSjga9HwJ6hspoZxwyvBAyJE94Fwbp/J2FJL3TDSRgqI8Qn2jkok1K73R0KTcLs
	P0LfV5wgXho119anvTRJWirXn+wwnQQwx+tiZF8xv9qtWa3gu6V862HHOCA7XTIK8a4TFyhtqOu
	0+K01R6HvoKFhPuTAwxyhyXphMVNN56lJOoAZTknqLbE7xFTZr6sMjE5HMPUoKhxrbhuewpV2if
	nd2kFi0aZKtazzcIqI3GeOFBSSJ1aJe383kOT8X0jsoLRTnxPwxUGtpKDYa7X+HQRCFUeKor6f3
	uzVIxSA4Pc
X-Google-Smtp-Source: AGHT+IFG9PRJj4hJnOsAli3ExVpUIqMkI6ladtV4cUbFCSFrS4g6B0zpSiawDZTZ0fCrdUQ/jF1HJQ==
X-Received: by 2002:a05:620a:1923:b0:817:77a7:35b with SMTP id af79cd13be357-81777a7071cmr993668985a.15.1757443459814;
        Tue, 09 Sep 2025 11:44:19 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:19 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 6/9] rust-target-config: fix nativesdk-libstd-rs build with baremetal
Date: Tue,  9 Sep 2025 14:43:59 -0400
Message-ID: <60da766fff56c9c6e1265aaaf47ae516e913c6fc.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2163

From: Ovidiu Panait <ovidiu.panait@windriver.com>

If TCLIBC='baremetal' is set in local.conf, nativesdk-libstd-rs build fails
with:

| error[E0412]: cannot find type `c_char` in the crate root
|   --> /usr/src/debug/libstd-rs/1.75.0/rustc-1.75.0-src/vendor/libc/src/unix/mod.rs:56:29
|    |
| 6  | pub type c_schar = i8;
|    | ---------------------- similarly named type alias `c_schar` defined here
| ...
| 56 |         pub gr_name: *mut ::c_char,
|    |                             ^^^^^^

This happens because rust_gen_target() sets os="none" when TCLIBC is
'baremetal' - even for nativesdk targets. However, nativesdk packages are
built against glibc, so the correct 'os' value should be "linux".

Fix this by setting the os field based on {TARGET,HOST,BUILD}_OS variables,
as it is already done in rust_base_triple(), instead of relying on TCLIBC.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3eaf2cd5647585a1e6df03fc20e2753da27bb692)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index feaec6a..b027dd5 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -332,6 +332,7 @@ def rust_gen_target(d, thing, wd, arch):
     sys = d.getVar('{}_SYS'.format(thing))
     prefix = d.getVar('{}_PREFIX'.format(thing))
     rustsys = d.getVar('RUST_{}_SYS'.format(thing))
+    os = d.getVar('{}_OS'.format(thing))
 
     abi = None
     cpu = "generic"
@@ -371,7 +372,7 @@ def rust_gen_target(d, thing, wd, arch):
     tspec['target-c-int-width'] = d.getVarFlag('TARGET_C_INT_WIDTH', arch_abi)
     tspec['target-endian'] = d.getVarFlag('TARGET_ENDIAN', arch_abi)
     tspec['arch'] = arch_to_rust_target_arch(rust_arch)
-    if "baremetal" in d.getVar('TCLIBC'):
+    if "elf" in os:
         tspec['os'] = "none"
     else:
         tspec['os'] = "linux"
-- 
2.50.1


