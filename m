Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E044CD19539
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35706.1769471495501880210
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ptH3pHvp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6a0702b86so508305085a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471494; x=1770076294; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmwWxXl6s9aPqiWxyhR5JwKIcFJ+nQS3CxmCy3UYtv8=;
        b=ptH3pHvpuASGUi+HrbHW19unjBdjeczxYtKOpFqzxbgyEGB8WHRXZgQzDoaJK4PYiL
         EOgzk+11APnybAZssDYzvTjX+lChhuCMjaeC8iIBYFu/HpcTqtEK6Nv99C/UI8OKeZwj
         Gs8oEwvhc9nRJBMOHsKhTG4kwyfz5JJ1qd13A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471494; x=1770076294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmwWxXl6s9aPqiWxyhR5JwKIcFJ+nQS3CxmCy3UYtv8=;
        b=c3b1pSXAf5XBrNsMON1n6cwR7qCImHFHLsbgtnID8FtTjEmhhFk+9+ztWsClNlakzm
         175fpEL/WuX1ZIsdCFwn1SQX91iEIshKHU8pPMjsTEGxEzpeBMZeZQV3YjAIUXIoLC18
         Hw/F8DAzcHA3y580byeMZxQVIZx6rRafnbyAQX+DNmk/rftBqweRjN6Ht9CHNpRhEJLn
         N2IsQ/UZUesJzpgDiEWZGGOFWSZYId9V3XMTaihrvcuygJP22KhCU0ZZU04ODn6itMO/
         qjIBXTXrTXzZC+tkyLg7IRo+ipae/2+fzj3iFsEasa3XKzvqvYJsExi3KBe3Bt+ZsExz
         7vAA==
X-Gm-Message-State: AOJu0YxvCGE/fcVEvdMmTf0ugpikuwFVrJWpzYcWSJtumvxq/fAJekEM
	gqkaYH0BniEh64WWnYKIlhk/ihyYJ69voBVdmxoIrG5Khi9QuHaV4X40pHT5Fn7Gz4BsBiIUnTb
	qN7tKHVc=
X-Gm-Gg: AZuq6aIKm9u7yZoWwAFkT2T74TEbX5ydDXntaXX5z2WYHigpVVGpOv9kanGX34/jbLu
	KolFYZqEMRDw3BuuZBHjcN8lItL29ksZkIFO/3WJxkjDU/vI/JleA4PUweXdhv/KqmkDmr3KIjC
	4gV+hnDAPkJW0z7XNfFdLcHRkNUhu4nG5BjQ1A5ahsDJaUlf0iTOObitZKjLJpG3xJQTqfLAIHy
	DDG9yJqXILiFWpwB+o+EwpDNgAm5Ut/PAYtO1F+r0fysWLe6qfsD/WFASHJkenLKnFPjGEHkj+a
	XPR3tg1afGvukRd3J5Wzgx0B30Z+F/EPSE+pyqahEFMaUdcSZrj5tYHBWSZ2VcR/v1vKJOhLQ3j
	W+f5SeKPmevSLC4jvWWJbKqWVtZjdB0oOIL+aiJOyguuGZ4Vx96rSmo2lnFNGSJfdO8/kZ9CmXD
	dKFch7smyERBR2gjQdzoX1lG5eMIypJs6RyZBQwjuyuBQntiGLZXl1hO1rhUOb6DSG/VZBNnz8o
	L5tzKrM6h+HOiEKdbG/dRmLy53fTDpghWIGB2mJJAQU7qRgTbMG
X-Received: by 2002:a05:620a:4013:b0:8b2:f1f3:900e with SMTP id af79cd13be357-8c6f96636eemr738852885a.62.1769471493916;
        Mon, 26 Jan 2026 15:51:33 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:33 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/11] cargo-c: update 0.10.18 -> 0.10.19
Date: Mon, 26 Jan 2026 18:51:10 -0500
Message-ID: <68b518475f94758115c1f05c424b9d88ec30a03d.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3096

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Changes are here:
https://github.com/lu-zero/cargo-c/compare/v0.10.18..v0.10.19

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit af7cd7f6e19998704c3c83ee809d278d3af1ece5)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c-crates.inc      | 274 ++++++++++--------
 ...2.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} |   2 +-
 2 files changed, 155 insertions(+), 121 deletions(-)
 rename recipes-devtools/rust/{cargo-c_0.10.18+cargo-0.92.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} (87%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/rust/cargo-c-crates.inc
index 4cea0fc..9155299 100644
--- a/recipes-devtools/rust/cargo-c-crates.inc
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -5,12 +5,13 @@ SRC_URI += " \
     crate://crates.io/adler2/2.0.1 \
     crate://crates.io/aho-corasick/1.1.4 \
     crate://crates.io/allocator-api2/0.2.21 \
-    crate://crates.io/annotate-snippets/0.12.8 \
+    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/annotate-snippets/0.12.10 \
     crate://crates.io/anstream/0.6.21 \
     crate://crates.io/anstyle/1.0.13 \
     crate://crates.io/anstyle-parse/0.2.7 \
-    crate://crates.io/anstyle-query/1.1.4 \
-    crate://crates.io/anstyle-wincon/3.0.10 \
+    crate://crates.io/anstyle-query/1.1.5 \
+    crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/anyhow/1.0.100 \
     crate://crates.io/arc-swap/1.7.1 \
     crate://crates.io/arrayref/0.3.9 \
@@ -18,29 +19,31 @@ SRC_URI += " \
     crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
-    crate://crates.io/base64ct/1.8.0 \
+    crate://crates.io/base64ct/1.8.1 \
     crate://crates.io/bitflags/2.10.0 \
     crate://crates.io/bitmaps/2.1.0 \
     crate://crates.io/blake3/1.8.2 \
     crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/block2/0.6.2 \
     crate://crates.io/bstr/1.12.1 \
     crate://crates.io/bumpalo/3.19.0 \
     crate://crates.io/byteorder/1.5.0 \
-    crate://crates.io/bytes/1.10.1 \
-    crate://crates.io/cargo/0.92.0 \
+    crate://crates.io/bytes/1.11.0 \
+    crate://crates.io/cargo/0.93.0 \
     crate://crates.io/cargo-credential/0.4.9 \
-    crate://crates.io/cargo-credential-libsecret/0.5.2 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.17 \
-    crate://crates.io/cargo-credential-wincred/0.4.17 \
-    crate://crates.io/cargo-platform/0.3.1 \
-    crate://crates.io/cargo-util/0.2.24 \
-    crate://crates.io/cargo-util-schemas/0.10.1 \
+    crate://crates.io/cargo-credential-libsecret/0.5.3 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.18 \
+    crate://crates.io/cargo-credential-wincred/0.4.18 \
+    crate://crates.io/cargo-platform/0.3.2 \
+    crate://crates.io/cargo-util/0.2.25 \
+    crate://crates.io/cargo-util-schemas/0.10.2 \
     crate://crates.io/cbindgen/0.29.2 \
-    crate://crates.io/cc/1.2.44 \
+    crate://crates.io/cc/1.2.49 \
     crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/clap/4.5.51 \
-    crate://crates.io/clap_builder/4.5.51 \
-    crate://crates.io/clap_complete/4.5.60 \
+    crate://crates.io/cfg_aliases/0.2.1 \
+    crate://crates.io/clap/4.5.53 \
+    crate://crates.io/clap_builder/4.5.53 \
+    crate://crates.io/clap_complete/4.5.61 \
     crate://crates.io/clap_derive/4.5.49 \
     crate://crates.io/clap_lex/0.7.6 \
     crate://crates.io/clru/0.6.2 \
@@ -52,7 +55,7 @@ SRC_URI += " \
     crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crates-io/0.40.14 \
+    crate://crates.io/crates-io/0.40.15 \
     crate://crates.io/crc32fast/1.5.0 \
     crate://crates.io/crossbeam-channel/0.5.15 \
     crate://crates.io/crossbeam-deque/0.8.6 \
@@ -62,20 +65,21 @@ SRC_URI += " \
     crate://crates.io/crypto-common/0.1.6 \
     crate://crates.io/ct-codecs/1.1.6 \
     crate://crates.io/curl/0.4.49 \
-    crate://crates.io/curl-sys/0.4.83+curl-8.15.0 \
+    crate://crates.io/curl-sys/0.4.84+curl-8.17.0 \
     crate://crates.io/dashmap/6.1.0 \
     crate://crates.io/der/0.7.10 \
     crate://crates.io/deranged/0.5.5 \
     crate://crates.io/digest/0.10.7 \
+    crate://crates.io/dispatch2/0.3.0 \
     crate://crates.io/displaydoc/0.2.5 \
     crate://crates.io/dunce/1.0.5 \
     crate://crates.io/ecdsa/0.16.9 \
-    crate://crates.io/ed25519-compact/2.1.1 \
+    crate://crates.io/ed25519-compact/2.2.0 \
     crate://crates.io/either/1.15.0 \
     crate://crates.io/elliptic-curve/0.13.8 \
     crate://crates.io/encoding_rs/0.8.35 \
     crate://crates.io/equivalent/1.0.2 \
-    crate://crates.io/erased-serde/0.4.8 \
+    crate://crates.io/erased-serde/0.4.9 \
     crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
@@ -84,7 +88,7 @@ SRC_URI += " \
     crate://crates.io/ff/0.13.1 \
     crate://crates.io/fiat-crypto/0.3.0 \
     crate://crates.io/filetime/0.2.26 \
-    crate://crates.io/find-msvc-tools/0.1.4 \
+    crate://crates.io/find-msvc-tools/0.1.5 \
     crate://crates.io/flate2/1.1.5 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/foldhash/0.1.5 \
@@ -94,7 +98,7 @@ SRC_URI += " \
     crate://crates.io/generic-array/0.14.9 \
     crate://crates.io/getrandom/0.2.16 \
     crate://crates.io/getrandom/0.3.4 \
-    crate://crates.io/git2/0.20.2 \
+    crate://crates.io/git2/0.20.3 \
     crate://crates.io/git2-curl/0.21.0 \
     crate://crates.io/gix/0.73.0 \
     crate://crates.io/gix-actor/0.35.6 \
@@ -125,7 +129,7 @@ SRC_URI += " \
     crate://crates.io/gix-pack/0.60.0 \
     crate://crates.io/gix-packetline/0.19.3 \
     crate://crates.io/gix-packetline-blocking/0.19.3 \
-    crate://crates.io/gix-path/0.10.21 \
+    crate://crates.io/gix-path/0.10.22 \
     crate://crates.io/gix-pathspec/0.12.0 \
     crate://crates.io/gix-prompt/0.11.2 \
     crate://crates.io/gix-protocol/0.51.0 \
@@ -152,7 +156,7 @@ SRC_URI += " \
     crate://crates.io/hash32/0.3.1 \
     crate://crates.io/hashbrown/0.14.5 \
     crate://crates.io/hashbrown/0.15.5 \
-    crate://crates.io/hashbrown/0.16.0 \
+    crate://crates.io/hashbrown/0.16.1 \
     crate://crates.io/hashlink/0.10.0 \
     crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
@@ -165,8 +169,8 @@ SRC_URI += " \
     crate://crates.io/icu_locale_core/2.1.1 \
     crate://crates.io/icu_normalizer/2.1.1 \
     crate://crates.io/icu_normalizer_data/2.1.1 \
-    crate://crates.io/icu_properties/2.1.1 \
-    crate://crates.io/icu_properties_data/2.1.1 \
+    crate://crates.io/icu_properties/2.1.2 \
+    crate://crates.io/icu_properties_data/2.1.2 \
     crate://crates.io/icu_provider/2.1.1 \
     crate://crates.io/idna/1.1.0 \
     crate://crates.io/idna_adapter/1.2.1 \
@@ -174,33 +178,33 @@ SRC_URI += " \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/imara-diff/0.1.8 \
     crate://crates.io/implib/0.4.0 \
-    crate://crates.io/indexmap/2.12.0 \
+    crate://crates.io/indexmap/2.12.1 \
     crate://crates.io/is_executable/1.0.5 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.14.0 \
     crate://crates.io/itoa/1.0.15 \
-    crate://crates.io/jiff/0.2.15 \
-    crate://crates.io/jiff-static/0.2.15 \
-    crate://crates.io/jiff-tzdb/0.1.4 \
+    crate://crates.io/jiff/0.2.16 \
+    crate://crates.io/jiff-static/0.2.16 \
+    crate://crates.io/jiff-tzdb/0.1.5 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.34 \
-    crate://crates.io/js-sys/0.3.82 \
+    crate://crates.io/js-sys/0.3.83 \
     crate://crates.io/kstring/2.0.2 \
     crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/lazycell/1.3.0 \
-    crate://crates.io/libc/0.2.177 \
-    crate://crates.io/libgit2-sys/0.18.2+1.9.1 \
+    crate://crates.io/libc/0.2.178 \
+    crate://crates.io/libgit2-sys/0.18.3+1.9.2 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/libnghttp2-sys/0.1.11+1.64.0 \
     crate://crates.io/libredox/0.1.10 \
     crate://crates.io/libsqlite3-sys/0.35.0 \
     crate://crates.io/libssh2-sys/0.3.1 \
-    crate://crates.io/libz-rs-sys/0.5.2 \
-    crate://crates.io/libz-sys/1.1.22 \
+    crate://crates.io/libz-rs-sys/0.5.4 \
+    crate://crates.io/libz-sys/1.1.23 \
     crate://crates.io/linux-raw-sys/0.11.0 \
     crate://crates.io/litemap/0.8.1 \
     crate://crates.io/lock_api/0.4.14 \
-    crate://crates.io/log/0.4.28 \
+    crate://crates.io/log/0.4.29 \
     crate://crates.io/matchers/0.2.0 \
     crate://crates.io/maybe-async/0.2.10 \
     crate://crates.io/memchr/2.7.6 \
@@ -209,23 +213,39 @@ SRC_URI += " \
     crate://crates.io/minimal-lexical/0.2.1 \
     crate://crates.io/miniz_oxide/0.8.9 \
     crate://crates.io/miow/0.6.1 \
+    crate://crates.io/nix/0.30.1 \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normpath/1.5.0 \
     crate://crates.io/nu-ansi-term/0.50.3 \
     crate://crates.io/num-conv/0.1.0 \
     crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/objc2/0.6.3 \
+    crate://crates.io/objc2-cloud-kit/0.3.2 \
+    crate://crates.io/objc2-core-data/0.3.2 \
+    crate://crates.io/objc2-core-foundation/0.3.2 \
+    crate://crates.io/objc2-core-graphics/0.3.2 \
+    crate://crates.io/objc2-core-image/0.3.2 \
+    crate://crates.io/objc2-core-location/0.3.2 \
+    crate://crates.io/objc2-core-text/0.3.2 \
+    crate://crates.io/objc2-encode/4.1.0 \
+    crate://crates.io/objc2-foundation/0.3.2 \
+    crate://crates.io/objc2-io-surface/0.3.2 \
+    crate://crates.io/objc2-quartz-core/0.3.2 \
+    crate://crates.io/objc2-ui-kit/0.3.2 \
+    crate://crates.io/objc2-user-notifications/0.3.2 \
     crate://crates.io/object/0.37.3 \
+    crate://crates.io/object/0.38.0 \
     crate://crates.io/once_cell/1.21.3 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/opener/0.8.3 \
-    crate://crates.io/openssl/0.10.74 \
+    crate://crates.io/openssl/0.10.75 \
     crate://crates.io/openssl-macros/0.1.1 \
     crate://crates.io/openssl-probe/0.1.6 \
     crate://crates.io/openssl-src/300.5.4+3.5.4 \
-    crate://crates.io/openssl-sys/0.9.110 \
+    crate://crates.io/openssl-sys/0.9.111 \
     crate://crates.io/ordered-float/2.10.1 \
     crate://crates.io/orion/0.17.11 \
-    crate://crates.io/os_info/3.12.0 \
+    crate://crates.io/os_info/3.13.0 \
     crate://crates.io/p384/0.13.1 \
     crate://crates.io/parking_lot/0.12.5 \
     crate://crates.io/parking_lot_core/0.9.12 \
@@ -236,7 +256,6 @@ SRC_URI += " \
     crate://crates.io/pin-project-lite/0.2.16 \
     crate://crates.io/pkcs8/0.10.2 \
     crate://crates.io/pkg-config/0.3.32 \
-    crate://crates.io/plist/1.8.0 \
     crate://crates.io/portable-atomic/1.11.1 \
     crate://crates.io/portable-atomic-util/0.2.4 \
     crate://crates.io/potential_utf/0.1.4 \
@@ -245,8 +264,7 @@ SRC_URI += " \
     crate://crates.io/primeorder/0.13.6 \
     crate://crates.io/proc-macro2/1.0.103 \
     crate://crates.io/prodash/30.0.1 \
-    crate://crates.io/quick-xml/0.38.3 \
-    crate://crates.io/quote/1.0.41 \
+    crate://crates.io/quote/1.0.42 \
     crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/rand/0.9.2 \
     crate://crates.io/rand_chacha/0.9.0 \
@@ -261,7 +279,7 @@ SRC_URI += " \
     crate://crates.io/rusqlite/0.37.0 \
     crate://crates.io/rustc-hash/2.1.1 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
-    crate://crates.io/rustfix/0.9.3 \
+    crate://crates.io/rustfix/0.9.4 \
     crate://crates.io/rustix/1.1.2 \
     crate://crates.io/rustversion/1.0.22 \
     crate://crates.io/ryu/1.0.20 \
@@ -285,10 +303,10 @@ SRC_URI += " \
     crate://crates.io/sha2/0.10.9 \
     crate://crates.io/sharded-slab/0.1.7 \
     crate://crates.io/shell-escape/0.1.5 \
-    crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/1.3.0 \
     crate://crates.io/signature/2.2.0 \
-    crate://crates.io/simd-adler32/0.3.7 \
+    crate://crates.io/simd-adler32/0.3.8 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/smallvec/1.15.1 \
     crate://crates.io/socket2/0.6.1 \
@@ -299,7 +317,7 @@ SRC_URI += " \
     crate://crates.io/subtle/2.6.1 \
     crate://crates.io/supports-hyperlinks/3.1.0 \
     crate://crates.io/supports-unicode/3.0.0 \
-    crate://crates.io/syn/2.0.108 \
+    crate://crates.io/syn/2.0.111 \
     crate://crates.io/synstructure/0.13.2 \
     crate://crates.io/tar/0.4.44 \
     crate://crates.io/tempfile/3.23.0 \
@@ -315,15 +333,15 @@ SRC_URI += " \
     crate://crates.io/tinyvec_macros/0.1.1 \
     crate://crates.io/toml/0.9.8 \
     crate://crates.io/toml_datetime/0.7.3 \
-    crate://crates.io/toml_edit/0.23.7 \
+    crate://crates.io/toml_edit/0.23.9 \
     crate://crates.io/toml_parser/1.0.4 \
     crate://crates.io/toml_writer/1.0.4 \
-    crate://crates.io/tracing/0.1.41 \
-    crate://crates.io/tracing-attributes/0.1.30 \
+    crate://crates.io/tracing/0.1.43 \
+    crate://crates.io/tracing-attributes/0.1.31 \
     crate://crates.io/tracing-chrome/0.7.2 \
-    crate://crates.io/tracing-core/0.1.34 \
+    crate://crates.io/tracing-core/0.1.35 \
     crate://crates.io/tracing-log/0.2.0 \
-    crate://crates.io/tracing-subscriber/0.3.20 \
+    crate://crates.io/tracing-subscriber/0.3.22 \
     crate://crates.io/typeid/1.0.3 \
     crate://crates.io/typenum/1.19.0 \
     crate://crates.io/unicase/2.8.1 \
@@ -341,13 +359,12 @@ SRC_URI += " \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
     crate://crates.io/wasip2/1.0.1+wasi-0.2.4 \
-    crate://crates.io/wasm-bindgen/0.2.105 \
-    crate://crates.io/wasm-bindgen-macro/0.2.105 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.105 \
-    crate://crates.io/wasm-bindgen-shared/0.2.105 \
+    crate://crates.io/wasm-bindgen/0.2.106 \
+    crate://crates.io/wasm-bindgen-macro/0.2.106 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.106 \
+    crate://crates.io/wasm-bindgen-shared/0.2.106 \
     crate://crates.io/winapi-util/0.1.11 \
     crate://crates.io/windows-link/0.2.1 \
-    crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-sys/0.59.0 \
     crate://crates.io/windows-sys/0.60.2 \
     crate://crates.io/windows-sys/0.61.2 \
@@ -369,31 +386,32 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnullvm/0.53.1 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.53.1 \
-    crate://crates.io/winnow/0.7.13 \
+    crate://crates.io/winnow/0.7.14 \
     crate://crates.io/wit-bindgen/0.46.0 \
     crate://crates.io/writeable/0.6.2 \
     crate://crates.io/yoke/0.8.1 \
     crate://crates.io/yoke-derive/0.8.1 \
-    crate://crates.io/zerocopy/0.8.27 \
-    crate://crates.io/zerocopy-derive/0.8.27 \
+    crate://crates.io/zerocopy/0.8.31 \
+    crate://crates.io/zerocopy-derive/0.8.31 \
     crate://crates.io/zerofrom/0.1.6 \
     crate://crates.io/zerofrom-derive/0.1.6 \
     crate://crates.io/zeroize/1.8.2 \
     crate://crates.io/zerotrie/0.2.3 \
     crate://crates.io/zerovec/0.11.5 \
     crate://crates.io/zerovec-derive/0.11.2 \
-    crate://crates.io/zlib-rs/0.5.2 \
+    crate://crates.io/zlib-rs/0.5.4 \
 "
 
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
 SRC_URI[aho-corasick-1.1.4.sha256sum] = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
-SRC_URI[annotate-snippets-0.12.8.sha256sum] = "025c7edcdffa4ccc5c0905f472a0ae3759378cfbef88ef518a3575e19ae3aebd"
+SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[annotate-snippets-0.12.10.sha256sum] = "15580ece6ea97cbf832d60ba19c021113469480852c6a2a6beb0db28f097bf1f"
 SRC_URI[anstream-0.6.21.sha256sum] = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
 SRC_URI[anstyle-1.0.13.sha256sum] = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
 SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
-SRC_URI[anstyle-query-1.1.4.sha256sum] = "9e231f6134f61b71076a3eab506c379d4f36122f2af15a9ff04415ea4c3339e2"
-SRC_URI[anstyle-wincon-3.0.10.sha256sum] = "3e0633414522a32ffaac8ac6cc8f748e090c5717661fddeea04219e2344f5f2a"
+SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
+SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[anyhow-1.0.100.sha256sum] = "a23eb6b1614318a8071c9b2521f36b424b2c83db5eb3a0fead4a6c0809af6e61"
 SRC_URI[arc-swap-1.7.1.sha256sum] = "69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
 SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
@@ -401,29 +419,31 @@ SRC_URI[arrayvec-0.7.6.sha256sum] = "7c02d123df017efcdfbd739ef81735b36c5ba83ec3c
 SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
-SRC_URI[base64ct-1.8.0.sha256sum] = "55248b47b0caf0546f7988906588779981c43bb1bc9d0c44087278f80cdb44ba"
+SRC_URI[base64ct-1.8.1.sha256sum] = "0e050f626429857a27ddccb31e0aca21356bfa709c04041aefddac081a8f068a"
 SRC_URI[bitflags-2.10.0.sha256sum] = "812e12b5285cc515a9c72a5c1d3b6d46a19dac5acfef5265968c166106e31dd3"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
 SRC_URI[blake3-1.8.2.sha256sum] = "3888aaa89e4b2a40fca9848e400f6a658a5a3978de7be858e209cafa8be9a4a0"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[block2-0.6.2.sha256sum] = "cdeb9d870516001442e364c5220d3574d2da8dc765554b4a617230d33fa58ef5"
 SRC_URI[bstr-1.12.1.sha256sum] = "63044e1ae8e69f3b5a92c736ca6269b8d12fa7efe39bf34ddb06d102cf0e2cab"
 SRC_URI[bumpalo-3.19.0.sha256sum] = "46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
-SRC_URI[bytes-1.10.1.sha256sum] = "d71b6127be86fdcfddb610f7182ac57211d4b18a3e9c82eb2d17662f2227ad6a"
-SRC_URI[cargo-0.92.0.sha256sum] = "89389877f508bae1d45a48b4e76cb0dac5e41a6ac5103752e44d29be0c69c394"
+SRC_URI[bytes-1.11.0.sha256sum] = "b35204fbdc0b3f4446b89fc1ac2cf84a8a68971995d0bf2e925ec7cd960f9cb3"
+SRC_URI[cargo-0.93.0.sha256sum] = "2a9eb357bdc58680a9d65ec020f0ec258d89a70c96d491b39606fb86a42c0dd5"
 SRC_URI[cargo-credential-0.4.9.sha256sum] = "e36f089041deadf16226478a7737a833864fbda09408c7af237b9d615eeb6d69"
-SRC_URI[cargo-credential-libsecret-0.5.2.sha256sum] = "90161b8b1b98a28f0fbdfccafb6adcf2b0be948a4fad3acc31461abf5447debe"
-SRC_URI[cargo-credential-macos-keychain-0.4.17.sha256sum] = "e95b9c2431165b30ea111f2933ed6799bfa9a66c9503046064cf8f001960ea1b"
-SRC_URI[cargo-credential-wincred-0.4.17.sha256sum] = "c35397b066a83f2e036fb23fca2fb400bfa65e8e8453c21e0b1690cf8250e414"
-SRC_URI[cargo-platform-0.3.1.sha256sum] = "122ec45a44b270afd1402f351b782c676b173e3c3fb28d86ff7ebfb4d86a4ee4"
-SRC_URI[cargo-util-0.2.24.sha256sum] = "f97c9ef0f8af69bfcecfe4c17a414d7bb978fe794bc1a38952e27b5c5d87492d"
-SRC_URI[cargo-util-schemas-0.10.1.sha256sum] = "549c00f5bb23fdaf26135d747d7530563402a101f1887a5a1916afe2c09cf229"
+SRC_URI[cargo-credential-libsecret-0.5.3.sha256sum] = "67e287f3cc9732b9a7eb5140e9501ec6557bdcdc83366a424993e4d4db228c4a"
+SRC_URI[cargo-credential-macos-keychain-0.4.18.sha256sum] = "806cb58d7644f7c4f8c8e47af5f7f2dc4e10f0ce205f0416e8fdc6d58c7efaf2"
+SRC_URI[cargo-credential-wincred-0.4.18.sha256sum] = "a12eac22936a44d4be4765ffb9a29cbd69faab267a637c578feef62f8cc96c39"
+SRC_URI[cargo-platform-0.3.2.sha256sum] = "87a0c0e6148f11f01f32650a2ea02d532b2ad4e81d8bd41e6e565b5adc5e6082"
+SRC_URI[cargo-util-0.2.25.sha256sum] = "03ae3fc62640c9e0235c95b07e68a59a31919d7331bd95961cc811bc0607c87b"
+SRC_URI[cargo-util-schemas-0.10.2.sha256sum] = "f714efe9b56ea4bed06b499396e77b68db663a55b16dc3f144d5a5a0dc19788c"
 SRC_URI[cbindgen-0.29.2.sha256sum] = "befbfd072a8e81c02f8c507aefce431fe5e7d051f83d48a23ffc9b9fe5a11799"
-SRC_URI[cc-1.2.44.sha256sum] = "37521ac7aabe3d13122dc382493e20c9416f299d2ccd5b3a5340a2570cdeb0f3"
+SRC_URI[cc-1.2.49.sha256sum] = "90583009037521a116abf44494efecd645ba48b6622457080f080b85544e2215"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[clap-4.5.51.sha256sum] = "4c26d721170e0295f191a69bd9a1f93efcdb0aff38684b61ab5750468972e5f5"
-SRC_URI[clap_builder-4.5.51.sha256sum] = "75835f0c7bf681bfd05abe44e965760fea999a5286c6eb2d59883634fd02011a"
-SRC_URI[clap_complete-4.5.60.sha256sum] = "8e602857739c5a4291dfa33b5a298aeac9006185229a700e5810a3ef7272d971"
+SRC_URI[cfg_aliases-0.2.1.sha256sum] = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
+SRC_URI[clap-4.5.53.sha256sum] = "c9e340e012a1bf4935f5282ed1436d1489548e8f72308207ea5df0e23d2d03f8"
+SRC_URI[clap_builder-4.5.53.sha256sum] = "d76b5d13eaa18c901fd2f7fca939fefe3a0727a953561fefdf3b2922b8569d00"
+SRC_URI[clap_complete-4.5.61.sha256sum] = "39615915e2ece2550c0149addac32fb5bd312c657f43845bb9088cb9c8a7c992"
 SRC_URI[clap_derive-4.5.49.sha256sum] = "2a0b5487afeab2deb2ff4e03a807ad1a03ac532ff5a2cee5d86884440c7f7671"
 SRC_URI[clap_lex-0.7.6.sha256sum] = "a1d728cc89cf3aee9ff92b05e62b19ee65a02b5702cff7d5a377e32c6ae29d8d"
 SRC_URI[clru-0.6.2.sha256sum] = "cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
@@ -435,7 +455,7 @@ SRC_URI[constant_time_eq-0.3.1.sha256sum] = "7c74b8349d32d297c9134b8c88677813a22
 SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crates-io-0.40.14.sha256sum] = "574ce0b8170c097cf174097b84bff181956ad2ab2bbe092ab58d1c08d9f1f417"
+SRC_URI[crates-io-0.40.15.sha256sum] = "62451b814867f57f25e941eeb22b55ada9d93308cb65578ec57e35e414091019"
 SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
 SRC_URI[crossbeam-channel-0.5.15.sha256sum] = "82b8f8f868b36967f9606790d1903570de9ceaf870a7bf9fbbd3016d636a2cb2"
 SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
@@ -445,20 +465,21 @@ SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
 SRC_URI[ct-codecs-1.1.6.sha256sum] = "9b10589d1a5e400d61f9f38f12f884cfd080ff345de8f17efda36fe0e4a02aa8"
 SRC_URI[curl-0.4.49.sha256sum] = "79fc3b6dd0b87ba36e565715bf9a2ced221311db47bd18011676f24a6066edbc"
-SRC_URI[curl-sys-0.4.83+curl-8.15.0.sha256sum] = "5830daf304027db10c82632a464879d46a3f7c4ba17a31592657ad16c719b483"
+SRC_URI[curl-sys-0.4.84+curl-8.17.0.sha256sum] = "abc4294dc41b882eaff37973c2ec3ae203d0091341ee68fbadd1d06e0c18a73b"
 SRC_URI[dashmap-6.1.0.sha256sum] = "5041cc499144891f3790297212f32a74fb938e5136a14943f338ef9e0ae276cf"
 SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
 SRC_URI[deranged-0.5.5.sha256sum] = "ececcb659e7ba858fb4f10388c250a7252eb0a27373f1a72b8748afdd248e587"
 SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
+SRC_URI[dispatch2-0.3.0.sha256sum] = "89a09f22a6c6069a18470eb92d2298acf25463f14256d24778e1230d789a2aec"
 SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
 SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
 SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
-SRC_URI[ed25519-compact-2.1.1.sha256sum] = "e9b3460f44bea8cd47f45a0c70892f1eff856d97cd55358b2f73f663789f6190"
+SRC_URI[ed25519-compact-2.2.0.sha256sum] = "33ce99a9e19c84beb4cc35ece85374335ccc398240712114c85038319ed709bd"
 SRC_URI[either-1.15.0.sha256sum] = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
 SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
 SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
-SRC_URI[erased-serde-0.4.8.sha256sum] = "259d404d09818dec19332e31d94558aeb442fea04c817006456c24b5460bbd4b"
+SRC_URI[erased-serde-0.4.9.sha256sum] = "89e8918065695684b2b0702da20382d5ae6065cf3327bc2d6436bd49a71ce9f3"
 SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
@@ -467,7 +488,7 @@ SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e9
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
 SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
 SRC_URI[filetime-0.2.26.sha256sum] = "bc0505cd1b6fa6580283f6bdf70a73fcf4aba1184038c90902b92b3dd0df63ed"
-SRC_URI[find-msvc-tools-0.1.4.sha256sum] = "52051878f80a721bb68ebfbc930e07b65ba72f2da88968ea5c06fd6ca3d3a127"
+SRC_URI[find-msvc-tools-0.1.5.sha256sum] = "3a3076410a55c90011c298b04d0cfa770b00fa04e1e3c97d3f6c9de105a03844"
 SRC_URI[flate2-1.1.5.sha256sum] = "bfe33edd8e85a12a67454e37f8c75e730830d83e313556ab9ebf9ee7fbeb3bfb"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[foldhash-0.1.5.sha256sum] = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
@@ -477,7 +498,7 @@ SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9
 SRC_URI[generic-array-0.14.9.sha256sum] = "4bb6743198531e02858aeaea5398fcc883e71851fcbcb5a2f773e2fb6cb1edf2"
 SRC_URI[getrandom-0.2.16.sha256sum] = "335ff9f135e4384c8150d6f27c6daed433577f86b4750418338c01a1a2528592"
 SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
-SRC_URI[git2-0.20.2.sha256sum] = "2deb07a133b1520dc1a5690e9bd08950108873d7ed5de38dcc74d3b5ebffa110"
+SRC_URI[git2-0.20.3.sha256sum] = "3e2b37e2f62729cdada11f0e6b3b6fe383c69c29fc619e391223e12856af308c"
 SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
 SRC_URI[gix-0.73.0.sha256sum] = "514c29cc879bdc0286b0cbc205585a49b252809eb86c69df4ce4f855ee75f635"
 SRC_URI[gix-actor-0.35.6.sha256sum] = "987a51a7e66db6ef4dc030418eb2a42af6b913a79edd8670766122d8af3ba59e"
@@ -508,7 +529,7 @@ SRC_URI[gix-odb-0.70.0.sha256sum] = "9c9d7af10fda9df0bb4f7f9bd507963560b3c66cb15
 SRC_URI[gix-pack-0.60.0.sha256sum] = "d8571df89bfca5abb49c3e3372393f7af7e6f8b8dbe2b96303593cef5b263019"
 SRC_URI[gix-packetline-0.19.3.sha256sum] = "64286a8b5148e76ab80932e72762dd27ccf6169dd7a134b027c8a262a8262fcf"
 SRC_URI[gix-packetline-blocking-0.19.3.sha256sum] = "89c59c3ad41e68cb38547d849e9ef5ccfc0d00f282244ba1441ae856be54d001"
-SRC_URI[gix-path-0.10.21.sha256sum] = "0416b41cd00ff292af9b94b0660880c44bd2ed66828ddca9a2b333535cbb71b8"
+SRC_URI[gix-path-0.10.22.sha256sum] = "7cb06c3e4f8eed6e24fd915fa93145e28a511f4ea0e768bae16673e05ed3f366"
 SRC_URI[gix-pathspec-0.12.0.sha256sum] = "daedead611c9bd1f3640dc90a9012b45f790201788af4d659f28d94071da7fba"
 SRC_URI[gix-prompt-0.11.2.sha256sum] = "868e6516dfa16fdcbc5f8c935167d085f2ae65ccd4c9476a4319579d12a69d8d"
 SRC_URI[gix-protocol-0.51.0.sha256sum] = "12b4b807c47ffcf7c1e5b8119585368a56449f3493da93b931e1d4239364e922"
@@ -535,7 +556,7 @@ SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9
 SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e902d4df49588d1470606"
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
 SRC_URI[hashbrown-0.15.5.sha256sum] = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
-SRC_URI[hashbrown-0.16.0.sha256sum] = "5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
+SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
 SRC_URI[hashlink-0.10.0.sha256sum] = "7382cf6263419f2d8df38c55d7da83da5c18aef87fc7a7fc1fb1e344edfe14c1"
 SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
@@ -548,8 +569,8 @@ SRC_URI[icu_collections-2.1.1.sha256sum] = "4c6b649701667bbe825c3b7e6388cb521c23
 SRC_URI[icu_locale_core-2.1.1.sha256sum] = "edba7861004dd3714265b4db54a3c390e880ab658fec5f7db895fae2046b5bb6"
 SRC_URI[icu_normalizer-2.1.1.sha256sum] = "5f6c8828b67bf8908d82127b2054ea1b4427ff0230ee9141c54251934ab1b599"
 SRC_URI[icu_normalizer_data-2.1.1.sha256sum] = "7aedcccd01fc5fe81e6b489c15b247b8b0690feb23304303a9e560f37efc560a"
-SRC_URI[icu_properties-2.1.1.sha256sum] = "e93fcd3157766c0c8da2f8cff6ce651a31f0810eaa1c51ec363ef790bbb5fb99"
-SRC_URI[icu_properties_data-2.1.1.sha256sum] = "02845b3647bb045f1100ecd6480ff52f34c35f82d9880e029d329c21d1054899"
+SRC_URI[icu_properties-2.1.2.sha256sum] = "020bfc02fe870ec3a66d93e677ccca0562506e5872c650f893269e08615d74ec"
+SRC_URI[icu_properties_data-2.1.2.sha256sum] = "616c294cf8d725c6afcd8f55abc17c56464ef6211f9ed59cccffe534129c77af"
 SRC_URI[icu_provider-2.1.1.sha256sum] = "85962cf0ce02e1e0a629cc34e7ca3e373ce20dda4c4d7294bbd0bf1fdb59e614"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
 SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
@@ -557,33 +578,33 @@ SRC_URI[ignore-0.4.25.sha256sum] = "d3d782a365a015e0f5c04902246139249abf76912500
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[imara-diff-0.1.8.sha256sum] = "17d34b7d42178945f775e84bc4c36dde7c1c6cdfea656d3354d009056f2bb3d2"
 SRC_URI[implib-0.4.0.sha256sum] = "7923c255262a0e44362e221f8b74b931fe21484b83f27386aa45f021a379caf6"
-SRC_URI[indexmap-2.12.0.sha256sum] = "6717a8d2a5a929a1a2eb43a12812498ed141a0bcfb7e8f7844fbdbe4303bba9f"
+SRC_URI[indexmap-2.12.1.sha256sum] = "0ad4bb2b565bca0645f4d68c5c9af97fba094e9791da685bf83cb5f3ce74acf2"
 SRC_URI[is_executable-1.0.5.sha256sum] = "baabb8b4867b26294d818bf3f651a454b6901431711abb96e296245888d6e8c4"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
 SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
-SRC_URI[jiff-0.2.15.sha256sum] = "be1f93b8b1eb69c77f24bbb0afdf66f54b632ee39af40ca21c4365a1d7347e49"
-SRC_URI[jiff-static-0.2.15.sha256sum] = "03343451ff899767262ec32146f6d559dd759fdadf42ff0e227c7c48f72594b4"
-SRC_URI[jiff-tzdb-0.1.4.sha256sum] = "c1283705eb0a21404d2bfd6eef2a7593d240bc42a0bdb39db0ad6fa2ec026524"
+SRC_URI[jiff-0.2.16.sha256sum] = "49cce2b81f2098e7e3efc35bc2e0a6b7abec9d34128283d7a26fa8f32a6dbb35"
+SRC_URI[jiff-static-0.2.16.sha256sum] = "980af8b43c3ad5d8d349ace167ec8170839f753a42d233ba19e08afe1850fa69"
+SRC_URI[jiff-tzdb-0.1.5.sha256sum] = "68971ebff725b9e2ca27a601c5eb38a4c5d64422c4cbab0c535f248087eda5c2"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.34.sha256sum] = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
-SRC_URI[js-sys-0.3.82.sha256sum] = "b011eec8cc36da2aab2d5cff675ec18454fad408585853910a202391cf9f8e65"
+SRC_URI[js-sys-0.3.83.sha256sum] = "464a3709c7f55f1f721e5389aa6ea4e3bc6aba669353300af094b29ffbdde1d8"
 SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
 SRC_URI[lazycell-1.3.0.sha256sum] = "830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
-SRC_URI[libc-0.2.177.sha256sum] = "2874a2af47a2325c2001a6e6fad9b16a53b802102b528163885171cf92b15976"
-SRC_URI[libgit2-sys-0.18.2+1.9.1.sha256sum] = "1c42fe03df2bd3c53a3a9c7317ad91d80c81cd1fb0caec8d7cc4cd2bfa10c222"
+SRC_URI[libc-0.2.178.sha256sum] = "37c93d8daa9d8a012fd8ab92f088405fb202ea0b6ab73ee2482ae66af4f42091"
+SRC_URI[libgit2-sys-0.18.3+1.9.2.sha256sum] = "c9b3acc4b91781bb0b3386669d325163746af5f6e4f73e6d2d630e09a35f3487"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[libnghttp2-sys-0.1.11+1.64.0.sha256sum] = "1b6c24e48a7167cffa7119da39d577fa482e66c688a4aac016bee862e1a713c4"
 SRC_URI[libredox-0.1.10.sha256sum] = "416f7e718bdb06000964960ffa43b4335ad4012ae8b99060261aa4a8088d5ccb"
 SRC_URI[libsqlite3-sys-0.35.0.sha256sum] = "133c182a6a2c87864fe97778797e46c7e999672690dc9fa3ee8e241aa4a9c13f"
 SRC_URI[libssh2-sys-0.3.1.sha256sum] = "220e4f05ad4a218192533b300327f5150e809b54c4ec83b5a1d91833601811b9"
-SRC_URI[libz-rs-sys-0.5.2.sha256sum] = "840db8cf39d9ec4dd794376f38acc40d0fc65eec2a8f484f7fd375b84602becd"
-SRC_URI[libz-sys-1.1.22.sha256sum] = "8b70e7a7df205e92a1a4cd9aaae7898dac0aa555503cc0a649494d0d60e7651d"
+SRC_URI[libz-rs-sys-0.5.4.sha256sum] = "15413ef615ad868d4d65dce091cb233b229419c7c0c4bcaa746c0901c49ff39c"
+SRC_URI[libz-sys-1.1.23.sha256sum] = "15d118bbf3771060e7311cc7bb0545b01d08a8b4a7de949198dec1fa0ca1c0f7"
 SRC_URI[linux-raw-sys-0.11.0.sha256sum] = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
 SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
-SRC_URI[log-0.4.28.sha256sum] = "34080505efa8e45a4b816c349525ebe327ceaa8559756f0356cba97ef3bf7432"
+SRC_URI[log-0.4.29.sha256sum] = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
 SRC_URI[matchers-0.2.0.sha256sum] = "d1525a2a28c7f4fa0fc98bb91ae755d1e2d1505079e05539e35bc876b5d65ae9"
 SRC_URI[maybe-async-0.2.10.sha256sum] = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
 SRC_URI[memchr-2.7.6.sha256sum] = "f52b00d39961fc5b2736ea853c9cc86238e165017a493d1d5c8eac6bdc4cc273"
@@ -592,23 +613,39 @@ SRC_URI[memoffset-0.9.1.sha256sum] = "488016bfae457b036d996092f6cb448677611ce444
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
 SRC_URI[miow-0.6.1.sha256sum] = "536bfad37a309d62069485248eeaba1e8d9853aaf951caaeaed0585a95346f08"
+SRC_URI[nix-0.30.1.sha256sum] = "74523f3a35e05aba87a1d978330aef40f67b0304ac79c1c00b294c9830543db6"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normpath-1.5.0.sha256sum] = "bf23ab2b905654b4cb177e30b629937b3868311d4e1cba859f899c041046e69b"
 SRC_URI[nu-ansi-term-0.50.3.sha256sum] = "7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5"
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[objc2-0.6.3.sha256sum] = "b7c2599ce0ec54857b29ce62166b0ed9b4f6f1a70ccc9a71165b6154caca8c05"
+SRC_URI[objc2-cloud-kit-0.3.2.sha256sum] = "73ad74d880bb43877038da939b7427bba67e9dd42004a18b809ba7d87cee241c"
+SRC_URI[objc2-core-data-0.3.2.sha256sum] = "0b402a653efbb5e82ce4df10683b6b28027616a2715e90009947d50b8dd298fa"
+SRC_URI[objc2-core-foundation-0.3.2.sha256sum] = "2a180dd8642fa45cdb7dd721cd4c11b1cadd4929ce112ebd8b9f5803cc79d536"
+SRC_URI[objc2-core-graphics-0.3.2.sha256sum] = "e022c9d066895efa1345f8e33e584b9f958da2fd4cd116792e15e07e4720a807"
+SRC_URI[objc2-core-image-0.3.2.sha256sum] = "e5d563b38d2b97209f8e861173de434bd0214cf020e3423a52624cd1d989f006"
+SRC_URI[objc2-core-location-0.3.2.sha256sum] = "ca347214e24bc973fc025fd0d36ebb179ff30536ed1f80252706db19ee452009"
+SRC_URI[objc2-core-text-0.3.2.sha256sum] = "0cde0dfb48d25d2b4862161a4d5fcc0e3c24367869ad306b0c9ec0073bfed92d"
+SRC_URI[objc2-encode-4.1.0.sha256sum] = "ef25abbcd74fb2609453eb695bd2f860d389e457f67dc17cafc8b8cbc89d0c33"
+SRC_URI[objc2-foundation-0.3.2.sha256sum] = "e3e0adef53c21f888deb4fa59fc59f7eb17404926ee8a6f59f5df0fd7f9f3272"
+SRC_URI[objc2-io-surface-0.3.2.sha256sum] = "180788110936d59bab6bd83b6060ffdfffb3b922ba1396b312ae795e1de9d81d"
+SRC_URI[objc2-quartz-core-0.3.2.sha256sum] = "96c1358452b371bf9f104e21ec536d37a650eb10f7ee379fff67d2e08d537f1f"
+SRC_URI[objc2-ui-kit-0.3.2.sha256sum] = "d87d638e33c06f577498cbcc50491496a3ed4246998a7fbba7ccb98b1e7eab22"
+SRC_URI[objc2-user-notifications-0.3.2.sha256sum] = "9df9128cbbfef73cda168416ccf7f837b62737d748333bfe9ab71c245d76613e"
 SRC_URI[object-0.37.3.sha256sum] = "ff76201f031d8863c38aa7f905eca4f53abbfa15f609db4277d44cd8938f33fe"
+SRC_URI[object-0.38.0.sha256sum] = "b8b28f24bd43920cd8e0bc4f9c6553e8b93221c512cb9a1014987fc89d36f830"
 SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[opener-0.8.3.sha256sum] = "cb9024962ab91e00c89d2a14352a8d0fc1a64346bf96f1839b45c09149564e47"
-SRC_URI[openssl-0.10.74.sha256sum] = "24ad14dd45412269e1a30f52ad8f0664f0f4f4a89ee8fe28c3b3527021ebb654"
+SRC_URI[openssl-0.10.75.sha256sum] = "08838db121398ad17ab8531ce9de97b244589089e290a384c900cb9ff7434328"
 SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
 SRC_URI[openssl-probe-0.1.6.sha256sum] = "d05e27ee213611ffe7d6348b942e8f942b37114c00cc03cec254295a4a17852e"
 SRC_URI[openssl-src-300.5.4+3.5.4.sha256sum] = "a507b3792995dae9b0df8a1c1e3771e8418b7c2d9f0baeba32e6fe8b06c7cb72"
-SRC_URI[openssl-sys-0.9.110.sha256sum] = "0a9f0075ba3c21b09f8e8b2026584b1d18d49388648f2fbbf3c97ea8deced8e2"
+SRC_URI[openssl-sys-0.9.111.sha256sum] = "82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
 SRC_URI[orion-0.17.11.sha256sum] = "21b3da83b2b4cdc74ab6a556b2e7b473da046d5aa4008c0a7a3ae96b1b4aabb4"
-SRC_URI[os_info-3.12.0.sha256sum] = "d0e1ac5fde8d43c34139135df8ea9ee9465394b2d8d20f032d38998f64afffc3"
+SRC_URI[os_info-3.13.0.sha256sum] = "7c39b5918402d564846d5aba164c09a66cc88d232179dfd3e3c619a25a268392"
 SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
 SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
@@ -619,7 +656,6 @@ SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f67
 SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
 SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
-SRC_URI[plist-1.8.0.sha256sum] = "740ebea15c5d1428f910cd1a5f52cebf8d25006245ed8ade92702f4943d91e07"
 SRC_URI[portable-atomic-1.11.1.sha256sum] = "f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
 SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
 SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
@@ -628,8 +664,7 @@ SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
 SRC_URI[proc-macro2-1.0.103.sha256sum] = "5ee95bc4ef87b8d5ba32e8b7714ccc834865276eab0aed5c9958d00ec45f49e8"
 SRC_URI[prodash-30.0.1.sha256sum] = "5a6efc566849d3d9d737c5cb06cc50e48950ebe3d3f9d70631490fff3a07b139"
-SRC_URI[quick-xml-0.38.3.sha256sum] = "42a232e7487fc2ef313d96dde7948e7a3c05101870d8985e4fd8d26aedd27b89"
-SRC_URI[quote-1.0.41.sha256sum] = "ce25767e7b499d1b604768e7cde645d14cc8584231ea6b295e9c9eb22c02e1d1"
+SRC_URI[quote-1.0.42.sha256sum] = "a338cc41d27e6cc6dce6cefc13a0729dfbb81c262b1f519331575dd80ef3067f"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
@@ -644,7 +679,7 @@ SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119
 SRC_URI[rusqlite-0.37.0.sha256sum] = "165ca6e57b20e1351573e3729b958bc62f0e48025386970b6e4d29e7a7e71f3f"
 SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
-SRC_URI[rustfix-0.9.3.sha256sum] = "267bf52289c9e66a8f140f1c8109c1324f5f39248b8af5997bd0d78ec8d6ffd2"
+SRC_URI[rustfix-0.9.4.sha256sum] = "864792a841a1d785ba91b8d2a75e1936b40bc517020c3c2958ac403b92e4f00a"
 SRC_URI[rustix-1.1.2.sha256sum] = "cd15f8a2c5551a84d56efdc1cd049089e409ac19a3072d5037a17fd70719ff3e"
 SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
 SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
@@ -668,10 +703,10 @@ SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832
 SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
 SRC_URI[sharded-slab-0.1.7.sha256sum] = "f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6"
 SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873bfad7dc788c42e6430db40184f"
-SRC_URI[shell-words-1.1.0.sha256sum] = "24188a676b6ae68c3b2cb3a01be17fbf7240ce009799bb56d5b1409051e78fde"
+SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
-SRC_URI[simd-adler32-0.3.7.sha256sum] = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
+SRC_URI[simd-adler32-0.3.8.sha256sum] = "e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
 SRC_URI[socket2-0.6.1.sha256sum] = "17129e116933cf371d018bb80ae557e889637989d8638274fb25622827b03881"
@@ -682,7 +717,7 @@ SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70
 SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
 SRC_URI[supports-hyperlinks-3.1.0.sha256sum] = "804f44ed3c63152de6a9f90acbea1a110441de43006ea51bcce8f436196a288b"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
-SRC_URI[syn-2.0.108.sha256sum] = "da58917d35242480a05c2897064da0a80589a2a0476c9a3f2fdc83b53502e917"
+SRC_URI[syn-2.0.111.sha256sum] = "390cc9a294ab71bdb1aa2e99d13be9c753cd2d7bd6560c77118597410c4d2e87"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
 SRC_URI[tar-0.4.44.sha256sum] = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
 SRC_URI[tempfile-3.23.0.sha256sum] = "2d31c77bdf42a745371d260a26ca7163f1e0924b64afa0b688e61b5a9fa02f16"
@@ -698,15 +733,15 @@ SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
 SRC_URI[toml-0.9.8.sha256sum] = "f0dc8b1fb61449e27716ec0e1bdf0f6b8f3e8f6b05391e8497b8b6d7804ea6d8"
 SRC_URI[toml_datetime-0.7.3.sha256sum] = "f2cdb639ebbc97961c51720f858597f7f24c4fc295327923af55b74c3c724533"
-SRC_URI[toml_edit-0.23.7.sha256sum] = "6485ef6d0d9b5d0ec17244ff7eb05310113c3f316f2d14200d4de56b3cb98f8d"
+SRC_URI[toml_edit-0.23.9.sha256sum] = "5d7cbc3b4b49633d57a0509303158ca50de80ae32c265093b24c414705807832"
 SRC_URI[toml_parser-1.0.4.sha256sum] = "c0cbe268d35bdb4bb5a56a2de88d0ad0eb70af5384a99d648cd4b3d04039800e"
 SRC_URI[toml_writer-1.0.4.sha256sum] = "df8b2b54733674ad286d16267dcfc7a71ed5c776e4ac7aa3c3e2561f7c637bf2"
-SRC_URI[tracing-0.1.41.sha256sum] = "784e0ac535deb450455cbfa28a6f0df145ea1bb7ae51b821cf5e7927fdcfbdd0"
-SRC_URI[tracing-attributes-0.1.30.sha256sum] = "81383ab64e72a7a8b8e13130c49e3dab29def6d0c7d76a03087b3cf71c5c6903"
+SRC_URI[tracing-0.1.43.sha256sum] = "2d15d90a0b5c19378952d479dc858407149d7bb45a14de0142f6c534b16fc647"
+SRC_URI[tracing-attributes-0.1.31.sha256sum] = "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
-SRC_URI[tracing-core-0.1.34.sha256sum] = "b9d12581f227e93f094d3af2ae690a574abb8a2b9b7a96e7cfe9647b2b617678"
+SRC_URI[tracing-core-0.1.35.sha256sum] = "7a04e24fab5c89c6a36eb8558c9656f30d81de51dfa4d3b45f26b21d61fa0a6c"
 SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
-SRC_URI[tracing-subscriber-0.3.20.sha256sum] = "2054a14f5307d601f88daf0553e1cbf472acc4f2c51afab632431cdcd72124d5"
+SRC_URI[tracing-subscriber-0.3.22.sha256sum] = "2f30143827ddab0d256fd843b7a66d164e9f271cfa0dde49142c5ca0ca291f1e"
 SRC_URI[typeid-1.0.3.sha256sum] = "bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
 SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
 SRC_URI[unicase-2.8.1.sha256sum] = "75b844d17643ee918803943289730bec8aac480150456169e647ed0b576ba539"
@@ -724,13 +759,12 @@ SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
 SRC_URI[wasip2-1.0.1+wasi-0.2.4.sha256sum] = "0562428422c63773dad2c345a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
-SRC_URI[wasm-bindgen-0.2.105.sha256sum] = "da95793dfc411fbbd93f5be7715b0578ec61fe87cb1a42b12eb625caa5c5ea60"
-SRC_URI[wasm-bindgen-macro-0.2.105.sha256sum] = "04264334509e04a7bf8690f2384ef5265f05143a4bff3889ab7a3269adab59c2"
-SRC_URI[wasm-bindgen-macro-support-0.2.105.sha256sum] = "420bc339d9f322e562942d52e115d57e950d12d88983a14c79b86859ee6c7ebc"
-SRC_URI[wasm-bindgen-shared-0.2.105.sha256sum] = "76f218a38c84bcb33c25ec7059b07847d465ce0e0a76b995e134a45adcb6af76"
+SRC_URI[wasm-bindgen-0.2.106.sha256sum] = "0d759f433fa64a2d763d1340820e46e111a7a5ab75f993d1852d70b03dbb80fd"
+SRC_URI[wasm-bindgen-macro-0.2.106.sha256sum] = "48cb0d2638f8baedbc542ed444afc0644a29166f1595371af4fecf8ce1e7eeb3"
+SRC_URI[wasm-bindgen-macro-support-0.2.106.sha256sum] = "cefb59d5cd5f92d9dcf80e4683949f15ca4b511f4ac0a6e14d4e1ac60c6ecd40"
+SRC_URI[wasm-bindgen-shared-0.2.106.sha256sum] = "cbc538057e648b67f72a982e708d485b2efa771e1ac05fec311f9f63e5800db4"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
-SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
 SRC_URI[windows-sys-0.60.2.sha256sum] = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
@@ -752,17 +786,17 @@ SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b4
 SRC_URI[windows_x86_64_gnullvm-0.53.1.sha256sum] = "0ffa179e2d07eee8ad8f57493436566c7cc30ac536a3379fdf008f47f6bb7ae1"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[windows_x86_64_msvc-0.53.1.sha256sum] = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
-SRC_URI[winnow-0.7.13.sha256sum] = "21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
+SRC_URI[winnow-0.7.14.sha256sum] = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
 SRC_URI[wit-bindgen-0.46.0.sha256sum] = "f17a85883d4e6d00e8a97c586de764dabcc06133f7f1d55dce5cdc070ad7fe59"
 SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
 SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
 SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
-SRC_URI[zerocopy-0.8.27.sha256sum] = "0894878a5fa3edfd6da3f88c4805f4c8558e2b996227a3d864f47fe11e38282c"
-SRC_URI[zerocopy-derive-0.8.27.sha256sum] = "88d2b8d9c68ad2b9e4340d7832716a4d21a22a1154777ad56ea55c51a9cf3831"
+SRC_URI[zerocopy-0.8.31.sha256sum] = "fd74ec98b9250adb3ca554bdde269adf631549f51d8a8f8f0a10b50f1cb298c3"
+SRC_URI[zerocopy-derive-0.8.31.sha256sum] = "d8a8d209fdf45cf5138cbb5a506f6b52522a25afccc534d1475dad8e31105c6a"
 SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
 SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
 SRC_URI[zeroize-1.8.2.sha256sum] = "b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
 SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
 SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
 SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
-SRC_URI[zlib-rs-0.5.2.sha256sum] = "2f06ae92f42f5e5c42443fd094f245eb656abf56dd7cce9b8b263236565e00f2"
+SRC_URI[zlib-rs-0.5.4.sha256sum] = "51f936044d677be1a1168fae1d03b583a285a5dd9d8cbf7b24c23aa1fc775235"
diff --git a/recipes-devtools/rust/cargo-c_0.10.18+cargo-0.92.0.bb b/recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb
similarity index 87%
rename from recipes-devtools/rust/cargo-c_0.10.18+cargo-0.92.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb
index ac14d9c..f3923c7 100644
--- a/recipes-devtools/rust/cargo-c_0.10.18+cargo-0.92.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.12/ \
 "
-SRC_URI[cargo-c.sha256sum] = "2a15984245971462c8e0e6c4e7f1d11f1693af9f7fa11b35c099ab76d749c523"
+SRC_URI[cargo-c.sha256sum] = "d42aa5310f659a1c3c0dea92f6dd5ba0d4e0d8d5c221ecc341ba36846ab5f7da"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
-- 
2.51.0


