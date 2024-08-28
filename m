Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9BC71123
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web10.5980.1724875815518196492
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Uhbxt8EV;
 spf=pass (domain: konsulko.com, ip: 209.85.166.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82521c46feaso264348839f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875814; x=1725480614; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76KYmRudZ9nNusekrty2vJ+avw96ZEybT9pFYZteKig=;
        b=Uhbxt8EVx+OZuTNghzVzncaHaOSQEknHBldWOx3TL660/4OKVO/U4wLAUC/lcmQbAG
         zghdvndDdl1+w8t0/Ym2GOR+mUcFiGDNeJ4EFoIX9rGgCD9CcdenWyExXHVALmB2432p
         hRRZBzVr47Oi3vzuDos/RsvfRFl5BRsPGBGCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875814; x=1725480614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76KYmRudZ9nNusekrty2vJ+avw96ZEybT9pFYZteKig=;
        b=HX7U8xuiK1E+czUKEcLs6vKJ5iAymahrcpKcR9Furg3LPCo5mRd9j4N2BULD9MUaPR
         nlEJ7Bod0yKPD+jGRcXuMg9aoS0zzDOoWTFoZvahOM5RCVz5mmjcSQce0MkyXVWflvAF
         U1s16SvFIX1173ixppB0uIzuFvMndgQMSpuP1m0DVembChODL5bUOG9dhm9XgSWPucOw
         9E3Yd/uCzyq+l4wB6nia0WB8GjFdEIwJIUo5+ANyvko7B4G8LCMqmDg8aQKLmCEIWknc
         9+JeNzau5WMQdOmK/QqQt3kf9rVBfcO6v2VJZa5ibuNtd5xDCixr51K6tgo1/rdRElBv
         Aj5g==
X-Gm-Message-State: AOJu0Yy6nDddrNC4EHmoYWUTS6d9BXR2o0BZJMXDLLLOFTIP2wjbwH7F
	1xz7v07vZhCb/fCizWvcQNLki8onixP7VALOdLgbbozgNK9W4xIwQ0fN5HQ5FCc+qte3TW9zEIc
	d
X-Google-Smtp-Source: AGHT+IFAb8VNvLRqlVQuQchqWA+hROBMyJh+QN7/pSN9A+xpIKtxdcmra6g1cznDUgzwQM61rasEkA==
X-Received: by 2002:a05:6602:2b08:b0:825:2a43:27e7 with SMTP id ca18e2360f4ac-82a10e18e4emr123771439f.4.1724875814528;
        Wed, 28 Aug 2024 13:10:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:14 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 30/33] rust: Upgrade 1.77.1->1.77.2
Date: Wed, 28 Aug 2024 16:09:16 -0400
Message-ID: <b1cfa357ba4f046c9f739ceb357fe8a7971cc0d3.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/596

From: Yash Shinde <Yash.Shinde@windriver.com>

    https://blog.rust-lang.org/2024/04/09/Rust-1.77.2.html

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c3a996c3b06b11a5e2b07dbf820f3e3eb1e28782)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/{cargo_1.77.1.bb => cargo_1.77.2.bb}      | 0
 .../rust/{libstd-rs_1.77.1.bb => libstd-rs_1.77.2.bb}           | 0
 ...t-cross-canadian_1.77.1.bb => rust-cross-canadian_1.77.2.bb} | 0
 .../rust/{rust-llvm_1.77.1.bb => rust-llvm_1.77.2.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.77.1.bb => rust_1.77.2.bb}        | 0
 6 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/rust/{cargo_1.77.1.bb => cargo_1.77.2.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.77.1.bb => libstd-rs_1.77.2.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.77.1.bb => rust-cross-canadian_1.77.2.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.77.1.bb => rust-llvm_1.77.2.bb} (100%)
 rename recipes-devtools/rust/{rust_1.77.1.bb => rust_1.77.2.bb} (100%)

diff --git a/recipes-devtools/rust/cargo_1.77.1.bb b/recipes-devtools/rust/cargo_1.77.2.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.77.1.bb
rename to recipes-devtools/rust/cargo_1.77.2.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.77.1.bb b/recipes-devtools/rust/libstd-rs_1.77.2.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.77.1.bb
rename to recipes-devtools/rust/libstd-rs_1.77.2.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.77.1.bb b/recipes-devtools/rust/rust-cross-canadian_1.77.2.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.77.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.77.2.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.77.1.bb b/recipes-devtools/rust/rust-llvm_1.77.2.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.77.1.bb
rename to recipes-devtools/rust/rust-llvm_1.77.2.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index aafb595..efbfa72 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -14,7 +14,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "2ddc6f5e01df1bd6c7ff94d9931574181795a231b199ca6948d433fa5e795873"
+SRC_URI[rust.sha256sum] = "4d214c4189e4dd934d47e869fa5721b2c33dbbbdea21f2fc7fa6df3f38c1dea2"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.77.1.bb b/recipes-devtools/rust/rust_1.77.2.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.77.1.bb
rename to recipes-devtools/rust/rust_1.77.2.bb
-- 
2.46.0


