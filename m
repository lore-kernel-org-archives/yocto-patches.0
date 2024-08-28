Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68249C6FD3A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.5863.1724875814716960859
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j+IYej8X;
 spf=pass (domain: konsulko.com, ip: 209.85.166.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8f0198beso351849539f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875814; x=1725480614; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ijM3vPOdxRB/aC2AHTrb9gEcY3z7twcyo9pHjLA4E4=;
        b=j+IYej8XAc0/XiXhxOryB1YhvNDeM3K5V8BHfurm3qW/Qkip9vgcG1UTsYUrH3Ad+0
         skbdyog2Ygo14fncXMP/cwULUM8G0pwinLvx1CwWYWhCrL3yjMuobI1N227/QbSaDbrd
         dD+elalR42mfs/0qi+0/13EZNDcxqPDMooci8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875814; x=1725480614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ijM3vPOdxRB/aC2AHTrb9gEcY3z7twcyo9pHjLA4E4=;
        b=oQP75KHtyYB981U96InSSlJ2lfFOw7NEVl0+uMAk13qBDp4KhdqvBBncy1kn2hXIwX
         djkzpJVUuaF3BTxIXA5/424r0zyw/vFCDjJOnNyQVMo4aFVstxbKdPuuOVkS+/lg1zLy
         3iaAKyrCEu8S1PEJ86kJYS7n4xLGYb4IE25odi9nJfWONnFg9Qd22Ih7UjYjJ+1nMrv+
         mB0b6kZdV/XgLCOnyhiNky4vGRsHY7vp4KhSJqB0rATDc1ZBNI12SMB5drQG5h3BdjSw
         r/NNb0IqcevP2LYgIfv6ZPrRcYCqaKNrMbzm5JrYi+Tekl9Hq4wKkYkfMCahuqICo56N
         imyg==
X-Gm-Message-State: AOJu0YzyGA2Rxn2LGQ9if3P/pXOegkfcjZktPOfInb41i2D+9V5qFuer
	Y7Ve6vTzM8IlZiyTozcY/FQe/mMXDp8EqeVq4Z0gMXZ8x8uap3laWhC0iHT0SKKjbiq6xVYu8fE
	f
X-Google-Smtp-Source: AGHT+IEPIniF2HsFZ+kPTQw1rwANrnrEx71o2Q/LAxl6gjXM5vw0GxnFkOiEnHiPHcHIzJnXHFwaKQ==
X-Received: by 2002:a05:6602:1654:b0:81f:92b6:8235 with SMTP id ca18e2360f4ac-82a1102b872mr84170139f.6.1724875813694;
        Wed, 28 Aug 2024 13:10:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 29/33] rust: Upgrade 1.77.0->1.77.1
Date: Wed, 28 Aug 2024 16:09:15 -0400
Message-ID: <5ea0e65a171fd5059bbc5593c12bc8b4b375a320.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/595

From: Yash Shinde <Yash.Shinde@windriver.com>

    https://blog.rust-lang.org/2024/03/28/Rust-1.77.1.html

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a7ca97ffbb23602ad79c3dc1819cfedd0b969075)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/{cargo_1.77.0.bb => cargo_1.77.1.bb}      | 0
 .../rust/{libstd-rs_1.77.0.bb => libstd-rs_1.77.1.bb}           | 0
 ...t-cross-canadian_1.77.0.bb => rust-cross-canadian_1.77.1.bb} | 0
 .../rust/{rust-llvm_1.77.0.bb => rust-llvm_1.77.1.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.77.0.bb => rust_1.77.1.bb}        | 0
 6 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/rust/{cargo_1.77.0.bb => cargo_1.77.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.77.0.bb => libstd-rs_1.77.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.77.0.bb => rust-cross-canadian_1.77.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.77.0.bb => rust-llvm_1.77.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.77.0.bb => rust_1.77.1.bb} (100%)

diff --git a/recipes-devtools/rust/cargo_1.77.0.bb b/recipes-devtools/rust/cargo_1.77.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.77.0.bb
rename to recipes-devtools/rust/cargo_1.77.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.77.0.bb b/recipes-devtools/rust/libstd-rs_1.77.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.77.0.bb
rename to recipes-devtools/rust/libstd-rs_1.77.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.77.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.77.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.77.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.77.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.77.0.bb b/recipes-devtools/rust/rust-llvm_1.77.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.77.0.bb
rename to recipes-devtools/rust/rust-llvm_1.77.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 27d74fe..aafb595 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -14,7 +14,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "66126989782cbf77fa3aff121bbb108429f2d46fe19328c3de231553de711b90"
+SRC_URI[rust.sha256sum] = "2ddc6f5e01df1bd6c7ff94d9931574181795a231b199ca6948d433fa5e795873"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.77.0.bb b/recipes-devtools/rust/rust_1.77.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.77.0.bb
rename to recipes-devtools/rust/rust_1.77.1.bb
-- 
2.46.0


