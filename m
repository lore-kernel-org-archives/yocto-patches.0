Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C94CC02195
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:28 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web10.19468.1738174159057317070
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Mt9KduZD;
 spf=pass (domain: konsulko.com, ip: 209.85.166.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso16132105ab.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174158; x=1738778958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUib8dztQ9zPTKQJeHmix/XQQlLXb+hSmNfY9eYLHg0=;
        b=Mt9KduZDLQ15Jk6kClz+yPcc7X0fFmWsCPRrP0jCIcRPLlhaI+O7KcrG8iKv7hLQC/
         RvlltpGpt/cL3wCaiEpSOUapiiv2RuE7VZjiJbWXzd2Dg28yIzJPXWnSHlbar9C+qNFW
         FilRhOczfh9NjSq+ZGwkLN8dIQU8h3JuwsUes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174158; x=1738778958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUib8dztQ9zPTKQJeHmix/XQQlLXb+hSmNfY9eYLHg0=;
        b=Mcrvh3Mm47zcdbkgNLEE0crlOsAVCjLfTSSREXY+hoHtRfABgA3i99evOU/0I+IBEz
         9uqHHeBkk8+G8nvQUCLBG996iLMnDTB2+KnsM3fjR129a4DKCgMiTMCQy2lLkeFrOHV1
         nTgP9jqOQO4DoGqAiuZ5mkM1jpjAH0bt8M+T0jiKZV61xtLxLN7k3JIBCWwQfZ8gryVV
         I0xFEwG94WbptU4x/QAkqnbduXbs38CPplS6k5q2UwXlp7uilPcpssOi89T+mCMk0Jh+
         Fa6eUig9/An4HzPruWmwYh+DFobaYxBae9+wLxYGAAbAyLR/yXQc0yKZ+hHnWEg5xdi6
         cQ0g==
X-Gm-Message-State: AOJu0YzuGDDBJGp7lmgKO9CFm3/QuXm2L7+S1NQ4sItdN/GPFGbpiXvm
	sBMtQYZFsTcZTxpB4vJ6Doj5p8bPLTY7eSoRDx9LRWyWaR0x33wJsuGjcinWI+irY/OWI0/Q0RA
	w
X-Gm-Gg: ASbGncvwWgjMCjM7MjVJvhxznlvPJIWo/8umA2LHdbV0giZNltYhx3ZVSxzb2/yYFnq
	dbWhsdxQEwrcmLt3kiTBEjvmTyZPvg2RhqhLJCWyvkZgJR8UDfcRgd0xJhzUjeymbu8PiTY7N3l
	QAdmexPSzUcJdNUCqUrAa7Y0wpGAs8jMyaDehbH+Jd1w/z+VhKtXDxveH+SKHC+K3BMprPv/jP2
	ksBf7XU8i0u8rnO7gerCaGP8v4MNMCtwY8igoamx8ffna8+AyIGdJR8TWRe+7WAkRxY+WfCvhwz
	4XNtjp3oodzXDvFzoaBYY0Nni8omBwgLhZWPRYcJwXDj92orgi/dbO7v1wGxeoU79J92b648eH5
	X8Q==
X-Google-Smtp-Source: AGHT+IHOR63saF09LJ0t3gVeVHeBwGxYcPm5mPKSDtNH4GiQDp1SXB5nFxnZTlwFdq5DWrUIHyfMSw==
X-Received: by 2002:a92:c56f:0:b0:3cf:cc08:6165 with SMTP id e9e14a558f8ab-3cffe3bd21dmr39332985ab.12.1738174157207;
        Wed, 29 Jan 2025 10:09:17 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 4/9] librsvg: update 2.58.2 -> 2.59.2
Date: Wed, 29 Jan 2025 13:08:55 -0500
Message-ID: <834e12521bd93e14ba305462c39ba5ebd96710f5.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1017

From: Alexander Kanavin <alex@linutronix.de>

Upstream has moved from autotools to meson, which requires a substantial
amount of tweaks to the recipe.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit ae4824f4f6234884a245bce314d6305ad8eb982d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 682 +++++++++---------
 ...-rust-target-to-cargo-also-when-not-.patch |  44 --
 ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 +
 ...ot-force-disable-introspection-and-v.patch |  34 +
 .../librsvg/disable-rsvg-loader-test.patch    |  40 -
 .../{librsvg_2.58.2.bb =3D> librsvg_2.59.2.bb}  |  38 +-
 6 files changed, 439 insertions(+), 427 deletions(-)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rus=
t-target-to-cargo-also-when-not-.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-me=
son.build-do-not-look-for-gdk-pi.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-f=
orce-disable-introspection-and-v.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.=
patch
 rename recipes-gnome/librsvg/{librsvg_2.58.2.bb =3D> librsvg_2.59.2.bb} (6=
7%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librs=
vg/librsvg-crates.inc
index 0ab8076..54cd1c6 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -3,76 +3,84 @@
 # from Cargo.lock
 SRC_URI +=3D " \
     crate://crates.io/adler/1.0.2 \
-    crate://crates.io/aho-corasick/1.1.2 \
+    crate://crates.io/ahash/0.8.11 \
+    crate://crates.io/aho-corasick/1.1.3 \
     crate://crates.io/android-tzdata/0.1.1 \
     crate://crates.io/android_system_properties/0.1.5 \
     crate://crates.io/anes/0.1.6 \
-    crate://crates.io/anstream/0.6.11 \
-    crate://crates.io/anstyle/1.0.6 \
-    crate://crates.io/anstyle-parse/0.2.3 \
-    crate://crates.io/anstyle-query/1.0.2 \
-    crate://crates.io/anstyle-wincon/3.0.2 \
-    crate://crates.io/anyhow/1.0.79 \
+    crate://crates.io/anstream/0.6.15 \
+    crate://crates.io/anstyle/1.0.8 \
+    crate://crates.io/anstyle-parse/0.2.5 \
+    crate://crates.io/anstyle-query/1.1.1 \
+    crate://crates.io/anstyle-wincon/3.0.4 \
+    crate://crates.io/anyhow/1.0.86 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.0.13 \
-    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/assert_cmd/2.0.15 \
+    crate://crates.io/autocfg/1.3.0 \
+    crate://crates.io/av-data/0.4.2 \
     crate://crates.io/bit-set/0.5.3 \
     crate://crates.io/bit-vec/0.6.3 \
-    crate://crates.io/bit_field/0.10.2 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.4.2 \
+    crate://crates.io/bitflags/2.6.0 \
+    crate://crates.io/bitreader/0.3.8 \
     crate://crates.io/block/0.1.6 \
-    crate://crates.io/bstr/1.9.0 \
-    crate://crates.io/bumpalo/3.14.0 \
-    crate://crates.io/bytemuck/1.14.2 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/bstr/1.10.0 \
+    crate://crates.io/bumpalo/3.16.0 \
+    crate://crates.io/byte-slice-cast/1.2.2 \
+    crate://crates.io/bytemuck/1.16.3 \
     crate://crates.io/byteorder/1.5.0 \
-    crate://crates.io/cairo-rs/0.19.1 \
-    crate://crates.io/cairo-sys-rs/0.19.1 \
+    crate://crates.io/byteorder-lite/0.1.0 \
+    crate://crates.io/bytes/1.7.1 \
+    crate://crates.io/cairo-rs/0.20.0 \
+    crate://crates.io/cairo-sys-rs/0.20.0 \
     crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cc/1.0.83 \
-    crate://crates.io/cfg-expr/0.15.6 \
+    crate://crates.io/cc/1.1.8 \
+    crate://crates.io/cfg-expr/0.15.8 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/chrono/0.4.33 \
+    crate://crates.io/chrono/0.4.38 \
     crate://crates.io/ciborium/0.2.2 \
     crate://crates.io/ciborium-io/0.2.2 \
     crate://crates.io/ciborium-ll/0.2.2 \
-    crate://crates.io/clap/4.4.18 \
-    crate://crates.io/clap_builder/4.4.18 \
-    crate://crates.io/clap_complete/4.4.10 \
-    crate://crates.io/clap_derive/4.4.7 \
-    crate://crates.io/clap_lex/0.6.0 \
+    crate://crates.io/clap/4.5.13 \
+    crate://crates.io/clap_builder/4.5.13 \
+    crate://crates.io/clap_complete/4.5.12 \
+    crate://crates.io/clap_derive/4.5.13 \
+    crate://crates.io/clap_lex/0.7.2 \
     crate://crates.io/color_quant/1.1.0 \
-    crate://crates.io/colorchoice/1.0.0 \
-    crate://crates.io/const-cstr/0.3.0 \
+    crate://crates.io/colorchoice/1.0.2 \
     crate://crates.io/core-foundation-sys/0.8.6 \
-    crate://crates.io/crc32fast/1.3.2 \
+    crate://crates.io/crc32fast/1.4.2 \
     crate://crates.io/criterion/0.5.1 \
     crate://crates.io/criterion-plot/0.5.0 \
     crate://crates.io/crossbeam-deque/0.8.5 \
     crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-utils/0.8.19 \
+    crate://crates.io/crossbeam-utils/0.8.20 \
     crate://crates.io/crunchy/0.2.2 \
+    crate://crates.io/crypto-common/0.1.6 \
     crate://crates.io/cssparser/0.31.2 \
     crate://crates.io/cssparser-macros/0.6.1 \
-    crate://crates.io/cstr/0.2.11 \
     crate://crates.io/data-url/0.3.1 \
+    crate://crates.io/dav1d/0.10.3 \
+    crate://crates.io/dav1d-sys/0.8.2 \
+    crate://crates.io/dcv-color-primitives/0.6.1 \
     crate://crates.io/deranged/0.3.11 \
-    crate://crates.io/derive_more/0.99.17 \
+    crate://crates.io/derive_more/0.99.18 \
     crate://crates.io/difflib/0.4.0 \
+    crate://crates.io/digest/0.10.7 \
     crate://crates.io/dlib/0.5.2 \
     crate://crates.io/doc-comment/0.3.3 \
     crate://crates.io/dtoa/1.0.9 \
-    crate://crates.io/dtoa-short/0.3.4 \
-    crate://crates.io/either/1.9.0 \
-    crate://crates.io/encoding_rs/0.8.33 \
+    crate://crates.io/dtoa-short/0.3.5 \
+    crate://crates.io/either/1.13.0 \
+    crate://crates.io/encoding_rs/0.8.34 \
     crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/errno/0.3.8 \
-    crate://crates.io/exr/1.72.0 \
-    crate://crates.io/fastrand/2.0.1 \
+    crate://crates.io/errno/0.3.9 \
+    crate://crates.io/fallible_collections/0.4.9 \
+    crate://crates.io/fastrand/2.1.0 \
     crate://crates.io/fdeflate/0.3.4 \
-    crate://crates.io/flate2/1.0.28 \
+    crate://crates.io/flate2/1.0.31 \
     crate://crates.io/float-cmp/0.9.0 \
-    crate://crates.io/flume/0.11.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.1 \
     crate://crates.io/futf/0.1.5 \
@@ -84,278 +92,289 @@ SRC_URI +=3D " \
     crate://crates.io/futures-task/0.3.30 \
     crate://crates.io/futures-util/0.3.30 \
     crate://crates.io/fxhash/0.2.1 \
-    crate://crates.io/gdk-pixbuf/0.19.0 \
-    crate://crates.io/gdk-pixbuf-sys/0.19.0 \
-    crate://crates.io/getrandom/0.2.12 \
-    crate://crates.io/gif/0.12.0 \
-    crate://crates.io/gio/0.19.0 \
-    crate://crates.io/gio-sys/0.19.0 \
-    crate://crates.io/glib/0.19.0 \
-    crate://crates.io/glib-macros/0.19.0 \
-    crate://crates.io/glib-sys/0.19.0 \
-    crate://crates.io/gobject-sys/0.19.0 \
-    crate://crates.io/half/2.3.1 \
-    crate://crates.io/hashbrown/0.14.3 \
-    crate://crates.io/heck/0.4.1 \
-    crate://crates.io/hermit-abi/0.3.5 \
+    crate://crates.io/gdk-pixbuf/0.20.0 \
+    crate://crates.io/gdk-pixbuf-sys/0.20.0 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/getrandom/0.2.15 \
+    crate://crates.io/gif/0.13.1 \
+    crate://crates.io/gio/0.20.0 \
+    crate://crates.io/gio-sys/0.20.0 \
+    crate://crates.io/glib/0.20.0 \
+    crate://crates.io/glib-macros/0.20.0 \
+    crate://crates.io/glib-sys/0.20.0 \
+    crate://crates.io/gobject-sys/0.20.0 \
+    crate://crates.io/half/2.4.1 \
+    crate://crates.io/hashbrown/0.13.2 \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hermit-abi/0.3.9 \
     crate://crates.io/iana-time-zone/0.1.60 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
     crate://crates.io/idna/0.5.0 \
-    crate://crates.io/image/0.24.8 \
-    crate://crates.io/indexmap/2.2.2 \
-    crate://crates.io/is-terminal/0.4.10 \
+    crate://crates.io/image/0.25.2 \
+    crate://crates.io/image-webp/0.1.3 \
+    crate://crates.io/indexmap/2.3.0 \
+    crate://crates.io/is-terminal/0.4.12 \
+    crate://crates.io/is_terminal_polyfill/1.70.1 \
     crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itertools/0.12.1 \
-    crate://crates.io/itoa/1.0.10 \
-    crate://crates.io/jpeg-decoder/0.3.1 \
-    crate://crates.io/js-sys/0.3.68 \
+    crate://crates.io/itertools/0.13.0 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/js-sys/0.3.69 \
     crate://crates.io/language-tags/0.3.2 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/lebe/0.5.2 \
-    crate://crates.io/libc/0.2.153 \
-    crate://crates.io/libloading/0.8.1 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/libc/0.2.155 \
+    crate://crates.io/libloading/0.8.5 \
     crate://crates.io/libm/0.2.8 \
     crate://crates.io/linked-hash-map/0.5.6 \
-    crate://crates.io/linux-raw-sys/0.4.13 \
+    crate://crates.io/linux-raw-sys/0.4.14 \
     crate://crates.io/locale_config/0.3.0 \
-    crate://crates.io/lock_api/0.4.11 \
-    crate://crates.io/log/0.4.20 \
-    crate://crates.io/lopdf/0.32.0 \
+    crate://crates.io/lock_api/0.4.12 \
+    crate://crates.io/log/0.4.22 \
+    crate://crates.io/lopdf/0.33.0 \
     crate://crates.io/mac/0.1.1 \
     crate://crates.io/malloc_buf/0.0.6 \
-    crate://crates.io/markup5ever/0.11.0 \
+    crate://crates.io/markup5ever/0.12.1 \
     crate://crates.io/matches/0.1.10 \
-    crate://crates.io/matrixmultiply/0.3.8 \
-    crate://crates.io/md5/0.7.0 \
-    crate://crates.io/memchr/2.7.1 \
+    crate://crates.io/matrixmultiply/0.3.9 \
+    crate://crates.io/md-5/0.10.6 \
+    crate://crates.io/memchr/2.7.4 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.7.2 \
-    crate://crates.io/nalgebra/0.32.3 \
-    crate://crates.io/nalgebra-macros/0.2.1 \
-    crate://crates.io/new_debug_unreachable/1.0.4 \
+    crate://crates.io/miniz_oxide/0.7.4 \
+    crate://crates.io/mp4parse/0.17.0 \
+    crate://crates.io/nalgebra/0.33.0 \
+    crate://crates.io/nalgebra-macros/0.2.2 \
+    crate://crates.io/new_debug_unreachable/1.0.6 \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normalize-line-endings/0.3.0 \
-    crate://crates.io/num-complex/0.4.5 \
+    crate://crates.io/num-bigint/0.4.6 \
+    crate://crates.io/num-complex/0.4.6 \
     crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-derive/0.4.2 \
     crate://crates.io/num-integer/0.1.46 \
-    crate://crates.io/num-rational/0.4.1 \
-    crate://crates.io/num-traits/0.2.18 \
+    crate://crates.io/num-rational/0.4.2 \
+    crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/objc/0.2.7 \
     crate://crates.io/objc-foundation/0.1.1 \
     crate://crates.io/objc_id/0.1.1 \
     crate://crates.io/once_cell/1.19.0 \
-    crate://crates.io/oorandom/11.1.3 \
-    crate://crates.io/pango/0.19.0 \
-    crate://crates.io/pango-sys/0.19.0 \
-    crate://crates.io/pangocairo/0.19.1 \
-    crate://crates.io/pangocairo-sys/0.19.0 \
-    crate://crates.io/parking_lot/0.12.1 \
-    crate://crates.io/parking_lot_core/0.9.9 \
-    crate://crates.io/paste/1.0.14 \
+    crate://crates.io/oorandom/11.1.4 \
+    crate://crates.io/pango/0.20.0 \
+    crate://crates.io/pango-sys/0.20.0 \
+    crate://crates.io/pangocairo/0.20.0 \
+    crate://crates.io/pangocairo-sys/0.20.0 \
+    crate://crates.io/parking_lot/0.12.3 \
+    crate://crates.io/parking_lot_core/0.9.10 \
+    crate://crates.io/paste/1.0.15 \
     crate://crates.io/percent-encoding/2.3.1 \
     crate://crates.io/phf/0.10.1 \
     crate://crates.io/phf/0.11.2 \
     crate://crates.io/phf_codegen/0.10.0 \
+    crate://crates.io/phf_codegen/0.11.2 \
     crate://crates.io/phf_generator/0.10.0 \
     crate://crates.io/phf_generator/0.11.2 \
     crate://crates.io/phf_macros/0.11.2 \
     crate://crates.io/phf_shared/0.10.0 \
     crate://crates.io/phf_shared/0.11.2 \
-    crate://crates.io/pin-project-lite/0.2.13 \
+    crate://crates.io/pin-project-lite/0.2.14 \
     crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/pkg-config/0.3.29 \
-    crate://crates.io/plotters/0.3.5 \
-    crate://crates.io/plotters-backend/0.3.5 \
-    crate://crates.io/plotters-svg/0.3.5 \
-    crate://crates.io/png/0.17.11 \
+    crate://crates.io/pkg-config/0.3.30 \
+    crate://crates.io/plotters/0.3.6 \
+    crate://crates.io/plotters-backend/0.3.6 \
+    crate://crates.io/plotters-svg/0.3.6 \
+    crate://crates.io/png/0.17.13 \
     crate://crates.io/powerfmt/0.2.0 \
-    crate://crates.io/ppv-lite86/0.2.17 \
+    crate://crates.io/ppv-lite86/0.2.20 \
     crate://crates.io/precomputed-hash/0.1.1 \
-    crate://crates.io/predicates/3.1.0 \
-    crate://crates.io/predicates-core/1.0.6 \
-    crate://crates.io/predicates-tree/1.0.9 \
+    crate://crates.io/predicates/3.1.2 \
+    crate://crates.io/predicates-core/1.0.8 \
+    crate://crates.io/predicates-tree/1.0.11 \
     crate://crates.io/proc-macro-crate/3.1.0 \
-    crate://crates.io/proc-macro2/1.0.78 \
-    crate://crates.io/proptest/1.4.0 \
-    crate://crates.io/qoi/0.4.1 \
+    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/proptest/1.5.0 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/quote/1.0.35 \
+    crate://crates.io/quote/1.0.36 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_xorshift/0.3.0 \
     crate://crates.io/rawpointer/0.2.1 \
-    crate://crates.io/rayon/1.8.1 \
+    crate://crates.io/rayon/1.10.0 \
     crate://crates.io/rayon-core/1.12.1 \
     crate://crates.io/rctree/0.6.0 \
-    crate://crates.io/redox_syscall/0.4.1 \
-    crate://crates.io/regex/1.10.3 \
-    crate://crates.io/regex-automata/0.4.5 \
-    crate://crates.io/regex-syntax/0.8.2 \
-    crate://crates.io/rgb/0.8.37 \
-    crate://crates.io/rustix/0.38.31 \
+    crate://crates.io/redox_syscall/0.5.3 \
+    crate://crates.io/regex/1.10.6 \
+    crate://crates.io/regex-automata/0.4.7 \
+    crate://crates.io/regex-syntax/0.8.4 \
+    crate://crates.io/rgb/0.8.48 \
+    crate://crates.io/rustix/0.38.34 \
     crate://crates.io/rusty-fork/0.3.0 \
-    crate://crates.io/ryu/1.0.16 \
-    crate://crates.io/safe_arch/0.7.1 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/safe_arch/0.7.2 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/selectors/0.25.0 \
-    crate://crates.io/serde/1.0.196 \
-    crate://crates.io/serde_derive/1.0.196 \
-    crate://crates.io/serde_json/1.0.113 \
-    crate://crates.io/serde_spanned/0.6.5 \
+    crate://crates.io/serde/1.0.204 \
+    crate://crates.io/serde_derive/1.0.204 \
+    crate://crates.io/serde_json/1.0.122 \
+    crate://crates.io/serde_spanned/0.6.7 \
     crate://crates.io/servo_arc/0.3.0 \
-    crate://crates.io/simba/0.8.1 \
+    crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/simba/0.9.0 \
     crate://crates.io/simd-adler32/0.3.7 \
     crate://crates.io/siphasher/0.3.11 \
     crate://crates.io/slab/0.4.9 \
-    crate://crates.io/smallvec/1.13.1 \
-    crate://crates.io/spin/0.9.8 \
+    crate://crates.io/smallvec/1.13.2 \
     crate://crates.io/stable_deref_trait/1.2.0 \
+    crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/string_cache/0.8.7 \
     crate://crates.io/string_cache_codegen/0.5.2 \
-    crate://crates.io/strsim/0.10.0 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.48 \
-    crate://crates.io/system-deps/6.2.0 \
-    crate://crates.io/target-lexicon/0.12.13 \
-    crate://crates.io/tempfile/3.10.0 \
+    crate://crates.io/strsim/0.11.1 \
+    crate://crates.io/syn/2.0.72 \
+    crate://crates.io/system-deps/6.2.2 \
+    crate://crates.io/system-deps/7.0.1 \
+    crate://crates.io/target-lexicon/0.12.16 \
+    crate://crates.io/tempfile/3.12.0 \
     crate://crates.io/tendril/0.4.3 \
     crate://crates.io/termtree/0.4.1 \
-    crate://crates.io/thiserror/1.0.56 \
-    crate://crates.io/thiserror-impl/1.0.56 \
-    crate://crates.io/tiff/0.9.1 \
-    crate://crates.io/time/0.3.34 \
+    crate://crates.io/thiserror/1.0.63 \
+    crate://crates.io/thiserror-impl/1.0.63 \
+    crate://crates.io/time/0.3.36 \
     crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.17 \
+    crate://crates.io/time-macros/0.2.18 \
     crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/tinyvec/1.6.0 \
+    crate://crates.io/tinyvec/1.8.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.8.10 \
-    crate://crates.io/toml_datetime/0.6.5 \
+    crate://crates.io/toml/0.8.19 \
+    crate://crates.io/toml_datetime/0.6.8 \
     crate://crates.io/toml_edit/0.21.1 \
-    crate://crates.io/toml_edit/0.22.4 \
+    crate://crates.io/toml_edit/0.22.20 \
     crate://crates.io/typenum/1.17.0 \
     crate://crates.io/unarray/0.1.4 \
     crate://crates.io/unicode-bidi/0.3.15 \
     crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-normalization/0.1.22 \
-    crate://crates.io/url/2.5.0 \
+    crate://crates.io/unicode-normalization/0.1.23 \
+    crate://crates.io/url/2.5.2 \
     crate://crates.io/utf-8/0.7.6 \
-    crate://crates.io/utf8parse/0.2.1 \
-    crate://crates.io/version-compare/0.1.1 \
+    crate://crates.io/utf8parse/0.2.2 \
+    crate://crates.io/version-compare/0.2.0 \
+    crate://crates.io/version_check/0.9.5 \
     crate://crates.io/wait-timeout/0.2.0 \
-    crate://crates.io/walkdir/2.4.0 \
+    crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.91 \
-    crate://crates.io/wasm-bindgen-backend/0.2.91 \
-    crate://crates.io/wasm-bindgen-macro/0.2.91 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.91 \
-    crate://crates.io/wasm-bindgen-shared/0.2.91 \
-    crate://crates.io/web-sys/0.3.68 \
+    crate://crates.io/wasm-bindgen/0.2.92 \
+    crate://crates.io/wasm-bindgen-backend/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
+    crate://crates.io/wasm-bindgen-shared/0.2.92 \
+    crate://crates.io/web-sys/0.3.69 \
     crate://crates.io/weezl/0.1.8 \
-    crate://crates.io/wide/0.7.15 \
+    crate://crates.io/wide/0.7.26 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.6 \
+    crate://crates.io/winapi-util/0.1.9 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
     crate://crates.io/windows-core/0.52.0 \
-    crate://crates.io/windows-sys/0.48.0 \
     crate://crates.io/windows-sys/0.52.0 \
-    crate://crates.io/windows-targets/0.48.5 \
-    crate://crates.io/windows-targets/0.52.0 \
-    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.0 \
-    crate://crates.io/windows_aarch64_msvc/0.48.5 \
-    crate://crates.io/windows_aarch64_msvc/0.52.0 \
-    crate://crates.io/windows_i686_gnu/0.48.5 \
-    crate://crates.io/windows_i686_gnu/0.52.0 \
-    crate://crates.io/windows_i686_msvc/0.48.5 \
-    crate://crates.io/windows_i686_msvc/0.52.0 \
-    crate://crates.io/windows_x86_64_gnu/0.48.5 \
-    crate://crates.io/windows_x86_64_gnu/0.52.0 \
-    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.0 \
-    crate://crates.io/windows_x86_64_msvc/0.48.5 \
-    crate://crates.io/windows_x86_64_msvc/0.52.0 \
-    crate://crates.io/winnow/0.5.39 \
-    crate://crates.io/xml5ever/0.17.0 \
-    crate://crates.io/yeslogic-fontconfig-sys/4.0.1 \
-    crate://crates.io/zune-inflate/0.2.54 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/0.5.40 \
+    crate://crates.io/winnow/0.6.18 \
+    crate://crates.io/xml5ever/0.18.1 \
+    crate://crates.io/yeslogic-fontconfig-sys/6.0.0 \
+    crate://crates.io/zerocopy/0.7.35 \
+    crate://crates.io/zerocopy-derive/0.7.35 \
+    crate://crates.io/zune-core/0.4.12 \
+    crate://crates.io/zune-jpeg/0.4.13 \
 "
=20
 SRC_URI[adler-1.0.2.sha256sum] =3D "f26201604c87b1e01bd3d98f8d5d9a8fcbb815=
e8cedb41ffccbeb4bf593a35fe"
-SRC_URI[aho-corasick-1.1.2.sha256sum] =3D "b2969dcb958b36655471fc61f7e416f=
a76033bdd4bfed0678d8fee1e2d07a1f0"
+SRC_URI[ahash-0.8.11.sha256sum] =3D "e89da841a80418a9b391ebaea17f5c112ffaa=
a96f621d2c285b5174da76b9011"
+SRC_URI[aho-corasick-1.1.3.sha256sum] =3D "8e60d3430d3a69478ad0993f19238d2=
df97c507009a52b3c10addcd7f6bcb916"
 SRC_URI[android-tzdata-0.1.1.sha256sum] =3D "e999941b234f3131b00bc13c22d06=
e8c5ff726d1b6318ac7eb276997bbb4fef0"
 SRC_URI[android_system_properties-0.1.5.sha256sum] =3D "819e7219dbd41043ac=
279b19830f2efc897156490d7fd6ea916720117ee66311"
 SRC_URI[anes-0.1.6.sha256sum] =3D "4b46cbb362ab8752921c97e041f5e366ee6297b=
d428a31275b9fcf1e380f7299"
-SRC_URI[anstream-0.6.11.sha256sum] =3D "6e2e1ebcb11de5c03c67de28a7df593d32=
191b44939c482e97702baaaa6ab6a5"
-SRC_URI[anstyle-1.0.6.sha256sum] =3D "8901269c6307e8d93993578286ac0edf7f19=
5079ffff5ebdeea6a59ffb7e36bc"
-SRC_URI[anstyle-parse-0.2.3.sha256sum] =3D "c75ac65da39e5fe5ab759307499dda=
d880d724eed2f6ce5b5e8a26f4f387928c"
-SRC_URI[anstyle-query-1.0.2.sha256sum] =3D "e28923312444cdd728e4738b3f9c9c=
ac739500909bb3d3c94b43551b16517648"
-SRC_URI[anstyle-wincon-3.0.2.sha256sum] =3D "1cd54b81ec8d6180e24654d0b371a=
d22fc3dd083b6ff8ba325b72e00c87660a7"
-SRC_URI[anyhow-1.0.79.sha256sum] =3D "080e9890a082662b09c1ad45f567faeeb47f=
22b5fb23895fbe1e651e718e25ca"
+SRC_URI[anstream-0.6.15.sha256sum] =3D "64e15c1ab1f89faffbf04a634d5e1962e9=
074f2741eef6d97f3c4e322426d526"
+SRC_URI[anstyle-1.0.8.sha256sum] =3D "1bec1de6f59aedf83baf9ff929c98f2ad654=
b97c9510f4e70cf6f661d49fd5b1"
+SRC_URI[anstyle-parse-0.2.5.sha256sum] =3D "eb47de1e80c2b463c735db5b217a0d=
dc39d612e7ac9e2e96a5aed1f57616c1cb"
+SRC_URI[anstyle-query-1.1.1.sha256sum] =3D "6d36fc52c7f6c869915e99412912f2=
2093507da8d9e942ceaf66fe4b7c14422a"
+SRC_URI[anstyle-wincon-3.0.4.sha256sum] =3D "5bf74e1b6e971609db8ca7a9ce79f=
d5768ab6ae46441c572e46cf596f59e57f8"
+SRC_URI[anyhow-1.0.86.sha256sum] =3D "b3d1d046238990b9cf5bcde22a3fb3584ee5=
cf65fb2765f454ed428c7a0063da"
 SRC_URI[approx-0.5.1.sha256sum] =3D "cab112f0a86d568ea0e627cc1d6be74a1e9cd=
55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.0.13.sha256sum] =3D "00ad3f3a942eee60335ab4342358c161=
ee296829e0d16ff42fc1d6cb07815467"
-SRC_URI[autocfg-1.1.0.sha256sum] =3D "d468802bab17cbc0cc575e9b053f41e72aa3=
6bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[assert_cmd-2.0.15.sha256sum] =3D "bc65048dd435533bb1baf2ed9956b9a2=
78fbfdcf90301b39ee117f06c0199d37"
+SRC_URI[autocfg-1.3.0.sha256sum] =3D "0c4b4d0bd25bd0b74681c0ad21497610ce1b=
7c91b1022cd21c80c6fbdd9476b0"
+SRC_URI[av-data-0.4.2.sha256sum] =3D "d75b98a3525d00f920df9a2d44cc99b9cc5b=
7dc70d7fbb612cd755270dbe6552"
 SRC_URI[bit-set-0.5.3.sha256sum] =3D "0700ddab506f33b20a03b13996eccd309a48=
e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] =3D "349f9b6a179ed607305526ca489b34ad0a41=
aed5f7980fa90eb03160b69598fb"
-SRC_URI[bit_field-0.10.2.sha256sum] =3D "dc827186963e592360843fb5ba4b973e1=
45841266c1357f7180c43526f2e5b61"
 SRC_URI[bitflags-1.3.2.sha256sum] =3D "bef38d45163c2f1dde094a7dfd33ccf595c=
92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.4.2.sha256sum] =3D "ed570934406eb16438a4e976b1b45007740=
99c13b8cb96eec99f620f05090ddf"
+SRC_URI[bitflags-2.6.0.sha256sum] =3D "b048fb63fd8b5923fc5aa7b340d8e156aec=
7ec02f0c78fa8a6ddc2613f6f71de"
+SRC_URI[bitreader-0.3.8.sha256sum] =3D "bdd859c9d97f7c468252795b35aeccc412=
bdbb1e90ee6969c4fa6328272eaeff"
 SRC_URI[block-0.1.6.sha256sum] =3D "0d8c1fef690941d3e7788d328517591fecc684=
c084084702d6ff1641e993699a"
-SRC_URI[bstr-1.9.0.sha256sum] =3D "c48f0051a4b4c5e0b6d365cd04af53aeaa209e3=
cc15ec2cdb69e73cc87fbd0dc"
-SRC_URI[bumpalo-3.14.0.sha256sum] =3D "7f30e7476521f6f8af1a1c4c0b8cc94f0be=
e37d91763d0ca2665f299b6cd8aec"
-SRC_URI[bytemuck-1.14.2.sha256sum] =3D "ea31d69bda4949c1c1562c1e6f042a1cae=
fac98cdc8a298260a2ff41c1e2d42b"
+SRC_URI[block-buffer-0.10.4.sha256sum] =3D "3078c7629b62d3f0439517fa394996=
acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[bstr-1.10.0.sha256sum] =3D "40723b8fb387abc38f4f4a37c09073622e41dd=
12327033091ef8950659e6dc0c"
+SRC_URI[bumpalo-3.16.0.sha256sum] =3D "79296716171880943b8470b5f8d03aa55eb=
2e645a4874bdbb28adb49162e012c"
+SRC_URI[byte-slice-cast-1.2.2.sha256sum] =3D "c3ac9f8b63eca6fd385229b3675f=
6cc0dc5c8a5c8a54a59d4f52ffd670d87b0c"
+SRC_URI[bytemuck-1.16.3.sha256sum] =3D "102087e286b4677862ea56cf8fc58bb2cd=
fa8725c40ffb80fe3a008eb7f2fc83"
 SRC_URI[byteorder-1.5.0.sha256sum] =3D "1fd0f2584146f6f2ef48085050886acf35=
3beff7305ebd1ae69500e27c67f64b"
-SRC_URI[cairo-rs-0.19.1.sha256sum] =3D "bc1c415b7088381c53c575420899c34c9e=
6312df5ac5defd05614210e9fd6e1b"
-SRC_URI[cairo-sys-rs-0.19.1.sha256sum] =3D "75b6a5fefce2eadb8333e3c604ac96=
4ba6573ec4f28bdd17f67032c4a2831831"
+SRC_URI[byteorder-lite-0.1.0.sha256sum] =3D "8f1fe948ff07f4bd06c30984e69f5=
b4899c516a3ef74f34df92a2df2ab535495"
+SRC_URI[bytes-1.7.1.sha256sum] =3D "8318a53db07bb3f8dca91a600466bdb3f2eaad=
eedfdbcf02e1accbad9271ba50"
+SRC_URI[cairo-rs-0.20.0.sha256sum] =3D "797fd5a634dcb0ad0d7d583df794deb0a2=
36d88e759cd34b7da20198c6c9d145"
+SRC_URI[cairo-sys-rs-0.20.0.sha256sum] =3D "428290f914b9b86089f60f5d8a9f6e=
440508e1bcff23b25afd51502b0a2da88f"
 SRC_URI[cast-0.3.0.sha256sum] =3D "37b2a672a2cb129a2e41c10b1224bb368f9f37a=
2b16b612598138befd7b37eb5"
-SRC_URI[cc-1.0.83.sha256sum] =3D "f1174fb0b6ec23863f8b971027804a42614e347e=
afb0a95bf0b12cdae21fc4d0"
-SRC_URI[cfg-expr-0.15.6.sha256sum] =3D "6100bc57b6209840798d95cb2775684849=
d332f7bd788db2a8c8caf7ef82a41a"
+SRC_URI[cc-1.1.8.sha256sum] =3D "504bdec147f2cc13c8b57ed9401fd8a147cc66b67=
ad5cb241394244f2c947549"
+SRC_URI[cfg-expr-0.15.8.sha256sum] =3D "d067ad48b8650848b989a59a86c6c36a99=
5d02d2bf778d45c3c5d57bc2718f02"
 SRC_URI[cfg-if-1.0.0.sha256sum] =3D "baf1de4339761588bc0619e3cbc0120ee582e=
bb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.33.sha256sum] =3D "9f13690e35a5e4ace198e7beea2895d29f3a=
9cc55015fcebe6336bd2010af9eb"
+SRC_URI[chrono-0.4.38.sha256sum] =3D "a21f936df1771bf62b77f047b726c4625ff2=
e8aa607c01ec06e5a05bd8463401"
 SRC_URI[ciborium-0.2.2.sha256sum] =3D "42e69ffd6f0917f5c029256a24d0161db17=
cea3997d185db0d35926308770f0e"
 SRC_URI[ciborium-io-0.2.2.sha256sum] =3D "05afea1e0a06c9be33d539b876f1ce36=
92f4afea2cb41f740e7743225ed1c757"
 SRC_URI[ciborium-ll-0.2.2.sha256sum] =3D "57663b653d948a338bfb3eeba9bb2fd5=
fcfaecb9e199e87e1eda4d9e8b240fd9"
-SRC_URI[clap-4.4.18.sha256sum] =3D "1e578d6ec4194633722ccf9544794b71b1385c=
3c027efe0c55db226fc880865c"
-SRC_URI[clap_builder-4.4.18.sha256sum] =3D "4df4df40ec50c46000231c91496827=
8b1eb05098cf8f1b3a518a95030e71d1c7"
-SRC_URI[clap_complete-4.4.10.sha256sum] =3D "abb745187d7f4d76267b37485a65e=
0149edd0e91a4cfcdd3f27524ad86cee9f3"
-SRC_URI[clap_derive-4.4.7.sha256sum] =3D "cf9804afaaf59a91e75b022a30fb7229=
a7901f60c755489cc61c9b423b836442"
-SRC_URI[clap_lex-0.6.0.sha256sum] =3D "702fc72eb24e5a1e48ce58027a675bc24ed=
d52096d5397d4aea7c6dd9eca0bd1"
+SRC_URI[clap-4.5.13.sha256sum] =3D "0fbb260a053428790f3de475e304ff84cdbc4f=
ace759ea7a3e64c1edd938a7fc"
+SRC_URI[clap_builder-4.5.13.sha256sum] =3D "64b17d7ea74e9f833c7dbf2cbe4fb1=
2ff26783eda4782a8975b72f895c9b4d99"
+SRC_URI[clap_complete-4.5.12.sha256sum] =3D "a8670053e87c316345e384ca1f3eb=
a3006fc6355ed8b8a1140d104e109e3df34"
+SRC_URI[clap_derive-4.5.13.sha256sum] =3D "501d359d5f3dcaf6ecdeee48833ae73=
ec6e42723a1e52419c79abf9507eec0a0"
+SRC_URI[clap_lex-0.7.2.sha256sum] =3D "1462739cb27611015575c0c11df5df76011=
41071f07518d56fcc1be504cbec97"
 SRC_URI[color_quant-1.1.0.sha256sum] =3D "3d7b894f5411737b7867f4827955924d=
7c254fc9f4d91a6aad6b097804b1018b"
-SRC_URI[colorchoice-1.0.0.sha256sum] =3D "acbf1af155f9b9ef647e42cdc158db4b=
64a1b61f743629225fde6f3e0be2a7c7"
-SRC_URI[const-cstr-0.3.0.sha256sum] =3D "ed3d0b5ff30645a68f35ece8cea4556ca=
14ef8a1651455f789a099a0513532a6"
+SRC_URI[colorchoice-1.0.2.sha256sum] =3D "d3fd119d74b830634cea2a0f58bbd0d5=
4540518a14397557951e79340abc28c0"
 SRC_URI[core-foundation-sys-0.8.6.sha256sum] =3D "06ea2b9bc92be3c2baa9334a=
323ebca2d6f074ff852cd1d7b11064035cd3868f"
-SRC_URI[crc32fast-1.3.2.sha256sum] =3D "b540bd8bc810d3885c6ea91e2018302f68=
baba2129ab3e88f32389ee9370880d"
+SRC_URI[crc32fast-1.4.2.sha256sum] =3D "a97769d94ddab943e4510d138150169a27=
58b5ef3eb191a9ee688de3e23ef7b3"
 SRC_URI[criterion-0.5.1.sha256sum] =3D "f2b12d017a929603d80db1831cd3a24082=
f8137ce19c69e6447f54f5fc8d692f"
 SRC_URI[criterion-plot-0.5.0.sha256sum] =3D "6b50826342786a51a89e2da3a28f1=
c32b06e387201bc2d19791f622c673706b1"
 SRC_URI[crossbeam-deque-0.8.5.sha256sum] =3D "613f8cc01fe9cf1a3eb3d7f488fd=
2fa8388403e97039e2f73692932e291a770d"
 SRC_URI[crossbeam-epoch-0.9.18.sha256sum] =3D "5b82ac4a3c2ca9c3460964f020e=
1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-utils-0.8.19.sha256sum] =3D "248e3bacc7dc6baa3b21e405ee0=
45c3047101a49145e7e9eca583ab4c2ca5345"
+SRC_URI[crossbeam-utils-0.8.20.sha256sum] =3D "22ec99545bb0ed0ea7bb9b8e1e9=
122ea386ff8a48c0922e43f36d45ab09e0e80"
 SRC_URI[crunchy-0.2.2.sha256sum] =3D "7a81dae078cea95a014a339291cec439d2f2=
32ebe854a9d672b796c6afafa9b7"
+SRC_URI[crypto-common-0.1.6.sha256sum] =3D "1bfb12502f3fc46cca1bb51ac28df9=
d618d813cdc3d2f25b9fe775a34af26bb3"
 SRC_URI[cssparser-0.31.2.sha256sum] =3D "5b3df4f93e5fbbe73ec01ec8d3f68bba7=
3107993a5b1e7519273c32db9b0d5be"
 SRC_URI[cssparser-macros-0.6.1.sha256sum] =3D "13b588ba4ac1a99f7f2964d24b3=
d896ddc6bf847ee3855dbd4366f058cfcd331"
-SRC_URI[cstr-0.2.11.sha256sum] =3D "8aa998c33a6d3271e3678950a22134cd7dd27c=
ef86dee1b611b5b14207d1d90b"
 SRC_URI[data-url-0.3.1.sha256sum] =3D "5c297a1c74b71ae29df00c3e22dd9534821=
d60eb9af5a0192823fa2acea70c2a"
+SRC_URI[dav1d-0.10.3.sha256sum] =3D "0d4b54a40baf633a71c6f0fb49494a7e4ee7b=
c26f3e727212b6cb915aa1ea1e1"
+SRC_URI[dav1d-sys-0.8.2.sha256sum] =3D "6ecb1c5e8f4dc438eedc1b534a54672fb0=
e0a56035dae6b50162787bd2c50e95"
+SRC_URI[dcv-color-primitives-0.6.1.sha256sum] =3D "07ad62edfed069700a5b33a=
f6babd29c498d7e33eb01d96ffa8841ee1841634c"
 SRC_URI[deranged-0.3.11.sha256sum] =3D "b42b6fa04a440b495c8b04d0e71b707c58=
5f83cb9cb28cf8cd0d976c315e31b4"
-SRC_URI[derive_more-0.99.17.sha256sum] =3D "4fb810d30a7c1953f91334de724473=
1fc3f3c10d7fe163338a35b9f640960321"
+SRC_URI[derive_more-0.99.18.sha256sum] =3D "5f33878137e4dafd7fa914ad4e259e=
18a4e8e532b9617a2d0150262bf53abfce"
 SRC_URI[difflib-0.4.0.sha256sum] =3D "6184e33543162437515c2e2b48714794e378=
45ec9851711914eec9d308f6ebe8"
+SRC_URI[digest-0.10.7.sha256sum] =3D "9ed9a281f7bc9b7576e61468ba615a66a5c8=
cfdff42420a70aa82701a3b1e292"
 SRC_URI[dlib-0.5.2.sha256sum] =3D "330c60081dcc4c72131f8eb70510f1ac07223e5=
d4163db481a04a0befcffa412"
 SRC_URI[doc-comment-0.3.3.sha256sum] =3D "fea41bba32d969b51399775273560505=
4bc0dfa92b4c56bf1189f2e174be7a10"
 SRC_URI[dtoa-1.0.9.sha256sum] =3D "dcbb2bf8e87535c23f7a8a321e364ce21462d0f=
f10cb6407820e8e96dfff6653"
-SRC_URI[dtoa-short-0.3.4.sha256sum] =3D "dbaceec3c6e4211c79e7b1800fb968052=
7106beb2f9c51904a3210c03a448c74"
-SRC_URI[either-1.9.0.sha256sum] =3D "a26ae43d7bcc3b814de94796a5e736d4029ef=
b0ee900c12e2d54c993ad1a1e07"
-SRC_URI[encoding_rs-0.8.33.sha256sum] =3D "7268b386296a025e474d5140678f75d=
6de9493ae55a5d709eeb9dd08149945e1"
+SRC_URI[dtoa-short-0.3.5.sha256sum] =3D "cd1511a7b6a56299bd043a9c167a6d2bf=
b37bf84a6dfceaba651168adfb43c87"
+SRC_URI[either-1.13.0.sha256sum] =3D "60b1af1c220855b6ceac025d3f6ecdd2b7c4=
894bfe9cd9bda4fbb4bc7c0d4cf0"
+SRC_URI[encoding_rs-0.8.34.sha256sum] =3D "b45de904aa0b010bce2ab45264d0631=
681847fa7b6f2eaa7dab7619943bc4f59"
 SRC_URI[equivalent-1.0.1.sha256sum] =3D "5443807d6dff69373d433ab9ef5378ad8=
df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[errno-0.3.8.sha256sum] =3D "a258e46cdc063eb8519c00b9fc845fc47bcfca=
4130e2f08e88665ceda8474245"
-SRC_URI[exr-1.72.0.sha256sum] =3D "887d93f60543e9a9362ef8a21beedd0a833c5d9=
610e18c67abe15a5963dcb1a4"
-SRC_URI[fastrand-2.0.1.sha256sum] =3D "25cbce373ec4653f1a01a31e8a5e5ec0c62=
2dc27ff9c4e6606eefef5cbbed4a5"
+SRC_URI[errno-0.3.9.sha256sum] =3D "534c5cf6194dfab3db3242765c03bbe257cf92=
f22b38f6bc0c58d59108a820ba"
+SRC_URI[fallible_collections-0.4.9.sha256sum] =3D "a88c69768c0a15262df2189=
9142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
+SRC_URI[fastrand-2.1.0.sha256sum] =3D "9fc0510504f03c51ada170672ac806f1f10=
5a88aa97a5281117e1ddc3368e51a"
 SRC_URI[fdeflate-0.3.4.sha256sum] =3D "4f9bfee30e4dedf0ab8b422f03af778d961=
2b63f502710fc500a334ebe2de645"
-SRC_URI[flate2-1.0.28.sha256sum] =3D "46303f565772937ffe1d394a4fac6f411c60=
13172fadde9dcdb1e147a086940e"
+SRC_URI[flate2-1.0.31.sha256sum] =3D "7f211bbe8e69bbd0cfdea405084f128ae8b4=
aaa6b0b522fc8f2b009084797920"
 SRC_URI[float-cmp-0.9.0.sha256sum] =3D "98de4bbd547a563b716d8dfa9aad1cb19b=
fab00f4fa09a6a4ed21dbcf44ce9c4"
-SRC_URI[flume-0.11.0.sha256sum] =3D "55ac459de2512911e4b674ce33cf20befaba3=
82d05b62b008afc1c8b57cbf181"
 SRC_URI[fnv-1.0.7.sha256sum] =3D "3f9eec918d3f24069decb9af1554cad7c880e2da=
24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.1.sha256sum] =3D "e13624c2627564efccf4934284bd=
d98cbaa14e79b0b5a141218e507b3a823456"
 SRC_URI[futf-0.1.5.sha256sum] =3D "df420e2e84819663797d1ec6544b13c5be84629=
e7bb00dc960d6917db2987843"
@@ -367,202 +386,205 @@ SRC_URI[futures-macro-0.3.30.sha256sum] =3D "87750c=
f4b7a4c0625b1529e4c543c2182106e
 SRC_URI[futures-task-0.3.30.sha256sum] =3D "38d84fa142264698cdce1a9f9172cf=
383a0c82de1bddcf3092901442c4097004"
 SRC_URI[futures-util-0.3.30.sha256sum] =3D "3d6401deb83407ab3da39eba7e3398=
7a73c3df0c82b4bb5813ee871c19c41d48"
 SRC_URI[fxhash-0.2.1.sha256sum] =3D "c31b6d751ae2c7f11320402d34e41349dd101=
6f8d5d45e48c4312bc8625af50c"
-SRC_URI[gdk-pixbuf-0.19.0.sha256sum] =3D "c311c47800051b87de1335e8792774d7=
cec551c91a0a3d109ab21d76b36f208f"
-SRC_URI[gdk-pixbuf-sys-0.19.0.sha256sum] =3D "3dcbd04c1b2c4834cc008b4828bc=
917d062483b88d26effde6342e5622028f96"
-SRC_URI[getrandom-0.2.12.sha256sum] =3D "190092ea657667030ac6a35e305e62fc4=
dd69fd98ac98631e5d3a2b1575a12b5"
-SRC_URI[gif-0.12.0.sha256sum] =3D "80792593675e051cf94a4b111980da2ba60d4a8=
3e43e0048c5693baab3977045"
-SRC_URI[gio-0.19.0.sha256sum] =3D "b3d1aaa2d926710a27f3b35822806b1513b393b=
71174dd2601c9d02fdab0cb82"
-SRC_URI[gio-sys-0.19.0.sha256sum] =3D "bcf8e1d9219bb294636753d307b030c1e8a=
032062cba74f493c431a5c8b81ce4"
-SRC_URI[glib-0.19.0.sha256sum] =3D "170ee82b9b44b3b5fd1cf4971d6cf0eadec383=
03bb84c7bcc4e6b95a18934e71"
-SRC_URI[glib-macros-0.19.0.sha256sum] =3D "2ff52fff7e4d1bb8598ae744e9bb90c=
8c76271712483c3f0ce931bee9814de85"
-SRC_URI[glib-sys-0.19.0.sha256sum] =3D "630f097773d7c7a0bb3258df4e8157b47d=
c98bbfa0e60ad9ab56174813feced4"
-SRC_URI[gobject-sys-0.19.0.sha256sum] =3D "c85e2b1080b9418dd0c58b498da3a5c=
826030343e0ef07bde6a955d28de54979"
-SRC_URI[half-2.3.1.sha256sum] =3D "bc52e53916c08643f1b56ec082790d1e86a32e5=
8dc5268f897f313fbae7b4872"
-SRC_URI[hashbrown-0.14.3.sha256sum] =3D "290f1a1d9242c78d09ce40a5e87e7554e=
e637af1351968159f4952f028f75604"
-SRC_URI[heck-0.4.1.sha256sum] =3D "95505c38b4572b2d910cecb0281560f54b440a1=
9336cbbcb27bf6ce6adc6f5a8"
-SRC_URI[hermit-abi-0.3.5.sha256sum] =3D "d0c62115964e08cb8039170eb33c1d0e2=
388a256930279edca206fff675f82c3"
+SRC_URI[gdk-pixbuf-0.20.0.sha256sum] =3D "28bb53ecb56857c683c9ec859908e076=
dd3969c7d67598bd8b1ce095d211304a"
+SRC_URI[gdk-pixbuf-sys-0.20.0.sha256sum] =3D "9f6681a0c1330d1d3968bec1529f=
7172d62819ef0bdbb0d18022320654158b03"
+SRC_URI[generic-array-0.14.7.sha256sum] =3D "85649ca51fd72272d7821adaf274a=
d91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[getrandom-0.2.15.sha256sum] =3D "c4567c8db10ae91089c99af84c68c38da=
3ec2f087c3f82960bcdbf3656b6f4d7"
+SRC_URI[gif-0.13.1.sha256sum] =3D "3fb2d69b19215e18bb912fa30f7ce15846e3014=
08695e44e0ef719f1da9e19f2"
+SRC_URI[gio-0.20.0.sha256sum] =3D "398e3da68749fdc32783cbf7521ec3f65c9cf94=
6db8c7774f8460af49e52c6e2"
+SRC_URI[gio-sys-0.20.0.sha256sum] =3D "e4feb96b31c32730ea3e1e89aecd2e4e37e=
cb1c473ad8f685e3430a159419f63"
+SRC_URI[glib-0.20.0.sha256sum] =3D "fee90a615ce05be7a32932cfb8adf2c4bbb470=
0e80d37713c981fb24c0c56238"
+SRC_URI[glib-macros-0.20.0.sha256sum] =3D "4da558d8177c0c8c54368818b508a42=
44e1286fce2858cef4e547023f0cfa5ef"
+SRC_URI[glib-sys-0.20.0.sha256sum] =3D "4958c26e5a01c9af00dea669a97369eccb=
ec29a8e6d125c24ea2d85ee7467b60"
+SRC_URI[gobject-sys-0.20.0.sha256sum] =3D "c6908864f5ffff15b56df7e90346863=
904f49b949337ed0456b9287af61903b8"
+SRC_URI[half-2.4.1.sha256sum] =3D "6dd08c532ae367adf81c312a4580bc67f1d0fe8=
bc9c460520283f4c0ff277888"
+SRC_URI[hashbrown-0.13.2.sha256sum] =3D "43a3c133739dddd0d2990f9a4bdf8eb4b=
21ef50e4851ca85ab661199821d510e"
+SRC_URI[hashbrown-0.14.5.sha256sum] =3D "e5274423e17b7c9fc20b6e7e208532f9b=
19825d82dfd615708b70edd83df41f1"
+SRC_URI[heck-0.5.0.sha256sum] =3D "2304e00983f87ffb38b55b444b5e3b60a884b5d=
30c0fca7d82fe33449bbe55ea"
+SRC_URI[hermit-abi-0.3.9.sha256sum] =3D "d231dfb89cfffdbc30e7fc41579ed6066=
ad03abda9e567ccafae602b97ec5024"
 SRC_URI[iana-time-zone-0.1.60.sha256sum] =3D "e7ffbb5a1b541ea2561f8c41c087=
286cc091e21e556a4f09a8f6cbf17b69b141"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] =3D "f31827a206f56af32e590ba=
56d5d2d085f558508192593743f16b2306495269f"
 SRC_URI[idna-0.5.0.sha256sum] =3D "634d9b1461af396cad843f47fdba5597a4f9e6d=
dd4bfb6ff5d85028c25cb12f6"
-SRC_URI[image-0.24.8.sha256sum] =3D "034bbe799d1909622a74d1193aa5014776944=
0040ff36cb2baa947609b0a4e23"
-SRC_URI[indexmap-2.2.2.sha256sum] =3D "824b2ae422412366ba479e8111fd301f7b5=
faece8149317bb81925979a53f520"
-SRC_URI[is-terminal-0.4.10.sha256sum] =3D "0bad00257d07be169d870ab665980b0=
6cdb366d792ad690bf2e76876dc503455"
+SRC_URI[image-0.25.2.sha256sum] =3D "99314c8a2152b8ddb211f924cdae532d8c5e4=
c8bb54728e12fff1b0cd5963a10"
+SRC_URI[image-webp-0.1.3.sha256sum] =3D "f79afb8cbee2ef20f59ccd477a218c12a=
93943d075b492015ecb1bb81f8ee904"
+SRC_URI[indexmap-2.3.0.sha256sum] =3D "de3fc2e30ba82dd1b3911c8de1ffc143c74=
a914a14e99514d7637e3099df5ea0"
+SRC_URI[is-terminal-0.4.12.sha256sum] =3D "f23ff5ef2b80d608d61efee834934d8=
62cd92461afc0560dedf493e4c033738b"
+SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] =3D "7943c866cc5cd64cbc25b2=
e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
 SRC_URI[itertools-0.10.5.sha256sum] =3D "b0fd2260e829bddf4cb6ea802289de2f8=
6d6a7a690192fbe91b3f46e0f2c8473"
-SRC_URI[itertools-0.12.1.sha256sum] =3D "ba291022dbbd398a455acf126c1e34195=
4079855bc60dfdda641363bd6922569"
-SRC_URI[itoa-1.0.10.sha256sum] =3D "b1a46d1a171d865aa5f83f92695765caa047a9=
b4cbae2cbf37dbd613a793fd4c"
-SRC_URI[jpeg-decoder-0.3.1.sha256sum] =3D "f5d4a7da358eff58addd2877a458651=
58f0d78c911d43a5784ceb7bbf52833b0"
-SRC_URI[js-sys-0.3.68.sha256sum] =3D "406cda4b368d531c842222cf9d2600a9a4ac=
ce8d29423695379c6868a143a9ee"
+SRC_URI[itertools-0.13.0.sha256sum] =3D "413ee7dfc52ee1a4949ceeb7dbc8a33f2=
d6c088194d9f922fb8318faf1f01186"
+SRC_URI[itoa-1.0.11.sha256sum] =3D "49f1f14873335454500d59611f1cf4a4b0f786=
f9ac11f4312a78e4cf2566695b"
+SRC_URI[js-sys-0.3.69.sha256sum] =3D "29c15563dc2726973df627357ce0c9ddddbe=
a194836909d655df6a75d2cf296d"
 SRC_URI[language-tags-0.3.2.sha256sum] =3D "d4345964bb142484797b161f473a50=
3a434de77149dd8c7427788c6e13379388"
-SRC_URI[lazy_static-1.4.0.sha256sum] =3D "e2abad23fbc42b3700f2f279844dc832=
adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[lebe-0.5.2.sha256sum] =3D "03087c2bad5e1034e8cace5926dec053fb37902=
48370865f5117a7d0213354c8"
-SRC_URI[libc-0.2.153.sha256sum] =3D "9c198f91728a82281a64e1f4f9eeb25d82cb3=
2a5de251c6bd1b5154d63a8e7bd"
-SRC_URI[libloading-0.8.1.sha256sum] =3D "c571b676ddfc9a8c12f1f3d3085a7b163=
966a8fd8098a90640953ce5f6170161"
+SRC_URI[lazy_static-1.5.0.sha256sum] =3D "bbd2bcb4c963f2ddae06a2efc7e9f359=
1312473c50c6685e1f298068316e66fe"
+SRC_URI[libc-0.2.155.sha256sum] =3D "97b3888a4aecf77e811145cadf6eef5901f47=
82c53886191b2f693f24761847c"
+SRC_URI[libloading-0.8.5.sha256sum] =3D "4979f22fdb869068da03c9f7528f8297c=
6fd2606bc3a4affe42e6a823fdb8da4"
 SRC_URI[libm-0.2.8.sha256sum] =3D "4ec2a862134d2a7d32d7983ddcdd1c492353083=
3c9f2ea1a44fc5fa473989058"
 SRC_URI[linked-hash-map-0.5.6.sha256sum] =3D "0717cef1bc8b636c6e1c1bbdefc0=
9e6322da8a9321966e8928ef80d20f7f770f"
-SRC_URI[linux-raw-sys-0.4.13.sha256sum] =3D "01cda141df6706de531b6c46c3a33=
ecca755538219bd484262fa09410c13539c"
+SRC_URI[linux-raw-sys-0.4.14.sha256sum] =3D "78b3ae25bc7c8c38cec158d1f2757=
ee79e9b3740fbc7ccf0e59e4b08d793fa89"
 SRC_URI[locale_config-0.3.0.sha256sum] =3D "08d2c35b16f4483f6c26f0e4e95507=
17a2f6575bcd6f12a53ff0c490a94a6934"
-SRC_URI[lock_api-0.4.11.sha256sum] =3D "3c168f8615b12bc01f9c17e2eb0cc07dca=
e1940121185446edc3744920e8ef45"
-SRC_URI[log-0.4.20.sha256sum] =3D "b5e6163cb8c49088c2c36f57875e58ccd8c87c7=
427f7fbd50ea6710b2f3f2e8f"
-SRC_URI[lopdf-0.32.0.sha256sum] =3D "e775e4ee264e8a87d50a9efef7b67b4aa988c=
f94e75630859875fc347e6c872b"
+SRC_URI[lock_api-0.4.12.sha256sum] =3D "07af8b9cdd281b7915f413fa73f29ebd5d=
55d0d3f0155584dade1ff18cea1b17"
+SRC_URI[log-0.4.22.sha256sum] =3D "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c=
54bba33a7f72f873a39d07b24"
+SRC_URI[lopdf-0.33.0.sha256sum] =3D "b5c14afa083a906d49e1bda105ddbf8175016=
e2658954e6d0c3e612f886df3db"
 SRC_URI[mac-0.1.1.sha256sum] =3D "c41e0c4fef86961ac6d6f8a82609f55f31b05e4f=
ce149ac5710e439df7619ba4"
 SRC_URI[malloc_buf-0.0.6.sha256sum] =3D "62bb907fe88d54d8d9ce32a3cceab4218=
ed2f6b7d35617cafe9adf84e43919cb"
-SRC_URI[markup5ever-0.11.0.sha256sum] =3D "7a2629bb1404f3d34c2e921f21fd34b=
a00b206124c81f65c50b43b6aaefeb016"
+SRC_URI[markup5ever-0.12.1.sha256sum] =3D "16ce3abbeba692c8b8441d036ef91ae=
a6df8da2c6b6e21c7e14d3c18e526be45"
 SRC_URI[matches-0.1.10.sha256sum] =3D "2532096657941c2fea9c289d370a250971c=
689d4f143798ff67113ec042024a5"
-SRC_URI[matrixmultiply-0.3.8.sha256sum] =3D "7574c1cf36da4798ab73da5b215bb=
f444f50718207754cb522201d78d1cd0ff2"
-SRC_URI[md5-0.7.0.sha256sum] =3D "490cc448043f947bae3cbee9c203358d62dbee0d=
b12107a74be5c30ccfd09771"
-SRC_URI[memchr-2.7.1.sha256sum] =3D "523dc4f511e55ab87b694dc30d0f820d60906=
ef06413f93d4d7a1385599cc149"
+SRC_URI[matrixmultiply-0.3.9.sha256sum] =3D "9380b911e3e96d10c1f415da08763=
89aaf1b56759054eeb0de7df940c456ba1a"
+SRC_URI[md-5-0.10.6.sha256sum] =3D "d89e7ee0cfbedfc4da3340218492196241d89e=
efb6dab27de5df917a6d2e78cf"
+SRC_URI[memchr-2.7.4.sha256sum] =3D "78ca9ab1a0babb1e7d5695e3530886289c18c=
f2f87ec19a575a0abdce112e3a3"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] =3D "68354c5c6bd36d73ff3feceb05ef=
a59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.7.2.sha256sum] =3D "9d811f3e15f28568be3407c8e7fdb651=
4c1cda3cb30683f15b6a1a1dc4ea14a7"
-SRC_URI[nalgebra-0.32.3.sha256sum] =3D "307ed9b18cc2423f29e83f84fd23a8e736=
28727990181f18641a8b5dc2ab1caa"
-SRC_URI[nalgebra-macros-0.2.1.sha256sum] =3D "91761aed67d03ad966ef783ae962=
ef9bbaca728d2dd7ceb7939ec110fffad998"
-SRC_URI[new_debug_unreachable-1.0.4.sha256sum] =3D "e4a24736216ec316047a1f=
c4252e27dabb04218aa4a3f37c6e7ddbf1f9782b54"
+SRC_URI[miniz_oxide-0.7.4.sha256sum] =3D "b8a240ddb74feaf34a79a7add65a741f=
3167852fba007066dcac1ca548d89c08"
+SRC_URI[mp4parse-0.17.0.sha256sum] =3D "63a35203d3c6ce92d5251c77520acb2e57=
108c88728695aa883f70023624c570"
+SRC_URI[nalgebra-0.33.0.sha256sum] =3D "3c4b5f057b303842cf3262c27e465f4c30=
3572e7f6b0648f60e16248ac3397f4"
+SRC_URI[nalgebra-macros-0.2.2.sha256sum] =3D "254a5372af8fc138e36684761d3c=
0cdb758a4410e938babcff1c860ce14ddbfc"
+SRC_URI[new_debug_unreachable-1.0.6.sha256sum] =3D "650eef8c711430f1a879fd=
d01d4745a7deea475becfb90269c06775983bbf086"
 SRC_URI[nom-7.1.3.sha256sum] =3D "d273983c5a657a70a3e8f2a01329822f3b8c8172=
b73826411a55751e404a0a4a"
 SRC_URI[normalize-line-endings-0.3.0.sha256sum] =3D "61807f77802ff30975e01=
f4f071c8ba10c022052f98b3294119f3e615d13e5be"
-SRC_URI[num-complex-0.4.5.sha256sum] =3D "23c6602fda94a57c990fe0df199a035d=
83576b496aa29f4e634a8ac6004e68a6"
+SRC_URI[num-bigint-0.4.6.sha256sum] =3D "a5e44f723f1133c9deac646763579fdb3=
ac745e418f2a7af9cd0c431da1f20b9"
+SRC_URI[num-complex-0.4.6.sha256sum] =3D "73f88a1307638156682bada9d7604135=
552957b7818057dcef22705b4d509495"
 SRC_URI[num-conv-0.1.0.sha256sum] =3D "51d515d32fb182ee37cda2ccdcb92950d6a=
3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-derive-0.4.2.sha256sum] =3D "ed3955f1a9c7c0c15e092f9c887db08b1=
fc683305fdf6eb6684f22555355e202"
 SRC_URI[num-integer-0.1.46.sha256sum] =3D "7969661fd2958a5cb096e56c8e1ad04=
44ac2bbcd0061bd28660485a44879858f"
-SRC_URI[num-rational-0.4.1.sha256sum] =3D "0638a1c9d0a3c0914158145bc76cff3=
73a75a627e6ecbfb71cbe6f453a5a19b0"
-SRC_URI[num-traits-0.2.18.sha256sum] =3D "da0df0e5185db44f69b44f26786fe401=
b6c293d1907744beaa7fa62b2e5a517a"
+SRC_URI[num-rational-0.4.2.sha256sum] =3D "f83d14da390562dca69fc84082e73e5=
48e1ad308d24accdedd2720017cb37824"
+SRC_URI[num-traits-0.2.19.sha256sum] =3D "071dfc062690e90b734c0b2273ce72ad=
0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[objc-0.2.7.sha256sum] =3D "915b1b472bc21c53464d6c8461c9d3af805ba1e=
f837e1cac254428f4a77177b1"
 SRC_URI[objc-foundation-0.1.1.sha256sum] =3D "1add1b659e36c9607c7aab864a76=
c7a4c2760cd0cd2e120f3fb8b952c7e22bf9"
 SRC_URI[objc_id-0.1.1.sha256sum] =3D "c92d4ddb4bd7b50d730c215ff871754d0da6=
b2178849f8a2a2ab69712d0c073b"
 SRC_URI[once_cell-1.19.0.sha256sum] =3D "3fdb12b2476b595f9358c5161aa467c24=
38859caa136dec86c26fdd2efe17b92"
-SRC_URI[oorandom-11.1.3.sha256sum] =3D "0ab1bc2a289d34bd04a330323ac98a1b4b=
c82c9d9fcb1e66b63caa84da26b575"
-SRC_URI[pango-0.19.0.sha256sum] =3D "78d7f779b957728c74fd1a060dfa6d89a0bea=
792ebc50cc2da80e4e87282d69e"
-SRC_URI[pango-sys-0.19.0.sha256sum] =3D "f52ef6a881c19fbfe3b1484df5cad411a=
caaba29dbec843941c3110d19f340ea"
-SRC_URI[pangocairo-0.19.1.sha256sum] =3D "9615c6294903a6ea26fa63984b18e512=
75354d1fa91bbde68eeb7fa3ab61a72f"
-SRC_URI[pangocairo-sys-0.19.0.sha256sum] =3D "01bd0597ae45983f9e8b7f73afc4=
2238426cd3fbb44a9cf14fd881a4ae08f1e4"
-SRC_URI[parking_lot-0.12.1.sha256sum] =3D "3742b2c103b9f06bc9fff0a37ff4912=
935851bee6d36f3c02bcc755bcfec228f"
-SRC_URI[parking_lot_core-0.9.9.sha256sum] =3D "4c42a9226546d68acdd9c0a280d=
17ce19bfe27a46bf68784e4066115788d008e"
-SRC_URI[paste-1.0.14.sha256sum] =3D "de3145af08024dea9fa9914f381a17b8fc603=
4dfb00f3a84013f7ff43f29ed4c"
+SRC_URI[oorandom-11.1.4.sha256sum] =3D "b410bbe7e14ab526a0e86877eb47c6996a=
2bd7746f027ba551028c925390e4e9"
+SRC_URI[pango-0.20.0.sha256sum] =3D "54768854025df6903061d0084fd9702a253dd=
fd60db7d9b751d43b76689a7f0a"
+SRC_URI[pango-sys-0.20.0.sha256sum] =3D "b07cc57d10cee4ec661f718a6902cee18=
c2f4cfae08e87e5a390525946913390"
+SRC_URI[pangocairo-0.20.0.sha256sum] =3D "902cd6e53493a475f4524e7b3f4c09ef=
60ee87c7be16f08f1b41882fc74dac46"
+SRC_URI[pangocairo-sys-0.20.0.sha256sum] =3D "bc23a5ea756e709ab1598f8446a6=
4c799b10c99ec59aa2310965218bc1915853"
+SRC_URI[parking_lot-0.12.3.sha256sum] =3D "f1bf18183cf54e8d6059647fc306364=
6a1801cf30896933ec2311622cc4b9a27"
+SRC_URI[parking_lot_core-0.9.10.sha256sum] =3D "1e401f977ab385c9e4e3ab3062=
7d6f26d00e2c73eef317493c4ec6d468726cf8"
+SRC_URI[paste-1.0.15.sha256sum] =3D "57c0d7b74b563b49d38dae00a0c37d4d6de9b=
432382b2892f0574ddcae73fd0a"
 SRC_URI[percent-encoding-2.3.1.sha256sum] =3D "e3148f5046208a5d56bcfc03053=
e3ca6334e51da8dfb19b6cdc8b306fae3283e"
 SRC_URI[phf-0.10.1.sha256sum] =3D "fabbf1ead8a5bcbc20f5f8b939ee3f5b0f6f281=
b6ad3468b84656b658b455259"
 SRC_URI[phf-0.11.2.sha256sum] =3D "ade2d8b8f33c7333b51bcf0428d37e217e9f321=
92ae4772156f65063b8ce03dc"
 SRC_URI[phf_codegen-0.10.0.sha256sum] =3D "4fb1c3a8bc4dd4e5cfce29b44ffc14b=
edd2ee294559a294e2a4d4c9e9a6a13cd"
+SRC_URI[phf_codegen-0.11.2.sha256sum] =3D "e8d39688d359e6b34654d328e262234=
662d16cc0f60ec8dcbe5e718709342a5a"
 SRC_URI[phf_generator-0.10.0.sha256sum] =3D "5d5285893bb5eb82e6aaf5d59ee90=
9a06a16737a8970984dd7746ba9283498d6"
 SRC_URI[phf_generator-0.11.2.sha256sum] =3D "48e4cc64c2ad9ebe670cb8fd69dd5=
0ae301650392e81c05f9bfcb2d5bdbc24b0"
 SRC_URI[phf_macros-0.11.2.sha256sum] =3D "3444646e286606587e49f3bcf1679b8c=
ef1dc2c5ecc29ddacaffc305180d464b"
 SRC_URI[phf_shared-0.10.0.sha256sum] =3D "b6796ad771acdc0123d2a88dc428b5e3=
8ef24456743ddb1744ed628f9815c096"
 SRC_URI[phf_shared-0.11.2.sha256sum] =3D "90fcb95eef784c2ac79119d1dd819e16=
2b5da872ce6f3c3abe1e8ca1c082f72b"
-SRC_URI[pin-project-lite-0.2.13.sha256sum] =3D "8afb450f006bf6385ca15ef45d=
71d2288452bc3683ce2e2cacc0d18e4be60b58"
+SRC_URI[pin-project-lite-0.2.14.sha256sum] =3D "bda66fc9667c18cb2758a2ac84=
d1167245054bcf85d5d1aaa6923f45801bdd02"
 SRC_URI[pin-utils-0.1.0.sha256sum] =3D "8b870d8c151b6f2fb93e84a13146138f05=
d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.29.sha256sum] =3D "2900ede94e305130c13ddd391e0ab7cb=
aeb783945ae07a279c268cb05109c6cb"
-SRC_URI[plotters-0.3.5.sha256sum] =3D "d2c224ba00d7cadd4d5c660deaf2098e5e8=
0e07846537c51f9cfa4be50c1fd45"
-SRC_URI[plotters-backend-0.3.5.sha256sum] =3D "9e76628b4d3a7581389a35d5b6e=
2139607ad7c75b17aed325f210aa91f4a9609"
-SRC_URI[plotters-svg-0.3.5.sha256sum] =3D "38f6d39893cca0701371e3c27294f09=
797214b86f1fb951b89ade8ec04e2abab"
-SRC_URI[png-0.17.11.sha256sum] =3D "1f6c3c3e617595665b8ea2ff95a86066be38fb=
121ff920a9c0eb282abcd1da5a"
+SRC_URI[pkg-config-0.3.30.sha256sum] =3D "d231b230927b5e4ad203db57bbcbee28=
02f6bce620b1e4a9024a07d94e2907ec"
+SRC_URI[plotters-0.3.6.sha256sum] =3D "a15b6eccb8484002195a3e44fe65a4ce8e9=
3a625797a063735536fd59cb01cf3"
+SRC_URI[plotters-backend-0.3.6.sha256sum] =3D "414cec62c6634ae900ea1c56128=
dfe87cf63e7caece0852ec76aba307cebadb7"
+SRC_URI[plotters-svg-0.3.6.sha256sum] =3D "81b30686a7d9c3e010b84284bdd26a2=
9f2138574f52f5eb6f794fc0ad924e705"
+SRC_URI[png-0.17.13.sha256sum] =3D "06e4b0d3d1312775e782c86c91a111aa1f910c=
bb65e1337f9975b5f9a554b5e1"
 SRC_URI[powerfmt-0.2.0.sha256sum] =3D "439ee305def115ba05938db6eb1644ff941=
65c5ab5e9420d1c1bcedbba909391"
-SRC_URI[ppv-lite86-0.2.17.sha256sum] =3D "5b40af805b3121feab8a3c29f04d8ad2=
62fa8e0561883e7653e024ae4479e6de"
+SRC_URI[ppv-lite86-0.2.20.sha256sum] =3D "77957b295656769bb8ad2b6a6b09d897=
d94f05c41b069aede1fcdaa675eaea04"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] =3D "925383efa346730478fb4838dbe=
9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[predicates-3.1.0.sha256sum] =3D "68b87bfd4605926cdfefc1c3b5f8fe560=
e3feca9d5552cf68c466d3d8236c7e8"
-SRC_URI[predicates-core-1.0.6.sha256sum] =3D "b794032607612e7abeb4db69adb4=
e33590fa6cf1149e95fd7cb00e634b92f174"
-SRC_URI[predicates-tree-1.0.9.sha256sum] =3D "368ba315fb8c5052ab692e68a0ee=
fec6ec57b23a36959c14496f0b0df2c0cecf"
+SRC_URI[predicates-3.1.2.sha256sum] =3D "7e9086cc7640c29a356d1a29fd134380b=
ee9d8f79a17410aa76e7ad295f42c97"
+SRC_URI[predicates-core-1.0.8.sha256sum] =3D "ae8177bee8e75d6846599c6b9ff6=
79ed51e882816914eec639944d7c9aa11931"
+SRC_URI[predicates-tree-1.0.11.sha256sum] =3D "41b740d195ed3166cd147c8047e=
c98db0e22ec019eb8eeb76d343b795304fb13"
 SRC_URI[proc-macro-crate-3.1.0.sha256sum] =3D "6d37c51ca738a55da99dc0c4a34=
860fd675453b8b36209178c2249bb13651284"
-SRC_URI[proc-macro2-1.0.78.sha256sum] =3D "e2422ad645d89c99f8f3e6b88a9fdec=
a7fabeac836b1002371c4367c8f984aae"
-SRC_URI[proptest-1.4.0.sha256sum] =3D "31b476131c3c86cb68032fdc5cb6d5a1045=
e3e42d96b69fa599fd77701e1f5bf"
-SRC_URI[qoi-0.4.1.sha256sum] =3D "7f6d64c71eb498fe9eae14ce4ec935c555749aef=
511cca85b5568910d6e48001"
+SRC_URI[proc-macro2-1.0.86.sha256sum] =3D "5e719e8df665df0d1c8fbfd23801574=
4736151d4445ec0836b8e628aae103b77"
+SRC_URI[proptest-1.5.0.sha256sum] =3D "b4c2511913b88df1637da85cc8d96ec8e43=
a3f8bb8ccb71ee1ac240d6f3df58d"
 SRC_URI[quick-error-1.2.3.sha256sum] =3D "a1d01941d82fa2ab50be1e79e6714289=
dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] =3D "a993555f31e5a609f617c12db6250ded=
cac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[quote-1.0.35.sha256sum] =3D "291ec9ab5efd934aaf503a6466c5d5251535d=
108ee747472c3977cc5acc868ef"
+SRC_URI[quote-1.0.36.sha256sum] =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab=
723cdda1c6bd4e6ad4208acaca7"
 SRC_URI[rand-0.8.5.sha256sum] =3D "34af8d1a0e25924bc5b7c43c079c942339d8f0a=
8b57c39049bef581b46327404"
 SRC_URI[rand_chacha-0.3.1.sha256sum] =3D "e6c10a63a0fa32252be49d21e7709d4d=
4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] =3D "ec0be4795e2f6a28069bec0b5ff3e2ac9b=
afc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_xorshift-0.3.0.sha256sum] =3D "d25bf25ec5ae4a3f1b92f929810509=
a2f53d7dca2f50b794ff57e3face536c8f"
 SRC_URI[rawpointer-0.2.1.sha256sum] =3D "60a357793950651c4ed0f3f52338f53b2=
f809f32d83a07f72909fa13e4c6c1e3"
-SRC_URI[rayon-1.8.1.sha256sum] =3D "fa7237101a77a10773db45d62004a272517633=
fbcc3df19d96455ede1122e051"
+SRC_URI[rayon-1.10.0.sha256sum] =3D "b418a60154510ca1a002a752ca9714984e21e=
4241e804d32555251faf8b78ffa"
 SRC_URI[rayon-core-1.12.1.sha256sum] =3D "1465873a3dfdaa8ae7cb14b4383657ca=
ab0b3e8a0aa9ae8e04b044854c8dfce2"
 SRC_URI[rctree-0.6.0.sha256sum] =3D "e03e7866abec1101869ffa8e2c8355c4c2419=
d0214ece0cc3e428e5b94dea6e9"
-SRC_URI[redox_syscall-0.4.1.sha256sum] =3D "4722d768eff46b75989dd134e5c353=
f0d6296e5aaa3132e776cbdb56be7731aa"
-SRC_URI[regex-1.10.3.sha256sum] =3D "b62dbe01f0b06f9d8dc7d49e05a0785f153b0=
0b2c227856282f671e0318c9b15"
-SRC_URI[regex-automata-0.4.5.sha256sum] =3D "5bb987efffd3c6d0d8f5f89510bb4=
58559eab11e4f869acb20bf845e016259cd"
-SRC_URI[regex-syntax-0.8.2.sha256sum] =3D "c08c74e62047bb2de4ff487b251e4a9=
2e24f48745648451635cec7d591162d9f"
-SRC_URI[rgb-0.8.37.sha256sum] =3D "05aaa8004b64fd573fc9d002f4e632d51ad4f02=
6c2b5ba95fcb6c2f32c2c47d8"
-SRC_URI[rustix-0.38.31.sha256sum] =3D "6ea3e1a662af26cd7a3ba09c0297a31af21=
5563ecf42817c98df621387f4e949"
+SRC_URI[redox_syscall-0.5.3.sha256sum] =3D "2a908a6e00f1fdd0dfd9c0eb08ce85=
126f6d8bbda50017e74bc4a4b7d4a926a4"
+SRC_URI[regex-1.10.6.sha256sum] =3D "4219d74c6b67a3654a9fbebc4b419e22126d1=
3d2f3c4a07ee0cb61ff79a79619"
+SRC_URI[regex-automata-0.4.7.sha256sum] =3D "38caf58cc5ef2fed281f89292ef23=
f6365465ed9a41b7a7754eb4e26496c92df"
+SRC_URI[regex-syntax-0.8.4.sha256sum] =3D "7a66a03ae7c801facd77a29370b4fae=
c201768915ac14a721ba36f20bc9c209b"
+SRC_URI[rgb-0.8.48.sha256sum] =3D "0f86ae463694029097b846d8f99fd5536740602=
ae00022c0c50c5600720b2f71"
+SRC_URI[rustix-0.38.34.sha256sum] =3D "70dc5ec042f7a43c4a73241207cecc9873a=
06d45debb38b329f8541d85c2730f"
 SRC_URI[rusty-fork-0.3.0.sha256sum] =3D "cb3dcc6e454c328bb824492db107ab7c0=
ae8fcffe4ad210136ef014458c1bc4f"
-SRC_URI[ryu-1.0.16.sha256sum] =3D "f98d2aa92eebf49b69786be48e4477826b25691=
6e84a57ff2a4f21923b48eb4c"
-SRC_URI[safe_arch-0.7.1.sha256sum] =3D "f398075ce1e6a179b46f51bd88d0598b92=
b00d3551f1a2d4ac49e771b56ac354"
+SRC_URI[ryu-1.0.18.sha256sum] =3D "f3cb5ba0dc43242ce17de99c180e96db90b235b=
8a9fdc9543c96d2209116bd9f"
+SRC_URI[safe_arch-0.7.2.sha256sum] =3D "c3460605018fdc9612bce72735cba0d27e=
fbcd9904780d44c7e3a9948f96148a"
 SRC_URI[same-file-1.0.6.sha256sum] =3D "93fc1dc3aaa9bfed95e02e6eadabb4baf7=
e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] =3D "94143f37725109f92c262ed2cf5e59bce=
7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[selectors-0.25.0.sha256sum] =3D "4eb30575f3638fc8f6815f448d50cb1a2=
e255b0897985c8c59f4d37b72a07b06"
-SRC_URI[serde-1.0.196.sha256sum] =3D "870026e60fa08c69f064aa766c10f10b1d62=
db9ccd4d0abb206472bee0ce3b32"
-SRC_URI[serde_derive-1.0.196.sha256sum] =3D "33c85360c95e7d137454dc81d9a4e=
d2b8efd8fbe19cee57357b32b9771fccb67"
-SRC_URI[serde_json-1.0.113.sha256sum] =3D "69801b70b1c3dac963ecb03a364ba0c=
eda9cf60c71cfe475e99864759c8b8a79"
-SRC_URI[serde_spanned-0.6.5.sha256sum] =3D "eb3622f419d1296904700073ea6cc2=
3ad690adbd66f13ea683df73298736f0c1"
+SRC_URI[serde-1.0.204.sha256sum] =3D "bc76f558e0cbb2a839d37354c575f1dc3fdc=
6546b5be373ba43d95f231bf7c12"
+SRC_URI[serde_derive-1.0.204.sha256sum] =3D "e0cd7e117be63d3c3678776753929=
474f3b04a43a080c744d6b0ae2a8c28e222"
+SRC_URI[serde_json-1.0.122.sha256sum] =3D "784b6203951c57ff748476b126ccb5e=
8e2959a5c19e5c617ab1956be3dbc68da"
+SRC_URI[serde_spanned-0.6.7.sha256sum] =3D "eb5b1b31579f3811bf615c14439341=
7496f152e12ac8b7663bf664f4a815306d"
 SRC_URI[servo_arc-0.3.0.sha256sum] =3D "d036d71a959e00c77a63538b90a6c23909=
69f9772b096ea837205c6bd0491a44"
-SRC_URI[simba-0.8.1.sha256sum] =3D "061507c94fc6ab4ba1c9a0305018408e312e17=
c041eb63bef8aa726fa33aceae"
+SRC_URI[shell-words-1.1.0.sha256sum] =3D "24188a676b6ae68c3b2cb3a01be17fbf=
7240ce009799bb56d5b1409051e78fde"
+SRC_URI[simba-0.9.0.sha256sum] =3D "b3a386a501cd104797982c15ae17aafe8b9261=
315b5d07e3ec803f2ea26be0fa"
 SRC_URI[simd-adler32-0.3.7.sha256sum] =3D "d66dc143e6b11c1eddc06d5c423cfc9=
7062865baf299914ab64caa38182078fe"
 SRC_URI[siphasher-0.3.11.sha256sum] =3D "38b58827f4464d87d377d175e90bf58eb=
00fd8716ff0a62f80356b5e61555d0d"
 SRC_URI[slab-0.4.9.sha256sum] =3D "8f92a496fb766b417c996b9c5e57daf2f7ad3b0=
bebe1ccfca4856390e3d3bb67"
-SRC_URI[smallvec-1.13.1.sha256sum] =3D "e6ecd384b10a64542d77071bd64bd7b231=
f4ed5940fba55e98c3de13824cf3d7"
-SRC_URI[spin-0.9.8.sha256sum] =3D "6980e8d7511241f8acf4aebddbb1ff938df5eeb=
e98691418c4468d0b72a96a67"
+SRC_URI[smallvec-1.13.2.sha256sum] =3D "3c5e1a9a646d36c3599cd173a41282daf4=
7c44583ad367b8e6837255952e5c67"
 SRC_URI[stable_deref_trait-1.2.0.sha256sum] =3D "a8f112729512f8e442d81f95a=
8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
+SRC_URI[static_assertions-1.1.0.sha256sum] =3D "a2eb9349b6444b326872e140eb=
1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[string_cache-0.8.7.sha256sum] =3D "f91138e76242f575eb1d3b38b4f1362=
f10d3a43f47d182a5b359af488a02293b"
 SRC_URI[string_cache_codegen-0.5.2.sha256sum] =3D "6bb30289b722be4ff74a408=
c3cc27edeaad656e06cb1fe8fa9231fa59c728988"
-SRC_URI[strsim-0.10.0.sha256sum] =3D "73473c0e59e6d5812c5dfe2a064a6444949f=
089e20eec9a2e5506596494e4623"
-SRC_URI[syn-1.0.109.sha256sum] =3D "72b64191b275b66ffe2469e8af2c1cfe3bafa6=
7b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.48.sha256sum] =3D "0f3531638e407dfc0814761abb7c00a5b54992b=
849452a0646b7f65c9f770f3f"
-SRC_URI[system-deps-6.2.0.sha256sum] =3D "2a2d580ff6a20c55dfb86be5f9c238f6=
7835d0e81cbdea8bf5680e0897320331"
-SRC_URI[target-lexicon-0.12.13.sha256sum] =3D "69758bda2e78f098e4ccb393021=
a0963bb3442eac05f135c30f61b7370bbafae"
-SRC_URI[tempfile-3.10.0.sha256sum] =3D "a365e8cd18e44762ef95d87f284f4b5cd0=
4107fec2ff3052bd6a3e6069669e67"
+SRC_URI[strsim-0.11.1.sha256sum] =3D "7da8b5736845d9f2fcb837ea5d9e2628564b=
3b043a70948a3f0b778838c5fb4f"
+SRC_URI[syn-2.0.72.sha256sum] =3D "dc4b9b9bf2add8093d3f2c0204471e951b22855=
80335de42f9d2534f3ae7a8af"
+SRC_URI[system-deps-6.2.2.sha256sum] =3D "a3e535eb8dded36d55ec13eddacd30de=
c501792ff23a0b1682c38601b8cf2349"
+SRC_URI[system-deps-7.0.1.sha256sum] =3D "6c81f13d9a334a6c242465140bd262fa=
e382b752ff2011c4f7419919a9c97922"
+SRC_URI[target-lexicon-0.12.16.sha256sum] =3D "61c41af27dd6d1e27b1b16b489d=
b798443478cef1f06a660c96db617ba5de3b1"
+SRC_URI[tempfile-3.12.0.sha256sum] =3D "04cbcdd0c794ebb0d4cf35e88edd2f7d2c=
4c3e9a5a6dab322839b321c6a87a64"
 SRC_URI[tendril-0.4.3.sha256sum] =3D "d24a120c5fc464a3458240ee02c299ebcb9d=
67b5249c8848b09d639dca8d7bb0"
 SRC_URI[termtree-0.4.1.sha256sum] =3D "3369f5ac52d5eb6ab48c6b4ffdc8efbcad6=
b89c765749064ba298f2c68a16a76"
-SRC_URI[thiserror-1.0.56.sha256sum] =3D "d54378c645627613241d077a3a79db965=
db602882668f9136ac42af9ecb730ad"
-SRC_URI[thiserror-impl-1.0.56.sha256sum] =3D "fa0faa943b50f3db30a20aa7e265=
dbc66076993efed8463e8de414e5d06d3471"
-SRC_URI[tiff-0.9.1.sha256sum] =3D "ba1310fcea54c6a9a4fd1aad794ecc02c31682f=
6bfbecdf460bf19533eed1e3e"
-SRC_URI[time-0.3.34.sha256sum] =3D "c8248b6521bb14bc45b4067159b9b6ad792e2d=
6d754d6c41fb50e29fefe38749"
+SRC_URI[thiserror-1.0.63.sha256sum] =3D "c0342370b38b6a11b6cc11d6a80556995=
8d54cfa061a29969c3b5ce2ea405724"
+SRC_URI[thiserror-impl-1.0.63.sha256sum] =3D "a4558b58466b9ad7ca0f102865ec=
cc95938dca1a74a856f2b57b6629050da261"
+SRC_URI[time-0.3.36.sha256sum] =3D "5dfd88e563464686c916c7e46e623e520ddc6d=
79fa6641390f2e3fa86e83e885"
 SRC_URI[time-core-0.1.2.sha256sum] =3D "ef927ca75afb808a4d64dd374f00a2adf8=
d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.17.sha256sum] =3D "7ba3a3ef41e6672a2f0f001392bb5dc=
d3ff0a9992d618ca761a11c3121547774"
+SRC_URI[time-macros-0.2.18.sha256sum] =3D "3f252a68540fde3a3877aeea552b832=
b40ab9a69e318efd078774a01ddee1ccf"
 SRC_URI[tinytemplate-1.2.1.sha256sum] =3D "be4d6b5f19ff7664e8c98d03e2139cb=
510db9b0a60b55f8e8709b689d939b6bc"
-SRC_URI[tinyvec-1.6.0.sha256sum] =3D "87cc5ceb3875bb20c2890005a4e226a46512=
64a5c75edb2421b52861a0a0cb50"
+SRC_URI[tinyvec-1.8.0.sha256sum] =3D "445e881f4f6d382d5f27c034e25eb92edd7c=
784ceab92a0937db7f2e9471b938"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] =3D "1f3ccbac311fea05f86f61904b462=
b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.8.10.sha256sum] =3D "9a9aad4a3066010876e8dcf5a8a06e70a55875=
1117a145c6ce2b82c2e2054290"
-SRC_URI[toml_datetime-0.6.5.sha256sum] =3D "3550f4e9685620ac18a50ed434eb3a=
ec30db8ba93b0287467bca5826ea25baf1"
+SRC_URI[toml-0.8.19.sha256sum] =3D "a1ed1f98e3fdc28d6d910e6737ae6ab1a93bf1=
985935a1193e68f93eeb68d24e"
+SRC_URI[toml_datetime-0.6.8.sha256sum] =3D "0dd7358ecb8fc2f8d014bf86f6f638=
ce72ba252a2c3a2572f2a795f1d23efb41"
 SRC_URI[toml_edit-0.21.1.sha256sum] =3D "6a8534fd7f78b5405e860340ad6575217=
ce99f38d4d5c8f2442cb5ecb50090e1"
-SRC_URI[toml_edit-0.22.4.sha256sum] =3D "0c9ffdf896f8daaabf9b66ba8e77ea1ed=
5ed0f72821b398aba62352e95062951"
+SRC_URI[toml_edit-0.22.20.sha256sum] =3D "583c44c02ad26b0c3f3066fe629275e5=
0627026c51ac2e595cca4c230ce1ce1d"
 SRC_URI[typenum-1.17.0.sha256sum] =3D "42ff0bf0c66b8238c6f3b578df37d0b7848=
e55df8577b3f74f92a69acceeb825"
 SRC_URI[unarray-0.1.4.sha256sum] =3D "eaea85b334db583fe3274d12b4cd1880032b=
eab409c0d774be044d4480ab9a94"
 SRC_URI[unicode-bidi-0.3.15.sha256sum] =3D "08f95100a766bf4f8f28f90d77e0a5=
461bbdb219042e7679bebe79004fed8d75"
 SRC_URI[unicode-ident-1.0.12.sha256sum] =3D "3354b9ac3fae1ff6755cb6db53683=
adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-normalization-0.1.22.sha256sum] =3D "5c5713f0fc4b5db668a2a=
c63cdb7bb4469d8c9fed047b1d0292cc7b0ce2ba921"
-SRC_URI[url-2.5.0.sha256sum] =3D "31e6302e3bb753d46e83516cae55ae196fc0c309=
407cf11ab35cc51a4c2a4633"
+SRC_URI[unicode-normalization-0.1.23.sha256sum] =3D "a56d1686db2308d901306=
f92a263857ef59ea39678a5458e7cb17f01415101f5"
+SRC_URI[url-2.5.2.sha256sum] =3D "22784dbdf76fdde8af1aeda5622b546b422b6fc5=
85325248a2bf9f5e41e94d6c"
 SRC_URI[utf-8-0.7.6.sha256sum] =3D "09cc8ee72d2a9becf2f2febe0205bbed8fc661=
5b7cb429ad062dc7b7ddd036a9"
-SRC_URI[utf8parse-0.2.1.sha256sum] =3D "711b9620af191e0cdc7468a8d14e709c3d=
cdb115b36f838e601583af800a370a"
-SRC_URI[version-compare-0.1.1.sha256sum] =3D "579a42fc0b8e0c63b76519a339be=
31bed574929511fa53c1a3acae26eb258f29"
+SRC_URI[utf8parse-0.2.2.sha256sum] =3D "06abde3611657adf66d383f00b093d7fae=
cc7fa57071cce2578660c9f1010821"
+SRC_URI[version-compare-0.2.0.sha256sum] =3D "852e951cb7832cb45cb1169900d1=
9760cfa39b82bc0ea9c0e5a14ae88411c98b"
+SRC_URI[version_check-0.9.5.sha256sum] =3D "0b928f33d975fc6ad9f86c8f283853=
ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[wait-timeout-0.2.0.sha256sum] =3D "9f200f5b12eb75f8c1ed65abd4b2db8=
a6e1b138a20de009dacee265a2498f3f6"
-SRC_URI[walkdir-2.4.0.sha256sum] =3D "d71d857dc86794ca4c280d616f7da00d2dbf=
d8cd788846559a6813e6aa4b54ee"
+SRC_URI[walkdir-2.5.0.sha256sum] =3D "29790946404f91d9c5d06f9874efddea1dc0=
6c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] =3D "9c8d87e72b64a3b=
4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.91.sha256sum] =3D "c1e124130aee3fb58c5bdd6b639a05=
09486b0338acaaae0c84a5124b0f588b7f"
-SRC_URI[wasm-bindgen-backend-0.2.91.sha256sum] =3D "c9e7e1900c352b609c8488=
ad12639a311045f40a35491fb69ba8c12f758af70b"
-SRC_URI[wasm-bindgen-macro-0.2.91.sha256sum] =3D "b30af9e2d358182b5c744942=
4f017eba305ed32a7010509ede96cdc4696c46ed"
-SRC_URI[wasm-bindgen-macro-support-0.2.91.sha256sum] =3D "642f325be6301eb8=
107a83d12a8ac6c1e1c54345a7ef1a9261962dfefda09e66"
-SRC_URI[wasm-bindgen-shared-0.2.91.sha256sum] =3D "4f186bd2dcf04330886ce82=
d6f33dd75a7bfcf69ecf5763b89fcde53b6ac9838"
-SRC_URI[web-sys-0.3.68.sha256sum] =3D "96565907687f7aceb35bc5fc03770a8a047=
1d82e479f25832f54a0e3f4b28446"
+SRC_URI[wasm-bindgen-0.2.92.sha256sum] =3D "4be2531df63900aeb2bca0daaaddec=
08491ee64ceecbee5076636a3b026795a8"
+SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] =3D "614d787b966d3989fa7bb9=
8a654e369c762374fd3213d212cfc0251257e747da"
+SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] =3D "a1f8823de937b71b9460c0c3=
4e25f3da88250760bec0ebac694b49997550d726"
+SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] =3D "e94f17b526d0a461=
a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
+SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] =3D "af190c94f2773fdb3729c55=
b007a722abb5384da03bc0986df4c289bf5567e96"
+SRC_URI[web-sys-0.3.69.sha256sum] =3D "77afa9a11836342370f4817622a2f0f418b=
134426d91a82dfb48f532d2ec13ef"
 SRC_URI[weezl-0.1.8.sha256sum] =3D "53a85b86a771b1c87058196170769dd264f66c=
0782acf1ae6cc51bfd64b39082"
-SRC_URI[wide-0.7.15.sha256sum] =3D "89beec544f246e679fc25490e3f8e08003bc4b=
f612068f325120dad4cea02c1c"
+SRC_URI[wide-0.7.26.sha256sum] =3D "901e8597c777fa042e9e245bd56c0dc4418c5d=
b3f845b6ff94fbac732c6a0692"
 SRC_URI[winapi-0.3.9.sha256sum] =3D "5c839a674fcd7a98952e593242ea400abe939=
92746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] =3D "ac3b87c63620426dd=
9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.6.sha256sum] =3D "f29e6f9198ba0d26b4c9f07dbe6f9ed6=
33e1f3d5b8b414090084349e46a52596"
+SRC_URI[winapi-util-0.1.9.sha256sum] =3D "cf221c93e13a30d793f7645a0e7762c5=
5d169dbb0a49671918a2319d289b10bb"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] =3D "712e227841d057c=
1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[windows-core-0.52.0.sha256sum] =3D "33ab640c8d7e35bf8ba19b884ba838=
ceb4fba93a4e8c65a9059d08afcfc683d9"
-SRC_URI[windows-sys-0.48.0.sha256sum] =3D "677d2418bec65e3338edb076e806bc1=
ec15693c5d0104683f2efe857f61056a9"
 SRC_URI[windows-sys-0.52.0.sha256sum] =3D "282be5f36a8ce781fad8c8ae18fa3f9=
beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.48.5.sha256sum] =3D "9a2fa6e2155d7247be68c096456=
083145c183cbbbc2764150dda45a87197940c"
-SRC_URI[windows-targets-0.52.0.sha256sum] =3D "8a18201040b24831fbb9e4eb208=
f8892e1f50a37feb53cc7ff887feb8f50e7cd"
-SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] =3D "2b38e32f0abccf9987a=
4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
-SRC_URI[windows_aarch64_gnullvm-0.52.0.sha256sum] =3D "cb7764e35d4db8a7921=
e09562a0304bf2f93e0a51bfccee0bd0bb0b666b015ea"
-SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] =3D "dc35310971f3b2dbbf3f06=
90a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
-SRC_URI[windows_aarch64_msvc-0.52.0.sha256sum] =3D "bbaa0368d4f1d2aaefc55b=
6fcfee13f41544ddf36801e793edbbfd7d7df075ef"
-SRC_URI[windows_i686_gnu-0.48.5.sha256sum] =3D "a75915e7def60c94dcef72200b=
9a8e58e5091744960da64ec734a6c6e9b3743e"
-SRC_URI[windows_i686_gnu-0.52.0.sha256sum] =3D "a28637cb1fa3560a16915793af=
b20081aba2c92ee8af57b4d5f28e4b3e7df313"
-SRC_URI[windows_i686_msvc-0.48.5.sha256sum] =3D "8f55c233f70c4b27f66c52358=
0f78f1004e8b5a8b659e05a4eb49d4166cca406"
-SRC_URI[windows_i686_msvc-0.52.0.sha256sum] =3D "ffe5e8e31046ce6230cc72157=
07b816e339ff4d4d67c65dffa206fd0f7aa7b9a"
-SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] =3D "53d40abd2583d23e4718fddf=
1ebec84dbff8381c07cae67ff7768bbf19c6718e"
-SRC_URI[windows_x86_64_gnu-0.52.0.sha256sum] =3D "3d6fa32db2bc4a2f5abeacf2=
b69f7992cd09dca97498da74a151a3132c26befd"
-SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] =3D "0b7b52767868a23d5bab=
768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
-SRC_URI[windows_x86_64_gnullvm-0.52.0.sha256sum] =3D "1a657e1e9d3f514745a5=
72a6846d3c7aa7dbe1658c056ed9c3344c4109a6949e"
-SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] =3D "ed94fce61571a4006852b73=
89a063ab983c02eb1bb37b47f8272ce92d06d9538"
-SRC_URI[windows_x86_64_msvc-0.52.0.sha256sum] =3D "dff9641d1cd4be8d1a070da=
f9e3773c5f67e78b4d9d42263020c057706765c04"
-SRC_URI[winnow-0.5.39.sha256sum] =3D "5389a154b01683d28c77f8f68f49dea75f0a=
4da32557a58f68ee51ebba472d29"
-SRC_URI[xml5ever-0.17.0.sha256sum] =3D "4034e1d05af98b51ad7214527730626f01=
9682d797ba38b51689212118d8e650"
-SRC_URI[yeslogic-fontconfig-sys-4.0.1.sha256sum] =3D "ec657fd32bbcbeaef5c7=
bc8e10b3db95b143fab8db0a50079773dbf936fd4f73"
-SRC_URI[zune-inflate-0.2.54.sha256sum] =3D "73ab332fe2f6680068f3582b16a24f=
90ad7096d5d39b974d1c0aff0125116f02"
+SRC_URI[windows-sys-0.59.0.sha256sum] =3D "1e38bc4d79ed67fd075bcc251a1c39b=
32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-targets-0.52.6.sha256sum] =3D "9b724f72796e036ab90c1021d47=
80d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] =3D "32a4622180e7a0ec044=
bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] =3D "09ec2a7bb152e2252b53fa=
7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] =3D "8e9b5ad5ab802e97eb8e295ac6=
720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] =3D "0eee52d38c090b3caa76c5=
63b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] =3D "240948bc05c5e7c6dabba28bf=
89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] =3D "147a5c80aabfbf0c7d901cb5=
895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] =3D "24d5b23dc41741267968=
1396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] =3D "589f6da84c646204747d127=
0a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.5.40.sha256sum] =3D "f593a95398737aeed53e489c785df13f3618=
e41dbcd6718c6addbf1395aa6876"
+SRC_URI[winnow-0.6.18.sha256sum] =3D "68a9bda4691f099d435ad181000724da8e58=
99daa10713c2d432552b9ccd3a6f"
+SRC_URI[xml5ever-0.18.1.sha256sum] =3D "9bbb26405d8e919bc1547a5aa9abc95cbf=
a438f04844f5fdd9dc7596b748bf69"
+SRC_URI[yeslogic-fontconfig-sys-6.0.0.sha256sum] =3D "503a066b4c037c440169=
d995b869046827dbc71263f6e8f3be6d77d4f3229dbd"
+SRC_URI[zerocopy-0.7.35.sha256sum] =3D "1b9b4fd18abc82b8136838da5d50bae7bd=
ea537c574d8dc1a34ed098d6c166f0"
+SRC_URI[zerocopy-derive-0.7.35.sha256sum] =3D "fa4f8080344d4671fb4e831a13a=
d1e68092748387dfc4f55e356242fae12ce3e"
+SRC_URI[zune-core-0.4.12.sha256sum] =3D "3f423a2c17029964870cfaabb1f13dfab=
7d092a62a29a89264f4d36990ca414a"
+SRC_URI[zune-jpeg-0.4.13.sha256sum] =3D "16099418600b4d8f028622f73ff6e3dea=
abdff330fb9a2a131dea781ee8b0768"
diff --git a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-targe=
t-to-cargo-also-when-not-.patch b/recipes-gnome/librsvg/librsvg/0001-Makefi=
le.am-pass-rust-target-to-cargo-also-when-not-.patch
deleted file mode 100644
index 8051eb6..0000000
--- a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-ca=
rgo-also-when-not-.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 6e2cff10a4f24e89e6aee8250a9ac5527fdaa910 Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Tue, 21 Sep 2021 16:27:14 +0200
-Subject: [PATCH] Makefile.am: pass rust target to cargo also when not cross
- compiling
-
-Otherwise oe-core's native build doesn't work either.
-
-Upstream-Status: Inappropriate [oe-core specific]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- Makefile.am  | 2 --
- configure.ac | 4 +---
- 2 files changed, 1 insertion(+), 5 deletions(-)
-
-diff --git a/Makefile.am b/Makefile.am
-index b1cd889..9d33432 100644
---- a/Makefile.am
-+++ b/Makefile.am
-@@ -170,9 +170,7 @@ else
- CARGO_RELEASE_ARGS=3D--release
- endif
-=20
--if CROSS_COMPILING
- CARGO_TARGET_ARGS=3D--target=3D$(RUST_TARGET)
--endif
-=20
- CARGO_VERBOSE =3D $(cargo_verbose_$(V))
- cargo_verbose_ =3D $(cargo_verbose_$(AM_DEFAULT_VERBOSITY))
-diff --git a/configure.ac b/configure.ac
-index 2c4995e..1370a36 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -291,9 +291,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=3D$h=
ost)])
- : ${RUST_TARGET:=3D$host}
-=20
- AM_CONDITIONAL([CROSS_COMPILING], [test "x$cross_compiling" =3D xyes])
--AS_IF([test "x$cross_compiling" =3D "xyes"], [
--	RUST_TARGET_SUBDIR=3D"$RUST_TARGET/$RUST_TARGET_SUBDIR"
--])
-+RUST_TARGET_SUBDIR=3D"$RUST_TARGET/$RUST_TARGET_SUBDIR"
- AC_SUBST([RUST_TARGET_SUBDIR])
-=20
- dnl =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
diff --git a/recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.bui=
ld-do-not-look-for-gdk-pi.patch b/recipes-gnome/librsvg/librsvg/0001-gdk-pi=
xbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
new file mode 100644
index 0000000..9b8468f
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-n=
ot-look-for-gdk-pi.patch
@@ -0,0 +1,28 @@
+From 57f98688e46b128f7767479ef373e8cb5e3304b8 Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Wed, 27 Nov 2024 16:34:06 +0100
+Subject: [PATCH] gdk-pixbuf-loader/meson.build: do not look for
+ gdk-pixbuf-query-loaders
+
+Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1061]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ gdk-pixbuf-loader/meson.build | 2 --
+ 1 file changed, 2 deletions(-)
+
+diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
+index 5081844..4ae58c6 100644
+--- a/gdk-pixbuf-loader/meson.build
++++ b/gdk-pixbuf-loader/meson.build
+@@ -36,8 +36,6 @@ pixbuf_thumbnailer =3D configure_file(
+   install_dir: get_option('datadir') / 'thumbnailers'=0D
+ )=0D
+ =0D
+-gdk_pixbuf_query_loaders =3D find_program(pixbuf_dep.get_variable(pkgconf=
ig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'))=
=0D
+-=0D
+ pixbufloader_svg_install_args =3D [=0D
+   '--gdk-pixbuf-moduledir',=0D
+   pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_de=
fine: ['prefix', prefix]),=0D
+--=20
+2.39.5
+
diff --git a/recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-di=
sable-introspection-and-v.patch b/recipes-gnome/librsvg/librsvg/0001-meson.=
build-do-not-force-disable-introspection-and-v.patch
new file mode 100644
index 0000000..f33e90a
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-i=
ntrospection-and-v.patch
@@ -0,0 +1,34 @@
+From 57d02c05184ae565ef8182c7151c1faa97d45b2b Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Wed, 27 Nov 2024 16:28:49 +0100
+Subject: [PATCH] meson.build: do not force-disable introspection and vala =
in
+ cross builds
+
+It is entirely possible to make them work through qemu wrappers
+(and g-i has upstream support for it).
+
+Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1062]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ meson.build | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/meson.build b/meson.build
+index 12cb44f..2dae10c 100644
+--- a/meson.build
++++ b/meson.build
+@@ -160,9 +160,9 @@ endif
+ if host_system =3D=3D 'windows'
+   build_gir =3D get_option('introspection').require(get_option('default_l=
ibrary') !=3D 'static' and not meson.is_cross_build() and gi_dep.found())
+ else
+-  build_gir =3D get_option('introspection').require(not meson.is_cross_bu=
ild() and gi_dep.found())
++  build_gir =3D get_option('introspection').require(gi_dep.found())
+ endif
+-build_vala =3D get_option('vala').require(not meson.is_cross_build() and =
vapigen_dep.found())
++build_vala =3D get_option('vala').require(vapigen_dep.found())
+=20
+ build_pixbuf_loader =3D get_option('pixbuf-loader').require(pixbuf_dep.fo=
und())
+=20
+--=20
+2.39.5
+
diff --git a/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch b=
/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
deleted file mode 100644
index e56772a..0000000
--- a/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From df94cfa4a637c229fef32c349b5c2dfee2dca3fc Mon Sep 17 00:00:00 2001
-From: Ross Burton <ross.burton@arm.com>
-Date: Thu, 27 Jun 2024 17:09:11 +0100
-Subject: [PATCH] Don't build rsvg-loader in cross builds
-
-This binary is a non-installed test binary that isn't any use in cross bui=
lds, and
-causes problems because it generates a gdk-pixbuf loader cache at build ti=
me using
-a mix of host and target libraries.
-
-As we don't install the binary, we can just not build it.
-
-Upstream-Status: Inappropriate [upstream has moved to Meson]
-Signed-off-by: Ross Burton <ross.burton@arm.com>
----
- gdk-pixbuf-loader/Makefile.am | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/gdk-pixbuf-loader/Makefile.am b/gdk-pixbuf-loader/Makefile.am
-index 44df9c6c..fb417d24 100644
---- a/gdk-pixbuf-loader/Makefile.am
-+++ b/gdk-pixbuf-loader/Makefile.am
-@@ -30,6 +30,7 @@ if PLATFORM_WIN32
- libpixbufloader_svg_la_LDFLAGS +=3D -no-undefined
- endif
-=20
-+if !CROSS_COMPILING
- noinst_PROGRAMS =3D rsvg-loader
-=20
- rsvg_loader_SOURCES =3D \
-@@ -52,6 +53,7 @@ EXTRA_rsvg_loader_DEPENDENCIES =3D libpixbufloader-svg.l=
a gdk-pixbuf-loaders
-=20
- gdk-pixbuf-loaders: Makefile
- 	$(AM_V_GEN) ( $(GDK_PIXBUF_QUERYLOADERS) ./libpixbufloader-svg.la && GDK=
_PIXBUF_MODULEDIR=3D$(gdk_pixbuf_moduledir) $(GDK_PIXBUF_QUERYLOADERS)) > g=
dk-pixbuf.loaders 2>/dev/null
-+endif
-=20
- if CROSS_COMPILING
- RUN_QUERY_LOADER_TEST=3Dfalse
---=20
-2.34.1
-
diff --git a/recipes-gnome/librsvg/librsvg_2.58.2.bb b/recipes-gnome/librsv=
g/librsvg_2.59.2.bb
similarity index 67%
rename from recipes-gnome/librsvg/librsvg_2.58.2.bb
rename to recipes-gnome/librsvg/librsvg_2.59.2.bb
index 19e2699..7718f2b 100644
--- a/recipes-gnome/librsvg/librsvg_2.58.2.bb
+++ b/recipes-gnome/librsvg/librsvg_2.59.2.bb
@@ -11,20 +11,21 @@ LIC_FILES_CHKSUM =3D "file://COPYING.LIB;md5=3D4fbd6538=
0cdd255951079008b364516c \
                    "
=20
 SECTION =3D "x11/utils"
-DEPENDS =3D "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-nati=
ve"
+DEPENDS =3D "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-nati=
ve cargo-c-native"
 BBCLASSEXTEND =3D "native nativesdk"
=20
-GNOMEBASEBUILDCLASS =3D "autotools"
 inherit cargo_common gnomebase pixbufcache gobject-introspection rust vala=
 gi-docgen cargo-update-recipe-crates
+GIR_MESON_ENABLE_FLAG =3D 'enabled'
+GIR_MESON_DISABLE_FLAG =3D 'disabled'
+GIDOCGEN_MESON_OPTION =3D 'docs'
+GIDOCGEN_MESON_ENABLE_FLAG =3D 'enabled'
+GIDOCGEN_MESON_DISABLE_FLAG =3D 'disabled'
=20
 require ${BPN}-crates.inc
=20
-SRC_URI +=3D " \
-           file://0001-Makefile.am-pass-rust-target-to-cargo-also-when-not=
-.patch \
-           file://disable-rsvg-loader-test.patch \
-           "
-
-SRC_URI[archive.sha256sum] =3D "18e9d70c08cf25f50d610d6d5af571561d67cf4179=
f962e04266475df6e2e224"
+SRC_URI +=3D "file://0001-meson.build-do-not-force-disable-introspection-a=
nd-v.patch \
+            file://0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-=
pi.patch"
+SRC_URI[archive.sha256sum] =3D "ecd293fb0cc338c170171bbc7bcfbea6725d041c95=
f31385dc935409933e4597"
=20
 UPSTREAM_CHECK_REGEX =3D "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
=20
@@ -33,11 +34,10 @@ UPSTREAM_CHECK_REGEX =3D "librsvg-(?P<pver>\d+\.\d+\.(?=
!9\d+)\d+)"
 # for cargo to be happy
 BASEDEPENDS:append =3D " cargo-native"
=20
+export EXTRA_NATIVE_PKGCONFIG_PATH =3D "${B}/meson-uninstalled:"
 export RUST_BACKTRACE =3D "full"
 export RUSTFLAGS
=20
-export RUST_TARGET =3D "${RUST_HOST_SYS}"
-
 RUSTFLAGS:append:mips =3D " --cfg crossbeam_no_atomic_64"
 RUSTFLAGS:append:mipsel =3D " --cfg crossbeam_no_atomic_64"
 RUSTFLAGS:append:powerpc =3D " --cfg crossbeam_no_atomic_64"
@@ -56,13 +56,16 @@ do_compile:prepend() {
=20
 CVE_STATUS[CVE-2018-1000041] =3D "not-applicable-platform: Issue only appl=
ies on Windows"
=20
-CACHED_CONFIGUREVARS =3D "ac_cv_path_GDK_PIXBUF_QUERYLOADERS=3D${STAGING_L=
IBDIR_NATIVE}/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders"
+EXTRA_OEMESON =3D "-Dtriplet=3D${RUST_HOST_SYS}"
+LDFLAGS +=3D " -L${B}/rsvg"
+# needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym=
'' errors
+BUILD_LDFLAGS +=3D " -ldl"
=20
 PACKAGECONFIG ??=3D "gdkpixbuf"
 PACKAGECONFIG:append:class-target =3D " ${@bb.utils.contains('GI_DATA_ENAB=
LED', 'True', 'vala', '', d)}"
 # The gdk-pixbuf loader
-PACKAGECONFIG[gdkpixbuf] =3D "--enable-pixbuf-loader,--disable-pixbuf-load=
er,gdk-pixbuf-native"
-PACKAGECONFIG[vala] =3D "--enable-vala,--disable-vala"
+PACKAGECONFIG[gdkpixbuf] =3D "-Dpixbuf-loader=3Denabled,-Dpixbuf-loader=3D=
disabled,gdk-pixbuf-native"
+PACKAGECONFIG[vala] =3D "-Dvala=3Denabled,-Dvala=3Ddisabled"
=20
 do_install:append() {
 	# Loadable modules don't need .a or .la on Linux
@@ -78,3 +81,12 @@ FILES:librsvg-gtk =3D "${libdir}/gdk-pixbuf-2.0/*/*/*.so=
 \
 RRECOMMENDS:librsvg-gtk =3D "gdk-pixbuf-bin"
=20
 PIXBUF_PACKAGES =3D "librsvg-gtk"
+
+SYSROOT_PREPROCESS_FUNCS:append:class-target =3D " pkgconfig_sysroot_prepr=
ocess"
+
+# installed .pc file contains
+# prefix=3D${pcfiledir}/../..
+# which is expanded to an absolute path, and thus doesn't work when additi=
onally prefixed with a sysroot directory
+pkgconfig_sysroot_preprocess() {
+        sed -i -e "s:^prefix=3D.*:prefix=3D${prefix}:g" ${SYSROOT_DESTDIR}=
${libdir}/pkgconfig/librsvg-2.0.pc
+}
--=20
2.48.1


