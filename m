Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6314.1794870786788823198
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F2Mt5Fv2;
 spf=pass (domain: konsulko.com, ip: 209.85.221.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ec6f271883so3667934e0c.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870785; x=1795475585; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0pcMqJkrrz8xk7m8iadYr/l/toHDsed+tdoxWYwlEhw=;
        b=F2Mt5Fv2nProw8cxvcdO0y/q9Pe+ye9HysiEICQHMNtqt0v+9xX08b/4y3tMc2EbpZ
         tZF4NeaFz0cKcXUc+f7JFUHUPSOxfZ6A/rABQGPDrEXTNzqv398IPYlViJqtSdfcRs6q
         wN4dBOvzNvukC3A9NGGl7synZYX6WWxl36tbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870785; x=1795475585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0pcMqJkrrz8xk7m8iadYr/l/toHDsed+tdoxWYwlEhw=;
        b=x8YCMqkBGDfFJsRcAJMh8qWhQJ9Ycmgcxp4sAc2KLVANB0nHKsnv+tCnHFNq/8Gs7o
         3pydcys0fuI9MWkWF5EHAOdxNymLMGMrtKCgdS1AEJMJ8W9opyg4KQq194AzHeCh378Z
         Kvwf2d9heDM43Xj+8slnks+zEF1XBxggyg78W/lSAQZ9oefFkMXQq6yY+TWkXiGVdUGw
         F8lLFvyOmcAddqnUoQBpnWTL1rXLUrabnoEBFSYEfy2AOO9LJXZ2nlJT6IN/OeaCL5ra
         nWzdQCEz1SMnPzk0JmJd8QMqJNnPKV2CAyMpkZR9w9WZVC9zKfeGTk67+AWNmpsIspkU
         o2kg==
X-Gm-Message-State: APuU4Z+9DYDY9x5YVkF0KYtn1I2PfRlDM1/S5sn5JQRN8Fl3GMyHQsgv
	MeDWj84nNPOQkUL5JkMuWPPjFlwTqk9vVaUCv17QhgRtTEJ/kHkFnFn1PEZb6AUk4EO0D/6IosL
	QoJCL9PU=
X-Gm-Gg: AYBFou27EEBU1ZJPp4jge95oAr3XfzBV3mYOE2/qbRg2znvo7HqlTYlRPYO6KlkEXHa
	cZvxOn9twpfcQvj8oG4eFOFsBly6LHCVegYjSzb0Y6RvPcpquNN+LqKdRqNF4hAX4jdVOAuiMBp
	XbHuI8U10F8FFzu1n0yN2FUmEmQsBP0+mbZ+xFgUzg6Uhw2pn1DyEao3UwSjBcQl2p11VndrH3I
	+F8usaJy0+oOhLvrNzXuu6rlo+HZwEwdOQv3+iwFg9Pd0ZOzB/t70TehmKR067rrK03NuxU0jh7
	l63FXYTIqGM/EGwe4g4Q2/nQm3BSawOyud3qOBzwk6AaEgmSMyoVLYx8dwMuUyPFqmDA2uLfmgD
	7W1e6Uf5ttkOIhSC90HsOIJZIIVO0FrCjgKx9iz641Z+UPzbdUM7QJoXHsaTi35mCsbWGEJZcyu
	wuFPJDjp9Yj8fpbqgzbhj/+1csPZ/daUsTNX2BsLlWNQlXI3f5PnSHEVUvPpfIn4mMhIxWGAztY
	L1eVmcbd8WVqM55RHijZTiS7zYv/7JNoCfgn7F68TjVdu3+7ViHORNdL4wH2KS0hTXBqSkZ6HqY
	2bfRZkpjdu+KIsWtE/RLITFtWSVAbaCSO1thn1dtL8P01gWzNaX7i1j49gLP1wyASklmL7uDqcH
	LT8EBAUXfc55RSSW8EdKbFV9jXa1S5TQ4/KTCq5R2ap+UrVrbKeK1Wjq4y4U/Zx3n8w==
X-Received: by 2002:a05:6122:178b:b0:5ea:b712:8281 with SMTP id 71dfb90a1353d-5ee34ae1c8bmr5068586e0c.18.1794870784707;
        Mon, 16 Nov 2026 15:13:04 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:04 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 15/19] librsvg: upgrade 2.63.2 -> 2.63.3
Date: Mon, 16 Nov 2026 18:12:36 -0500
Message-ID: <e88137c7d463c364fd703cf78d22e963492a0dc5.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5455
Content-Type: text/plain; charset="utf-8"

From: Ankur Tyagi <ankur.tyagi85@gmail.com>

Changelog:
https://gitlab.gnome.org/GNOME/librsvg/-/blob/2.63.3/NEWS?ref_type=tags

PTEST pass:
root@qemux86-64:~# ptest-runner librsvg
START: ptest-runner
2026-10-18T21:52
BEGIN: /usr/lib/librsvg/ptest
...
...
END: /usr/lib/librsvg/ptest
2026-10-18T21:54
STOP: ptest-runner
TOTAL: 1 FAIL: 0

Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 1994eea6d15575364c14d6e70164b3cc4b8dbb4d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 222 +++++++++---------
 .../{librsvg_2.63.2.bb => librsvg_2.63.3.bb}  |   2 +-
 2 files changed, 107 insertions(+), 117 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.63.2.bb => librsvg_2.63.3.bb} (98%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 1177c27..8574ab9 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -15,18 +15,20 @@ SRC_URI += " \
     crate://crates.io/anstyle-query/1.1.5 \
     crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/arbitrary/1.4.2 \
+    crate://crates.io/arbitrary/1.5.0 \
     crate://crates.io/assert_cmd/2.2.2 \
     crate://crates.io/autocfg/1.5.1 \
     crate://crates.io/av-data/0.4.4 \
-    crate://crates.io/bit-set/0.8.0 \
-    crate://crates.io/bit-vec/0.8.0 \
+    crate://crates.io/bit-set/0.11.1 \
+    crate://crates.io/bit-vec/0.10.1 \
     crate://crates.io/bitflags/1.3.2 \
     crate://crates.io/bitflags/2.13.2 \
     crate://crates.io/bitreader/0.3.11 \
     crate://crates.io/block/0.1.6 \
     crate://crates.io/block-buffer/0.12.1 \
     crate://crates.io/block-padding/0.4.2 \
+    crate://crates.io/borsh/1.8.1 \
+    crate://crates.io/borsh-derive/1.8.1 \
     crate://crates.io/bstr/1.13.1 \
     crate://crates.io/bumpalo/3.20.3 \
     crate://crates.io/byte-slice-cast/1.2.3 \
@@ -38,9 +40,10 @@ SRC_URI += " \
     crate://crates.io/cairo-sys-rs/0.22.9 \
     crate://crates.io/cast/0.3.0 \
     crate://crates.io/cbc/0.2.1 \
-    crate://crates.io/cc/1.4.7 \
-    crate://crates.io/cfg-expr/0.20.9 \
+    crate://crates.io/cc/1.8.0 \
+    crate://crates.io/cfg-expr/0.20.10 \
     crate://crates.io/cfg-if/1.0.5 \
+    crate://crates.io/cfg_aliases/0.2.2 \
     crate://crates.io/chacha20/0.10.2 \
     crate://crates.io/chrono/0.4.45 \
     crate://crates.io/ciborium/0.2.2 \
@@ -73,10 +76,10 @@ SRC_URI += " \
     crate://crates.io/data-url/0.3.2 \
     crate://crates.io/dav1d/0.11.1 \
     crate://crates.io/dav1d-sys/0.8.3 \
-    crate://crates.io/defmt/1.1.1 \
-    crate://crates.io/defmt-macros/1.1.1 \
-    crate://crates.io/defmt-parser/1.0.0 \
-    crate://crates.io/deranged/0.5.8 \
+    crate://crates.io/defmt/1.2.0 \
+    crate://crates.io/defmt-macros/1.2.0 \
+    crate://crates.io/defmt-parser/1.1.0 \
+    crate://crates.io/deranged/0.5.9 \
     crate://crates.io/derive_more/2.1.1 \
     crate://crates.io/derive_more-impl/2.1.1 \
     crate://crates.io/diff/0.1.13 \
@@ -87,14 +90,14 @@ SRC_URI += " \
     crate://crates.io/dtoa/1.0.11 \
     crate://crates.io/dtoa-short/0.3.5 \
     crate://crates.io/ecb/0.2.1 \
-    crate://crates.io/either/1.18.0 \
-    crate://crates.io/encoding_rs/0.8.41 \
-    crate://crates.io/equivalent/1.0.2 \
+    crate://crates.io/either/1.19.0 \
+    crate://crates.io/encoding_rs/0.8.42 \
+    crate://crates.io/equivalent/1.0.3 \
     crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible_collections/0.4.9 \
     crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/fdeflate/0.3.7 \
-    crate://crates.io/find-msvc-tools/0.1.13 \
+    crate://crates.io/find-msvc-tools/0.1.14 \
     crate://crates.io/flate2/1.1.10 \
     crate://crates.io/float-cmp/0.10.0 \
     crate://crates.io/fnv/1.0.7 \
@@ -108,10 +111,9 @@ SRC_URI += " \
     crate://crates.io/futures-util/0.3.34 \
     crate://crates.io/gdk-pixbuf/0.22.0 \
     crate://crates.io/gdk-pixbuf-sys/0.22.9 \
-    crate://crates.io/getrandom/0.3.4 \
     crate://crates.io/getrandom/0.4.3 \
     crate://crates.io/gif/0.14.2 \
-    crate://crates.io/gio/0.22.9 \
+    crate://crates.io/gio/0.22.10 \
     crate://crates.io/gio-sys/0.22.9 \
     crate://crates.io/gio-unix/0.22.8 \
     crate://crates.io/gio-unix-sys/0.22.9 \
@@ -120,8 +122,8 @@ SRC_URI += " \
     crate://crates.io/glam/0.30.10 \
     crate://crates.io/glam/0.31.1 \
     crate://crates.io/glam/0.32.1 \
-    crate://crates.io/glam/0.33.7 \
-    crate://crates.io/glib/0.22.9 \
+    crate://crates.io/glam/0.33.12 \
+    crate://crates.io/glib/0.22.10 \
     crate://crates.io/glib-macros/0.22.9 \
     crate://crates.io/glib-sys/0.22.9 \
     crate://crates.io/gobject-sys/0.22.9 \
@@ -144,21 +146,21 @@ SRC_URI += " \
     crate://crates.io/image/0.25.10 \
     crate://crates.io/image-webp/0.2.4 \
     crate://crates.io/indexmap/2.14.2 \
-    crate://crates.io/inout/0.2.2 \
+    crate://crates.io/inout/0.2.4 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.13.0 \
     crate://crates.io/itertools/0.15.0 \
     crate://crates.io/itoa/1.0.18 \
-    crate://crates.io/jiff/0.2.37 \
+    crate://crates.io/jiff/0.2.38 \
     crate://crates.io/jiff-core/0.1.1 \
-    crate://crates.io/jiff-static/0.2.37 \
-    crate://crates.io/jiff-tzdb/0.1.8 \
+    crate://crates.io/jiff-static/0.2.38 \
+    crate://crates.io/jiff-tzdb/0.1.9 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.35 \
-    crate://crates.io/js-sys/0.3.105 \
+    crate://crates.io/js-sys/0.3.106 \
     crate://crates.io/language-tags/0.3.2 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.189 \
+    crate://crates.io/lazy_static/1.5.1 \
+    crate://crates.io/libc/0.2.190 \
     crate://crates.io/libfuzzer-sys/0.4.13 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/linux-raw-sys/0.12.1 \
@@ -177,8 +179,6 @@ SRC_URI += " \
     crate://crates.io/miniz_oxide/0.9.1 \
     crate://crates.io/moxcms/0.8.1 \
     crate://crates.io/mp4parse/0.17.0 \
-    crate://crates.io/multiversion/0.9.0 \
-    crate://crates.io/multiversion-macros/0.9.0 \
     crate://crates.io/multiversion_no_op/1.0.0 \
     crate://crates.io/mutants/0.0.4 \
     crate://crates.io/nalgebra/0.35.0 \
@@ -222,27 +222,23 @@ SRC_URI += " \
     crate://crates.io/portable-atomic/1.15.0 \
     crate://crates.io/portable-atomic-util/0.2.8 \
     crate://crates.io/potential_utf/0.1.6 \
-    crate://crates.io/powerfmt/0.2.0 \
-    crate://crates.io/ppv-lite86/0.2.21 \
+    crate://crates.io/powerfmt/0.2.1 \
     crate://crates.io/precomputed-hash/0.1.1 \
     crate://crates.io/predicates/3.1.4 \
     crate://crates.io/predicates-core/1.0.10 \
     crate://crates.io/predicates-tree/1.0.13 \
     crate://crates.io/pretty_assertions/1.4.1 \
+    crate://crates.io/proc-macro-crate/3.5.0 \
     crate://crates.io/proc-macro2/1.0.107 \
-    crate://crates.io/proptest/1.11.0 \
+    crate://crates.io/proptest/1.12.0 \
     crate://crates.io/pxfm/0.1.30 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
     crate://crates.io/quote/1.0.47 \
-    crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/r-efi/6.0.0 \
-    crate://crates.io/rand/0.9.5 \
-    crate://crates.io/rand/0.10.2 \
-    crate://crates.io/rand_chacha/0.9.0 \
-    crate://crates.io/rand_core/0.9.5 \
+    crate://crates.io/rand/0.10.3 \
     crate://crates.io/rand_core/0.10.1 \
-    crate://crates.io/rand_xorshift/0.4.0 \
+    crate://crates.io/rand_xorshift/0.5.0 \
     crate://crates.io/rangemap/1.8.0 \
     crate://crates.io/rawpointer/0.2.1 \
     crate://crates.io/rayon/1.12.0 \
@@ -266,18 +262,18 @@ SRC_URI += " \
     crate://crates.io/serde/1.0.229 \
     crate://crates.io/serde_core/1.0.229 \
     crate://crates.io/serde_derive/1.0.229 \
-    crate://crates.io/serde_json/1.0.151 \
-    crate://crates.io/serde_spanned/1.1.1 \
+    crate://crates.io/serde_json/1.0.154 \
+    crate://crates.io/serde_spanned/1.1.2 \
     crate://crates.io/servo_arc/0.4.3 \
-    crate://crates.io/sha2/0.11.0 \
+    crate://crates.io/sha2/0.11.1 \
     crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/2.0.1 \
     crate://crates.io/simba/0.10.2 \
     crate://crates.io/simd-adler32/0.3.10 \
     crate://crates.io/simdutf8/0.1.5 \
-    crate://crates.io/siphasher/1.0.3 \
+    crate://crates.io/siphasher/1.0.4 \
     crate://crates.io/slab/0.4.12 \
-    crate://crates.io/smallvec/1.16.1 \
+    crate://crates.io/smallvec/1.16.3 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/string_cache/0.9.0 \
@@ -286,7 +282,7 @@ SRC_URI += " \
     crate://crates.io/stringprep/0.1.5 \
     crate://crates.io/strsim/0.11.1 \
     crate://crates.io/syn/2.0.119 \
-    crate://crates.io/syn/3.0.6 \
+    crate://crates.io/syn/3.0.9 \
     crate://crates.io/synstructure/0.14.0 \
     crate://crates.io/system-deps/7.0.8 \
     crate://crates.io/system-deps/9.0.0 \
@@ -294,22 +290,23 @@ SRC_URI += " \
     crate://crates.io/tempfile/3.27.0 \
     crate://crates.io/tendril/0.5.1 \
     crate://crates.io/termtree/0.5.1 \
-    crate://crates.io/thiserror/2.0.20 \
-    crate://crates.io/thiserror-impl/2.0.20 \
+    crate://crates.io/thiserror/2.0.21 \
+    crate://crates.io/thiserror-impl/2.0.21 \
     crate://crates.io/time/0.3.55 \
     crate://crates.io/time-core/0.1.9 \
     crate://crates.io/time-macros/0.2.32 \
     crate://crates.io/tinystr/0.8.4 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.13.3 \
-    crate://crates.io/toml/1.1.6+spec-1.1.0 \
-    crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
-    crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
-    crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml/1.1.8+spec-1.1.0 \
+    crate://crates.io/toml_datetime/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_edit/0.25.17+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.5+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.3+spec-1.1.0 \
     crate://crates.io/typenum/1.20.1 \
     crate://crates.io/unarray/0.1.4 \
     crate://crates.io/unicode-bidi/0.3.18 \
-    crate://crates.io/unicode-ident/1.0.26 \
+    crate://crates.io/unicode-ident/1.0.27 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-properties/0.1.4 \
     crate://crates.io/url/2.5.8 \
@@ -319,12 +316,11 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/wait-timeout/0.2.1 \
     crate://crates.io/walkdir/2.5.0 \
-    crate://crates.io/wasip2/1.0.4+wasi-0.2.12 \
-    crate://crates.io/wasm-bindgen/0.2.128 \
-    crate://crates.io/wasm-bindgen-macro/0.2.128 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.128 \
-    crate://crates.io/wasm-bindgen-shared/0.2.128 \
-    crate://crates.io/web-sys/0.3.105 \
+    crate://crates.io/wasm-bindgen/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.129 \
+    crate://crates.io/wasm-bindgen-shared/0.2.129 \
+    crate://crates.io/web-sys/0.3.106 \
     crate://crates.io/web_atoms/0.2.6 \
     crate://crates.io/weezl/0.1.12 \
     crate://crates.io/weezl/0.2.1 \
@@ -341,15 +337,14 @@ SRC_URI += " \
     crate://crates.io/windows-strings/0.5.1 \
     crate://crates.io/windows-sys/0.61.2 \
     crate://crates.io/winnow/1.0.4 \
-    crate://crates.io/wit-bindgen/0.57.1 \
     crate://crates.io/writeable/0.6.4 \
     crate://crates.io/xml5ever/0.39.0 \
     crate://crates.io/yansi/1.0.1 \
     crate://crates.io/yeslogic-fontconfig-sys/6.0.1 \
     crate://crates.io/yoke/0.8.3 \
-    crate://crates.io/yoke-derive/0.8.3 \
-    crate://crates.io/zerocopy/0.8.57 \
-    crate://crates.io/zerocopy-derive/0.8.57 \
+    crate://crates.io/yoke-derive/0.8.4 \
+    crate://crates.io/zerocopy/0.8.63 \
+    crate://crates.io/zerocopy-derive/0.8.63 \
     crate://crates.io/zerofrom/0.1.8 \
     crate://crates.io/zerofrom-derive/0.1.8 \
     crate://crates.io/zerotrie/0.2.5 \
@@ -374,18 +369,20 @@ SRC_URI[anstyle-parse-1.0.0.sha256sum] = "52ce7f38b242319f7cabaa6813055467063ecd
 SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[approx-0.5.1.sha256sum] = "cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
-SRC_URI[arbitrary-1.4.2.sha256sum] = "c3d036a3c4ab069c7b410a2ce876bd74808d2d0888a82667669f8e783a898bf1"
+SRC_URI[arbitrary-1.5.0.sha256sum] = "3bc62ac97cc33321f50863d514c3bc38a453947a8f9e781137e47c7401020aed"
 SRC_URI[assert_cmd-2.2.2.sha256sum] = "2aa3a22042e45de04255c7bf3626e239f450200fd0493c1e382263544b20aea6"
 SRC_URI[autocfg-1.5.1.sha256sum] = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
 SRC_URI[av-data-0.4.4.sha256sum] = "fca67ba5d317924c02180c576157afd54babe48a76ebc66ce6d34bb8ba08308e"
-SRC_URI[bit-set-0.8.0.sha256sum] = "08807e080ed7f9d5433fa9b275196cfc35414f66a0c79d864dc51a0d825231a3"
-SRC_URI[bit-vec-0.8.0.sha256sum] = "5e764a1d40d510daf35e07be9eb06e75770908c27d411ee6c92109c9840eaaf7"
+SRC_URI[bit-set-0.11.1.sha256sum] = "56d87354e4229f54a44f7bf2435906a4656dba36026ab6eaca629a2c436a691c"
+SRC_URI[bit-vec-0.10.1.sha256sum] = "5727b15fa97d4f4fee0a3b7c3d550ed0269f54329207b86388de918604e31269"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
 SRC_URI[bitflags-2.13.2.sha256sum] = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
 SRC_URI[bitreader-0.3.11.sha256sum] = "886559b1e163d56c765bc3a985febb4eee8009f625244511d8ee3c432e08c066"
 SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
 SRC_URI[block-buffer-0.12.1.sha256sum] = "d2f6c7dbe95a6ed67ad9f18e57daf93a2f034c524b99fd2b76d18fdfeb6660aa"
 SRC_URI[block-padding-0.4.2.sha256sum] = "710f1dd022ef4e93f8a438b4ba958de7f64308434fa6a87104481645cc30068b"
+SRC_URI[borsh-1.8.1.sha256sum] = "553c5d846a6ba5150c65e3b1b8ec073bcf1abc20f9b7220de384a4443ea4e20a"
+SRC_URI[borsh-derive-1.8.1.sha256sum] = "12cdfe656708a01f89b451a7d36466e6fe6c414de0aa18fc54f864f6f9ca9f56"
 SRC_URI[bstr-1.13.1.sha256sum] = "6bb31b46c14244e20ee9984b11bf5c992b91fb6939fea616e3512c8baecdbe5f"
 SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
 SRC_URI[byte-slice-cast-1.2.3.sha256sum] = "7575182f7272186991736b70173b0ea045398f984bf5ebbb3804736ce1330c9d"
@@ -397,9 +394,10 @@ SRC_URI[cairo-rs-0.22.9.sha256sum] = "df683f1d30b457964673a5541a4603208ef95ab687
 SRC_URI[cairo-sys-rs-0.22.9.sha256sum] = "ee548131103ad8f698c6725669647b9c757b3b66992dd6a026037596417bee21"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 SRC_URI[cbc-0.2.1.sha256sum] = "ce2dc9ee5f88d11e0beb842c88b33c8a5cf0d1329c4b19494af42b07dbfe8896"
-SRC_URI[cc-1.4.7.sha256sum] = "54413ede23c2daf518f35156dfde027feb2374004d63bd497f983c8db9c0e313"
-SRC_URI[cfg-expr-0.20.9.sha256sum] = "fe4ece8474b5f766c63426647e7b4b316b67431ade1036a8313cee24a03ae917"
+SRC_URI[cc-1.8.0.sha256sum] = "6651c9ed80effdc7db0ff72512157f901af5e3549e341e24b1dd4887d836d838"
+SRC_URI[cfg-expr-0.20.10.sha256sum] = "9ba9e9ec16c447027685b1f897b720e18e9a8afd00bd7332c483537e38086c9f"
 SRC_URI[cfg-if-1.0.5.sha256sum] = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
+SRC_URI[cfg_aliases-0.2.2.sha256sum] = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
 SRC_URI[chacha20-0.10.2.sha256sum] = "65c35e4b699c7e15ccbe7ee35c005e4fc0a278d22238a2857e6ce2dadeda1b06"
 SRC_URI[chrono-0.4.45.sha256sum] = "1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
 SRC_URI[ciborium-0.2.2.sha256sum] = "42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
@@ -432,10 +430,10 @@ SRC_URI[cssparser-macros-0.7.1.sha256sum] = "d045de693cb712d0b22c6a64be5b953f67b
 SRC_URI[data-url-0.3.2.sha256sum] = "be1e0bca6c3637f992fc1cc7cbc52a78c1ef6db076dbf1059c4323d6a2048376"
 SRC_URI[dav1d-0.11.1.sha256sum] = "3ee89cb860616069c67520dcd66cacdb900b57c799f634a0eb6d91f6e2a82b61"
 SRC_URI[dav1d-sys-0.8.3.sha256sum] = "c3c91aea6668645415331133ed6f8ddf0e7f40160cd97a12d59e68716a58704b"
-SRC_URI[defmt-1.1.1.sha256sum] = "e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
-SRC_URI[defmt-macros-1.1.1.sha256sum] = "bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
-SRC_URI[defmt-parser-1.0.0.sha256sum] = "10d60334b3b2e7c9d91ef8150abfb6fa4c1c39ebbcf4a81c2e346aad939fee3e"
-SRC_URI[deranged-0.5.8.sha256sum] = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
+SRC_URI[defmt-1.2.0.sha256sum] = "e4a0795ac740cb54d7b3775c9c17345f6aaecf884c01733b39d6017738e0e3e1"
+SRC_URI[defmt-macros-1.2.0.sha256sum] = "840bb056bd99c495c9188198a258ab787c79f306d864db3e6e8451442d6d8366"
+SRC_URI[defmt-parser-1.1.0.sha256sum] = "71958f69fb2de856c5dd51ac9377e986ca1aa5919f931bf5395a807277f889a0"
+SRC_URI[deranged-0.5.9.sha256sum] = "9e9de72ce2ad1f90dc62fa25f0f430ef85eb4b0d8fa0be4f30373bc40a21d28e"
 SRC_URI[derive_more-2.1.1.sha256sum] = "d751e9e49156b02b44f9c1815bcb94b984cdcc4396ecc32521c739452808b134"
 SRC_URI[derive_more-impl-2.1.1.sha256sum] = "799a97264921d8623a957f6c3b9011f3b5492f557bbb7a5a19b7fa6d06ba8dcb"
 SRC_URI[diff-0.1.13.sha256sum] = "56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
@@ -446,14 +444,14 @@ SRC_URI[dlib-0.5.3.sha256sum] = "ab8ecd87370524b461f8557c119c405552c396ed91fc0a8
 SRC_URI[dtoa-1.0.11.sha256sum] = "4c3cf4824e2d5f025c7b531afcb2325364084a16806f6d47fbc1f5fbd9960590"
 SRC_URI[dtoa-short-0.3.5.sha256sum] = "cd1511a7b6a56299bd043a9c167a6d2bfb37bf84a6dfceaba651168adfb43c87"
 SRC_URI[ecb-0.2.1.sha256sum] = "26f2a8b3e564eba0877223dc343703ad0385794e882e6d13f3a4dd5c6b1f41ac"
-SRC_URI[either-1.18.0.sha256sum] = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
-SRC_URI[encoding_rs-0.8.41.sha256sum] = "7b5ef0006ac9ab233c38522f5ae99cae3625151de8f706cacee1cba4b8e2832a"
-SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+SRC_URI[either-1.19.0.sha256sum] = "0e9c71c2167ca323c882b99918929403426e2373ea17242ff5653e0d5e1058be"
+SRC_URI[encoding_rs-0.8.42.sha256sum] = "8e985e0451871ad22fb8d2b6b076e2028a502a0d3950998c2c5c0a4f9b5d9679"
+SRC_URI[equivalent-1.0.3.sha256sum] = "00d174d5400e5e8fd687ad1049e2f578285fa914201b1af7e8b112a4546bd826"
 SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible_collections-0.4.9.sha256sum] = "a88c69768c0a15262df21899142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
 SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[fdeflate-0.3.7.sha256sum] = "1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
-SRC_URI[find-msvc-tools-0.1.13.sha256sum] = "ef25905e51abafe4dcea6c15fec58c57b601cdbd0ee53d22ea1d3016c587d39b"
+SRC_URI[find-msvc-tools-0.1.14.sha256sum] = "aedcfb3409746eddb02b9e19ebda1c3394f759a152e48ee875a0844d1b955484"
 SRC_URI[flate2-1.1.10.sha256sum] = "6e634e2e0ebac1ee034020da1ca582e17ffe4e0f5e985823721e168928136dcb"
 SRC_URI[float-cmp-0.10.0.sha256sum] = "b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
@@ -467,10 +465,9 @@ SRC_URI[futures-task-0.3.34.sha256sum] = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef
 SRC_URI[futures-util-0.3.34.sha256sum] = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
 SRC_URI[gdk-pixbuf-0.22.0.sha256sum] = "25f420376dbee041b2db374ce4573892a36222bb3f6c0c43e24f0d67eae9b646"
 SRC_URI[gdk-pixbuf-sys-0.22.9.sha256sum] = "9d5209294ba3775f9b650bf78bfadeba4332089f2329b3e2f6ce0a4957a45bff"
-SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
 SRC_URI[getrandom-0.4.3.sha256sum] = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
 SRC_URI[gif-0.14.2.sha256sum] = "ee8cfcc411d9adbbaba82fb72661cc1bcca13e8bba98b364e62b2dba8f960159"
-SRC_URI[gio-0.22.9.sha256sum] = "b399f4650bb52c051f3fdf49a234e8a27ab5725c8cd774556c55eee64b2c0350"
+SRC_URI[gio-0.22.10.sha256sum] = "4620fbafdf19dba814473e19f18e75290cb3338662f6ae35f0402affd3b2b699"
 SRC_URI[gio-sys-0.22.9.sha256sum] = "6c28739f914c15b87a9856000bed9cbd5b3a8afbca5e982d9a299e1601422cb5"
 SRC_URI[gio-unix-0.22.8.sha256sum] = "ce8d768735e229742c135afa3d3326604088d2df0679901cdb05e791fe2fbe0a"
 SRC_URI[gio-unix-sys-0.22.9.sha256sum] = "7c01dbb58f92f67548d85e2209e073acc7ee04e107c7e04ee69b49e38b4933b4"
@@ -479,8 +476,8 @@ SRC_URI[gio-win32-sys-0.22.9.sha256sum] = "81b96f21f242e3ee9076561f3ff04e8ac1fed
 SRC_URI[glam-0.30.10.sha256sum] = "19fc433e8437a212d1b6f1e68c7824af3aed907da60afa994e7f542d18d12aa9"
 SRC_URI[glam-0.31.1.sha256sum] = "556f6b2ea90b8d15a74e0e7bb41671c9bdf38cd9f78c284d750b9ce58a2b5be7"
 SRC_URI[glam-0.32.1.sha256sum] = "f70749695b063ecbf6b62949ccccde2e733ec3ecbbd71d467dca4e5c6c97cca0"
-SRC_URI[glam-0.33.7.sha256sum] = "e762b9b188634fc508d4ec54b62ea3d352c43fd431d18d05d46f559f217f4725"
-SRC_URI[glib-0.22.9.sha256sum] = "18b9b8d350db41f690ec1b87109f202782748bbd8ab2f2ede17cb40d29e2838c"
+SRC_URI[glam-0.33.12.sha256sum] = "37bfe73dc8ec21f54d181e5a60554327ec3f1c600c455a75ccbfc65d2106a6c4"
+SRC_URI[glib-0.22.10.sha256sum] = "e4cf9e5bd8713f1990a92c422998826e0fb34824277b46bc59757373483c6694"
 SRC_URI[glib-macros-0.22.9.sha256sum] = "c9597c68fa7bdf4154a3079642cd21c4dccac0b0bdd2897d82861523bf91e7b9"
 SRC_URI[glib-sys-0.22.9.sha256sum] = "99b38907e67e40dec9b60f858bcada952598719cb512a13eb13d6cdcd16f8295"
 SRC_URI[gobject-sys-0.22.9.sha256sum] = "07595c9ba696bd9819cb6a8df39f08078f3dd679508fe052dd558492c2053834"
@@ -503,21 +500,21 @@ SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3
 SRC_URI[image-0.25.10.sha256sum] = "85ab80394333c02fe689eaf900ab500fbd0c2213da414687ebf995a65d5a6104"
 SRC_URI[image-webp-0.2.4.sha256sum] = "525e9ff3e1a4be2fbea1fdf0e98686a6d98b4d8f937e1bf7402245af1909e8c3"
 SRC_URI[indexmap-2.14.2.sha256sum] = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
-SRC_URI[inout-0.2.2.sha256sum] = "4250ce6452e92010fdf7268ccc5d14faa80bb12fc741938534c58f16804e03c7"
+SRC_URI[inout-0.2.4.sha256sum] = "3ce983bb6fb399067d101fbfc9e74174e07e9f29a2bc679efefeb8c645819c3f"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
 SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
 SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
-SRC_URI[jiff-0.2.37.sha256sum] = "0ab1baf72f08796de0260609515130699b890ac25f30e610ad894bc5856cafdb"
+SRC_URI[jiff-0.2.38.sha256sum] = "b2b005715dcbeb0089a3c0dab99f2ff1cc3b2525323552703d648585d342a383"
 SRC_URI[jiff-core-0.1.1.sha256sum] = "5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
-SRC_URI[jiff-static-0.2.37.sha256sum] = "378268a1116ad67ae6228701118ac9f491d78fda38a40a1f1a9e1348de6f7212"
-SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
+SRC_URI[jiff-static-0.2.38.sha256sum] = "2cc9817253cf7c7ee4684451bd327e88d6f3658014e54a29198625590650695c"
+SRC_URI[jiff-tzdb-0.1.9.sha256sum] = "fa8377070c6bae868759445e5a77f66d84f0b72f3a054bfb00e6d038b8282da7"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
-SRC_URI[js-sys-0.3.105.sha256sum] = "ce57d20d1ea864ce2ac172ab472d409214f4fd359f0b2a2775abdf522e2af99e"
+SRC_URI[js-sys-0.3.106.sha256sum] = "7883d941dae510fb2d978fc3fe018c71c9e2892fd38854de3e8b92c2e5ad9cc5"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+SRC_URI[lazy_static-1.5.1.sha256sum] = "20870f649af7073d53e38067b2a84312175d56ea15217e1b15bc83506ec50afb"
+SRC_URI[libc-0.2.190.sha256sum] = "ce5d3ddc6d3fa000eb1536d85e147bfe31aacaba692ed6a876f95cb7c855be78"
 SRC_URI[libfuzzer-sys-0.4.13.sha256sum] = "a9fd2f41a1cba099f79a0b6b6c35656cf7c03351a7bae8ff0f28f25270f929d2"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
@@ -536,8 +533,6 @@ SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce385
 SRC_URI[miniz_oxide-0.9.1.sha256sum] = "b63fbc4a50860e98e7b2aa7804ded1db5cbc3aff9193adaff57a6931bf7c4b4c"
 SRC_URI[moxcms-0.8.1.sha256sum] = "bb85c154ba489f01b25c0d36ae69a87e4a1c73a72631fc6c0eb6dde34a73e44b"
 SRC_URI[mp4parse-0.17.0.sha256sum] = "63a35203d3c6ce92d5251c77520acb2e57108c88728695aa883f70023624c570"
-SRC_URI[multiversion-0.9.0.sha256sum] = "b4ca4bea16ffc3f443cf7d866912118196bfef4c6a1556ca00f9f9b00bb43f7c"
-SRC_URI[multiversion-macros-0.9.0.sha256sum] = "0d416831a7317ef4b08bee00b69cbbb9c8763da7959a7026244d6266869f9c83"
 SRC_URI[multiversion_no_op-1.0.0.sha256sum] = "743fb55ba31b18fb1ecef6bdc9aa2743314978ac084044301a7eee33fb99a20d"
 SRC_URI[mutants-0.0.4.sha256sum] = "add0ac067452ff1aca8c5002111bd6b1c895baee6e45fcbc44e0193aea17be56"
 SRC_URI[nalgebra-0.35.0.sha256sum] = "adc43a60c217b0c6ff46e47f26911015ad8d2e5a8be1af668c67e370d99a4346"
@@ -581,27 +576,23 @@ SRC_URI[png-0.18.1.sha256sum] = "60769b8b31b2a9f263dae2776c37b1b28ae246943cf719e
 SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
 SRC_URI[portable-atomic-util-0.2.8.sha256sum] = "10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
 SRC_URI[potential_utf-0.1.6.sha256sum] = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
-SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
-SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
+SRC_URI[powerfmt-0.2.1.sha256sum] = "4a6394b9e965e73d0a289ee54f589087e2c676aedf60885baf52c76b771e4958"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
 SRC_URI[predicates-3.1.4.sha256sum] = "ada8f2932f28a27ee7b70dd6c1c39ea0675c55a36879ab92f3a715eaa1e63cfe"
 SRC_URI[predicates-core-1.0.10.sha256sum] = "cad38746f3166b4031b1a0d39ad9f954dd291e7854fcc0eed52ee41a0b50d144"
 SRC_URI[predicates-tree-1.0.13.sha256sum] = "d0de1b847b39c8131db0467e9df1ff60e6d0562ab8e9a16e568ad0fdb372e2f2"
 SRC_URI[pretty_assertions-1.4.1.sha256sum] = "3ae130e2f271fbc2ac3a40fb1d07180839cdbbe443c7a27e1e3c13c5cac0116d"
+SRC_URI[proc-macro-crate-3.5.0.sha256sum] = "e67ba7e9b2b56446f1d419b1d807906278ffa1a658a8a5d8a39dcb1f5a78614f"
 SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
-SRC_URI[proptest-1.11.0.sha256sum] = "4b45fcc2344c680f5025fe57779faef368840d0bd1f42f216291f0dc4ace4744"
+SRC_URI[proptest-1.12.0.sha256sum] = "b8530004ccb15eae51c7e40009fbe317f341f804db54dc033eec1c50be28cfa0"
 SRC_URI[pxfm-0.1.30.sha256sum] = "d55d956fa96f5ec02be2e13af0e20391a5aa83d6a074e3ad368959d0fab299ea"
 SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
 SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
-SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
-SRC_URI[rand-0.9.5.sha256sum] = "b9ef1d0d795eb7d84685bca4f72f3649f064e6641543d3a8c415898726a57b41"
-SRC_URI[rand-0.10.2.sha256sum] = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
-SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
-SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
+SRC_URI[rand-0.10.3.sha256sum] = "65c9fb96cbc91e3478eaae79a69fcd3f1ae4ad052e471fe6732fff548984b4af"
 SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
-SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
+SRC_URI[rand_xorshift-0.5.0.sha256sum] = "60aa6af80be32871323012e02e6e65f8a7cc7890931ae421d217ad8fe0df2ccf"
 SRC_URI[rangemap-1.8.0.sha256sum] = "a611d15b50743feb4c76b7d03edcb0e64f399c26961e4efe6975bc398be6aa3d"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
 SRC_URI[rayon-1.12.0.sha256sum] = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
@@ -625,18 +616,18 @@ SRC_URI[semver-1.0.28.sha256sum] = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba
 SRC_URI[serde-1.0.229.sha256sum] = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
 SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
 SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
-SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
-SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
+SRC_URI[serde_json-1.0.154.sha256sum] = "e7e9cc8b1b85264074fbcc02a88680c4096b1e47df8f739dceb03bf482f04bd6"
+SRC_URI[serde_spanned-1.1.2.sha256sum] = "4e7523beb55eece201a2356bee0bbca0d1ab466c14c07703b2e0ee6d42cb0c2c"
 SRC_URI[servo_arc-0.4.3.sha256sum] = "170fb83ab34de17dc69aa7c67482b22218ddb85da56546f9bd6b929e32a05930"
-SRC_URI[sha2-0.11.0.sha256sum] = "446ba717509524cb3f22f17ecc096f10f4822d76ab5c0b9822c5f9c284e825f4"
+SRC_URI[sha2-0.11.1.sha256sum] = "47d7069beb7d6ac7b9acd1039986e73443f24234f41074da099d6f994ac9ad19"
 SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
 SRC_URI[simba-0.10.2.sha256sum] = "f1a7200d82ff1c7b4235efd12f11e2537a402c91cf83a5cb97ce80eef787fde7"
 SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
 SRC_URI[simdutf8-0.1.5.sha256sum] = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
-SRC_URI[siphasher-1.0.3.sha256sum] = "8ee5873ec9cce0195efcb7a4e9507a04cd49aec9c83d0389df45b1ef7ba2e649"
+SRC_URI[siphasher-1.0.4.sha256sum] = "33f4fe9184a62d842c9ef383018f3306d8ba224fd9d836f56d7288308847c256"
 SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
-SRC_URI[smallvec-1.16.1.sha256sum] = "ba467056f1b547ed52077911161fc86985becbc60e8e1857c8a144dab0def891"
+SRC_URI[smallvec-1.16.3.sha256sum] = "5b3dc8af474f516a851ff4bd12db780f948b9250ad37211e4eec0bccea54e01b"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[string_cache-0.9.0.sha256sum] = "a18596f8c785a729f2819c0f6a7eae6ebeebdfffbfe4214ae6b087f690e31901"
@@ -645,7 +636,7 @@ SRC_URI[string_cache_codegen-0.6.1.sha256sum] = "585635e46db231059f76c5849798146
 SRC_URI[stringprep-0.1.5.sha256sum] = "7b4df3d392d81bd458a8a621b8bffbd2302a12ffe288a9d931670948749463b1"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
 SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
-SRC_URI[syn-3.0.6.sha256sum] = "8593e8e72159ed2257d083c7a454a85cbf854f37a0966d8d483aff8c8a3ebcee"
+SRC_URI[syn-3.0.9.sha256sum] = "d78c8dee4c7bf0e14673097256fed6142ce9d3b85a408189d07482442145823b"
 SRC_URI[synstructure-0.14.0.sha256sum] = "901704edd0dfe137f1987838ee4f259e4e063c31371bdb423f7ae38ec6f77f02"
 SRC_URI[system-deps-7.0.8.sha256sum] = "396a35feb67335377e0251fcbc1092fc85c484bd4e3a7a54319399da127796e7"
 SRC_URI[system-deps-9.0.0.sha256sum] = "8a0dae2cbca1f0ff93795713cfe0a4c02f760e3c0b8ae2ab4ec4045808ff429f"
@@ -653,22 +644,23 @@ SRC_URI[target-lexicon-0.13.5.sha256sum] = "adb6935a6f5c20170eeceb1a3835a49e12e1
 SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[tendril-0.5.1.sha256sum] = "5fed54709c5b3a53d09bb1c113ea4f5ceafd1e772ddcb0030a82e1d56c087b08"
 SRC_URI[termtree-0.5.1.sha256sum] = "8f50febec83f5ee1df3015341d8bd429f2d1cc62bcba7ea2076759d315084683"
-SRC_URI[thiserror-2.0.20.sha256sum] = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
-SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
+SRC_URI[thiserror-2.0.21.sha256sum] = "09e52cb86a36cede5cb101bf8908837b3e4c6e5e59fe7fd85c23fb56200d189e"
+SRC_URI[thiserror-impl-2.0.21.sha256sum] = "fe5197923287db20a58125f0bc85c062f7f2c892de97b18c356f9efb14b28524"
 SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
 SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
 SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
 SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.13.3.sha256sum] = "fd3ca314f692efd6c868f8408f53fe444634a845f96c028b97d35f6a1f79f0ee"
-SRC_URI[toml-1.1.6+spec-1.1.0.sha256sum] = "920602543f0911ab71da12c50d59701da54c196d1a2bf5cb4b75667f137a406a"
-SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
-SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
-SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+SRC_URI[toml-1.1.8+spec-1.1.0.sha256sum] = "20489e00e4d8741d6be680764cc12e270655e375a20d1011e844a9c3379e678d"
+SRC_URI[toml_datetime-1.1.2+spec-1.1.0.sha256sum] = "2b86d767906c6c42421dcba507eb9d203e779497710a47782a224bb871653053"
+SRC_URI[toml_edit-0.25.17+spec-1.1.0.sha256sum] = "e3641d5bbb5349a79e1020a242d251efbc546ad8048d133958323ce9c40a9c9c"
+SRC_URI[toml_parser-1.1.5+spec-1.1.0.sha256sum] = "baa693a8032d7e1cada7d0041e96126df243179ff061456783ac7f12bda4744c"
+SRC_URI[toml_writer-1.1.3+spec-1.1.0.sha256sum] = "06bdbd8cfc056b8d2e2e85f29b56a3bdbecb527cef81eb39e3e7b98af4652770"
 SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
 SRC_URI[unicode-bidi-0.3.18.sha256sum] = "5c1cb5db39152898a79168971543b1cb5020dff7fe43c8dc468b0885f5e29df5"
-SRC_URI[unicode-ident-1.0.26.sha256sum] = "d245f478577f809a851594d02313b640fb437e0bb33866753cff937863096954"
+SRC_URI[unicode-ident-1.0.27.sha256sum] = "a2c754d6c33795a1c324727428e5a7dedb5b06195f9890bdbcba760d3e246563"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-properties-0.1.4.sha256sum] = "7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
 SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
@@ -678,12 +670,11 @@ SRC_URI[version-compare-0.2.1.sha256sum] = "03c2856837ef78f57382f06b2b8563a2f512
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[wait-timeout-0.2.1.sha256sum] = "09ac3b126d3914f9849036f826e054cbabdc8519970b8998ddaf3b5bd3c65f11"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
-SRC_URI[wasip2-1.0.4+wasi-0.2.12.sha256sum] = "b67efb37e106e55ce722a510d6b5f9c17f083e5fc79afc2badeb12cc313d9487"
-SRC_URI[wasm-bindgen-0.2.128.sha256sum] = "aecb87a33d3b0c5e3b7aa46336eaf486cffafbd281b195e4c8b80d50df2351bf"
-SRC_URI[wasm-bindgen-macro-0.2.128.sha256sum] = "a690d511e3c1a8b3a55e33511e3c2c00c78415cd23650f32b808627f5696b9ed"
-SRC_URI[wasm-bindgen-macro-support-0.2.128.sha256sum] = "411e4887f0071ef2d2164a9d5fdf2d20efbef78fccd3a78b0c10a1dc5295e48a"
-SRC_URI[wasm-bindgen-shared-0.2.128.sha256sum] = "81941cd78d0c92026c33e5e01312845a4cb1e9af3407f9134b100dd03144103e"
-SRC_URI[web-sys-0.3.105.sha256sum] = "9fbddc4a036f00ec4f18c83445bd3115cb306a91da554919a099d9222fe4a7f8"
+SRC_URI[wasm-bindgen-0.2.129.sha256sum] = "9bb54f33acc68fd454578d9820b0bde1a1a3d17aa17bb7b6595806d02886d409"
+SRC_URI[wasm-bindgen-macro-0.2.129.sha256sum] = "2e29d0c35b16e224a7eeb5cd2d25e3e1968fbd65604117b44d3b789d00ee8535"
+SRC_URI[wasm-bindgen-macro-support-0.2.129.sha256sum] = "6f501a8bc3719dba86ef8ae4728879c08001bea749eb1333ac5b91e040e2a6b7"
+SRC_URI[wasm-bindgen-shared-0.2.129.sha256sum] = "23f0c9c52aa7cd7d77769a4cfe2a9adb1b331f489a41d912ce14513d5ab995c6"
+SRC_URI[web-sys-0.3.106.sha256sum] = "88261b9deccee56594c11a3460c462c41f58d148598fe70ad77070126a68aba4"
 SRC_URI[web_atoms-0.2.6.sha256sum] = "ba8b815c1b593dc0baf78dd0f4fc8fdb2de53198fb1163738093e9a311c33fb3"
 SRC_URI[weezl-0.1.12.sha256sum] = "a28ac98ddc8b9274cb41bb4d9d4d5c425b6020c50c46f25559911905610b4a88"
 SRC_URI[weezl-0.2.1.sha256sum] = "d4ca08e5ef825b65b056d9efbd95c8750683f0a6d0466d02e96dc2e4e360f3d2"
@@ -700,15 +691,14 @@ SRC_URI[windows-result-0.4.1.sha256sum] = "7781fa89eaf60850ac3d2da7af8e5242a5ea7
 SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
 SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
-SRC_URI[wit-bindgen-0.57.1.sha256sum] = "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
 SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
 SRC_URI[xml5ever-0.39.0.sha256sum] = "5ab627f34ff61b80d756180d556f9c68801d836d271b3b8c094504ceca69d221"
 SRC_URI[yansi-1.0.1.sha256sum] = "cfe53a6657fd280eaa890a3bc59152892ffa3e30101319d168b781ed6529b049"
 SRC_URI[yeslogic-fontconfig-sys-6.0.1.sha256sum] = "1d8b8abf912b9a29ff112e1671c97c33636903d13a69712037190e6805af4f76"
 SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
-SRC_URI[yoke-derive-0.8.3.sha256sum] = "33811428bee40dbceb6d545e95754741d17a6aef9a4849f0fd62e2ba4f412a78"
-SRC_URI[zerocopy-0.8.57.sha256sum] = "d35102a9f36d089ccae9e4c6802bc118be4487b80aaffc0ab4e0cf5ce92d2873"
-SRC_URI[zerocopy-derive-0.8.57.sha256sum] = "146c01f5ab44258da43cf276c74a2763db2ff3969c9c652c3f2de07041d0b2bc"
+SRC_URI[yoke-derive-0.8.4.sha256sum] = "ec8ebde2db3681e8c9980cc27822030e68752690ddfa9473e739aeb4dbde6d71"
+SRC_URI[zerocopy-0.8.63.sha256sum] = "e5fe1f8f1b06191a00962174c61aa5005e0bb391a6d80d07e24d115c01a92ed8"
+SRC_URI[zerocopy-derive-0.8.63.sha256sum] = "863ad3ac83293fb4d740aedbfdc9240dd8d1a50c1099acd76ce80ce7c7230c7f"
 SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
 SRC_URI[zerofrom-derive-0.1.8.sha256sum] = "f75b4683f6c7f45248d4d64056a24298c6281e0993356d7d1b4a1a962ef10d4a"
 SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
diff --git a/recipes-gnome/librsvg/librsvg_2.63.2.bb b/recipes-gnome/librsvg/librsvg_2.63.3.bb
similarity index 98%
rename from recipes-gnome/librsvg/librsvg_2.63.2.bb
rename to recipes-gnome/librsvg/librsvg_2.63.3.bb
index 114401d..cdf386a 100644
--- a/recipes-gnome/librsvg/librsvg_2.63.2.bb
+++ b/recipes-gnome/librsvg/librsvg_2.63.3.bb
@@ -26,7 +26,7 @@ require ${BPN}-crates.inc
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
             file://run-ptest"
-SRC_URI[archive.sha256sum] = "852b18e1a00b8605528825a27dc7748bff2a5dd254028f59dc22a34ea57e81b6"
+SRC_URI[archive.sha256sum] = "55311c2293612e4a2e38cd9bdb6160a1c85c158adc7c97e423e1e65949afb6a4"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.56.0

