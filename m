Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3057.1795645891901835350
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IZlm+WSP;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55c35262674so48332331cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645891; x=1796250691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Untb4BcoLE8+J16tOX0Msq9rirr53vLcV4WmRAQPM9s=;
        b=IZlm+WSP9cdeeOxOMdyp09SnHaBF3ejlN165IC540giXyo6SC2cBdDuJTYpME+1E+F
         X2bsTFWzYsDXqkQgNikE/OnjRqKrIoEW/tR7xv+183/17/pmB16J+KPb7SPoKyLiDIRp
         6dxRAy+MTeE8rD+v2AX+xU8qwGdoJIImhNWM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645891; x=1796250691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Untb4BcoLE8+J16tOX0Msq9rirr53vLcV4WmRAQPM9s=;
        b=vlZoRjjKsuv3ck8PTRWEynkwGpDJkB0SN99qv1wGTQ30nF83OKjiKFF+9uXYYygS6A
         qt8kTrrG0uIQjcYw0hKnOJoCk6crkQeUnRtplcSsiRU33hjhBx0tB1sYvd8Il/E8kcaq
         PcjOv/yvFsBqgLtab+bXCvfRldugIQ3ivJJKsr/osuFdVmBIGDXVeIulHbbx3fUiKOsj
         4wRJQ2zHQvl130I0G3b/MbWm/MKcYYP4YITTXZm8Blguh/68T4GilZmkEJDTQtHhkbzX
         tt1PR2ogM0c1xuXzkIqSyKvoVBCXQlFv+FO5fcoVb9C3gui3PRXpTtBSJ5QukS/UJB2F
         +v2Q==
X-Gm-Message-State: APuU4Z9pjwpwueamABzo4TnSWnqVanlH1Viq+wh9xzMn+5mBMZMDfhV0
	GmwV6qWvW1oIW+0iCdvmwka9xSOvQjjDxCOdikISQFlbdlyZqcVCqeDeh+JKrm+mfubU4pE+Mf8
	2VjKJ
X-Gm-Gg: AZFdTZdXzV3mGKuwsZEXBxoYEymHXmoSXQy/gz4KUwtozAj+cFAnBU5LI9nchzuImWP
	yHJYal8BMheFaw47EXr8gVSNr3CtLP2ARfyQGpnFbx+sk7uz3lHECB1LMAhitlu/dbi7Zbud/Qt
	VNXs0pxeVIHXRwc3mJwsh7pJk6XX8A8Lb517N0D+eTCZRwz8IvLuVlqZjIkeY/CJr43H/2iwwwE
	tKuTEst2UUarV3Q+VdA9AdtVlKPG02F6n2Sepu+FTdyTCNNJLGuUIFddKbaJINVuxpF/Fu734Pu
	MsXjQOrV/APrp+oQBkefDrL3xHQhUCTPPaFqdxSVtprRNxUnHMb/9aDAqm7KCpePHN0WjVKOCv9
	1QIcEZJI/24xhjFMvleZagc42RbrYMb7sOqYqBWsykmQG2T4sOGWJa5cLidtSutf1/KPUhwvvC8
	13QySpi7JwahzjLlFj5inlGTPDL0ckGq6YglCVoPDjHkE/+x0RfPi9IQa5/SEIgm8l0ubA/6P4u
	I+sGfLt4060HVb6ddkXEfPgib9Ni0PWGhXiE5u6hJpQzkfjndDk5IsF+RKAUUNvP38tTit5py04
	iOQz8rUGaEAY+EeF1MtnNnZP/BM7qUMt3b1fKx1nnH1P4yib6dtTS6DkFI81mVSvZ5OVYsO/GLb
	Y0/jApKo+aTWylFU4DLlIU4+bTQXZcDIWFyQ4VfiUKVWTZFQkyFJ+E7aANGnoCWeuyA==
X-Received: by 2002:a05:622a:13c7:b0:55d:2f53:4e7e with SMTP id d75a77b69052e-55d76a5fa45mr390449731cf.68.1795645890085;
        Wed, 25 Nov 2026 14:31:30 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:29 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/19] librsvg: upgrade 2.63.0 -> 2.63.2
Date: Wed, 25 Nov 2026 17:31:00 -0500
Message-ID: <ac60e470770a87fa7ce06d0521890a798fef8b4e.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5529
Content-Type: text/plain; charset="utf-8"

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Version 2.63.2
==============

librsvg crate version 2.63.2

librsvg-rebind crate version 0.3.0

- #1241: Fix use-after-free when there are duplicate XML entities in
  nested Xinclude documents.  Thanks to Rafael B. Dias for reporting
  this in detail.

Version 2.63.1
==============

This version is to be considered non-working; the chacha20 0.10.1
crate was yanked from crates.io.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 002addb0adbb6aabeeb2f61d463e274e44076814)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 342 +++++++++---------
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |   2 +-
 .../{librsvg_2.63.0.bb => librsvg_2.63.2.bb}  |   2 +-
 4 files changed, 181 insertions(+), 167 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.63.0.bb => librsvg_2.63.2.bb} (98%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 3945c46..1177c27 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -3,7 +3,7 @@
 # from Cargo.lock
 SRC_URI += " \
     crate://crates.io/adler2/2.0.1 \
-    crate://crates.io/aes/0.9.2 \
+    crate://crates.io/aes/0.9.3 \
     crate://crates.io/ahash/0.8.12 \
     crate://crates.io/aho-corasick/1.1.5 \
     crate://crates.io/alloca/0.4.0 \
@@ -22,7 +22,7 @@ SRC_URI += " \
     crate://crates.io/bit-set/0.8.0 \
     crate://crates.io/bit-vec/0.8.0 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.13.1 \
+    crate://crates.io/bitflags/2.13.2 \
     crate://crates.io/bitreader/0.3.11 \
     crate://crates.io/block/0.1.6 \
     crate://crates.io/block-buffer/0.12.1 \
@@ -34,41 +34,42 @@ SRC_URI += " \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/byteorder-lite/0.1.0 \
     crate://crates.io/bytes/1.12.1 \
-    crate://crates.io/cairo-rs/0.22.0 \
-    crate://crates.io/cairo-sys-rs/0.22.0 \
+    crate://crates.io/cairo-rs/0.22.9 \
+    crate://crates.io/cairo-sys-rs/0.22.9 \
     crate://crates.io/cast/0.3.0 \
     crate://crates.io/cbc/0.2.1 \
-    crate://crates.io/cc/1.4.2 \
-    crate://crates.io/cfg-expr/0.20.8 \
-    crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/chacha20/0.10.1 \
+    crate://crates.io/cc/1.4.7 \
+    crate://crates.io/cfg-expr/0.20.9 \
+    crate://crates.io/cfg-if/1.0.5 \
+    crate://crates.io/chacha20/0.10.2 \
     crate://crates.io/chrono/0.4.45 \
     crate://crates.io/ciborium/0.2.2 \
     crate://crates.io/ciborium-io/0.2.2 \
     crate://crates.io/ciborium-ll/0.2.2 \
     crate://crates.io/cipher/0.5.2 \
-    crate://crates.io/clap/4.6.6 \
-    crate://crates.io/clap_builder/4.6.6 \
-    crate://crates.io/clap_complete/4.6.9 \
-    crate://crates.io/clap_derive/4.6.4 \
-    crate://crates.io/clap_lex/1.1.0 \
+    crate://crates.io/clap/4.6.7 \
+    crate://crates.io/clap_builder/4.6.7 \
+    crate://crates.io/clap_complete/4.6.11 \
+    crate://crates.io/clap_derive/4.6.7 \
+    crate://crates.io/clap_lex/1.1.1 \
     crate://crates.io/color_quant/1.1.0 \
     crate://crates.io/colorchoice/1.0.5 \
     crate://crates.io/const-oid/0.10.2 \
     crate://crates.io/core-foundation-sys/0.8.7 \
+    crate://crates.io/core_detect/1.0.0 \
     crate://crates.io/cpubits/0.1.1 \
-    crate://crates.io/cpufeatures/0.3.0 \
-    crate://crates.io/crc32fast/1.5.0 \
+    crate://crates.io/cpufeatures/0.3.1 \
+    crate://crates.io/crc32fast/1.5.2 \
     crate://crates.io/criterion/0.8.2 \
     crate://crates.io/criterion-plot/0.8.2 \
-    crate://crates.io/crossbeam-deque/0.8.7 \
-    crate://crates.io/crossbeam-epoch/0.9.20 \
-    crate://crates.io/crossbeam-utils/0.8.22 \
+    crate://crates.io/crossbeam-deque/0.8.8 \
+    crate://crates.io/crossbeam-epoch/0.9.21 \
+    crate://crates.io/crossbeam-utils/0.8.23 \
     crate://crates.io/crunchy/0.2.4 \
     crate://crates.io/crypto-common/0.2.2 \
     crate://crates.io/cssparser/0.37.0 \
     crate://crates.io/cssparser-color/0.5.0 \
-    crate://crates.io/cssparser-macros/0.7.0 \
+    crate://crates.io/cssparser-macros/0.7.1 \
     crate://crates.io/data-url/0.3.2 \
     crate://crates.io/dav1d/0.11.1 \
     crate://crates.io/dav1d-sys/0.8.3 \
@@ -85,16 +86,16 @@ SRC_URI += " \
     crate://crates.io/dlib/0.5.3 \
     crate://crates.io/dtoa/1.0.11 \
     crate://crates.io/dtoa-short/0.3.5 \
-    crate://crates.io/ecb/0.2.0 \
-    crate://crates.io/either/1.17.0 \
-    crate://crates.io/encoding_rs/0.8.35 \
+    crate://crates.io/ecb/0.2.1 \
+    crate://crates.io/either/1.18.0 \
+    crate://crates.io/encoding_rs/0.8.41 \
     crate://crates.io/equivalent/1.0.2 \
     crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible_collections/0.4.9 \
     crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/fdeflate/0.3.7 \
-    crate://crates.io/find-msvc-tools/0.1.10 \
-    crate://crates.io/flate2/1.1.9 \
+    crate://crates.io/find-msvc-tools/0.1.13 \
+    crate://crates.io/flate2/1.1.10 \
     crate://crates.io/float-cmp/0.10.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.2 \
@@ -106,65 +107,65 @@ SRC_URI += " \
     crate://crates.io/futures-task/0.3.34 \
     crate://crates.io/futures-util/0.3.34 \
     crate://crates.io/gdk-pixbuf/0.22.0 \
-    crate://crates.io/gdk-pixbuf-sys/0.22.0 \
+    crate://crates.io/gdk-pixbuf-sys/0.22.9 \
     crate://crates.io/getrandom/0.3.4 \
     crate://crates.io/getrandom/0.4.3 \
     crate://crates.io/gif/0.14.2 \
-    crate://crates.io/gio/0.22.8 \
-    crate://crates.io/gio-sys/0.22.8 \
+    crate://crates.io/gio/0.22.9 \
+    crate://crates.io/gio-sys/0.22.9 \
     crate://crates.io/gio-unix/0.22.8 \
-    crate://crates.io/gio-unix-sys/0.22.0 \
+    crate://crates.io/gio-unix-sys/0.22.9 \
     crate://crates.io/gio-win32/0.22.8 \
-    crate://crates.io/gio-win32-sys/0.22.0 \
+    crate://crates.io/gio-win32-sys/0.22.9 \
     crate://crates.io/glam/0.30.10 \
     crate://crates.io/glam/0.31.1 \
     crate://crates.io/glam/0.32.1 \
-    crate://crates.io/glam/0.33.3 \
-    crate://crates.io/glib/0.22.8 \
-    crate://crates.io/glib-macros/0.22.6 \
-    crate://crates.io/glib-sys/0.22.8 \
-    crate://crates.io/gobject-sys/0.22.6 \
+    crate://crates.io/glam/0.33.7 \
+    crate://crates.io/glib/0.22.9 \
+    crate://crates.io/glib-macros/0.22.9 \
+    crate://crates.io/glib-sys/0.22.9 \
+    crate://crates.io/gobject-sys/0.22.9 \
     crate://crates.io/half/2.7.1 \
     crate://crates.io/hashbrown/0.13.2 \
     crate://crates.io/hashbrown/0.17.1 \
     crate://crates.io/heck/0.5.0 \
-    crate://crates.io/hybrid-array/0.4.14 \
+    crate://crates.io/hybrid-array/0.4.15 \
     crate://crates.io/iana-time-zone/0.1.65 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/icu_collections/2.2.0 \
-    crate://crates.io/icu_locale_core/2.2.0 \
-    crate://crates.io/icu_normalizer/2.2.0 \
-    crate://crates.io/icu_normalizer_data/2.2.0 \
-    crate://crates.io/icu_properties/2.2.0 \
-    crate://crates.io/icu_properties_data/2.2.0 \
-    crate://crates.io/icu_provider/2.2.0 \
+    crate://crates.io/icu_collections/2.3.0 \
+    crate://crates.io/icu_locale_core/2.3.0 \
+    crate://crates.io/icu_normalizer/2.3.0 \
+    crate://crates.io/icu_normalizer_data/2.3.0 \
+    crate://crates.io/icu_properties/2.3.0 \
+    crate://crates.io/icu_properties_data/2.3.0 \
+    crate://crates.io/icu_provider/2.3.1 \
     crate://crates.io/idna/1.1.0 \
     crate://crates.io/idna_adapter/1.2.2 \
     crate://crates.io/image/0.25.10 \
     crate://crates.io/image-webp/0.2.4 \
-    crate://crates.io/indexmap/2.14.0 \
+    crate://crates.io/indexmap/2.14.2 \
     crate://crates.io/inout/0.2.2 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.13.0 \
     crate://crates.io/itertools/0.15.0 \
     crate://crates.io/itoa/1.0.18 \
-    crate://crates.io/jiff/0.2.35 \
-    crate://crates.io/jiff-core/0.1.0 \
-    crate://crates.io/jiff-static/0.2.35 \
+    crate://crates.io/jiff/0.2.37 \
+    crate://crates.io/jiff-core/0.1.1 \
+    crate://crates.io/jiff-static/0.2.37 \
     crate://crates.io/jiff-tzdb/0.1.8 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.35 \
-    crate://crates.io/js-sys/0.3.104 \
+    crate://crates.io/js-sys/0.3.105 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/libc/0.2.189 \
     crate://crates.io/libfuzzer-sys/0.4.13 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/linux-raw-sys/0.12.1 \
-    crate://crates.io/litemap/0.8.2 \
+    crate://crates.io/litemap/0.8.3 \
     crate://crates.io/locale_config/0.3.0 \
     crate://crates.io/lock_api/0.4.14 \
-    crate://crates.io/log/0.4.33 \
+    crate://crates.io/log/0.4.34 \
     crate://crates.io/lopdf/0.44.0 \
     crate://crates.io/malloc_buf/0.0.6 \
     crate://crates.io/markup5ever/0.39.0 \
@@ -173,8 +174,12 @@ SRC_URI += " \
     crate://crates.io/md-5/0.11.0 \
     crate://crates.io/memchr/2.8.3 \
     crate://crates.io/miniz_oxide/0.8.9 \
+    crate://crates.io/miniz_oxide/0.9.1 \
     crate://crates.io/moxcms/0.8.1 \
     crate://crates.io/mp4parse/0.17.0 \
+    crate://crates.io/multiversion/0.9.0 \
+    crate://crates.io/multiversion-macros/0.9.0 \
+    crate://crates.io/multiversion_no_op/1.0.0 \
     crate://crates.io/mutants/0.0.4 \
     crate://crates.io/nalgebra/0.35.0 \
     crate://crates.io/nalgebra-macros/0.3.0 \
@@ -185,7 +190,7 @@ SRC_URI += " \
     crate://crates.io/num-complex/0.4.6 \
     crate://crates.io/num-conv/0.2.2 \
     crate://crates.io/num-derive/0.4.2 \
-    crate://crates.io/num-integer/0.1.46 \
+    crate://crates.io/num-integer/0.1.47 \
     crate://crates.io/num-rational/0.4.2 \
     crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/objc/0.2.7 \
@@ -195,10 +200,10 @@ SRC_URI += " \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/oorandom/11.1.5 \
     crate://crates.io/page_size/0.6.0 \
-    crate://crates.io/pango/0.22.8 \
-    crate://crates.io/pango-sys/0.22.0 \
-    crate://crates.io/pangocairo/0.22.8 \
-    crate://crates.io/pangocairo-sys/0.22.0 \
+    crate://crates.io/pango/0.22.9 \
+    crate://crates.io/pango-sys/0.22.9 \
+    crate://crates.io/pangocairo/0.22.9 \
+    crate://crates.io/pangocairo-sys/0.22.9 \
     crate://crates.io/parking_lot/0.12.5 \
     crate://crates.io/parking_lot_core/0.9.12 \
     crate://crates.io/percent-encoding/2.3.2 \
@@ -209,14 +214,14 @@ SRC_URI += " \
     crate://crates.io/phf_shared/0.13.1 \
     crate://crates.io/phf_shared/0.14.0 \
     crate://crates.io/pin-project-lite/0.2.17 \
-    crate://crates.io/pkg-config/0.3.33 \
+    crate://crates.io/pkg-config/0.3.34 \
     crate://crates.io/plotters/0.3.7 \
     crate://crates.io/plotters-backend/0.3.7 \
     crate://crates.io/plotters-svg/0.3.7 \
     crate://crates.io/png/0.18.1 \
     crate://crates.io/portable-atomic/1.15.0 \
-    crate://crates.io/portable-atomic-util/0.2.7 \
-    crate://crates.io/potential_utf/0.1.5 \
+    crate://crates.io/portable-atomic-util/0.2.8 \
+    crate://crates.io/potential_utf/0.1.6 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/precomputed-hash/0.1.1 \
@@ -238,7 +243,7 @@ SRC_URI += " \
     crate://crates.io/rand_core/0.9.5 \
     crate://crates.io/rand_core/0.10.1 \
     crate://crates.io/rand_xorshift/0.4.0 \
-    crate://crates.io/rangemap/1.7.1 \
+    crate://crates.io/rangemap/1.8.0 \
     crate://crates.io/rawpointer/0.2.1 \
     crate://crates.io/rayon/1.12.0 \
     crate://crates.io/rayon-core/1.13.0 \
@@ -250,10 +255,10 @@ SRC_URI += " \
     crate://crates.io/rgb/0.8.53 \
     crate://crates.io/rustc-hash/2.1.3 \
     crate://crates.io/rustc_version/0.4.1 \
-    crate://crates.io/rustix/1.1.4 \
+    crate://crates.io/rustix/1.1.5 \
     crate://crates.io/rustversion/1.0.23 \
     crate://crates.io/rusty-fork/0.3.1 \
-    crate://crates.io/safe_arch/1.1.0 \
+    crate://crates.io/safe_arch/1.2.0 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/selectors/0.40.0 \
@@ -269,9 +274,10 @@ SRC_URI += " \
     crate://crates.io/shlex/2.0.1 \
     crate://crates.io/simba/0.10.2 \
     crate://crates.io/simd-adler32/0.3.10 \
+    crate://crates.io/simdutf8/0.1.5 \
     crate://crates.io/siphasher/1.0.3 \
     crate://crates.io/slab/0.4.12 \
-    crate://crates.io/smallvec/1.15.2 \
+    crate://crates.io/smallvec/1.16.1 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/string_cache/0.9.0 \
@@ -280,9 +286,10 @@ SRC_URI += " \
     crate://crates.io/stringprep/0.1.5 \
     crate://crates.io/strsim/0.11.1 \
     crate://crates.io/syn/2.0.119 \
-    crate://crates.io/syn/3.0.3 \
-    crate://crates.io/synstructure/0.13.2 \
+    crate://crates.io/syn/3.0.6 \
+    crate://crates.io/synstructure/0.14.0 \
     crate://crates.io/system-deps/7.0.8 \
+    crate://crates.io/system-deps/9.0.0 \
     crate://crates.io/target-lexicon/0.13.5 \
     crate://crates.io/tempfile/3.27.0 \
     crate://crates.io/tendril/0.5.1 \
@@ -292,18 +299,17 @@ SRC_URI += " \
     crate://crates.io/time/0.3.55 \
     crate://crates.io/time-core/0.1.9 \
     crate://crates.io/time-macros/0.2.32 \
-    crate://crates.io/tinystr/0.8.3 \
+    crate://crates.io/tinystr/0.8.4 \
     crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/tinyvec/1.12.0 \
-    crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/1.1.4+spec-1.1.0 \
+    crate://crates.io/tinyvec/1.13.3 \
+    crate://crates.io/toml/1.1.6+spec-1.1.0 \
     crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
     crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
     crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
     crate://crates.io/typenum/1.20.1 \
     crate://crates.io/unarray/0.1.4 \
     crate://crates.io/unicode-bidi/0.3.18 \
-    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-ident/1.0.26 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-properties/0.1.4 \
     crate://crates.io/url/2.5.8 \
@@ -314,15 +320,15 @@ SRC_URI += " \
     crate://crates.io/wait-timeout/0.2.1 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasip2/1.0.4+wasi-0.2.12 \
-    crate://crates.io/wasm-bindgen/0.2.127 \
-    crate://crates.io/wasm-bindgen-macro/0.2.127 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.127 \
-    crate://crates.io/wasm-bindgen-shared/0.2.127 \
-    crate://crates.io/web-sys/0.3.104 \
+    crate://crates.io/wasm-bindgen/0.2.128 \
+    crate://crates.io/wasm-bindgen-macro/0.2.128 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.128 \
+    crate://crates.io/wasm-bindgen-shared/0.2.128 \
+    crate://crates.io/web-sys/0.3.105 \
     crate://crates.io/web_atoms/0.2.6 \
     crate://crates.io/weezl/0.1.12 \
     crate://crates.io/weezl/0.2.1 \
-    crate://crates.io/wide/1.6.1 \
+    crate://crates.io/wide/1.7.1 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.11 \
@@ -336,26 +342,27 @@ SRC_URI += " \
     crate://crates.io/windows-sys/0.61.2 \
     crate://crates.io/winnow/1.0.4 \
     crate://crates.io/wit-bindgen/0.57.1 \
-    crate://crates.io/writeable/0.6.3 \
+    crate://crates.io/writeable/0.6.4 \
     crate://crates.io/xml5ever/0.39.0 \
     crate://crates.io/yansi/1.0.1 \
     crate://crates.io/yeslogic-fontconfig-sys/6.0.1 \
     crate://crates.io/yoke/0.8.3 \
-    crate://crates.io/yoke-derive/0.8.2 \
-    crate://crates.io/zerocopy/0.8.56 \
-    crate://crates.io/zerocopy-derive/0.8.56 \
+    crate://crates.io/yoke-derive/0.8.3 \
+    crate://crates.io/zerocopy/0.8.57 \
+    crate://crates.io/zerocopy-derive/0.8.57 \
     crate://crates.io/zerofrom/0.1.8 \
-    crate://crates.io/zerofrom-derive/0.1.7 \
-    crate://crates.io/zerotrie/0.2.4 \
-    crate://crates.io/zerovec/0.11.6 \
-    crate://crates.io/zerovec-derive/0.11.3 \
+    crate://crates.io/zerofrom-derive/0.1.8 \
+    crate://crates.io/zerotrie/0.2.5 \
+    crate://crates.io/zerovec/0.11.8 \
+    crate://crates.io/zerovec-derive/0.11.6 \
+    crate://crates.io/zlib-rs/0.6.8 \
     crate://crates.io/zmij/1.0.23 \
     crate://crates.io/zune-core/0.5.3 \
     crate://crates.io/zune-jpeg/0.5.15 \
 "
 
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
-SRC_URI[aes-0.9.2.sha256sum] = "f8eb277bec05f56a0e0591f155a484cbd0f4f07ff2905051a48c72f004f7ed58"
+SRC_URI[aes-0.9.3.sha256sum] = "35f0f96ce78e38c3dc6d8948aa8163d06385be74000f3c7a95bf1eef35d3ea32"
 SRC_URI[ahash-0.8.12.sha256sum] = "5a15f179cd60c4584b8a8c596927aadc462e27f2ca70c04e0071964a73ba7a75"
 SRC_URI[aho-corasick-1.1.5.sha256sum] = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
 SRC_URI[alloca-0.4.0.sha256sum] = "e5a7d05ea6aea7e9e64d25b9156ba2fee3fdd659e34e41063cd2fc7cd020d7f4"
@@ -374,7 +381,7 @@ SRC_URI[av-data-0.4.4.sha256sum] = "fca67ba5d317924c02180c576157afd54babe48a76eb
 SRC_URI[bit-set-0.8.0.sha256sum] = "08807e080ed7f9d5433fa9b275196cfc35414f66a0c79d864dc51a0d825231a3"
 SRC_URI[bit-vec-0.8.0.sha256sum] = "5e764a1d40d510daf35e07be9eb06e75770908c27d411ee6c92109c9840eaaf7"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.13.1.sha256sum] = "b588b76d00fde79687d7646a9b5bdf3cc0f655e0bbd080335a95d7e96f3587da"
+SRC_URI[bitflags-2.13.2.sha256sum] = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
 SRC_URI[bitreader-0.3.11.sha256sum] = "886559b1e163d56c765bc3a985febb4eee8009f625244511d8ee3c432e08c066"
 SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
 SRC_URI[block-buffer-0.12.1.sha256sum] = "d2f6c7dbe95a6ed67ad9f18e57daf93a2f034c524b99fd2b76d18fdfeb6660aa"
@@ -386,41 +393,42 @@ SRC_URI[bytemuck-1.25.2.sha256sum] = "95832e849adfb21180ccb6826a99da14e5d266ae5c
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[byteorder-lite-0.1.0.sha256sum] = "8f1fe948ff07f4bd06c30984e69f5b4899c516a3ef74f34df92a2df2ab535495"
 SRC_URI[bytes-1.12.1.sha256sum] = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
-SRC_URI[cairo-rs-0.22.0.sha256sum] = "5cc8d9aa793480744cd9a0524fef1a2e197d9eaa0f739cde19d16aba530dcb95"
-SRC_URI[cairo-sys-rs-0.22.0.sha256sum] = "f8b4985713047f5faee02b8db6a6ef32bbb50269ff53c1aee716d1d195b76d54"
+SRC_URI[cairo-rs-0.22.9.sha256sum] = "df683f1d30b457964673a5541a4603208ef95ab6873d2a55871895cf310f3b56"
+SRC_URI[cairo-sys-rs-0.22.9.sha256sum] = "ee548131103ad8f698c6725669647b9c757b3b66992dd6a026037596417bee21"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 SRC_URI[cbc-0.2.1.sha256sum] = "ce2dc9ee5f88d11e0beb842c88b33c8a5cf0d1329c4b19494af42b07dbfe8896"
-SRC_URI[cc-1.4.2.sha256sum] = "5d262e149917187838d5b42777c8253bcb64500067342904e7d429499a6f277e"
-SRC_URI[cfg-expr-0.20.8.sha256sum] = "fb693542bcafa528e198be0ebd9d3632ca5b7c93dbe7237460e199910835997c"
-SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[chacha20-0.10.1.sha256sum] = "d524456ba66e72eb8b115ff89e01e497f8e6d11d78b70b1aa13c0fbd97540a81"
+SRC_URI[cc-1.4.7.sha256sum] = "54413ede23c2daf518f35156dfde027feb2374004d63bd497f983c8db9c0e313"
+SRC_URI[cfg-expr-0.20.9.sha256sum] = "fe4ece8474b5f766c63426647e7b4b316b67431ade1036a8313cee24a03ae917"
+SRC_URI[cfg-if-1.0.5.sha256sum] = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
+SRC_URI[chacha20-0.10.2.sha256sum] = "65c35e4b699c7e15ccbe7ee35c005e4fc0a278d22238a2857e6ce2dadeda1b06"
 SRC_URI[chrono-0.4.45.sha256sum] = "1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
 SRC_URI[ciborium-0.2.2.sha256sum] = "42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
 SRC_URI[ciborium-io-0.2.2.sha256sum] = "05afea1e0a06c9be33d539b876f1ce3692f4afea2cb41f740e7743225ed1c757"
 SRC_URI[ciborium-ll-0.2.2.sha256sum] = "57663b653d948a338bfb3eeba9bb2fd5fcfaecb9e199e87e1eda4d9e8b240fd9"
 SRC_URI[cipher-0.5.2.sha256sum] = "e8cf2a2c93cd704877c0858356ed03480ff301ee950b43f1cbe4573b088bfa6c"
-SRC_URI[clap-4.6.6.sha256sum] = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
-SRC_URI[clap_builder-4.6.6.sha256sum] = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
-SRC_URI[clap_complete-4.6.9.sha256sum] = "3be2ad0423bdbbb0e25bc89add796f3559706d4a95e1bc98e4d9662a957b6a19"
-SRC_URI[clap_derive-4.6.4.sha256sum] = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
-SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
+SRC_URI[clap-4.6.7.sha256sum] = "aa8876b300ab35ba921adea3dfd70157a46249b33f95c9084ae5709785478946"
+SRC_URI[clap_builder-4.6.7.sha256sum] = "ec0797fb7aeb1406c84efac526901f7ec3ead2124f946b494e72879d4b54704d"
+SRC_URI[clap_complete-4.6.11.sha256sum] = "037e2a1a92236d0aff7e845093f64661d6df4c02c9fcc61a60e9e1d736fa392f"
+SRC_URI[clap_derive-4.6.7.sha256sum] = "f9c751b79415d4e559e3d1fcf128e09e720eb673a06d26cf6f392d37d75b66e0"
+SRC_URI[clap_lex-1.1.1.sha256sum] = "1c133bc6a41be0d194c306b5506d15e6feeea7b1d6604bd3f8310dfb2ca96486"
 SRC_URI[color_quant-1.1.0.sha256sum] = "3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
 SRC_URI[colorchoice-1.0.5.sha256sum] = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
 SRC_URI[const-oid-0.10.2.sha256sum] = "a6ef517f0926dd24a1582492c791b6a4818a4d94e789a334894aa15b0d12f55c"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+SRC_URI[core_detect-1.0.0.sha256sum] = "7f8f80099a98041a3d1622845c271458a2d73e688351bf3cb999266764b81d48"
 SRC_URI[cpubits-0.1.1.sha256sum] = "15b85f9c39137c3a891689859392b1bd49812121d0d61c9caf00d46ed5ce06ae"
-SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
-SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
+SRC_URI[cpufeatures-0.3.1.sha256sum] = "5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
+SRC_URI[crc32fast-1.5.2.sha256sum] = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
 SRC_URI[criterion-0.8.2.sha256sum] = "950046b2aa2492f9a536f5f4f9a3de7b9e2476e575e05bd6c333371add4d98f3"
 SRC_URI[criterion-plot-0.8.2.sha256sum] = "d8d80a2f4f5b554395e47b5d8305bc3d27813bacb73493eb1001e8f76dae29ea"
-SRC_URI[crossbeam-deque-0.8.7.sha256sum] = "5181e0de7b61eb03a81e347d6dd8797bae9da5146707b51077e2d71a54ec0ceb"
-SRC_URI[crossbeam-epoch-0.9.20.sha256sum] = "2d6914041f254d6e9176c01941b21115dcfb7089e55135a35411081bd106ef3f"
-SRC_URI[crossbeam-utils-0.8.22.sha256sum] = "61803da095bee82a81bb1a452ecc25d3b2f1416d1897eb86430c6159ef717c17"
+SRC_URI[crossbeam-deque-0.8.8.sha256sum] = "622f3fc73690be383c7214310406f28a90e6edeadc3cea882f9d71e495b9711a"
+SRC_URI[crossbeam-epoch-0.9.21.sha256sum] = "dc74980687109a3b14c72fd458107bf0baa1da1a1a805e178d15501ba9b86d9d"
+SRC_URI[crossbeam-utils-0.8.23.sha256sum] = "a31eee39dddec8330830986fcd7625edb5a24ec90ea038215273bbc3adb08ac6"
 SRC_URI[crunchy-0.2.4.sha256sum] = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
 SRC_URI[crypto-common-0.2.2.sha256sum] = "ce6e4c961d6cd6c9a86db418387425e8bdeaf05b3c8bc1411e6dca4c252f1453"
 SRC_URI[cssparser-0.37.0.sha256sum] = "8c9cdaae01d5ed7882b04d795e7f752f46ff52d2fa3b50a20d28c464510bba98"
 SRC_URI[cssparser-color-0.5.0.sha256sum] = "bbaa233e1dcd9c13a5d3e3a8a2c0f5a727bac380398345dbcb31db4597edc86b"
-SRC_URI[cssparser-macros-0.7.0.sha256sum] = "10a2a99df6e410a8ff4245aa2006499ea662245f967cc7c0a38c83ef8eb44dbf"
+SRC_URI[cssparser-macros-0.7.1.sha256sum] = "d045de693cb712d0b22c6a64be5b953f67b3ce00ab5ad3dd5d8b441886ab8e1a"
 SRC_URI[data-url-0.3.2.sha256sum] = "be1e0bca6c3637f992fc1cc7cbc52a78c1ef6db076dbf1059c4323d6a2048376"
 SRC_URI[dav1d-0.11.1.sha256sum] = "3ee89cb860616069c67520dcd66cacdb900b57c799f634a0eb6d91f6e2a82b61"
 SRC_URI[dav1d-sys-0.8.3.sha256sum] = "c3c91aea6668645415331133ed6f8ddf0e7f40160cd97a12d59e68716a58704b"
@@ -437,16 +445,16 @@ SRC_URI[displaydoc-0.2.7.sha256sum] = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308
 SRC_URI[dlib-0.5.3.sha256sum] = "ab8ecd87370524b461f8557c119c405552c396ed91fc0a8eec68679eab26f94a"
 SRC_URI[dtoa-1.0.11.sha256sum] = "4c3cf4824e2d5f025c7b531afcb2325364084a16806f6d47fbc1f5fbd9960590"
 SRC_URI[dtoa-short-0.3.5.sha256sum] = "cd1511a7b6a56299bd043a9c167a6d2bfb37bf84a6dfceaba651168adfb43c87"
-SRC_URI[ecb-0.2.0.sha256sum] = "fbfbf3db731928d6912bc3beda911d55b834cee3df6131ba79b337a1298a3fa9"
-SRC_URI[either-1.17.0.sha256sum] = "9e5e8f6c15a24b9a3ee5efec809ccd006d3b30e8b3bb63c39af737c7f87daa1d"
-SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
+SRC_URI[ecb-0.2.1.sha256sum] = "26f2a8b3e564eba0877223dc343703ad0385794e882e6d13f3a4dd5c6b1f41ac"
+SRC_URI[either-1.18.0.sha256sum] = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
+SRC_URI[encoding_rs-0.8.41.sha256sum] = "7b5ef0006ac9ab233c38522f5ae99cae3625151de8f706cacee1cba4b8e2832a"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible_collections-0.4.9.sha256sum] = "a88c69768c0a15262df21899142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
 SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[fdeflate-0.3.7.sha256sum] = "1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
-SRC_URI[find-msvc-tools-0.1.10.sha256sum] = "26b73573e6edcd2af0cdf47bd6cb58f0b3839491263c314eaad1ccf24430e1de"
-SRC_URI[flate2-1.1.9.sha256sum] = "843fba2746e448b37e26a819579957415c8cef339bf08564fe8b7ddbd959573c"
+SRC_URI[find-msvc-tools-0.1.13.sha256sum] = "ef25905e51abafe4dcea6c15fec58c57b601cdbd0ee53d22ea1d3016c587d39b"
+SRC_URI[flate2-1.1.10.sha256sum] = "6e634e2e0ebac1ee034020da1ca582e17ffe4e0f5e985823721e168928136dcb"
 SRC_URI[float-cmp-0.10.0.sha256sum] = "b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
@@ -458,65 +466,65 @@ SRC_URI[futures-macro-0.3.34.sha256sum] = "9fb9654ba8355388abeb8dcb4fc62f5113008
 SRC_URI[futures-task-0.3.34.sha256sum] = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
 SRC_URI[futures-util-0.3.34.sha256sum] = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
 SRC_URI[gdk-pixbuf-0.22.0.sha256sum] = "25f420376dbee041b2db374ce4573892a36222bb3f6c0c43e24f0d67eae9b646"
-SRC_URI[gdk-pixbuf-sys-0.22.0.sha256sum] = "48f31b37b1fc4b48b54f6b91b7ef04c18e00b4585d98359dd7b998774bbd91fb"
+SRC_URI[gdk-pixbuf-sys-0.22.9.sha256sum] = "9d5209294ba3775f9b650bf78bfadeba4332089f2329b3e2f6ce0a4957a45bff"
 SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
 SRC_URI[getrandom-0.4.3.sha256sum] = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
 SRC_URI[gif-0.14.2.sha256sum] = "ee8cfcc411d9adbbaba82fb72661cc1bcca13e8bba98b364e62b2dba8f960159"
-SRC_URI[gio-0.22.8.sha256sum] = "8b3e1f669909c326b9413bde5a742097b8c90a7d78f45326db13668984769ded"
-SRC_URI[gio-sys-0.22.8.sha256sum] = "353fdc7da7cd16da916104b1e0e4e7de380ec9c8aaa20d4d742d66310ab4b0d5"
+SRC_URI[gio-0.22.9.sha256sum] = "b399f4650bb52c051f3fdf49a234e8a27ab5725c8cd774556c55eee64b2c0350"
+SRC_URI[gio-sys-0.22.9.sha256sum] = "6c28739f914c15b87a9856000bed9cbd5b3a8afbca5e982d9a299e1601422cb5"
 SRC_URI[gio-unix-0.22.8.sha256sum] = "ce8d768735e229742c135afa3d3326604088d2df0679901cdb05e791fe2fbe0a"
-SRC_URI[gio-unix-sys-0.22.0.sha256sum] = "44bab97ce39112040216e268f074645f50b31caeb53af708ab5d7e4e67f0dbfd"
+SRC_URI[gio-unix-sys-0.22.9.sha256sum] = "7c01dbb58f92f67548d85e2209e073acc7ee04e107c7e04ee69b49e38b4933b4"
 SRC_URI[gio-win32-0.22.8.sha256sum] = "9daa423bc3dc24305275d0551882c4c0469c1cf842ab14897cf5ffbb63d95cd4"
-SRC_URI[gio-win32-sys-0.22.0.sha256sum] = "d673cd130fa7b598cf3fa776265a8e4c02634f3283433d441b8fc6f9fe07f327"
+SRC_URI[gio-win32-sys-0.22.9.sha256sum] = "81b96f21f242e3ee9076561f3ff04e8ac1fed20a56da23acfa69890c9d922170"
 SRC_URI[glam-0.30.10.sha256sum] = "19fc433e8437a212d1b6f1e68c7824af3aed907da60afa994e7f542d18d12aa9"
 SRC_URI[glam-0.31.1.sha256sum] = "556f6b2ea90b8d15a74e0e7bb41671c9bdf38cd9f78c284d750b9ce58a2b5be7"
 SRC_URI[glam-0.32.1.sha256sum] = "f70749695b063ecbf6b62949ccccde2e733ec3ecbbd71d467dca4e5c6c97cca0"
-SRC_URI[glam-0.33.3.sha256sum] = "7360bd2cd76e0cd9032d42cf2922155cecea2685b0cfa4630c3246df030bcfd6"
-SRC_URI[glib-0.22.8.sha256sum] = "ddbcf514bd1881fc1b960e4e52b4e82873f4da3bceddbd58d42827b508888100"
-SRC_URI[glib-macros-0.22.6.sha256sum] = "506d23499707c7142898429757e8d9a3871d965239a2cb66dfa05052be6d6f19"
-SRC_URI[glib-sys-0.22.8.sha256sum] = "030967459f9f676851872c6304adea7825c6d462ec9b72554c733cf0c5952233"
-SRC_URI[gobject-sys-0.22.6.sha256sum] = "22a861859b887a79cf461359c192c97a57d8fb0229dd291232e57aa11f6fa72c"
+SRC_URI[glam-0.33.7.sha256sum] = "e762b9b188634fc508d4ec54b62ea3d352c43fd431d18d05d46f559f217f4725"
+SRC_URI[glib-0.22.9.sha256sum] = "18b9b8d350db41f690ec1b87109f202782748bbd8ab2f2ede17cb40d29e2838c"
+SRC_URI[glib-macros-0.22.9.sha256sum] = "c9597c68fa7bdf4154a3079642cd21c4dccac0b0bdd2897d82861523bf91e7b9"
+SRC_URI[glib-sys-0.22.9.sha256sum] = "99b38907e67e40dec9b60f858bcada952598719cb512a13eb13d6cdcd16f8295"
+SRC_URI[gobject-sys-0.22.9.sha256sum] = "07595c9ba696bd9819cb6a8df39f08078f3dd679508fe052dd558492c2053834"
 SRC_URI[half-2.7.1.sha256sum] = "6ea2d84b969582b4b1864a92dc5d27cd2b77b622a8d79306834f1be5ba20d84b"
 SRC_URI[hashbrown-0.13.2.sha256sum] = "43a3c133739dddd0d2990f9a4bdf8eb4b21ef50e4851ca85ab661199821d510e"
 SRC_URI[hashbrown-0.17.1.sha256sum] = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
-SRC_URI[hybrid-array-0.4.14.sha256sum] = "707114b52a152fa7bdb290cd7cd5912d9467273b6d74e21b8d81aca1f8533f6b"
+SRC_URI[hybrid-array-0.4.15.sha256sum] = "27f864f10dfb56725ce5ce5472bc52252c8f93a4ab86327122cebf62c5f59a17"
 SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[icu_collections-2.2.0.sha256sum] = "2984d1cd16c883d7935b9e07e44071dca8d917fd52ecc02c04d5fa0b5a3f191c"
-SRC_URI[icu_locale_core-2.2.0.sha256sum] = "92219b62b3e2b4d88ac5119f8904c10f8f61bf7e95b640d25ba3075e6cac2c29"
-SRC_URI[icu_normalizer-2.2.0.sha256sum] = "c56e5ee99d6e3d33bd91c5d85458b6005a22140021cc324cea84dd0e72cff3b4"
-SRC_URI[icu_normalizer_data-2.2.0.sha256sum] = "da3be0ae77ea334f4da67c12f149704f19f81d1adf7c51cf482943e84a2bad38"
-SRC_URI[icu_properties-2.2.0.sha256sum] = "bee3b67d0ea5c2cca5003417989af8996f8604e34fb9ddf96208a033901e70de"
-SRC_URI[icu_properties_data-2.2.0.sha256sum] = "8e2bbb201e0c04f7b4b3e14382af113e17ba4f63e2c9d2ee626b720cbce54a14"
-SRC_URI[icu_provider-2.2.0.sha256sum] = "139c4cf31c8b5f33d7e199446eff9c1e02decfc2f0eec2c8d71f65befa45b421"
+SRC_URI[icu_collections-2.3.0.sha256sum] = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
+SRC_URI[icu_locale_core-2.3.0.sha256sum] = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
+SRC_URI[icu_normalizer-2.3.0.sha256sum] = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
+SRC_URI[icu_normalizer_data-2.3.0.sha256sum] = "1563da1ed3e0b3bf3d74c9b85917ac9c56464d2f57242270c09c9e752f8021a0"
+SRC_URI[icu_properties-2.3.0.sha256sum] = "7e7ca276ad3145661a65914e6daf131ca5120cd3dcee8f8f3214b8875184a148"
+SRC_URI[icu_properties_data-2.3.0.sha256sum] = "e590f038c1464a96894fd6d10127e90a8be4509f56ff7ecef851b15cee0b7caa"
+SRC_URI[icu_provider-2.3.1.sha256sum] = "d27bbb9d3abbefac45d55f647c9de1d44aafcd1186eb91879afef17c396c3e73"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
 SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
 SRC_URI[image-0.25.10.sha256sum] = "85ab80394333c02fe689eaf900ab500fbd0c2213da414687ebf995a65d5a6104"
 SRC_URI[image-webp-0.2.4.sha256sum] = "525e9ff3e1a4be2fbea1fdf0e98686a6d98b4d8f937e1bf7402245af1909e8c3"
-SRC_URI[indexmap-2.14.0.sha256sum] = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
+SRC_URI[indexmap-2.14.2.sha256sum] = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
 SRC_URI[inout-0.2.2.sha256sum] = "4250ce6452e92010fdf7268ccc5d14faa80bb12fc741938534c58f16804e03c7"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
 SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
 SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
-SRC_URI[jiff-0.2.35.sha256sum] = "668b7183bd07af9a4885f5c35b0cc5c83c4607a913c16b7e17291832910d2dcc"
-SRC_URI[jiff-core-0.1.0.sha256sum] = "7feca88439efe53da3754500c1851dedf3cb36c524dd5cf8225cc0794de95d09"
-SRC_URI[jiff-static-0.2.35.sha256sum] = "3a69dcb3a21cfb32ce1cd056169337ca284af0766dd766e7878819b251a49204"
+SRC_URI[jiff-0.2.37.sha256sum] = "0ab1baf72f08796de0260609515130699b890ac25f30e610ad894bc5856cafdb"
+SRC_URI[jiff-core-0.1.1.sha256sum] = "5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
+SRC_URI[jiff-static-0.2.37.sha256sum] = "378268a1116ad67ae6228701118ac9f491d78fda38a40a1f1a9e1348de6f7212"
 SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
-SRC_URI[js-sys-0.3.104.sha256sum] = "0e0c1080212aad755ea003d18543e8768dd432c48819efd73a7bf1e39b7a5a3a"
+SRC_URI[js-sys-0.3.105.sha256sum] = "ce57d20d1ea864ce2ac172ab472d409214f4fd359f0b2a2775abdf522e2af99e"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
 SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
 SRC_URI[libfuzzer-sys-0.4.13.sha256sum] = "a9fd2f41a1cba099f79a0b6b6c35656cf7c03351a7bae8ff0f28f25270f929d2"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
-SRC_URI[litemap-0.8.2.sha256sum] = "92daf443525c4cce67b150400bc2316076100ce0b3686209eb8cf3c31612e6f0"
+SRC_URI[litemap-0.8.3.sha256sum] = "47d9d19d1d6efa0109d2f65ff4c85cddd50bd572e5a00127ab10987290bcefae"
 SRC_URI[locale_config-0.3.0.sha256sum] = "08d2c35b16f4483f6c26f0e4e9550717a2f6575bcd6f12a53ff0c490a94a6934"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
-SRC_URI[log-0.4.33.sha256sum] = "0ceec5bc11778974d1bcb055b18002eba7f4b3518b6a0081b3af5f21666da9ad"
+SRC_URI[log-0.4.34.sha256sum] = "f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
 SRC_URI[lopdf-0.44.0.sha256sum] = "5e2ec995d822e05cabc3f06d196ee43650af3fe4fe38012cacb35e0c3d113b68"
 SRC_URI[malloc_buf-0.0.6.sha256sum] = "62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
 SRC_URI[markup5ever-0.39.0.sha256sum] = "7122d987ec5f704ee56f6e5b41a7d93722e9aae27ae07cafa4036c4d3f9757de"
@@ -525,8 +533,12 @@ SRC_URI[matrixmultiply-0.3.11.sha256sum] = "3f607c237553f086e7043417a51df26b2eb8
 SRC_URI[md-5-0.11.0.sha256sum] = "69b6441f590336821bb897fb28fc622898ccceb1d6cea3fde5ea86b090c4de98"
 SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
 SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
+SRC_URI[miniz_oxide-0.9.1.sha256sum] = "b63fbc4a50860e98e7b2aa7804ded1db5cbc3aff9193adaff57a6931bf7c4b4c"
 SRC_URI[moxcms-0.8.1.sha256sum] = "bb85c154ba489f01b25c0d36ae69a87e4a1c73a72631fc6c0eb6dde34a73e44b"
 SRC_URI[mp4parse-0.17.0.sha256sum] = "63a35203d3c6ce92d5251c77520acb2e57108c88728695aa883f70023624c570"
+SRC_URI[multiversion-0.9.0.sha256sum] = "b4ca4bea16ffc3f443cf7d866912118196bfef4c6a1556ca00f9f9b00bb43f7c"
+SRC_URI[multiversion-macros-0.9.0.sha256sum] = "0d416831a7317ef4b08bee00b69cbbb9c8763da7959a7026244d6266869f9c83"
+SRC_URI[multiversion_no_op-1.0.0.sha256sum] = "743fb55ba31b18fb1ecef6bdc9aa2743314978ac084044301a7eee33fb99a20d"
 SRC_URI[mutants-0.0.4.sha256sum] = "add0ac067452ff1aca8c5002111bd6b1c895baee6e45fcbc44e0193aea17be56"
 SRC_URI[nalgebra-0.35.0.sha256sum] = "adc43a60c217b0c6ff46e47f26911015ad8d2e5a8be1af668c67e370d99a4346"
 SRC_URI[nalgebra-macros-0.3.0.sha256sum] = "973e7178a678cfd059ccec50887658d482ce16b0aa9da3888ddeab5cd5eb4889"
@@ -537,7 +549,7 @@ SRC_URI[num-bigint-0.4.8.sha256sum] = "c89e69e7e0f03bea5ef08013795c25018e1019322
 SRC_URI[num-complex-0.4.6.sha256sum] = "73f88a1307638156682bada9d7604135552957b7818057dcef22705b4d509495"
 SRC_URI[num-conv-0.2.2.sha256sum] = "521739c6d2bac4aa25192232afe6841231376b2b26d4d9fae5ecf8ca5772e441"
 SRC_URI[num-derive-0.4.2.sha256sum] = "ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
-SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
+SRC_URI[num-integer-0.1.47.sha256sum] = "7ce2d95d4b3734dc35aa2f45e1aa22cd416814592a4f9d9205e11affd5b8e10b"
 SRC_URI[num-rational-0.4.2.sha256sum] = "f83d14da390562dca69fc84082e73e548e1ad308d24accdedd2720017cb37824"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[objc-0.2.7.sha256sum] = "915b1b472bc21c53464d6c8461c9d3af805ba1ef837e1cac254428f4a77177b1"
@@ -547,10 +559,10 @@ SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d0
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[oorandom-11.1.5.sha256sum] = "d6790f58c7ff633d8771f42965289203411a5e5c68388703c06e14f24770b41e"
 SRC_URI[page_size-0.6.0.sha256sum] = "30d5b2194ed13191c1999ae0704b7839fb18384fa22e49b57eeaa97d79ce40da"
-SRC_URI[pango-0.22.8.sha256sum] = "5d800d8d0de2ad5d0fb046f5344dbaba14a003cf3dd27cc21d85893d35ea316c"
-SRC_URI[pango-sys-0.22.0.sha256sum] = "bbd111a20ca90fedf03e09c59783c679c00900f1d8491cca5399f5e33609d5d6"
-SRC_URI[pangocairo-0.22.8.sha256sum] = "738a2ef690f51487814ff7172e0417c8e4fa2d7567571e5eb299d38b47b543ab"
-SRC_URI[pangocairo-sys-0.22.0.sha256sum] = "d95cb73468373b9e568abb1afbaf5b42fe6ab9128fc41b5f2adbf69451c3c77f"
+SRC_URI[pango-0.22.9.sha256sum] = "0b2022dbbd82e1c42bd950a6f1df9b98c796e725dce5ec275e03cbf9772e4efa"
+SRC_URI[pango-sys-0.22.9.sha256sum] = "ca02d64761b74d56cdd4b437db6d73dc95e6c0d40f27e1c707952c0f09052948"
+SRC_URI[pangocairo-0.22.9.sha256sum] = "bd199a0fef965b3ebda91a929a1ab5e7729538882c68e8de38e1904d2e094757"
+SRC_URI[pangocairo-sys-0.22.9.sha256sum] = "a649a616d67ae68539bc85f00fb45d36fba742ed20fc20e6712a15d8ee52bd3f"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
 SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
 SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
@@ -561,14 +573,14 @@ SRC_URI[phf_macros-0.13.1.sha256sum] = "812f032b54b1e759ccd5f8b6677695d5268c5887
 SRC_URI[phf_shared-0.13.1.sha256sum] = "e57fef6bc5981e38c2ce2d63bfa546861309f875b8a75f092d1d54ae2d64f266"
 SRC_URI[phf_shared-0.14.0.sha256sum] = "c6fd9027e2d9319be6349febd1db4e8d02aa544921200c9b777720ac34a3aa89"
 SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
-SRC_URI[pkg-config-0.3.33.sha256sum] = "19f132c84eca552bf34cab8ec81f1c1dcc229b811638f9d283dceabe58c5569e"
+SRC_URI[pkg-config-0.3.34.sha256sum] = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
 SRC_URI[plotters-0.3.7.sha256sum] = "5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
 SRC_URI[plotters-backend-0.3.7.sha256sum] = "df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
 SRC_URI[plotters-svg-0.3.7.sha256sum] = "51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
 SRC_URI[png-0.18.1.sha256sum] = "60769b8b31b2a9f263dae2776c37b1b28ae246943cf719eb6946a1db05128a61"
 SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
-SRC_URI[portable-atomic-util-0.2.7.sha256sum] = "c2a106d1259c23fac8e543272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
-SRC_URI[potential_utf-0.1.5.sha256sum] = "0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564"
+SRC_URI[portable-atomic-util-0.2.8.sha256sum] = "10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
+SRC_URI[potential_utf-0.1.6.sha256sum] = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
@@ -590,7 +602,7 @@ SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae
 SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
 SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
 SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
-SRC_URI[rangemap-1.7.1.sha256sum] = "973443cf09a9c8656b574a866ab68dfa19f0867d0340648c7d2f6a71b8a8ea68"
+SRC_URI[rangemap-1.8.0.sha256sum] = "a611d15b50743feb4c76b7d03edcb0e64f399c26961e4efe6975bc398be6aa3d"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
 SRC_URI[rayon-1.12.0.sha256sum] = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
 SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
@@ -602,10 +614,10 @@ SRC_URI[regex-syntax-0.8.11.sha256sum] = "d6f6ff9a378485b298a5286656da665ba74413
 SRC_URI[rgb-0.8.53.sha256sum] = "47b34b781b31e5d73e9fbc8689c70551fd1ade9a19e3e28cfec8580a79290cc4"
 SRC_URI[rustc-hash-2.1.3.sha256sum] = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
 SRC_URI[rustc_version-0.4.1.sha256sum] = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
-SRC_URI[rustix-1.1.4.sha256sum] = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+SRC_URI[rustix-1.1.5.sha256sum] = "891efababe418670775f199f0d233d84843c227a0949a883ce15b37c78d6629d"
 SRC_URI[rustversion-1.0.23.sha256sum] = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
 SRC_URI[rusty-fork-0.3.1.sha256sum] = "cc6bf79ff24e648f6da1f8d1f011e9cac26491b619e6b9280f2b47f1774e6ee2"
-SRC_URI[safe_arch-1.1.0.sha256sum] = "3a52ec151f024d703f9fd65abb7cbe81e7cdb39f18917a3a37e3014470dc7c59"
+SRC_URI[safe_arch-1.2.0.sha256sum] = "42c6efa15875e6ecb39ca61fb0b0c1a40b84fac5a5ffe71eef7d1000c8eb3f5f"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[selectors-0.40.0.sha256sum] = "eeee001a77567bb05e71652718d3ff76d8697c151ac523e68e9513194eb2b75a"
@@ -621,9 +633,10 @@ SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f1
 SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
 SRC_URI[simba-0.10.2.sha256sum] = "f1a7200d82ff1c7b4235efd12f11e2537a402c91cf83a5cb97ce80eef787fde7"
 SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
+SRC_URI[simdutf8-0.1.5.sha256sum] = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
 SRC_URI[siphasher-1.0.3.sha256sum] = "8ee5873ec9cce0195efcb7a4e9507a04cd49aec9c83d0389df45b1ef7ba2e649"
 SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
-SRC_URI[smallvec-1.15.2.sha256sum] = "8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
+SRC_URI[smallvec-1.16.1.sha256sum] = "ba467056f1b547ed52077911161fc86985becbc60e8e1857c8a144dab0def891"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[string_cache-0.9.0.sha256sum] = "a18596f8c785a729f2819c0f6a7eae6ebeebdfffbfe4214ae6b087f690e31901"
@@ -632,9 +645,10 @@ SRC_URI[string_cache_codegen-0.6.1.sha256sum] = "585635e46db231059f76c5849798146
 SRC_URI[stringprep-0.1.5.sha256sum] = "7b4df3d392d81bd458a8a621b8bffbd2302a12ffe288a9d931670948749463b1"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
 SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
-SRC_URI[syn-3.0.3.sha256sum] = "53e9bae58849f64dfa4f5d5ae372c8341f7305f82a3868709269343628b659a3"
-SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
+SRC_URI[syn-3.0.6.sha256sum] = "8593e8e72159ed2257d083c7a454a85cbf854f37a0966d8d483aff8c8a3ebcee"
+SRC_URI[synstructure-0.14.0.sha256sum] = "901704edd0dfe137f1987838ee4f259e4e063c31371bdb423f7ae38ec6f77f02"
 SRC_URI[system-deps-7.0.8.sha256sum] = "396a35feb67335377e0251fcbc1092fc85c484bd4e3a7a54319399da127796e7"
+SRC_URI[system-deps-9.0.0.sha256sum] = "8a0dae2cbca1f0ff93795713cfe0a4c02f760e3c0b8ae2ab4ec4045808ff429f"
 SRC_URI[target-lexicon-0.13.5.sha256sum] = "adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
 SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[tendril-0.5.1.sha256sum] = "5fed54709c5b3a53d09bb1c113ea4f5ceafd1e772ddcb0030a82e1d56c087b08"
@@ -644,18 +658,17 @@ SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120
 SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
 SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
 SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
-SRC_URI[tinystr-0.8.3.sha256sum] = "c8323304221c2a851516f22236c5722a72eaa19749016521d6dff0824447d96d"
+SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
-SRC_URI[tinyvec-1.12.0.sha256sum] = "bb4ebadaa0af04fab11ae01eb5f9fdb5f9c5b875506e210e71c07873528baa7f"
-SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-1.1.4+spec-1.1.0.sha256sum] = "3aace63f4bbcdfc2c965b059de67119c89c4017a70d633be6c104910f67056f5"
+SRC_URI[tinyvec-1.13.3.sha256sum] = "fd3ca314f692efd6c868f8408f53fe444634a845f96c028b97d35f6a1f79f0ee"
+SRC_URI[toml-1.1.6+spec-1.1.0.sha256sum] = "920602543f0911ab71da12c50d59701da54c196d1a2bf5cb4b75667f137a406a"
 SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
 SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
 SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
 SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
 SRC_URI[unicode-bidi-0.3.18.sha256sum] = "5c1cb5db39152898a79168971543b1cb5020dff7fe43c8dc468b0885f5e29df5"
-SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-ident-1.0.26.sha256sum] = "d245f478577f809a851594d02313b640fb437e0bb33866753cff937863096954"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-properties-0.1.4.sha256sum] = "7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
 SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
@@ -666,15 +679,15 @@ SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5
 SRC_URI[wait-timeout-0.2.1.sha256sum] = "09ac3b126d3914f9849036f826e054cbabdc8519970b8998ddaf3b5bd3c65f11"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasip2-1.0.4+wasi-0.2.12.sha256sum] = "b67efb37e106e55ce722a510d6b5f9c17f083e5fc79afc2badeb12cc313d9487"
-SRC_URI[wasm-bindgen-0.2.127.sha256sum] = "1b70935747edd64d89de3efa29d73789b806c15798f8e7dca4d8ac356b50ce70"
-SRC_URI[wasm-bindgen-macro-0.2.127.sha256sum] = "77775f8f3f7217702089053b94958f8f54061a3f663417df76e19cbdcca29bc1"
-SRC_URI[wasm-bindgen-macro-support-0.2.127.sha256sum] = "e11d33f857dc2fb11b8bc75aee111aa9cbeb12cd9f25efd3d4c2a3dd4e235284"
-SRC_URI[wasm-bindgen-shared-0.2.127.sha256sum] = "7ef64dbcc55df09c7e5a46182d181c2cfa3e925f3da937ea764728b4bbb9dcbf"
-SRC_URI[web-sys-0.3.104.sha256sum] = "c435338968042f4f59a557f690a253676d47ce13ceb55d70100e7facf6620a30"
+SRC_URI[wasm-bindgen-0.2.128.sha256sum] = "aecb87a33d3b0c5e3b7aa46336eaf486cffafbd281b195e4c8b80d50df2351bf"
+SRC_URI[wasm-bindgen-macro-0.2.128.sha256sum] = "a690d511e3c1a8b3a55e33511e3c2c00c78415cd23650f32b808627f5696b9ed"
+SRC_URI[wasm-bindgen-macro-support-0.2.128.sha256sum] = "411e4887f0071ef2d2164a9d5fdf2d20efbef78fccd3a78b0c10a1dc5295e48a"
+SRC_URI[wasm-bindgen-shared-0.2.128.sha256sum] = "81941cd78d0c92026c33e5e01312845a4cb1e9af3407f9134b100dd03144103e"
+SRC_URI[web-sys-0.3.105.sha256sum] = "9fbddc4a036f00ec4f18c83445bd3115cb306a91da554919a099d9222fe4a7f8"
 SRC_URI[web_atoms-0.2.6.sha256sum] = "ba8b815c1b593dc0baf78dd0f4fc8fdb2de53198fb1163738093e9a311c33fb3"
 SRC_URI[weezl-0.1.12.sha256sum] = "a28ac98ddc8b9274cb41bb4d9d4d5c425b6020c50c46f25559911905610b4a88"
 SRC_URI[weezl-0.2.1.sha256sum] = "d4ca08e5ef825b65b056d9efbd95c8750683f0a6d0466d02e96dc2e4e360f3d2"
-SRC_URI[wide-1.6.1.sha256sum] = "de2aaf408e58689c2096682331b1f42bb2d9f2ed6b11560407d023cd0a6c634e"
+SRC_URI[wide-1.7.1.sha256sum] = "d920ac99c3c8edce110cb8d07dbb324d6d026011dce85b1e9355b70f0adacc4f"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
@@ -688,19 +701,20 @@ SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bf
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
 SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
 SRC_URI[wit-bindgen-0.57.1.sha256sum] = "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
-SRC_URI[writeable-0.6.3.sha256sum] = "1ffae5123b2d3fc086436f8834ae3ab053a283cfac8fe0a0b8eaae044768a4c4"
+SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
 SRC_URI[xml5ever-0.39.0.sha256sum] = "5ab627f34ff61b80d756180d556f9c68801d836d271b3b8c094504ceca69d221"
 SRC_URI[yansi-1.0.1.sha256sum] = "cfe53a6657fd280eaa890a3bc59152892ffa3e30101319d168b781ed6529b049"
 SRC_URI[yeslogic-fontconfig-sys-6.0.1.sha256sum] = "1d8b8abf912b9a29ff112e1671c97c33636903d13a69712037190e6805af4f76"
 SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
-SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
-SRC_URI[zerocopy-0.8.56.sha256sum] = "556764e583adb45a9f8d413c2a147fa7e8d821e48e12b14fd560b607998b75eb"
-SRC_URI[zerocopy-derive-0.8.56.sha256sum] = "f2ab42fc20575779bd240faa45f94a74256f755c0fa9e89f0ede20d91d0cdfc1"
+SRC_URI[yoke-derive-0.8.3.sha256sum] = "33811428bee40dbceb6d545e95754741d17a6aef9a4849f0fd62e2ba4f412a78"
+SRC_URI[zerocopy-0.8.57.sha256sum] = "d35102a9f36d089ccae9e4c6802bc118be4487b80aaffc0ab4e0cf5ce92d2873"
+SRC_URI[zerocopy-derive-0.8.57.sha256sum] = "146c01f5ab44258da43cf276c74a2763db2ff3969c9c652c3f2de07041d0b2bc"
 SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
-SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
-SRC_URI[zerotrie-0.2.4.sha256sum] = "0f9152d31db0792fa83f70fb2f83148effb5c1f5b8c7686c3459e361d9bc20bf"
-SRC_URI[zerovec-0.11.6.sha256sum] = "90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239"
-SRC_URI[zerovec-derive-0.11.3.sha256sum] = "625dc425cab0dca6dc3c3319506e6593dcb08a9f387ea3b284dbd52a92c40555"
+SRC_URI[zerofrom-derive-0.1.8.sha256sum] = "f75b4683f6c7f45248d4d64056a24298c6281e0993356d7d1b4a1a962ef10d4a"
+SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
+SRC_URI[zerovec-0.11.8.sha256sum] = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
+SRC_URI[zerovec-derive-0.11.6.sha256sum] = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
+SRC_URI[zlib-rs-0.6.8.sha256sum] = "b268e58e7c693d7c271f93ffc4ba3b380412554231c85bf61ca7af91042a4112"
 SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
 SRC_URI[zune-core-0.5.3.sha256sum] = "d56377fd46368984a170bc5aac5567e52ca5da874caa60bea39fcbca78fb658b"
 SRC_URI[zune-jpeg-0.5.15.sha256sum] = "27bc9d5b815bc103f142aa054f561d9187d191692ec7c2d1e2b4737f8dbd7296"
diff --git a/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch b/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
index 1c02eda..d9a7fbf 100644
--- a/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
@@ -1,4 +1,4 @@
-From 2becfbb5964754f7c3f1ff90f9447d84093ba986 Mon Sep 17 00:00:00 2001
+From faa062c4bbd9f3678997a90c85ec4efa05156c07 Mon Sep 17 00:00:00 2001
 From: Gyorgy Sarvari <skandigraun@gmail.com>
 Date: Sat, 2 Aug 2025 20:57:49 +0200
 Subject: [PATCH] query-rustc: append RUSTFLAGS to rustc executable
diff --git a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
index 05e0e0f..35ae9a7 100644
--- a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
@@ -1,4 +1,4 @@
-From 095e3c67c5e6b410098eb8d86878ec411d00fa0b Mon Sep 17 00:00:00 2001
+From 5fca1f7d88ce817cb532e6b7e7168d3beb1a86f4 Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex@linutronix.de>
 Date: Thu, 18 Dec 2025 18:43:20 +0100
 Subject: [PATCH] tests: revert 'Take care of deprecated
diff --git a/recipes-gnome/librsvg/librsvg_2.63.0.bb b/recipes-gnome/librsvg/librsvg_2.63.2.bb
similarity index 98%
rename from recipes-gnome/librsvg/librsvg_2.63.0.bb
rename to recipes-gnome/librsvg/librsvg_2.63.2.bb
index 944a10a..f708ebd 100644
--- a/recipes-gnome/librsvg/librsvg_2.63.0.bb
+++ b/recipes-gnome/librsvg/librsvg_2.63.2.bb
@@ -26,7 +26,7 @@ require ${BPN}-crates.inc
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
             file://run-ptest"
-SRC_URI[archive.sha256sum] = "cab7f7d1326fb001e4eb9f37990de66d4578a5f48465507471a69322d8b326e3"
+SRC_URI[archive.sha256sum] = "852b18e1a00b8605528825a27dc7748bff2a5dd254028f59dc22a34ea57e81b6"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.56.1

