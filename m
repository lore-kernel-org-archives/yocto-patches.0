Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEC4C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:28 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.19377.1738174164102846388
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QZdV2rYF;
 spf=pass (domain: konsulko.com, ip: 209.85.166.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844e1020253so188963039f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174163; x=1738778963; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go4j396iuzLzLshqIeUliAKcswmPd3VfeaZ/OOF4N5g=;
        b=QZdV2rYFJNALuojoqEimiKxo7raoYD+BTxshhySzvwkq5DQFEmQLS5x/yPusRcQuq8
         qyLRAGomFdLZW6I+IpqmBGJvxIFxbhHHYiiLoCVNrT2YDD0s6vV87MVEHxSe+EOYpV7q
         TmJsWW++Venk10URZShK3rhBSn77aULesxd18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174163; x=1738778963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go4j396iuzLzLshqIeUliAKcswmPd3VfeaZ/OOF4N5g=;
        b=LV3iI1LR99dQziAQVKX/rFVsWjOV7U1628yT0Fy1IkPJPG0vaJu14saxby2I8z1qm6
         Hp4Hl4+49fnuahEogHVy7ZY/mxMQJ3Wt53FLMSEXr20RY1E6vbchSnIDIC98PqznFbjH
         F1bTI1Gn+gQqrUwv/wabX14mp1dbqku8/Trpx7hLnrVC9W8V37wgIfj3rmOcQa4hGmh7
         Spv6VX9ZO5t7W1+qn3ohBsLkXdbgLz9cJLB1uUPeeZSaH56d0SPZ3scr4UCnP9A6Qbln
         q8sX5QqgJSfh+A9ovTdGo/d8/2hpHYjreo67RtMiCH/qapOjxQRjJ41NvvcreYN74SEu
         dvtg==
X-Gm-Message-State: AOJu0YzszreX0SqkTpuEvBDRXKIT5WRWynXBRNQYdgLCARZoyMF8/PK2
	pzS6/jNtu/m6DGkZOplnWJPtVNU17tYCgXWAHC+yv5nh3cSQO0CnVpAvty4ItxOyw9ejEvZqSG9
	C
X-Gm-Gg: ASbGncvkAG8m2zZqQlPwXOE1pTIoXooLa3mM+Gnh1kY1uPzWjNBdyiQEbO8RAs4SjyT
	vTmo90GbtszmzRQ/LjIDpv4pQTTLnf3KEXnKUuZwyPXs1OxaUHZ+7LHKs6GrjXi3UjP9hfHnzBY
	KvzVpVfEdblHm1ZbObrf2u4+abknJuaG+IhcuCsQaayRoCPmEqGk4bU4/5tNZnnvij0LaAxpSR2
	SRRsAbFPQok+8P9KlUenWrKJBmEpln/H4YUax6R4juFRQ0pjommXLKG49w1GB8E4nmF8i1Rlc9+
	lwH4aorrfK1I7K6ynh3/z2hISOaJ2X/qiJpfVRmtrrghifQco1hh75XC0Nf/lcHSEeE=
X-Google-Smtp-Source: AGHT+IFpsdPzgk+6Pf13Gy49bfiRjKKA6Le9KObVI1V79+sh9ynz80lfXDp1WCeBA7sZSA14UGKi2Q==
X-Received: by 2002:a05:6602:2cc4:b0:84f:41e2:8087 with SMTP id ca18e2360f4ac-85427d78792mr445225839f.8.1738174162714;
        Wed, 29 Jan 2025 10:09:22 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 9/9] rust-common: add LDFLAGS to 'build-rust-cc' wrapper
Date: Wed, 29 Jan 2025 13:09:00 -0500
Message-ID: <1793a1b8fc92cf8688c72b7fd4181e3a2f5ade55.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1021

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

Although rust differs between compiling (--> 'rust-cc' wrapper) and
linking (--> 'rust-ccld' wrapper), some core crates are using only the
'rust-cc' wrapper to check for available compiler options [1] and
libraries [2].

Not having LDFLAGS can break the build in subtle ways.  E.g. 'cargo-native'
can fail to build with

|   = note: .../hosttools/ld: .../liblibz_sys-....rlib(deflate.o):
|     relocation R_X86_64_32S against hidden symbol `_length_code' can not be used when making a PIE object

because it does not find '-lz' (added by "DEPENDS = zlib") and builds
a static libz.a with missing PIC flags.

Add LDFLAGS to the 'build-rust-cc' wrapper as it is done already for
the target one.

[1] https://github.com/rust-lang/cc-rs/pull/1322

[2] https://github.com/rust-lang/libz-sys/blob/12a32798c6bd18986cb5cd603359b03c96f0eb4c/build.rs#L228-L234

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
(adapted from oe-core commit 49b37575b548f0ab082c700f91fdd856740dc829)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index 6940093..baa3869 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
@@ -173,7 +173,7 @@ do_rust_create_wrappers () {
 	mkdir -p "${WRAPPER_DIR}"
 
 	# Yocto Build / Rust Host C compiler
-	create_wrapper_rust "${RUST_BUILD_CC}" "" "${CRATE_CC_FLAGS}" "${BUILD_CC}"
+	create_wrapper_rust "${RUST_BUILD_CC}" "" "${CRATE_CC_FLAGS}" "${BUILD_CC}" "${BUILD_LDFLAGS}"
 	# Yocto Build / Rust Host C++ compiler
 	create_wrapper_rust "${RUST_BUILD_CXX}" "" "${CRATE_CC_FLAGS}" "${BUILD_CXX}"
 	# Yocto Build / Rust Host linker
-- 
2.48.1


