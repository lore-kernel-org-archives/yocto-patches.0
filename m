Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6312.1794870785677625083
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZRmIIUUg;
 spf=pass (domain: konsulko.com, ip: 209.85.221.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso3704920e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870784; x=1795475584; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fXD1KtKdjhm/eO+SF26h/yk5qqOrF7u26WNSVIPppvc=;
        b=ZRmIIUUgcj0HmM7NQlIqcQ0RE4slWF9h6Y+MdopoQUVUC1qV+llr8i7HsqIz4guMCe
         WxYBO+DjOX/pO1laLofymcg6Gm3WA1Ie7gL67RLqZn5gFxPXdPPTNa9RhqQCObRWGNah
         4qPed2wTxSCrusmuruIaSc+Xa5BavKx7dvNvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870784; x=1795475584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fXD1KtKdjhm/eO+SF26h/yk5qqOrF7u26WNSVIPppvc=;
        b=Jlikn2v89cPp8WBe2mSW0Gc3RCc1TwTvnR/SJQoWu8eMg8hjRLdZSMqCCXTGiHFJOl
         aQZ9pT++euRqORuzKqf3jY6pT3fkf/6zu8nsIJ9V3NaYqfZKG3RRp39L3LmlNsowdTzt
         O30eBsb8CkOsF5h9ezwj7D1TmKkcXjFKkcWFMYqR/Ar+aulXV0PtHHBHkVNYU4+Kq2XM
         xhKh+2zRnNkHWNtec7Wkg73Jejl3MSXyo4iUUX3vdFF7Frf/1A1MBXEfMn/rG6FZFe9p
         8TI5b4SfEg7Ww6Ie4b94/vuV7whR3+q/rCdirTaj25h53soLRp+oN7zV7PpbX+yQL7Na
         CZIA==
X-Gm-Message-State: APuU4Z9tnONvG9nbQzrOygSnzI2Edzsup9zvQeXx4cXkkvIV8opeJUxU
	6Om+c8pO+wnjvwknoZnWqLY2s67UbZ7ApmLOgLTuSHRLHOxMZJdEna8QpJMqzDnj4sbbc1NqlJn
	coIBxO9M=
X-Gm-Gg: AYBFou1abg8A1d7agM7QkfaHXfrfgbJ0FhE+MuHoFWlyT72isoTr/CYrXOsh2EyOBkD
	k9Ijq79+YG6Z0RbyWxbmNfw9HPP1LBZl83+TEsZXkxev8wlV4dL1VkRTE/nOBWfKf97vn2PTknU
	KzBypc9OyZJBFq6X6cU3W1mCsZQi++Ooi9+lVF8hLnnnZJhGCLRjUqIWWAOW7v6Ur07FObung5F
	SFNKT1C4Byn3lePreJyLNF3I+sx+HmYHhKaFiyFERCtm4vxQ10T/vue9Hf6aTARWEYlN38tNcqE
	GsqHdSLrwZCCzewBTxzFO0ewiKEVIo5EyPgl5GsBhP21f25Tik9SNVzFipXG08g0GA9gJ1tLxkZ
	QjsmfI5CpJ3tKaO+jWK7R6AkXpG7JSo+QjmlRvgMl9Rukrbay+P7lhitkFvJgWMu7kCGtU4BqhK
	g0hbi+kFIuEtQW3HEEUaj5FvE7tDvIc8p4A66eHUX246THzf3l9tF8cpfbLPAGxZ8UHUcKmmBWv
	0b36eRxLS2gwVHfEnnrtwhdi/pk3oB6sUu56neU1YW5QuvC4k6H4cC+ojfSHlg5Zjs/+rV9550h
	rFRIbNo9Ykmy+B/qZfNshMA+v4+rHBOyMlt2EbIH64eiFRuhaIamvavzG0zAbUFmQBQGSZ9ae8D
	AZ2PBbSdNnzdGWEcdPXfbRKjfosPyHUonY8MvRJsYM7Mq122hCdX363Y3P6ttWboS1A==
X-Received: by 2002:a05:6122:3110:b0:5ec:e6b8:ebad with SMTP id 71dfb90a1353d-5ee34a6e073mr4861133e0c.10.1794870783843;
        Mon, 16 Nov 2026 15:13:03 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:03 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 14/19] cargo-c: upgrade 0.10.25 -> 0.10.26
Date: Mon, 16 Nov 2026 18:12:35 -0500
Message-ID: <b8d1bbe60dd2edc1f26501fbfa31a7cc3aa87441.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5453
Content-Type: text/plain; charset="utf-8"

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Update cargo-c from 0.10.25+cargo-0.99.0 to 0.10.26+cargo-0.100.0.

The embedded cargo library is updated from 0.99.0 to 0.100.0.

Notable dependency changes:
- cargo: 0.99.0 -> 0.100.0
- crates-io: 0.41.1 -> 0.41.2
- cargo-util: 0.2.31 -> 0.2.32
- cargo-util-schemas: 0.14.2 -> 0.14.3
- cargo-util-terminal: 0.1.1 -> 0.1.2
- cargo-credential: 0.4.10 -> 0.4.11 (and libsecret/macos-keychain/
  wincred backends updated accordingly)
- rustfix: 0.9.7 -> 0.9.8
- curl: 0.4.50 -> 0.4.51, curl-sys: 0.4.90+curl-8.21.0 ->
  0.4.91+curl-8.22.0
- cbindgen deps: clap 4.6.6 -> 4.6.7 (and clap_* sub-crates)
- gix-path: 0.12.5 -> 0.12.6
- jiff: 0.2.35 -> 0.2.38 (and jiff-core/jiff-static/jiff-tzdb)
- wasm-bindgen: 0.2.127 -> 0.2.129 (and macro/shared sub-crates)
- rustix: 1.1.4 -> 1.1.5
- toml: 1.1.4 -> 1.1.8 (and toml_edit/toml_parser/toml_writer/
  toml_datetime)
- thiserror: 2.0.20 -> 2.0.21
- cc: 1.4.4 -> 1.7.0

Removed crates (4): adler2, miniz_oxide, simd-adler32 and
tinyvec_macros.

Added crates (4): core_detect, defmt, multiversion_no_op and
simdutf8.

The parking_lot_core riscv32 patch is retained as the crate
remains at version 0.9.12.

Assisted-by: Kiro CLI 2.27.1 (AI assistant)
Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d6f39d7e6fde0da50382b81d0aa494353a0c5885)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 332 +++++++++---------
 ....0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} |   2 +-
 2 files changed, 167 insertions(+), 167 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.25+cargo-0.99.0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} (87%)

diff --git a/recipes-devtools/cargo-c/cargo-c-crates.inc b/recipes-devtools/cargo-c/cargo-c-crates.inc
index 4d24368..da5994a 100644
--- a/recipes-devtools/cargo-c/cargo-c-crates.inc
+++ b/recipes-devtools/cargo-c/cargo-c-crates.inc
@@ -2,7 +2,6 @@
 
 # from Cargo.lock
 SRC_URI += " \
-    crate://crates.io/adler2/2.0.1 \
     crate://crates.io/aho-corasick/1.1.5 \
     crate://crates.io/allocator-api2/0.2.21 \
     crate://crates.io/android_system_properties/0.1.6 \
@@ -24,7 +23,7 @@ SRC_URI += " \
     crate://crates.io/base64/0.22.1 \
     crate://crates.io/base64ct/1.8.3 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.13.1 \
+    crate://crates.io/bitflags/2.13.2 \
     crate://crates.io/bitmaps/2.1.0 \
     crate://crates.io/blake3/1.8.7 \
     crate://crates.io/block-buffer/0.10.4 \
@@ -34,26 +33,26 @@ SRC_URI += " \
     crate://crates.io/bumpalo/3.20.3 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.12.1 \
-    crate://crates.io/camino/1.2.5 \
-    crate://crates.io/cargo/0.99.0 \
-    crate://crates.io/cargo-credential/0.4.10 \
-    crate://crates.io/cargo-credential-libsecret/0.5.9 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.24 \
-    crate://crates.io/cargo-credential-wincred/0.4.24 \
+    crate://crates.io/camino/1.2.6 \
+    crate://crates.io/cargo/0.100.0 \
+    crate://crates.io/cargo-credential/0.4.11 \
+    crate://crates.io/cargo-credential-libsecret/0.5.10 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.25 \
+    crate://crates.io/cargo-credential-wincred/0.4.25 \
     crate://crates.io/cargo-platform/0.3.3 \
-    crate://crates.io/cargo-util/0.2.31 \
-    crate://crates.io/cargo-util-schemas/0.14.2 \
-    crate://crates.io/cargo-util-terminal/0.1.1 \
+    crate://crates.io/cargo-util/0.2.32 \
+    crate://crates.io/cargo-util-schemas/0.14.3 \
+    crate://crates.io/cargo-util-terminal/0.1.2 \
     crate://crates.io/cbindgen/0.29.4 \
-    crate://crates.io/cc/1.4.4 \
-    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/cc/1.7.0 \
+    crate://crates.io/cfg-if/1.0.5 \
     crate://crates.io/cfg_aliases/0.2.2 \
-    crate://crates.io/chacha20/0.10.1 \
-    crate://crates.io/clap/4.6.6 \
-    crate://crates.io/clap_builder/4.6.6 \
-    crate://crates.io/clap_complete/4.6.9 \
-    crate://crates.io/clap_derive/4.6.4 \
-    crate://crates.io/clap_lex/1.1.0 \
+    crate://crates.io/chacha20/0.10.2 \
+    crate://crates.io/clap/4.6.7 \
+    crate://crates.io/clap_builder/4.6.7 \
+    crate://crates.io/clap_complete/4.6.11 \
+    crate://crates.io/clap_derive/4.6.7 \
+    crate://crates.io/clap_lex/1.1.1 \
     crate://crates.io/clru/0.6.3 \
     crate://crates.io/cmov/0.5.4 \
     crate://crates.io/color-print/0.3.7 \
@@ -64,22 +63,24 @@ SRC_URI += " \
     crate://crates.io/constant_time_eq/0.4.2 \
     crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
+    crate://crates.io/core_detect/1.0.0 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/cpufeatures/0.3.0 \
-    crate://crates.io/crates-io/0.41.1 \
-    crate://crates.io/crc32fast/1.5.1 \
-    crate://crates.io/crossbeam-channel/0.5.16 \
-    crate://crates.io/crossbeam-deque/0.8.7 \
-    crate://crates.io/crossbeam-epoch/0.9.20 \
-    crate://crates.io/crossbeam-utils/0.8.22 \
+    crate://crates.io/cpufeatures/0.3.1 \
+    crate://crates.io/crates-io/0.41.2 \
+    crate://crates.io/crc32fast/1.5.2 \
+    crate://crates.io/crossbeam-channel/0.5.17 \
+    crate://crates.io/crossbeam-deque/0.8.8 \
+    crate://crates.io/crossbeam-epoch/0.9.21 \
+    crate://crates.io/crossbeam-utils/0.8.23 \
     crate://crates.io/crypto-bigint/0.5.5 \
     crate://crates.io/crypto-common/0.1.6 \
     crate://crates.io/crypto-common/0.2.2 \
-    crate://crates.io/ct-codecs/1.1.7 \
-    crate://crates.io/ctutils/0.4.2 \
-    crate://crates.io/curl/0.4.50 \
-    crate://crates.io/curl-sys/0.4.90+curl-8.21.0 \
+    crate://crates.io/ct-codecs/1.1.8 \
+    crate://crates.io/ctutils/0.4.3 \
+    crate://crates.io/curl/0.4.51 \
+    crate://crates.io/curl-sys/0.4.91+curl-8.22.0 \
     crate://crates.io/dashmap/6.2.1 \
+    crate://crates.io/defmt/0.3.100 \
     crate://crates.io/defmt/1.1.1 \
     crate://crates.io/defmt-macros/1.1.1 \
     crate://crates.io/defmt-parser/1.0.0 \
@@ -91,22 +92,22 @@ SRC_URI += " \
     crate://crates.io/displaydoc/0.2.7 \
     crate://crates.io/dunce/1.0.5 \
     crate://crates.io/ecdsa/0.16.9 \
-    crate://crates.io/ed25519-compact/2.4.2 \
-    crate://crates.io/either/1.18.0 \
+    crate://crates.io/ed25519-compact/2.6.0 \
+    crate://crates.io/either/1.19.0 \
     crate://crates.io/elliptic-curve/0.13.8 \
-    crate://crates.io/encoding_rs/0.8.35 \
+    crate://crates.io/encoding_rs/0.8.42 \
     crate://crates.io/equivalent/1.0.2 \
     crate://crates.io/erased-serde/0.4.10 \
     crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
-    crate://crates.io/faster-hex/0.10.0 \
+    crate://crates.io/faster-hex/0.10.1 \
     crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/ff/0.13.1 \
     crate://crates.io/fiat-crypto/0.3.0 \
     crate://crates.io/filetime/0.2.29 \
-    crate://crates.io/find-msvc-tools/0.1.11 \
-    crate://crates.io/flate2/1.1.9 \
+    crate://crates.io/find-msvc-tools/0.1.14 \
+    crate://crates.io/flate2/1.1.10 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/foldhash/0.2.0 \
     crate://crates.io/foreign-types/0.3.2 \
@@ -157,7 +158,7 @@ SRC_URI += " \
     crate://crates.io/gix-odb/0.82.0 \
     crate://crates.io/gix-pack/0.72.0 \
     crate://crates.io/gix-packetline/0.21.5 \
-    crate://crates.io/gix-path/0.12.5 \
+    crate://crates.io/gix-path/0.12.6 \
     crate://crates.io/gix-pathspec/0.18.1 \
     crate://crates.io/gix-prompt/0.15.1 \
     crate://crates.io/gix-protocol/0.63.0 \
@@ -186,7 +187,7 @@ SRC_URI += " \
     crate://crates.io/hashbrown/0.14.5 \
     crate://crates.io/hashbrown/0.16.1 \
     crate://crates.io/hashbrown/0.17.1 \
-    crate://crates.io/hashlink/0.12.1 \
+    crate://crates.io/hashlink/0.12.2 \
     crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
     crate://crates.io/hex/0.4.3 \
@@ -196,7 +197,7 @@ SRC_URI += " \
     crate://crates.io/home/0.5.12 \
     crate://crates.io/http/1.5.0 \
     crate://crates.io/http-auth/0.1.10 \
-    crate://crates.io/hybrid-array/0.4.14 \
+    crate://crates.io/hybrid-array/0.4.15 \
     crate://crates.io/icu_collections/2.3.0 \
     crate://crates.io/icu_locale_core/2.3.0 \
     crate://crates.io/icu_normalizer/2.3.0 \
@@ -209,26 +210,26 @@ SRC_URI += " \
     crate://crates.io/ignore/0.4.33 \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/implib/0.6.0 \
-    crate://crates.io/indexmap/2.14.0 \
+    crate://crates.io/indexmap/2.14.2 \
     crate://crates.io/is_executable/1.0.6 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.15.0 \
     crate://crates.io/itoa/1.0.18 \
-    crate://crates.io/jiff/0.2.35 \
-    crate://crates.io/jiff-core/0.1.0 \
-    crate://crates.io/jiff-static/0.2.35 \
-    crate://crates.io/jiff-tzdb/0.1.8 \
+    crate://crates.io/jiff/0.2.38 \
+    crate://crates.io/jiff-core/0.1.1 \
+    crate://crates.io/jiff-static/0.2.38 \
+    crate://crates.io/jiff-tzdb/0.1.9 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.35 \
-    crate://crates.io/js-sys/0.3.104 \
-    crate://crates.io/kstring/2.0.4 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.189 \
+    crate://crates.io/js-sys/0.3.106 \
+    crate://crates.io/kstring/2.0.5 \
+    crate://crates.io/lazy_static/1.5.1 \
+    crate://crates.io/libc/0.2.190 \
     crate://crates.io/libgit2-sys/0.18.8+1.9.7 \
     crate://crates.io/libloading/0.9.0 \
     crate://crates.io/libnghttp2-sys/0.1.13+1.68.1 \
     crate://crates.io/libsqlite3-sys/0.38.2 \
-    crate://crates.io/libssh2-sys/0.3.2 \
+    crate://crates.io/libssh2-sys/0.3.3 \
     crate://crates.io/libz-sys/1.1.29 \
     crate://crates.io/linux-raw-sys/0.12.1 \
     crate://crates.io/litemap/0.8.3 \
@@ -240,16 +241,16 @@ SRC_URI += " \
     crate://crates.io/memmap2/0.9.11 \
     crate://crates.io/memoffset/0.9.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.8.9 \
     crate://crates.io/miow/0.6.1 \
+    crate://crates.io/multiversion_no_op/1.0.0 \
     crate://crates.io/nix/0.31.3 \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/nonempty/0.12.0 \
-    crate://crates.io/normpath/1.5.1 \
+    crate://crates.io/normpath/1.5.2 \
     crate://crates.io/nu-ansi-term/0.50.3 \
     crate://crates.io/num-conv/0.2.2 \
     crate://crates.io/num-traits/0.2.19 \
-    crate://crates.io/objc2/0.6.4 \
+    crate://crates.io/objc2/0.6.5 \
     crate://crates.io/objc2-cloud-kit/0.3.2 \
     crate://crates.io/objc2-core-data/0.3.2 \
     crate://crates.io/objc2-core-foundation/0.3.2 \
@@ -287,15 +288,15 @@ SRC_URI += " \
     crate://crates.io/pkcs8/0.10.2 \
     crate://crates.io/pkg-config/0.3.34 \
     crate://crates.io/portable-atomic/1.15.0 \
-    crate://crates.io/portable-atomic-util/0.2.7 \
+    crate://crates.io/portable-atomic-util/0.2.8 \
     crate://crates.io/potential_utf/0.1.6 \
-    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/powerfmt/0.2.1 \
     crate://crates.io/primeorder/0.13.6 \
     crate://crates.io/proc-macro2/1.0.107 \
-    crate://crates.io/prodash/31.0.0 \
+    crate://crates.io/prodash/31.0.1 \
     crate://crates.io/quote/1.0.47 \
     crate://crates.io/r-efi/6.0.0 \
-    crate://crates.io/rand/0.10.2 \
+    crate://crates.io/rand/0.10.3 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.10.1 \
     crate://crates.io/rand_xoshiro/0.6.0 \
@@ -308,8 +309,8 @@ SRC_URI += " \
     crate://crates.io/rusqlite/0.40.2 \
     crate://crates.io/rustc-hash/2.1.3 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
-    crate://crates.io/rustfix/0.9.7 \
-    crate://crates.io/rustix/1.1.4 \
+    crate://crates.io/rustfix/0.9.8 \
+    crate://crates.io/rustix/1.1.5 \
     crate://crates.io/rustversion/1.0.23 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/schannel/0.1.29 \
@@ -324,8 +325,8 @@ SRC_URI += " \
     crate://crates.io/serde_core/1.0.229 \
     crate://crates.io/serde_derive/1.0.229 \
     crate://crates.io/serde_ignored/0.1.14 \
-    crate://crates.io/serde_json/1.0.151 \
-    crate://crates.io/serde_spanned/1.1.1 \
+    crate://crates.io/serde_json/1.0.152 \
+    crate://crates.io/serde_spanned/1.1.2 \
     crate://crates.io/sha1/0.10.7 \
     crate://crates.io/sha1/0.11.0 \
     crate://crates.io/sha1-checked/0.10.0 \
@@ -336,10 +337,10 @@ SRC_URI += " \
     crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/2.0.1 \
     crate://crates.io/signature/2.2.0 \
-    crate://crates.io/simd-adler32/0.3.10 \
+    crate://crates.io/simdutf8/0.1.5 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/slab/0.4.12 \
-    crate://crates.io/smallvec/1.15.2 \
+    crate://crates.io/smallvec/1.16.3 \
     crate://crates.io/socket2/0.6.5 \
     crate://crates.io/spki/0.7.3 \
     crate://crates.io/sqlite-wasm-rs/0.5.5 \
@@ -350,27 +351,26 @@ SRC_URI += " \
     crate://crates.io/supports-hyperlinks/3.2.0 \
     crate://crates.io/supports-unicode/3.0.0 \
     crate://crates.io/syn/2.0.119 \
-    crate://crates.io/syn/3.0.3 \
-    crate://crates.io/synstructure/0.13.2 \
+    crate://crates.io/syn/3.0.7 \
+    crate://crates.io/synstructure/0.14.0 \
     crate://crates.io/tar/0.4.46 \
     crate://crates.io/tempfile/3.27.0 \
     crate://crates.io/terminal_size/0.4.4 \
-    crate://crates.io/thiserror/2.0.20 \
-    crate://crates.io/thiserror-impl/2.0.20 \
+    crate://crates.io/thiserror/2.0.21 \
+    crate://crates.io/thiserror-impl/2.0.21 \
     crate://crates.io/thread_local/1.1.10 \
     crate://crates.io/time/0.3.55 \
     crate://crates.io/time-core/0.1.9 \
     crate://crates.io/time-macros/0.2.32 \
     crate://crates.io/tinystr/0.8.4 \
-    crate://crates.io/tinyvec/1.12.0 \
-    crate://crates.io/tinyvec_macros/0.1.1 \
+    crate://crates.io/tinyvec/1.13.3 \
     crate://crates.io/toml/0.9.12+spec-1.1.0 \
-    crate://crates.io/toml/1.1.4+spec-1.1.0 \
+    crate://crates.io/toml/1.1.8+spec-1.1.0 \
     crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
-    crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
-    crate://crates.io/toml_edit/0.25.13+spec-1.1.0 \
-    crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
-    crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_datetime/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_edit/0.25.17+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.5+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.3+spec-1.1.0 \
     crate://crates.io/tracing/0.1.44 \
     crate://crates.io/tracing-attributes/0.1.31 \
     crate://crates.io/tracing-chrome/0.7.2 \
@@ -379,9 +379,9 @@ SRC_URI += " \
     crate://crates.io/tracing-subscriber/0.3.23 \
     crate://crates.io/typeid/1.0.3 \
     crate://crates.io/typenum/1.20.1 \
-    crate://crates.io/unicase/2.9.0 \
+    crate://crates.io/unicase/2.10.0 \
     crate://crates.io/unicode-bom/2.0.3 \
-    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-ident/1.0.26 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-width/0.2.2 \
     crate://crates.io/url/2.5.8 \
@@ -392,10 +392,10 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.127 \
-    crate://crates.io/wasm-bindgen-macro/0.2.127 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.127 \
-    crate://crates.io/wasm-bindgen-shared/0.2.127 \
+    crate://crates.io/wasm-bindgen/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.129 \
+    crate://crates.io/wasm-bindgen-shared/0.2.129 \
     crate://crates.io/winapi-util/0.1.11 \
     crate://crates.io/windows-link/0.2.1 \
     crate://crates.io/windows-sys/0.61.2 \
@@ -403,18 +403,17 @@ SRC_URI += " \
     crate://crates.io/winnow/1.0.4 \
     crate://crates.io/writeable/0.6.4 \
     crate://crates.io/yoke/0.8.3 \
-    crate://crates.io/yoke-derive/0.8.2 \
+    crate://crates.io/yoke-derive/0.8.4 \
     crate://crates.io/zerofrom/0.1.8 \
-    crate://crates.io/zerofrom-derive/0.1.7 \
-    crate://crates.io/zeroize/1.9.0 \
+    crate://crates.io/zerofrom-derive/0.1.8 \
+    crate://crates.io/zeroize/1.9.1 \
     crate://crates.io/zerotrie/0.2.5 \
     crate://crates.io/zerovec/0.11.8 \
     crate://crates.io/zerovec-derive/0.11.6 \
-    crate://crates.io/zlib-rs/0.6.7 \
+    crate://crates.io/zlib-rs/0.6.8 \
     crate://crates.io/zmij/1.0.23 \
 "
 
-SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
 SRC_URI[aho-corasick-1.1.5.sha256sum] = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
 SRC_URI[android_system_properties-0.1.6.sha256sum] = "ae221649c9976a6f6c56ae1facf410f3ddb33cc661c4b7b61020a912d4237fbc"
@@ -436,7 +435,7 @@ SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
 SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.13.1.sha256sum] = "b588b76d00fde79687d7646a9b5bdf3cc0f655e0bbd080335a95d7e96f3587da"
+SRC_URI[bitflags-2.13.2.sha256sum] = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
 SRC_URI[blake3-1.8.7.sha256sum] = "6d9e454fc11f76977dc803893aff6304ed33d6a26efae8696573bea74baa27ae"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
@@ -446,26 +445,26 @@ SRC_URI[bstr-1.13.1.sha256sum] = "6bb31b46c14244e20ee9984b11bf5c992b91fb6939fea6
 SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.12.1.sha256sum] = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
-SRC_URI[camino-1.2.5.sha256sum] = "bb1307f12aa967b5a58416e87b3653360e0fd614a016b6e970db08fecbb1b80d"
-SRC_URI[cargo-0.99.0.sha256sum] = "0c30a0d29369c04a80056b22089ad95f28c3df596821f1f8672d44ef64b7e26a"
-SRC_URI[cargo-credential-0.4.10.sha256sum] = "aa57675b822ecda7f0be12eedbfabd890066271eedc7f2c45ed41e86e0f327a8"
-SRC_URI[cargo-credential-libsecret-0.5.9.sha256sum] = "05e5f16a4f9f863e65e5c8b09a0b72d7ffe2b2c17eec4f7ea480360ddc4f61ca"
-SRC_URI[cargo-credential-macos-keychain-0.4.24.sha256sum] = "06f5b56bc59e9f3fe2a0450cd379057c8a327662c1d04ccecab61cd79818325e"
-SRC_URI[cargo-credential-wincred-0.4.24.sha256sum] = "25c2de3e8263008f298c44371abc403c08742df04c88230a66e781a11d2110fc"
+SRC_URI[camino-1.2.6.sha256sum] = "bbbad30e4b4c14a39e3cc8aed085a12a327257c316619c93581e017bc52be591"
+SRC_URI[cargo-0.100.0.sha256sum] = "f4d8037642eef9a2744e1bbc775522cb20867ecc7ea35373f1769609d7386e60"
+SRC_URI[cargo-credential-0.4.11.sha256sum] = "5de74202293b2bc090da20d0b475aa74821caf0e901f29ba97003353886a5b42"
+SRC_URI[cargo-credential-libsecret-0.5.10.sha256sum] = "7a84968127ab001ecc938ea245ad6d93be6039eb7732ead0f16f9b83fc8d5334"
+SRC_URI[cargo-credential-macos-keychain-0.4.25.sha256sum] = "cf917177a4bb7f238e1b8b3084cae37a688910e3b7bd95403f43f7c3d5a93b0e"
+SRC_URI[cargo-credential-wincred-0.4.25.sha256sum] = "9234ec1ab98e92524fbf7ceb5dd06e0fcf2a046d6f341670d32796e9c5a9a384"
 SRC_URI[cargo-platform-0.3.3.sha256sum] = "dd0061da739915fae12ea00e16397555ed4371a6bb285431aab930f61b0aa4ba"
-SRC_URI[cargo-util-0.2.31.sha256sum] = "218d28c233cdb23a98404ae6d6f8eea19db3c3ab28c34633c7d9facf72f2d2ff"
-SRC_URI[cargo-util-schemas-0.14.2.sha256sum] = "46262ca4393669799a8df4852e81672ddea46657e73294b1a846f0d5c71509ed"
-SRC_URI[cargo-util-terminal-0.1.1.sha256sum] = "db1548e157f51e667fdf147e5c55ee09a713cab10345293b1009f8de9af4974b"
+SRC_URI[cargo-util-0.2.32.sha256sum] = "dbe819082beae53247a2c440bece59bc2d1d90736cf5bed6b87f5e5bb53f0d30"
+SRC_URI[cargo-util-schemas-0.14.3.sha256sum] = "292e4a141b9c1ecfe5e6e960edc81a6ea3358a5440e030da848d0269376abeaf"
+SRC_URI[cargo-util-terminal-0.1.2.sha256sum] = "82be174c17e22a0366a1a0929e0306e0d53f120d159416b00f35e9708e7b2940"
 SRC_URI[cbindgen-0.29.4.sha256sum] = "2ecb53484c9c167ba674026b656d8a27d7657a58e6066aa902bfb1a4aa00ae20"
-SRC_URI[cc-1.4.4.sha256sum] = "0ad534f4357a5264cce5019c989cf66a4f0dc4e0d1b1d15f8aacec0ff7360273"
-SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+SRC_URI[cc-1.7.0.sha256sum] = "50a649af8a827553c29fb0cb4bd4a6f1a0dd695bd3232b9bc98bd9c8a3ffbb8b"
+SRC_URI[cfg-if-1.0.5.sha256sum] = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
 SRC_URI[cfg_aliases-0.2.2.sha256sum] = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
-SRC_URI[chacha20-0.10.1.sha256sum] = "d524456ba66e72eb8b115ff89e01e497f8e6d11d78b70b1aa13c0fbd97540a81"
-SRC_URI[clap-4.6.6.sha256sum] = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
-SRC_URI[clap_builder-4.6.6.sha256sum] = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
-SRC_URI[clap_complete-4.6.9.sha256sum] = "3be2ad0423bdbbb0e25bc89add796f3559706d4a95e1bc98e4d9662a957b6a19"
-SRC_URI[clap_derive-4.6.4.sha256sum] = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
-SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
+SRC_URI[chacha20-0.10.2.sha256sum] = "65c35e4b699c7e15ccbe7ee35c005e4fc0a278d22238a2857e6ce2dadeda1b06"
+SRC_URI[clap-4.6.7.sha256sum] = "aa8876b300ab35ba921adea3dfd70157a46249b33f95c9084ae5709785478946"
+SRC_URI[clap_builder-4.6.7.sha256sum] = "ec0797fb7aeb1406c84efac526901f7ec3ead2124f946b494e72879d4b54704d"
+SRC_URI[clap_complete-4.6.11.sha256sum] = "037e2a1a92236d0aff7e845093f64661d6df4c02c9fcc61a60e9e1d736fa392f"
+SRC_URI[clap_derive-4.6.7.sha256sum] = "f9c751b79415d4e559e3d1fcf128e09e720eb673a06d26cf6f392d37d75b66e0"
+SRC_URI[clap_lex-1.1.1.sha256sum] = "1c133bc6a41be0d194c306b5506d15e6feeea7b1d6604bd3f8310dfb2ca96486"
 SRC_URI[clru-0.6.3.sha256sum] = "197fd99cb113a8d5d9b6376f3aa817f32c1078f2343b714fff7d2ca44fdf67d5"
 SRC_URI[cmov-0.5.4.sha256sum] = "0c9ea0ac24bc397ab3c98583a3c9ba74fa56b09a4449bbe172b9b1ddb016027a"
 SRC_URI[color-print-0.3.7.sha256sum] = "3aa954171903797d5623e047d9ab69d91b493657917bdfb8c2c80ecaf9cdb6f4"
@@ -476,22 +475,24 @@ SRC_URI[const-oid-0.10.2.sha256sum] = "a6ef517f0926dd24a1582492c791b6a4818a4d94e
 SRC_URI[constant_time_eq-0.4.2.sha256sum] = "3d52eff69cd5e647efe296129160853a42795992097e8af39800e1060caeea9b"
 SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+SRC_URI[core_detect-1.0.0.sha256sum] = "7f8f80099a98041a3d1622845c271458a2d73e688351bf3cb999266764b81d48"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
-SRC_URI[crates-io-0.41.1.sha256sum] = "61eac17e797075f82dc4f2ca6c2b807abcb7f2b101f1fd1f627c5f1cde27b0d5"
-SRC_URI[crc32fast-1.5.1.sha256sum] = "8498c871161e1742aaa9d52551b2d6ebdd4c3d45a3be423e3728f33b955be550"
-SRC_URI[crossbeam-channel-0.5.16.sha256sum] = "d85363c37faeca707aef026efa9f3b34d077bce547e48f770770625c6013679e"
-SRC_URI[crossbeam-deque-0.8.7.sha256sum] = "5181e0de7b61eb03a81e347d6dd8797bae9da5146707b51077e2d71a54ec0ceb"
-SRC_URI[crossbeam-epoch-0.9.20.sha256sum] = "2d6914041f254d6e9176c01941b21115dcfb7089e55135a35411081bd106ef3f"
-SRC_URI[crossbeam-utils-0.8.22.sha256sum] = "61803da095bee82a81bb1a452ecc25d3b2f1416d1897eb86430c6159ef717c17"
+SRC_URI[cpufeatures-0.3.1.sha256sum] = "5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
+SRC_URI[crates-io-0.41.2.sha256sum] = "c047c636cac168acc89c2df97a9017f2751e96742faaa35941fabec8c9d057a9"
+SRC_URI[crc32fast-1.5.2.sha256sum] = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
+SRC_URI[crossbeam-channel-0.5.17.sha256sum] = "98b0cc327b5bc766e7fda9c9260cc0fa81b43a8e240440422dff70788e3f9ef1"
+SRC_URI[crossbeam-deque-0.8.8.sha256sum] = "622f3fc73690be383c7214310406f28a90e6edeadc3cea882f9d71e495b9711a"
+SRC_URI[crossbeam-epoch-0.9.21.sha256sum] = "dc74980687109a3b14c72fd458107bf0baa1da1a1a805e178d15501ba9b86d9d"
+SRC_URI[crossbeam-utils-0.8.23.sha256sum] = "a31eee39dddec8330830986fcd7625edb5a24ec90ea038215273bbc3adb08ac6"
 SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
 SRC_URI[crypto-common-0.2.2.sha256sum] = "ce6e4c961d6cd6c9a86db418387425e8bdeaf05b3c8bc1411e6dca4c252f1453"
-SRC_URI[ct-codecs-1.1.7.sha256sum] = "49fb0c6640b4507ebd99ff67677009e381ba5eee1d14df78de4a3d16eb123c39"
-SRC_URI[ctutils-0.4.2.sha256sum] = "7d5515a3834141de9eafb9717ad39eea8247b5674e6066c404e8c4b365d2a29e"
-SRC_URI[curl-0.4.50.sha256sum] = "3a45ee8994e5307cb4c60cfc1c20bf7263ffb771ddc135c9f768a14bcbc15b09"
-SRC_URI[curl-sys-0.4.90+curl-8.21.0.sha256sum] = "97799a0d220bfb3361e0fe4936966ff8c4b24d65c3f06dfc70d7b680b44e7897"
+SRC_URI[ct-codecs-1.1.8.sha256sum] = "8fd9f3db6f2cfef61c10613071955154ffdc9e515daebff26de4b54e35038fdd"
+SRC_URI[ctutils-0.4.3.sha256sum] = "03bb0e1cc970d482d121d9a1744999169b69a07470b3d644a7894e53fcaf4574"
+SRC_URI[curl-0.4.51.sha256sum] = "ef3ce06df3ac230a4f5c91bfd3e3961cd66f177bd9964c87deb3cce59a54fb7b"
+SRC_URI[curl-sys-0.4.91+curl-8.22.0.sha256sum] = "cd39579123e45bf762716bb893d43886ed1cabe6289455be29a4f1d4e37afb06"
 SRC_URI[dashmap-6.2.1.sha256sum] = "e6361d5c062261c78a176addb82d4c821ae42bed6089de0e12603cd25de2059c"
+SRC_URI[defmt-0.3.100.sha256sum] = "f0963443817029b2024136fc4dd07a5107eb8f977eaf18fcd1fdeb11306b64ad"
 SRC_URI[defmt-1.1.1.sha256sum] = "e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
 SRC_URI[defmt-macros-1.1.1.sha256sum] = "bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
 SRC_URI[defmt-parser-1.0.0.sha256sum] = "10d60334b3b2e7c9d91ef8150abfb6fa4c1c39ebbcf4a81c2e346aad939fee3e"
@@ -503,22 +504,22 @@ SRC_URI[dispatch2-0.3.1.sha256sum] = "1e0e367e4e7da84520dedcac1901e4da967309406d
 SRC_URI[displaydoc-0.2.7.sha256sum] = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308ccd87b1c098f1fb2eaf82a8"
 SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
 SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
-SRC_URI[ed25519-compact-2.4.2.sha256sum] = "f05391a505666bdf2b5d2626f41b7f0f49052b1e33cceac960eaa818008141da"
-SRC_URI[either-1.18.0.sha256sum] = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
+SRC_URI[ed25519-compact-2.6.0.sha256sum] = "1454db4f2edb7f0e8fe0c5b375b0c978fc63244cc9f010d160e417eb10139aa8"
+SRC_URI[either-1.19.0.sha256sum] = "0e9c71c2167ca323c882b99918929403426e2373ea17242ff5653e0d5e1058be"
 SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
-SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
+SRC_URI[encoding_rs-0.8.42.sha256sum] = "8e985e0451871ad22fb8d2b6b076e2028a502a0d3950998c2c5c0a4f9b5d9679"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 SRC_URI[erased-serde-0.4.10.sha256sum] = "d2add8a07dd6a8d93ff627029c51de145e12686fbc36ecb298ac22e74cf02dec"
 SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
-SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
+SRC_URI[faster-hex-0.10.1.sha256sum] = "04839bdf9d8c10f66806fad16b852fc72aab80873aebc3cb69d85b4fa41543ed"
 SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
 SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
 SRC_URI[filetime-0.2.29.sha256sum] = "5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
-SRC_URI[find-msvc-tools-0.1.11.sha256sum] = "d45db016d36b838f563236e9193d0ee6ce38f3f68b6c94e914b4929c96bbb890"
-SRC_URI[flate2-1.1.9.sha256sum] = "843fba2746e448b37e26a819579957415c8cef339bf08564fe8b7ddbd959573c"
+SRC_URI[find-msvc-tools-0.1.14.sha256sum] = "aedcfb3409746eddb02b9e19ebda1c3394f759a152e48ee875a0844d1b955484"
+SRC_URI[flate2-1.1.10.sha256sum] = "6e634e2e0ebac1ee034020da1ca582e17ffe4e0f5e985823721e168928136dcb"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[foldhash-0.2.0.sha256sum] = "77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
@@ -569,7 +570,7 @@ SRC_URI[gix-object-0.62.0.sha256sum] = "019b38afc3eac1e41f9fe09a327664b313ba4a12
 SRC_URI[gix-odb-0.82.0.sha256sum] = "7fadc59f6fa0f9dd445eceee61060a2b59ca557f48da9fc677f567db535b782a"
 SRC_URI[gix-pack-0.72.0.sha256sum] = "ca3e7f1726cd2c0cd1cf1fc20be8a8e623f0b163f1f8d6fc836cfb9bc8cd758b"
 SRC_URI[gix-packetline-0.21.5.sha256sum] = "b217dd0ee0c4021ecf169a4a519b1b4f80d15e3f3765f3dc466223dc0ac891d7"
-SRC_URI[gix-path-0.12.5.sha256sum] = "2b075e730586bba7341304d6fc1b4efc1d10cf64532622521c0e07f30e661046"
+SRC_URI[gix-path-0.12.6.sha256sum] = "38fc6f029ea67de83cbcbd33fd98c05a48360d2932b39d9fdacbc6eae802d475"
 SRC_URI[gix-pathspec-0.18.1.sha256sum] = "3050783b41ee11511e1e8fb35623df81806194f4030395f14f48ea37c2798c9f"
 SRC_URI[gix-prompt-0.15.1.sha256sum] = "3ee604d7746080ae7e1023bf47204bcc2c5f307bfbe2306a3c90b1bfd1a2c6d8"
 SRC_URI[gix-protocol-0.63.0.sha256sum] = "978468bae4ea2df20c72db3b20d0bdb548a0c1090b85a83643b553e6e0e041f2"
@@ -598,7 +599,7 @@ SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e9
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
 SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
 SRC_URI[hashbrown-0.17.1.sha256sum] = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
-SRC_URI[hashlink-0.12.1.sha256sum] = "32069d97bb81e38fa67eab65e3393bf804bb85969f2bc06bf13f64aef5aba248"
+SRC_URI[hashlink-0.12.2.sha256sum] = "a596f1b20ed2cc5ecac41a164aaebc7258057060f06c0cf7a2ba3991ee7990fb"
 SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
@@ -608,7 +609,7 @@ SRC_URI[hmac-0.13.0.sha256sum] = "6303bc9732ae41b04cb554b844a762b4115a61bfaa81e3
 SRC_URI[home-0.5.12.sha256sum] = "cc627f471c528ff0c4a49e1d5e60450c8f6461dd6d10ba9dcd3a61d3dff7728d"
 SRC_URI[http-1.5.0.sha256sum] = "918d3568bebf352712bc2ef3d46a8bcf1a75b373be6539de198e9105cbbf9ce0"
 SRC_URI[http-auth-0.1.10.sha256sum] = "150fa4a9462ef926824cf4519c84ed652ca8f4fbae34cb8af045b5cbcaf98822"
-SRC_URI[hybrid-array-0.4.14.sha256sum] = "707114b52a152fa7bdb290cd7cd5912d9467273b6d74e21b8d81aca1f8533f6b"
+SRC_URI[hybrid-array-0.4.15.sha256sum] = "27f864f10dfb56725ce5ce5472bc52252c8f93a4ab86327122cebf62c5f59a17"
 SRC_URI[icu_collections-2.3.0.sha256sum] = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
 SRC_URI[icu_locale_core-2.3.0.sha256sum] = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
 SRC_URI[icu_normalizer-2.3.0.sha256sum] = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
@@ -621,26 +622,26 @@ SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3
 SRC_URI[ignore-0.4.33.sha256sum] = "00b69833ed729dc5aa7d19541d96d6cf8e9137194207a04916d658e43168402f"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[implib-0.6.0.sha256sum] = "96e1090e37c7188a99a2353115083505ff6a489e86637dc41e1671457b1259d3"
-SRC_URI[indexmap-2.14.0.sha256sum] = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
+SRC_URI[indexmap-2.14.2.sha256sum] = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
 SRC_URI[is_executable-1.0.6.sha256sum] = "82cb6a9f675da968c63b6208c641b9dca58fc0133ae53375736b1767b0cab8bd"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
 SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
-SRC_URI[jiff-0.2.35.sha256sum] = "668b7183bd07af9a4885f5c35b0cc5c83c4607a913c16b7e17291832910d2dcc"
-SRC_URI[jiff-core-0.1.0.sha256sum] = "7feca88439efe53da3754500c1851dedf3cb36c524dd5cf8225cc0794de95d09"
-SRC_URI[jiff-static-0.2.35.sha256sum] = "3a69dcb3a21cfb32ce1cd056169337ca284af0766dd766e7878819b251a49204"
-SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
+SRC_URI[jiff-0.2.38.sha256sum] = "b2b005715dcbeb0089a3c0dab99f2ff1cc3b2525323552703d648585d342a383"
+SRC_URI[jiff-core-0.1.1.sha256sum] = "5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
+SRC_URI[jiff-static-0.2.38.sha256sum] = "2cc9817253cf7c7ee4684451bd327e88d6f3658014e54a29198625590650695c"
+SRC_URI[jiff-tzdb-0.1.9.sha256sum] = "fa8377070c6bae868759445e5a77f66d84f0b72f3a054bfb00e6d038b8282da7"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
-SRC_URI[js-sys-0.3.104.sha256sum] = "0e0c1080212aad755ea003d18543e8768dd432c48819efd73a7bf1e39b7a5a3a"
-SRC_URI[kstring-2.0.4.sha256sum] = "b609e7ca5ea38f093c20a4a102335b247221c9643b7a6bc3510f196f99499a9e"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+SRC_URI[js-sys-0.3.106.sha256sum] = "7883d941dae510fb2d978fc3fe018c71c9e2892fd38854de3e8b92c2e5ad9cc5"
+SRC_URI[kstring-2.0.5.sha256sum] = "7a09b82a7f771ed02dc0dd9b27130a0fa5499fa15ed3027116c1e5e4e591bd9e"
+SRC_URI[lazy_static-1.5.1.sha256sum] = "20870f649af7073d53e38067b2a84312175d56ea15217e1b15bc83506ec50afb"
+SRC_URI[libc-0.2.190.sha256sum] = "ce5d3ddc6d3fa000eb1536d85e147bfe31aacaba692ed6a876f95cb7c855be78"
 SRC_URI[libgit2-sys-0.18.8+1.9.7.sha256sum] = "7f7c568b25d7489bc3fb2988ed69ab111d2944d2f5fec3d5c987fe545ea97b50"
 SRC_URI[libloading-0.9.0.sha256sum] = "754ca22de805bb5744484a5b151a9e1a8e837d5dc232c2d7d8c2e3492edc8b60"
 SRC_URI[libnghttp2-sys-0.1.13+1.68.1.sha256sum] = "492e00167f1418c15648144f42bbfc63099806ecee9bf8d09a6353d6b4856b3c"
 SRC_URI[libsqlite3-sys-0.38.2.sha256sum] = "f1d20bef17f513b9b3004532233187769cd072d790971f4e4da0e346eb6401e8"
-SRC_URI[libssh2-sys-0.3.2.sha256sum] = "c04141a07bb0c0bc461cb657808764de571702a59bc5c726c400ac9a7625e3ab"
+SRC_URI[libssh2-sys-0.3.3.sha256sum] = "0f5eb74291e8691cab524a01274a1b1e7742b1a94f29d8b101d8aadc8372c1cd"
 SRC_URI[libz-sys-1.1.29.sha256sum] = "85bc9657773828b90eeb625adff10eeac83cc21bbfd8e23a03eaa8a33c9e28d9"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
 SRC_URI[litemap-0.8.3.sha256sum] = "47d9d19d1d6efa0109d2f65ff4c85cddd50bd572e5a00127ab10987290bcefae"
@@ -652,16 +653,16 @@ SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3
 SRC_URI[memmap2-0.9.11.sha256sum] = "d1219ed1b7f229ee7104d281dd01d6802fe28bb6e95d292942c4daacdeb798c0"
 SRC_URI[memoffset-0.9.1.sha256sum] = "488016bfae457b036d996092f6cb448677611ce4449e970ceaf42695203f218a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
 SRC_URI[miow-0.6.1.sha256sum] = "536bfad37a309d62069485248eeaba1e8d9853aaf951caaeaed0585a95346f08"
+SRC_URI[multiversion_no_op-1.0.0.sha256sum] = "743fb55ba31b18fb1ecef6bdc9aa2743314978ac084044301a7eee33fb99a20d"
 SRC_URI[nix-0.31.3.sha256sum] = "cf20d2fde8ff38632c426f1165ed7436270b44f199fc55284c38276f9db47c3d"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[nonempty-0.12.0.sha256sum] = "9737e026353e5cd0736f98eddae28665118eb6f6600902a7f50db585621fecb6"
-SRC_URI[normpath-1.5.1.sha256sum] = "b9985ef7269fa99f3b12437bb698381da2428743ab90f20393f399fa14cab21a"
+SRC_URI[normpath-1.5.2.sha256sum] = "b11ce00d2594068e8a27c9146fdc5cf9f3ac38eb42c7cd34d05fea618873ac9f"
 SRC_URI[nu-ansi-term-0.50.3.sha256sum] = "7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5"
 SRC_URI[num-conv-0.2.2.sha256sum] = "521739c6d2bac4aa25192232afe6841231376b2b26d4d9fae5ecf8ca5772e441"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
-SRC_URI[objc2-0.6.4.sha256sum] = "3a12a8ed07aefc768292f076dc3ac8c48f3781c8f2d5851dd3d98950e8c5a89f"
+SRC_URI[objc2-0.6.5.sha256sum] = "08849bbd4767dfae9457696856ae1c84fe4e0281bbe4a7abff2d0e06fb7981f8"
 SRC_URI[objc2-cloud-kit-0.3.2.sha256sum] = "73ad74d880bb43877038da939b7427bba67e9dd42004a18b809ba7d87cee241c"
 SRC_URI[objc2-core-data-0.3.2.sha256sum] = "0b402a653efbb5e82ce4df10683b6b28027616a2715e90009947d50b8dd298fa"
 SRC_URI[objc2-core-foundation-0.3.2.sha256sum] = "2a180dd8642fa45cdb7dd721cd4c11b1cadd4929ce112ebd8b9f5803cc79d536"
@@ -699,15 +700,15 @@ SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e07096
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
 SRC_URI[pkg-config-0.3.34.sha256sum] = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
 SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
-SRC_URI[portable-atomic-util-0.2.7.sha256sum] = "c2a106d1259c23fac8e543272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
+SRC_URI[portable-atomic-util-0.2.8.sha256sum] = "10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
 SRC_URI[potential_utf-0.1.6.sha256sum] = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
-SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[powerfmt-0.2.1.sha256sum] = "4a6394b9e965e73d0a289ee54f589087e2c676aedf60885baf52c76b771e4958"
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
 SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
-SRC_URI[prodash-31.0.0.sha256sum] = "962200e2d7d551451297d9fdce85138374019ada198e30ea9ede38034e27604c"
+SRC_URI[prodash-31.0.1.sha256sum] = "cf52d87428247c5aa3760ac8e7d8b13ec7b3579b955a8c3f311668b6860acba5"
 SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
-SRC_URI[rand-0.10.2.sha256sum] = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
+SRC_URI[rand-0.10.3.sha256sum] = "65c9fb96cbc91e3478eaae79a69fcd3f1ae4ad052e471fe6732fff548984b4af"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
@@ -720,8 +721,8 @@ SRC_URI[rsqlite-vfs-0.1.1.sha256sum] = "c51c9ae4df8a7fba42103df5c621fa3c37eccf3a
 SRC_URI[rusqlite-0.40.2.sha256sum] = "23f2a97da3e3873c73cb2a2e71b35c40ff95e0b1eefa8d72d8499a6928c3b5b3"
 SRC_URI[rustc-hash-2.1.3.sha256sum] = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
-SRC_URI[rustfix-0.9.7.sha256sum] = "4ab550bf03e3428c98b8e0354800a18f366f1f5f25544b908463b4634374f34f"
-SRC_URI[rustix-1.1.4.sha256sum] = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+SRC_URI[rustfix-0.9.8.sha256sum] = "c614151d9f1b1e1f23041dacbf5f8dfab85687455b9e553f19f3d70275d1fe1c"
+SRC_URI[rustix-1.1.5.sha256sum] = "891efababe418670775f199f0d233d84843c227a0949a883ce15b37c78d6629d"
 SRC_URI[rustversion-1.0.23.sha256sum] = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[schannel-0.1.29.sha256sum] = "91c1b7e4904c873ef0710c1f407dde2e6287de2bebc1bbbf7d430bb7cbffd939"
@@ -736,8 +737,8 @@ SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e
 SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
 SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
 SRC_URI[serde_ignored-0.1.14.sha256sum] = "115dffd5f3853e06e746965a20dcbae6ee747ae30b543d91b0e089668bb07798"
-SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
-SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
+SRC_URI[serde_json-1.0.152.sha256sum] = "1741ab7a6cc54a03a89b5d563ed60075c277d9e3cfa73ad0c1f23f23974703c6"
+SRC_URI[serde_spanned-1.1.2.sha256sum] = "4e7523beb55eece201a2356bee0bbca0d1ab466c14c07703b2e0ee6d42cb0c2c"
 SRC_URI[sha1-0.10.7.sha256sum] = "a978451301f4db1d02937a4ab3ccce137717b81826e79b7d49ffe3244a13c3b8"
 SRC_URI[sha1-0.11.0.sha256sum] = "aacc4cc499359472b4abe1bf11d0b12e688af9a805fa5e3016f9a386dc2d0214"
 SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832b03984598375bff3975b804423"
@@ -748,10 +749,10 @@ SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873b
 SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
-SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
+SRC_URI[simdutf8-0.1.5.sha256sum] = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
-SRC_URI[smallvec-1.15.2.sha256sum] = "8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
+SRC_URI[smallvec-1.16.3.sha256sum] = "5b3dc8af474f516a851ff4bd12db780f948b9250ad37211e4eec0bccea54e01b"
 SRC_URI[socket2-0.6.5.sha256sum] = "c3d1e2c7f27f8d4cb10542a02c49005dbd6e93095799d6f3be745fae9f8fedd4"
 SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
 SRC_URI[sqlite-wasm-rs-0.5.5.sha256sum] = "dc3efc0da82635d7e1ced0053bbbfa8c7ab9645d0bf36ceb4f7127bb85315d75"
@@ -762,27 +763,26 @@ SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51c
 SRC_URI[supports-hyperlinks-3.2.0.sha256sum] = "e396b6523b11ccb83120b115a0b7366de372751aa6edf19844dfb13a6af97e91"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
 SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
-SRC_URI[syn-3.0.3.sha256sum] = "53e9bae58849f64dfa4f5d5ae372c8341f7305f82a3868709269343628b659a3"
-SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
+SRC_URI[syn-3.0.7.sha256sum] = "d62a2e0561533f2ca2561d0cf27fd9fedb640a1bf2616ff5d5c80d99017faadc"
+SRC_URI[synstructure-0.14.0.sha256sum] = "901704edd0dfe137f1987838ee4f259e4e063c31371bdb423f7ae38ec6f77f02"
 SRC_URI[tar-0.4.46.sha256sum] = "3f6221d9a6003c78398e3b239969f352578258df48c8eb051caadae0015bc840"
 SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[terminal_size-0.4.4.sha256sum] = "230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
-SRC_URI[thiserror-2.0.20.sha256sum] = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
-SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
+SRC_URI[thiserror-2.0.21.sha256sum] = "09e52cb86a36cede5cb101bf8908837b3e4c6e5e59fe7fd85c23fb56200d189e"
+SRC_URI[thiserror-impl-2.0.21.sha256sum] = "fe5197923287db20a58125f0bc85c062f7f2c892de97b18c356f9efb14b28524"
 SRC_URI[thread_local-1.1.10.sha256sum] = "1ad99c4c6d32803332c548b1af0540b357b3f5fc0be8f6c6bfe8b2e6ae784070"
 SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
 SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
 SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
 SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
-SRC_URI[tinyvec-1.12.0.sha256sum] = "bb4ebadaa0af04fab11ae01eb5f9fdb5f9c5b875506e210e71c07873528baa7f"
-SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
+SRC_URI[tinyvec-1.13.3.sha256sum] = "fd3ca314f692efd6c868f8408f53fe444634a845f96c028b97d35f6a1f79f0ee"
 SRC_URI[toml-0.9.12+spec-1.1.0.sha256sum] = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
-SRC_URI[toml-1.1.4+spec-1.1.0.sha256sum] = "3aace63f4bbcdfc2c965b059de67119c89c4017a70d633be6c104910f67056f5"
+SRC_URI[toml-1.1.8+spec-1.1.0.sha256sum] = "20489e00e4d8741d6be680764cc12e270655e375a20d1011e844a9c3379e678d"
 SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
-SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
-SRC_URI[toml_edit-0.25.13+spec-1.1.0.sha256sum] = "6975367e4d2ef766d86af01ffad14b622fecc8d4357a998fbc4deb6e9bacaf9b"
-SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
-SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+SRC_URI[toml_datetime-1.1.2+spec-1.1.0.sha256sum] = "2b86d767906c6c42421dcba507eb9d203e779497710a47782a224bb871653053"
+SRC_URI[toml_edit-0.25.17+spec-1.1.0.sha256sum] = "e3641d5bbb5349a79e1020a242d251efbc546ad8048d133958323ce9c40a9c9c"
+SRC_URI[toml_parser-1.1.5+spec-1.1.0.sha256sum] = "baa693a8032d7e1cada7d0041e96126df243179ff061456783ac7f12bda4744c"
+SRC_URI[toml_writer-1.1.3+spec-1.1.0.sha256sum] = "06bdbd8cfc056b8d2e2e85f29b56a3bdbecb527cef81eb39e3e7b98af4652770"
 SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
 SRC_URI[tracing-attributes-0.1.31.sha256sum] = "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
@@ -791,9 +791,9 @@ SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54
 SRC_URI[tracing-subscriber-0.3.23.sha256sum] = "cb7f578e5945fb242538965c2d0b04418d38ec25c79d160cd279bf0731c8d319"
 SRC_URI[typeid-1.0.3.sha256sum] = "bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
 SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
-SRC_URI[unicase-2.9.0.sha256sum] = "dbc4bc3a9f746d862c45cb89d705aa10f187bb96c76001afab07a0d35ce60142"
+SRC_URI[unicase-2.10.0.sha256sum] = "357cc3acc6a036009fd6c973ed009037c732d60d0b4f6c673e9041497482a28f"
 SRC_URI[unicode-bom-2.0.3.sha256sum] = "7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
-SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-ident-1.0.26.sha256sum] = "d245f478577f809a851594d02313b640fb437e0bb33866753cff937863096954"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-width-0.2.2.sha256sum] = "b4ac048d71ede7ee76d585517add45da530660ef4390e49b098733c6e897f254"
 SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
@@ -804,10 +804,10 @@ SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb82
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
-SRC_URI[wasm-bindgen-0.2.127.sha256sum] = "1b70935747edd64d89de3efa29d73789b806c15798f8e7dca4d8ac356b50ce70"
-SRC_URI[wasm-bindgen-macro-0.2.127.sha256sum] = "77775f8f3f7217702089053b94958f8f54061a3f663417df76e19cbdcca29bc1"
-SRC_URI[wasm-bindgen-macro-support-0.2.127.sha256sum] = "e11d33f857dc2fb11b8bc75aee111aa9cbeb12cd9f25efd3d4c2a3dd4e235284"
-SRC_URI[wasm-bindgen-shared-0.2.127.sha256sum] = "7ef64dbcc55df09c7e5a46182d181c2cfa3e925f3da937ea764728b4bbb9dcbf"
+SRC_URI[wasm-bindgen-0.2.129.sha256sum] = "9bb54f33acc68fd454578d9820b0bde1a1a3d17aa17bb7b6595806d02886d409"
+SRC_URI[wasm-bindgen-macro-0.2.129.sha256sum] = "2e29d0c35b16e224a7eeb5cd2d25e3e1968fbd65604117b44d3b789d00ee8535"
+SRC_URI[wasm-bindgen-macro-support-0.2.129.sha256sum] = "6f501a8bc3719dba86ef8ae4728879c08001bea749eb1333ac5b91e040e2a6b7"
+SRC_URI[wasm-bindgen-shared-0.2.129.sha256sum] = "23f0c9c52aa7cd7d77769a4cfe2a9adb1b331f489a41d912ce14513d5ab995c6"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
@@ -815,12 +815,12 @@ SRC_URI[winnow-0.7.15.sha256sum] = "df79d97927682d2fd8adb29682d1140b343be4ac0f08
 SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
 SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
 SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
-SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
+SRC_URI[yoke-derive-0.8.4.sha256sum] = "ec8ebde2db3681e8c9980cc27822030e68752690ddfa9473e739aeb4dbde6d71"
 SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
-SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
-SRC_URI[zeroize-1.9.0.sha256sum] = "e13c156562582aa81c60cb29407084cdb54c4164760106ab78e6c5b0858cf64e"
+SRC_URI[zerofrom-derive-0.1.8.sha256sum] = "f75b4683f6c7f45248d4d64056a24298c6281e0993356d7d1b4a1a962ef10d4a"
+SRC_URI[zeroize-1.9.1.sha256sum] = "e13084392c5e4bc371903e2935a5eaeed24905a7511356b883835e18a78f6879"
 SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
 SRC_URI[zerovec-0.11.8.sha256sum] = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
 SRC_URI[zerovec-derive-0.11.6.sha256sum] = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
-SRC_URI[zlib-rs-0.6.7.sha256sum] = "34b31d188d9d685a4f9c7b46d6e36631b07058d2cfe190267adce54dc230bf12"
+SRC_URI[zlib-rs-0.6.8.sha256sum] = "b268e58e7c693d7c271f93ffc4ba3b380412554231c85bf61ca7af91042a4112"
 SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
diff --git a/recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb b/recipes-devtools/cargo-c/cargo-c_0.10.26+cargo-0.100.0.bb
similarity index 87%
rename from recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb
rename to recipes-devtools/cargo-c/cargo-c_0.10.26+cargo-0.100.0.bb
index b6e459c..722a128 100644
--- a/recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb
+++ b/recipes-devtools/cargo-c/cargo-c_0.10.26+cargo-0.100.0.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.12/ \
 "
-SRC_URI[cargo-c.sha256sum] = "6b2ddde58a8a773ccce4b6384acacd3ce01373f52717dd2424633ed46755c627"
+SRC_URI[cargo-c.sha256sum] = "5ff6e05531e58286d3c02ec0adb7f254e5d532a8d4b667f30b9942d802e1db25"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
-- 
2.56.0

