Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1949C7112F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web11.5853.1724875804432988655
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gKw9KJ2r;
 spf=pass (domain: konsulko.com, ip: 209.85.166.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-829e856a173so134150839f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875803; x=1725480603; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3KDaVMNVIASFZBoSQ5Zi81ZR/c7gekuzERD9hHPl/A=;
        b=gKw9KJ2r0dTyZKjKvImmcKEgx/mmwVvmE55MY5615rWuq2yz4JQuA9X/9HTR+TOz7X
         hQ+vb1lZWY0rYe61WY1pSeNLNhs3nqdfGz4Joa/CwpkGLuIf8Wa+likCoMvxjFNvJDpg
         KrYnFlUDm56cRlyAbgJFsf2pKtej0jJy6W8no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875803; x=1725480603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3KDaVMNVIASFZBoSQ5Zi81ZR/c7gekuzERD9hHPl/A=;
        b=NBgEjHtT3ICy4T6ixL2WTBv8c+gnrMItj930YNQPpbTRFa4h9HH3L82b2eu0JEfaiq
         yxJ/PbEiTJi7UneKZxH+VvvJSepp4Dqb0qtNwRPb2FuvRVIBoIrXvPE/c7KcqjxWAvsW
         d6H8pJJ5v1pTLLYRQtYnEQ3A3jk49V57GATNQ64/hCdrTfxmAKQeP2Ii7kEIoVIh9zNT
         6TXdn3B61ISXZ1wxdaQ+6pNORhmdyCdhMpgHVLh1tkr2JUahQn1Q9HoUGO8YD/cUmG0l
         k0ol/w425Y25XTaP2LfHoPnUBBVVN19uxVtm0dOT/Sed36p3lys5tqVlUixeIsK4J1z/
         4wag==
X-Gm-Message-State: AOJu0YyfsuRUEWsGVYPyFs88s8Eu1vsG84BKcfM+0HdOUI/K6BR1hk/X
	68DrpldwF6pLtxRsDdqnK0Ap+/OMA5sw/cYBNdYJJwgdOZzOXHpqSNrwgpzBLORtC6SxNWHlZTT
	7
X-Google-Smtp-Source: AGHT+IF1qzSUGWqvkGxElTydFn62KYRTqU7LnYRMcTJZ2XtgcwiSxEjKFNC4NgMcZtve86jiqqEDRA==
X-Received: by 2002:a05:6602:148a:b0:81f:c103:3e5d with SMTP id ca18e2360f4ac-82a1109b8e8mr67989739f.15.1724875803277;
        Wed, 28 Aug 2024 13:10:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 19/33]  libstd-rs,rust-cross-canadian: set CVE_PRODUCT to rust
Date: Wed, 28 Aug 2024 16:09:05 -0400
Message-ID: <294b35b405ba8865333935bfb7aa5adca063d600.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/585

From: Peter Marko <peter.marko@siemens.com>

These recipes come from rust sources and CVEs are reported for them
under rust-lang:rust vendor:product touple.
Especially libstd-rs needs correct CVE_PRODUCT as is it installed on
target devices (being statically linked to rust compiled binaries).

before:
cargo: CVE_PRODUCT="cargo"
cargo-c-native: CVE_PRODUCT="cargo-c"
libstd-rs: CVE_PRODUCT="libstd-rs"
rust: CVE_PRODUCT="rust"
rust-cross-canadian: CVE_PRODUCT="rust-cross-canadian-<arch>"
rust-llvm: CVE_PRODUCT="rust-llvm"

after:
cargo: CVE_PRODUCT="cargo"
cargo-c-native: CVE_PRODUCT="cargo-c"
libstd-rs: CVE_PRODUCT="rust"
rust: CVE_PRODUCT="rust"
rust-cross-canadian-x86-64: CVE_PRODUCT="rust"
rust-llvm: CVE_PRODUCT="rust-llvm"

Product for rust-llvm is uncertain and, should be handled in another
commit if it is desired to align it, too.

sqlite> select vendor, product, count(product) from products where vendor="rust-lang" group by product;
rust-lang|async-h1|2
rust-lang|cargo|5
rust-lang|future-utils|2
rust-lang|futures-task|2
rust-lang|mdbook|1
rust-lang|regex|2
rust-lang|rsa|2
rust-lang|rust|45
rust-lang|socket2|1

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit e8cf1df16a6ec2785cacaf608bec5cd8496103af)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.75.0.bb     | 2 ++
 recipes-devtools/rust/rust-cross-canadian.inc | 1 +
 2 files changed, 3 insertions(+)

diff --git a/recipes-devtools/rust/libstd-rs_1.75.0.bb b/recipes-devtools/rust/libstd-rs_1.75.0.bb
index d2bf266..fe016e7 100644
--- a/recipes-devtools/rust/libstd-rs_1.75.0.bb
+++ b/recipes-devtools/rust/libstd-rs_1.75.0.bb
@@ -15,6 +15,8 @@ S = "${RUSTSRC}/library/sysroot"
 RUSTLIB_DEP = ""
 inherit cargo
 
+CVE_PRODUCT = "rust"
+
 DEPENDS:append:libc-musl = " libunwind"
 # rv32 does not have libunwind ported yet
 DEPENDS:remove:riscv32 = "libunwind"
diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index 3096448..45cb402 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -1,5 +1,6 @@
 SUMMARY = "Rust compiler and runtime libaries (cross-canadian for ${TARGET_ARCH} target)"
 PN = "rust-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+CVE_PRODUCT = "rust"
 
 inherit rust-target-config
 inherit rust-common
-- 
2.46.0


