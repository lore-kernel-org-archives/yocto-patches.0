Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C2C55178
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4599.1785497619158015574
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WDcNtW03;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5c92c389so42179785a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497618; x=1786102418; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=79TFoFfhPrHpPPF6HPYNyz9uKOG0JCTxtBgTDqgUqe4=;
        b=WDcNtW037Ee5gelaUOCnOhm3nkraCov1Z5RXb49e15XPw8JVsz3UwAC7AuYDsfUxJZ
         +lBTgYoSuhbG7mR5xFqFqVJrVfqXGDcl8rhUDIFYYLWUvnSdfF4wh7WZLBgpQ5O0/nkS
         0Eacsm2SC5fzAAnm4mvFW45b+Xgn9l4rKd7lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497618; x=1786102418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=79TFoFfhPrHpPPF6HPYNyz9uKOG0JCTxtBgTDqgUqe4=;
        b=JvbDbnraI8W1sK3eDd9iInCiQBTY0BXQ3/I6swMZFcDB/fwv1YqmuXgXqsY7559Y6Z
         vMYIqJesYc0/TfVfyGdL719844ZQa1oPd/0/4Lk/6dHs8Q7JjKX2VwR4PE26Zwo0baOk
         mzmgy+t6JsrfM/kZJrGgOz7d1UkGx8G7oeg21uBOi8C0dcJc5edhe+gRE6t/7vDXp4qg
         7GQtN/mfEI5TwpXiAQdDH1PgIkjo/WnL64oclnpEI5lBgDP88z1krPo7Gh7nsxm1iIy8
         uepeVMi3zv3aEQ1VxO9F4D1feeIWueJz6q9Qr7XgWd7PLmdLa9AknSxCZtC2Y1OpOFX4
         riXA==
X-Gm-Message-State: AOJu0Yy4UEFT1nymMv9D1qdmAT4VzTvLa1D9BDcAC60i5xy8fru2l5s8
	x19yUHSZ1qMZQZHtBXrVTnTiwFmP/IzBbQN6/uMTTfEKLTkEiPYjqwn10fU/HwyCbq1PBixRkcM
	bvHHw
X-Gm-Gg: AR+sD12Y6KRqiPY0qWj/xCy4gWawiaDbCm5nea3e9b2ehd7wtyb0quYGotqBqM7SUUL
	EdmJOiBcu6/WLbU11iKJRi+oyelI0Uh32vXoRhr/b8YKqa4C+XiHMdNP/sWR9avsbhmBN7JGl+r
	8khwN5iMx+1tOgUFFmfk9q3DKTv6QGeXSR8ls80QNht/5KObNFyrJpSm53DfAOf9EhGOjjLt/mb
	tbM6tQWmANDNBhtQABnITNtP5AMJVFUxXzgTLYfR0yZKw1tHEQE7P1QDa0aaTGFUTz2cyRawiOt
	WFb7U68CxJJ7aWwc+d+x5QuND26IYh93xpyLl8TNXg6Wb7b0b39iUFcunpEbbRPFZSe16BJ1orN
	C/pB6dB8zyJ+KaIikYTSlTO03aPS6vg6AS9hR5UUNnPAbFwKG3zKHQXaLtU8ZEhfPaR0hWSWvEN
	HCeAH+jvGPl6e2a+XmqCFGzub4mpytW99krpoFhCVd/wilRliI8i/oBQwCO+1VJ9sRveesxx/Th
	CRDIhVRqBJf0lkp4v+z5AtsRH1L+3YtwpPXQiBWMRQu21MnntIQLE48Nm+Bz6WxFR3enA0nyR1U
	610tbHkpoWjZsWB3vUxIFroIyg==
X-Received: by 2002:a05:620a:ab08:b0:930:987d:9cd7 with SMTP id af79cd13be357-9349659219bmr195521685a.11.1785497617355;
        Fri, 31 Jul 2026 04:33:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 25/35] librsvg: upgrade 2.61.3 -> 2.62.2
Date: Fri, 31 Jul 2026 07:32:55 -0400
Message-ID: <355a1a706c5afab4296a9d6a2afc6f3f7df09fdd.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4601

From: Ross Burton <ross.burton@arm.com>

Selected highlights from the release notes:

Version 2.62.2
==============

- #1142: Fix blurry embeded SVG images by rasterizing them at
  device resolution (Dylan Sechet).

- #1229: Fix build when gobject-introspection is enabled but
  gdk-pixbuf is disabled.

Version 2.62.0
==============

- The minimum supported Rust version (MSRV) is 1.92.0.

- #1218: Fix rendering of markers at the end of open subpaths.

- #1216: Small optimization for userLanguage so regexes only get
  compiled if needed (Adetoye Anointing).

Update cross-query-loaders.patch to the final version that was submitted
upstream.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b3aa1a6419bef653cff710fc3359211daf9f7902)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 490 +++++++++---------
 ...e-care-of-deprecated-assert_cmd-Comm.patch |   8 +-
 .../librsvg/librsvg/cross-query-loaders.patch | 157 +++---
 .../{librsvg_2.61.3.bb => librsvg_2.62.2.bb}  |   2 +-
 4 files changed, 352 insertions(+), 305 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.61.3.bb => librsvg_2.62.2.bb} (98%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 2260a6f..dfa96e2 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -11,10 +11,10 @@ SRC_URI += " \
     crate://crates.io/anstream/0.6.21 \
     crate://crates.io/anstyle/1.0.13 \
     crate://crates.io/anstyle-parse/0.2.7 \
-    crate://crates.io/anstyle-query/1.1.4 \
-    crate://crates.io/anstyle-wincon/3.0.10 \
+    crate://crates.io/anstyle-query/1.1.5 \
+    crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.1.1 \
+    crate://crates.io/assert_cmd/2.1.2 \
     crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/av-data/0.4.4 \
     crate://crates.io/bit-set/0.8.0 \
@@ -25,30 +25,30 @@ SRC_URI += " \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/block-padding/0.3.3 \
     crate://crates.io/bstr/1.12.1 \
-    crate://crates.io/bumpalo/3.19.0 \
+    crate://crates.io/bumpalo/3.19.1 \
     crate://crates.io/byte-slice-cast/1.2.3 \
     crate://crates.io/bytecount/0.6.9 \
     crate://crates.io/bytemuck/1.24.0 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/byteorder-lite/0.1.0 \
-    crate://crates.io/bytes/1.10.1 \
-    crate://crates.io/cairo-rs/0.21.2 \
-    crate://crates.io/cairo-sys-rs/0.21.2 \
+    crate://crates.io/bytes/1.11.1 \
+    crate://crates.io/cairo-rs/0.22.0 \
+    crate://crates.io/cairo-sys-rs/0.22.0 \
     crate://crates.io/cast/0.3.0 \
     crate://crates.io/cbc/0.1.2 \
-    crate://crates.io/cc/1.2.44 \
-    crate://crates.io/cfg-expr/0.20.4 \
+    crate://crates.io/cc/1.2.54 \
+    crate://crates.io/cfg-expr/0.20.6 \
     crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/chrono/0.4.42 \
+    crate://crates.io/chrono/0.4.43 \
     crate://crates.io/ciborium/0.2.2 \
     crate://crates.io/ciborium-io/0.2.2 \
     crate://crates.io/ciborium-ll/0.2.2 \
     crate://crates.io/cipher/0.4.4 \
-    crate://crates.io/clap/4.5.51 \
-    crate://crates.io/clap_builder/4.5.51 \
-    crate://crates.io/clap_complete/4.5.60 \
-    crate://crates.io/clap_derive/4.5.49 \
-    crate://crates.io/clap_lex/0.7.6 \
+    crate://crates.io/clap/4.5.56 \
+    crate://crates.io/clap_builder/4.5.56 \
+    crate://crates.io/clap_complete/4.5.65 \
+    crate://crates.io/clap_derive/4.5.55 \
+    crate://crates.io/clap_lex/0.7.7 \
     crate://crates.io/color_quant/1.1.0 \
     crate://crates.io/colorchoice/1.0.4 \
     crate://crates.io/core-foundation-sys/0.8.7 \
@@ -60,21 +60,22 @@ SRC_URI += " \
     crate://crates.io/crossbeam-epoch/0.9.18 \
     crate://crates.io/crossbeam-utils/0.8.21 \
     crate://crates.io/crunchy/0.2.4 \
-    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/crypto-common/0.1.7 \
     crate://crates.io/cssparser/0.35.0 \
     crate://crates.io/cssparser-color/0.3.0 \
     crate://crates.io/cssparser-macros/0.6.1 \
     crate://crates.io/data-url/0.3.2 \
-    crate://crates.io/dav1d/0.10.4 \
+    crate://crates.io/dav1d/0.11.1 \
     crate://crates.io/dav1d-sys/0.8.3 \
     crate://crates.io/deranged/0.5.5 \
-    crate://crates.io/derive_more/2.0.1 \
-    crate://crates.io/derive_more-impl/2.0.1 \
+    crate://crates.io/derive_more/2.1.1 \
+    crate://crates.io/derive_more-impl/2.1.1 \
+    crate://crates.io/diff/0.1.13 \
     crate://crates.io/difflib/0.4.0 \
     crate://crates.io/digest/0.10.7 \
     crate://crates.io/displaydoc/0.2.5 \
     crate://crates.io/dlib/0.5.2 \
-    crate://crates.io/dtoa/1.0.10 \
+    crate://crates.io/dtoa/1.0.11 \
     crate://crates.io/dtoa-short/0.3.5 \
     crate://crates.io/ecb/0.1.2 \
     crate://crates.io/either/1.15.0 \
@@ -84,68 +85,88 @@ SRC_URI += " \
     crate://crates.io/fallible_collections/0.4.9 \
     crate://crates.io/fastrand/2.3.0 \
     crate://crates.io/fdeflate/0.3.7 \
-    crate://crates.io/find-msvc-tools/0.1.4 \
-    crate://crates.io/flate2/1.1.5 \
+    crate://crates.io/find-msvc-tools/0.1.8 \
+    crate://crates.io/flate2/1.1.8 \
     crate://crates.io/float-cmp/0.10.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.2 \
     crate://crates.io/futf/0.1.5 \
     crate://crates.io/futures-channel/0.3.31 \
-    crate://crates.io/futures-core/0.3.31 \
+    crate://crates.io/futures-core/0.3.32 \
     crate://crates.io/futures-executor/0.3.31 \
     crate://crates.io/futures-io/0.3.31 \
-    crate://crates.io/futures-macro/0.3.31 \
-    crate://crates.io/futures-task/0.3.31 \
-    crate://crates.io/futures-util/0.3.31 \
+    crate://crates.io/futures-macro/0.3.32 \
+    crate://crates.io/futures-task/0.3.32 \
+    crate://crates.io/futures-util/0.3.32 \
     crate://crates.io/fxhash/0.2.1 \
-    crate://crates.io/gdk-pixbuf/0.21.2 \
-    crate://crates.io/gdk-pixbuf-sys/0.21.2 \
-    crate://crates.io/generic-array/0.14.9 \
+    crate://crates.io/gdk-pixbuf/0.22.0 \
+    crate://crates.io/gdk-pixbuf-sys/0.22.0 \
+    crate://crates.io/generic-array/0.14.7 \
     crate://crates.io/getrandom/0.3.4 \
-    crate://crates.io/gif/0.13.3 \
-    crate://crates.io/gio/0.21.4 \
-    crate://crates.io/gio-sys/0.21.2 \
-    crate://crates.io/glib/0.21.4 \
-    crate://crates.io/glib-macros/0.21.4 \
-    crate://crates.io/glib-sys/0.21.2 \
-    crate://crates.io/gobject-sys/0.21.2 \
+    crate://crates.io/gif/0.14.1 \
+    crate://crates.io/gio/0.22.1 \
+    crate://crates.io/gio-sys/0.22.0 \
+    crate://crates.io/gio-unix/0.22.0 \
+    crate://crates.io/gio-unix-sys/0.22.0 \
+    crate://crates.io/gio-win32/0.22.0 \
+    crate://crates.io/gio-win32-sys/0.22.0 \
+    crate://crates.io/glam/0.14.0 \
+    crate://crates.io/glam/0.15.2 \
+    crate://crates.io/glam/0.16.0 \
+    crate://crates.io/glam/0.17.3 \
+    crate://crates.io/glam/0.18.0 \
+    crate://crates.io/glam/0.19.0 \
+    crate://crates.io/glam/0.20.5 \
+    crate://crates.io/glam/0.21.3 \
+    crate://crates.io/glam/0.22.0 \
+    crate://crates.io/glam/0.23.0 \
+    crate://crates.io/glam/0.24.2 \
+    crate://crates.io/glam/0.25.0 \
+    crate://crates.io/glam/0.27.0 \
+    crate://crates.io/glam/0.28.0 \
+    crate://crates.io/glam/0.29.3 \
+    crate://crates.io/glam/0.30.10 \
+    crate://crates.io/glib/0.22.0 \
+    crate://crates.io/glib-macros/0.22.0 \
+    crate://crates.io/glib-sys/0.22.0 \
+    crate://crates.io/gobject-sys/0.22.0 \
     crate://crates.io/half/2.7.1 \
     crate://crates.io/hashbrown/0.13.2 \
-    crate://crates.io/hashbrown/0.16.0 \
+    crate://crates.io/hashbrown/0.16.1 \
     crate://crates.io/heck/0.5.0 \
-    crate://crates.io/iana-time-zone/0.1.64 \
+    crate://crates.io/iana-time-zone/0.1.65 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
     crate://crates.io/icu_collections/2.1.1 \
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
-    crate://crates.io/image/0.25.8 \
+    crate://crates.io/image/0.25.10 \
     crate://crates.io/image-webp/0.2.4 \
-    crate://crates.io/indexmap/2.12.0 \
+    crate://crates.io/indexmap/2.13.0 \
     crate://crates.io/inout/0.1.4 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.13.0 \
     crate://crates.io/itertools/0.14.0 \
-    crate://crates.io/itoa/1.0.15 \
-    crate://crates.io/jiff/0.2.15 \
-    crate://crates.io/jiff-static/0.2.15 \
-    crate://crates.io/jiff-tzdb/0.1.4 \
+    crate://crates.io/itoa/1.0.17 \
+    crate://crates.io/jiff/0.2.18 \
+    crate://crates.io/jiff-static/0.2.18 \
+    crate://crates.io/jiff-tzdb/0.1.5 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
-    crate://crates.io/js-sys/0.3.82 \
+    crate://crates.io/js-sys/0.3.85 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.177 \
+    crate://crates.io/libc/0.2.180 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/linux-raw-sys/0.11.0 \
     crate://crates.io/litemap/0.8.1 \
     crate://crates.io/locale_config/0.3.0 \
     crate://crates.io/lock_api/0.4.14 \
-    crate://crates.io/log/0.4.28 \
+    crate://crates.io/log/0.4.29 \
     crate://crates.io/lopdf/0.38.0 \
     crate://crates.io/mac/0.1.1 \
     crate://crates.io/malloc_buf/0.0.6 \
@@ -153,19 +174,20 @@ SRC_URI += " \
     crate://crates.io/matches/0.1.10 \
     crate://crates.io/matrixmultiply/0.3.10 \
     crate://crates.io/md-5/0.10.6 \
-    crate://crates.io/memchr/2.7.6 \
+    crate://crates.io/memchr/2.8.0 \
     crate://crates.io/miniz_oxide/0.8.9 \
-    crate://crates.io/moxcms/0.7.9 \
+    crate://crates.io/moxcms/0.8.1 \
     crate://crates.io/mp4parse/0.17.0 \
-    crate://crates.io/nalgebra/0.33.2 \
-    crate://crates.io/nalgebra-macros/0.2.2 \
+    crate://crates.io/mutants/0.0.3 \
+    crate://crates.io/nalgebra/0.34.1 \
+    crate://crates.io/nalgebra-macros/0.3.0 \
     crate://crates.io/new_debug_unreachable/1.0.6 \
     crate://crates.io/nom/8.0.0 \
     crate://crates.io/nom_locate/5.0.0 \
     crate://crates.io/normalize-line-endings/0.3.0 \
     crate://crates.io/num-bigint/0.4.6 \
     crate://crates.io/num-complex/0.4.6 \
-    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-conv/0.2.0 \
     crate://crates.io/num-derive/0.4.2 \
     crate://crates.io/num-integer/0.1.46 \
     crate://crates.io/num-rational/0.4.2 \
@@ -176,10 +198,10 @@ SRC_URI += " \
     crate://crates.io/once_cell/1.21.3 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/oorandom/11.1.5 \
-    crate://crates.io/pango/0.21.3 \
-    crate://crates.io/pango-sys/0.21.2 \
-    crate://crates.io/pangocairo/0.21.2 \
-    crate://crates.io/pangocairo-sys/0.21.2 \
+    crate://crates.io/pango/0.22.0 \
+    crate://crates.io/pango-sys/0.22.0 \
+    crate://crates.io/pangocairo/0.22.0 \
+    crate://crates.io/pangocairo-sys/0.22.0 \
     crate://crates.io/parking_lot/0.12.5 \
     crate://crates.io/parking_lot_core/0.9.12 \
     crate://crates.io/paste/1.0.15 \
@@ -191,13 +213,12 @@ SRC_URI += " \
     crate://crates.io/phf_shared/0.11.3 \
     crate://crates.io/phf_shared/0.13.1 \
     crate://crates.io/pin-project-lite/0.2.16 \
-    crate://crates.io/pin-utils/0.1.0 \
     crate://crates.io/pkg-config/0.3.32 \
     crate://crates.io/plotters/0.3.7 \
     crate://crates.io/plotters-backend/0.3.7 \
     crate://crates.io/plotters-svg/0.3.7 \
-    crate://crates.io/png/0.18.0 \
-    crate://crates.io/portable-atomic/1.11.1 \
+    crate://crates.io/png/0.18.1 \
+    crate://crates.io/portable-atomic/1.13.0 \
     crate://crates.io/portable-atomic-util/0.2.4 \
     crate://crates.io/potential_utf/0.1.4 \
     crate://crates.io/powerfmt/0.2.0 \
@@ -206,21 +227,21 @@ SRC_URI += " \
     crate://crates.io/predicates/3.1.3 \
     crate://crates.io/predicates-core/1.0.9 \
     crate://crates.io/predicates-tree/1.0.12 \
-    crate://crates.io/proc-macro-crate/3.4.0 \
-    crate://crates.io/proc-macro2/1.0.103 \
+    crate://crates.io/pretty_assertions/1.4.1 \
+    crate://crates.io/proc-macro2/1.0.106 \
     crate://crates.io/proptest/1.9.0 \
-    crate://crates.io/pxfm/0.1.25 \
+    crate://crates.io/pxfm/0.1.27 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/quote/1.0.41 \
+    crate://crates.io/quote/1.0.44 \
     crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand/0.9.2 \
     crate://crates.io/rand_chacha/0.9.0 \
     crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/rand_core/0.9.3 \
+    crate://crates.io/rand_core/0.9.5 \
     crate://crates.io/rand_xorshift/0.4.0 \
-    crate://crates.io/rangemap/1.6.0 \
+    crate://crates.io/rangemap/1.7.1 \
     crate://crates.io/rawpointer/0.2.1 \
     crate://crates.io/rayon/1.11.0 \
     crate://crates.io/rayon-core/1.13.0 \
@@ -230,26 +251,27 @@ SRC_URI += " \
     crate://crates.io/regex-automata/0.4.13 \
     crate://crates.io/regex-syntax/0.8.8 \
     crate://crates.io/rgb/0.8.52 \
-    crate://crates.io/rustix/1.1.2 \
+    crate://crates.io/rustc_version/0.4.1 \
+    crate://crates.io/rustix/1.1.3 \
     crate://crates.io/rustversion/1.0.22 \
     crate://crates.io/rusty-fork/0.3.1 \
-    crate://crates.io/ryu/1.0.20 \
     crate://crates.io/safe_arch/0.7.4 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/selectors/0.31.0 \
+    crate://crates.io/semver/1.0.27 \
     crate://crates.io/serde/1.0.228 \
     crate://crates.io/serde_core/1.0.228 \
     crate://crates.io/serde_derive/1.0.228 \
-    crate://crates.io/serde_json/1.0.145 \
-    crate://crates.io/serde_spanned/1.0.3 \
-    crate://crates.io/servo_arc/0.4.1 \
+    crate://crates.io/serde_json/1.0.149 \
+    crate://crates.io/serde_spanned/1.0.4 \
+    crate://crates.io/servo_arc/0.4.3 \
     crate://crates.io/sha2/0.10.9 \
-    crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/1.3.0 \
     crate://crates.io/simba/0.9.1 \
-    crate://crates.io/simd-adler32/0.3.7 \
-    crate://crates.io/siphasher/1.0.1 \
+    crate://crates.io/simd-adler32/0.3.8 \
+    crate://crates.io/siphasher/1.0.2 \
     crate://crates.io/slab/0.4.11 \
     crate://crates.io/smallvec/1.15.1 \
     crate://crates.io/stable_deref_trait/1.2.1 \
@@ -259,27 +281,26 @@ SRC_URI += " \
     crate://crates.io/string_cache_codegen/0.5.4 \
     crate://crates.io/stringprep/0.1.5 \
     crate://crates.io/strsim/0.11.1 \
-    crate://crates.io/syn/2.0.108 \
+    crate://crates.io/syn/2.0.114 \
     crate://crates.io/synstructure/0.13.2 \
     crate://crates.io/system-deps/7.0.7 \
     crate://crates.io/target-lexicon/0.13.3 \
-    crate://crates.io/tempfile/3.23.0 \
+    crate://crates.io/tempfile/3.24.0 \
     crate://crates.io/tendril/0.4.3 \
     crate://crates.io/termtree/0.5.1 \
-    crate://crates.io/thiserror/2.0.17 \
-    crate://crates.io/thiserror-impl/2.0.17 \
-    crate://crates.io/time/0.3.44 \
-    crate://crates.io/time-core/0.1.6 \
-    crate://crates.io/time-macros/0.2.24 \
+    crate://crates.io/thiserror/2.0.18 \
+    crate://crates.io/thiserror-impl/2.0.18 \
+    crate://crates.io/time/0.3.47 \
+    crate://crates.io/time-core/0.1.8 \
+    crate://crates.io/time-macros/0.2.27 \
     crate://crates.io/tinystr/0.8.2 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.10.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.9.8 \
-    crate://crates.io/toml_datetime/0.7.3 \
-    crate://crates.io/toml_edit/0.23.7 \
-    crate://crates.io/toml_parser/1.0.4 \
-    crate://crates.io/toml_writer/1.0.4 \
+    crate://crates.io/toml/0.9.11+spec-1.1.0 \
+    crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.0.6+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.0.6+spec-1.1.0 \
     crate://crates.io/ttf-parser/0.25.1 \
     crate://crates.io/typenum/1.19.0 \
     crate://crates.io/unarray/0.1.4 \
@@ -287,7 +308,7 @@ SRC_URI += " \
     crate://crates.io/unicode-ident/1.0.22 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-properties/0.1.4 \
-    crate://crates.io/url/2.5.7 \
+    crate://crates.io/url/2.5.8 \
     crate://crates.io/utf-8/0.7.6 \
     crate://crates.io/utf8_iter/1.0.4 \
     crate://crates.io/utf8parse/0.2.2 \
@@ -295,14 +316,14 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/wait-timeout/0.2.1 \
     crate://crates.io/walkdir/2.5.0 \
-    crate://crates.io/wasip2/1.0.1+wasi-0.2.4 \
-    crate://crates.io/wasm-bindgen/0.2.105 \
-    crate://crates.io/wasm-bindgen-macro/0.2.105 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.105 \
-    crate://crates.io/wasm-bindgen-shared/0.2.105 \
-    crate://crates.io/web-sys/0.3.82 \
+    crate://crates.io/wasip2/1.0.2+wasi-0.2.9 \
+    crate://crates.io/wasm-bindgen/0.2.108 \
+    crate://crates.io/wasm-bindgen-macro/0.2.108 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.108 \
+    crate://crates.io/wasm-bindgen-shared/0.2.108 \
+    crate://crates.io/web-sys/0.3.85 \
     crate://crates.io/web_atoms/0.1.3 \
-    crate://crates.io/weezl/0.1.10 \
+    crate://crates.io/weezl/0.1.12 \
     crate://crates.io/wide/0.7.33 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
@@ -314,43 +335,25 @@ SRC_URI += " \
     crate://crates.io/windows-link/0.2.1 \
     crate://crates.io/windows-result/0.4.1 \
     crate://crates.io/windows-strings/0.5.1 \
-    crate://crates.io/windows-sys/0.59.0 \
-    crate://crates.io/windows-sys/0.60.2 \
     crate://crates.io/windows-sys/0.61.2 \
-    crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows-targets/0.53.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
-    crate://crates.io/windows_aarch64_gnullvm/0.53.1 \
-    crate://crates.io/windows_aarch64_msvc/0.52.6 \
-    crate://crates.io/windows_aarch64_msvc/0.53.1 \
-    crate://crates.io/windows_i686_gnu/0.52.6 \
-    crate://crates.io/windows_i686_gnu/0.53.1 \
-    crate://crates.io/windows_i686_gnullvm/0.52.6 \
-    crate://crates.io/windows_i686_gnullvm/0.53.1 \
-    crate://crates.io/windows_i686_msvc/0.52.6 \
-    crate://crates.io/windows_i686_msvc/0.53.1 \
-    crate://crates.io/windows_x86_64_gnu/0.52.6 \
-    crate://crates.io/windows_x86_64_gnu/0.53.1 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
-    crate://crates.io/windows_x86_64_gnullvm/0.53.1 \
-    crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/windows_x86_64_msvc/0.53.1 \
-    crate://crates.io/winnow/0.7.13 \
-    crate://crates.io/wit-bindgen/0.46.0 \
+    crate://crates.io/winnow/0.7.14 \
+    crate://crates.io/wit-bindgen/0.51.0 \
     crate://crates.io/writeable/0.6.2 \
     crate://crates.io/xml5ever/0.35.0 \
+    crate://crates.io/yansi/1.0.1 \
     crate://crates.io/yeslogic-fontconfig-sys/6.0.0 \
     crate://crates.io/yoke/0.8.1 \
     crate://crates.io/yoke-derive/0.8.1 \
-    crate://crates.io/zerocopy/0.8.27 \
-    crate://crates.io/zerocopy-derive/0.8.27 \
+    crate://crates.io/zerocopy/0.8.36 \
+    crate://crates.io/zerocopy-derive/0.8.36 \
     crate://crates.io/zerofrom/0.1.6 \
     crate://crates.io/zerofrom-derive/0.1.6 \
     crate://crates.io/zerotrie/0.2.3 \
     crate://crates.io/zerovec/0.11.5 \
     crate://crates.io/zerovec-derive/0.11.2 \
-    crate://crates.io/zune-core/0.4.12 \
-    crate://crates.io/zune-jpeg/0.4.21 \
+    crate://crates.io/zmij/1.0.17 \
+    crate://crates.io/zune-core/0.5.1 \
+    crate://crates.io/zune-jpeg/0.5.13 \
 "
 
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
@@ -362,10 +365,10 @@ SRC_URI[anes-0.1.6.sha256sum] = "4b46cbb362ab8752921c97e041f5e366ee6297bd428a312
 SRC_URI[anstream-0.6.21.sha256sum] = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
 SRC_URI[anstyle-1.0.13.sha256sum] = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
 SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
-SRC_URI[anstyle-query-1.1.4.sha256sum] = "9e231f6134f61b71076a3eab506c379d4f36122f2af15a9ff04415ea4c3339e2"
-SRC_URI[anstyle-wincon-3.0.10.sha256sum] = "3e0633414522a32ffaac8ac6cc8f748e090c5717661fddeea04219e2344f5f2a"
+SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
+SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[approx-0.5.1.sha256sum] = "cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.1.1.sha256sum] = "bcbb6924530aa9e0432442af08bbcafdad182db80d2e560da42a6d442535bf85"
+SRC_URI[assert_cmd-2.1.2.sha256sum] = "9c5bcfa8749ac45dd12cb11055aeeb6b27a3895560d60d71e3c23bf979e60514"
 SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
 SRC_URI[av-data-0.4.4.sha256sum] = "fca67ba5d317924c02180c576157afd54babe48a76ebc66ce6d34bb8ba08308e"
 SRC_URI[bit-set-0.8.0.sha256sum] = "08807e080ed7f9d5433fa9b275196cfc35414f66a0c79d864dc51a0d825231a3"
@@ -376,30 +379,30 @@ SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c0840847
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[block-padding-0.3.3.sha256sum] = "a8894febbff9f758034a5b8e12d87918f56dfc64a8e1fe757d65e29041538d93"
 SRC_URI[bstr-1.12.1.sha256sum] = "63044e1ae8e69f3b5a92c736ca6269b8d12fa7efe39bf34ddb06d102cf0e2cab"
-SRC_URI[bumpalo-3.19.0.sha256sum] = "46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
+SRC_URI[bumpalo-3.19.1.sha256sum] = "5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
 SRC_URI[byte-slice-cast-1.2.3.sha256sum] = "7575182f7272186991736b70173b0ea045398f984bf5ebbb3804736ce1330c9d"
 SRC_URI[bytecount-0.6.9.sha256sum] = "175812e0be2bccb6abe50bb8d566126198344f707e304f45c648fd8f2cc0365e"
 SRC_URI[bytemuck-1.24.0.sha256sum] = "1fbdf580320f38b612e485521afda1ee26d10cc9884efaaa750d383e13e3c5f4"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[byteorder-lite-0.1.0.sha256sum] = "8f1fe948ff07f4bd06c30984e69f5b4899c516a3ef74f34df92a2df2ab535495"
-SRC_URI[bytes-1.10.1.sha256sum] = "d71b6127be86fdcfddb610f7182ac57211d4b18a3e9c82eb2d17662f2227ad6a"
-SRC_URI[cairo-rs-0.21.2.sha256sum] = "dfe4354df4da648870e363387679081f8f9fc538ec8b55901e3740c6a0ef81b1"
-SRC_URI[cairo-sys-rs-0.21.2.sha256sum] = "47d6c3300c7103eb8e4de07591003511aa25664438f8c6fc317a3a9902c103f8"
+SRC_URI[bytes-1.11.1.sha256sum] = "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33"
+SRC_URI[cairo-rs-0.22.0.sha256sum] = "5cc8d9aa793480744cd9a0524fef1a2e197d9eaa0f739cde19d16aba530dcb95"
+SRC_URI[cairo-sys-rs-0.22.0.sha256sum] = "f8b4985713047f5faee02b8db6a6ef32bbb50269ff53c1aee716d1d195b76d54"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 SRC_URI[cbc-0.1.2.sha256sum] = "26b52a9543ae338f279b96b0b9fed9c8093744685043739079ce85cd58f289a6"
-SRC_URI[cc-1.2.44.sha256sum] = "37521ac7aabe3d13122dc382493e20c9416f299d2ccd5b3a5340a2570cdeb0f3"
-SRC_URI[cfg-expr-0.20.4.sha256sum] = "9acd0bdbbf4b2612d09f52ba61da432140cb10930354079d0d53fafc12968726"
+SRC_URI[cc-1.2.54.sha256sum] = "6354c81bbfd62d9cfa9cb3c773c2b7b2a3a482d569de977fd0e961f6e7c00583"
+SRC_URI[cfg-expr-0.20.6.sha256sum] = "78cef5b5a1a6827c7322ae2a636368a573006b27cfa76c7ebd53e834daeaab6a"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[chrono-0.4.42.sha256sum] = "145052bdd345b87320e369255277e3fb5152762ad123a901ef5c262dd38fe8d2"
+SRC_URI[chrono-0.4.43.sha256sum] = "fac4744fb15ae8337dc853fee7fb3f4e48c0fbaa23d0afe49c447b4fab126118"
 SRC_URI[ciborium-0.2.2.sha256sum] = "42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
 SRC_URI[ciborium-io-0.2.2.sha256sum] = "05afea1e0a06c9be33d539b876f1ce3692f4afea2cb41f740e7743225ed1c757"
 SRC_URI[ciborium-ll-0.2.2.sha256sum] = "57663b653d948a338bfb3eeba9bb2fd5fcfaecb9e199e87e1eda4d9e8b240fd9"
 SRC_URI[cipher-0.4.4.sha256sum] = "773f3b9af64447d2ce9850330c473515014aa235e6a783b02db81ff39e4a3dad"
-SRC_URI[clap-4.5.51.sha256sum] = "4c26d721170e0295f191a69bd9a1f93efcdb0aff38684b61ab5750468972e5f5"
-SRC_URI[clap_builder-4.5.51.sha256sum] = "75835f0c7bf681bfd05abe44e965760fea999a5286c6eb2d59883634fd02011a"
-SRC_URI[clap_complete-4.5.60.sha256sum] = "8e602857739c5a4291dfa33b5a298aeac9006185229a700e5810a3ef7272d971"
-SRC_URI[clap_derive-4.5.49.sha256sum] = "2a0b5487afeab2deb2ff4e03a807ad1a03ac532ff5a2cee5d86884440c7f7671"
-SRC_URI[clap_lex-0.7.6.sha256sum] = "a1d728cc89cf3aee9ff92b05e62b19ee65a02b5702cff7d5a377e32c6ae29d8d"
+SRC_URI[clap-4.5.56.sha256sum] = "a75ca66430e33a14957acc24c5077b503e7d374151b2b4b3a10c83b4ceb4be0e"
+SRC_URI[clap_builder-4.5.56.sha256sum] = "793207c7fa6300a0608d1080b858e5fdbe713cdc1c8db9fb17777d8a13e63df0"
+SRC_URI[clap_complete-4.5.65.sha256sum] = "430b4dc2b5e3861848de79627b2bedc9f3342c7da5173a14eaa5d0f8dc18ae5d"
+SRC_URI[clap_derive-4.5.55.sha256sum] = "a92793da1a46a5f2a02a6f4c46c6496b28c43638adea8306fcb0caa1634f24e5"
+SRC_URI[clap_lex-0.7.7.sha256sum] = "c3e64b0cc0439b12df2fa678eae89a1c56a529fd067a9115f7827f1fffd22b32"
 SRC_URI[color_quant-1.1.0.sha256sum] = "3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
 SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
@@ -411,21 +414,22 @@ SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853
 SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
 SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
 SRC_URI[crunchy-0.2.4.sha256sum] = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
-SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
+SRC_URI[crypto-common-0.1.7.sha256sum] = "78c8292055d1c1df0cce5d180393dc8cce0abec0a7102adb6c7b1eef6016d60a"
 SRC_URI[cssparser-0.35.0.sha256sum] = "4e901edd733a1472f944a45116df3f846f54d37e67e68640ac8bb69689aca2aa"
 SRC_URI[cssparser-color-0.3.0.sha256sum] = "6eeef9ae8c0e112edd89eb6406b3156ffa99c7e037b3baef1dbdf4158d35c324"
 SRC_URI[cssparser-macros-0.6.1.sha256sum] = "13b588ba4ac1a99f7f2964d24b3d896ddc6bf847ee3855dbd4366f058cfcd331"
 SRC_URI[data-url-0.3.2.sha256sum] = "be1e0bca6c3637f992fc1cc7cbc52a78c1ef6db076dbf1059c4323d6a2048376"
-SRC_URI[dav1d-0.10.4.sha256sum] = "80c3f80814db85397819d464bb553268992c393b4b3b5554b89c1655996d5926"
+SRC_URI[dav1d-0.11.1.sha256sum] = "3ee89cb860616069c67520dcd66cacdb900b57c799f634a0eb6d91f6e2a82b61"
 SRC_URI[dav1d-sys-0.8.3.sha256sum] = "c3c91aea6668645415331133ed6f8ddf0e7f40160cd97a12d59e68716a58704b"
 SRC_URI[deranged-0.5.5.sha256sum] = "ececcb659e7ba858fb4f10388c250a7252eb0a27373f1a72b8748afdd248e587"
-SRC_URI[derive_more-2.0.1.sha256sum] = "093242cf7570c207c83073cf82f79706fe7b8317e98620a47d5be7c3d8497678"
-SRC_URI[derive_more-impl-2.0.1.sha256sum] = "bda628edc44c4bb645fbe0f758797143e4e07926f7ebf4e9bdfbd3d2ce621df3"
+SRC_URI[derive_more-2.1.1.sha256sum] = "d751e9e49156b02b44f9c1815bcb94b984cdcc4396ecc32521c739452808b134"
+SRC_URI[derive_more-impl-2.1.1.sha256sum] = "799a97264921d8623a957f6c3b9011f3b5492f557bbb7a5a19b7fa6d06ba8dcb"
+SRC_URI[diff-0.1.13.sha256sum] = "56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
 SRC_URI[difflib-0.4.0.sha256sum] = "6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"
 SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
 SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
 SRC_URI[dlib-0.5.2.sha256sum] = "330c60081dcc4c72131f8eb70510f1ac07223e5d4163db481a04a0befcffa412"
-SRC_URI[dtoa-1.0.10.sha256sum] = "d6add3b8cff394282be81f3fc1a0605db594ed69890078ca6e2cab1c408bcf04"
+SRC_URI[dtoa-1.0.11.sha256sum] = "4c3cf4824e2d5f025c7b531afcb2325364084a16806f6d47fbc1f5fbd9960590"
 SRC_URI[dtoa-short-0.3.5.sha256sum] = "cd1511a7b6a56299bd043a9c167a6d2bfb37bf84a6dfceaba651168adfb43c87"
 SRC_URI[ecb-0.1.2.sha256sum] = "1a8bfa975b1aec2145850fcaa1c6fe269a16578c44705a532ae3edc92b8881c7"
 SRC_URI[either-1.15.0.sha256sum] = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
@@ -435,68 +439,88 @@ SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda
 SRC_URI[fallible_collections-0.4.9.sha256sum] = "a88c69768c0a15262df21899142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
 SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
 SRC_URI[fdeflate-0.3.7.sha256sum] = "1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
-SRC_URI[find-msvc-tools-0.1.4.sha256sum] = "52051878f80a721bb68ebfbc930e07b65ba72f2da88968ea5c06fd6ca3d3a127"
-SRC_URI[flate2-1.1.5.sha256sum] = "bfe33edd8e85a12a67454e37f8c75e730830d83e313556ab9ebf9ee7fbeb3bfb"
+SRC_URI[find-msvc-tools-0.1.8.sha256sum] = "8591b0bcc8a98a64310a2fae1bb3e9b8564dd10e381e6e28010fde8e8e8568db"
+SRC_URI[flate2-1.1.8.sha256sum] = "b375d6465b98090a5f25b1c7703f3859783755aa9a80433b36e0379a3ec2f369"
 SRC_URI[float-cmp-0.10.0.sha256sum] = "b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
 SRC_URI[futf-0.1.5.sha256sum] = "df420e2e84819663797d1ec6544b13c5be84629e7bb00dc960d6917db2987843"
 SRC_URI[futures-channel-0.3.31.sha256sum] = "2dff15bf788c671c1934e366d07e30c1814a8ef514e1af724a602e8a2fbe1b10"
-SRC_URI[futures-core-0.3.31.sha256sum] = "05f29059c0c2090612e8d742178b0580d2dc940c837851ad723096f87af6663e"
+SRC_URI[futures-core-0.3.32.sha256sum] = "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
 SRC_URI[futures-executor-0.3.31.sha256sum] = "1e28d1d997f585e54aebc3f97d39e72338912123a67330d723fdbb564d646c9f"
 SRC_URI[futures-io-0.3.31.sha256sum] = "9e5c1b78ca4aae1ac06c48a526a655760685149f0d465d21f37abfe57ce075c6"
-SRC_URI[futures-macro-0.3.31.sha256sum] = "162ee34ebcb7c64a8abebc059ce0fee27c2262618d7b60ed8faf72fef13c3650"
-SRC_URI[futures-task-0.3.31.sha256sum] = "f90f7dce0722e95104fcb095585910c0977252f286e354b5e3bd38902cd99988"
-SRC_URI[futures-util-0.3.31.sha256sum] = "9fa08315bb612088cc391249efdc3bc77536f16c91f6cf495e6fbe85b20a4a81"
+SRC_URI[futures-macro-0.3.32.sha256sum] = "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b"
+SRC_URI[futures-task-0.3.32.sha256sum] = "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
+SRC_URI[futures-util-0.3.32.sha256sum] = "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
 SRC_URI[fxhash-0.2.1.sha256sum] = "c31b6d751ae2c7f11320402d34e41349dd1016f8d5d45e48c4312bc8625af50c"
-SRC_URI[gdk-pixbuf-0.21.2.sha256sum] = "2a3c64459f569154f37616fc28923bfac490d4aaa134aaf5eca58a2c0c13050f"
-SRC_URI[gdk-pixbuf-sys-0.21.2.sha256sum] = "3854ef7a6a8b8f3b4013a01d5f9cb0d1794ec4e810c6cb4e2cc6d980f1baf724"
-SRC_URI[generic-array-0.14.9.sha256sum] = "4bb6743198531e02858aeaea5398fcc883e71851fcbcb5a2f773e2fb6cb1edf2"
+SRC_URI[gdk-pixbuf-0.22.0.sha256sum] = "25f420376dbee041b2db374ce4573892a36222bb3f6c0c43e24f0d67eae9b646"
+SRC_URI[gdk-pixbuf-sys-0.22.0.sha256sum] = "48f31b37b1fc4b48b54f6b91b7ef04c18e00b4585d98359dd7b998774bbd91fb"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
 SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
-SRC_URI[gif-0.13.3.sha256sum] = "4ae047235e33e2829703574b54fdec96bfbad892062d97fed2f76022287de61b"
-SRC_URI[gio-0.21.4.sha256sum] = "daeff3dd716d1ba91850b976b76a1c2d28f99ef6c1602cd8fdaa8fab8017fd9c"
-SRC_URI[gio-sys-0.21.2.sha256sum] = "171ed2f6dd927abbe108cfd9eebff2052c335013f5879d55bab0dc1dee19b706"
-SRC_URI[glib-0.21.4.sha256sum] = "5b9dbecb1c33e483a98be4acfea2ab369e1c28f517c6eadb674537409c25c4b2"
-SRC_URI[glib-macros-0.21.4.sha256sum] = "880e524e0085f3546cfb38532b2c202c0d64741d9977a6e4aa24704bfc9f19fb"
-SRC_URI[glib-sys-0.21.2.sha256sum] = "d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1"
-SRC_URI[gobject-sys-0.21.2.sha256sum] = "538e41d8776173ec107e7b0f2aceced60abc368d7e1d81c1f0e2ecd35f59080d"
+SRC_URI[gif-0.14.1.sha256sum] = "f5df2ba84018d80c213569363bdcd0c64e6933c67fe4c1d60ecf822971a3c35e"
+SRC_URI[gio-0.22.1.sha256sum] = "bb018ae3f3967134a833fac8a2568c3e698f4b95c658865360772d73803cc5de"
+SRC_URI[gio-sys-0.22.0.sha256sum] = "64729ba2772c080448f9f966dba8f4456beeb100d8c28a865ef8a0f2ef4987e1"
+SRC_URI[gio-unix-0.22.0.sha256sum] = "69db2f0bb80c9d97c315720c395db76d4649969bce3a130aea6c5c9d757bf80f"
+SRC_URI[gio-unix-sys-0.22.0.sha256sum] = "44bab97ce39112040216e268f074645f50b31caeb53af708ab5d7e4e67f0dbfd"
+SRC_URI[gio-win32-0.22.0.sha256sum] = "bcbc408e97739d418bed9200f4af709a47ccfbf7efb9adf02882ba2cdb02304f"
+SRC_URI[gio-win32-sys-0.22.0.sha256sum] = "d673cd130fa7b598cf3fa776265a8e4c02634f3283433d441b8fc6f9fe07f327"
+SRC_URI[glam-0.14.0.sha256sum] = "333928d5eb103c5d4050533cec0384302db6be8ef7d3cebd30ec6a35350353da"
+SRC_URI[glam-0.15.2.sha256sum] = "3abb554f8ee44336b72d522e0a7fe86a29e09f839a36022fa869a7dfe941a54b"
+SRC_URI[glam-0.16.0.sha256sum] = "4126c0479ccf7e8664c36a2d719f5f2c140fbb4f9090008098d2c291fa5b3f16"
+SRC_URI[glam-0.17.3.sha256sum] = "e01732b97afd8508eee3333a541b9f7610f454bb818669e66e90f5f57c93a776"
+SRC_URI[glam-0.18.0.sha256sum] = "525a3e490ba77b8e326fb67d4b44b4bd2f920f44d4cc73ccec50adc68e3bee34"
+SRC_URI[glam-0.19.0.sha256sum] = "2b8509e6791516e81c1a630d0bd7fbac36d2fa8712a9da8662e716b52d5051ca"
+SRC_URI[glam-0.20.5.sha256sum] = "f43e957e744be03f5801a55472f593d43fabdebf25a4585db250f04d86b1675f"
+SRC_URI[glam-0.21.3.sha256sum] = "518faa5064866338b013ff9b2350dc318e14cc4fcd6cb8206d7e7c9886c98815"
+SRC_URI[glam-0.22.0.sha256sum] = "12f597d56c1bd55a811a1be189459e8fad2bbc272616375602443bdfb37fa774"
+SRC_URI[glam-0.23.0.sha256sum] = "8e4afd9ad95555081e109fe1d21f2a30c691b5f0919c67dfa690a2e1eb6bd51c"
+SRC_URI[glam-0.24.2.sha256sum] = "b5418c17512bdf42730f9032c74e1ae39afc408745ebb2acf72fbc4691c17945"
+SRC_URI[glam-0.25.0.sha256sum] = "151665d9be52f9bb40fc7966565d39666f2d1e69233571b71b87791c7e0528b3"
+SRC_URI[glam-0.27.0.sha256sum] = "9e05e7e6723e3455f4818c7b26e855439f7546cf617ef669d1adedb8669e5cb9"
+SRC_URI[glam-0.28.0.sha256sum] = "779ae4bf7e8421cf91c0b3b64e7e8b40b862fba4d393f59150042de7c4965a94"
+SRC_URI[glam-0.29.3.sha256sum] = "8babf46d4c1c9d92deac9f7be466f76dfc4482b6452fc5024b5e8daf6ffeb3ee"
+SRC_URI[glam-0.30.10.sha256sum] = "19fc433e8437a212d1b6f1e68c7824af3aed907da60afa994e7f542d18d12aa9"
+SRC_URI[glib-0.22.0.sha256sum] = "9a3b79a62980e85d61aae88988e5bcca6a35f05b0008e1333aa43bd61ef9bf35"
+SRC_URI[glib-macros-0.22.0.sha256sum] = "8b48a968528354e04603ae96205f00cf7e77347ffde0fc943a2159948d7d6d80"
+SRC_URI[glib-sys-0.22.0.sha256sum] = "48073e3b228419faa80b9b7f7122759d4ab2f44cd52a065fde7ca08f34c03147"
+SRC_URI[gobject-sys-0.22.0.sha256sum] = "18eda93f09d3778f38255b231b17ef67195013a592c91624a4daf8bead875565"
 SRC_URI[half-2.7.1.sha256sum] = "6ea2d84b969582b4b1864a92dc5d27cd2b77b622a8d79306834f1be5ba20d84b"
 SRC_URI[hashbrown-0.13.2.sha256sum] = "43a3c133739dddd0d2990f9a4bdf8eb4b21ef50e4851ca85ab661199821d510e"
-SRC_URI[hashbrown-0.16.0.sha256sum] = "5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
+SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
-SRC_URI[iana-time-zone-0.1.64.sha256sum] = "33e57f83510bb73707521ebaffa789ec8caf86f9657cad665b092b581d40e9fb"
+SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
 SRC_URI[icu_collections-2.1.1.sha256sum] = "4c6b649701667bbe825c3b7e6388cb521c23d88644678e83c0c4d0a621a34b43"
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
-SRC_URI[image-0.25.8.sha256sum] = "529feb3e6769d234375c4cf1ee2ce713682b8e76538cb13f9fc23e1400a591e7"
+SRC_URI[image-0.25.10.sha256sum] = "85ab80394333c02fe689eaf900ab500fbd0c2213da414687ebf995a65d5a6104"
 SRC_URI[image-webp-0.2.4.sha256sum] = "525e9ff3e1a4be2fbea1fdf0e98686a6d98b4d8f937e1bf7402245af1909e8c3"
-SRC_URI[indexmap-2.12.0.sha256sum] = "6717a8d2a5a929a1a2eb43a12812498ed141a0bcfb7e8f7844fbdbe4303bba9f"
+SRC_URI[indexmap-2.13.0.sha256sum] = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
 SRC_URI[inout-0.1.4.sha256sum] = "879f10e63c20629ecabbb64a8010319738c66a5cd0c29b02d63d272b03751d01"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
 SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
-SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
-SRC_URI[jiff-0.2.15.sha256sum] = "be1f93b8b1eb69c77f24bbb0afdf66f54b632ee39af40ca21c4365a1d7347e49"
-SRC_URI[jiff-static-0.2.15.sha256sum] = "03343451ff899767262ec32146f6d559dd759fdadf42ff0e227c7c48f72594b4"
-SRC_URI[jiff-tzdb-0.1.4.sha256sum] = "c1283705eb0a21404d2bfd6eef2a7593d240bc42a0bdb39db0ad6fa2ec026524"
+SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
+SRC_URI[jiff-0.2.18.sha256sum] = "e67e8da4c49d6d9909fe03361f9b620f58898859f5c7aded68351e85e71ecf50"
+SRC_URI[jiff-static-0.2.18.sha256sum] = "e0c84ee7f197eca9a86c6fd6cb771e55eb991632f15f2bc3ca6ec838929e6e78"
+SRC_URI[jiff-tzdb-0.1.5.sha256sum] = "68971ebff725b9e2ca27a601c5eb38a4c5d64422c4cbab0c535f248087eda5c2"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
-SRC_URI[js-sys-0.3.82.sha256sum] = "b011eec8cc36da2aab2d5cff675ec18454fad408585853910a202391cf9f8e65"
+SRC_URI[js-sys-0.3.85.sha256sum] = "8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.177.sha256sum] = "2874a2af47a2325c2001a6e6fad9b16a53b802102b528163885171cf92b15976"
+SRC_URI[libc-0.2.180.sha256sum] = "bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[linux-raw-sys-0.11.0.sha256sum] = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
 SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
 SRC_URI[locale_config-0.3.0.sha256sum] = "08d2c35b16f4483f6c26f0e4e9550717a2f6575bcd6f12a53ff0c490a94a6934"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
-SRC_URI[log-0.4.28.sha256sum] = "34080505efa8e45a4b816c349525ebe327ceaa8559756f0356cba97ef3bf7432"
+SRC_URI[log-0.4.29.sha256sum] = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
 SRC_URI[lopdf-0.38.0.sha256sum] = "c7184fdea2bc3cd272a1acec4030c321a8f9875e877b3f92a53f2f6033fdc289"
 SRC_URI[mac-0.1.1.sha256sum] = "c41e0c4fef86961ac6d6f8a82609f55f31b05e4fce149ac5710e439df7619ba4"
 SRC_URI[malloc_buf-0.0.6.sha256sum] = "62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
@@ -504,19 +528,20 @@ SRC_URI[markup5ever-0.35.0.sha256sum] = "311fe69c934650f8f19652b3946075f0fc41ad8
 SRC_URI[matches-0.1.10.sha256sum] = "2532096657941c2fea9c289d370a250971c689d4f143798ff67113ec042024a5"
 SRC_URI[matrixmultiply-0.3.10.sha256sum] = "a06de3016e9fae57a36fd14dba131fccf49f74b40b7fbdb472f96e361ec71a08"
 SRC_URI[md-5-0.10.6.sha256sum] = "d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
-SRC_URI[memchr-2.7.6.sha256sum] = "f52b00d39961fc5b2736ea853c9cc86238e165017a493d1d5c8eac6bdc4cc273"
+SRC_URI[memchr-2.8.0.sha256sum] = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
 SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
-SRC_URI[moxcms-0.7.9.sha256sum] = "0fbdd3d7436f8b5e892b8b7ea114271ff0fa00bc5acae845d53b07d498616ef6"
+SRC_URI[moxcms-0.8.1.sha256sum] = "bb85c154ba489f01b25c0d36ae69a87e4a1c73a72631fc6c0eb6dde34a73e44b"
 SRC_URI[mp4parse-0.17.0.sha256sum] = "63a35203d3c6ce92d5251c77520acb2e57108c88728695aa883f70023624c570"
-SRC_URI[nalgebra-0.33.2.sha256sum] = "26aecdf64b707efd1310e3544d709c5c0ac61c13756046aaaba41be5c4f66a3b"
-SRC_URI[nalgebra-macros-0.2.2.sha256sum] = "254a5372af8fc138e36684761d3c0cdb758a4410e938babcff1c860ce14ddbfc"
+SRC_URI[mutants-0.0.3.sha256sum] = "bc0287524726960e07b119cebd01678f852f147742ae0d925e6a520dca956126"
+SRC_URI[nalgebra-0.34.1.sha256sum] = "c4d5b3eff5cd580f93da45e64715e8c20a3996342f1e466599cf7a267a0c2f5f"
+SRC_URI[nalgebra-macros-0.3.0.sha256sum] = "973e7178a678cfd059ccec50887658d482ce16b0aa9da3888ddeab5cd5eb4889"
 SRC_URI[new_debug_unreachable-1.0.6.sha256sum] = "650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
 SRC_URI[nom-8.0.0.sha256sum] = "df9761775871bdef83bee530e60050f7e54b1105350d6884eb0fb4f46c2f9405"
 SRC_URI[nom_locate-5.0.0.sha256sum] = "0b577e2d69827c4740cba2b52efaad1c4cc7c73042860b199710b3575c68438d"
 SRC_URI[normalize-line-endings-0.3.0.sha256sum] = "61807f77802ff30975e01f4f071c8ba10c022052f98b3294119f3e615d13e5be"
 SRC_URI[num-bigint-0.4.6.sha256sum] = "a5e44f723f1133c9deac646763579fdb3ac745e418f2a7af9cd0c431da1f20b9"
 SRC_URI[num-complex-0.4.6.sha256sum] = "73f88a1307638156682bada9d7604135552957b7818057dcef22705b4d509495"
-SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-conv-0.2.0.sha256sum] = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
 SRC_URI[num-derive-0.4.2.sha256sum] = "ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
 SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
 SRC_URI[num-rational-0.4.2.sha256sum] = "f83d14da390562dca69fc84082e73e548e1ad308d24accdedd2720017cb37824"
@@ -527,10 +552,10 @@ SRC_URI[objc_id-0.1.1.sha256sum] = "c92d4ddb4bd7b50d730c215ff871754d0da6b2178849
 SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[oorandom-11.1.5.sha256sum] = "d6790f58c7ff633d8771f42965289203411a5e5c68388703c06e14f24770b41e"
-SRC_URI[pango-0.21.3.sha256sum] = "e37b7a678e18c2e9f2485f7e39b7b2dac99590d5ddef08a7f56eae38a145402e"
-SRC_URI[pango-sys-0.21.2.sha256sum] = "f4f5daf21da43fba9f2a0092da0eebeb77637c23552bccaf58f791c518009c94"
-SRC_URI[pangocairo-0.21.2.sha256sum] = "7fe686297711b9c0499d0e292e86d343d90b4832d19ebff3d50ce3f627b64e17"
-SRC_URI[pangocairo-sys-0.21.2.sha256sum] = "e6263d7d919c8f3ccd31874774b5f7924e88f5b82ddee3163b3ef49197786a00"
+SRC_URI[pango-0.22.0.sha256sum] = "25d8f224eddef627b896d2f7b05725b3faedbd140e0e8343446f0d34f34238ee"
+SRC_URI[pango-sys-0.22.0.sha256sum] = "bbd111a20ca90fedf03e09c59783c679c00900f1d8491cca5399f5e33609d5d6"
+SRC_URI[pangocairo-0.22.0.sha256sum] = "d9f15369c787b1cc59a5b86eff6afffd5a9716c5beb4969d20b307cebfe7e407"
+SRC_URI[pangocairo-sys-0.22.0.sha256sum] = "d95cb73468373b9e568abb1afbaf5b42fe6ab9128fc41b5f2adbf69451c3c77f"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
 SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
 SRC_URI[paste-1.0.15.sha256sum] = "57c0d7b74b563b49d38dae00a0c37d4d6de9b432382b2892f0574ddcae73fd0a"
@@ -542,13 +567,12 @@ SRC_URI[phf_macros-0.11.3.sha256sum] = "f84ac04429c13a7ff43785d75ad27569f2951ce0
 SRC_URI[phf_shared-0.11.3.sha256sum] = "67eabc2ef2a60eb7faa00097bd1ffdb5bd28e62bf39990626a582201b7a754e5"
 SRC_URI[phf_shared-0.13.1.sha256sum] = "e57fef6bc5981e38c2ce2d63bfa546861309f875b8a75f092d1d54ae2d64f266"
 SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
-SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
 SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
 SRC_URI[plotters-0.3.7.sha256sum] = "5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
 SRC_URI[plotters-backend-0.3.7.sha256sum] = "df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
 SRC_URI[plotters-svg-0.3.7.sha256sum] = "51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
-SRC_URI[png-0.18.0.sha256sum] = "97baced388464909d42d89643fe4361939af9b7ce7a31ee32a168f832a70f2a0"
-SRC_URI[portable-atomic-1.11.1.sha256sum] = "f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
+SRC_URI[png-0.18.1.sha256sum] = "60769b8b31b2a9f263dae2776c37b1b28ae246943cf719eb6946a1db05128a61"
+SRC_URI[portable-atomic-1.13.0.sha256sum] = "f89776e4d69bb58bc6993e99ffa1d11f228b839984854c7daeb5d37f87cbe950"
 SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
 SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
@@ -557,21 +581,21 @@ SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a4
 SRC_URI[predicates-3.1.3.sha256sum] = "a5d19ee57562043d37e82899fade9a22ebab7be9cef5026b07fda9cdd4293573"
 SRC_URI[predicates-core-1.0.9.sha256sum] = "727e462b119fe9c93fd0eb1429a5f7647394014cf3c04ab2c0350eeb09095ffa"
 SRC_URI[predicates-tree-1.0.12.sha256sum] = "72dd2d6d381dfb73a193c7fca536518d7caee39fc8503f74e7dc0be0531b425c"
-SRC_URI[proc-macro-crate-3.4.0.sha256sum] = "219cb19e96be00ab2e37d6e299658a0cfa83e52429179969b0f0121b4ac46983"
-SRC_URI[proc-macro2-1.0.103.sha256sum] = "5ee95bc4ef87b8d5ba32e8b7714ccc834865276eab0aed5c9958d00ec45f49e8"
+SRC_URI[pretty_assertions-1.4.1.sha256sum] = "3ae130e2f271fbc2ac3a40fb1d07180839cdbbe443c7a27e1e3c13c5cac0116d"
+SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
 SRC_URI[proptest-1.9.0.sha256sum] = "bee689443a2bd0a16ab0348b52ee43e3b2d1b1f931c8aa5c9f8de4c86fbe8c40"
-SRC_URI[pxfm-0.1.25.sha256sum] = "a3cbdf373972bf78df4d3b518d07003938e2c7d1fb5891e55f9cb6df57009d84"
+SRC_URI[pxfm-0.1.27.sha256sum] = "7186d3822593aa4393561d186d1393b3923e9d6163d3fbfd6e825e3e6cf3e6a8"
 SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[quote-1.0.41.sha256sum] = "ce25767e7b499d1b604768e7cde645d14cc8584231ea6b295e9c9eb22c02e1d1"
+SRC_URI[quote-1.0.44.sha256sum] = "21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
 SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
+SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
 SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
-SRC_URI[rangemap-1.6.0.sha256sum] = "f93e7e49bb0bf967717f7bd674458b3d6b0c5f48ec7e3038166026a69fc22223"
+SRC_URI[rangemap-1.7.1.sha256sum] = "973443cf09a9c8656b574a866ab68dfa19f0867d0340648c7d2f6a71b8a8ea68"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
 SRC_URI[rayon-1.11.0.sha256sum] = "368f01d005bf8fd9b1206fb6fa653e6c4a81ceb1466406b81792d87c5677a58f"
 SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
@@ -581,26 +605,27 @@ SRC_URI[regex-1.12.2.sha256sum] = "843bc0191f75f3e22651ae5f1e72939ab2f72a4bc30fa
 SRC_URI[regex-automata-0.4.13.sha256sum] = "5276caf25ac86c8d810222b3dbb938e512c55c6831a10f3e6ed1c93b84041f1c"
 SRC_URI[regex-syntax-0.8.8.sha256sum] = "7a2d987857b319362043e95f5353c0535c1f58eec5336fdfcf626430af7def58"
 SRC_URI[rgb-0.8.52.sha256sum] = "0c6a884d2998352bb4daf0183589aec883f16a6da1f4dde84d8e2e9a5409a1ce"
-SRC_URI[rustix-1.1.2.sha256sum] = "cd15f8a2c5551a84d56efdc1cd049089e409ac19a3072d5037a17fd70719ff3e"
+SRC_URI[rustc_version-0.4.1.sha256sum] = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
+SRC_URI[rustix-1.1.3.sha256sum] = "146c9e247ccc180c1f61615433868c99f3de3ae256a30a43b49f67c2d9171f34"
 SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
 SRC_URI[rusty-fork-0.3.1.sha256sum] = "cc6bf79ff24e648f6da1f8d1f011e9cac26491b619e6b9280f2b47f1774e6ee2"
-SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
 SRC_URI[safe_arch-0.7.4.sha256sum] = "96b02de82ddbe1b636e6170c21be622223aea188ef2e139be0a5b219ec215323"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[selectors-0.31.0.sha256sum] = "5685b6ae43bfcf7d2e7dfcfb5d8e8f61b46442c902531e41a32a9a8bf0ee0fb6"
+SRC_URI[semver-1.0.27.sha256sum] = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
 SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
 SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
 SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
-SRC_URI[serde_json-1.0.145.sha256sum] = "402a6f66d8c709116cf22f558eab210f5a50187f702eb4d7e5ef38d9a7f1c79c"
-SRC_URI[serde_spanned-1.0.3.sha256sum] = "e24345aa0fe688594e73770a5f6d1b216508b4f93484c0026d521acd30134392"
-SRC_URI[servo_arc-0.4.1.sha256sum] = "204ea332803bd95a0b60388590d59cf6468ec9becf626e2451f1d26a1d972de4"
+SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
+SRC_URI[serde_spanned-1.0.4.sha256sum] = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
+SRC_URI[servo_arc-0.4.3.sha256sum] = "170fb83ab34de17dc69aa7c67482b22218ddb85da56546f9bd6b929e32a05930"
 SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
-SRC_URI[shell-words-1.1.0.sha256sum] = "24188a676b6ae68c3b2cb3a01be17fbf7240ce009799bb56d5b1409051e78fde"
+SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
 SRC_URI[simba-0.9.1.sha256sum] = "c99284beb21666094ba2b75bbceda012e610f5479dfcc2d6e2426f53197ffd95"
-SRC_URI[simd-adler32-0.3.7.sha256sum] = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
-SRC_URI[siphasher-1.0.1.sha256sum] = "56199f7ddabf13fe5074ce809e7d3f42b42ae711800501b5b16ea82ad029c39d"
+SRC_URI[simd-adler32-0.3.8.sha256sum] = "e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
+SRC_URI[siphasher-1.0.2.sha256sum] = "b2aa850e253778c88a04c3d7323b043aeda9d3e30d5971937c1855769763678e"
 SRC_URI[slab-0.4.11.sha256sum] = "7a2ae44ef20feb57a68b23d846850f861394c2e02dc425a50098ae8c90267589"
 SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
@@ -610,27 +635,26 @@ SRC_URI[string_cache-0.9.0.sha256sum] = "a18596f8c785a729f2819c0f6a7eae6ebeebdff
 SRC_URI[string_cache_codegen-0.5.4.sha256sum] = "c711928715f1fe0fe509c53b43e993a9a557babc2d0a3567d0a3006f1ac931a0"
 SRC_URI[stringprep-0.1.5.sha256sum] = "7b4df3d392d81bd458a8a621b8bffbd2302a12ffe288a9d931670948749463b1"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
-SRC_URI[syn-2.0.108.sha256sum] = "da58917d35242480a05c2897064da0a80589a2a0476c9a3f2fdc83b53502e917"
+SRC_URI[syn-2.0.114.sha256sum] = "d4d107df263a3013ef9b1879b0df87d706ff80f65a86ea879bd9c31f9b307c2a"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
 SRC_URI[system-deps-7.0.7.sha256sum] = "48c8f33736f986f16d69b6cb8b03f55ddcad5c41acc4ccc39dd88e84aa805e7f"
 SRC_URI[target-lexicon-0.13.3.sha256sum] = "df7f62577c25e07834649fc3b39fafdc597c0a3527dc1c60129201ccfcbaa50c"
-SRC_URI[tempfile-3.23.0.sha256sum] = "2d31c77bdf42a745371d260a26ca7163f1e0924b64afa0b688e61b5a9fa02f16"
+SRC_URI[tempfile-3.24.0.sha256sum] = "655da9c7eb6305c55742045d5a8d2037996d61d8de95806335c7c86ce0f82e9c"
 SRC_URI[tendril-0.4.3.sha256sum] = "d24a120c5fc464a3458240ee02c299ebcb9d67b5249c8848b09d639dca8d7bb0"
 SRC_URI[termtree-0.5.1.sha256sum] = "8f50febec83f5ee1df3015341d8bd429f2d1cc62bcba7ea2076759d315084683"
-SRC_URI[thiserror-2.0.17.sha256sum] = "f63587ca0f12b72a0600bcba1d40081f830876000bb46dd2337a3051618f4fc8"
-SRC_URI[thiserror-impl-2.0.17.sha256sum] = "3ff15c8ecd7de3849db632e14d18d2571fa09dfc5ed93479bc4485c7a517c913"
-SRC_URI[time-0.3.44.sha256sum] = "91e7d9e3bb61134e77bde20dd4825b97c010155709965fedf0f49bb138e52a9d"
-SRC_URI[time-core-0.1.6.sha256sum] = "40868e7c1d2f0b8d73e4a8c7f0ff63af4f6d19be117e90bd73eb1d62cf831c6b"
-SRC_URI[time-macros-0.2.24.sha256sum] = "30cfb0125f12d9c277f35663a0a33f8c30190f4e4574868a330595412d34ebf3"
+SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
+SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
+SRC_URI[time-0.3.47.sha256sum] = "743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
+SRC_URI[time-core-0.1.8.sha256sum] = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
+SRC_URI[time-macros-0.2.27.sha256sum] = "2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
 SRC_URI[tinystr-0.8.2.sha256sum] = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.9.8.sha256sum] = "f0dc8b1fb61449e27716ec0e1bdf0f6b8f3e8f6b05391e8497b8b6d7804ea6d8"
-SRC_URI[toml_datetime-0.7.3.sha256sum] = "f2cdb639ebbc97961c51720f858597f7f24c4fc295327923af55b74c3c724533"
-SRC_URI[toml_edit-0.23.7.sha256sum] = "6485ef6d0d9b5d0ec17244ff7eb05310113c3f316f2d14200d4de56b3cb98f8d"
-SRC_URI[toml_parser-1.0.4.sha256sum] = "c0cbe268d35bdb4bb5a56a2de88d0ad0eb70af5384a99d648cd4b3d04039800e"
-SRC_URI[toml_writer-1.0.4.sha256sum] = "df8b2b54733674ad286d16267dcfc7a71ed5c776e4ac7aa3c3e2561f7c637bf2"
+SRC_URI[toml-0.9.11+spec-1.1.0.sha256sum] = "f3afc9a848309fe1aaffaed6e1546a7a14de1f935dc9d89d32afd9a44bab7c46"
+SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
+SRC_URI[toml_parser-1.0.6+spec-1.1.0.sha256sum] = "a3198b4b0a8e11f09dd03e133c0280504d0801269e9afa46362ffde1cbeebf44"
+SRC_URI[toml_writer-1.0.6+spec-1.1.0.sha256sum] = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
 SRC_URI[ttf-parser-0.25.1.sha256sum] = "d2df906b07856748fa3f6e0ad0cbaa047052d4a7dd609e231c4f72cee8c36f31"
 SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
@@ -638,7 +662,7 @@ SRC_URI[unicode-bidi-0.3.18.sha256sum] = "5c1cb5db39152898a79168971543b1cb5020df
 SRC_URI[unicode-ident-1.0.22.sha256sum] = "9312f7c4f6ff9069b165498234ce8be658059c6728633667c526e27dc2cf1df5"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-properties-0.1.4.sha256sum] = "7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
-SRC_URI[url-2.5.7.sha256sum] = "08bc136a29a3d1758e07a9cca267be308aeebf5cfd5a10f3f67ab2097683ef5b"
+SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
 SRC_URI[utf-8-0.7.6.sha256sum] = "09cc8ee72d2a9becf2f2febe0205bbed8fc6615b7cb429ad062dc7b7ddd036a9"
 SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
 SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
@@ -646,14 +670,14 @@ SRC_URI[version-compare-0.2.1.sha256sum] = "03c2856837ef78f57382f06b2b8563a2f512
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[wait-timeout-0.2.1.sha256sum] = "09ac3b126d3914f9849036f826e054cbabdc8519970b8998ddaf3b5bd3c65f11"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
-SRC_URI[wasip2-1.0.1+wasi-0.2.4.sha256sum] = "0562428422c63773dad2c345a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
-SRC_URI[wasm-bindgen-0.2.105.sha256sum] = "da95793dfc411fbbd93f5be7715b0578ec61fe87cb1a42b12eb625caa5c5ea60"
-SRC_URI[wasm-bindgen-macro-0.2.105.sha256sum] = "04264334509e04a7bf8690f2384ef5265f05143a4bff3889ab7a3269adab59c2"
-SRC_URI[wasm-bindgen-macro-support-0.2.105.sha256sum] = "420bc339d9f322e562942d52e115d57e950d12d88983a14c79b86859ee6c7ebc"
-SRC_URI[wasm-bindgen-shared-0.2.105.sha256sum] = "76f218a38c84bcb33c25ec7059b07847d465ce0e0a76b995e134a45adcb6af76"
-SRC_URI[web-sys-0.3.82.sha256sum] = "3a1f95c0d03a47f4ae1f7a64643a6bb97465d9b740f0fa8f90ea33915c99a9a1"
+SRC_URI[wasip2-1.0.2+wasi-0.2.9.sha256sum] = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
+SRC_URI[wasm-bindgen-0.2.108.sha256sum] = "64024a30ec1e37399cf85a7ffefebdb72205ca1c972291c51512360d90bd8566"
+SRC_URI[wasm-bindgen-macro-0.2.108.sha256sum] = "008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
+SRC_URI[wasm-bindgen-macro-support-0.2.108.sha256sum] = "5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
+SRC_URI[wasm-bindgen-shared-0.2.108.sha256sum] = "1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
+SRC_URI[web-sys-0.3.85.sha256sum] = "312e32e551d92129218ea9a2452120f4aabc03529ef03e4d0d82fb2780608598"
 SRC_URI[web_atoms-0.1.3.sha256sum] = "57ffde1dc01240bdf9992e3205668b235e59421fd085e8a317ed98da0178d414"
-SRC_URI[weezl-0.1.10.sha256sum] = "a751b3277700db47d3e574514de2eced5e54dc8a5436a3bf7a0b248b2cee16f3"
+SRC_URI[weezl-0.1.12.sha256sum] = "a28ac98ddc8b9274cb41bb4d9d4d5c425b6020c50c46f25559911905610b4a88"
 SRC_URI[wide-0.7.33.sha256sum] = "0ce5da8ecb62bcd8ec8b7ea19f69a51275e91299be594ea5cc6ef7819e16cd03"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
@@ -665,40 +689,22 @@ SRC_URI[windows-interface-0.59.3.sha256sum] = "3f316c4a2570ba26bbec722032c4099d8
 SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
 SRC_URI[windows-result-0.4.1.sha256sum] = "7781fa89eaf60850ac3d2da7af8e5242a5ea78d1a11c49bf2910bb5a73853eb5"
 SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091"
-SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
-SRC_URI[windows-sys-0.60.2.sha256sum] = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
-SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows-targets-0.53.5.sha256sum] = "4945f9f551b88e0d65f3db0bc25c33b8acea4d9e41163edf90dcd0b19f9069f3"
-SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-SRC_URI[windows_aarch64_gnullvm-0.53.1.sha256sum] = "a9d8416fa8b42f5c947f8482c43e7d89e73a173cead56d044f6a56104a6d1b53"
-SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-SRC_URI[windows_aarch64_msvc-0.53.1.sha256sum] = "b9d782e804c2f632e395708e99a94275910eb9100b2114651e04744e9b125006"
-SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-SRC_URI[windows_i686_gnu-0.53.1.sha256sum] = "960e6da069d81e09becb0ca57a65220ddff016ff2d6af6a223cf372a506593a3"
-SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-SRC_URI[windows_i686_gnullvm-0.53.1.sha256sum] = "fa7359d10048f68ab8b09fa71c3daccfb0e9b559aed648a8f95469c27057180c"
-SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_i686_msvc-0.53.1.sha256sum] = "1e7ac75179f18232fe9c285163565a57ef8d3c89254a30685b57d83a38d326c2"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnu-0.53.1.sha256sum] = "9c3842cdd74a865a8066ab39c8a7a473c0778a3f29370b5fd6b4b9aa7df4a499"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_gnullvm-0.53.1.sha256sum] = "0ffa179e2d07eee8ad8f57493436566c7cc30ac536a3379fdf008f47f6bb7ae1"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[windows_x86_64_msvc-0.53.1.sha256sum] = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
-SRC_URI[winnow-0.7.13.sha256sum] = "21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
-SRC_URI[wit-bindgen-0.46.0.sha256sum] = "f17a85883d4e6d00e8a97c586de764dabcc06133f7f1d55dce5cdc070ad7fe59"
+SRC_URI[winnow-0.7.14.sha256sum] = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
+SRC_URI[wit-bindgen-0.51.0.sha256sum] = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
 SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
 SRC_URI[xml5ever-0.35.0.sha256sum] = "ee3f1e41afb31a75aef076563b0ad3ecc24f5bd9d12a72b132222664eb76b494"
+SRC_URI[yansi-1.0.1.sha256sum] = "cfe53a6657fd280eaa890a3bc59152892ffa3e30101319d168b781ed6529b049"
 SRC_URI[yeslogic-fontconfig-sys-6.0.0.sha256sum] = "503a066b4c037c440169d995b869046827dbc71263f6e8f3be6d77d4f3229dbd"
 SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
 SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
-SRC_URI[zerocopy-0.8.27.sha256sum] = "0894878a5fa3edfd6da3f88c4805f4c8558e2b996227a3d864f47fe11e38282c"
-SRC_URI[zerocopy-derive-0.8.27.sha256sum] = "88d2b8d9c68ad2b9e4340d7832716a4d21a22a1154777ad56ea55c51a9cf3831"
+SRC_URI[zerocopy-0.8.36.sha256sum] = "dafd85c832c1b68bbb4ec0c72c7f6f4fc5179627d2bc7c26b30e4c0cc11e76cc"
+SRC_URI[zerocopy-derive-0.8.36.sha256sum] = "7cb7e4e8436d9db52fbd6625dbf2f45243ab84994a72882ec8227b99e72b439a"
 SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
 SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
 SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
 SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
 SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
-SRC_URI[zune-core-0.4.12.sha256sum] = "3f423a2c17029964870cfaabb1f13dfab7d092a62a29a89264f4d36990ca414a"
-SRC_URI[zune-jpeg-0.4.21.sha256sum] = "29ce2c8a9384ad323cf564b67da86e21d3cfdff87908bc1223ed5c99bc792713"
+SRC_URI[zmij-1.0.17.sha256sum] = "02aae0f83f69aafc94776e879363e9771d7ecbffe2c7fbb6c14c5e00dfe88439"
+SRC_URI[zune-core-0.5.1.sha256sum] = "cb8a0807f7c01457d0379ba880ba6322660448ddebc890ce29bb64da71fb40f9"
+SRC_URI[zune-jpeg-0.5.13.sha256sum] = "ec5f41c76397b7da451efd19915684f727d7e1d516384ca6bd0ec43ec94de23c"
diff --git a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
index f893d81..85ae52c 100644
--- a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
@@ -20,17 +20,17 @@ Signed-off-by: Alexander Kanavin <alex@linutronix.de>
  1 file changed, 1 insertion(+), 2 deletions(-)
 
 diff --git a/rsvg_convert/tests/rsvg_convert.rs b/rsvg_convert/tests/rsvg_convert.rs
-index 3d0a340..90a4c2f 100644
+index dbf6dd7..2dbc8f6 100644
 --- a/rsvg_convert/tests/rsvg_convert.rs
 +++ b/rsvg_convert/tests/rsvg_convert.rs
-@@ -3,7 +3,6 @@ mod internal_predicates;
- use internal_predicates::file;
+@@ -4,7 +4,6 @@ use internal_predicates::file;
  
+ use assert_cmd::Command;
  use assert_cmd::assert::IntoOutputPredicate;
 -use assert_cmd::cargo::cargo_bin_cmd;
- use assert_cmd::Command;
  #[cfg(system_deps_have_cairo_pdf)]
  use chrono::{TimeZone, Utc};
+ use predicates::boolean::*;
 @@ -50,7 +49,7 @@ impl RsvgConvert {
          let path_str = config_file_path.to_str().unwrap();
          eprintln!("FONTCONFIG_FILE={path_str}");
diff --git a/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch b/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch
index ab0ca2b..dff36aa 100644
--- a/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch
+++ b/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch
@@ -1,4 +1,8 @@
-gdk-pixbuf-loader/meson_install: improve argument parsing and logic
+From e46317a80e9d37d7b9c4cbf43ff1d60c3ac21fff Mon Sep 17 00:00:00 2001
+From: Ross Burton <ross.burton@arm.com>
+Date: Mon, 11 May 2026 12:34:53 +0100
+Subject: [PATCH 1/2] gdk-pixbuf-loader/meson_install: improve argument parsing
+ and logic
 
 Make the arguments more explicit by changing the path arguments to be
 specified with options, such as --queryloaders <path>. Previously one of
@@ -13,8 +17,83 @@ parser another Path instance does not need to be created.
 None of this changes the underlying logic, just makes it more consistent
 and explicit.
 
+Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge_requests/1194]
+Signed-off-by: Ross Burton <ross.burton@arm.com>
+---
+ gdk-pixbuf-loader/meson.build      |  4 +++-
+ gdk-pixbuf-loader/meson_install.py | 23 +++++++++++------------
+ 2 files changed, 14 insertions(+), 13 deletions(-)
+
+diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
+index 951d2d1c9..c7c017978 100644
+--- a/gdk-pixbuf-loader/meson.build
++++ b/gdk-pixbuf-loader/meson.build
+@@ -43,9 +43,11 @@ else
+ endif
+ 
+ pixbufloader_svg_install_args = [
+-  '--gdk-pixbuf-moduledir',
++  '--moduledir',
+   pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_define: ['prefix', prefix]),
++  '--queryloaders',
+   gdk_pixbuf_query_loaders,
++  '--cache-file',
+   pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_cache_file', pkgconfig_define: ['prefix', prefix])
+ ]
+ 
+diff --git a/gdk-pixbuf-loader/meson_install.py b/gdk-pixbuf-loader/meson_install.py
+index ff003350f..d9bbbe433 100644
+--- a/gdk-pixbuf-loader/meson_install.py
++++ b/gdk-pixbuf-loader/meson_install.py
+@@ -6,29 +6,28 @@ import os
+ import subprocess
+ import sys
+ 
+-argparse = ArgumentParser('Deploy loaders.cache')
+-
+-argparse.add_argument('--gdk-pixbuf-moduledir', type=Path)
+-argparse.add_argument('gdk_pixbuf_queryloaders', type=Path)
+-argparse.add_argument('gdk_pixbuf_cache_file', type=Path)
+-argparse.add_argument('--show-cross-message', action='store_true')
+-
+ if __name__ == '__main__':
++    argparse = ArgumentParser(description='Deploy loaders.cache. Pass required paths, or --show-cross-message.')
++    argparse.add_argument('--queryloaders', type=Path, metavar="PATH", help="gdk-pixbuf-queryloaders to run")
++    argparse.add_argument('--moduledir', type=Path, metavar="PATH", help="installed gdk-pixbuf module directory")
++    argparse.add_argument('--cache-file', type=Path, metavar="PATH", help="module cache file to write")
++    argparse.add_argument('--show-cross-message', action='store_true', help="tell the user to run query-loaders manually")
+     args = argparse.parse_args()
+ 
+-    cache_file: Path = args.gdk_pixbuf_cache_file
++    if not(args.show_cross_message or (args.queryloaders and args.moduledir and args.cache_file)):
++        argparse.print_help()
++        sys.exit(1)
+ 
+     if args.show_cross_message or os.environ.get("DESTDIR"):
+         print('*** Note: Please run gdk-pixbuf-queryloaders manually ' +
+               'against the newly-built gdkpixbuf-svg loader', file=sys.stderr)
+     else:
+         env = os.environ.copy()
+-        env['GDK_PIXBUF_MODULEDIR'] = Path(args.gdk_pixbuf_moduledir).as_posix()
+-        with cache_file.open('w', encoding='utf-8') as f:
++        env['GDK_PIXBUF_MODULEDIR'] = args.moduledir.as_posix()
++        with args.cache_file.open('w', encoding='utf-8') as f:
+             subprocess.run(
+-                [Path(args.gdk_pixbuf_queryloaders).as_posix()],
++                [args.queryloaders.as_posix()],
+                 env=env,
+                 stdout=f,
+                 check=True
+             )
+-
+-- 
+2.43.0
 
-gdk-pixbuf-loader: fix install logic in cross builds
+
+From 85e11b2c1c6b2a27949a0e3e883c01e4b48060e0 Mon Sep 17 00:00:00 2001
+From: Ross Burton <ross.burton@arm.com>
+Date: Mon, 11 May 2026 12:46:08 +0100
+Subject: [PATCH 2/2] gdk-pixbuf-loader: fix install logic in cross builds
 
 The logic in this install rule was getting complicated, but it should be
 quite simple really:
@@ -40,26 +119,30 @@ depending on whether query-loaders was found or not.
 
 This fixes the case where Meson can run host executables, but the target
 sysroot does not actually contain gdk-pixbuf-query-loaders.
+---
+ gdk-pixbuf-loader/meson.build | 28 +++++++++++++---------------
+ 1 file changed, 13 insertions(+), 15 deletions(-)
 
-Upstream-Status: Pending
-Signed-off-by: Ross Burton <ross.burton@arm.com>
-
-diff --git i/gdk-pixbuf-loader/meson.build w/gdk-pixbuf-loader/meson.build
-index 6fa10a68b..4f88ba037 100644
---- i/gdk-pixbuf-loader/meson.build
-+++ w/gdk-pixbuf-loader/meson.build
-@@ -37,19 +37,21 @@ pixbuf_thumbnailer = configure_file(
+diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
+index c7c017978..4f88ba037 100644
+--- a/gdk-pixbuf-loader/meson.build
++++ b/gdk-pixbuf-loader/meson.build
+@@ -37,23 +37,21 @@ pixbuf_thumbnailer = configure_file(
  )
  
  if meson.can_run_host_binaries()
--  gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'))
+-  gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders')).path()
+-else
+-  gdk_pixbuf_query_loaders = pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', pkgconfig_define: ['prefix', prefix])
 +  gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'), required: not meson.is_cross_build())
  endif
  
 -pixbufloader_svg_install_args = [
--  '--gdk-pixbuf-moduledir',
+-  '--moduledir',
 -  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_define: ['prefix', prefix]),
--  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', pkgconfig_define: ['prefix', prefix]),
+-  '--queryloaders',
+-  gdk_pixbuf_query_loaders,
+-  '--cache-file',
 -  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_cache_file', pkgconfig_define: ['prefix', prefix])
 -]
 -
@@ -81,48 +164,6 @@ index 6fa10a68b..4f88ba037 100644
  endif
  
  meson.add_install_script(
-diff --git i/gdk-pixbuf-loader/meson_install.py w/gdk-pixbuf-loader/meson_install.py
-index ff003350f..d9bbbe433 100644
---- i/gdk-pixbuf-loader/meson_install.py
-+++ w/gdk-pixbuf-loader/meson_install.py
-@@ -6,29 +6,28 @@ import os
- import subprocess
- import sys
- 
--argparse = ArgumentParser('Deploy loaders.cache')
--
--argparse.add_argument('--gdk-pixbuf-moduledir', type=Path)
--argparse.add_argument('gdk_pixbuf_queryloaders', type=Path)
--argparse.add_argument('gdk_pixbuf_cache_file', type=Path)
--argparse.add_argument('--show-cross-message', action='store_true')
--
- if __name__ == '__main__':
-+    argparse = ArgumentParser(description='Deploy loaders.cache. Pass required paths, or --show-cross-message.')
-+    argparse.add_argument('--queryloaders', type=Path, metavar="PATH", help="gdk-pixbuf-queryloaders to run")
-+    argparse.add_argument('--moduledir', type=Path, metavar="PATH", help="installed gdk-pixbuf module directory")
-+    argparse.add_argument('--cache-file', type=Path, metavar="PATH", help="module cache file to write")
-+    argparse.add_argument('--show-cross-message', action='store_true', help="tell the user to run query-loaders manually")
-     args = argparse.parse_args()
- 
--    cache_file: Path = args.gdk_pixbuf_cache_file
-+    if not(args.show_cross_message or (args.queryloaders and args.moduledir and args.cache_file)):
-+        argparse.print_help()
-+        sys.exit(1)
- 
-     if args.show_cross_message or os.environ.get("DESTDIR"):
-         print('*** Note: Please run gdk-pixbuf-queryloaders manually ' +
-               'against the newly-built gdkpixbuf-svg loader', file=sys.stderr)
-     else:
-         env = os.environ.copy()
--        env['GDK_PIXBUF_MODULEDIR'] = Path(args.gdk_pixbuf_moduledir).as_posix()
--        with cache_file.open('w', encoding='utf-8') as f:
-+        env['GDK_PIXBUF_MODULEDIR'] = args.moduledir.as_posix()
-+        with args.cache_file.open('w', encoding='utf-8') as f:
-             subprocess.run(
--                [Path(args.gdk_pixbuf_queryloaders).as_posix()],
-+                [args.queryloaders.as_posix()],
-                 env=env,
-                 stdout=f,
-                 check=True
-             )
--
+-- 
+2.43.0
+
diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.62.2.bb
similarity index 98%
rename from recipes-gnome/librsvg/librsvg_2.61.3.bb
rename to recipes-gnome/librsvg/librsvg_2.62.2.bb
index 19ceb69..c9bba2b 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.62.2.bb
@@ -27,7 +27,7 @@ SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
             file://cross-query-loaders.patch \
             file://run-ptest"
-SRC_URI[archive.sha256sum] = "a56d2c80d744ad2f2718f85df466fe71d24ff1f9bc3e5ef588bde4d7e87815f2"
+SRC_URI[archive.sha256sum] = "c0c1367e381e1ae4842a78f1b57c656ff19b25637e3a6527cb44ae5a1cc68d65"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.55.0


