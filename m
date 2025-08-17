Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE7CA0EED
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:29:51 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.57123.1755451789717511387
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WFgVI+qW;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b113500aebso24001071cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451788; x=1756056588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRt/nbTg04bFJmIuGvDEHwitCWyplPLlInvAIbWCv+U=;
        b=WFgVI+qWhbO5xT21M8YzI2k6THg5w6FQ1WhyyT88w9nAyB/aZ/1lizi1LmtnOcoByE
         DyVgUd4Re2NYrlVXcpX+Kt/SsOnR5sqlFNlMuYi5XOb3L2ptadatVCdn7We/T9Gyes56
         ljk4Vkg7+t2y46PVPPJ9+0JBY4iyDN5/9cjrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451788; x=1756056588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRt/nbTg04bFJmIuGvDEHwitCWyplPLlInvAIbWCv+U=;
        b=HOiHdinixaE4+DwwaUVjB0ZDTs1O6uk96xsbzK1+kl295Cj9m2hwBD3LeZI5JXOKa/
         4gyuoFWHxJj5xSuCsErAsqSXk+Mhtm0lZ6jDeY5+ZjapoytivCs422lUNgzGYsKgUitL
         8wuHK+fyyQXbYepmEMuVpM3lTJa00sXEsa3al7+3eJS1kKNX2ndLuBFpKp1eTLNQbKUy
         oueediE09zHHfi86MVt8EFW8t9VYVqukgjFAlmigJozL8MrEJ6yj6giLQQ1tB9czeQPj
         x8FTABKpx1T6AAUh2kqkslZc2JIYkSe30YXnhUgv6Xe7yFI103LMyJE0KHwayS3o3HZ/
         AsGg==
X-Gm-Message-State: AOJu0Yza8KPSNAfQGQMa8q7ffb33xo2/e34hk83jnCTe3tQwOaFnQbvM
	w6jxfNYWajjNaW5QER7d7uofNuLxycnfhuBDUEK3mbMpuVn29pEejo0JwHZIm0qTdjuxXPE1Mqk
	2q09f
X-Gm-Gg: ASbGnctZDVSY9ala/K5NpUAgQv1U/HBNJlrZvNAAtbP7Ux9Ox3Z5mpWtL7D8vqG9X3B
	/yVdrlQXkRRFhg+eTet3dsI1ZaHKnihKwJk3SpcmBoCPsb5sdHyWloNgSq7R2ZJHdFTIx+06h/B
	2hMjLHMQxsbkEq+qNMgpR1jlKIgTrmFL5fnlOtXphV+S0yIX+H94WqDqYciydTZovYDzs013gAu
	yC4RQ7y26AV5pSw2zCOA6mwy5CKkN9KvD33mp8810X6slJqNqb795lyVotAtwJZqe0HFu6uPWfZ
	nQTe6a8nRBJOSgHyfI7WD7AVgUoZTO8onbe4vqHRtirrqrchDamtY9WdxGMCnevFcNLaWyGwaNS
	yRxSBOTYxe/oJFhchxYh5Glnj7zS1J3bX4siS++h0ZvpbXH0jF+A2D5Z7HG/Lb0KP1R+TdLh/Vw
	==
X-Google-Smtp-Source: AGHT+IECTMIizr3VKnmOSJoJLlA9tCLqjIfgLt2jzT487uDSPujJnWJXNG7eugkZz0wqoseHhcq8CA==
X-Received: by 2002:ac8:7f8a:0:b0:4b0:65cc:f642 with SMTP id d75a77b69052e-4b11e12bc82mr148445841cf.22.1755451786965;
        Sun, 17 Aug 2025 10:29:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 2/7] cargo-c: Upgrade to 0.10.14+cargo-0.89.0
Date: Sun, 17 Aug 2025 13:29:26 -0400
Message-ID: <3f402f6fd74edfab22a8c0518e1ee4a6c46e2e83.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2007

From: Khem Raj <raj.khem@gmail.com>

Fix build on riscv32 while here.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 34b07ad6330173fc8319b8db69410cf72af48395)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c-crates.inc      | 498 +++++++++---------
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |  53 ++
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |  66 +++
 ...8.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} |   7 +-
 4 files changed, 386 insertions(+), 238 deletions(-)
 create mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
 create mode 100644 recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
 rename recipes-devtools/rust/{cargo-c_0.10.13+cargo-0.88.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} (50%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/rust/cargo-c-crates.inc
index ab0b0d0..c7d333c 100644
--- a/recipes-devtools/rust/cargo-c-crates.inc
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -2,57 +2,58 @@
 
 # from Cargo.lock
 SRC_URI += " \
-    crate://crates.io/adler2/2.0.0 \
+    crate://crates.io/adler2/2.0.1 \
     crate://crates.io/ahash/0.8.12 \
     crate://crates.io/aho-corasick/1.1.3 \
     crate://crates.io/allocator-api2/0.2.21 \
     crate://crates.io/annotate-snippets/0.11.5 \
-    crate://crates.io/anstream/0.6.18 \
-    crate://crates.io/anstyle/1.0.10 \
-    crate://crates.io/anstyle-parse/0.2.6 \
-    crate://crates.io/anstyle-query/1.1.2 \
-    crate://crates.io/anstyle-wincon/3.0.7 \
+    crate://crates.io/anstream/0.6.19 \
+    crate://crates.io/anstyle/1.0.11 \
+    crate://crates.io/anstyle-parse/0.2.7 \
+    crate://crates.io/anstyle-query/1.1.3 \
+    crate://crates.io/anstyle-wincon/3.0.9 \
     crate://crates.io/anyhow/1.0.98 \
     crate://crates.io/arc-swap/1.7.1 \
     crate://crates.io/arrayref/0.3.9 \
     crate://crates.io/arrayvec/0.7.6 \
-    crate://crates.io/autocfg/1.4.0 \
+    crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
-    crate://crates.io/base64ct/1.7.3 \
+    crate://crates.io/base64ct/1.8.0 \
     crate://crates.io/bitflags/2.9.1 \
     crate://crates.io/bitmaps/2.1.0 \
     crate://crates.io/blake3/1.8.2 \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/bstr/1.12.0 \
-    crate://crates.io/bumpalo/3.17.0 \
+    crate://crates.io/bumpalo/3.19.0 \
+    crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.10.1 \
-    crate://crates.io/cargo/0.88.0 \
+    crate://crates.io/cargo/0.89.0 \
     crate://crates.io/cargo-credential/0.4.8 \
-    crate://crates.io/cargo-credential-libsecret/0.4.13 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.13 \
-    crate://crates.io/cargo-credential-wincred/0.4.13 \
-    crate://crates.io/cargo-platform/0.2.0 \
-    crate://crates.io/cargo-util/0.2.20 \
-    crate://crates.io/cargo-util-schemas/0.8.1 \
-    crate://crates.io/cbindgen/0.28.0 \
-    crate://crates.io/cc/1.2.22 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/4.5.38 \
-    crate://crates.io/clap_builder/4.5.38 \
-    crate://crates.io/clap_complete/4.5.50 \
-    crate://crates.io/clap_derive/4.5.32 \
-    crate://crates.io/clap_lex/0.7.4 \
+    crate://crates.io/cargo-credential-libsecret/0.4.14 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.14 \
+    crate://crates.io/cargo-credential-wincred/0.4.14 \
+    crate://crates.io/cargo-platform/0.3.0 \
+    crate://crates.io/cargo-util/0.2.21 \
+    crate://crates.io/cargo-util-schemas/0.8.2 \
+    crate://crates.io/cbindgen/0.29.0 \
+    crate://crates.io/cc/1.2.27 \
+    crate://crates.io/cfg-if/1.0.1 \
+    crate://crates.io/clap/4.5.40 \
+    crate://crates.io/clap_builder/4.5.40 \
+    crate://crates.io/clap_complete/4.5.54 \
+    crate://crates.io/clap_derive/4.5.40 \
+    crate://crates.io/clap_lex/0.7.5 \
     crate://crates.io/clru/0.6.2 \
     crate://crates.io/color-print/0.3.7 \
     crate://crates.io/color-print-proc-macro/0.3.7 \
-    crate://crates.io/colorchoice/1.0.3 \
+    crate://crates.io/colorchoice/1.0.4 \
     crate://crates.io/const-oid/0.9.6 \
     crate://crates.io/constant_time_eq/0.3.1 \
-    crate://crates.io/core-foundation/0.10.0 \
+    crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crates-io/0.40.10 \
+    crate://crates.io/crates-io/0.40.11 \
     crate://crates.io/crc32fast/1.4.2 \
     crate://crates.io/crossbeam-channel/0.5.15 \
     crate://crates.io/crossbeam-deque/0.8.6 \
@@ -60,9 +61,9 @@ SRC_URI += " \
     crate://crates.io/crossbeam-utils/0.8.21 \
     crate://crates.io/crypto-bigint/0.5.5 \
     crate://crates.io/crypto-common/0.1.6 \
-    crate://crates.io/ct-codecs/1.1.5 \
-    crate://crates.io/curl/0.4.47 \
-    crate://crates.io/curl-sys/0.4.80+curl-8.12.1 \
+    crate://crates.io/ct-codecs/1.1.6 \
+    crate://crates.io/curl/0.4.48 \
+    crate://crates.io/curl-sys/0.4.82+curl-8.14.1 \
     crate://crates.io/dbus/0.9.7 \
     crate://crates.io/der/0.7.10 \
     crate://crates.io/deranged/0.4.0 \
@@ -76,15 +77,16 @@ SRC_URI += " \
     crate://crates.io/encoding_rs/0.8.35 \
     crate://crates.io/equivalent/1.0.2 \
     crate://crates.io/erased-serde/0.4.6 \
-    crate://crates.io/errno/0.3.12 \
+    crate://crates.io/errno/0.3.13 \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
     crate://crates.io/faster-hex/0.9.0 \
+    crate://crates.io/faster-hex/0.10.0 \
     crate://crates.io/fastrand/2.3.0 \
     crate://crates.io/ff/0.13.1 \
-    crate://crates.io/fiat-crypto/0.2.9 \
+    crate://crates.io/fiat-crypto/0.3.0 \
     crate://crates.io/filetime/0.2.25 \
-    crate://crates.io/flate2/1.1.1 \
+    crate://crates.io/flate2/1.1.2 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/foldhash/0.1.5 \
     crate://crates.io/foreign-types/0.3.2 \
@@ -95,63 +97,68 @@ SRC_URI += " \
     crate://crates.io/getrandom/0.3.3 \
     crate://crates.io/git2/0.20.2 \
     crate://crates.io/git2-curl/0.21.0 \
-    crate://crates.io/gix/0.70.0 \
-    crate://crates.io/gix-actor/0.33.2 \
-    crate://crates.io/gix-attributes/0.24.0 \
+    crate://crates.io/gix/0.71.0 \
+    crate://crates.io/gix-actor/0.34.0 \
+    crate://crates.io/gix-attributes/0.25.0 \
     crate://crates.io/gix-bitmap/0.2.14 \
     crate://crates.io/gix-chunk/0.4.11 \
-    crate://crates.io/gix-command/0.4.1 \
-    crate://crates.io/gix-commitgraph/0.26.0 \
-    crate://crates.io/gix-config/0.43.0 \
+    crate://crates.io/gix-command/0.5.0 \
+    crate://crates.io/gix-commitgraph/0.27.0 \
+    crate://crates.io/gix-config/0.44.0 \
     crate://crates.io/gix-config-value/0.14.12 \
-    crate://crates.io/gix-credentials/0.27.0 \
+    crate://crates.io/gix-credentials/0.28.0 \
     crate://crates.io/gix-date/0.9.4 \
-    crate://crates.io/gix-diff/0.50.0 \
-    crate://crates.io/gix-dir/0.12.0 \
-    crate://crates.io/gix-discover/0.38.0 \
-    crate://crates.io/gix-features/0.40.0 \
-    crate://crates.io/gix-filter/0.17.0 \
-    crate://crates.io/gix-fs/0.13.0 \
-    crate://crates.io/gix-glob/0.18.0 \
-    crate://crates.io/gix-hash/0.16.0 \
-    crate://crates.io/gix-hashtable/0.7.0 \
-    crate://crates.io/gix-ignore/0.13.0 \
-    crate://crates.io/gix-index/0.38.0 \
-    crate://crates.io/gix-lock/16.0.0 \
-    crate://crates.io/gix-negotiate/0.18.0 \
-    crate://crates.io/gix-object/0.47.0 \
-    crate://crates.io/gix-odb/0.67.0 \
-    crate://crates.io/gix-pack/0.57.0 \
+    crate://crates.io/gix-diff/0.51.0 \
+    crate://crates.io/gix-dir/0.13.0 \
+    crate://crates.io/gix-discover/0.39.0 \
+    crate://crates.io/gix-features/0.41.1 \
+    crate://crates.io/gix-features/0.42.1 \
+    crate://crates.io/gix-filter/0.18.0 \
+    crate://crates.io/gix-fs/0.14.0 \
+    crate://crates.io/gix-fs/0.15.0 \
+    crate://crates.io/gix-glob/0.19.0 \
+    crate://crates.io/gix-hash/0.17.0 \
+    crate://crates.io/gix-hash/0.18.0 \
+    crate://crates.io/gix-hashtable/0.8.1 \
+    crate://crates.io/gix-ignore/0.14.0 \
+    crate://crates.io/gix-index/0.39.0 \
+    crate://crates.io/gix-lock/17.1.0 \
+    crate://crates.io/gix-negotiate/0.19.0 \
+    crate://crates.io/gix-object/0.48.0 \
+    crate://crates.io/gix-odb/0.68.0 \
+    crate://crates.io/gix-pack/0.58.0 \
     crate://crates.io/gix-packetline/0.18.4 \
     crate://crates.io/gix-packetline-blocking/0.18.3 \
     crate://crates.io/gix-path/0.10.18 \
-    crate://crates.io/gix-pathspec/0.9.0 \
-    crate://crates.io/gix-prompt/0.9.1 \
-    crate://crates.io/gix-protocol/0.48.0 \
-    crate://crates.io/gix-quote/0.4.15 \
-    crate://crates.io/gix-ref/0.50.0 \
-    crate://crates.io/gix-refspec/0.28.0 \
-    crate://crates.io/gix-revision/0.32.0 \
-    crate://crates.io/gix-revwalk/0.18.0 \
+    crate://crates.io/gix-pathspec/0.10.0 \
+    crate://crates.io/gix-prompt/0.10.0 \
+    crate://crates.io/gix-protocol/0.49.0 \
+    crate://crates.io/gix-quote/0.5.0 \
+    crate://crates.io/gix-ref/0.51.0 \
+    crate://crates.io/gix-refspec/0.29.0 \
+    crate://crates.io/gix-revision/0.33.0 \
+    crate://crates.io/gix-revwalk/0.19.0 \
     crate://crates.io/gix-sec/0.10.12 \
-    crate://crates.io/gix-shallow/0.2.0 \
-    crate://crates.io/gix-submodule/0.17.0 \
-    crate://crates.io/gix-tempfile/16.0.0 \
+    crate://crates.io/gix-shallow/0.3.0 \
+    crate://crates.io/gix-submodule/0.18.0 \
+    crate://crates.io/gix-tempfile/17.1.0 \
     crate://crates.io/gix-trace/0.1.12 \
-    crate://crates.io/gix-transport/0.45.0 \
-    crate://crates.io/gix-traverse/0.44.0 \
-    crate://crates.io/gix-url/0.29.0 \
-    crate://crates.io/gix-utils/0.1.14 \
+    crate://crates.io/gix-transport/0.46.0 \
+    crate://crates.io/gix-traverse/0.45.0 \
+    crate://crates.io/gix-url/0.30.0 \
+    crate://crates.io/gix-utils/0.2.0 \
+    crate://crates.io/gix-utils/0.3.0 \
     crate://crates.io/gix-validate/0.9.4 \
     crate://crates.io/gix-validate/0.10.0 \
-    crate://crates.io/gix-worktree/0.39.0 \
+    crate://crates.io/gix-worktree/0.40.0 \
     crate://crates.io/glob/0.3.2 \
     crate://crates.io/globset/0.4.16 \
     crate://crates.io/group/0.13.0 \
+    crate://crates.io/hash32/0.3.1 \
     crate://crates.io/hashbrown/0.14.5 \
-    crate://crates.io/hashbrown/0.15.3 \
+    crate://crates.io/hashbrown/0.15.4 \
     crate://crates.io/hashlink/0.10.0 \
-    crate://crates.io/heck/0.4.1 \
+    crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
     crate://crates.io/hex/0.4.3 \
     crate://crates.io/hkdf/0.12.4 \
@@ -162,21 +169,21 @@ SRC_URI += " \
     crate://crates.io/icu_locale_core/2.0.0 \
     crate://crates.io/icu_normalizer/2.0.0 \
     crate://crates.io/icu_normalizer_data/2.0.0 \
-    crate://crates.io/icu_properties/2.0.0 \
-    crate://crates.io/icu_properties_data/2.0.0 \
+    crate://crates.io/icu_properties/2.0.1 \
+    crate://crates.io/icu_properties_data/2.0.1 \
     crate://crates.io/icu_provider/2.0.0 \
     crate://crates.io/idna/1.0.3 \
     crate://crates.io/idna_adapter/1.2.1 \
     crate://crates.io/ignore/0.4.23 \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/implib/0.3.5 \
-    crate://crates.io/indexmap/2.9.0 \
+    crate://crates.io/indexmap/2.10.0 \
     crate://crates.io/is_executable/1.0.4 \
     crate://crates.io/is_terminal_polyfill/1.70.1 \
     crate://crates.io/itertools/0.14.0 \
     crate://crates.io/itoa/1.0.15 \
-    crate://crates.io/jiff/0.2.13 \
-    crate://crates.io/jiff-static/0.2.13 \
+    crate://crates.io/jiff/0.2.15 \
+    crate://crates.io/jiff-static/0.2.15 \
     crate://crates.io/jiff-tzdb/0.1.4 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.33 \
@@ -184,27 +191,28 @@ SRC_URI += " \
     crate://crates.io/kstring/2.0.2 \
     crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/lazycell/1.3.0 \
-    crate://crates.io/libc/0.2.172 \
+    crate://crates.io/libc/0.2.174 \
     crate://crates.io/libdbus-sys/0.2.5 \
-    crate://crates.io/libgit2-sys/0.18.1+1.9.0 \
-    crate://crates.io/libloading/0.8.7 \
+    crate://crates.io/libgit2-sys/0.18.2+1.9.1 \
+    crate://crates.io/libloading/0.8.8 \
     crate://crates.io/libnghttp2-sys/0.1.11+1.64.0 \
-    crate://crates.io/libredox/0.1.3 \
-    crate://crates.io/libsqlite3-sys/0.31.0 \
+    crate://crates.io/libredox/0.1.4 \
+    crate://crates.io/libsqlite3-sys/0.32.0 \
     crate://crates.io/libssh2-sys/0.3.1 \
+    crate://crates.io/libz-rs-sys/0.5.1 \
     crate://crates.io/libz-sys/1.1.22 \
     crate://crates.io/linux-raw-sys/0.4.15 \
     crate://crates.io/linux-raw-sys/0.9.4 \
     crate://crates.io/litemap/0.8.0 \
-    crate://crates.io/lock_api/0.4.12 \
+    crate://crates.io/lock_api/0.4.13 \
     crate://crates.io/log/0.4.27 \
     crate://crates.io/matchers/0.1.0 \
     crate://crates.io/maybe-async/0.2.10 \
-    crate://crates.io/memchr/2.7.4 \
+    crate://crates.io/memchr/2.7.5 \
     crate://crates.io/memmap2/0.9.5 \
     crate://crates.io/memoffset/0.9.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.8.8 \
+    crate://crates.io/miniz_oxide/0.8.9 \
     crate://crates.io/miow/0.6.0 \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normpath/1.3.0 \
@@ -212,28 +220,31 @@ SRC_URI += " \
     crate://crates.io/num-conv/0.1.0 \
     crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/object/0.36.7 \
+    crate://crates.io/object/0.37.1 \
     crate://crates.io/once_cell/1.21.3 \
+    crate://crates.io/once_cell_polyfill/1.70.1 \
     crate://crates.io/opener/0.7.2 \
-    crate://crates.io/openssl/0.10.57 \
+    crate://crates.io/openssl/0.10.73 \
     crate://crates.io/openssl-macros/0.1.1 \
     crate://crates.io/openssl-probe/0.1.6 \
     crate://crates.io/openssl-src/300.5.0+3.5.0 \
-    crate://crates.io/openssl-sys/0.9.108 \
+    crate://crates.io/openssl-sys/0.9.109 \
     crate://crates.io/ordered-float/2.10.1 \
-    crate://crates.io/orion/0.17.10 \
-    crate://crates.io/os_info/3.11.0 \
+    crate://crates.io/orion/0.17.11 \
+    crate://crates.io/os_info/3.12.0 \
     crate://crates.io/overload/0.1.1 \
     crate://crates.io/p384/0.13.1 \
-    crate://crates.io/parking_lot/0.12.3 \
-    crate://crates.io/parking_lot_core/0.9.10 \
-    crate://crates.io/pasetors/0.7.4 \
+    crate://crates.io/parking_lot/0.12.4 \
+    crate://crates.io/parking_lot_core/0.9.11 \
+    crate://crates.io/pasetors/0.7.6 \
     crate://crates.io/pathdiff/0.2.3 \
     crate://crates.io/pem-rfc7468/0.7.0 \
     crate://crates.io/percent-encoding/2.3.1 \
     crate://crates.io/pin-project-lite/0.2.16 \
     crate://crates.io/pkcs8/0.10.2 \
     crate://crates.io/pkg-config/0.3.32 \
-    crate://crates.io/portable-atomic/1.11.0 \
+    crate://crates.io/plist/1.7.2 \
+    crate://crates.io/portable-atomic/1.11.1 \
     crate://crates.io/portable-atomic-util/0.2.4 \
     crate://crates.io/potential_utf/0.1.2 \
     crate://crates.io/powerfmt/0.2.0 \
@@ -241,24 +252,25 @@ SRC_URI += " \
     crate://crates.io/primeorder/0.13.6 \
     crate://crates.io/proc-macro2/1.0.95 \
     crate://crates.io/prodash/29.0.2 \
+    crate://crates.io/quick-xml/0.37.5 \
     crate://crates.io/quote/1.0.40 \
-    crate://crates.io/r-efi/5.2.0 \
+    crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/rand/0.9.1 \
     crate://crates.io/rand_chacha/0.9.0 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.9.3 \
     crate://crates.io/rand_xoshiro/0.6.0 \
-    crate://crates.io/redox_syscall/0.5.12 \
+    crate://crates.io/redox_syscall/0.5.13 \
     crate://crates.io/regex/1.11.1 \
     crate://crates.io/regex-automata/0.1.10 \
     crate://crates.io/regex-automata/0.4.9 \
     crate://crates.io/regex-syntax/0.6.29 \
     crate://crates.io/regex-syntax/0.8.5 \
     crate://crates.io/rfc6979/0.4.0 \
-    crate://crates.io/rusqlite/0.33.0 \
+    crate://crates.io/rusqlite/0.34.0 \
     crate://crates.io/rustc-hash/2.1.1 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
-    crate://crates.io/rustfix/0.9.0 \
+    crate://crates.io/rustfix/0.9.1 \
     crate://crates.io/rustix/0.38.44 \
     crate://crates.io/rustix/1.0.7 \
     crate://crates.io/ryu/1.0.20 \
@@ -275,9 +287,9 @@ SRC_URI += " \
     crate://crates.io/serde_derive/1.0.219 \
     crate://crates.io/serde_ignored/0.1.12 \
     crate://crates.io/serde_json/1.0.140 \
-    crate://crates.io/serde_spanned/0.6.8 \
+    crate://crates.io/serde_spanned/0.6.9 \
     crate://crates.io/sha1/0.10.6 \
-    crate://crates.io/sha1_smol/1.0.1 \
+    crate://crates.io/sha1-checked/0.10.0 \
     crate://crates.io/sha2/0.10.9 \
     crate://crates.io/sharded-slab/0.1.7 \
     crate://crates.io/shell-escape/0.1.5 \
@@ -285,8 +297,8 @@ SRC_URI += " \
     crate://crates.io/shlex/1.3.0 \
     crate://crates.io/signature/2.2.0 \
     crate://crates.io/sized-chunks/0.6.5 \
-    crate://crates.io/smallvec/1.15.0 \
-    crate://crates.io/socket2/0.5.9 \
+    crate://crates.io/smallvec/1.15.1 \
+    crate://crates.io/socket2/0.5.10 \
     crate://crates.io/spki/0.7.3 \
     crate://crates.io/stable_deref_trait/1.2.0 \
     crate://crates.io/static_assertions/1.1.0 \
@@ -294,7 +306,7 @@ SRC_URI += " \
     crate://crates.io/subtle/2.6.1 \
     crate://crates.io/supports-hyperlinks/3.1.0 \
     crate://crates.io/supports-unicode/3.0.0 \
-    crate://crates.io/syn/2.0.101 \
+    crate://crates.io/syn/2.0.104 \
     crate://crates.io/synstructure/0.13.2 \
     crate://crates.io/tar/0.4.44 \
     crate://crates.io/tempfile/3.20.0 \
@@ -303,21 +315,21 @@ SRC_URI += " \
     crate://crates.io/thiserror/2.0.12 \
     crate://crates.io/thiserror-impl/1.0.69 \
     crate://crates.io/thiserror-impl/2.0.12 \
-    crate://crates.io/thread_local/1.1.8 \
+    crate://crates.io/thread_local/1.1.9 \
     crate://crates.io/time/0.3.41 \
     crate://crates.io/time-core/0.1.4 \
     crate://crates.io/time-macros/0.2.22 \
     crate://crates.io/tinystr/0.8.1 \
     crate://crates.io/tinyvec/1.9.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.8.22 \
-    crate://crates.io/toml_datetime/0.6.9 \
-    crate://crates.io/toml_edit/0.22.26 \
-    crate://crates.io/toml_write/0.1.1 \
+    crate://crates.io/toml/0.8.23 \
+    crate://crates.io/toml_datetime/0.6.11 \
+    crate://crates.io/toml_edit/0.22.27 \
+    crate://crates.io/toml_write/0.1.2 \
     crate://crates.io/tracing/0.1.41 \
-    crate://crates.io/tracing-attributes/0.1.28 \
+    crate://crates.io/tracing-attributes/0.1.30 \
     crate://crates.io/tracing-chrome/0.7.2 \
-    crate://crates.io/tracing-core/0.1.33 \
+    crate://crates.io/tracing-core/0.1.34 \
     crate://crates.io/tracing-log/0.2.0 \
     crate://crates.io/tracing-subscriber/0.3.19 \
     crate://crates.io/typeid/1.0.3 \
@@ -326,7 +338,7 @@ SRC_URI += " \
     crate://crates.io/unicode-bom/2.0.3 \
     crate://crates.io/unicode-ident/1.0.18 \
     crate://crates.io/unicode-normalization/0.1.24 \
-    crate://crates.io/unicode-width/0.2.0 \
+    crate://crates.io/unicode-width/0.2.1 \
     crate://crates.io/unicode-xid/0.2.6 \
     crate://crates.io/url/2.5.4 \
     crate://crates.io/utf8_iter/1.0.4 \
@@ -335,7 +347,7 @@ SRC_URI += " \
     crate://crates.io/vcpkg/0.2.15 \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
     crate://crates.io/wasi/0.14.2+wasi-0.2.4 \
     crate://crates.io/wasm-bindgen/0.2.100 \
     crate://crates.io/wasm-bindgen-backend/0.2.100 \
@@ -349,9 +361,10 @@ SRC_URI += " \
     crate://crates.io/windows-sys/0.48.0 \
     crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-sys/0.60.2 \
     crate://crates.io/windows-targets/0.48.5 \
     crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows-targets/0.53.0 \
+    crate://crates.io/windows-targets/0.53.2 \
     crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.53.0 \
@@ -375,73 +388,74 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_msvc/0.48.5 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.53.0 \
-    crate://crates.io/winnow/0.6.26 \
-    crate://crates.io/winnow/0.7.10 \
+    crate://crates.io/winnow/0.7.11 \
     crate://crates.io/wit-bindgen-rt/0.39.0 \
     crate://crates.io/writeable/0.6.1 \
     crate://crates.io/yoke/0.8.0 \
     crate://crates.io/yoke-derive/0.8.0 \
-    crate://crates.io/zerocopy/0.8.25 \
-    crate://crates.io/zerocopy-derive/0.8.25 \
+    crate://crates.io/zerocopy/0.8.26 \
+    crate://crates.io/zerocopy-derive/0.8.26 \
     crate://crates.io/zerofrom/0.1.6 \
     crate://crates.io/zerofrom-derive/0.1.6 \
     crate://crates.io/zeroize/1.8.1 \
     crate://crates.io/zerotrie/0.2.2 \
     crate://crates.io/zerovec/0.11.2 \
     crate://crates.io/zerovec-derive/0.11.1 \
+    crate://crates.io/zlib-rs/0.5.1 \
 "
 
-SRC_URI[adler2-2.0.0.sha256sum] = "512761e0bb2578dd7380c6baaa0f4ce03e84f95e960231d1dec8bf4d7d6e2627"
+SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
 SRC_URI[ahash-0.8.12.sha256sum] = "5a15f179cd60c4584b8a8c596927aadc462e27f2ca70c04e0071964a73ba7a75"
 SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
 SRC_URI[annotate-snippets-0.11.5.sha256sum] = "710e8eae58854cdc1790fcb56cca04d712a17be849eeb81da2a724bf4bae2bc4"
-SRC_URI[anstream-0.6.18.sha256sum] = "8acc5369981196006228e28809f761875c0327210a891e941f4c683b3a99529b"
-SRC_URI[anstyle-1.0.10.sha256sum] = "55cc3b69f167a1ef2e161439aa98aed94e6028e5f9a59be9a6ffb47aef1651f9"
-SRC_URI[anstyle-parse-0.2.6.sha256sum] = "3b2d16507662817a6a20a9ea92df6652ee4f94f914589377d69f3b21bc5798a9"
-SRC_URI[anstyle-query-1.1.2.sha256sum] = "79947af37f4177cfead1110013d678905c37501914fba0efea834c3fe9a8d60c"
-SRC_URI[anstyle-wincon-3.0.7.sha256sum] = "ca3534e77181a9cc07539ad51f2141fe32f6c3ffd4df76db8ad92346b003ae4e"
+SRC_URI[anstream-0.6.19.sha256sum] = "301af1932e46185686725e0fad2f8f2aa7da69dd70bf6ecc44d6b703844a3933"
+SRC_URI[anstyle-1.0.11.sha256sum] = "862ed96ca487e809f1c8e5a8447f6ee2cf102f846893800b20cebdf541fc6bbd"
+SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
+SRC_URI[anstyle-query-1.1.3.sha256sum] = "6c8bdeb6047d8983be085bab0ba1472e6dc604e7041dbf6fcd5e71523014fae9"
+SRC_URI[anstyle-wincon-3.0.9.sha256sum] = "403f75924867bb1033c59fbf0797484329750cfbe3c4325cd33127941fabc882"
 SRC_URI[anyhow-1.0.98.sha256sum] = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
 SRC_URI[arc-swap-1.7.1.sha256sum] = "69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
 SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
 SRC_URI[arrayvec-0.7.6.sha256sum] = "7c02d123df017efcdfbd739ef81735b36c5ba83ec3c59c80a9d7ecc718f92e50"
-SRC_URI[autocfg-1.4.0.sha256sum] = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
+SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
-SRC_URI[base64ct-1.7.3.sha256sum] = "89e25b6adfb930f02d1981565a6e5d9c547ac15a96606256d3b59040e5cd4ca3"
+SRC_URI[base64ct-1.8.0.sha256sum] = "55248b47b0caf0546f7988906588779981c43bb1bc9d0c44087278f80cdb44ba"
 SRC_URI[bitflags-2.9.1.sha256sum] = "1b8e56985ec62d17e9c1001dc89c88ecd7dc08e47eba5ec7c29c7b5eeecde967"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
 SRC_URI[blake3-1.8.2.sha256sum] = "3888aaa89e4b2a40fca9848e400f6a658a5a3978de7be858e209cafa8be9a4a0"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[bstr-1.12.0.sha256sum] = "234113d19d0d7d613b40e86fb654acf958910802bcceab913a4f9e7cda03b1a4"
-SRC_URI[bumpalo-3.17.0.sha256sum] = "1628fb46dfa0b37568d12e5edd512553eccf6a22a78e8bde00bb4aed84d5bdbf"
+SRC_URI[bumpalo-3.19.0.sha256sum] = "46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
+SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.10.1.sha256sum] = "d71b6127be86fdcfddb610f7182ac57211d4b18a3e9c82eb2d17662f2227ad6a"
-SRC_URI[cargo-0.88.0.sha256sum] = "e3266d7f10870d970f22fd244b5d4bb017f723247e6743f2283f6fe63a4f6084"
+SRC_URI[cargo-0.89.0.sha256sum] = "4ffb868a2869728e8cad2afd836cf7f287f5e9379f2e857deea187abfd7c5cfd"
 SRC_URI[cargo-credential-0.4.8.sha256sum] = "ac1ef5080adde1db190e901884d2c400990856c2a23201c5a181b910a6dbdf2a"
-SRC_URI[cargo-credential-libsecret-0.4.13.sha256sum] = "02d4e8e593dd3967cf90d6ae8e0e820abbb9ba168c4015dc04d90abc80477b8b"
-SRC_URI[cargo-credential-macos-keychain-0.4.13.sha256sum] = "4037e5af4bd682580c82143a0a22d9fd2ae6e57ee8b9ea7110dabcf1160828cc"
-SRC_URI[cargo-credential-wincred-0.4.13.sha256sum] = "320491fd2d43703fe8685cc844af75eba650d32f51a26a9f37ec8fd0d426a738"
-SRC_URI[cargo-platform-0.2.0.sha256sum] = "84982c6c0ae343635a3a4ee6dedef965513735c8b183caa7289fa6e27399ebd4"
-SRC_URI[cargo-util-0.2.20.sha256sum] = "d767bc85f367f6483a6072430b56f5c0d6ee7636751a21a800526d0711753d76"
-SRC_URI[cargo-util-schemas-0.8.1.sha256sum] = "ea8b01266e95c3cf839fe626e651fa36a9171033caa917a773d7a0ba1d5ce6be"
-SRC_URI[cbindgen-0.28.0.sha256sum] = "eadd868a2ce9ca38de7eeafdcec9c7065ef89b42b32f0839278d55f35c54d1ff"
-SRC_URI[cc-1.2.22.sha256sum] = "32db95edf998450acc7881c932f94cd9b05c87b4b2599e8bab064753da4acfd1"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[clap-4.5.38.sha256sum] = "ed93b9805f8ba930df42c2590f05453d5ec36cbb85d018868a5b24d31f6ac000"
-SRC_URI[clap_builder-4.5.38.sha256sum] = "379026ff283facf611b0ea629334361c4211d1b12ee01024eec1591133b04120"
-SRC_URI[clap_complete-4.5.50.sha256sum] = "c91d3baa3bcd889d60e6ef28874126a0b384fd225ab83aa6d8a801c519194ce1"
-SRC_URI[clap_derive-4.5.32.sha256sum] = "09176aae279615badda0765c0c0b3f6ed53f4709118af73cf4655d85d1530cd7"
-SRC_URI[clap_lex-0.7.4.sha256sum] = "f46ad14479a25103f283c0f10005961cf086d8dc42205bb44c46ac563475dca6"
+SRC_URI[cargo-credential-libsecret-0.4.14.sha256sum] = "d4c6e10380bfa25a4f1495e6ca7256332857e3ef7bb16adf376641e6af03acaf"
+SRC_URI[cargo-credential-macos-keychain-0.4.14.sha256sum] = "123e3570992ff3f899a62eefd482e131dea655df8c08150ae559bda2ff492836"
+SRC_URI[cargo-credential-wincred-0.4.14.sha256sum] = "0310db795786db4bbe6cc00f30099ff6a157bb78f9f590376e5e1005866a68d3"
+SRC_URI[cargo-platform-0.3.0.sha256sum] = "8abf5d501fd757c2d2ee78d0cc40f606e92e3a63544420316565556ed28485e2"
+SRC_URI[cargo-util-0.2.21.sha256sum] = "c95ec8b2485b20aed818bd7460f8eecc6c87c35c84191b353a3aba9aa1736c36"
+SRC_URI[cargo-util-schemas-0.8.2.sha256sum] = "7dc1a6f7b5651af85774ae5a34b4e8be397d9cf4bc063b7e6dbd99a841837830"
+SRC_URI[cbindgen-0.29.0.sha256sum] = "975982cdb7ad6a142be15bdf84aea7ec6a9e5d4d797c004d43185b24cfe4e684"
+SRC_URI[cc-1.2.27.sha256sum] = "d487aa071b5f64da6f19a3e848e3578944b726ee5a4854b82172f02aa876bfdc"
+SRC_URI[cfg-if-1.0.1.sha256sum] = "9555578bc9e57714c812a1f84e4fc5b4d21fcb063490c624de019f7464c91268"
+SRC_URI[clap-4.5.40.sha256sum] = "40b6887a1d8685cebccf115538db5c0efe625ccac9696ad45c409d96566e910f"
+SRC_URI[clap_builder-4.5.40.sha256sum] = "e0c66c08ce9f0c698cbce5c0279d0bb6ac936d8674174fe48f736533b964f59e"
+SRC_URI[clap_complete-4.5.54.sha256sum] = "aad5b1b4de04fead402672b48897030eec1f3bfe1550776322f59f6d6e6a5677"
+SRC_URI[clap_derive-4.5.40.sha256sum] = "d2c7947ae4cc3d851207c1adb5b5e260ff0cca11446b1d6d1423788e442257ce"
+SRC_URI[clap_lex-0.7.5.sha256sum] = "b94f61472cee1439c0b966b47e3aca9ae07e45d070759512cd390ea2bebc6675"
 SRC_URI[clru-0.6.2.sha256sum] = "cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
 SRC_URI[color-print-0.3.7.sha256sum] = "3aa954171903797d5623e047d9ab69d91b493657917bdfb8c2c80ecaf9cdb6f4"
 SRC_URI[color-print-proc-macro-0.3.7.sha256sum] = "692186b5ebe54007e45a59aea47ece9eb4108e141326c304cdc91699a7118a22"
-SRC_URI[colorchoice-1.0.3.sha256sum] = "5b63caa9aa9397e2d9480a9b13673856c78d8ac123288526c37d7839f2a86990"
+SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
 SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
 SRC_URI[constant_time_eq-0.3.1.sha256sum] = "7c74b8349d32d297c9134b8c88677813a227df8f779daa29bfc29c183fe3dca6"
-SRC_URI[core-foundation-0.10.0.sha256sum] = "b55271e5c8c478ad3f38ad24ef34923091e0548492a266d19b3c0b4d82574c63"
+SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crates-io-0.40.10.sha256sum] = "9c15b946f2bbd53f5be858ed02fcacfeb3646f3ca67b24defc276a01edd10de6"
+SRC_URI[crates-io-0.40.11.sha256sum] = "9d8912d1316660f138aa2dec2c20e38633449fb7a3b2b8fcbf1698ac31941b8e"
 SRC_URI[crc32fast-1.4.2.sha256sum] = "a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
 SRC_URI[crossbeam-channel-0.5.15.sha256sum] = "82b8f8f868b36967f9606790d1903570de9ceaf870a7bf9fbbd3016d636a2cb2"
 SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
@@ -449,9 +463,9 @@ SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5
 SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
 SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
-SRC_URI[ct-codecs-1.1.5.sha256sum] = "dd0d274c65cbc1c34703d2fc2ce0fb892ff68f4516b677671a2f238a30b9b2b2"
-SRC_URI[curl-0.4.47.sha256sum] = "d9fb4d13a1be2b58f14d60adba57c9834b78c62fd86c3e76a148f732686e9265"
-SRC_URI[curl-sys-0.4.80+curl-8.12.1.sha256sum] = "55f7df2eac63200c3ab25bde3b2268ef2ee56af3d238e76d61f01c3c49bff734"
+SRC_URI[ct-codecs-1.1.6.sha256sum] = "9b10589d1a5e400d61f9f38f12f884cfd080ff345de8f17efda36fe0e4a02aa8"
+SRC_URI[curl-0.4.48.sha256sum] = "9e2d5c8f48d9c0c23250e52b55e82a6ab4fdba6650c931f5a0a57a43abda812b"
+SRC_URI[curl-sys-0.4.82+curl-8.14.1.sha256sum] = "c4d63638b5ec65f1a4ae945287b3fd035be4554bbaf211901159c9a2a74fb5be"
 SRC_URI[dbus-0.9.7.sha256sum] = "1bb21987b9fb1613058ba3843121dd18b163b254d8a6e797e144cbac14d96d1b"
 SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
 SRC_URI[deranged-0.4.0.sha256sum] = "9c9e6a11ca8224451684bc0d7d5a7adbf8f2fd6887261a1cfc3c0432f9d4068e"
@@ -465,15 +479,16 @@ SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b68
 SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 SRC_URI[erased-serde-0.4.6.sha256sum] = "e004d887f51fcb9fef17317a2f3525c887d8aa3f4f50fed920816a688284a5b7"
-SRC_URI[errno-0.3.12.sha256sum] = "cea14ef9355e3beab063703aa9dab15afd25f0667c341310c1e5274bb1d0da18"
+SRC_URI[errno-0.3.13.sha256sum] = "778e2ac28f6c47af28e4907f13ffd1e1ddbd400980a9abd7c8df189bf578a5ad"
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
 SRC_URI[faster-hex-0.9.0.sha256sum] = "a2a2b11eda1d40935b26cf18f6833c526845ae8c41e58d09af6adeb6f0269183"
+SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
 SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
-SRC_URI[fiat-crypto-0.2.9.sha256sum] = "28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
+SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
 SRC_URI[filetime-0.2.25.sha256sum] = "35c0522e981e68cbfa8c3f978441a5f34b30b96e146b33cd3359176b50fe8586"
-SRC_URI[flate2-1.1.1.sha256sum] = "7ced92e76e966ca2fd84c8f7aa01a4aea65b0eb6648d72f7c8f3e2764a67fece"
+SRC_URI[flate2-1.1.2.sha256sum] = "4a3d7db9596fecd151c5f638c0ee5d5bd487b6e0ea232e5dc96d5250f6f94b1d"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[foldhash-0.1.5.sha256sum] = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
@@ -484,63 +499,68 @@ SRC_URI[getrandom-0.2.16.sha256sum] = "335ff9f135e4384c8150d6f27c6daed433577f86b
 SRC_URI[getrandom-0.3.3.sha256sum] = "26145e563e54f2cadc477553f1ec5ee650b00862f0a58bcd12cbdc5f0ea2d2f4"
 SRC_URI[git2-0.20.2.sha256sum] = "2deb07a133b1520dc1a5690e9bd08950108873d7ed5de38dcc74d3b5ebffa110"
 SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
-SRC_URI[gix-0.70.0.sha256sum] = "736f14636705f3a56ea52b553e67282519418d9a35bb1e90b3a9637a00296b68"
-SRC_URI[gix-actor-0.33.2.sha256sum] = "20018a1a6332e065f1fcc8305c1c932c6b8c9985edea2284b3c79dc6fa3ee4b2"
-SRC_URI[gix-attributes-0.24.0.sha256sum] = "f151000bf662ef5f641eca6102d942ee31ace80f271a3ef642e99776ce6ddb38"
+SRC_URI[gix-0.71.0.sha256sum] = "a61e71ec6817fc3c9f12f812682cfe51ee6ea0d2e27e02fc3849c35524617435"
+SRC_URI[gix-actor-0.34.0.sha256sum] = "f438c87d4028aca4b82f82ba8d8ab1569823cfb3e5bc5fa8456a71678b2a20e7"
+SRC_URI[gix-attributes-0.25.0.sha256sum] = "e4e25825e0430aa11096f8b65ced6780d4a96a133f81904edceebb5344c8dd7f"
 SRC_URI[gix-bitmap-0.2.14.sha256sum] = "b1db9765c69502650da68f0804e3dc2b5f8ccc6a2d104ca6c85bc40700d37540"
 SRC_URI[gix-chunk-0.4.11.sha256sum] = "0b1f1d8764958699dc764e3f727cef280ff4d1bd92c107bbf8acd85b30c1bd6f"
-SRC_URI[gix-command-0.4.1.sha256sum] = "cb410b84d6575db45e62025a9118bdbf4d4b099ce7575a76161e898d9ca98df1"
-SRC_URI[gix-commitgraph-0.26.0.sha256sum] = "e23a8ec2d8a16026a10dafdb6ed51bcfd08f5d97f20fa52e200bc50cb72e4877"
-SRC_URI[gix-config-0.43.0.sha256sum] = "377c1efd2014d5d469e0b3cd2952c8097bce9828f634e04d5665383249f1d9e9"
+SRC_URI[gix-command-0.5.0.sha256sum] = "c0378995847773a697f8e157fe2963ecf3462fe64be05b7b3da000b3b472def8"
+SRC_URI[gix-commitgraph-0.27.0.sha256sum] = "043cbe49b7a7505150db975f3cb7c15833335ac1e26781f615454d9d640a28fe"
+SRC_URI[gix-config-0.44.0.sha256sum] = "9c6f830bf746604940261b49abf7f655d2c19cadc9f4142ae9379e3a316e8cfa"
 SRC_URI[gix-config-value-0.14.12.sha256sum] = "8dc2c844c4cf141884678cabef736fd91dd73068b9146e6f004ba1a0457944b6"
-SRC_URI[gix-credentials-0.27.0.sha256sum] = "cf950f9ee1690bb9c4388b5152baa8a9f41ad61e5cf1ba0ec8c207b08dab9e45"
+SRC_URI[gix-credentials-0.28.0.sha256sum] = "25322308aaf65789536b860d21137c3f7b69004ac4971c15c1abb08d3951c062"
 SRC_URI[gix-date-0.9.4.sha256sum] = "daa30058ec7d3511fbc229e4f9e696a35abd07ec5b82e635eff864a2726217e4"
-SRC_URI[gix-diff-0.50.0.sha256sum] = "62afb7f4ca0acdf4e9dad92065b2eb1bf2993bcc5014b57bc796e3a365b17c4d"
-SRC_URI[gix-dir-0.12.0.sha256sum] = "c1d78db3927a12f7d1b788047b84efacaab03ef25738bd1c77856ad8966bd57b"
-SRC_URI[gix-discover-0.38.0.sha256sum] = "d0c2414bdf04064e0f5a5aa029dfda1e663cf9a6c4bfc8759f2d369299bb65d8"
-SRC_URI[gix-features-0.40.0.sha256sum] = "8bfdd4838a8d42bd482c9f0cb526411d003ee94cc7c7b08afe5007329c71d554"
-SRC_URI[gix-filter-0.17.0.sha256sum] = "bdcc36cd7dbc63ed0ec3558645886553d1afd3cd09daa5efb9cba9cceb942bbb"
-SRC_URI[gix-fs-0.13.0.sha256sum] = "182e7fa7bfdf44ffb7cfe7451b373cdf1e00870ac9a488a49587a110c562063d"
-SRC_URI[gix-glob-0.18.0.sha256sum] = "4e9c7249fa0a78f9b363aa58323db71e0a6161fd69860ed6f48dedf0ef3a314e"
-SRC_URI[gix-hash-0.16.0.sha256sum] = "e81c5ec48649b1821b3ed066a44efb95f1a268b35c1d91295e61252539fbe9f8"
-SRC_URI[gix-hashtable-0.7.0.sha256sum] = "189130bc372accd02e0520dc5ab1cef318dcc2bc829b76ab8d84bbe90ac212d1"
-SRC_URI[gix-ignore-0.13.0.sha256sum] = "4f529dcb80bf9855c0a7c49f0ac588df6d6952d63a63fefc254b9c869d2cdf6f"
-SRC_URI[gix-index-0.38.0.sha256sum] = "acd12e3626879369310fffe2ac61acc828613ef656b50c4ea984dd59d7dc85d8"
-SRC_URI[gix-lock-16.0.0.sha256sum] = "9739815270ff6940968441824d162df9433db19211ca9ba8c3fc1b50b849c642"
-SRC_URI[gix-negotiate-0.18.0.sha256sum] = "a6a8af1ef7bbe303d30b55312b7f4d33e955de43a3642ae9b7347c623d80ef80"
-SRC_URI[gix-object-0.47.0.sha256sum] = "ddc4b3a0044244f0fe22347fb7a79cca165e37829d668b41b85ff46a43e5fd68"
-SRC_URI[gix-odb-0.67.0.sha256sum] = "3e93457df69cd09573608ce9fa4f443fbd84bc8d15d8d83adecd471058459c1b"
-SRC_URI[gix-pack-0.57.0.sha256sum] = "fc13a475b3db735617017fb35f816079bf503765312d4b1913b18cf96f3fa515"
+SRC_URI[gix-diff-0.51.0.sha256sum] = "a2c975dad2afc85e4e233f444d1efbe436c3cdcf3a07173984509c436d00a3f8"
+SRC_URI[gix-dir-0.13.0.sha256sum] = "5879497bd3815d8277ed864ec8975290a70de5b62bb92d2d666a4cefc5d4793b"
+SRC_URI[gix-discover-0.39.0.sha256sum] = "f7fb8a4349b854506a3915de18d3341e5f1daa6b489c8affc9ca0d69efe86781"
+SRC_URI[gix-features-0.41.1.sha256sum] = "016d6050219458d14520fe22bdfdeb9cb71631dec9bc2724767c983f60109634"
+SRC_URI[gix-features-0.42.1.sha256sum] = "56f4399af6ec4fd9db84dd4cf9656c5c785ab492ab40a7c27ea92b4241923fed"
+SRC_URI[gix-filter-0.18.0.sha256sum] = "cb2b2bbffdc5cc9b2b82fc82da1b98163c9b423ac2b45348baa83a947ac9ab89"
+SRC_URI[gix-fs-0.14.0.sha256sum] = "951e886120dc5fa8cac053e5e5c89443f12368ca36811b2e43d1539081f9c111"
+SRC_URI[gix-fs-0.15.0.sha256sum] = "67a0637149b4ef24d3ea55f81f77231401c8463fae6da27331c987957eb597c7"
+SRC_URI[gix-glob-0.19.0.sha256sum] = "20972499c03473e773a2099e5fd0c695b9b72465837797a51a43391a1635a030"
+SRC_URI[gix-hash-0.17.0.sha256sum] = "834e79722063958b03342edaa1e17595cd2939bb2b3306b3225d0815566dcb49"
+SRC_URI[gix-hash-0.18.0.sha256sum] = "8d4900562c662852a6b42e2ef03442eccebf24f047d8eab4f23bc12ef0d785d8"
+SRC_URI[gix-hashtable-0.8.1.sha256sum] = "b5b5cb3c308b4144f2612ff64e32130e641279fcf1a84d8d40dad843b4f64904"
+SRC_URI[gix-ignore-0.14.0.sha256sum] = "9a27c8380f493a10d1457f756a3f81924d578fc08d6535e304dfcafbf0261d18"
+SRC_URI[gix-index-0.39.0.sha256sum] = "855bece2d4153453aa5d0a80d51deea1ce8cd6a3b4cf213da85ac344ccb908a7"
+SRC_URI[gix-lock-17.1.0.sha256sum] = "570f8b034659f256366dc90f1a24924902f20acccd6a15be96d44d1269e7a796"
+SRC_URI[gix-negotiate-0.19.0.sha256sum] = "dad912acf5a68a7defa4836014337ff4381af8c3c098f41f818a8c524285e57b"
+SRC_URI[gix-object-0.48.0.sha256sum] = "4943fcdae6ffc135920c9ea71e0362ed539182924ab7a85dd9dac8d89b0dd69a"
+SRC_URI[gix-odb-0.68.0.sha256sum] = "50306d40dcc982eb6b7593103f066ea6289c7b094cb9db14f3cd2be0b9f5e610"
+SRC_URI[gix-pack-0.58.0.sha256sum] = "9b65fffb09393c26624ca408d32cfe8776fb94cd0a5cdf984905e1d2f39779cb"
 SRC_URI[gix-packetline-0.18.4.sha256sum] = "123844a70cf4d5352441dc06bab0da8aef61be94ec239cb631e0ba01dc6d3a04"
 SRC_URI[gix-packetline-blocking-0.18.3.sha256sum] = "1ecf3ea2e105c7e45587bac04099824301262a6c43357fad5205da36dbb233b3"
 SRC_URI[gix-path-0.10.18.sha256sum] = "567f65fec4ef10dfab97ae71f26a27fd4d7fe7b8e3f90c8a58551c41ff3fb65b"
-SRC_URI[gix-pathspec-0.9.0.sha256sum] = "6430d3a686c08e9d59019806faa78c17315fe22ae73151a452195857ca02f86c"
-SRC_URI[gix-prompt-0.9.1.sha256sum] = "79f2185958e1512b989a007509df8d61dca014aa759a22bee80cfa6c594c3b6d"
-SRC_URI[gix-protocol-0.48.0.sha256sum] = "6c61bd61afc6b67d213241e2100394c164be421e3f7228d3521b04f48ca5ba90"
-SRC_URI[gix-quote-0.4.15.sha256sum] = "e49357fccdb0c85c0d3a3292a9f6db32d9b3535959b5471bb9624908f4a066c6"
-SRC_URI[gix-ref-0.50.0.sha256sum] = "47adf4c5f933429f8554e95d0d92eee583cfe4b95d2bf665cd6fd4a1531ee20c"
-SRC_URI[gix-refspec-0.28.0.sha256sum] = "59650228d8f612f68e7f7a25f517fcf386c5d0d39826085492e94766858b0a90"
-SRC_URI[gix-revision-0.32.0.sha256sum] = "3fe28bbccca55da6d66e6c6efc6bb4003c29d407afd8178380293729733e6b53"
-SRC_URI[gix-revwalk-0.18.0.sha256sum] = "d4ecb80c235b1e9ef2b99b23a81ea50dd569a88a9eb767179793269e0e616247"
+SRC_URI[gix-pathspec-0.10.0.sha256sum] = "fef8422c3c9066d649074b24025125963f85232bfad32d6d16aea9453b82ec14"
+SRC_URI[gix-prompt-0.10.0.sha256sum] = "fbf9cbf6239fd32f2c2c9c57eeb4e9b28fa1c9b779fa0e3b7c455eb1ca49d5f0"
+SRC_URI[gix-protocol-0.49.0.sha256sum] = "5678ddae1d62880bc30e2200be1b9387af3372e0e88e21f81b4e7f8367355b5a"
+SRC_URI[gix-quote-0.5.0.sha256sum] = "1b005c550bf84de3b24aa5e540a23e6146a1c01c7d30470e35d75a12f827f969"
+SRC_URI[gix-ref-0.51.0.sha256sum] = "b2e1f7eb6b7ce82d2d19961f74bd637bab3ea79b1bc7bfb23dbefc67b0415d8b"
+SRC_URI[gix-refspec-0.29.0.sha256sum] = "1d8587b21e2264a6e8938d940c5c99662779c13a10741a5737b15fc85c252ffc"
+SRC_URI[gix-revision-0.33.0.sha256sum] = "342caa4e158df3020cadf62f656307c3948fe4eacfdf67171d7212811860c3e9"
+SRC_URI[gix-revwalk-0.19.0.sha256sum] = "2dc7c3d7e5cdc1ab8d35130106e4af0a4f9f9eca0c81f4312b690780e92bde0d"
 SRC_URI[gix-sec-0.10.12.sha256sum] = "47aeb0f13de9ef2f3033f5ff218de30f44db827ac9f1286f9ef050aacddd5888"
-SRC_URI[gix-shallow-0.2.0.sha256sum] = "ab72543011e303e52733c85bef784603ef39632ddf47f69723def52825e35066"
-SRC_URI[gix-submodule-0.17.0.sha256sum] = "74972fe8d46ac8a09490ae1e843b4caf221c5b157c5ac17057e8e1c38417a3ac"
-SRC_URI[gix-tempfile-16.0.0.sha256sum] = "2558f423945ef24a8328c55d1fd6db06b8376b0e7013b1bb476cc4ffdf678501"
+SRC_URI[gix-shallow-0.3.0.sha256sum] = "cc0598aacfe1d52575a21c9492fee086edbb21e228ec36c819c42ab923f434c3"
+SRC_URI[gix-submodule-0.18.0.sha256sum] = "78c7390c2059505c365e9548016d4edc9f35749c6a9112b7b1214400bbc68da2"
+SRC_URI[gix-tempfile-17.1.0.sha256sum] = "c750e8c008453a2dba67a2b0d928b7716e05da31173a3f5e351d5457ad4470aa"
 SRC_URI[gix-trace-0.1.12.sha256sum] = "7c396a2036920c69695f760a65e7f2677267ccf483f25046977d87e4cb2665f7"
-SRC_URI[gix-transport-0.45.0.sha256sum] = "11187418489477b1b5b862ae1aedbbac77e582f2c4b0ef54280f20cfe5b964d9"
-SRC_URI[gix-traverse-0.44.0.sha256sum] = "2bec70e53896586ef32a3efa7e4427b67308531ed186bb6120fb3eca0f0d61b4"
-SRC_URI[gix-url-0.29.0.sha256sum] = "29218c768b53dd8f116045d87fec05b294c731a4b2bdd257eeca2084cc150b13"
-SRC_URI[gix-utils-0.1.14.sha256sum] = "ff08f24e03ac8916c478c8419d7d3c33393da9bb41fa4c24455d5406aeefd35f"
+SRC_URI[gix-transport-0.46.0.sha256sum] = "b3f68c2870bfca8278389d2484a7f2215b67d0b0cc5277d3c72ad72acf41787e"
+SRC_URI[gix-traverse-0.45.0.sha256sum] = "36c0b049f8bdb61b20016694102f7b507f2e1727e83e9c5e6dad4f7d84ff7384"
+SRC_URI[gix-url-0.30.0.sha256sum] = "48dfe23f93f1ddb84977d80bb0dd7aa09d1bf5d5afc0c9b6820cccacc25ae860"
+SRC_URI[gix-utils-0.2.0.sha256sum] = "189f8724cf903e7fd57cfe0b7bc209db255cacdcb22c781a022f52c3a774f8d0"
+SRC_URI[gix-utils-0.3.0.sha256sum] = "5351af2b172caf41a3728eb4455326d84e0d70fe26fc4de74ab0bd37df4191c5"
 SRC_URI[gix-validate-0.9.4.sha256sum] = "34b5f1253109da6c79ed7cf6e1e38437080bb6d704c76af14c93e2f255234084"
 SRC_URI[gix-validate-0.10.0.sha256sum] = "77b9e00cacde5b51388d28ed746c493b18a6add1f19b5e01d686b3b9ece66d4d"
-SRC_URI[gix-worktree-0.39.0.sha256sum] = "6673512f7eaa57a6876adceca6978a501d6c6569a4f177767dc405f8b9778958"
+SRC_URI[gix-worktree-0.40.0.sha256sum] = "f7760dbc4b79aa274fed30adc0d41dca6b917641f26e7867c4071b1fb4dc727b"
 SRC_URI[glob-0.3.2.sha256sum] = "a8d1add55171497b4705a648c6b583acafb01d58050a51727785f0b2c8e0a2b2"
 SRC_URI[globset-0.4.16.sha256sum] = "54a1028dfc5f5df5da8a56a73e6c153c9a9708ec57232470703592a3f18e49f5"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
+SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e902d4df49588d1470606"
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
-SRC_URI[hashbrown-0.15.3.sha256sum] = "84b26c544d002229e640969970a2e74021aadf6e2f96372b9c58eff97de08eb3"
+SRC_URI[hashbrown-0.15.4.sha256sum] = "5971ac85611da7067dbfcabef3c70ebb5606018acd9e2a3903a0da507521e0d5"
 SRC_URI[hashlink-0.10.0.sha256sum] = "7382cf6263419f2d8df38c55d7da83da5c18aef87fc7a7fc1fb1e344edfe14c1"
-SRC_URI[heck-0.4.1.sha256sum] = "95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
+SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
 SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
@@ -551,21 +571,21 @@ SRC_URI[icu_collections-2.0.0.sha256sum] = "200072f5d0e3614556f94a9930d5dc3e0662
 SRC_URI[icu_locale_core-2.0.0.sha256sum] = "0cde2700ccaed3872079a65fb1a78f6c0a36c91570f28755dda67bc8f7d9f00a"
 SRC_URI[icu_normalizer-2.0.0.sha256sum] = "436880e8e18df4d7bbc06d58432329d6458cc84531f7ac5f024e93deadb37979"
 SRC_URI[icu_normalizer_data-2.0.0.sha256sum] = "00210d6893afc98edb752b664b8890f0ef174c8adbb8d0be9710fa66fbbf72d3"
-SRC_URI[icu_properties-2.0.0.sha256sum] = "2549ca8c7241c82f59c80ba2a6f415d931c5b58d24fb8412caa1a1f02c49139a"
-SRC_URI[icu_properties_data-2.0.0.sha256sum] = "8197e866e47b68f8f7d95249e172903bec06004b18b2937f1095d40a0c57de04"
+SRC_URI[icu_properties-2.0.1.sha256sum] = "016c619c1eeb94efb86809b015c58f479963de65bdb6253345c1a1276f22e32b"
+SRC_URI[icu_properties_data-2.0.1.sha256sum] = "298459143998310acd25ffe6810ed544932242d3f07083eee1084d83a71bd632"
 SRC_URI[icu_provider-2.0.0.sha256sum] = "03c80da27b5f4187909049ee2d72f276f0d9f99a42c306bd0131ecfe04d8e5af"
 SRC_URI[idna-1.0.3.sha256sum] = "686f825264d630750a544639377bae737628043f20d38bbc029e8f29ea968a7e"
 SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
 SRC_URI[ignore-0.4.23.sha256sum] = "6d89fd380afde86567dfba715db065673989d6253f42b88179abd3eae47bda4b"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[implib-0.3.5.sha256sum] = "598bf7096215f835b0f70c94d7b033da3cbf66181b619f25e54d65adaf825e62"
-SRC_URI[indexmap-2.9.0.sha256sum] = "cea70ddb795996207ad57735b50c5982d8844f38ba9ee5f1aedcfb708a2aa11e"
+SRC_URI[indexmap-2.10.0.sha256sum] = "fe4cd85333e22411419a0bcae1297d25e58c9443848b11dc6a86fefe8c78a661"
 SRC_URI[is_executable-1.0.4.sha256sum] = "d4a1b5bad6f9072935961dfbf1cced2f3d129963d091b6f69f007fe04e758ae2"
 SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] = "7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
 SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
 SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
-SRC_URI[jiff-0.2.13.sha256sum] = "f02000660d30638906021176af16b17498bd0d12813dbfe7b276d8bc7f3c0806"
-SRC_URI[jiff-static-0.2.13.sha256sum] = "f3c30758ddd7188629c6713fc45d1188af4f44c90582311d0c8d8c9907f60c48"
+SRC_URI[jiff-0.2.15.sha256sum] = "be1f93b8b1eb69c77f24bbb0afdf66f54b632ee39af40ca21c4365a1d7347e49"
+SRC_URI[jiff-static-0.2.15.sha256sum] = "03343451ff899767262ec32146f6d559dd759fdadf42ff0e227c7c48f72594b4"
 SRC_URI[jiff-tzdb-0.1.4.sha256sum] = "c1283705eb0a21404d2bfd6eef2a7593d240bc42a0bdb39db0ad6fa2ec026524"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.33.sha256sum] = "38f262f097c174adebe41eb73d66ae9c06b2844fb0da69969647bbddd9b0538a"
@@ -573,27 +593,28 @@ SRC_URI[js-sys-0.3.77.sha256sum] = "1cfaf33c695fc6e08064efbc1f72ec937429614f25ee
 SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
 SRC_URI[lazycell-1.3.0.sha256sum] = "830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
-SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
+SRC_URI[libc-0.2.174.sha256sum] = "1171693293099992e19cddea4e8b849964e9846f4acee11b3948bcc337be8776"
 SRC_URI[libdbus-sys-0.2.5.sha256sum] = "06085512b750d640299b79be4bad3d2fa90a9c00b1fd9e1b46364f66f0485c72"
-SRC_URI[libgit2-sys-0.18.1+1.9.0.sha256sum] = "e1dcb20f84ffcdd825c7a311ae347cce604a6f084a767dec4a4929829645290e"
-SRC_URI[libloading-0.8.7.sha256sum] = "6a793df0d7afeac54f95b471d3af7f0d4fb975699f972341a4b76988d49cdf0c"
+SRC_URI[libgit2-sys-0.18.2+1.9.1.sha256sum] = "1c42fe03df2bd3c53a3a9c7317ad91d80c81cd1fb0caec8d7cc4cd2bfa10c222"
+SRC_URI[libloading-0.8.8.sha256sum] = "07033963ba89ebaf1584d767badaa2e8fcec21aedea6b8c0346d487d49c28667"
 SRC_URI[libnghttp2-sys-0.1.11+1.64.0.sha256sum] = "1b6c24e48a7167cffa7119da39d577fa482e66c688a4aac016bee862e1a713c4"
-SRC_URI[libredox-0.1.3.sha256sum] = "c0ff37bd590ca25063e35af745c343cb7a0271906fb7b37e4813e8f79f00268d"
-SRC_URI[libsqlite3-sys-0.31.0.sha256sum] = "ad8935b44e7c13394a179a438e0cebba0fe08fe01b54f152e29a93b5cf993fd4"
+SRC_URI[libredox-0.1.4.sha256sum] = "1580801010e535496706ba011c15f8532df6b42297d2e471fec38ceadd8c0638"
+SRC_URI[libsqlite3-sys-0.32.0.sha256sum] = "fbb8270bb4060bd76c6e96f20c52d80620f1d82a3470885694e41e0f81ef6fe7"
 SRC_URI[libssh2-sys-0.3.1.sha256sum] = "220e4f05ad4a218192533b300327f5150e809b54c4ec83b5a1d91833601811b9"
+SRC_URI[libz-rs-sys-0.5.1.sha256sum] = "172a788537a2221661b480fee8dc5f96c580eb34fa88764d3205dc356c7e4221"
 SRC_URI[libz-sys-1.1.22.sha256sum] = "8b70e7a7df205e92a1a4cd9aaae7898dac0aa555503cc0a649494d0d60e7651d"
 SRC_URI[linux-raw-sys-0.4.15.sha256sum] = "d26c52dbd32dccf2d10cac7725f8eae5296885fb5703b261f7d0a0739ec807ab"
 SRC_URI[linux-raw-sys-0.9.4.sha256sum] = "cd945864f07fe9f5371a27ad7b52a172b4b499999f1d97574c9fa68373937e12"
 SRC_URI[litemap-0.8.0.sha256sum] = "241eaef5fd12c88705a01fc1066c48c4b36e0dd4377dcdc7ec3942cea7a69956"
-SRC_URI[lock_api-0.4.12.sha256sum] = "07af8b9cdd281b7915f413fa73f29ebd5d55d0d3f0155584dade1ff18cea1b17"
+SRC_URI[lock_api-0.4.13.sha256sum] = "96936507f153605bddfcda068dd804796c84324ed2510809e5b2a624c81da765"
 SRC_URI[log-0.4.27.sha256sum] = "13dc2df351e3202783a1fe0d44375f7295ffb4049267b0f3018346dc122a1d94"
 SRC_URI[matchers-0.1.0.sha256sum] = "8263075bb86c5a1b1427b5ae862e8889656f126e9f77c484496e8b47cf5c5558"
 SRC_URI[maybe-async-0.2.10.sha256sum] = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[memchr-2.7.5.sha256sum] = "32a282da65faaf38286cf3be983213fcf1d2e2a58700e808f83f4ea9a4804bc0"
 SRC_URI[memmap2-0.9.5.sha256sum] = "fd3f7eed9d3848f8b98834af67102b720745c4ec028fcd0aa0239277e7de374f"
 SRC_URI[memoffset-0.9.1.sha256sum] = "488016bfae457b036d996092f6cb448677611ce4449e970ceaf42695203f218a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.8.8.sha256sum] = "3be647b768db090acb35d5ec5db2b0e1f1de11133ca123b9eacf5137868f892a"
+SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
 SRC_URI[miow-0.6.0.sha256sum] = "359f76430b20a79f9e20e115b3428614e654f04fab314482fc0fda0ebd3c6044"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normpath-1.3.0.sha256sum] = "c8911957c4b1549ac0dc74e30db9c8b0e66ddcd6d7acc33098f4c63a64a6d7ed"
@@ -601,28 +622,31 @@ SRC_URI[nu-ansi-term-0.46.0.sha256sum] = "77a8165726e8236064dbb45459242600304b42
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[object-0.36.7.sha256sum] = "62948e14d923ea95ea2c7c86c71013138b66525b86bdc08d2dcc262bdb497b87"
+SRC_URI[object-0.37.1.sha256sum] = "03fd943161069e1768b4b3d050890ba48730e590f57e56d4aa04e7e090e61b4a"
 SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
+SRC_URI[once_cell_polyfill-1.70.1.sha256sum] = "a4895175b425cb1f87721b59f0f286c2092bd4af812243672510e1ac53e2e0ad"
 SRC_URI[opener-0.7.2.sha256sum] = "d0812e5e4df08da354c851a3376fead46db31c2214f849d3de356d774d057681"
-SRC_URI[openssl-0.10.57.sha256sum] = "bac25ee399abb46215765b1cb35bc0212377e58a061560d8b29b024fd0430e7c"
+SRC_URI[openssl-0.10.73.sha256sum] = "8505734d46c8ab1e19a1dce3aef597ad87dcb4c37e7188231769bd6bd51cebf8"
 SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
 SRC_URI[openssl-probe-0.1.6.sha256sum] = "d05e27ee213611ffe7d6348b942e8f942b37114c00cc03cec254295a4a17852e"
 SRC_URI[openssl-src-300.5.0+3.5.0.sha256sum] = "e8ce546f549326b0e6052b649198487d91320875da901e7bd11a06d1ee3f9c2f"
-SRC_URI[openssl-sys-0.9.108.sha256sum] = "e145e1651e858e820e4860f7b9c5e169bc1d8ce1c86043be79fa7b7634821847"
+SRC_URI[openssl-sys-0.9.109.sha256sum] = "90096e2e47630d78b7d1c20952dc621f957103f8bc2c8359ec81290d75238571"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
-SRC_URI[orion-0.17.10.sha256sum] = "ccc95d369bc6b5cf404c562cd33de439ae9ca6dc4b044cd2625b2072ca0b81e4"
-SRC_URI[os_info-3.11.0.sha256sum] = "41fc863e2ca13dc2d5c34fb22ea4a588248ac14db929616ba65c45f21744b1e9"
+SRC_URI[orion-0.17.11.sha256sum] = "21b3da83b2b4cdc74ab6a556b2e7b473da046d5aa4008c0a7a3ae96b1b4aabb4"
+SRC_URI[os_info-3.12.0.sha256sum] = "d0e1ac5fde8d43c34139135df8ea9ee9465394b2d8d20f032d38998f64afffc3"
 SRC_URI[overload-0.1.1.sha256sum] = "b15813163c1d831bf4a13c3610c05c0d03b39feb07f7e09fa234dac9b15aaf39"
 SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
-SRC_URI[parking_lot-0.12.3.sha256sum] = "f1bf18183cf54e8d6059647fc3063646a1801cf30896933ec2311622cc4b9a27"
-SRC_URI[parking_lot_core-0.9.10.sha256sum] = "1e401f977ab385c9e4e3ab30627d6f26d00e2c73eef317493c4ec6d468726cf8"
-SRC_URI[pasetors-0.7.4.sha256sum] = "cb798c661c80718af935bea17997928937822e7369cd087667ff4179f9146551"
+SRC_URI[parking_lot-0.12.4.sha256sum] = "70d58bf43669b5795d1576d0641cfb6fbb2057bf629506267a92807158584a13"
+SRC_URI[parking_lot_core-0.9.11.sha256sum] = "bc838d2a56b5b1a6c25f55575dfc605fabb63bb2365f6c2353ef9159aa69e4a5"
+SRC_URI[pasetors-0.7.6.sha256sum] = "8c1c6d47c07a08cb59ddad44d53cb5729855e35f7d993184cec3aa37ccdb7008"
 SRC_URI[pathdiff-0.2.3.sha256sum] = "df94ce210e5bc13cb6651479fa48d14f601d9858cfe0467f43ae157023b938d3"
 SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
 SRC_URI[percent-encoding-2.3.1.sha256sum] = "e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
 SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
 SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
-SRC_URI[portable-atomic-1.11.0.sha256sum] = "350e9b48cbc6b0e028b0473b114454c6316e57336ee184ceab6e53f72c178b3e"
+SRC_URI[plist-1.7.2.sha256sum] = "3d77244ce2d584cd84f6a15f86195b8c9b2a0dfbfd817c09e0464244091a58ed"
+SRC_URI[portable-atomic-1.11.1.sha256sum] = "f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
 SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
 SRC_URI[potential_utf-0.1.2.sha256sum] = "e5a7c30837279ca13e7c867e9e40053bc68740f988cb07f7ca6df43cc734b585"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
@@ -630,24 +654,25 @@ SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
 SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
 SRC_URI[prodash-29.0.2.sha256sum] = "f04bb108f648884c23b98a0e940ebc2c93c0c3b89f04dbaf7eb8256ce617d1bc"
+SRC_URI[quick-xml-0.37.5.sha256sum] = "331e97a1af0bf59823e6eadffe373d7b27f485be8748f71471c662c1f269b7fb"
 SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
-SRC_URI[r-efi-5.2.0.sha256sum] = "74765f6d916ee2faa39bc8e68e4f3ed8949b48cccdac59983d287a7cb71ce9c5"
+SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[rand-0.9.1.sha256sum] = "9fbfd9d094a40bf3ae768db9361049ace4c0e04a4fd6b359518bd7b73a73dd97"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
-SRC_URI[redox_syscall-0.5.12.sha256sum] = "928fca9cf2aa042393a8325b9ead81d2f0df4cb12e1e24cef072922ccd99c5af"
+SRC_URI[redox_syscall-0.5.13.sha256sum] = "0d04b7d0ee6b4a0207a0a7adb104d23ecb0b47d6beae7152d0fa34b692b29fd6"
 SRC_URI[regex-1.11.1.sha256sum] = "b544ef1b4eac5dc2db33ea63606ae9ffcfac26c1416a2806ae0bf5f56b201191"
 SRC_URI[regex-automata-0.1.10.sha256sum] = "6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
 SRC_URI[regex-automata-0.4.9.sha256sum] = "809e8dc61f6de73b46c85f4c96486310fe304c434cfa43669d7b40f711150908"
 SRC_URI[regex-syntax-0.6.29.sha256sum] = "f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
 SRC_URI[regex-syntax-0.8.5.sha256sum] = "2b15c43186be67a4fd63bee50d0303afffcef381492ebe2c5d87f324e1b8815c"
 SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
-SRC_URI[rusqlite-0.33.0.sha256sum] = "1c6d5e5acb6f6129fe3f7ba0a7fc77bca1942cb568535e18e7bc40262baf3110"
+SRC_URI[rusqlite-0.34.0.sha256sum] = "37e34486da88d8e051c7c0e23c3f15fd806ea8546260aa2fec247e97242ec143"
 SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
-SRC_URI[rustfix-0.9.0.sha256sum] = "7f66156d7471ff4f12253cd7fd76dfe637a595a9418168154e8570f3947fe9a8"
+SRC_URI[rustfix-0.9.1.sha256sum] = "8abe01883100061761642e19324f87514bcaed7ddaab2dfd68041c992987b289"
 SRC_URI[rustix-0.38.44.sha256sum] = "fdb5bc1ae2baa591800df16c9ca78619bf65c0488b41b96ccec5d11220d8c154"
 SRC_URI[rustix-1.0.7.sha256sum] = "c71e83d6afe7ff64890ec6b71d6a69bb8a610ab78ce364b3352876bb4c801266"
 SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
@@ -664,9 +689,9 @@ SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e
 SRC_URI[serde_derive-1.0.219.sha256sum] = "5b0276cf7f2c73365f7157c8123c21cd9a50fbbd844757af28ca1f5925fc2a00"
 SRC_URI[serde_ignored-0.1.12.sha256sum] = "b516445dac1e3535b6d658a7b528d771153dfb272ed4180ca4617a20550365ff"
 SRC_URI[serde_json-1.0.140.sha256sum] = "20068b6e96dc6c9bd23e01df8827e6c7e1f2fddd43c21810382803c136b99373"
-SRC_URI[serde_spanned-0.6.8.sha256sum] = "87607cb1398ed59d48732e575a4c28a7a8ebf2454b964fe3f224f2afc07909e1"
+SRC_URI[serde_spanned-0.6.9.sha256sum] = "bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
 SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
-SRC_URI[sha1_smol-1.0.1.sha256sum] = "bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
+SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832b03984598375bff3975b804423"
 SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
 SRC_URI[sharded-slab-0.1.7.sha256sum] = "f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6"
 SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873bfad7dc788c42e6430db40184f"
@@ -674,8 +699,8 @@ SRC_URI[shell-words-1.1.0.sha256sum] = "24188a676b6ae68c3b2cb3a01be17fbf7240ce00
 SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
-SRC_URI[smallvec-1.15.0.sha256sum] = "8917285742e9f3e1683f0a9c4e6b57960b7314d0b08d30d1ecd426713ee2eee9"
-SRC_URI[socket2-0.5.9.sha256sum] = "4f5fd57c80058a56cf5c777ab8a126398ece8e442983605d280a44ce79d0edef"
+SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
+SRC_URI[socket2-0.5.10.sha256sum] = "e22376abed350d73dd1cd119b57ffccad95b4e585a7cda43e286245ce23c0678"
 SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
 SRC_URI[stable_deref_trait-1.2.0.sha256sum] = "a8f112729512f8e442d81f95a8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
@@ -683,7 +708,7 @@ SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70
 SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
 SRC_URI[supports-hyperlinks-3.1.0.sha256sum] = "804f44ed3c63152de6a9f90acbea1a110441de43006ea51bcce8f436196a288b"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
-SRC_URI[syn-2.0.101.sha256sum] = "8ce2b7fc941b3a24138a0a7cf8e858bfc6a992e7978a068a5c760deb0ed43caf"
+SRC_URI[syn-2.0.104.sha256sum] = "17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
 SRC_URI[tar-0.4.44.sha256sum] = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
 SRC_URI[tempfile-3.20.0.sha256sum] = "e8a64e3985349f2441a1a9ef0b853f869006c3855f2cda6862a94d26ebb9d6a1"
@@ -692,21 +717,21 @@ SRC_URI[thiserror-1.0.69.sha256sum] = "b6aaf5339b578ea85b50e080feb250a3e8ae8cfcd
 SRC_URI[thiserror-2.0.12.sha256sum] = "567b8a2dae586314f7be2a752ec7474332959c6460e02bde30d702a66d488708"
 SRC_URI[thiserror-impl-1.0.69.sha256sum] = "4fee6c4efc90059e10f81e6d42c60a18f76588c3d74cb83a0b242a2b6c7504c1"
 SRC_URI[thiserror-impl-2.0.12.sha256sum] = "7f7cf42b4507d8ea322120659672cf1b9dbb93f8f2d4ecfd6e51350ff5b17a1d"
-SRC_URI[thread_local-1.1.8.sha256sum] = "8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
+SRC_URI[thread_local-1.1.9.sha256sum] = "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
 SRC_URI[time-0.3.41.sha256sum] = "8a7619e19bc266e0f9c5e6686659d394bc57973859340060a69221e57dbc0c40"
 SRC_URI[time-core-0.1.4.sha256sum] = "c9e9a38711f559d9e3ce1cdb06dd7c5b8ea546bc90052da6d06bb76da74bb07c"
 SRC_URI[time-macros-0.2.22.sha256sum] = "3526739392ec93fd8b359c8e98514cb3e8e021beb4e5f597b00a0221f8ed8a49"
 SRC_URI[tinystr-0.8.1.sha256sum] = "5d4f6d1145dcb577acf783d4e601bc1d76a13337bb54e6233add580b07344c8b"
 SRC_URI[tinyvec-1.9.0.sha256sum] = "09b3661f17e86524eccd4371ab0429194e0d7c008abb45f7a7495b1719463c71"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.8.22.sha256sum] = "05ae329d1f08c4d17a59bed7ff5b5a769d062e64a62d34a3261b219e62cd5aae"
-SRC_URI[toml_datetime-0.6.9.sha256sum] = "3da5db5a963e24bc68be8b17b6fa82814bb22ee8660f192bb182771d498f09a3"
-SRC_URI[toml_edit-0.22.26.sha256sum] = "310068873db2c5b3e7659d2cc35d21855dbafa50d1ce336397c666e3cb08137e"
-SRC_URI[toml_write-0.1.1.sha256sum] = "bfb942dfe1d8e29a7ee7fcbde5bd2b9a25fb89aa70caea2eba3bee836ff41076"
+SRC_URI[toml-0.8.23.sha256sum] = "dc1beb996b9d83529a9e75c17a1686767d148d70663143c7854d8b4a09ced362"
+SRC_URI[toml_datetime-0.6.11.sha256sum] = "22cddaf88f4fbc13c51aebbf5f8eceb5c7c5a9da2ac40a13519eb5b0a0e8f11c"
+SRC_URI[toml_edit-0.22.27.sha256sum] = "41fe8c660ae4257887cf66394862d21dbca4a6ddd26f04a3560410406a2f819a"
+SRC_URI[toml_write-0.1.2.sha256sum] = "5d99f8c9a7727884afe522e9bd5edbfc91a3312b36a77b5fb8926e4c31a41801"
 SRC_URI[tracing-0.1.41.sha256sum] = "784e0ac535deb450455cbfa28a6f0df145ea1bb7ae51b821cf5e7927fdcfbdd0"
-SRC_URI[tracing-attributes-0.1.28.sha256sum] = "395ae124c09f9e6918a2310af6038fba074bcf474ac352496d5910dd59a2226d"
+SRC_URI[tracing-attributes-0.1.30.sha256sum] = "81383ab64e72a7a8b8e13130c49e3dab29def6d0c7d76a03087b3cf71c5c6903"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
-SRC_URI[tracing-core-0.1.33.sha256sum] = "e672c95779cf947c5311f83787af4fa8fffd12fb27e4993211a84bdfd9610f9c"
+SRC_URI[tracing-core-0.1.34.sha256sum] = "b9d12581f227e93f094d3af2ae690a574abb8a2b9b7a96e7cfe9647b2b617678"
 SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
 SRC_URI[tracing-subscriber-0.3.19.sha256sum] = "e8189decb5ac0fa7bc8b96b7cb9b2701d60d48805aca84a238004d665fcc4008"
 SRC_URI[typeid-1.0.3.sha256sum] = "bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
@@ -715,7 +740,7 @@ SRC_URI[unicase-2.8.1.sha256sum] = "75b844d17643ee918803943289730bec8aac48015045
 SRC_URI[unicode-bom-2.0.3.sha256sum] = "7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
 SRC_URI[unicode-ident-1.0.18.sha256sum] = "5a5f39404a5da50712a4c1eecf25e90dd62b613502b7e925fd4e4d19b5c96512"
 SRC_URI[unicode-normalization-0.1.24.sha256sum] = "5033c97c4262335cded6d6fc3e5c18ab755e1a3dc96376350f3d8e9f009ad956"
-SRC_URI[unicode-width-0.2.0.sha256sum] = "1fc81956842c57dac11422a97c3b8195a1ff727f06e85c84ed2e8aa277c9a0fd"
+SRC_URI[unicode-width-0.2.1.sha256sum] = "4a1a07cc7db3810833284e8d372ccdc6da29741639ecc70c9ec107df0fa6154c"
 SRC_URI[unicode-xid-0.2.6.sha256sum] = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
 SRC_URI[url-2.5.4.sha256sum] = "32f8b686cadd1473f4bd0117a5d28d36b1ade384ea9b5069a1c40aefed7fda60"
 SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
@@ -724,7 +749,7 @@ SRC_URI[valuable-0.1.1.sha256sum] = "ba73ea9cf16a25df0c8caa16c51acb937d5712a8429
 SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
 SRC_URI[wasi-0.14.2+wasi-0.2.4.sha256sum] = "9683f9a5a998d873c0d21fcbe3c083009670149a8fab228644b8bd36b2c48cb3"
 SRC_URI[wasm-bindgen-0.2.100.sha256sum] = "1edc8929d7499fc4e8f0be2262a241556cfc54a0bea223790e71446f2aab1ef5"
 SRC_URI[wasm-bindgen-backend-0.2.100.sha256sum] = "2f0a0651a5c2bc21487bde11ee802ccaf4c51935d0d3d42a6101f98161700bc6"
@@ -738,9 +763,10 @@ SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2f
 SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-sys-0.60.2.sha256sum] = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
 SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows-targets-0.53.0.sha256sum] = "b1e4c7e8ceaaf9cb7d7507c974735728ab453b67ef8f18febdd7c11fe59dca8b"
+SRC_URI[windows-targets-0.53.2.sha256sum] = "c66f69fcc9ce11da9966ddb31a40968cad001c5bedeb5c2b82ede4253ab48aef"
 SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
 SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
 SRC_URI[windows_aarch64_gnullvm-0.53.0.sha256sum] = "86b8d5f90ddd19cb4a147a5fa63ca848db3df085e25fee3cc10b39b6eebae764"
@@ -764,17 +790,17 @@ SRC_URI[windows_x86_64_gnullvm-0.53.0.sha256sum] = "0a6e035dd0599267ce1ee132e51c
 SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[windows_x86_64_msvc-0.53.0.sha256sum] = "271414315aff87387382ec3d271b52d7ae78726f5d44ac98b4f4030c91880486"
-SRC_URI[winnow-0.6.26.sha256sum] = "1e90edd2ac1aa278a5c4599b1d89cf03074b610800f866d4026dc199d7929a28"
-SRC_URI[winnow-0.7.10.sha256sum] = "c06928c8748d81b05c9be96aad92e1b6ff01833332f281e8cfca3be4b35fc9ec"
+SRC_URI[winnow-0.7.11.sha256sum] = "74c7b26e3480b707944fc872477815d29a8e429d2f93a1ce000f5fa84a15cbcd"
 SRC_URI[wit-bindgen-rt-0.39.0.sha256sum] = "6f42320e61fe2cfd34354ecb597f86f413484a798ba44a8ca1165c58d42da6c1"
 SRC_URI[writeable-0.6.1.sha256sum] = "ea2f10b9bb0928dfb1b42b65e1f9e36f7f54dbdf08457afefb38afcdec4fa2bb"
 SRC_URI[yoke-0.8.0.sha256sum] = "5f41bb01b8226ef4bfd589436a297c53d118f65921786300e427be8d487695cc"
 SRC_URI[yoke-derive-0.8.0.sha256sum] = "38da3c9736e16c5d3c8c597a9aaa5d1fa565d0532ae05e27c24aa62fb32c0ab6"
-SRC_URI[zerocopy-0.8.25.sha256sum] = "a1702d9583232ddb9174e01bb7c15a2ab8fb1bc6f227aa1233858c351a3ba0cb"
-SRC_URI[zerocopy-derive-0.8.25.sha256sum] = "28a6e20d751156648aa063f3800b706ee209a32c0b4d9f24be3d980b01be55ef"
+SRC_URI[zerocopy-0.8.26.sha256sum] = "1039dd0d3c310cf05de012d8a39ff557cb0d23087fd44cad61df08fc31907a2f"
+SRC_URI[zerocopy-derive-0.8.26.sha256sum] = "9ecf5b4cc5364572d7f4c329661bcc82724222973f2cab6f050a4e5c22f75181"
 SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
 SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
 SRC_URI[zeroize-1.8.1.sha256sum] = "ced3678a2879b30306d323f4542626697a464a97c0a07c9aebf7ebca65cd4dde"
 SRC_URI[zerotrie-0.2.2.sha256sum] = "36f0bbd478583f79edad978b407914f61b2972f5af6fa089686016be8f9af595"
 SRC_URI[zerovec-0.11.2.sha256sum] = "4a05eb080e015ba39cc9e23bbe5e7fb04d5fb040350f99f34e338d5fdd294428"
 SRC_URI[zerovec-derive-0.11.1.sha256sum] = "5b96237efa0c878c64bd89c436f661be4e46b2f3eff1ebb976f7ef2321d2f58f"
+SRC_URI[zlib-rs-0.5.1.sha256sum] = "626bd9fa9734751fc50d6060752170984d7053f5a39061f524cda68023d4db8a"
diff --git a/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch b/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
new file mode 100644
index 0000000..dc7130f
--- /dev/null
+++ b/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
@@ -0,0 +1,53 @@
+From 71c356a07fbbf1530cfc87960e975f93bc9007e8 Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Tue, 22 Jul 2025 09:46:03 -0700
+Subject: [PATCH] Use libc::SYS_futex_time64 on riscv32
+
+On RISC-V 32-bit (riscv32), the SYS_futex system call is
+often handled indirectly due to the use of a 64-bit time_t
+type. Specifically, while SYS_futex is not directly defined,
+a related syscall like SYS_futex_time64 can be used,
+
+Upstream-Status: Submitted [https://github.com/rust-random/getrandom/pull/698]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ src/backends/use_file.rs | 17 +++++++++++++++++
+ 1 file changed, 17 insertions(+)
+
+diff --git a/src/backends/use_file.rs b/src/backends/use_file.rs
+index 7b48d43..baa0c66 100644
+--- a/src/backends/use_file.rs
++++ b/src/backends/use_file.rs
+@@ -158,7 +158,18 @@ mod sync {
+     pub(super) fn wait() {
+         let op = libc::FUTEX_WAIT | libc::FUTEX_PRIVATE_FLAG;
+         let timeout_ptr = core::ptr::null::<libc::timespec>();
++        #[cfg(not(target_arch = "riscv32"))]
+         let ret = unsafe { libc::syscall(libc::SYS_futex, &FD, op, FD_ONGOING_INIT, timeout_ptr) };
++        #[cfg(target_arch = "riscv32")]
++        let ret = unsafe {
++            libc::syscall(
++                libc::SYS_futex_time64,
++                &FD,
++                op,
++                FD_ONGOING_INIT,
++                timeout_ptr,
++            )
++        };
+         // FUTEX_WAIT should return either 0 or EAGAIN error
+         debug_assert!({
+             match ret {
+@@ -172,7 +183,13 @@ mod sync {
+     /// Wake up all threads which wait for value of atomic `FD` to change.
+     pub(super) fn wake() {
+         let op = libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG;
++
++        #[cfg(not(target_arch = "riscv32"))]
+         let ret = unsafe { libc::syscall(libc::SYS_futex, &FD, op, libc::INT_MAX) };
++
++        #[cfg(target_arch = "riscv32")]
++        let ret = unsafe { libc::syscall(libc::SYS_futex_time64, &FD, op, libc::INT_MAX) };
++
+         debug_assert!(ret >= 0);
+     }
+ 
diff --git a/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch b/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
new file mode 100644
index 0000000..37f21af
--- /dev/null
+++ b/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
@@ -0,0 +1,66 @@
+From 78d4c37e9c5b60ea2368627c2fc297dfc46bec2a Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Tue, 22 Jul 2025 10:15:06 -0700
+Subject: [PATCH] Use libc::SYS_futex_time64 on riscv32
+
+On RISC-V 32-bit (riscv32), the SYS_futex system call is
+often handled indirectly due to the use of a 64-bit time_t
+type. Specifically, while SYS_futex is not directly defined,
+a related syscall like SYS_futex_time64 can be used,
+
+Upstream-Status: Submitted [https://github.com/Amanieu/parking_lot/pull/485]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ src/thread_parker/linux.rs | 19 +++++++++++++++++++
+ 1 file changed, 19 insertions(+)
+
+diff --git a/src/thread_parker/linux.rs b/src/thread_parker/linux.rs
+index 92601f6..3695624 100644
+--- a/src/thread_parker/linux.rs
++++ b/src/thread_parker/linux.rs
+@@ -108,6 +108,7 @@ impl ThreadParker {
+             .as_ref()
+             .map(|ts_ref| ts_ref as *const _)
+             .unwrap_or(ptr::null());
++        #[cfg(not(target_arch = "riscv32"))]
+         let r = unsafe {
+             libc::syscall(
+                 libc::SYS_futex,
+@@ -117,6 +118,16 @@ impl ThreadParker {
+                 ts_ptr,
+             )
+         };
++        #[cfg(target_arch = "riscv32")]
++        let r = unsafe {
++            libc::syscall(
++                libc::SYS_futex_time64,
++                &self.futex,
++                libc::FUTEX_WAIT | libc::FUTEX_PRIVATE_FLAG,
++                1,
++                ts_ptr,
++            )
++        };
+         debug_assert!(r == 0 || r == -1);
+         if r == -1 {
+             debug_assert!(
+@@ -137,12 +148,20 @@ impl super::UnparkHandleT for UnparkHandle {
+     unsafe fn unpark(self) {
+         // The thread data may have been freed at this point, but it doesn't
+         // matter since the syscall will just return EFAULT in that case.
++        #[cfg(not(target_arch = "riscv32"))]
+         let r = libc::syscall(
+             libc::SYS_futex,
+             self.futex,
+             libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG,
+             1,
+         );
++        #[cfg(target_arch = "riscv32")]
++        let r = libc::syscall(
++            libc::SYS_futex_time64,
++            self.futex,
++            libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG,
++            1,
++        );
+         debug_assert!(r == 0 || r == 1 || r == -1);
+         if r == -1 {
+             debug_assert_eq!(errno(), libc::EFAULT);
diff --git a/recipes-devtools/rust/cargo-c_0.10.13+cargo-0.88.0.bb b/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
similarity index 50%
rename from recipes-devtools/rust/cargo-c_0.10.13+cargo-0.88.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
index b0f632a..f5907ac 100644
--- a/recipes-devtools/rust/cargo-c_0.10.13+cargo-0.88.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
@@ -5,8 +5,11 @@ LIC_FILES_CHKSUM = " \
     file://LICENSE;md5=384ed0e2e0b2dac094e51fbf93fdcbe0 \
 "
 
-SRC_URI = "crate://crates.io/cargo-c/${PV}"
-SRC_URI[cargo-c.sha256sum] = "bd11efb38aee5930cabfe8d41465f22859b2af9071fa04d3642814cf1cc2bc75"
+SRC_URI = "crate://crates.io/cargo-c/${PV} \
+           file://0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../getrandom-0.3.3/ \
+           file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.11/ \
+"
+SRC_URI[cargo-c.sha256sum] = "fe82742019f0e5c1a9f8549b0f41b20f1bc834f5ed0626c47019f15be566b321"
 
 inherit cargo cargo-update-recipe-crates pkgconfig
 
-- 
2.50.1


