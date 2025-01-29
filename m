Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341ADC02193
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:18 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.19372.1738174157352455154
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n2lw/HbC;
 spf=pass (domain: konsulko.com, ip: 209.85.166.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d0062fb20bso3943515ab.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174156; x=1738778956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HjjdUNgaC1cxRavOzYHQrTxwKPejhA/qvil9HqwuWo=;
        b=n2lw/HbCNkoKYSvhg6rlK2E4K12oHcAKL4HrsrGWS+cvOFzEjyJn4B2lo9QfqJWKEJ
         Et1p8QS5ihqPgRmYsNcXMTxjgnWz3T9OTjn8Bp49le8EoTnGGF7MsKbfeuqdREsgpkPH
         h8tYEJNes0Phy6GiFfz9QKts/M00Al9cni5NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174156; x=1738778956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HjjdUNgaC1cxRavOzYHQrTxwKPejhA/qvil9HqwuWo=;
        b=gPPOPmJxscDVZJ9x/ltLC1z+IPgpab6KL4FtR5QhAUu9kWpKOjEp6Ma3m2gGpQFtHT
         wiz5YxpO9K40HHDe3FmrGny7tl9sOwZzQUShzYU8NOr3VkKgYG081sitABkO/ICqhsPZ
         mTAoUt10ZLzQv8kmEQs5qjkU4ZY88Upy8qJ+XBpJy1AZ/lhX7154+Cm7ksKBk4puJhTv
         g2Bu1xbGmLEDc/38LTzUwZDEll/NhupxWVzzwhagXT2YcveKbIlz86raXZpk+a8kaGD0
         GvR0jpU3UIiuOrFSIgdrpNhDUXoe1/I/zTHV6zZPqc87dKRtanStF/KR2YBIVUS0SIyW
         XYFw==
X-Gm-Message-State: AOJu0YyZY6qhRim0a6Mrqeh7EIu5KeX/m0IiHEvARWVkyr/HLia2Lozk
	hC9ovZsdhaY71QTHTdoKEKkEhQ3zsPFOYEYEKiHcFqS/B5Zl26H6fg1h+73TvkOHt+Wk0wRdsbH
	s
X-Gm-Gg: ASbGncuO4iOXHOWQYBICH7lVqrLO0JxswyfwHIKQPZQNEvnBfBMdVtMGM2brc2YPc/w
	hA78NU3jhWkHoHhJDyYwpCvewVGGS10DFUkfo28qMinT1FE6V3YiZmglg3/HoKknm7xvP3N9Xip
	l1Vpa3X/vTiN9mEyvdx66hyDeC3O/lfZNV/96Pom95tmzgeziN9QD0PoeC2/gEtuGaz1bHRJXvI
	arSIi2n+2D+z5teL6mtq+wf3FQn6jBDhEVYu5+cKEUvVlM51z8rOBR4KEGLxYa4ispI8y0evL/c
	BQhuDLcRIACB4A+vLqg2MamaFoyiNNwAXCTgftMgqn1518cDQywDJjdmuXvMalb4On8=
X-Google-Smtp-Source: AGHT+IFrevFMps0xL9KLFMCDL6KRB3D9WBBdyW3ITnj7zMdGtbMeApnfp4FmYdGIhhaZkzBLfXIR/Q==
X-Received: by 2002:a05:6e02:1d05:b0:3cf:6eb8:b7b2 with SMTP id e9e14a558f8ab-3cffe4b0ff2mr35082045ab.20.1738174154940;
        Wed, 29 Jan 2025 10:09:14 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:14 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 2/9] cargo-c-native: update 0.10.3 -> 0.10.5
Date: Wed, 29 Jan 2025 13:08:53 -0500
Message-ID: <df567cda2dee2eecc65819e498112a0f8d94e0e1.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1016

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 942b6ab25f0c1df02920997b63db89187fbdeea1)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c-crates.inc      | 478 +++++++++---------
 ... => cargo-c-native_0.10.5+cargo-0.83.0.bb} |   2 +-
 2 files changed, 243 insertions(+), 237 deletions(-)
 rename recipes-devtools/rust/{cargo-c-native_0.10.3+cargo-0.81.0.bb => cargo-c-native_0.10.5+cargo-0.83.0.bb} (82%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/rust/cargo-c-crates.inc
index 2c84c32..8f4a223 100644
--- a/recipes-devtools/rust/cargo-c-crates.inc
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -2,7 +2,7 @@
 
 # from Cargo.lock
 SRC_URI += " \
-    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/adler2/2.0.0 \
     crate://crates.io/ahash/0.8.11 \
     crate://crates.io/aho-corasick/1.1.3 \
     crate://crates.io/allocator-api2/0.2.18 \
@@ -12,35 +12,34 @@ SRC_URI += " \
     crate://crates.io/anstyle-parse/0.2.5 \
     crate://crates.io/anstyle-query/1.1.1 \
     crate://crates.io/anstyle-wincon/3.0.4 \
-    crate://crates.io/anyhow/1.0.86 \
+    crate://crates.io/anyhow/1.0.89 \
     crate://crates.io/arc-swap/1.7.1 \
-    crate://crates.io/autocfg/1.3.0 \
+    crate://crates.io/autocfg/1.4.0 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
     crate://crates.io/base64ct/1.6.0 \
-    crate://crates.io/bitflags/1.3.2 \
     crate://crates.io/bitflags/2.6.0 \
     crate://crates.io/bitmaps/2.1.0 \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/bstr/1.10.0 \
     crate://crates.io/bumpalo/3.16.0 \
     crate://crates.io/byteorder/1.5.0 \
-    crate://crates.io/bytes/1.6.1 \
+    crate://crates.io/bytes/1.7.2 \
     crate://crates.io/bytesize/1.3.0 \
-    crate://crates.io/cargo/0.81.0 \
+    crate://crates.io/cargo/0.83.0 \
     crate://crates.io/cargo-credential/0.4.6 \
-    crate://crates.io/cargo-credential-libsecret/0.4.6 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.6 \
-    crate://crates.io/cargo-credential-wincred/0.4.6 \
+    crate://crates.io/cargo-credential-libsecret/0.4.8 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.8 \
+    crate://crates.io/cargo-credential-wincred/0.4.8 \
     crate://crates.io/cargo-platform/0.1.8 \
-    crate://crates.io/cargo-util/0.2.13 \
-    crate://crates.io/cargo-util-schemas/0.4.0 \
-    crate://crates.io/cbindgen/0.26.0 \
-    crate://crates.io/cc/1.1.7 \
+    crate://crates.io/cargo-util/0.2.15 \
+    crate://crates.io/cargo-util-schemas/0.6.0 \
+    crate://crates.io/cbindgen/0.27.0 \
+    crate://crates.io/cc/1.1.30 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/4.5.11 \
-    crate://crates.io/clap_builder/4.5.11 \
-    crate://crates.io/clap_derive/4.5.11 \
+    crate://crates.io/clap/4.5.20 \
+    crate://crates.io/clap_builder/4.5.20 \
+    crate://crates.io/clap_derive/4.5.18 \
     crate://crates.io/clap_lex/0.7.2 \
     crate://crates.io/clru/0.6.2 \
     crate://crates.io/color-print/0.3.6 \
@@ -48,9 +47,9 @@ SRC_URI += " \
     crate://crates.io/colorchoice/1.0.2 \
     crate://crates.io/const-oid/0.9.6 \
     crate://crates.io/core-foundation/0.9.4 \
-    crate://crates.io/core-foundation-sys/0.8.6 \
-    crate://crates.io/cpufeatures/0.2.12 \
-    crate://crates.io/crates-io/0.40.3 \
+    crate://crates.io/core-foundation-sys/0.8.7 \
+    crate://crates.io/cpufeatures/0.2.14 \
+    crate://crates.io/crates-io/0.40.5 \
     crate://crates.io/crc32fast/1.4.2 \
     crate://crates.io/crossbeam-channel/0.5.13 \
     crate://crates.io/crossbeam-deque/0.8.5 \
@@ -58,14 +57,14 @@ SRC_URI += " \
     crate://crates.io/crossbeam-utils/0.8.20 \
     crate://crates.io/crypto-bigint/0.5.5 \
     crate://crates.io/crypto-common/0.1.6 \
-    crate://crates.io/ct-codecs/1.1.1 \
-    crate://crates.io/curl/0.4.46 \
-    crate://crates.io/curl-sys/0.4.73+curl-8.8.0 \
+    crate://crates.io/ct-codecs/1.1.2 \
+    crate://crates.io/curl/0.4.47 \
+    crate://crates.io/curl-sys/0.4.77+curl-8.10.1 \
     crate://crates.io/dbus/0.9.7 \
     crate://crates.io/der/0.7.9 \
     crate://crates.io/deranged/0.3.11 \
     crate://crates.io/digest/0.10.7 \
-    crate://crates.io/dunce/1.0.4 \
+    crate://crates.io/dunce/1.0.5 \
     crate://crates.io/ecdsa/0.16.9 \
     crate://crates.io/ed25519-compact/2.1.1 \
     crate://crates.io/either/1.13.0 \
@@ -77,40 +76,42 @@ SRC_URI += " \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
     crate://crates.io/faster-hex/0.9.0 \
-    crate://crates.io/fastrand/2.1.0 \
+    crate://crates.io/fastrand/2.1.1 \
     crate://crates.io/ff/0.13.0 \
     crate://crates.io/fiat-crypto/0.2.9 \
-    crate://crates.io/filetime/0.2.23 \
-    crate://crates.io/flate2/1.0.30 \
+    crate://crates.io/filetime/0.2.25 \
+    crate://crates.io/flate2/1.0.34 \
     crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/foldhash/0.1.3 \
     crate://crates.io/foreign-types/0.3.2 \
     crate://crates.io/foreign-types-shared/0.1.1 \
     crate://crates.io/form_urlencoded/1.2.1 \
     crate://crates.io/generic-array/0.14.7 \
     crate://crates.io/getrandom/0.2.15 \
-    crate://crates.io/git2/0.18.3 \
-    crate://crates.io/git2-curl/0.19.0 \
-    crate://crates.io/gix/0.63.0 \
+    crate://crates.io/git2/0.19.0 \
+    crate://crates.io/git2-curl/0.20.0 \
+    crate://crates.io/gix/0.64.0 \
     crate://crates.io/gix-actor/0.31.5 \
-    crate://crates.io/gix-attributes/0.22.3 \
+    crate://crates.io/gix-attributes/0.22.5 \
     crate://crates.io/gix-bitmap/0.2.11 \
     crate://crates.io/gix-chunk/0.4.8 \
-    crate://crates.io/gix-command/0.3.8 \
+    crate://crates.io/gix-command/0.3.9 \
     crate://crates.io/gix-commitgraph/0.24.3 \
-    crate://crates.io/gix-config/0.37.0 \
-    crate://crates.io/gix-config-value/0.14.7 \
-    crate://crates.io/gix-credentials/0.24.4 \
+    crate://crates.io/gix-config/0.38.0 \
+    crate://crates.io/gix-config-value/0.14.8 \
+    crate://crates.io/gix-credentials/0.24.5 \
     crate://crates.io/gix-date/0.8.7 \
+    crate://crates.io/gix-date/0.9.0 \
     crate://crates.io/gix-diff/0.44.1 \
-    crate://crates.io/gix-dir/0.5.0 \
-    crate://crates.io/gix-discover/0.32.0 \
+    crate://crates.io/gix-dir/0.6.0 \
+    crate://crates.io/gix-discover/0.33.0 \
     crate://crates.io/gix-features/0.38.2 \
     crate://crates.io/gix-filter/0.11.3 \
-    crate://crates.io/gix-fs/0.11.2 \
-    crate://crates.io/gix-glob/0.16.4 \
+    crate://crates.io/gix-fs/0.11.3 \
+    crate://crates.io/gix-glob/0.16.5 \
     crate://crates.io/gix-hash/0.14.2 \
     crate://crates.io/gix-hashtable/0.5.2 \
-    crate://crates.io/gix-ignore/0.11.3 \
+    crate://crates.io/gix-ignore/0.11.4 \
     crate://crates.io/gix-index/0.33.1 \
     crate://crates.io/gix-lock/14.0.0 \
     crate://crates.io/gix-macros/0.1.5 \
@@ -118,32 +119,32 @@ SRC_URI += " \
     crate://crates.io/gix-object/0.42.3 \
     crate://crates.io/gix-odb/0.61.1 \
     crate://crates.io/gix-pack/0.51.1 \
-    crate://crates.io/gix-packetline/0.17.5 \
-    crate://crates.io/gix-packetline-blocking/0.17.4 \
-    crate://crates.io/gix-path/0.10.9 \
-    crate://crates.io/gix-pathspec/0.7.6 \
-    crate://crates.io/gix-prompt/0.8.6 \
-    crate://crates.io/gix-protocol/0.45.2 \
+    crate://crates.io/gix-packetline/0.17.6 \
+    crate://crates.io/gix-packetline-blocking/0.17.5 \
+    crate://crates.io/gix-path/0.10.11 \
+    crate://crates.io/gix-pathspec/0.7.7 \
+    crate://crates.io/gix-prompt/0.8.7 \
+    crate://crates.io/gix-protocol/0.45.3 \
     crate://crates.io/gix-quote/0.4.12 \
-    crate://crates.io/gix-ref/0.44.1 \
+    crate://crates.io/gix-ref/0.45.0 \
     crate://crates.io/gix-refspec/0.23.1 \
     crate://crates.io/gix-revision/0.27.2 \
     crate://crates.io/gix-revwalk/0.13.2 \
-    crate://crates.io/gix-sec/0.10.7 \
-    crate://crates.io/gix-submodule/0.11.0 \
-    crate://crates.io/gix-tempfile/14.0.1 \
-    crate://crates.io/gix-trace/0.1.9 \
-    crate://crates.io/gix-transport/0.42.2 \
+    crate://crates.io/gix-sec/0.10.8 \
+    crate://crates.io/gix-submodule/0.12.0 \
+    crate://crates.io/gix-tempfile/14.0.2 \
+    crate://crates.io/gix-trace/0.1.10 \
+    crate://crates.io/gix-transport/0.42.3 \
     crate://crates.io/gix-traverse/0.39.2 \
-    crate://crates.io/gix-url/0.27.4 \
+    crate://crates.io/gix-url/0.27.5 \
     crate://crates.io/gix-utils/0.1.12 \
     crate://crates.io/gix-validate/0.8.5 \
     crate://crates.io/gix-worktree/0.34.1 \
     crate://crates.io/glob/0.3.1 \
-    crate://crates.io/globset/0.4.14 \
+    crate://crates.io/globset/0.4.15 \
     crate://crates.io/group/0.13.0 \
-    crate://crates.io/hashbrown/0.12.3 \
     crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/hashbrown/0.15.0 \
     crate://crates.io/hashlink/0.9.1 \
     crate://crates.io/heck/0.4.1 \
     crate://crates.io/heck/0.5.0 \
@@ -151,109 +152,114 @@ SRC_URI += " \
     crate://crates.io/hkdf/0.12.4 \
     crate://crates.io/hmac/0.12.1 \
     crate://crates.io/home/0.5.9 \
-    crate://crates.io/http-auth/0.1.9 \
+    crate://crates.io/http-auth/0.1.10 \
     crate://crates.io/humantime/2.1.0 \
     crate://crates.io/idna/0.5.0 \
-    crate://crates.io/ignore/0.4.22 \
+    crate://crates.io/ignore/0.4.23 \
     crate://crates.io/im-rc/15.1.0 \
-    crate://crates.io/indexmap/1.9.3 \
-    crate://crates.io/indexmap/2.2.6 \
+    crate://crates.io/implib/0.3.3 \
+    crate://crates.io/indexmap/2.6.0 \
     crate://crates.io/is_terminal_polyfill/1.70.1 \
-    crate://crates.io/itertools/0.12.1 \
     crate://crates.io/itertools/0.13.0 \
     crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/jiff/0.1.13 \
+    crate://crates.io/jiff-tzdb/0.1.1 \
+    crate://crates.io/jiff-tzdb-platform/0.1.1 \
     crate://crates.io/jobserver/0.1.32 \
-    crate://crates.io/js-sys/0.3.69 \
+    crate://crates.io/js-sys/0.3.72 \
     crate://crates.io/kstring/2.0.2 \
     crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/lazycell/1.3.0 \
-    crate://crates.io/libc/0.2.155 \
+    crate://crates.io/libc/0.2.161 \
     crate://crates.io/libdbus-sys/0.2.5 \
-    crate://crates.io/libgit2-sys/0.16.2+1.7.2 \
+    crate://crates.io/libgit2-sys/0.17.0+1.8.1 \
     crate://crates.io/libloading/0.8.5 \
     crate://crates.io/libnghttp2-sys/0.1.10+1.61.0 \
-    crate://crates.io/libsqlite3-sys/0.28.0 \
+    crate://crates.io/libredox/0.1.3 \
+    crate://crates.io/libsqlite3-sys/0.30.1 \
     crate://crates.io/libssh2-sys/0.3.0 \
-    crate://crates.io/libz-sys/1.1.18 \
+    crate://crates.io/libz-sys/1.1.20 \
     crate://crates.io/linux-raw-sys/0.4.14 \
     crate://crates.io/lock_api/0.4.12 \
     crate://crates.io/log/0.4.22 \
     crate://crates.io/matchers/0.1.0 \
     crate://crates.io/maybe-async/0.2.10 \
     crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/memmap2/0.9.4 \
+    crate://crates.io/memmap2/0.9.5 \
+    crate://crates.io/memoffset/0.9.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.7.4 \
+    crate://crates.io/miniz_oxide/0.8.0 \
     crate://crates.io/miow/0.6.0 \
     crate://crates.io/nom/7.1.3 \
-    crate://crates.io/normpath/1.2.0 \
+    crate://crates.io/normpath/1.3.0 \
     crate://crates.io/nu-ansi-term/0.46.0 \
     crate://crates.io/num-conv/0.1.0 \
     crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/num_threads/0.1.7 \
-    crate://crates.io/once_cell/1.19.0 \
-    crate://crates.io/opener/0.7.1 \
-    crate://crates.io/openssl/0.10.66 \
+    crate://crates.io/object/0.36.5 \
+    crate://crates.io/once_cell/1.20.2 \
+    crate://crates.io/opener/0.7.2 \
+    crate://crates.io/openssl/0.10.57 \
     crate://crates.io/openssl-macros/0.1.1 \
     crate://crates.io/openssl-probe/0.1.5 \
-    crate://crates.io/openssl-src/300.3.1+3.3.1 \
-    crate://crates.io/openssl-sys/0.9.103 \
+    crate://crates.io/openssl-src/300.3.2+3.3.2 \
+    crate://crates.io/openssl-sys/0.9.104 \
     crate://crates.io/ordered-float/2.10.1 \
-    crate://crates.io/orion/0.17.6 \
+    crate://crates.io/orion/0.17.7 \
     crate://crates.io/os_info/3.8.2 \
     crate://crates.io/overload/0.1.1 \
     crate://crates.io/p384/0.13.0 \
     crate://crates.io/parking_lot/0.12.3 \
     crate://crates.io/parking_lot_core/0.9.10 \
     crate://crates.io/pasetors/0.6.8 \
-    crate://crates.io/pathdiff/0.2.1 \
+    crate://crates.io/pathdiff/0.2.2 \
     crate://crates.io/pem-rfc7468/0.7.0 \
     crate://crates.io/percent-encoding/2.3.1 \
     crate://crates.io/pin-project-lite/0.2.14 \
     crate://crates.io/pkcs8/0.10.2 \
-    crate://crates.io/pkg-config/0.3.30 \
+    crate://crates.io/pkg-config/0.3.31 \
     crate://crates.io/powerfmt/0.2.0 \
-    crate://crates.io/ppv-lite86/0.2.18 \
+    crate://crates.io/ppv-lite86/0.2.20 \
     crate://crates.io/primeorder/0.13.6 \
-    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/proc-macro2/1.0.88 \
     crate://crates.io/prodash/28.0.0 \
-    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/quote/1.0.37 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_xoshiro/0.6.0 \
-    crate://crates.io/redox_syscall/0.4.1 \
-    crate://crates.io/redox_syscall/0.5.3 \
-    crate://crates.io/regex/1.10.5 \
+    crate://crates.io/redox_syscall/0.5.7 \
+    crate://crates.io/regex/1.11.0 \
     crate://crates.io/regex-automata/0.1.10 \
-    crate://crates.io/regex-automata/0.4.7 \
+    crate://crates.io/regex-automata/0.4.8 \
     crate://crates.io/regex-syntax/0.6.29 \
-    crate://crates.io/regex-syntax/0.8.4 \
+    crate://crates.io/regex-syntax/0.8.5 \
     crate://crates.io/rfc6979/0.4.0 \
-    crate://crates.io/rusqlite/0.31.0 \
-    crate://crates.io/rustfix/0.8.4 \
-    crate://crates.io/rustix/0.38.34 \
+    crate://crates.io/rusqlite/0.32.1 \
+    crate://crates.io/rustfix/0.8.6 \
+    crate://crates.io/rustix/0.38.37 \
     crate://crates.io/ryu/1.0.18 \
     crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/schannel/0.1.23 \
+    crate://crates.io/schannel/0.1.26 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/sec1/0.7.3 \
     crate://crates.io/security-framework/2.11.1 \
-    crate://crates.io/security-framework-sys/2.11.1 \
+    crate://crates.io/security-framework-sys/2.12.0 \
     crate://crates.io/semver/1.0.23 \
-    crate://crates.io/serde/1.0.204 \
+    crate://crates.io/serde/1.0.210 \
     crate://crates.io/serde-untagged/0.1.6 \
     crate://crates.io/serde-value/0.7.0 \
-    crate://crates.io/serde_derive/1.0.204 \
+    crate://crates.io/serde_derive/1.0.210 \
     crate://crates.io/serde_ignored/0.1.10 \
-    crate://crates.io/serde_json/1.0.121 \
-    crate://crates.io/serde_spanned/0.6.7 \
+    crate://crates.io/serde_json/1.0.129 \
+    crate://crates.io/serde_spanned/0.6.8 \
     crate://crates.io/sha1/0.10.6 \
     crate://crates.io/sha1_smol/1.0.1 \
     crate://crates.io/sha2/0.10.8 \
     crate://crates.io/sharded-slab/0.1.7 \
     crate://crates.io/shell-escape/0.1.5 \
     crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/shlex/1.3.0 \
     crate://crates.io/signature/2.2.0 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/smallvec/1.13.2 \
@@ -264,38 +270,36 @@ SRC_URI += " \
     crate://crates.io/subtle/2.6.1 \
     crate://crates.io/supports-hyperlinks/3.0.0 \
     crate://crates.io/supports-unicode/3.0.0 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.72 \
-    crate://crates.io/tar/0.4.41 \
-    crate://crates.io/tempfile/3.10.1 \
-    crate://crates.io/terminal_size/0.3.0 \
-    crate://crates.io/thiserror/1.0.63 \
-    crate://crates.io/thiserror-impl/1.0.63 \
+    crate://crates.io/syn/2.0.79 \
+    crate://crates.io/tar/0.4.42 \
+    crate://crates.io/tempfile/3.13.0 \
+    crate://crates.io/terminal_size/0.4.0 \
+    crate://crates.io/thiserror/1.0.64 \
+    crate://crates.io/thiserror-impl/1.0.64 \
     crate://crates.io/thread_local/1.1.8 \
     crate://crates.io/time/0.3.36 \
     crate://crates.io/time-core/0.1.2 \
     crate://crates.io/time-macros/0.2.18 \
     crate://crates.io/tinyvec/1.8.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.5.11 \
-    crate://crates.io/toml/0.8.16 \
-    crate://crates.io/toml_datetime/0.6.7 \
-    crate://crates.io/toml_edit/0.22.17 \
+    crate://crates.io/toml/0.8.19 \
+    crate://crates.io/toml_datetime/0.6.8 \
+    crate://crates.io/toml_edit/0.22.22 \
     crate://crates.io/tracing/0.1.40 \
     crate://crates.io/tracing-attributes/0.1.27 \
     crate://crates.io/tracing-chrome/0.7.2 \
     crate://crates.io/tracing-core/0.1.32 \
     crate://crates.io/tracing-log/0.2.0 \
     crate://crates.io/tracing-subscriber/0.3.18 \
-    crate://crates.io/typeid/1.0.0 \
+    crate://crates.io/typeid/1.0.2 \
     crate://crates.io/typenum/1.17.0 \
     crate://crates.io/unicase/2.7.0 \
-    crate://crates.io/unicode-bidi/0.3.15 \
+    crate://crates.io/unicode-bidi/0.3.17 \
     crate://crates.io/unicode-bom/2.0.3 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-normalization/0.1.23 \
-    crate://crates.io/unicode-width/0.1.13 \
-    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/unicode-ident/1.0.13 \
+    crate://crates.io/unicode-normalization/0.1.24 \
+    crate://crates.io/unicode-width/0.1.14 \
+    crate://crates.io/unicode-xid/0.2.6 \
     crate://crates.io/url/2.5.2 \
     crate://crates.io/utf8parse/0.2.2 \
     crate://crates.io/valuable/0.1.0 \
@@ -303,17 +307,18 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.92 \
-    crate://crates.io/wasm-bindgen-backend/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
-    crate://crates.io/wasm-bindgen-shared/0.2.92 \
+    crate://crates.io/wasm-bindgen/0.2.95 \
+    crate://crates.io/wasm-bindgen-backend/0.2.95 \
+    crate://crates.io/wasm-bindgen-macro/0.2.95 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.95 \
+    crate://crates.io/wasm-bindgen-shared/0.2.95 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.8 \
+    crate://crates.io/winapi-util/0.1.9 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
     crate://crates.io/windows-sys/0.48.0 \
     crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-sys/0.59.0 \
     crate://crates.io/windows-targets/0.48.5 \
     crate://crates.io/windows-targets/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
@@ -331,15 +336,13 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.48.5 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/winnow/0.6.16 \
-    crate://crates.io/zerocopy/0.6.6 \
+    crate://crates.io/winnow/0.6.20 \
     crate://crates.io/zerocopy/0.7.35 \
-    crate://crates.io/zerocopy-derive/0.6.6 \
     crate://crates.io/zerocopy-derive/0.7.35 \
     crate://crates.io/zeroize/1.8.1 \
 "
 
-SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[adler2-2.0.0.sha256sum] = "512761e0bb2578dd7380c6baaa0f4ce03e84f95e960231d1dec8bf4d7d6e2627"
 SRC_URI[ahash-0.8.11.sha256sum] = "e89da841a80418a9b391ebaea17f5c112ffaaa96f621d2c285b5174da76b9011"
 SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
 SRC_URI[allocator-api2-0.2.18.sha256sum] = "5c6cb57a04249c6480766f7f7cef5467412af1490f8d1e243141daddada3264f"
@@ -349,35 +352,34 @@ SRC_URI[anstyle-1.0.8.sha256sum] = "1bec1de6f59aedf83baf9ff929c98f2ad654b97c9510
 SRC_URI[anstyle-parse-0.2.5.sha256sum] = "eb47de1e80c2b463c735db5b217a0ddc39d612e7ac9e2e96a5aed1f57616c1cb"
 SRC_URI[anstyle-query-1.1.1.sha256sum] = "6d36fc52c7f6c869915e99412912f22093507da8d9e942ceaf66fe4b7c14422a"
 SRC_URI[anstyle-wincon-3.0.4.sha256sum] = "5bf74e1b6e971609db8ca7a9ce79fd5768ab6ae46441c572e46cf596f59e57f8"
-SRC_URI[anyhow-1.0.86.sha256sum] = "b3d1d046238990b9cf5bcde22a3fb3584ee5cf65fb2765f454ed428c7a0063da"
+SRC_URI[anyhow-1.0.89.sha256sum] = "86fdf8605db99b54d3cd748a44c6d04df638eb5dafb219b135d0149bd0db01f6"
 SRC_URI[arc-swap-1.7.1.sha256sum] = "69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
-SRC_URI[autocfg-1.3.0.sha256sum] = "0c4b4d0bd25bd0b74681c0ad21497610ce1b7c91b1022cd21c80c6fbdd9476b0"
+SRC_URI[autocfg-1.4.0.sha256sum] = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
 SRC_URI[base64ct-1.6.0.sha256sum] = "8c3c1a368f70d6cf7302d78f8f7093da241fb8e8807c05cc9e51a125895a6d5b"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
 SRC_URI[bitflags-2.6.0.sha256sum] = "b048fb63fd8b5923fc5aa7b340d8e156aec7ec02f0c78fa8a6ddc2613f6f71de"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[bstr-1.10.0.sha256sum] = "40723b8fb387abc38f4f4a37c09073622e41dd12327033091ef8950659e6dc0c"
 SRC_URI[bumpalo-3.16.0.sha256sum] = "79296716171880943b8470b5f8d03aa55eb2e645a4874bdbb28adb49162e012c"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
-SRC_URI[bytes-1.6.1.sha256sum] = "a12916984aab3fa6e39d655a33e09c0071eb36d6ab3aea5c2d78551f1df6d952"
+SRC_URI[bytes-1.7.2.sha256sum] = "428d9aa8fbc0670b7b8d6030a7fadd0f86151cae55e4dbbece15f3780a3dfaf3"
 SRC_URI[bytesize-1.3.0.sha256sum] = "a3e368af43e418a04d52505cf3dbc23dda4e3407ae2fa99fd0e4f308ce546acc"
-SRC_URI[cargo-0.81.0.sha256sum] = "f24c9dcadcdad2f6fa2553b63d5e9c9700fa6932b75d53f3b11b8aea35ebab99"
+SRC_URI[cargo-0.83.0.sha256sum] = "82921fd88b95a7c1a66106437f00f701169c656e221bba9f76f9d983e01e6b7b"
 SRC_URI[cargo-credential-0.4.6.sha256sum] = "3a3e7c625670eacbefd48f552588c491eccc79a85a96898af13af7b312d1c4cd"
-SRC_URI[cargo-credential-libsecret-0.4.6.sha256sum] = "7133c8156697989e0d3547f886083bdcb4d7463be67699c37c206152e46925b0"
-SRC_URI[cargo-credential-macos-keychain-0.4.6.sha256sum] = "5e238786dd6bc99a94a99a108a0fedcc7e786a86c81b8e9857da88ca3caac3d0"
-SRC_URI[cargo-credential-wincred-0.4.6.sha256sum] = "cc0e24a553bb387e22fd5a18f49b72f15db22426b5a0cd37c5fc804978f5ce13"
+SRC_URI[cargo-credential-libsecret-0.4.8.sha256sum] = "7f83dd22c4024559012dd1f05b4391aa07c7765a935a4a6fc44ef34ba6cd6193"
+SRC_URI[cargo-credential-macos-keychain-0.4.8.sha256sum] = "8ace02b644d20964a5e62067ed931600a1bdf88e43890bd881941643d56465d5"
+SRC_URI[cargo-credential-wincred-0.4.8.sha256sum] = "5bfc1351f7d7a121209e9ac65622abd8605cd411b502f7d9c88a8dfce26ebec5"
 SRC_URI[cargo-platform-0.1.8.sha256sum] = "24b1f0365a6c6bb4020cd05806fd0d33c44d38046b8bd7f0e40814b9763cabfc"
-SRC_URI[cargo-util-0.2.13.sha256sum] = "14104698cb1694d43c2ff73492468ccf2bb0b047071a9838d999eeba9e984ffa"
-SRC_URI[cargo-util-schemas-0.4.0.sha256sum] = "34ddc7fc157e3dbbd88f05ef8be7c3ed3ecb05925a3f51f716d6103a607fb7c4"
-SRC_URI[cbindgen-0.26.0.sha256sum] = "da6bc11b07529f16944307272d5bd9b22530bc7d05751717c9d416586cedab49"
-SRC_URI[cc-1.1.7.sha256sum] = "26a5c3fd7bfa1ce3897a3a3501d362b2d87b7f2583ebcb4a949ec25911025cbc"
+SRC_URI[cargo-util-0.2.15.sha256sum] = "b6dd67a24439ca5260a08128b6cbf4b0f4453497a2f60508163ab9d5b534b122"
+SRC_URI[cargo-util-schemas-0.6.0.sha256sum] = "3c052794544a1be7decd4bbfbe08440f9331bf2df90f95c3a731bdf21c4b7d98"
+SRC_URI[cbindgen-0.27.0.sha256sum] = "3fce8dd7fcfcbf3a0a87d8f515194b49d6135acab73e18bd380d1d93bb1a15eb"
+SRC_URI[cc-1.1.30.sha256sum] = "b16803a61b81d9eabb7eae2588776c4c1e584b738ede45fdbb4c972cec1e9945"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[clap-4.5.11.sha256sum] = "35723e6a11662c2afb578bcf0b88bf6ea8e21282a953428f240574fcc3a2b5b3"
-SRC_URI[clap_builder-4.5.11.sha256sum] = "49eb96cbfa7cfa35017b7cd548c75b14c3118c98b423041d70562665e07fb0fa"
-SRC_URI[clap_derive-4.5.11.sha256sum] = "5d029b67f89d30bbb547c89fd5161293c0aec155fc691d7924b64550662db93e"
+SRC_URI[clap-4.5.20.sha256sum] = "b97f376d85a664d5837dbae44bf546e6477a679ff6610010f17276f686d867e8"
+SRC_URI[clap_builder-4.5.20.sha256sum] = "19bc80abd44e4bed93ca373a0704ccbd1b710dc5749406201bb018272808dc54"
+SRC_URI[clap_derive-4.5.18.sha256sum] = "4ac6a0c7b1a9e9a5186361f67dfa1b88213572f427fb9ab038efb2bd8c582dab"
 SRC_URI[clap_lex-0.7.2.sha256sum] = "1462739cb27611015575c0c11df5df7601141071f07518d56fcc1be504cbec97"
 SRC_URI[clru-0.6.2.sha256sum] = "cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
 SRC_URI[color-print-0.3.6.sha256sum] = "1ee543c60ff3888934877a5671f45494dd27ed4ba25c6670b9a7576b7ed7a8c0"
@@ -385,9 +387,9 @@ SRC_URI[color-print-proc-macro-0.3.6.sha256sum] = "77ff1a80c5f3cb1ca7c06ffdd71b6
 SRC_URI[colorchoice-1.0.2.sha256sum] = "d3fd119d74b830634cea2a0f58bbd0d54540518a14397557951e79340abc28c0"
 SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
 SRC_URI[core-foundation-0.9.4.sha256sum] = "91e195e091a93c46f7102ec7818a2aa394e1e1771c3ab4825963fa03e45afb8f"
-SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
-SRC_URI[cpufeatures-0.2.12.sha256sum] = "53fe5e26ff1b7aef8bca9c6080520cfb8d9333c7568e1829cef191a9723e5504"
-SRC_URI[crates-io-0.40.3.sha256sum] = "3b7837d3d2ea5d21a399489029609840d95608bfdf1dc5fd8604392df4b219b3"
+SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+SRC_URI[cpufeatures-0.2.14.sha256sum] = "608697df725056feaccfa42cffdaeeec3fccc4ffc38358ecd19b243e716a78e0"
+SRC_URI[crates-io-0.40.5.sha256sum] = "5c1f3f1277728b222abe5d05f2683e6643344de0ed563eb46d3574b6cd3cf1c3"
 SRC_URI[crc32fast-1.4.2.sha256sum] = "a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
 SRC_URI[crossbeam-channel-0.5.13.sha256sum] = "33480d6946193aa8033910124896ca395333cae7e2d1113d1fef6c3272217df2"
 SRC_URI[crossbeam-deque-0.8.5.sha256sum] = "613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
@@ -395,14 +397,14 @@ SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5
 SRC_URI[crossbeam-utils-0.8.20.sha256sum] = "22ec99545bb0ed0ea7bb9b8e1e9122ea386ff8a48c0922e43f36d45ab09e0e80"
 SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
-SRC_URI[ct-codecs-1.1.1.sha256sum] = "f3b7eb4404b8195a9abb6356f4ac07d8ba267045c8d6d220ac4dc992e6cc75df"
-SRC_URI[curl-0.4.46.sha256sum] = "1e2161dd6eba090ff1594084e95fd67aeccf04382ffea77999ea94ed42ec67b6"
-SRC_URI[curl-sys-0.4.73+curl-8.8.0.sha256sum] = "450ab250ecf17227c39afb9a2dd9261dc0035cb80f2612472fc0c4aac2dcb84d"
+SRC_URI[ct-codecs-1.1.2.sha256sum] = "026ac6ceace6298d2c557ef5ed798894962296469ec7842288ea64674201a2d1"
+SRC_URI[curl-0.4.47.sha256sum] = "d9fb4d13a1be2b58f14d60adba57c9834b78c62fd86c3e76a148f732686e9265"
+SRC_URI[curl-sys-0.4.77+curl-8.10.1.sha256sum] = "f469e8a5991f277a208224f6c7ad72ecb5f986e36d09ae1f2c1bb9259478a480"
 SRC_URI[dbus-0.9.7.sha256sum] = "1bb21987b9fb1613058ba3843121dd18b163b254d8a6e797e144cbac14d96d1b"
 SRC_URI[der-0.7.9.sha256sum] = "f55bf8e7b65898637379c1b74eb1551107c8294ed26d855ceb9fd1a09cfc9bc0"
 SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
 SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
-SRC_URI[dunce-1.0.4.sha256sum] = "56ce8c6da7551ec6c462cbaf3bfbc75131ebbfa1c944aeaa9dab51ca1c5f0c3b"
+SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
 SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
 SRC_URI[ed25519-compact-2.1.1.sha256sum] = "e9b3460f44bea8cd47f45a0c70892f1eff856d97cd55358b2f73f663789f6190"
 SRC_URI[either-1.13.0.sha256sum] = "60b1af1c220855b6ceac025d3f6ecdd2b7c4894bfe9cd9bda4fbb4bc7c0d4cf0"
@@ -414,40 +416,42 @@ SRC_URI[errno-0.3.9.sha256sum] = "534c5cf6194dfab3db3242765c03bbe257cf92f22b38f6
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
 SRC_URI[faster-hex-0.9.0.sha256sum] = "a2a2b11eda1d40935b26cf18f6833c526845ae8c41e58d09af6adeb6f0269183"
-SRC_URI[fastrand-2.1.0.sha256sum] = "9fc0510504f03c51ada170672ac806f1f105a88aa97a5281117e1ddc3368e51a"
+SRC_URI[fastrand-2.1.1.sha256sum] = "e8c02a5121d4ea3eb16a80748c74f5549a5665e4c21333c6098f283870fbdea6"
 SRC_URI[ff-0.13.0.sha256sum] = "ded41244b729663b1e574f1b4fb731469f69f79c17667b5d776b16cda0479449"
 SRC_URI[fiat-crypto-0.2.9.sha256sum] = "28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
-SRC_URI[filetime-0.2.23.sha256sum] = "1ee447700ac8aa0b2f2bd7bc4462ad686ba06baa6727ac149a2d6277f0d240fd"
-SRC_URI[flate2-1.0.30.sha256sum] = "5f54427cfd1c7829e2a139fcefea601bf088ebca651d2bf53ebc600eac295dae"
+SRC_URI[filetime-0.2.25.sha256sum] = "35c0522e981e68cbfa8c3f978441a5f34b30b96e146b33cd3359176b50fe8586"
+SRC_URI[flate2-1.0.34.sha256sum] = "a1b589b4dc103969ad3cf85c950899926ec64300a1a46d76c03a6072957036f0"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[foldhash-0.1.3.sha256sum] = "f81ec6369c545a7d40e4589b5597581fa1c441fe1cce96dd1de43159910a36a2"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
 SRC_URI[foreign-types-shared-0.1.1.sha256sum] = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
 SRC_URI[form_urlencoded-1.2.1.sha256sum] = "e13624c2627564efccf4934284bdd98cbaa14e79b0b5a141218e507b3a823456"
 SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
 SRC_URI[getrandom-0.2.15.sha256sum] = "c4567c8db10ae91089c99af84c68c38da3ec2f087c3f82960bcdbf3656b6f4d7"
-SRC_URI[git2-0.18.3.sha256sum] = "232e6a7bfe35766bf715e55a88b39a700596c0ccfd88cd3680b4cdb40d66ef70"
-SRC_URI[git2-curl-0.19.0.sha256sum] = "78e26b61608c573ffd26fc79061a823aa5147449a1afe1f61679a21e2031f7c3"
-SRC_URI[gix-0.63.0.sha256sum] = "984c5018adfa7a4536ade67990b3ebc6e11ab57b3d6cd9968de0947ca99b4b06"
+SRC_URI[git2-0.19.0.sha256sum] = "b903b73e45dc0c6c596f2d37eccece7c1c8bb6e4407b001096387c63d0d93724"
+SRC_URI[git2-curl-0.20.0.sha256sum] = "68ff14527a1c242320039b138376f8e0786697a1b7b172bc44f6efda3ab9079f"
+SRC_URI[gix-0.64.0.sha256sum] = "d78414d29fcc82329080166077e0f7689f4016551fdb334d787c3d040fe2634f"
 SRC_URI[gix-actor-0.31.5.sha256sum] = "a0e454357e34b833cc3a00b6efbbd3dd4d18b24b9fb0c023876ec2645e8aa3f2"
-SRC_URI[gix-attributes-0.22.3.sha256sum] = "e37ce99c7e81288c28b703641b6d5d119aacc45c1a6b247156e6249afa486257"
+SRC_URI[gix-attributes-0.22.5.sha256sum] = "ebccbf25aa4a973dd352564a9000af69edca90623e8a16dad9cbc03713131311"
 SRC_URI[gix-bitmap-0.2.11.sha256sum] = "a371db66cbd4e13f0ed9dc4c0fea712d7276805fccc877f77e96374d317e87ae"
 SRC_URI[gix-chunk-0.4.8.sha256sum] = "45c8751169961ba7640b513c3b24af61aa962c967aaf04116734975cd5af0c52"
-SRC_URI[gix-command-0.3.8.sha256sum] = "0d76867867da891cbe32021ad454e8cae90242f6afb06762e4dd0d357afd1d7b"
+SRC_URI[gix-command-0.3.9.sha256sum] = "dff2e692b36bbcf09286c70803006ca3fd56551a311de450be317a0ab8ea92e7"
 SRC_URI[gix-commitgraph-0.24.3.sha256sum] = "133b06f67f565836ec0c473e2116a60fb74f80b6435e21d88013ac0e3c60fc78"
-SRC_URI[gix-config-0.37.0.sha256sum] = "53fafe42957e11d98e354a66b6bd70aeea00faf2f62dd11164188224a507c840"
-SRC_URI[gix-config-value-0.14.7.sha256sum] = "b328997d74dd15dc71b2773b162cb4af9a25c424105e4876e6d0686ab41c383e"
-SRC_URI[gix-credentials-0.24.4.sha256sum] = "198588f532e4d1202e04e6c3f50e4d7c060dffc66801c6f53cc246f1d234739e"
+SRC_URI[gix-config-0.38.0.sha256sum] = "28f53fd03d1bf09ebcc2c8654f08969439c4556e644ca925f27cf033bc43e658"
+SRC_URI[gix-config-value-0.14.8.sha256sum] = "03f76169faa0dec598eac60f83d7fcdd739ec16596eca8fb144c88973dbe6f8c"
+SRC_URI[gix-credentials-0.24.5.sha256sum] = "8ce391d305968782f1ae301c4a3d42c5701df7ff1d8bc03740300f6fd12bce78"
 SRC_URI[gix-date-0.8.7.sha256sum] = "9eed6931f21491ee0aeb922751bd7ec97b4b2fe8fbfedcb678e2a2dce5f3b8c0"
+SRC_URI[gix-date-0.9.0.sha256sum] = "35c84b7af01e68daf7a6bb8bb909c1ff5edb3ce4326f1f43063a5a96d3c3c8a5"
 SRC_URI[gix-diff-0.44.1.sha256sum] = "1996d5c8a305b59709467d80617c9fde48d9d75fd1f4179ea970912630886c9d"
-SRC_URI[gix-dir-0.5.0.sha256sum] = "60c99f8c545abd63abe541d20ab6cda347de406c0a3f1c80aadc12d9b0e94974"
-SRC_URI[gix-discover-0.32.0.sha256sum] = "fc27c699b63da66b50d50c00668bc0b7e90c3a382ef302865e891559935f3dbf"
+SRC_URI[gix-dir-0.6.0.sha256sum] = "0c975679aa00dd2d757bfd3ddb232e8a188c0094c3306400575a0813858b1365"
+SRC_URI[gix-discover-0.33.0.sha256sum] = "67662731cec3cb31ba3ed2463809493f76d8e5d6c6d245de8b0560438c13450e"
 SRC_URI[gix-features-0.38.2.sha256sum] = "ac7045ac9fe5f9c727f38799d002a7ed3583cd777e3322a7c4b43e3cf437dc69"
 SRC_URI[gix-filter-0.11.3.sha256sum] = "e6547738da28275f4dff4e9f3a0f28509f53f94dd6bd822733c91cb306bca61a"
-SRC_URI[gix-fs-0.11.2.sha256sum] = "6adf99c27cdf17b1c4d77680c917e0d94d8783d4e1c73d3be0d1d63107163d7a"
-SRC_URI[gix-glob-0.16.4.sha256sum] = "fa7df15afa265cc8abe92813cd354d522f1ac06b29ec6dfa163ad320575cb447"
+SRC_URI[gix-fs-0.11.3.sha256sum] = "f2bfe6249cfea6d0c0e0990d5226a4cb36f030444ba9e35e0639275db8f98575"
+SRC_URI[gix-glob-0.16.5.sha256sum] = "74908b4bbc0a0a40852737e5d7889f676f081e340d5451a16e5b4c50d592f111"
 SRC_URI[gix-hash-0.14.2.sha256sum] = "f93d7df7366121b5018f947a04d37f034717e113dcf9ccd85c34b58e57a74d5e"
 SRC_URI[gix-hashtable-0.5.2.sha256sum] = "7ddf80e16f3c19ac06ce415a38b8591993d3f73aede049cb561becb5b3a8e242"
-SRC_URI[gix-ignore-0.11.3.sha256sum] = "5e6afb8f98e314d4e1adc822449389ada863c174b5707cedd327d67b84dba527"
+SRC_URI[gix-ignore-0.11.4.sha256sum] = "e447cd96598460f5906a0f6c75e950a39f98c2705fc755ad2f2020c9e937fab7"
 SRC_URI[gix-index-0.33.1.sha256sum] = "9a9a44eb55bd84bb48f8a44980e951968ced21e171b22d115d1cdcef82a7d73f"
 SRC_URI[gix-lock-14.0.0.sha256sum] = "e3bc7fe297f1f4614774989c00ec8b1add59571dc9b024b4c00acb7dedd4e19d"
 SRC_URI[gix-macros-0.1.5.sha256sum] = "999ce923619f88194171a67fb3e6d613653b8d4d6078b529b15a765da0edcc17"
@@ -455,32 +459,32 @@ SRC_URI[gix-negotiate-0.13.2.sha256sum] = "9ec879fb6307bb63519ba89be0024c6f61b4b
 SRC_URI[gix-object-0.42.3.sha256sum] = "25da2f46b4e7c2fa7b413ce4dffb87f69eaf89c2057e386491f4c55cadbfe386"
 SRC_URI[gix-odb-0.61.1.sha256sum] = "20d384fe541d93d8a3bb7d5d5ef210780d6df4f50c4e684ccba32665a5e3bc9b"
 SRC_URI[gix-pack-0.51.1.sha256sum] = "3e0594491fffe55df94ba1c111a6566b7f56b3f8d2e1efc750e77d572f5f5229"
-SRC_URI[gix-packetline-0.17.5.sha256sum] = "b70486beda0903b6d5b65dfa6e40585098cdf4e6365ca2dff4f74c387354a515"
-SRC_URI[gix-packetline-blocking-0.17.4.sha256sum] = "c31d42378a3d284732e4d589979930d0d253360eccf7ec7a80332e5ccb77e14a"
-SRC_URI[gix-path-0.10.9.sha256sum] = "8d23d5bbda31344d8abc8de7c075b3cf26e5873feba7c4a15d916bce67382bd9"
-SRC_URI[gix-pathspec-0.7.6.sha256sum] = "d307d1b8f84dc8386c4aa20ce0cf09242033840e15469a3ecba92f10cfb5c046"
-SRC_URI[gix-prompt-0.8.6.sha256sum] = "7e0595d2be4b6d6a71a099e989bdd610882b882da35fb8503d91d6f81aa0936f"
-SRC_URI[gix-protocol-0.45.2.sha256sum] = "bad8da8e89f24177bd77947092199bb13dcc318bbd73530ba8a05e6d6adaaa9d"
+SRC_URI[gix-packetline-0.17.6.sha256sum] = "8c43ef4d5fe2fa222c606731c8bdbf4481413ee4ef46d61340ec39e4df4c5e49"
+SRC_URI[gix-packetline-blocking-0.17.5.sha256sum] = "b9802304baa798dd6f5ff8008a2b6516d54b74a69ca2d3a2b9e2d6c3b5556b40"
+SRC_URI[gix-path-0.10.11.sha256sum] = "ebfc4febd088abdcbc9f1246896e57e37b7a34f6909840045a1767c6dafac7af"
+SRC_URI[gix-pathspec-0.7.7.sha256sum] = "5d23bf239532b4414d0e63b8ab3a65481881f7237ed9647bb10c1e3cc54c5ceb"
+SRC_URI[gix-prompt-0.8.7.sha256sum] = "74fde865cdb46b30d8dad1293385d9bcf998d3a39cbf41bee67d0dab026fe6b1"
+SRC_URI[gix-protocol-0.45.3.sha256sum] = "cc43a1006f01b5efee22a003928c9eb83dde2f52779ded9d4c0732ad93164e3e"
 SRC_URI[gix-quote-0.4.12.sha256sum] = "cbff4f9b9ea3fa7a25a70ee62f545143abef624ac6aa5884344e70c8b0a1d9ff"
-SRC_URI[gix-ref-0.44.1.sha256sum] = "3394a2997e5bc6b22ebc1e1a87b41eeefbcfcff3dbfa7c4bd73cb0ac8f1f3e2e"
+SRC_URI[gix-ref-0.45.0.sha256sum] = "636e96a0a5562715153fee098c217110c33a6f8218f08f4687ff99afde159bb5"
 SRC_URI[gix-refspec-0.23.1.sha256sum] = "6868f8cd2e62555d1f7c78b784bece43ace40dd2a462daf3b588d5416e603f37"
 SRC_URI[gix-revision-0.27.2.sha256sum] = "01b13e43c2118c4b0537ddac7d0821ae0dfa90b7b8dbf20c711e153fb749adce"
 SRC_URI[gix-revwalk-0.13.2.sha256sum] = "1b030ccaab71af141f537e0225f19b9e74f25fefdba0372246b844491cab43e0"
-SRC_URI[gix-sec-0.10.7.sha256sum] = "1547d26fa5693a7f34f05b4a3b59a90890972922172653bcb891ab3f09f436df"
-SRC_URI[gix-submodule-0.11.0.sha256sum] = "921cd49924ac14b6611b22e5fb7bbba74d8780dc7ad26153304b64d1272460ac"
-SRC_URI[gix-tempfile-14.0.1.sha256sum] = "006acf5a613e0b5cf095d8e4b3f48c12a60d9062aa2b2dd105afaf8344a5600c"
-SRC_URI[gix-trace-0.1.9.sha256sum] = "f924267408915fddcd558e3f37295cc7d6a3e50f8bd8b606cee0808c3915157e"
-SRC_URI[gix-transport-0.42.2.sha256sum] = "27c02b83763ffe95bcc27ce5821b2b7f843315a009c06f1cd59c9b66c508c058"
+SRC_URI[gix-sec-0.10.8.sha256sum] = "0fe4d52f30a737bbece5276fab5d3a8b276dc2650df963e293d0673be34e7a5f"
+SRC_URI[gix-submodule-0.12.0.sha256sum] = "0f2e0f69aa00805e39d39ec80472a7e9da20ed5d73318b27925a2cc198e854fd"
+SRC_URI[gix-tempfile-14.0.2.sha256sum] = "046b4927969fa816a150a0cda2e62c80016fe11fb3c3184e4dddf4e542f108aa"
+SRC_URI[gix-trace-0.1.10.sha256sum] = "6cae0e8661c3ff92688ce1c8b8058b3efb312aba9492bbe93661a21705ab431b"
+SRC_URI[gix-transport-0.42.3.sha256sum] = "421dcccab01b41a15d97b226ad97a8f9262295044e34fbd37b10e493b0a6481f"
 SRC_URI[gix-traverse-0.39.2.sha256sum] = "e499a18c511e71cf4a20413b743b9f5bcf64b3d9e81e9c3c6cd399eae55a8840"
-SRC_URI[gix-url-0.27.4.sha256sum] = "e2eb9b35bba92ea8f0b5ab406fad3cf6b87f7929aa677ff10aa042c6da621156"
+SRC_URI[gix-url-0.27.5.sha256sum] = "fd280c5e84fb22e128ed2a053a0daeacb6379469be6a85e3d518a0636e160c89"
 SRC_URI[gix-utils-0.1.12.sha256sum] = "35192df7fd0fa112263bad8021e2df7167df4cc2a6e6d15892e1e55621d3d4dc"
 SRC_URI[gix-validate-0.8.5.sha256sum] = "82c27dd34a49b1addf193c92070bcbf3beaf6e10f16a78544de6372e146a0acf"
 SRC_URI[gix-worktree-0.34.1.sha256sum] = "26f7326ebe0b9172220694ea69d344c536009a9b98fb0f9de092c440f3efe7a6"
 SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
-SRC_URI[globset-0.4.14.sha256sum] = "57da3b9b5b85bd66f31093f8c408b90a74431672542466497dcbdfdc02034be1"
+SRC_URI[globset-0.4.15.sha256sum] = "15f1ce686646e7f1e19bf7d5533fe443a45dbfb990e00629110797578b42fb19"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
-SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[hashbrown-0.15.0.sha256sum] = "1e087f84d4f86bf4b218b927129862374b72199ae7d8657835f1e89000eea4fb"
 SRC_URI[hashlink-0.9.1.sha256sum] = "6ba4ff7128dee98c7dc9794b6a411377e1404dba1c97deb8d1a55297bd25d8af"
 SRC_URI[heck-0.4.1.sha256sum] = "95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
@@ -488,109 +492,114 @@ SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5
 SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
 SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
 SRC_URI[home-0.5.9.sha256sum] = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
-SRC_URI[http-auth-0.1.9.sha256sum] = "643c9bbf6a4ea8a656d6b4cd53d34f79e3f841ad5203c1a55fb7d761923bc255"
+SRC_URI[http-auth-0.1.10.sha256sum] = "150fa4a9462ef926824cf4519c84ed652ca8f4fbae34cb8af045b5cbcaf98822"
 SRC_URI[humantime-2.1.0.sha256sum] = "9a3a5bfb195931eeb336b2a7b4d761daec841b97f947d34394601737a7bba5e4"
 SRC_URI[idna-0.5.0.sha256sum] = "634d9b1461af396cad843f47fdba5597a4f9e6ddd4bfb6ff5d85028c25cb12f6"
-SRC_URI[ignore-0.4.22.sha256sum] = "b46810df39e66e925525d6e38ce1e7f6e1d208f72dc39757880fcb66e2c58af1"
+SRC_URI[ignore-0.4.23.sha256sum] = "6d89fd380afde86567dfba715db065673989d6253f42b88179abd3eae47bda4b"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
-SRC_URI[indexmap-1.9.3.sha256sum] = "bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
-SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
+SRC_URI[implib-0.3.3.sha256sum] = "27a77d80daf69d39932349c736810ce6577550b75342e2b426e559ab99632bd8"
+SRC_URI[indexmap-2.6.0.sha256sum] = "707907fe3c25f5424cce2cb7e1cbcafee6bdbe735ca90ef77c29e84591e5b9da"
 SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] = "7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
-SRC_URI[itertools-0.12.1.sha256sum] = "ba291022dbbd398a455acf126c1e341954079855bc60dfdda641363bd6922569"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
 SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[jiff-0.1.13.sha256sum] = "8a45489186a6123c128fdf6016183fcfab7113e1820eb813127e036e287233fb"
+SRC_URI[jiff-tzdb-0.1.1.sha256sum] = "91335e575850c5c4c673b9bd467b0e025f164ca59d0564f69d0c2ee0ffad4653"
+SRC_URI[jiff-tzdb-platform-0.1.1.sha256sum] = "9835f0060a626fe59f160437bc725491a6af23133ea906500027d1bd2f8f4329"
 SRC_URI[jobserver-0.1.32.sha256sum] = "48d1dbcbbeb6a7fec7e059840aa538bd62aaccf972c7346c4d9d2059312853d0"
-SRC_URI[js-sys-0.3.69.sha256sum] = "29c15563dc2726973df627357ce0c9ddddbea194836909d655df6a75d2cf296d"
+SRC_URI[js-sys-0.3.72.sha256sum] = "6a88f1bda2bd75b0452a14784937d796722fdebfe50df998aeb3f0b7603019a9"
 SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
 SRC_URI[lazycell-1.3.0.sha256sum] = "830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
-SRC_URI[libc-0.2.155.sha256sum] = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+SRC_URI[libc-0.2.161.sha256sum] = "8e9489c2807c139ffd9c1794f4af0ebe86a828db53ecdc7fea2111d0fed085d1"
 SRC_URI[libdbus-sys-0.2.5.sha256sum] = "06085512b750d640299b79be4bad3d2fa90a9c00b1fd9e1b46364f66f0485c72"
-SRC_URI[libgit2-sys-0.16.2+1.7.2.sha256sum] = "ee4126d8b4ee5c9d9ea891dd875cfdc1e9d0950437179104b183d7d8a74d24e8"
+SRC_URI[libgit2-sys-0.17.0+1.8.1.sha256sum] = "10472326a8a6477c3c20a64547b0059e4b0d086869eee31e6d7da728a8eb7224"
 SRC_URI[libloading-0.8.5.sha256sum] = "4979f22fdb869068da03c9f7528f8297c6fd2606bc3a4affe42e6a823fdb8da4"
 SRC_URI[libnghttp2-sys-0.1.10+1.61.0.sha256sum] = "959c25552127d2e1fa72f0e52548ec04fc386e827ba71a7bd01db46a447dc135"
-SRC_URI[libsqlite3-sys-0.28.0.sha256sum] = "0c10584274047cb335c23d3e61bcef8e323adae7c5c8c760540f73610177fc3f"
+SRC_URI[libredox-0.1.3.sha256sum] = "c0ff37bd590ca25063e35af745c343cb7a0271906fb7b37e4813e8f79f00268d"
+SRC_URI[libsqlite3-sys-0.30.1.sha256sum] = "2e99fb7a497b1e3339bc746195567ed8d3e24945ecd636e3619d20b9de9e9149"
 SRC_URI[libssh2-sys-0.3.0.sha256sum] = "2dc8a030b787e2119a731f1951d6a773e2280c660f8ec4b0f5e1505a386e71ee"
-SRC_URI[libz-sys-1.1.18.sha256sum] = "c15da26e5af7e25c90b37a2d75cdbf940cf4a55316de9d84c679c9b8bfabf82e"
+SRC_URI[libz-sys-1.1.20.sha256sum] = "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
 SRC_URI[linux-raw-sys-0.4.14.sha256sum] = "78b3ae25bc7c8c38cec158d1f2757ee79e9b3740fbc7ccf0e59e4b08d793fa89"
 SRC_URI[lock_api-0.4.12.sha256sum] = "07af8b9cdd281b7915f413fa73f29ebd5d55d0d3f0155584dade1ff18cea1b17"
 SRC_URI[log-0.4.22.sha256sum] = "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c54bba33a7f72f873a39d07b24"
 SRC_URI[matchers-0.1.0.sha256sum] = "8263075bb86c5a1b1427b5ae862e8889656f126e9f77c484496e8b47cf5c5558"
 SRC_URI[maybe-async-0.2.10.sha256sum] = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
 SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[memmap2-0.9.4.sha256sum] = "fe751422e4a8caa417e13c3ea66452215d7d63e19e604f4980461212f3ae1322"
+SRC_URI[memmap2-0.9.5.sha256sum] = "fd3f7eed9d3848f8b98834af67102b720745c4ec028fcd0aa0239277e7de374f"
+SRC_URI[memoffset-0.9.1.sha256sum] = "488016bfae457b036d996092f6cb448677611ce4449e970ceaf42695203f218a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.7.4.sha256sum] = "b8a240ddb74feaf34a79a7add65a741f3167852fba007066dcac1ca548d89c08"
+SRC_URI[miniz_oxide-0.8.0.sha256sum] = "e2d80299ef12ff69b16a84bb182e3b9df68b5a91574d3d4fa6e41b65deec4df1"
 SRC_URI[miow-0.6.0.sha256sum] = "359f76430b20a79f9e20e115b3428614e654f04fab314482fc0fda0ebd3c6044"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
-SRC_URI[normpath-1.2.0.sha256sum] = "5831952a9476f2fed74b77d74182fa5ddc4d21c72ec45a333b250e3ed0272804"
+SRC_URI[normpath-1.3.0.sha256sum] = "c8911957c4b1549ac0dc74e30db9c8b0e66ddcd6d7acc33098f4c63a64a6d7ed"
 SRC_URI[nu-ansi-term-0.46.0.sha256sum] = "77a8165726e8236064dbb45459242600304b42a5ea24ee2948e18e023bf7ba84"
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[num_threads-0.1.7.sha256sum] = "5c7398b9c8b70908f6371f47ed36737907c87c52af34c268fed0bf0ceb92ead9"
-SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
-SRC_URI[opener-0.7.1.sha256sum] = "f8df34be653210fbe9ffaff41d3b92721c56ce82dfee58ee684f9afb5e3a90c0"
-SRC_URI[openssl-0.10.66.sha256sum] = "9529f4786b70a3e8c61e11179af17ab6188ad8d0ded78c5529441ed39d4bd9c1"
+SRC_URI[object-0.36.5.sha256sum] = "aedf0a2d09c573ed1d8d85b30c119153926a2b36dce0ab28322c09a117a4683e"
+SRC_URI[once_cell-1.20.2.sha256sum] = "1261fe7e33c73b354eab43b1273a57c8f967d0391e80353e51f764ac02cf6775"
+SRC_URI[opener-0.7.2.sha256sum] = "d0812e5e4df08da354c851a3376fead46db31c2214f849d3de356d774d057681"
+SRC_URI[openssl-0.10.57.sha256sum] = "bac25ee399abb46215765b1cb35bc0212377e58a061560d8b29b024fd0430e7c"
 SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
 SRC_URI[openssl-probe-0.1.5.sha256sum] = "ff011a302c396a5197692431fc1948019154afc178baf7d8e37367442a4601cf"
-SRC_URI[openssl-src-300.3.1+3.3.1.sha256sum] = "7259953d42a81bf137fbbd73bd30a8e1914d6dce43c2b90ed575783a22608b91"
-SRC_URI[openssl-sys-0.9.103.sha256sum] = "7f9e8deee91df40a943c71b917e5874b951d32a802526c85721ce3b776c929d6"
+SRC_URI[openssl-src-300.3.2+3.3.2.sha256sum] = "a211a18d945ef7e648cc6e0058f4c548ee46aab922ea203e0d30e966ea23647b"
+SRC_URI[openssl-sys-0.9.104.sha256sum] = "45abf306cbf99debc8195b66b7346498d7b10c210de50418b5ccd7ceba08c741"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
-SRC_URI[orion-0.17.6.sha256sum] = "7abdb10181903c8c4b016ba45d6d6d5af1a1e2a461aa4763a83b87f5df4695e5"
+SRC_URI[orion-0.17.7.sha256sum] = "97ab5415cf60cd271259e576f2ddee7a5f9fed42659035224c01af766943fad3"
 SRC_URI[os_info-3.8.2.sha256sum] = "ae99c7fa6dd38c7cafe1ec085e804f8f555a2f8659b0dbe03f1f9963a9b51092"
 SRC_URI[overload-0.1.1.sha256sum] = "b15813163c1d831bf4a13c3610c05c0d03b39feb07f7e09fa234dac9b15aaf39"
 SRC_URI[p384-0.13.0.sha256sum] = "70786f51bcc69f6a4c0360e063a4cac5419ef7c5cd5b3c99ad70f3be5ba79209"
 SRC_URI[parking_lot-0.12.3.sha256sum] = "f1bf18183cf54e8d6059647fc3063646a1801cf30896933ec2311622cc4b9a27"
 SRC_URI[parking_lot_core-0.9.10.sha256sum] = "1e401f977ab385c9e4e3ab30627d6f26d00e2c73eef317493c4ec6d468726cf8"
 SRC_URI[pasetors-0.6.8.sha256sum] = "6b36d47c66f2230dd1b7143d9afb2b4891879020210eddf2ccb624e529b96dba"
-SRC_URI[pathdiff-0.2.1.sha256sum] = "8835116a5c179084a830efb3adc117ab007512b535bc1a21c991d3b32a6b44dd"
+SRC_URI[pathdiff-0.2.2.sha256sum] = "d61c5ce1153ab5b689d0c074c4e7fc613e942dfb7dd9eea5ab202d2ad91fe361"
 SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
 SRC_URI[percent-encoding-2.3.1.sha256sum] = "e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
 SRC_URI[pin-project-lite-0.2.14.sha256sum] = "bda66fc9667c18cb2758a2ac84d1167245054bcf85d5d1aaa6923f45801bdd02"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
-SRC_URI[pkg-config-0.3.30.sha256sum] = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
+SRC_URI[pkg-config-0.3.31.sha256sum] = "953ec861398dccce10c670dfeaf3ec4911ca479e9c02154b3a215178c5f566f2"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
-SRC_URI[ppv-lite86-0.2.18.sha256sum] = "dee4364d9f3b902ef14fab8a1ddffb783a1cb6b4bba3bfc1fa3922732c7de97f"
+SRC_URI[ppv-lite86-0.2.20.sha256sum] = "77957b295656769bb8ad2b6a6b09d897d94f05c41b069aede1fcdaa675eaea04"
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
-SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+SRC_URI[proc-macro2-1.0.88.sha256sum] = "7c3a7fc5db1e57d5a779a352c8cdb57b29aa4c40cc69c3a68a7fedc815fbf2f9"
 SRC_URI[prodash-28.0.0.sha256sum] = "744a264d26b88a6a7e37cbad97953fa233b94d585236310bcbc88474b4092d79"
-SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[quote-1.0.37.sha256sum] = "b5b9d34b8991d19d98081b46eacdd8eb58c6f2b201139f7c5f643cc155a633af"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
-SRC_URI[redox_syscall-0.4.1.sha256sum] = "4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
-SRC_URI[redox_syscall-0.5.3.sha256sum] = "2a908a6e00f1fdd0dfd9c0eb08ce85126f6d8bbda50017e74bc4a4b7d4a926a4"
-SRC_URI[regex-1.10.5.sha256sum] = "b91213439dad192326a0d7c6ee3955910425f441d7038e0d6933b0aec5c4517f"
+SRC_URI[redox_syscall-0.5.7.sha256sum] = "9b6dfecf2c74bce2466cabf93f6664d6998a69eb21e39f4207930065b27b771f"
+SRC_URI[regex-1.11.0.sha256sum] = "38200e5ee88914975b69f657f0801b6f6dccafd44fd9326302a4aaeecfacb1d8"
 SRC_URI[regex-automata-0.1.10.sha256sum] = "6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
-SRC_URI[regex-automata-0.4.7.sha256sum] = "38caf58cc5ef2fed281f89292ef23f6365465ed9a41b7a7754eb4e26496c92df"
+SRC_URI[regex-automata-0.4.8.sha256sum] = "368758f23274712b504848e9d5a6f010445cc8b87a7cdb4d7cbee666c1288da3"
 SRC_URI[regex-syntax-0.6.29.sha256sum] = "f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
-SRC_URI[regex-syntax-0.8.4.sha256sum] = "7a66a03ae7c801facd77a29370b4faec201768915ac14a721ba36f20bc9c209b"
+SRC_URI[regex-syntax-0.8.5.sha256sum] = "2b15c43186be67a4fd63bee50d0303afffcef381492ebe2c5d87f324e1b8815c"
 SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
-SRC_URI[rusqlite-0.31.0.sha256sum] = "b838eba278d213a8beaf485bd313fd580ca4505a00d5871caeb1457c55322cae"
-SRC_URI[rustfix-0.8.4.sha256sum] = "4cef0c817217c330b3ef879e06455d726c1cffc800eaf7734d3b4ac63213636b"
-SRC_URI[rustix-0.38.34.sha256sum] = "70dc5ec042f7a43c4a73241207cecc9873a06d45debb38b329f8541d85c2730f"
+SRC_URI[rusqlite-0.32.1.sha256sum] = "7753b721174eb8ff87a9a0e799e2d7bc3749323e773db92e0984debb00019d6e"
+SRC_URI[rustfix-0.8.6.sha256sum] = "8fb2b066405a6d48a1b39c0022270503e352ae84da0c24e1d5f8ffc38e97a325"
+SRC_URI[rustix-0.38.37.sha256sum] = "8acb788b847c24f28525660c4d7758620a7210875711f79e7f663cc152726811"
 SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
-SRC_URI[schannel-0.1.23.sha256sum] = "fbc91545643bcf3a0bbb6569265615222618bdf33ce4ffbbd13c4bbd4c093534"
+SRC_URI[schannel-0.1.26.sha256sum] = "01227be5826fa0690321a2ba6c5cd57a19cf3f6a09e76973b58e61de6ab9d1c1"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
 SRC_URI[security-framework-2.11.1.sha256sum] = "897b2245f0b511c87893af39b033e5ca9cce68824c4d7e7630b5a1d339658d02"
-SRC_URI[security-framework-sys-2.11.1.sha256sum] = "75da29fe9b9b08fe9d6b22b5b4bcbc75d8db3aa31e639aa56bb62e9d46bfceaf"
+SRC_URI[security-framework-sys-2.12.0.sha256sum] = "ea4a292869320c0272d7bc55a5a6aafaff59b4f63404a003887b679a2e05b4b6"
 SRC_URI[semver-1.0.23.sha256sum] = "61697e0a1c7e512e84a621326239844a24d8207b4669b41bc18b32ea5cbf988b"
-SRC_URI[serde-1.0.204.sha256sum] = "bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
+SRC_URI[serde-1.0.210.sha256sum] = "c8e3592472072e6e22e0a54d5904d9febf8508f65fb8552499a1abc7d1078c3a"
 SRC_URI[serde-untagged-0.1.6.sha256sum] = "2676ba99bd82f75cae5cbd2c8eda6fa0b8760f18978ea840e980dd5567b5c5b6"
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
-SRC_URI[serde_derive-1.0.204.sha256sum] = "e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
+SRC_URI[serde_derive-1.0.210.sha256sum] = "243902eda00fad750862fc144cea25caca5e20d615af0a81bee94ca738f1df1f"
 SRC_URI[serde_ignored-0.1.10.sha256sum] = "a8e319a36d1b52126a0d608f24e93b2d81297091818cd70625fcf50a15d84ddf"
-SRC_URI[serde_json-1.0.121.sha256sum] = "4ab380d7d9f22ef3f21ad3e6c1ebe8e4fc7a2000ccba2e4d71fc96f15b2cb609"
-SRC_URI[serde_spanned-0.6.7.sha256sum] = "eb5b1b31579f3811bf615c144393417496f152e12ac8b7663bf664f4a815306d"
+SRC_URI[serde_json-1.0.129.sha256sum] = "6dbcf9b78a125ee667ae19388837dd12294b858d101fdd393cb9d5501ef09eb2"
+SRC_URI[serde_spanned-0.6.8.sha256sum] = "87607cb1398ed59d48732e575a4c28a7a8ebf2454b964fe3f224f2afc07909e1"
 SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
 SRC_URI[sha1_smol-1.0.1.sha256sum] = "bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
 SRC_URI[sha2-0.10.8.sha256sum] = "793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
 SRC_URI[sharded-slab-0.1.7.sha256sum] = "f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6"
 SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873bfad7dc788c42e6430db40184f"
 SRC_URI[shell-words-1.1.0.sha256sum] = "24188a676b6ae68c3b2cb3a01be17fbf7240ce009799bb56d5b1409051e78fde"
+SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[smallvec-1.13.2.sha256sum] = "3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
@@ -601,38 +610,36 @@ SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70
 SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
 SRC_URI[supports-hyperlinks-3.0.0.sha256sum] = "2c0a1e5168041f5f3ff68ff7d95dcb9c8749df29f6e7e89ada40dd4c9de404ee"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
-SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.72.sha256sum] = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
-SRC_URI[tar-0.4.41.sha256sum] = "cb797dad5fb5b76fcf519e702f4a589483b5ef06567f160c392832c1f5e44909"
-SRC_URI[tempfile-3.10.1.sha256sum] = "85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
-SRC_URI[terminal_size-0.3.0.sha256sum] = "21bebf2b7c9e0a515f6e0f8c51dc0f8e4696391e6f1ff30379559f8365fb0df7"
-SRC_URI[thiserror-1.0.63.sha256sum] = "c0342370b38b6a11b6cc11d6a805569958d54cfa061a29969c3b5ce2ea405724"
-SRC_URI[thiserror-impl-1.0.63.sha256sum] = "a4558b58466b9ad7ca0f102865eccc95938dca1a74a856f2b57b6629050da261"
+SRC_URI[syn-2.0.79.sha256sum] = "89132cd0bf050864e1d38dc3bbc07a0eb8e7530af26344d3d2bbbef83499f590"
+SRC_URI[tar-0.4.42.sha256sum] = "4ff6c40d3aedb5e06b57c6f669ad17ab063dd1e63d977c6a88e7f4dfa4f04020"
+SRC_URI[tempfile-3.13.0.sha256sum] = "f0f2c9fc62d0beef6951ccffd757e241266a2c833136efbe35af6cd2567dca5b"
+SRC_URI[terminal_size-0.4.0.sha256sum] = "4f599bd7ca042cfdf8f4512b277c02ba102247820f9d9d4a9f521f496751a6ef"
+SRC_URI[thiserror-1.0.64.sha256sum] = "d50af8abc119fb8bb6dbabcfa89656f46f84aa0ac7688088608076ad2b459a84"
+SRC_URI[thiserror-impl-1.0.64.sha256sum] = "08904e7672f5eb876eaaf87e0ce17857500934f4981c4a0ab2b4aa98baac7fc3"
 SRC_URI[thread_local-1.1.8.sha256sum] = "8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
 SRC_URI[time-0.3.36.sha256sum] = "5dfd88e563464686c916c7e46e623e520ddc6d79fa6641390f2e3fa86e83e885"
 SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
 SRC_URI[time-macros-0.2.18.sha256sum] = "3f252a68540fde3a3877aeea552b832b40ab9a69e318efd078774a01ddee1ccf"
 SRC_URI[tinyvec-1.8.0.sha256sum] = "445e881f4f6d382d5f27c034e25eb92edd7c784ceab92a0937db7f2e9471b938"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.5.11.sha256sum] = "f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
-SRC_URI[toml-0.8.16.sha256sum] = "81967dd0dd2c1ab0bc3468bd7caecc32b8a4aa47d0c8c695d8c2b2108168d62c"
-SRC_URI[toml_datetime-0.6.7.sha256sum] = "f8fb9f64314842840f1d940ac544da178732128f1c78c21772e876579e0da1db"
-SRC_URI[toml_edit-0.22.17.sha256sum] = "8d9f8729f5aea9562aac1cc0441f5d6de3cff1ee0c5d67293eeca5eb36ee7c16"
+SRC_URI[toml-0.8.19.sha256sum] = "a1ed1f98e3fdc28d6d910e6737ae6ab1a93bf1985935a1193e68f93eeb68d24e"
+SRC_URI[toml_datetime-0.6.8.sha256sum] = "0dd7358ecb8fc2f8d014bf86f6f638ce72ba252a2c3a2572f2a795f1d23efb41"
+SRC_URI[toml_edit-0.22.22.sha256sum] = "4ae48d6208a266e853d946088ed816055e556cc6028c5e8e2b84d9fa5dd7c7f5"
 SRC_URI[tracing-0.1.40.sha256sum] = "c3523ab5a71916ccf420eebdf5521fcef02141234bbc0b8a49f2fdc4544364ef"
 SRC_URI[tracing-attributes-0.1.27.sha256sum] = "34704c8d6ebcbc939824180af020566b01a7c01f80641264eba0999f6c2b6be7"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
 SRC_URI[tracing-core-0.1.32.sha256sum] = "c06d3da6113f116aaee68e4d601191614c9053067f9ab7f6edbcb161237daa54"
 SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
 SRC_URI[tracing-subscriber-0.3.18.sha256sum] = "ad0f048c97dbd9faa9b7df56362b8ebcaa52adb06b498c050d2f4e32f90a7a8b"
-SRC_URI[typeid-1.0.0.sha256sum] = "059d83cc991e7a42fc37bd50941885db0888e34209f8cfd9aab07ddec03bc9cf"
+SRC_URI[typeid-1.0.2.sha256sum] = "0e13db2e0ccd5e14a544e8a246ba2312cd25223f616442d7f2cb0e3db614236e"
 SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
 SRC_URI[unicase-2.7.0.sha256sum] = "f7d2d4dafb69621809a81864c9c1b864479e1235c0dd4e199924b9742439ed89"
-SRC_URI[unicode-bidi-0.3.15.sha256sum] = "08f95100a766bf4f8f28f90d77e0a5461bbdb219042e7679bebe79004fed8d75"
+SRC_URI[unicode-bidi-0.3.17.sha256sum] = "5ab17db44d7388991a428b2ee655ce0c212e862eff1768a455c58f9aad6e7893"
 SRC_URI[unicode-bom-2.0.3.sha256sum] = "7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
-SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-normalization-0.1.23.sha256sum] = "a56d1686db2308d901306f92a263857ef59ea39678a5458e7cb17f01415101f5"
-SRC_URI[unicode-width-0.1.13.sha256sum] = "0336d538f7abc86d282a4189614dfaa90810dfc2c6f6427eaf88e16311dd225d"
-SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
+SRC_URI[unicode-ident-1.0.13.sha256sum] = "e91b56cd4cadaeb79bbf1a5645f6b4f8dc5bde8834ad5894a8db35fda9efa1fe"
+SRC_URI[unicode-normalization-0.1.24.sha256sum] = "5033c97c4262335cded6d6fc3e5c18ab755e1a3dc96376350f3d8e9f009ad956"
+SRC_URI[unicode-width-0.1.14.sha256sum] = "7dd6e30e90baa6f72411720665d41d89b9a3d039dc45b8faea1ddd07f617f6af"
+SRC_URI[unicode-xid-0.2.6.sha256sum] = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
 SRC_URI[url-2.5.2.sha256sum] = "22784dbdf76fdde8af1aeda5622b546b422b6fc585325248a2bf9f5e41e94d6c"
 SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
 SRC_URI[valuable-0.1.0.sha256sum] = "830b7e5d4d90034032940e4ace0d9a9a057e7a45cd94e6c007832e39edb82f6d"
@@ -640,17 +647,18 @@ SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb82
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.92.sha256sum] = "4be2531df63900aeb2bca0daaaddec08491ee64ceecbee5076636a3b026795a8"
-SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] = "614d787b966d3989fa7bb98a654e369c762374fd3213d212cfc0251257e747da"
-SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] = "a1f8823de937b71b9460c0c34e25f3da88250760bec0ebac694b49997550d726"
-SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] = "e94f17b526d0a461a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
-SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] = "af190c94f2773fdb3729c55b007a722abb5384da03bc0986df4c289bf5567e96"
+SRC_URI[wasm-bindgen-0.2.95.sha256sum] = "128d1e363af62632b8eb57219c8fd7877144af57558fb2ef0368d0087bddeb2e"
+SRC_URI[wasm-bindgen-backend-0.2.95.sha256sum] = "cb6dd4d3ca0ddffd1dd1c9c04f94b868c37ff5fac97c30b97cff2d74fce3a358"
+SRC_URI[wasm-bindgen-macro-0.2.95.sha256sum] = "e79384be7f8f5a9dd5d7167216f022090cf1f9ec128e6e6a482a2cb5c5422c56"
+SRC_URI[wasm-bindgen-macro-support-0.2.95.sha256sum] = "26c6ab57572f7a24a4985830b120de1594465e5d500f24afe89e16b4e833ef68"
+SRC_URI[wasm-bindgen-shared-0.2.95.sha256sum] = "65fc09f10666a9f147042251e0dda9c18f166ff7de300607007e96bdebc1068d"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
+SRC_URI[winapi-util-0.1.9.sha256sum] = "cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
 SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
 SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
@@ -668,9 +676,7 @@ SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390d
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[winnow-0.6.16.sha256sum] = "b480ae9340fc261e6be3e95a1ba86d54ae3f9171132a73ce8d4bbaf68339507c"
-SRC_URI[zerocopy-0.6.6.sha256sum] = "854e949ac82d619ee9a14c66a1b674ac730422372ccb759ce0c39cabcf2bf8e6"
+SRC_URI[winnow-0.6.20.sha256sum] = "36c1fec1a2bb5866f07c25f68c26e565c4c200aebb96d7e55710c19d3e8ac49b"
 SRC_URI[zerocopy-0.7.35.sha256sum] = "1b9b4fd18abc82b8136838da5d50bae7bdea537c574d8dc1a34ed098d6c166f0"
-SRC_URI[zerocopy-derive-0.6.6.sha256sum] = "125139de3f6b9d625c39e2efdd73d41bdac468ccd556556440e322be0e1bbd91"
 SRC_URI[zerocopy-derive-0.7.35.sha256sum] = "fa4f8080344d4671fb4e831a13ad1e68092748387dfc4f55e356242fae12ce3e"
 SRC_URI[zeroize-1.8.1.sha256sum] = "ced3678a2879b30306d323f4542626697a464a97c0a07c9aebf7ebca65cd4dde"
diff --git a/recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb b/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
similarity index 82%
rename from recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb
rename to recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
index 145e704..728b875 100644
--- a/recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb
+++ b/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
@@ -6,7 +6,7 @@ LIC_FILES_CHKSUM = " \
 "
 
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c"
-SRC_URI[cargo-c.sha256sum] = "99f10fab01de791f95e81134202792e4a6975c3a3921fec2d4cbf3e9c269b709"
+SRC_URI[cargo-c.sha256sum] = "5bfa9ba93806384d940e71dafbc185316e0a6a47561b33b7105fcf67f99df70a"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 inherit cargo cargo-update-recipe-crates pkgconfig native
-- 
2.48.1


