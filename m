Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6302.1794870776615253385
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=J6ikpaHY;
 spf=pass (domain: konsulko.com, ip: 209.85.221.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ec20398b05so4061165e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870775; x=1795475575; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7oZJF1+YMhg/FguKWcJ9ut/gkl3N/+NQN/TQ5ygAIW0=;
        b=J6ikpaHY9vvpktp3Qhix0FlTMb9i/8I4TmECcVtq33k1Svc6CjqyZPsCOFKWpVgmgo
         ok+aTm1F/gre381EXiDqASIwt4SQ3QEhb0Vf+qdmgkckKlMB0IjYKSRTIUZCF0FASp2H
         C2FTBPaSpAAQxfBrAjP0akFjB4jRyannsn+cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870775; x=1795475575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7oZJF1+YMhg/FguKWcJ9ut/gkl3N/+NQN/TQ5ygAIW0=;
        b=B/kZ2iEwZO+7bXXzcusHOBIUrHYCYNMrW2klXr/xsArASoTJP9qYdpOlYyqVBZ7l7e
         crCkFCmdudvo+LFOTx8dhc8ubtZ2aBkrk0SHd/i/riBgTBwePovGYhd0n6xvurTNExue
         nhj26qAe8jCsRJe+GqLcQojtiG0OjHxnCMBkgTuL3lvGjzdLFb5aPRfc4zjSoV6Idu5q
         eAF7vj4anDssGbrXOeeDsNhiHREnNYrHT1RBj5fuiMeBPdJzGVY5Y1GNwsYf3hdlxMwK
         5O6jxwUVyx0GRCw4+1RCSn+n5Fqw1G8/CN81vSKneNsfSLr68vM8wI2O0LIUXgzoUv71
         1cRg==
X-Gm-Message-State: APuU4Z+yymhg1/2Mq/acmrRUyikajLVMeVzp3lWJYnVERpyWTHL/Je1H
	JtCiS+Gzl/kJ0LghlgoXiQ22i6JOVuk81aflaSwSR/6Pxrn/vseGvEQ7xO+xIUkUuADba6vu8zQ
	OHwN7lW4=
X-Gm-Gg: AYBFou3C/aC0gCU2uW+rC3EmhTRtcH/y1ZwXHJCY4mYh5JoPCaSLXLvJuWBz7eGon1N
	53yeMBrhf4KVEd617aaIn1cBFguc+f630BBBFJe59YPPFHw3lmAYXg3Q69DY3QzO0Whhu2OhMZp
	qR5gYFHtD9Mnwd3qELDIxrSAwA1zEIbp34JWBFnoizF84VvuAhgVzYkc/XBanFwAH+bnHTDXw1S
	FKO85xiRaknckT4oFIauq/M4SPjclMdLhVvUJby5nyeikwGzRhV9bwRIPNh7q8WFKcEBg9xOxCc
	X040oC16aIZxdG78u3ORIcuIZm2AhxnQbGH9rbqzB6BA97hotsoOmpgAXwfbsBMNKes+u6pDKbs
	XqzBvJtIC+IXpSJ/wLK9Kx5Zk38ZNHLqL8TpNJmAXOy4qnGkWIvLXbteXDtrvJRPWAEECEw94dZ
	N5lzNVyNHRSqR4U/PP2nN683JplVLXg1X+rt6KqUI92dw42PcSSdwmbHZ/d6YsP2fEMRa9lh1W/
	9cMHgpv6TBmcmq6OC9K+F1VSou/nar3TStQDk86RP4+dCObbM42UMUkceLqVKRUf2MYJVnYJ4GN
	Bn7x+oLsIsRIdDB+lEfXzZHtXEzCZ2ZKXSen5XtlLTEuxzg5q+LIMkzxZARVR7QFy6XfKiz6NVn
	x0HbUIby+F9jQ4m+Tsi/FrFrOB9h30Nl2SaE+LFvzbsclykoh7KXE3s9IsTZsKt1IxQ==
X-Received: by 2002:a05:6122:514:b0:5ea:c4a9:e6f9 with SMTP id 71dfb90a1353d-5ee34a52399mr4814191e0c.5.1794870774299;
        Mon, 16 Nov 2026 15:12:54 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 02/19] librsvg: upgrade 2.62.3 -> 2.63.0
Date: Mon, 16 Nov 2026 18:12:23 -0500
Message-ID: <e846b7961b17eed0f6751180dac2a093627b1735.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5442
Content-Type: text/plain; charset="utf-8"

From: Ross Burton <ross.burton@arm.com>

Changelog:

- Limit the depth of files that reference other files, via XML XInclude,
  inter-document references, and CSS includes.  The Rust API has a new
  ImplementationLimit::MaximumFileNestingDepthExceeded error variant to
  surface this to the loading functions.
- Fix blurry embeded SVG images by rasterizing them at device
  resolution.
- Raise the maximum nesting depth of layers for glibc systems.  The
  maximum on glibc is now 500 nested layers; the maximum for musl
  systems remains at 50 layers.  This is due to the amount of stack
  space required, since musl has a reduced default stack compared to
  glibc.  Please see the comments in that bug if you would like to help
  with the musl situation.
- Update test suite for change in how Pango renders underline/overline.
- Update Rust dependencies.
- Update C dependencies in the CI.
- Limit the depth of files that reference other files, via XML XInclude,
  inter-document references, and CSS includes.  The Rust API has a new
  ImplementationLimit::MaximumFileNestingDepthExceeded error variant to
  surface this to the loading functions.
- Remove loading limits from image-rs.  This means that raster images,
  when embedded in SVG documents, have no limits for their size or
  memory consumption.  The idea, for now, is that security-sensitive
  applications that use librsvg should do their own sandboxing if they
  want to impose memory limits.
- Fix the logic for whether gdk-pixbuf-query-loaders should be run
  during cross-compilation.  Native builds can of course use it; cross
  builds can use it if they can run host binaries *and* an executable
  wrapper has been set *and* the target sysroot contains the
  corresponding gdk-pixbuf-query-loaders executable (Ross Burton).
- Document the crate's feature flags.

Remove the test suite backporting as those fixes are now included.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1c322292b88f768bbab7d33004ad193ed6f5a3a0)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 816 +++++++++---------
 .../{librsvg_2.62.3.bb => librsvg_2.63.0.bb}  |   2 +-
 2 files changed, 407 insertions(+), 411 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.62.3.bb => librsvg_2.63.0.bb} (98%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index c6db9dc..3945c46 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -3,191 +3,187 @@
 # from Cargo.lock
 SRC_URI += " \
     crate://crates.io/adler2/2.0.1 \
-    crate://crates.io/aes/0.8.4 \
+    crate://crates.io/aes/0.9.2 \
     crate://crates.io/ahash/0.8.12 \
-    crate://crates.io/aho-corasick/1.1.4 \
-    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/aho-corasick/1.1.5 \
+    crate://crates.io/alloca/0.4.0 \
+    crate://crates.io/android_system_properties/0.1.6 \
     crate://crates.io/anes/0.1.6 \
-    crate://crates.io/anstream/0.6.21 \
-    crate://crates.io/anstyle/1.0.13 \
-    crate://crates.io/anstyle-parse/0.2.7 \
+    crate://crates.io/anstream/1.0.0 \
+    crate://crates.io/anstyle/1.0.14 \
+    crate://crates.io/anstyle-parse/1.0.0 \
     crate://crates.io/anstyle-query/1.1.5 \
     crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.1.2 \
-    crate://crates.io/autocfg/1.5.0 \
+    crate://crates.io/arbitrary/1.4.2 \
+    crate://crates.io/assert_cmd/2.2.2 \
+    crate://crates.io/autocfg/1.5.1 \
     crate://crates.io/av-data/0.4.4 \
     crate://crates.io/bit-set/0.8.0 \
     crate://crates.io/bit-vec/0.8.0 \
-    crate://crates.io/bitflags/2.10.0 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bitflags/2.13.1 \
     crate://crates.io/bitreader/0.3.11 \
     crate://crates.io/block/0.1.6 \
-    crate://crates.io/block-buffer/0.10.4 \
-    crate://crates.io/block-padding/0.3.3 \
-    crate://crates.io/bstr/1.12.1 \
-    crate://crates.io/bumpalo/3.19.1 \
+    crate://crates.io/block-buffer/0.12.1 \
+    crate://crates.io/block-padding/0.4.2 \
+    crate://crates.io/bstr/1.13.1 \
+    crate://crates.io/bumpalo/3.20.3 \
     crate://crates.io/byte-slice-cast/1.2.3 \
-    crate://crates.io/bytecount/0.6.9 \
-    crate://crates.io/bytemuck/1.24.0 \
+    crate://crates.io/bytemuck/1.25.2 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/byteorder-lite/0.1.0 \
-    crate://crates.io/bytes/1.11.1 \
+    crate://crates.io/bytes/1.12.1 \
     crate://crates.io/cairo-rs/0.22.0 \
     crate://crates.io/cairo-sys-rs/0.22.0 \
     crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cbc/0.1.2 \
-    crate://crates.io/cc/1.2.54 \
-    crate://crates.io/cfg-expr/0.20.6 \
+    crate://crates.io/cbc/0.2.1 \
+    crate://crates.io/cc/1.4.2 \
+    crate://crates.io/cfg-expr/0.20.8 \
     crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/chrono/0.4.43 \
+    crate://crates.io/chacha20/0.10.1 \
+    crate://crates.io/chrono/0.4.45 \
     crate://crates.io/ciborium/0.2.2 \
     crate://crates.io/ciborium-io/0.2.2 \
     crate://crates.io/ciborium-ll/0.2.2 \
-    crate://crates.io/cipher/0.4.4 \
-    crate://crates.io/clap/4.5.56 \
-    crate://crates.io/clap_builder/4.5.56 \
-    crate://crates.io/clap_complete/4.5.65 \
-    crate://crates.io/clap_derive/4.5.55 \
-    crate://crates.io/clap_lex/0.7.7 \
+    crate://crates.io/cipher/0.5.2 \
+    crate://crates.io/clap/4.6.6 \
+    crate://crates.io/clap_builder/4.6.6 \
+    crate://crates.io/clap_complete/4.6.9 \
+    crate://crates.io/clap_derive/4.6.4 \
+    crate://crates.io/clap_lex/1.1.0 \
     crate://crates.io/color_quant/1.1.0 \
-    crate://crates.io/colorchoice/1.0.4 \
+    crate://crates.io/colorchoice/1.0.5 \
+    crate://crates.io/const-oid/0.10.2 \
     crate://crates.io/core-foundation-sys/0.8.7 \
-    crate://crates.io/cpufeatures/0.2.17 \
+    crate://crates.io/cpubits/0.1.1 \
+    crate://crates.io/cpufeatures/0.3.0 \
     crate://crates.io/crc32fast/1.5.0 \
-    crate://crates.io/criterion/0.7.0 \
-    crate://crates.io/criterion-plot/0.6.0 \
-    crate://crates.io/crossbeam-deque/0.8.6 \
-    crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-utils/0.8.21 \
+    crate://crates.io/criterion/0.8.2 \
+    crate://crates.io/criterion-plot/0.8.2 \
+    crate://crates.io/crossbeam-deque/0.8.7 \
+    crate://crates.io/crossbeam-epoch/0.9.20 \
+    crate://crates.io/crossbeam-utils/0.8.22 \
     crate://crates.io/crunchy/0.2.4 \
-    crate://crates.io/crypto-common/0.1.7 \
-    crate://crates.io/cssparser/0.35.0 \
-    crate://crates.io/cssparser-color/0.3.0 \
-    crate://crates.io/cssparser-macros/0.6.1 \
+    crate://crates.io/crypto-common/0.2.2 \
+    crate://crates.io/cssparser/0.37.0 \
+    crate://crates.io/cssparser-color/0.5.0 \
+    crate://crates.io/cssparser-macros/0.7.0 \
     crate://crates.io/data-url/0.3.2 \
     crate://crates.io/dav1d/0.11.1 \
     crate://crates.io/dav1d-sys/0.8.3 \
-    crate://crates.io/deranged/0.5.5 \
+    crate://crates.io/defmt/1.1.1 \
+    crate://crates.io/defmt-macros/1.1.1 \
+    crate://crates.io/defmt-parser/1.0.0 \
+    crate://crates.io/deranged/0.5.8 \
     crate://crates.io/derive_more/2.1.1 \
     crate://crates.io/derive_more-impl/2.1.1 \
     crate://crates.io/diff/0.1.13 \
     crate://crates.io/difflib/0.4.0 \
-    crate://crates.io/digest/0.10.7 \
-    crate://crates.io/displaydoc/0.2.5 \
-    crate://crates.io/dlib/0.5.2 \
+    crate://crates.io/digest/0.11.3 \
+    crate://crates.io/displaydoc/0.2.7 \
+    crate://crates.io/dlib/0.5.3 \
     crate://crates.io/dtoa/1.0.11 \
     crate://crates.io/dtoa-short/0.3.5 \
-    crate://crates.io/ecb/0.1.2 \
-    crate://crates.io/either/1.15.0 \
+    crate://crates.io/ecb/0.2.0 \
+    crate://crates.io/either/1.17.0 \
     crate://crates.io/encoding_rs/0.8.35 \
     crate://crates.io/equivalent/1.0.2 \
     crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible_collections/0.4.9 \
-    crate://crates.io/fastrand/2.3.0 \
+    crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/fdeflate/0.3.7 \
-    crate://crates.io/find-msvc-tools/0.1.8 \
-    crate://crates.io/flate2/1.1.8 \
+    crate://crates.io/find-msvc-tools/0.1.10 \
+    crate://crates.io/flate2/1.1.9 \
     crate://crates.io/float-cmp/0.10.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.2 \
-    crate://crates.io/futf/0.1.5 \
-    crate://crates.io/futures-channel/0.3.31 \
-    crate://crates.io/futures-core/0.3.32 \
-    crate://crates.io/futures-executor/0.3.31 \
-    crate://crates.io/futures-io/0.3.31 \
-    crate://crates.io/futures-macro/0.3.32 \
-    crate://crates.io/futures-task/0.3.32 \
-    crate://crates.io/futures-util/0.3.32 \
-    crate://crates.io/fxhash/0.2.1 \
+    crate://crates.io/futures-channel/0.3.34 \
+    crate://crates.io/futures-core/0.3.34 \
+    crate://crates.io/futures-executor/0.3.34 \
+    crate://crates.io/futures-io/0.3.34 \
+    crate://crates.io/futures-macro/0.3.34 \
+    crate://crates.io/futures-task/0.3.34 \
+    crate://crates.io/futures-util/0.3.34 \
     crate://crates.io/gdk-pixbuf/0.22.0 \
     crate://crates.io/gdk-pixbuf-sys/0.22.0 \
-    crate://crates.io/generic-array/0.14.7 \
     crate://crates.io/getrandom/0.3.4 \
-    crate://crates.io/gif/0.14.1 \
-    crate://crates.io/gio/0.22.1 \
-    crate://crates.io/gio-sys/0.22.0 \
-    crate://crates.io/gio-unix/0.22.0 \
+    crate://crates.io/getrandom/0.4.3 \
+    crate://crates.io/gif/0.14.2 \
+    crate://crates.io/gio/0.22.8 \
+    crate://crates.io/gio-sys/0.22.8 \
+    crate://crates.io/gio-unix/0.22.8 \
     crate://crates.io/gio-unix-sys/0.22.0 \
-    crate://crates.io/gio-win32/0.22.0 \
+    crate://crates.io/gio-win32/0.22.8 \
     crate://crates.io/gio-win32-sys/0.22.0 \
-    crate://crates.io/glam/0.14.0 \
-    crate://crates.io/glam/0.15.2 \
-    crate://crates.io/glam/0.16.0 \
-    crate://crates.io/glam/0.17.3 \
-    crate://crates.io/glam/0.18.0 \
-    crate://crates.io/glam/0.19.0 \
-    crate://crates.io/glam/0.20.5 \
-    crate://crates.io/glam/0.21.3 \
-    crate://crates.io/glam/0.22.0 \
-    crate://crates.io/glam/0.23.0 \
-    crate://crates.io/glam/0.24.2 \
-    crate://crates.io/glam/0.25.0 \
-    crate://crates.io/glam/0.27.0 \
-    crate://crates.io/glam/0.28.0 \
-    crate://crates.io/glam/0.29.3 \
     crate://crates.io/glam/0.30.10 \
-    crate://crates.io/glib/0.22.0 \
-    crate://crates.io/glib-macros/0.22.0 \
-    crate://crates.io/glib-sys/0.22.0 \
-    crate://crates.io/gobject-sys/0.22.0 \
+    crate://crates.io/glam/0.31.1 \
+    crate://crates.io/glam/0.32.1 \
+    crate://crates.io/glam/0.33.3 \
+    crate://crates.io/glib/0.22.8 \
+    crate://crates.io/glib-macros/0.22.6 \
+    crate://crates.io/glib-sys/0.22.8 \
+    crate://crates.io/gobject-sys/0.22.6 \
     crate://crates.io/half/2.7.1 \
     crate://crates.io/hashbrown/0.13.2 \
-    crate://crates.io/hashbrown/0.16.1 \
+    crate://crates.io/hashbrown/0.17.1 \
     crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hybrid-array/0.4.14 \
     crate://crates.io/iana-time-zone/0.1.65 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/icu_collections/2.1.1 \
-    crate://crates.io/icu_locale_core/2.1.1 \
-    crate://crates.io/icu_normalizer/2.1.1 \
-    crate://crates.io/icu_normalizer_data/2.1.1 \
-    crate://crates.io/icu_properties/2.1.2 \
-    crate://crates.io/icu_properties_data/2.1.2 \
-    crate://crates.io/icu_provider/2.1.1 \
+    crate://crates.io/icu_collections/2.2.0 \
+    crate://crates.io/icu_locale_core/2.2.0 \
+    crate://crates.io/icu_normalizer/2.2.0 \
+    crate://crates.io/icu_normalizer_data/2.2.0 \
+    crate://crates.io/icu_properties/2.2.0 \
+    crate://crates.io/icu_properties_data/2.2.0 \
+    crate://crates.io/icu_provider/2.2.0 \
     crate://crates.io/idna/1.1.0 \
-    crate://crates.io/idna_adapter/1.2.1 \
+    crate://crates.io/idna_adapter/1.2.2 \
     crate://crates.io/image/0.25.10 \
     crate://crates.io/image-webp/0.2.4 \
-    crate://crates.io/indexmap/2.13.0 \
-    crate://crates.io/inout/0.1.4 \
+    crate://crates.io/indexmap/2.14.0 \
+    crate://crates.io/inout/0.2.2 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.13.0 \
-    crate://crates.io/itertools/0.14.0 \
-    crate://crates.io/itoa/1.0.17 \
-    crate://crates.io/jiff/0.2.18 \
-    crate://crates.io/jiff-static/0.2.18 \
-    crate://crates.io/jiff-tzdb/0.1.5 \
+    crate://crates.io/itertools/0.15.0 \
+    crate://crates.io/itoa/1.0.18 \
+    crate://crates.io/jiff/0.2.35 \
+    crate://crates.io/jiff-core/0.1.0 \
+    crate://crates.io/jiff-static/0.2.35 \
+    crate://crates.io/jiff-tzdb/0.1.8 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
-    crate://crates.io/js-sys/0.3.85 \
+    crate://crates.io/jobserver/0.1.35 \
+    crate://crates.io/js-sys/0.3.104 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.180 \
+    crate://crates.io/libc/0.2.189 \
+    crate://crates.io/libfuzzer-sys/0.4.13 \
     crate://crates.io/libloading/0.8.9 \
-    crate://crates.io/linux-raw-sys/0.11.0 \
-    crate://crates.io/litemap/0.8.1 \
+    crate://crates.io/linux-raw-sys/0.12.1 \
+    crate://crates.io/litemap/0.8.2 \
     crate://crates.io/locale_config/0.3.0 \
     crate://crates.io/lock_api/0.4.14 \
-    crate://crates.io/log/0.4.29 \
-    crate://crates.io/lopdf/0.38.0 \
-    crate://crates.io/mac/0.1.1 \
+    crate://crates.io/log/0.4.33 \
+    crate://crates.io/lopdf/0.44.0 \
     crate://crates.io/malloc_buf/0.0.6 \
-    crate://crates.io/markup5ever/0.35.0 \
+    crate://crates.io/markup5ever/0.39.0 \
     crate://crates.io/matches/0.1.10 \
-    crate://crates.io/matrixmultiply/0.3.10 \
-    crate://crates.io/md-5/0.10.6 \
-    crate://crates.io/memchr/2.8.0 \
+    crate://crates.io/matrixmultiply/0.3.11 \
+    crate://crates.io/md-5/0.11.0 \
+    crate://crates.io/memchr/2.8.3 \
     crate://crates.io/miniz_oxide/0.8.9 \
     crate://crates.io/moxcms/0.8.1 \
     crate://crates.io/mp4parse/0.17.0 \
-    crate://crates.io/mutants/0.0.3 \
-    crate://crates.io/nalgebra/0.34.1 \
+    crate://crates.io/mutants/0.0.4 \
+    crate://crates.io/nalgebra/0.35.0 \
     crate://crates.io/nalgebra-macros/0.3.0 \
     crate://crates.io/new_debug_unreachable/1.0.6 \
     crate://crates.io/nom/8.0.0 \
-    crate://crates.io/nom_locate/5.0.0 \
     crate://crates.io/normalize-line-endings/0.3.0 \
-    crate://crates.io/num-bigint/0.4.6 \
+    crate://crates.io/num-bigint/0.4.8 \
     crate://crates.io/num-complex/0.4.6 \
-    crate://crates.io/num-conv/0.2.0 \
+    crate://crates.io/num-conv/0.2.2 \
     crate://crates.io/num-derive/0.4.2 \
     crate://crates.io/num-integer/0.1.46 \
     crate://crates.io/num-rational/0.4.2 \
@@ -195,136 +191,138 @@ SRC_URI += " \
     crate://crates.io/objc/0.2.7 \
     crate://crates.io/objc-foundation/0.1.1 \
     crate://crates.io/objc_id/0.1.1 \
-    crate://crates.io/once_cell/1.21.3 \
+    crate://crates.io/once_cell/1.21.4 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/oorandom/11.1.5 \
-    crate://crates.io/pango/0.22.0 \
+    crate://crates.io/page_size/0.6.0 \
+    crate://crates.io/pango/0.22.8 \
     crate://crates.io/pango-sys/0.22.0 \
-    crate://crates.io/pangocairo/0.22.0 \
+    crate://crates.io/pangocairo/0.22.8 \
     crate://crates.io/pangocairo-sys/0.22.0 \
     crate://crates.io/parking_lot/0.12.5 \
     crate://crates.io/parking_lot_core/0.9.12 \
-    crate://crates.io/paste/1.0.15 \
     crate://crates.io/percent-encoding/2.3.2 \
-    crate://crates.io/phf/0.11.3 \
-    crate://crates.io/phf_codegen/0.11.3 \
-    crate://crates.io/phf_generator/0.11.3 \
-    crate://crates.io/phf_macros/0.11.3 \
-    crate://crates.io/phf_shared/0.11.3 \
+    crate://crates.io/phf/0.13.1 \
+    crate://crates.io/phf_codegen/0.13.1 \
+    crate://crates.io/phf_generator/0.13.1 \
+    crate://crates.io/phf_macros/0.13.1 \
     crate://crates.io/phf_shared/0.13.1 \
-    crate://crates.io/pin-project-lite/0.2.16 \
-    crate://crates.io/pkg-config/0.3.32 \
+    crate://crates.io/phf_shared/0.14.0 \
+    crate://crates.io/pin-project-lite/0.2.17 \
+    crate://crates.io/pkg-config/0.3.33 \
     crate://crates.io/plotters/0.3.7 \
     crate://crates.io/plotters-backend/0.3.7 \
     crate://crates.io/plotters-svg/0.3.7 \
     crate://crates.io/png/0.18.1 \
-    crate://crates.io/portable-atomic/1.13.0 \
-    crate://crates.io/portable-atomic-util/0.2.4 \
-    crate://crates.io/potential_utf/0.1.4 \
+    crate://crates.io/portable-atomic/1.15.0 \
+    crate://crates.io/portable-atomic-util/0.2.7 \
+    crate://crates.io/potential_utf/0.1.5 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/precomputed-hash/0.1.1 \
-    crate://crates.io/predicates/3.1.3 \
-    crate://crates.io/predicates-core/1.0.9 \
-    crate://crates.io/predicates-tree/1.0.12 \
+    crate://crates.io/predicates/3.1.4 \
+    crate://crates.io/predicates-core/1.0.10 \
+    crate://crates.io/predicates-tree/1.0.13 \
     crate://crates.io/pretty_assertions/1.4.1 \
-    crate://crates.io/proc-macro2/1.0.106 \
-    crate://crates.io/proptest/1.9.0 \
-    crate://crates.io/pxfm/0.1.27 \
+    crate://crates.io/proc-macro2/1.0.107 \
+    crate://crates.io/proptest/1.11.0 \
+    crate://crates.io/pxfm/0.1.30 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/quote/1.0.44 \
+    crate://crates.io/quote/1.0.47 \
     crate://crates.io/r-efi/5.3.0 \
-    crate://crates.io/rand/0.8.6 \
-    crate://crates.io/rand/0.9.4 \
+    crate://crates.io/r-efi/6.0.0 \
+    crate://crates.io/rand/0.9.5 \
+    crate://crates.io/rand/0.10.2 \
     crate://crates.io/rand_chacha/0.9.0 \
-    crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.9.5 \
+    crate://crates.io/rand_core/0.10.1 \
     crate://crates.io/rand_xorshift/0.4.0 \
     crate://crates.io/rangemap/1.7.1 \
     crate://crates.io/rawpointer/0.2.1 \
-    crate://crates.io/rayon/1.11.0 \
+    crate://crates.io/rayon/1.12.0 \
     crate://crates.io/rayon-core/1.13.0 \
     crate://crates.io/rctree/0.6.0 \
     crate://crates.io/redox_syscall/0.5.18 \
-    crate://crates.io/regex/1.12.2 \
-    crate://crates.io/regex-automata/0.4.13 \
-    crate://crates.io/regex-syntax/0.8.8 \
-    crate://crates.io/rgb/0.8.52 \
+    crate://crates.io/regex/1.13.1 \
+    crate://crates.io/regex-automata/0.4.18 \
+    crate://crates.io/regex-syntax/0.8.11 \
+    crate://crates.io/rgb/0.8.53 \
+    crate://crates.io/rustc-hash/2.1.3 \
     crate://crates.io/rustc_version/0.4.1 \
-    crate://crates.io/rustix/1.1.3 \
-    crate://crates.io/rustversion/1.0.22 \
+    crate://crates.io/rustix/1.1.4 \
+    crate://crates.io/rustversion/1.0.23 \
     crate://crates.io/rusty-fork/0.3.1 \
-    crate://crates.io/safe_arch/0.7.4 \
+    crate://crates.io/safe_arch/1.1.0 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
-    crate://crates.io/selectors/0.31.0 \
-    crate://crates.io/semver/1.0.27 \
-    crate://crates.io/serde/1.0.228 \
-    crate://crates.io/serde_core/1.0.228 \
-    crate://crates.io/serde_derive/1.0.228 \
-    crate://crates.io/serde_json/1.0.149 \
-    crate://crates.io/serde_spanned/1.0.4 \
+    crate://crates.io/selectors/0.40.0 \
+    crate://crates.io/semver/1.0.28 \
+    crate://crates.io/serde/1.0.229 \
+    crate://crates.io/serde_core/1.0.229 \
+    crate://crates.io/serde_derive/1.0.229 \
+    crate://crates.io/serde_json/1.0.151 \
+    crate://crates.io/serde_spanned/1.1.1 \
     crate://crates.io/servo_arc/0.4.3 \
-    crate://crates.io/sha2/0.10.9 \
+    crate://crates.io/sha2/0.11.0 \
     crate://crates.io/shell-words/1.1.1 \
-    crate://crates.io/shlex/1.3.0 \
-    crate://crates.io/simba/0.9.1 \
-    crate://crates.io/simd-adler32/0.3.8 \
-    crate://crates.io/siphasher/1.0.2 \
-    crate://crates.io/slab/0.4.11 \
-    crate://crates.io/smallvec/1.15.1 \
+    crate://crates.io/shlex/2.0.1 \
+    crate://crates.io/simba/0.10.2 \
+    crate://crates.io/simd-adler32/0.3.10 \
+    crate://crates.io/siphasher/1.0.3 \
+    crate://crates.io/slab/0.4.12 \
+    crate://crates.io/smallvec/1.15.2 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
-    crate://crates.io/string_cache/0.8.9 \
     crate://crates.io/string_cache/0.9.0 \
-    crate://crates.io/string_cache_codegen/0.5.4 \
+    crate://crates.io/string_cache/0.10.0 \
+    crate://crates.io/string_cache_codegen/0.6.1 \
     crate://crates.io/stringprep/0.1.5 \
     crate://crates.io/strsim/0.11.1 \
-    crate://crates.io/syn/2.0.114 \
+    crate://crates.io/syn/2.0.119 \
+    crate://crates.io/syn/3.0.3 \
     crate://crates.io/synstructure/0.13.2 \
-    crate://crates.io/system-deps/7.0.7 \
-    crate://crates.io/target-lexicon/0.13.3 \
-    crate://crates.io/tempfile/3.24.0 \
-    crate://crates.io/tendril/0.4.3 \
+    crate://crates.io/system-deps/7.0.8 \
+    crate://crates.io/target-lexicon/0.13.5 \
+    crate://crates.io/tempfile/3.27.0 \
+    crate://crates.io/tendril/0.5.1 \
     crate://crates.io/termtree/0.5.1 \
-    crate://crates.io/thiserror/2.0.18 \
-    crate://crates.io/thiserror-impl/2.0.18 \
-    crate://crates.io/time/0.3.47 \
-    crate://crates.io/time-core/0.1.8 \
-    crate://crates.io/time-macros/0.2.27 \
-    crate://crates.io/tinystr/0.8.2 \
+    crate://crates.io/thiserror/2.0.20 \
+    crate://crates.io/thiserror-impl/2.0.20 \
+    crate://crates.io/time/0.3.55 \
+    crate://crates.io/time-core/0.1.9 \
+    crate://crates.io/time-macros/0.2.32 \
+    crate://crates.io/tinystr/0.8.3 \
     crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/tinyvec/1.10.0 \
+    crate://crates.io/tinyvec/1.12.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.9.11+spec-1.1.0 \
-    crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
-    crate://crates.io/toml_parser/1.0.6+spec-1.1.0 \
-    crate://crates.io/toml_writer/1.0.6+spec-1.1.0 \
-    crate://crates.io/ttf-parser/0.25.1 \
-    crate://crates.io/typenum/1.19.0 \
+    crate://crates.io/toml/1.1.4+spec-1.1.0 \
+    crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
+    crate://crates.io/typenum/1.20.1 \
     crate://crates.io/unarray/0.1.4 \
     crate://crates.io/unicode-bidi/0.3.18 \
-    crate://crates.io/unicode-ident/1.0.22 \
+    crate://crates.io/unicode-ident/1.0.24 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-properties/0.1.4 \
     crate://crates.io/url/2.5.8 \
-    crate://crates.io/utf-8/0.7.6 \
     crate://crates.io/utf8_iter/1.0.4 \
     crate://crates.io/utf8parse/0.2.2 \
     crate://crates.io/version-compare/0.2.1 \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/wait-timeout/0.2.1 \
     crate://crates.io/walkdir/2.5.0 \
-    crate://crates.io/wasip2/1.0.2+wasi-0.2.9 \
-    crate://crates.io/wasm-bindgen/0.2.108 \
-    crate://crates.io/wasm-bindgen-macro/0.2.108 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.108 \
-    crate://crates.io/wasm-bindgen-shared/0.2.108 \
-    crate://crates.io/web-sys/0.3.85 \
-    crate://crates.io/web_atoms/0.1.3 \
+    crate://crates.io/wasip2/1.0.4+wasi-0.2.12 \
+    crate://crates.io/wasm-bindgen/0.2.127 \
+    crate://crates.io/wasm-bindgen-macro/0.2.127 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.127 \
+    crate://crates.io/wasm-bindgen-shared/0.2.127 \
+    crate://crates.io/web-sys/0.3.104 \
+    crate://crates.io/web_atoms/0.2.6 \
     crate://crates.io/weezl/0.1.12 \
-    crate://crates.io/wide/0.7.33 \
+    crate://crates.io/weezl/0.2.1 \
+    crate://crates.io/wide/1.6.1 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.11 \
@@ -336,212 +334,208 @@ SRC_URI += " \
     crate://crates.io/windows-result/0.4.1 \
     crate://crates.io/windows-strings/0.5.1 \
     crate://crates.io/windows-sys/0.61.2 \
-    crate://crates.io/winnow/0.7.14 \
-    crate://crates.io/wit-bindgen/0.51.0 \
-    crate://crates.io/writeable/0.6.2 \
-    crate://crates.io/xml5ever/0.35.0 \
+    crate://crates.io/winnow/1.0.4 \
+    crate://crates.io/wit-bindgen/0.57.1 \
+    crate://crates.io/writeable/0.6.3 \
+    crate://crates.io/xml5ever/0.39.0 \
     crate://crates.io/yansi/1.0.1 \
-    crate://crates.io/yeslogic-fontconfig-sys/6.0.0 \
-    crate://crates.io/yoke/0.8.1 \
-    crate://crates.io/yoke-derive/0.8.1 \
-    crate://crates.io/zerocopy/0.8.36 \
-    crate://crates.io/zerocopy-derive/0.8.36 \
-    crate://crates.io/zerofrom/0.1.6 \
-    crate://crates.io/zerofrom-derive/0.1.6 \
-    crate://crates.io/zerotrie/0.2.3 \
-    crate://crates.io/zerovec/0.11.5 \
-    crate://crates.io/zerovec-derive/0.11.2 \
-    crate://crates.io/zmij/1.0.17 \
-    crate://crates.io/zune-core/0.5.1 \
-    crate://crates.io/zune-jpeg/0.5.13 \
+    crate://crates.io/yeslogic-fontconfig-sys/6.0.1 \
+    crate://crates.io/yoke/0.8.3 \
+    crate://crates.io/yoke-derive/0.8.2 \
+    crate://crates.io/zerocopy/0.8.56 \
+    crate://crates.io/zerocopy-derive/0.8.56 \
+    crate://crates.io/zerofrom/0.1.8 \
+    crate://crates.io/zerofrom-derive/0.1.7 \
+    crate://crates.io/zerotrie/0.2.4 \
+    crate://crates.io/zerovec/0.11.6 \
+    crate://crates.io/zerovec-derive/0.11.3 \
+    crate://crates.io/zmij/1.0.23 \
+    crate://crates.io/zune-core/0.5.3 \
+    crate://crates.io/zune-jpeg/0.5.15 \
 "
 
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
-SRC_URI[aes-0.8.4.sha256sum] = "b169f7a6d4742236a0a00c541b845991d0ac43e546831af1249753ab4c3aa3a0"
+SRC_URI[aes-0.9.2.sha256sum] = "f8eb277bec05f56a0e0591f155a484cbd0f4f07ff2905051a48c72f004f7ed58"
 SRC_URI[ahash-0.8.12.sha256sum] = "5a15f179cd60c4584b8a8c596927aadc462e27f2ca70c04e0071964a73ba7a75"
-SRC_URI[aho-corasick-1.1.4.sha256sum] = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
-SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[aho-corasick-1.1.5.sha256sum] = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
+SRC_URI[alloca-0.4.0.sha256sum] = "e5a7d05ea6aea7e9e64d25b9156ba2fee3fdd659e34e41063cd2fc7cd020d7f4"
+SRC_URI[android_system_properties-0.1.6.sha256sum] = "ae221649c9976a6f6c56ae1facf410f3ddb33cc661c4b7b61020a912d4237fbc"
 SRC_URI[anes-0.1.6.sha256sum] = "4b46cbb362ab8752921c97e041f5e366ee6297bd428a31275b9fcf1e380f7299"
-SRC_URI[anstream-0.6.21.sha256sum] = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
-SRC_URI[anstyle-1.0.13.sha256sum] = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
-SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
+SRC_URI[anstream-1.0.0.sha256sum] = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
+SRC_URI[anstyle-1.0.14.sha256sum] = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
+SRC_URI[anstyle-parse-1.0.0.sha256sum] = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
 SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[approx-0.5.1.sha256sum] = "cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.1.2.sha256sum] = "9c5bcfa8749ac45dd12cb11055aeeb6b27a3895560d60d71e3c23bf979e60514"
-SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
+SRC_URI[arbitrary-1.4.2.sha256sum] = "c3d036a3c4ab069c7b410a2ce876bd74808d2d0888a82667669f8e783a898bf1"
+SRC_URI[assert_cmd-2.2.2.sha256sum] = "2aa3a22042e45de04255c7bf3626e239f450200fd0493c1e382263544b20aea6"
+SRC_URI[autocfg-1.5.1.sha256sum] = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
 SRC_URI[av-data-0.4.4.sha256sum] = "fca67ba5d317924c02180c576157afd54babe48a76ebc66ce6d34bb8ba08308e"
 SRC_URI[bit-set-0.8.0.sha256sum] = "08807e080ed7f9d5433fa9b275196cfc35414f66a0c79d864dc51a0d825231a3"
 SRC_URI[bit-vec-0.8.0.sha256sum] = "5e764a1d40d510daf35e07be9eb06e75770908c27d411ee6c92109c9840eaaf7"
-SRC_URI[bitflags-2.10.0.sha256sum] = "812e12b5285cc515a9c72a5c1d3b6d46a19dac5acfef5265968c166106e31dd3"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bitflags-2.13.1.sha256sum] = "b588b76d00fde79687d7646a9b5bdf3cc0f655e0bbd080335a95d7e96f3587da"
 SRC_URI[bitreader-0.3.11.sha256sum] = "886559b1e163d56c765bc3a985febb4eee8009f625244511d8ee3c432e08c066"
 SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
-SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
-SRC_URI[block-padding-0.3.3.sha256sum] = "a8894febbff9f758034a5b8e12d87918f56dfc64a8e1fe757d65e29041538d93"
-SRC_URI[bstr-1.12.1.sha256sum] = "63044e1ae8e69f3b5a92c736ca6269b8d12fa7efe39bf34ddb06d102cf0e2cab"
-SRC_URI[bumpalo-3.19.1.sha256sum] = "5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
+SRC_URI[block-buffer-0.12.1.sha256sum] = "d2f6c7dbe95a6ed67ad9f18e57daf93a2f034c524b99fd2b76d18fdfeb6660aa"
+SRC_URI[block-padding-0.4.2.sha256sum] = "710f1dd022ef4e93f8a438b4ba958de7f64308434fa6a87104481645cc30068b"
+SRC_URI[bstr-1.13.1.sha256sum] = "6bb31b46c14244e20ee9984b11bf5c992b91fb6939fea616e3512c8baecdbe5f"
+SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
 SRC_URI[byte-slice-cast-1.2.3.sha256sum] = "7575182f7272186991736b70173b0ea045398f984bf5ebbb3804736ce1330c9d"
-SRC_URI[bytecount-0.6.9.sha256sum] = "175812e0be2bccb6abe50bb8d566126198344f707e304f45c648fd8f2cc0365e"
-SRC_URI[bytemuck-1.24.0.sha256sum] = "1fbdf580320f38b612e485521afda1ee26d10cc9884efaaa750d383e13e3c5f4"
+SRC_URI[bytemuck-1.25.2.sha256sum] = "95832e849adfb21180ccb6826a99da14e5d266ae5c2e668e1602cf234f153797"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[byteorder-lite-0.1.0.sha256sum] = "8f1fe948ff07f4bd06c30984e69f5b4899c516a3ef74f34df92a2df2ab535495"
-SRC_URI[bytes-1.11.1.sha256sum] = "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33"
+SRC_URI[bytes-1.12.1.sha256sum] = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
 SRC_URI[cairo-rs-0.22.0.sha256sum] = "5cc8d9aa793480744cd9a0524fef1a2e197d9eaa0f739cde19d16aba530dcb95"
 SRC_URI[cairo-sys-rs-0.22.0.sha256sum] = "f8b4985713047f5faee02b8db6a6ef32bbb50269ff53c1aee716d1d195b76d54"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
-SRC_URI[cbc-0.1.2.sha256sum] = "26b52a9543ae338f279b96b0b9fed9c8093744685043739079ce85cd58f289a6"
-SRC_URI[cc-1.2.54.sha256sum] = "6354c81bbfd62d9cfa9cb3c773c2b7b2a3a482d569de977fd0e961f6e7c00583"
-SRC_URI[cfg-expr-0.20.6.sha256sum] = "78cef5b5a1a6827c7322ae2a636368a573006b27cfa76c7ebd53e834daeaab6a"
+SRC_URI[cbc-0.2.1.sha256sum] = "ce2dc9ee5f88d11e0beb842c88b33c8a5cf0d1329c4b19494af42b07dbfe8896"
+SRC_URI[cc-1.4.2.sha256sum] = "5d262e149917187838d5b42777c8253bcb64500067342904e7d429499a6f277e"
+SRC_URI[cfg-expr-0.20.8.sha256sum] = "fb693542bcafa528e198be0ebd9d3632ca5b7c93dbe7237460e199910835997c"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[chrono-0.4.43.sha256sum] = "fac4744fb15ae8337dc853fee7fb3f4e48c0fbaa23d0afe49c447b4fab126118"
+SRC_URI[chacha20-0.10.1.sha256sum] = "d524456ba66e72eb8b115ff89e01e497f8e6d11d78b70b1aa13c0fbd97540a81"
+SRC_URI[chrono-0.4.45.sha256sum] = "1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
 SRC_URI[ciborium-0.2.2.sha256sum] = "42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
 SRC_URI[ciborium-io-0.2.2.sha256sum] = "05afea1e0a06c9be33d539b876f1ce3692f4afea2cb41f740e7743225ed1c757"
 SRC_URI[ciborium-ll-0.2.2.sha256sum] = "57663b653d948a338bfb3eeba9bb2fd5fcfaecb9e199e87e1eda4d9e8b240fd9"
-SRC_URI[cipher-0.4.4.sha256sum] = "773f3b9af64447d2ce9850330c473515014aa235e6a783b02db81ff39e4a3dad"
-SRC_URI[clap-4.5.56.sha256sum] = "a75ca66430e33a14957acc24c5077b503e7d374151b2b4b3a10c83b4ceb4be0e"
-SRC_URI[clap_builder-4.5.56.sha256sum] = "793207c7fa6300a0608d1080b858e5fdbe713cdc1c8db9fb17777d8a13e63df0"
-SRC_URI[clap_complete-4.5.65.sha256sum] = "430b4dc2b5e3861848de79627b2bedc9f3342c7da5173a14eaa5d0f8dc18ae5d"
-SRC_URI[clap_derive-4.5.55.sha256sum] = "a92793da1a46a5f2a02a6f4c46c6496b28c43638adea8306fcb0caa1634f24e5"
-SRC_URI[clap_lex-0.7.7.sha256sum] = "c3e64b0cc0439b12df2fa678eae89a1c56a529fd067a9115f7827f1fffd22b32"
+SRC_URI[cipher-0.5.2.sha256sum] = "e8cf2a2c93cd704877c0858356ed03480ff301ee950b43f1cbe4573b088bfa6c"
+SRC_URI[clap-4.6.6.sha256sum] = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
+SRC_URI[clap_builder-4.6.6.sha256sum] = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
+SRC_URI[clap_complete-4.6.9.sha256sum] = "3be2ad0423bdbbb0e25bc89add796f3559706d4a95e1bc98e4d9662a957b6a19"
+SRC_URI[clap_derive-4.6.4.sha256sum] = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
+SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
 SRC_URI[color_quant-1.1.0.sha256sum] = "3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
-SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
+SRC_URI[colorchoice-1.0.5.sha256sum] = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
+SRC_URI[const-oid-0.10.2.sha256sum] = "a6ef517f0926dd24a1582492c791b6a4818a4d94e789a334894aa15b0d12f55c"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
-SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
+SRC_URI[cpubits-0.1.1.sha256sum] = "15b85f9c39137c3a891689859392b1bd49812121d0d61c9caf00d46ed5ce06ae"
+SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
 SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
-SRC_URI[criterion-0.7.0.sha256sum] = "e1c047a62b0cc3e145fa84415a3191f628e980b194c2755aa12300a4e6cbd928"
-SRC_URI[criterion-plot-0.6.0.sha256sum] = "9b1bcc0dc7dfae599d84ad0b1a55f80cde8af3725da8313b528da95ef783e338"
-SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
-SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
+SRC_URI[criterion-0.8.2.sha256sum] = "950046b2aa2492f9a536f5f4f9a3de7b9e2476e575e05bd6c333371add4d98f3"
+SRC_URI[criterion-plot-0.8.2.sha256sum] = "d8d80a2f4f5b554395e47b5d8305bc3d27813bacb73493eb1001e8f76dae29ea"
+SRC_URI[crossbeam-deque-0.8.7.sha256sum] = "5181e0de7b61eb03a81e347d6dd8797bae9da5146707b51077e2d71a54ec0ceb"
+SRC_URI[crossbeam-epoch-0.9.20.sha256sum] = "2d6914041f254d6e9176c01941b21115dcfb7089e55135a35411081bd106ef3f"
+SRC_URI[crossbeam-utils-0.8.22.sha256sum] = "61803da095bee82a81bb1a452ecc25d3b2f1416d1897eb86430c6159ef717c17"
 SRC_URI[crunchy-0.2.4.sha256sum] = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
-SRC_URI[crypto-common-0.1.7.sha256sum] = "78c8292055d1c1df0cce5d180393dc8cce0abec0a7102adb6c7b1eef6016d60a"
-SRC_URI[cssparser-0.35.0.sha256sum] = "4e901edd733a1472f944a45116df3f846f54d37e67e68640ac8bb69689aca2aa"
-SRC_URI[cssparser-color-0.3.0.sha256sum] = "6eeef9ae8c0e112edd89eb6406b3156ffa99c7e037b3baef1dbdf4158d35c324"
-SRC_URI[cssparser-macros-0.6.1.sha256sum] = "13b588ba4ac1a99f7f2964d24b3d896ddc6bf847ee3855dbd4366f058cfcd331"
+SRC_URI[crypto-common-0.2.2.sha256sum] = "ce6e4c961d6cd6c9a86db418387425e8bdeaf05b3c8bc1411e6dca4c252f1453"
+SRC_URI[cssparser-0.37.0.sha256sum] = "8c9cdaae01d5ed7882b04d795e7f752f46ff52d2fa3b50a20d28c464510bba98"
+SRC_URI[cssparser-color-0.5.0.sha256sum] = "bbaa233e1dcd9c13a5d3e3a8a2c0f5a727bac380398345dbcb31db4597edc86b"
+SRC_URI[cssparser-macros-0.7.0.sha256sum] = "10a2a99df6e410a8ff4245aa2006499ea662245f967cc7c0a38c83ef8eb44dbf"
 SRC_URI[data-url-0.3.2.sha256sum] = "be1e0bca6c3637f992fc1cc7cbc52a78c1ef6db076dbf1059c4323d6a2048376"
 SRC_URI[dav1d-0.11.1.sha256sum] = "3ee89cb860616069c67520dcd66cacdb900b57c799f634a0eb6d91f6e2a82b61"
 SRC_URI[dav1d-sys-0.8.3.sha256sum] = "c3c91aea6668645415331133ed6f8ddf0e7f40160cd97a12d59e68716a58704b"
-SRC_URI[deranged-0.5.5.sha256sum] = "ececcb659e7ba858fb4f10388c250a7252eb0a27373f1a72b8748afdd248e587"
+SRC_URI[defmt-1.1.1.sha256sum] = "e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
+SRC_URI[defmt-macros-1.1.1.sha256sum] = "bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
+SRC_URI[defmt-parser-1.0.0.sha256sum] = "10d60334b3b2e7c9d91ef8150abfb6fa4c1c39ebbcf4a81c2e346aad939fee3e"
+SRC_URI[deranged-0.5.8.sha256sum] = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
 SRC_URI[derive_more-2.1.1.sha256sum] = "d751e9e49156b02b44f9c1815bcb94b984cdcc4396ecc32521c739452808b134"
 SRC_URI[derive_more-impl-2.1.1.sha256sum] = "799a97264921d8623a957f6c3b9011f3b5492f557bbb7a5a19b7fa6d06ba8dcb"
 SRC_URI[diff-0.1.13.sha256sum] = "56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
 SRC_URI[difflib-0.4.0.sha256sum] = "6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"
-SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
-SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
-SRC_URI[dlib-0.5.2.sha256sum] = "330c60081dcc4c72131f8eb70510f1ac07223e5d4163db481a04a0befcffa412"
+SRC_URI[digest-0.11.3.sha256sum] = "f1dd6dbb5841937940781866fa1281a1ff7bd3bf827091440879f9994983d5c2"
+SRC_URI[displaydoc-0.2.7.sha256sum] = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308ccd87b1c098f1fb2eaf82a8"
+SRC_URI[dlib-0.5.3.sha256sum] = "ab8ecd87370524b461f8557c119c405552c396ed91fc0a8eec68679eab26f94a"
 SRC_URI[dtoa-1.0.11.sha256sum] = "4c3cf4824e2d5f025c7b531afcb2325364084a16806f6d47fbc1f5fbd9960590"
 SRC_URI[dtoa-short-0.3.5.sha256sum] = "cd1511a7b6a56299bd043a9c167a6d2bfb37bf84a6dfceaba651168adfb43c87"
-SRC_URI[ecb-0.1.2.sha256sum] = "1a8bfa975b1aec2145850fcaa1c6fe269a16578c44705a532ae3edc92b8881c7"
-SRC_URI[either-1.15.0.sha256sum] = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
+SRC_URI[ecb-0.2.0.sha256sum] = "fbfbf3db731928d6912bc3beda911d55b834cee3df6131ba79b337a1298a3fa9"
+SRC_URI[either-1.17.0.sha256sum] = "9e5e8f6c15a24b9a3ee5efec809ccd006d3b30e8b3bb63c39af737c7f87daa1d"
 SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible_collections-0.4.9.sha256sum] = "a88c69768c0a15262df21899142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
-SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
+SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[fdeflate-0.3.7.sha256sum] = "1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
-SRC_URI[find-msvc-tools-0.1.8.sha256sum] = "8591b0bcc8a98a64310a2fae1bb3e9b8564dd10e381e6e28010fde8e8e8568db"
-SRC_URI[flate2-1.1.8.sha256sum] = "b375d6465b98090a5f25b1c7703f3859783755aa9a80433b36e0379a3ec2f369"
+SRC_URI[find-msvc-tools-0.1.10.sha256sum] = "26b73573e6edcd2af0cdf47bd6cb58f0b3839491263c314eaad1ccf24430e1de"
+SRC_URI[flate2-1.1.9.sha256sum] = "843fba2746e448b37e26a819579957415c8cef339bf08564fe8b7ddbd959573c"
 SRC_URI[float-cmp-0.10.0.sha256sum] = "b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
-SRC_URI[futf-0.1.5.sha256sum] = "df420e2e84819663797d1ec6544b13c5be84629e7bb00dc960d6917db2987843"
-SRC_URI[futures-channel-0.3.31.sha256sum] = "2dff15bf788c671c1934e366d07e30c1814a8ef514e1af724a602e8a2fbe1b10"
-SRC_URI[futures-core-0.3.32.sha256sum] = "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
-SRC_URI[futures-executor-0.3.31.sha256sum] = "1e28d1d997f585e54aebc3f97d39e72338912123a67330d723fdbb564d646c9f"
-SRC_URI[futures-io-0.3.31.sha256sum] = "9e5c1b78ca4aae1ac06c48a526a655760685149f0d465d21f37abfe57ce075c6"
-SRC_URI[futures-macro-0.3.32.sha256sum] = "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b"
-SRC_URI[futures-task-0.3.32.sha256sum] = "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
-SRC_URI[futures-util-0.3.32.sha256sum] = "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
-SRC_URI[fxhash-0.2.1.sha256sum] = "c31b6d751ae2c7f11320402d34e41349dd1016f8d5d45e48c4312bc8625af50c"
+SRC_URI[futures-channel-0.3.34.sha256sum] = "b1f9e3d69d39e4862ffed03ed071a76f9a13ba1d9109d355b0f0aa6b15e393c4"
+SRC_URI[futures-core-0.3.34.sha256sum] = "92d699e522242e69e3003b94ecc1f960f3a5e015aa7c5d7486e65ad01dd94f5e"
+SRC_URI[futures-executor-0.3.34.sha256sum] = "031b47cf1a3c6cc8bc2fc76cd437f521619387907d469316e7c0bc278f1f5432"
+SRC_URI[futures-io-0.3.34.sha256sum] = "53c0fa8157de1303bfffdaa1cc2a673bfffb60102f76b0ef4441659124373fed"
+SRC_URI[futures-macro-0.3.34.sha256sum] = "9fb9654ba8355388abeb8dcb4fc62f511300867002afc858860463bdd9fe0c44"
+SRC_URI[futures-task-0.3.34.sha256sum] = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
+SRC_URI[futures-util-0.3.34.sha256sum] = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
 SRC_URI[gdk-pixbuf-0.22.0.sha256sum] = "25f420376dbee041b2db374ce4573892a36222bb3f6c0c43e24f0d67eae9b646"
 SRC_URI[gdk-pixbuf-sys-0.22.0.sha256sum] = "48f31b37b1fc4b48b54f6b91b7ef04c18e00b4585d98359dd7b998774bbd91fb"
-SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
 SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
-SRC_URI[gif-0.14.1.sha256sum] = "f5df2ba84018d80c213569363bdcd0c64e6933c67fe4c1d60ecf822971a3c35e"
-SRC_URI[gio-0.22.1.sha256sum] = "bb018ae3f3967134a833fac8a2568c3e698f4b95c658865360772d73803cc5de"
-SRC_URI[gio-sys-0.22.0.sha256sum] = "64729ba2772c080448f9f966dba8f4456beeb100d8c28a865ef8a0f2ef4987e1"
-SRC_URI[gio-unix-0.22.0.sha256sum] = "69db2f0bb80c9d97c315720c395db76d4649969bce3a130aea6c5c9d757bf80f"
+SRC_URI[getrandom-0.4.3.sha256sum] = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
+SRC_URI[gif-0.14.2.sha256sum] = "ee8cfcc411d9adbbaba82fb72661cc1bcca13e8bba98b364e62b2dba8f960159"
+SRC_URI[gio-0.22.8.sha256sum] = "8b3e1f669909c326b9413bde5a742097b8c90a7d78f45326db13668984769ded"
+SRC_URI[gio-sys-0.22.8.sha256sum] = "353fdc7da7cd16da916104b1e0e4e7de380ec9c8aaa20d4d742d66310ab4b0d5"
+SRC_URI[gio-unix-0.22.8.sha256sum] = "ce8d768735e229742c135afa3d3326604088d2df0679901cdb05e791fe2fbe0a"
 SRC_URI[gio-unix-sys-0.22.0.sha256sum] = "44bab97ce39112040216e268f074645f50b31caeb53af708ab5d7e4e67f0dbfd"
-SRC_URI[gio-win32-0.22.0.sha256sum] = "bcbc408e97739d418bed9200f4af709a47ccfbf7efb9adf02882ba2cdb02304f"
+SRC_URI[gio-win32-0.22.8.sha256sum] = "9daa423bc3dc24305275d0551882c4c0469c1cf842ab14897cf5ffbb63d95cd4"
 SRC_URI[gio-win32-sys-0.22.0.sha256sum] = "d673cd130fa7b598cf3fa776265a8e4c02634f3283433d441b8fc6f9fe07f327"
-SRC_URI[glam-0.14.0.sha256sum] = "333928d5eb103c5d4050533cec0384302db6be8ef7d3cebd30ec6a35350353da"
-SRC_URI[glam-0.15.2.sha256sum] = "3abb554f8ee44336b72d522e0a7fe86a29e09f839a36022fa869a7dfe941a54b"
-SRC_URI[glam-0.16.0.sha256sum] = "4126c0479ccf7e8664c36a2d719f5f2c140fbb4f9090008098d2c291fa5b3f16"
-SRC_URI[glam-0.17.3.sha256sum] = "e01732b97afd8508eee3333a541b9f7610f454bb818669e66e90f5f57c93a776"
-SRC_URI[glam-0.18.0.sha256sum] = "525a3e490ba77b8e326fb67d4b44b4bd2f920f44d4cc73ccec50adc68e3bee34"
-SRC_URI[glam-0.19.0.sha256sum] = "2b8509e6791516e81c1a630d0bd7fbac36d2fa8712a9da8662e716b52d5051ca"
-SRC_URI[glam-0.20.5.sha256sum] = "f43e957e744be03f5801a55472f593d43fabdebf25a4585db250f04d86b1675f"
-SRC_URI[glam-0.21.3.sha256sum] = "518faa5064866338b013ff9b2350dc318e14cc4fcd6cb8206d7e7c9886c98815"
-SRC_URI[glam-0.22.0.sha256sum] = "12f597d56c1bd55a811a1be189459e8fad2bbc272616375602443bdfb37fa774"
-SRC_URI[glam-0.23.0.sha256sum] = "8e4afd9ad95555081e109fe1d21f2a30c691b5f0919c67dfa690a2e1eb6bd51c"
-SRC_URI[glam-0.24.2.sha256sum] = "b5418c17512bdf42730f9032c74e1ae39afc408745ebb2acf72fbc4691c17945"
-SRC_URI[glam-0.25.0.sha256sum] = "151665d9be52f9bb40fc7966565d39666f2d1e69233571b71b87791c7e0528b3"
-SRC_URI[glam-0.27.0.sha256sum] = "9e05e7e6723e3455f4818c7b26e855439f7546cf617ef669d1adedb8669e5cb9"
-SRC_URI[glam-0.28.0.sha256sum] = "779ae4bf7e8421cf91c0b3b64e7e8b40b862fba4d393f59150042de7c4965a94"
-SRC_URI[glam-0.29.3.sha256sum] = "8babf46d4c1c9d92deac9f7be466f76dfc4482b6452fc5024b5e8daf6ffeb3ee"
 SRC_URI[glam-0.30.10.sha256sum] = "19fc433e8437a212d1b6f1e68c7824af3aed907da60afa994e7f542d18d12aa9"
-SRC_URI[glib-0.22.0.sha256sum] = "9a3b79a62980e85d61aae88988e5bcca6a35f05b0008e1333aa43bd61ef9bf35"
-SRC_URI[glib-macros-0.22.0.sha256sum] = "8b48a968528354e04603ae96205f00cf7e77347ffde0fc943a2159948d7d6d80"
-SRC_URI[glib-sys-0.22.0.sha256sum] = "48073e3b228419faa80b9b7f7122759d4ab2f44cd52a065fde7ca08f34c03147"
-SRC_URI[gobject-sys-0.22.0.sha256sum] = "18eda93f09d3778f38255b231b17ef67195013a592c91624a4daf8bead875565"
+SRC_URI[glam-0.31.1.sha256sum] = "556f6b2ea90b8d15a74e0e7bb41671c9bdf38cd9f78c284d750b9ce58a2b5be7"
+SRC_URI[glam-0.32.1.sha256sum] = "f70749695b063ecbf6b62949ccccde2e733ec3ecbbd71d467dca4e5c6c97cca0"
+SRC_URI[glam-0.33.3.sha256sum] = "7360bd2cd76e0cd9032d42cf2922155cecea2685b0cfa4630c3246df030bcfd6"
+SRC_URI[glib-0.22.8.sha256sum] = "ddbcf514bd1881fc1b960e4e52b4e82873f4da3bceddbd58d42827b508888100"
+SRC_URI[glib-macros-0.22.6.sha256sum] = "506d23499707c7142898429757e8d9a3871d965239a2cb66dfa05052be6d6f19"
+SRC_URI[glib-sys-0.22.8.sha256sum] = "030967459f9f676851872c6304adea7825c6d462ec9b72554c733cf0c5952233"
+SRC_URI[gobject-sys-0.22.6.sha256sum] = "22a861859b887a79cf461359c192c97a57d8fb0229dd291232e57aa11f6fa72c"
 SRC_URI[half-2.7.1.sha256sum] = "6ea2d84b969582b4b1864a92dc5d27cd2b77b622a8d79306834f1be5ba20d84b"
 SRC_URI[hashbrown-0.13.2.sha256sum] = "43a3c133739dddd0d2990f9a4bdf8eb4b21ef50e4851ca85ab661199821d510e"
-SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
+SRC_URI[hashbrown-0.17.1.sha256sum] = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+SRC_URI[hybrid-array-0.4.14.sha256sum] = "707114b52a152fa7bdb290cd7cd5912d9467273b6d74e21b8d81aca1f8533f6b"
 SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[icu_collections-2.1.1.sha256sum] = "4c6b649701667bbe825c3b7e6388cb521c23d88644678e83c0c4d0a621a34b43"
-SRC_URI[icu_locale_core-2.1.1.sha256sum] = "edba7861004dd3714265b4db54a3c390e880ab658fec5f7db895fae2046b5bb6"
-SRC_URI[icu_normalizer-2.1.1.sha256sum] = "5f6c8828b67bf8908d82127b2054ea1b4427ff0230ee9141c54251934ab1b599"
-SRC_URI[icu_normalizer_data-2.1.1.sha256sum] = "7aedcccd01fc5fe81e6b489c15b247b8b0690feb23304303a9e560f37efc560a"
-SRC_URI[icu_properties-2.1.2.sha256sum] = "020bfc02fe870ec3a66d93e677ccca0562506e5872c650f893269e08615d74ec"
-SRC_URI[icu_properties_data-2.1.2.sha256sum] = "616c294cf8d725c6afcd8f55abc17c56464ef6211f9ed59cccffe534129c77af"
-SRC_URI[icu_provider-2.1.1.sha256sum] = "85962cf0ce02e1e0a629cc34e7ca3e373ce20dda4c4d7294bbd0bf1fdb59e614"
+SRC_URI[icu_collections-2.2.0.sha256sum] = "2984d1cd16c883d7935b9e07e44071dca8d917fd52ecc02c04d5fa0b5a3f191c"
+SRC_URI[icu_locale_core-2.2.0.sha256sum] = "92219b62b3e2b4d88ac5119f8904c10f8f61bf7e95b640d25ba3075e6cac2c29"
+SRC_URI[icu_normalizer-2.2.0.sha256sum] = "c56e5ee99d6e3d33bd91c5d85458b6005a22140021cc324cea84dd0e72cff3b4"
+SRC_URI[icu_normalizer_data-2.2.0.sha256sum] = "da3be0ae77ea334f4da67c12f149704f19f81d1adf7c51cf482943e84a2bad38"
+SRC_URI[icu_properties-2.2.0.sha256sum] = "bee3b67d0ea5c2cca5003417989af8996f8604e34fb9ddf96208a033901e70de"
+SRC_URI[icu_properties_data-2.2.0.sha256sum] = "8e2bbb201e0c04f7b4b3e14382af113e17ba4f63e2c9d2ee626b720cbce54a14"
+SRC_URI[icu_provider-2.2.0.sha256sum] = "139c4cf31c8b5f33d7e199446eff9c1e02decfc2f0eec2c8d71f65befa45b421"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
-SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
+SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
 SRC_URI[image-0.25.10.sha256sum] = "85ab80394333c02fe689eaf900ab500fbd0c2213da414687ebf995a65d5a6104"
 SRC_URI[image-webp-0.2.4.sha256sum] = "525e9ff3e1a4be2fbea1fdf0e98686a6d98b4d8f937e1bf7402245af1909e8c3"
-SRC_URI[indexmap-2.13.0.sha256sum] = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
-SRC_URI[inout-0.1.4.sha256sum] = "879f10e63c20629ecabbb64a8010319738c66a5cd0c29b02d63d272b03751d01"
+SRC_URI[indexmap-2.14.0.sha256sum] = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
+SRC_URI[inout-0.2.2.sha256sum] = "4250ce6452e92010fdf7268ccc5d14faa80bb12fc741938534c58f16804e03c7"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
-SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
-SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
-SRC_URI[jiff-0.2.18.sha256sum] = "e67e8da4c49d6d9909fe03361f9b620f58898859f5c7aded68351e85e71ecf50"
-SRC_URI[jiff-static-0.2.18.sha256sum] = "e0c84ee7f197eca9a86c6fd6cb771e55eb991632f15f2bc3ca6ec838929e6e78"
-SRC_URI[jiff-tzdb-0.1.5.sha256sum] = "68971ebff725b9e2ca27a601c5eb38a4c5d64422c4cbab0c535f248087eda5c2"
+SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
+SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
+SRC_URI[jiff-0.2.35.sha256sum] = "668b7183bd07af9a4885f5c35b0cc5c83c4607a913c16b7e17291832910d2dcc"
+SRC_URI[jiff-core-0.1.0.sha256sum] = "7feca88439efe53da3754500c1851dedf3cb36c524dd5cf8225cc0794de95d09"
+SRC_URI[jiff-static-0.2.35.sha256sum] = "3a69dcb3a21cfb32ce1cd056169337ca284af0766dd766e7878819b251a49204"
+SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
-SRC_URI[js-sys-0.3.85.sha256sum] = "8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
+SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
+SRC_URI[js-sys-0.3.104.sha256sum] = "0e0c1080212aad755ea003d18543e8768dd432c48819efd73a7bf1e39b7a5a3a"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.180.sha256sum] = "bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
+SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+SRC_URI[libfuzzer-sys-0.4.13.sha256sum] = "a9fd2f41a1cba099f79a0b6b6c35656cf7c03351a7bae8ff0f28f25270f929d2"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
-SRC_URI[linux-raw-sys-0.11.0.sha256sum] = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
-SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
+SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
+SRC_URI[litemap-0.8.2.sha256sum] = "92daf443525c4cce67b150400bc2316076100ce0b3686209eb8cf3c31612e6f0"
 SRC_URI[locale_config-0.3.0.sha256sum] = "08d2c35b16f4483f6c26f0e4e9550717a2f6575bcd6f12a53ff0c490a94a6934"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
-SRC_URI[log-0.4.29.sha256sum] = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
-SRC_URI[lopdf-0.38.0.sha256sum] = "c7184fdea2bc3cd272a1acec4030c321a8f9875e877b3f92a53f2f6033fdc289"
-SRC_URI[mac-0.1.1.sha256sum] = "c41e0c4fef86961ac6d6f8a82609f55f31b05e4fce149ac5710e439df7619ba4"
+SRC_URI[log-0.4.33.sha256sum] = "0ceec5bc11778974d1bcb055b18002eba7f4b3518b6a0081b3af5f21666da9ad"
+SRC_URI[lopdf-0.44.0.sha256sum] = "5e2ec995d822e05cabc3f06d196ee43650af3fe4fe38012cacb35e0c3d113b68"
 SRC_URI[malloc_buf-0.0.6.sha256sum] = "62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
-SRC_URI[markup5ever-0.35.0.sha256sum] = "311fe69c934650f8f19652b3946075f0fc41ad8757dbb68f1ca14e7900ecc1c3"
+SRC_URI[markup5ever-0.39.0.sha256sum] = "7122d987ec5f704ee56f6e5b41a7d93722e9aae27ae07cafa4036c4d3f9757de"
 SRC_URI[matches-0.1.10.sha256sum] = "2532096657941c2fea9c289d370a250971c689d4f143798ff67113ec042024a5"
-SRC_URI[matrixmultiply-0.3.10.sha256sum] = "a06de3016e9fae57a36fd14dba131fccf49f74b40b7fbdb472f96e361ec71a08"
-SRC_URI[md-5-0.10.6.sha256sum] = "d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
-SRC_URI[memchr-2.8.0.sha256sum] = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
+SRC_URI[matrixmultiply-0.3.11.sha256sum] = "3f607c237553f086e7043417a51df26b2eb899d3caff94e6a67592ff992fedc7"
+SRC_URI[md-5-0.11.0.sha256sum] = "69b6441f590336821bb897fb28fc622898ccceb1d6cea3fde5ea86b090c4de98"
+SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
 SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
 SRC_URI[moxcms-0.8.1.sha256sum] = "bb85c154ba489f01b25c0d36ae69a87e4a1c73a72631fc6c0eb6dde34a73e44b"
 SRC_URI[mp4parse-0.17.0.sha256sum] = "63a35203d3c6ce92d5251c77520acb2e57108c88728695aa883f70023624c570"
-SRC_URI[mutants-0.0.3.sha256sum] = "bc0287524726960e07b119cebd01678f852f147742ae0d925e6a520dca956126"
-SRC_URI[nalgebra-0.34.1.sha256sum] = "c4d5b3eff5cd580f93da45e64715e8c20a3996342f1e466599cf7a267a0c2f5f"
+SRC_URI[mutants-0.0.4.sha256sum] = "add0ac067452ff1aca8c5002111bd6b1c895baee6e45fcbc44e0193aea17be56"
+SRC_URI[nalgebra-0.35.0.sha256sum] = "adc43a60c217b0c6ff46e47f26911015ad8d2e5a8be1af668c67e370d99a4346"
 SRC_URI[nalgebra-macros-0.3.0.sha256sum] = "973e7178a678cfd059ccec50887658d482ce16b0aa9da3888ddeab5cd5eb4889"
 SRC_URI[new_debug_unreachable-1.0.6.sha256sum] = "650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
 SRC_URI[nom-8.0.0.sha256sum] = "df9761775871bdef83bee530e60050f7e54b1105350d6884eb0fb4f46c2f9405"
-SRC_URI[nom_locate-5.0.0.sha256sum] = "0b577e2d69827c4740cba2b52efaad1c4cc7c73042860b199710b3575c68438d"
 SRC_URI[normalize-line-endings-0.3.0.sha256sum] = "61807f77802ff30975e01f4f071c8ba10c022052f98b3294119f3e615d13e5be"
-SRC_URI[num-bigint-0.4.6.sha256sum] = "a5e44f723f1133c9deac646763579fdb3ac745e418f2a7af9cd0c431da1f20b9"
+SRC_URI[num-bigint-0.4.8.sha256sum] = "c89e69e7e0f03bea5ef08013795c25018e101932225a656383bd384495ecc367"
 SRC_URI[num-complex-0.4.6.sha256sum] = "73f88a1307638156682bada9d7604135552957b7818057dcef22705b4d509495"
-SRC_URI[num-conv-0.2.0.sha256sum] = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
+SRC_URI[num-conv-0.2.2.sha256sum] = "521739c6d2bac4aa25192232afe6841231376b2b26d4d9fae5ecf8ca5772e441"
 SRC_URI[num-derive-0.4.2.sha256sum] = "ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
 SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
 SRC_URI[num-rational-0.4.2.sha256sum] = "f83d14da390562dca69fc84082e73e548e1ad308d24accdedd2720017cb37824"
@@ -549,136 +543,138 @@ SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0
 SRC_URI[objc-0.2.7.sha256sum] = "915b1b472bc21c53464d6c8461c9d3af805ba1ef837e1cac254428f4a77177b1"
 SRC_URI[objc-foundation-0.1.1.sha256sum] = "1add1b659e36c9607c7aab864a76c7a4c2760cd0cd2e120f3fb8b952c7e22bf9"
 SRC_URI[objc_id-0.1.1.sha256sum] = "c92d4ddb4bd7b50d730c215ff871754d0da6b2178849f8a2a2ab69712d0c073b"
-SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
+SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[oorandom-11.1.5.sha256sum] = "d6790f58c7ff633d8771f42965289203411a5e5c68388703c06e14f24770b41e"
-SRC_URI[pango-0.22.0.sha256sum] = "25d8f224eddef627b896d2f7b05725b3faedbd140e0e8343446f0d34f34238ee"
+SRC_URI[page_size-0.6.0.sha256sum] = "30d5b2194ed13191c1999ae0704b7839fb18384fa22e49b57eeaa97d79ce40da"
+SRC_URI[pango-0.22.8.sha256sum] = "5d800d8d0de2ad5d0fb046f5344dbaba14a003cf3dd27cc21d85893d35ea316c"
 SRC_URI[pango-sys-0.22.0.sha256sum] = "bbd111a20ca90fedf03e09c59783c679c00900f1d8491cca5399f5e33609d5d6"
-SRC_URI[pangocairo-0.22.0.sha256sum] = "d9f15369c787b1cc59a5b86eff6afffd5a9716c5beb4969d20b307cebfe7e407"
+SRC_URI[pangocairo-0.22.8.sha256sum] = "738a2ef690f51487814ff7172e0417c8e4fa2d7567571e5eb299d38b47b543ab"
 SRC_URI[pangocairo-sys-0.22.0.sha256sum] = "d95cb73468373b9e568abb1afbaf5b42fe6ab9128fc41b5f2adbf69451c3c77f"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
 SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
-SRC_URI[paste-1.0.15.sha256sum] = "57c0d7b74b563b49d38dae00a0c37d4d6de9b432382b2892f0574ddcae73fd0a"
 SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
-SRC_URI[phf-0.11.3.sha256sum] = "1fd6780a80ae0c52cc120a26a1a42c1ae51b247a253e4e06113d23d2c2edd078"
-SRC_URI[phf_codegen-0.11.3.sha256sum] = "aef8048c789fa5e851558d709946d6d79a8ff88c0440c587967f8e94bfb1216a"
-SRC_URI[phf_generator-0.11.3.sha256sum] = "3c80231409c20246a13fddb31776fb942c38553c51e871f8cbd687a4cfb5843d"
-SRC_URI[phf_macros-0.11.3.sha256sum] = "f84ac04429c13a7ff43785d75ad27569f2951ce0ffd30a3321230db2fc727216"
-SRC_URI[phf_shared-0.11.3.sha256sum] = "67eabc2ef2a60eb7faa00097bd1ffdb5bd28e62bf39990626a582201b7a754e5"
+SRC_URI[phf-0.13.1.sha256sum] = "c1562dc717473dbaa4c1f85a36410e03c047b2e7df7f45ee938fbef64ae7fadf"
+SRC_URI[phf_codegen-0.13.1.sha256sum] = "49aa7f9d80421bca176ca8dbfebe668cc7a2684708594ec9f3c0db0805d5d6e1"
+SRC_URI[phf_generator-0.13.1.sha256sum] = "135ace3a761e564ec88c03a77317a7c6b80bb7f7135ef2544dbe054243b89737"
+SRC_URI[phf_macros-0.13.1.sha256sum] = "812f032b54b1e759ccd5f8b6677695d5268c588701effba24601f6932f8269ef"
 SRC_URI[phf_shared-0.13.1.sha256sum] = "e57fef6bc5981e38c2ce2d63bfa546861309f875b8a75f092d1d54ae2d64f266"
-SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
-SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+SRC_URI[phf_shared-0.14.0.sha256sum] = "c6fd9027e2d9319be6349febd1db4e8d02aa544921200c9b777720ac34a3aa89"
+SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
+SRC_URI[pkg-config-0.3.33.sha256sum] = "19f132c84eca552bf34cab8ec81f1c1dcc229b811638f9d283dceabe58c5569e"
 SRC_URI[plotters-0.3.7.sha256sum] = "5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
 SRC_URI[plotters-backend-0.3.7.sha256sum] = "df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
 SRC_URI[plotters-svg-0.3.7.sha256sum] = "51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
 SRC_URI[png-0.18.1.sha256sum] = "60769b8b31b2a9f263dae2776c37b1b28ae246943cf719eb6946a1db05128a61"
-SRC_URI[portable-atomic-1.13.0.sha256sum] = "f89776e4d69bb58bc6993e99ffa1d11f228b839984854c7daeb5d37f87cbe950"
-SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
-SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
+SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
+SRC_URI[portable-atomic-util-0.2.7.sha256sum] = "c2a106d1259c23fac8e543272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
+SRC_URI[potential_utf-0.1.5.sha256sum] = "0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[predicates-3.1.3.sha256sum] = "a5d19ee57562043d37e82899fade9a22ebab7be9cef5026b07fda9cdd4293573"
-SRC_URI[predicates-core-1.0.9.sha256sum] = "727e462b119fe9c93fd0eb1429a5f7647394014cf3c04ab2c0350eeb09095ffa"
-SRC_URI[predicates-tree-1.0.12.sha256sum] = "72dd2d6d381dfb73a193c7fca536518d7caee39fc8503f74e7dc0be0531b425c"
+SRC_URI[predicates-3.1.4.sha256sum] = "ada8f2932f28a27ee7b70dd6c1c39ea0675c55a36879ab92f3a715eaa1e63cfe"
+SRC_URI[predicates-core-1.0.10.sha256sum] = "cad38746f3166b4031b1a0d39ad9f954dd291e7854fcc0eed52ee41a0b50d144"
+SRC_URI[predicates-tree-1.0.13.sha256sum] = "d0de1b847b39c8131db0467e9df1ff60e6d0562ab8e9a16e568ad0fdb372e2f2"
 SRC_URI[pretty_assertions-1.4.1.sha256sum] = "3ae130e2f271fbc2ac3a40fb1d07180839cdbbe443c7a27e1e3c13c5cac0116d"
-SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
-SRC_URI[proptest-1.9.0.sha256sum] = "bee689443a2bd0a16ab0348b52ee43e3b2d1b1f931c8aa5c9f8de4c86fbe8c40"
-SRC_URI[pxfm-0.1.27.sha256sum] = "7186d3822593aa4393561d186d1393b3923e9d6163d3fbfd6e825e3e6cf3e6a8"
+SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
+SRC_URI[proptest-1.11.0.sha256sum] = "4b45fcc2344c680f5025fe57779faef368840d0bd1f42f216291f0dc4ace4744"
+SRC_URI[pxfm-0.1.30.sha256sum] = "d55d956fa96f5ec02be2e13af0e20391a5aa83d6a074e3ad368959d0fab299ea"
 SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[quote-1.0.44.sha256sum] = "21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
+SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
-SRC_URI[rand-0.8.6.sha256sum] = "5ca0ecfa931c29007047d1bc58e623ab12e5590e8c7cc53200d5202b69266d8a"
-SRC_URI[rand-0.9.4.sha256sum] = "44c5af06bb1b7d3216d91932aed5265164bf384dc89cd6ba05cf59a35f5f76ea"
+SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
+SRC_URI[rand-0.9.5.sha256sum] = "b9ef1d0d795eb7d84685bca4f72f3649f064e6641543d3a8c415898726a57b41"
+SRC_URI[rand-0.10.2.sha256sum] = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
-SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
+SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
 SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
 SRC_URI[rangemap-1.7.1.sha256sum] = "973443cf09a9c8656b574a866ab68dfa19f0867d0340648c7d2f6a71b8a8ea68"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
-SRC_URI[rayon-1.11.0.sha256sum] = "368f01d005bf8fd9b1206fb6fa653e6c4a81ceb1466406b81792d87c5677a58f"
+SRC_URI[rayon-1.12.0.sha256sum] = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
 SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
 SRC_URI[rctree-0.6.0.sha256sum] = "e03e7866abec1101869ffa8e2c8355c4c2419d0214ece0cc3e428e5b94dea6e9"
 SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
-SRC_URI[regex-1.12.2.sha256sum] = "843bc0191f75f3e22651ae5f1e72939ab2f72a4bc30fa80a066bd66edefc24d4"
-SRC_URI[regex-automata-0.4.13.sha256sum] = "5276caf25ac86c8d810222b3dbb938e512c55c6831a10f3e6ed1c93b84041f1c"
-SRC_URI[regex-syntax-0.8.8.sha256sum] = "7a2d987857b319362043e95f5353c0535c1f58eec5336fdfcf626430af7def58"
-SRC_URI[rgb-0.8.52.sha256sum] = "0c6a884d2998352bb4daf0183589aec883f16a6da1f4dde84d8e2e9a5409a1ce"
+SRC_URI[regex-1.13.1.sha256sum] = "f020237b6c8eed93db2e2cb53c00c60a8e1bc73da7d073199a1180401450218d"
+SRC_URI[regex-automata-0.4.18.sha256sum] = "ad8553b9b26413251cbf30e620595c7a41b3887f03da04579c0e6b0d6a06b4b2"
+SRC_URI[regex-syntax-0.8.11.sha256sum] = "d6f6ff9a378485b298a5286656da665ba74413d36db0979633275d2e708145d4"
+SRC_URI[rgb-0.8.53.sha256sum] = "47b34b781b31e5d73e9fbc8689c70551fd1ade9a19e3e28cfec8580a79290cc4"
+SRC_URI[rustc-hash-2.1.3.sha256sum] = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
 SRC_URI[rustc_version-0.4.1.sha256sum] = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
-SRC_URI[rustix-1.1.3.sha256sum] = "146c9e247ccc180c1f61615433868c99f3de3ae256a30a43b49f67c2d9171f34"
-SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
+SRC_URI[rustix-1.1.4.sha256sum] = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+SRC_URI[rustversion-1.0.23.sha256sum] = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
 SRC_URI[rusty-fork-0.3.1.sha256sum] = "cc6bf79ff24e648f6da1f8d1f011e9cac26491b619e6b9280f2b47f1774e6ee2"
-SRC_URI[safe_arch-0.7.4.sha256sum] = "96b02de82ddbe1b636e6170c21be622223aea188ef2e139be0a5b219ec215323"
+SRC_URI[safe_arch-1.1.0.sha256sum] = "3a52ec151f024d703f9fd65abb7cbe81e7cdb39f18917a3a37e3014470dc7c59"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
-SRC_URI[selectors-0.31.0.sha256sum] = "5685b6ae43bfcf7d2e7dfcfb5d8e8f61b46442c902531e41a32a9a8bf0ee0fb6"
-SRC_URI[semver-1.0.27.sha256sum] = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
-SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
-SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
-SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
-SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
-SRC_URI[serde_spanned-1.0.4.sha256sum] = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
+SRC_URI[selectors-0.40.0.sha256sum] = "eeee001a77567bb05e71652718d3ff76d8697c151ac523e68e9513194eb2b75a"
+SRC_URI[semver-1.0.28.sha256sum] = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
+SRC_URI[serde-1.0.229.sha256sum] = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
+SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
+SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
+SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
+SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
 SRC_URI[servo_arc-0.4.3.sha256sum] = "170fb83ab34de17dc69aa7c67482b22218ddb85da56546f9bd6b929e32a05930"
-SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
+SRC_URI[sha2-0.11.0.sha256sum] = "446ba717509524cb3f22f17ecc096f10f4822d76ab5c0b9822c5f9c284e825f4"
 SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
-SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
-SRC_URI[simba-0.9.1.sha256sum] = "c99284beb21666094ba2b75bbceda012e610f5479dfcc2d6e2426f53197ffd95"
-SRC_URI[simd-adler32-0.3.8.sha256sum] = "e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
-SRC_URI[siphasher-1.0.2.sha256sum] = "b2aa850e253778c88a04c3d7323b043aeda9d3e30d5971937c1855769763678e"
-SRC_URI[slab-0.4.11.sha256sum] = "7a2ae44ef20feb57a68b23d846850f861394c2e02dc425a50098ae8c90267589"
-SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
+SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
+SRC_URI[simba-0.10.2.sha256sum] = "f1a7200d82ff1c7b4235efd12f11e2537a402c91cf83a5cb97ce80eef787fde7"
+SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
+SRC_URI[siphasher-1.0.3.sha256sum] = "8ee5873ec9cce0195efcb7a4e9507a04cd49aec9c83d0389df45b1ef7ba2e649"
+SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
+SRC_URI[smallvec-1.15.2.sha256sum] = "8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
-SRC_URI[string_cache-0.8.9.sha256sum] = "bf776ba3fa74f83bf4b63c3dcbbf82173db2632ed8452cb2d891d33f459de70f"
 SRC_URI[string_cache-0.9.0.sha256sum] = "a18596f8c785a729f2819c0f6a7eae6ebeebdfffbfe4214ae6b087f690e31901"
-SRC_URI[string_cache_codegen-0.5.4.sha256sum] = "c711928715f1fe0fe509c53b43e993a9a557babc2d0a3567d0a3006f1ac931a0"
+SRC_URI[string_cache-0.10.0.sha256sum] = "daf8762eb74d0e3b53126a15f88db5de3c8ee98cd3b5e3b58c1a9e21c6438873"
+SRC_URI[string_cache_codegen-0.6.1.sha256sum] = "585635e46db231059f76c5849798146164652513eb9e8ab2685939dd90f29b69"
 SRC_URI[stringprep-0.1.5.sha256sum] = "7b4df3d392d81bd458a8a621b8bffbd2302a12ffe288a9d931670948749463b1"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
-SRC_URI[syn-2.0.114.sha256sum] = "d4d107df263a3013ef9b1879b0df87d706ff80f65a86ea879bd9c31f9b307c2a"
+SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
+SRC_URI[syn-3.0.3.sha256sum] = "53e9bae58849f64dfa4f5d5ae372c8341f7305f82a3868709269343628b659a3"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
-SRC_URI[system-deps-7.0.7.sha256sum] = "48c8f33736f986f16d69b6cb8b03f55ddcad5c41acc4ccc39dd88e84aa805e7f"
-SRC_URI[target-lexicon-0.13.3.sha256sum] = "df7f62577c25e07834649fc3b39fafdc597c0a3527dc1c60129201ccfcbaa50c"
-SRC_URI[tempfile-3.24.0.sha256sum] = "655da9c7eb6305c55742045d5a8d2037996d61d8de95806335c7c86ce0f82e9c"
-SRC_URI[tendril-0.4.3.sha256sum] = "d24a120c5fc464a3458240ee02c299ebcb9d67b5249c8848b09d639dca8d7bb0"
+SRC_URI[system-deps-7.0.8.sha256sum] = "396a35feb67335377e0251fcbc1092fc85c484bd4e3a7a54319399da127796e7"
+SRC_URI[target-lexicon-0.13.5.sha256sum] = "adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
+SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
+SRC_URI[tendril-0.5.1.sha256sum] = "5fed54709c5b3a53d09bb1c113ea4f5ceafd1e772ddcb0030a82e1d56c087b08"
 SRC_URI[termtree-0.5.1.sha256sum] = "8f50febec83f5ee1df3015341d8bd429f2d1cc62bcba7ea2076759d315084683"
-SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
-SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
-SRC_URI[time-0.3.47.sha256sum] = "743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
-SRC_URI[time-core-0.1.8.sha256sum] = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
-SRC_URI[time-macros-0.2.27.sha256sum] = "2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
-SRC_URI[tinystr-0.8.2.sha256sum] = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
+SRC_URI[thiserror-2.0.20.sha256sum] = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
+SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
+SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
+SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
+SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
+SRC_URI[tinystr-0.8.3.sha256sum] = "c8323304221c2a851516f22236c5722a72eaa19749016521d6dff0824447d96d"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
-SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
+SRC_URI[tinyvec-1.12.0.sha256sum] = "bb4ebadaa0af04fab11ae01eb5f9fdb5f9c5b875506e210e71c07873528baa7f"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.9.11+spec-1.1.0.sha256sum] = "f3afc9a848309fe1aaffaed6e1546a7a14de1f935dc9d89d32afd9a44bab7c46"
-SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
-SRC_URI[toml_parser-1.0.6+spec-1.1.0.sha256sum] = "a3198b4b0a8e11f09dd03e133c0280504d0801269e9afa46362ffde1cbeebf44"
-SRC_URI[toml_writer-1.0.6+spec-1.1.0.sha256sum] = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
-SRC_URI[ttf-parser-0.25.1.sha256sum] = "d2df906b07856748fa3f6e0ad0cbaa047052d4a7dd609e231c4f72cee8c36f31"
-SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
+SRC_URI[toml-1.1.4+spec-1.1.0.sha256sum] = "3aace63f4bbcdfc2c965b059de67119c89c4017a70d633be6c104910f67056f5"
+SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
+SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
+SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
 SRC_URI[unicode-bidi-0.3.18.sha256sum] = "5c1cb5db39152898a79168971543b1cb5020dff7fe43c8dc468b0885f5e29df5"
-SRC_URI[unicode-ident-1.0.22.sha256sum] = "9312f7c4f6ff9069b165498234ce8be658059c6728633667c526e27dc2cf1df5"
+SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-properties-0.1.4.sha256sum] = "7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
 SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
-SRC_URI[utf-8-0.7.6.sha256sum] = "09cc8ee72d2a9becf2f2febe0205bbed8fc6615b7cb429ad062dc7b7ddd036a9"
 SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
 SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
 SRC_URI[version-compare-0.2.1.sha256sum] = "03c2856837ef78f57382f06b2b8563a2f512f7185d732608fd9176cb3b8edf0e"
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[wait-timeout-0.2.1.sha256sum] = "09ac3b126d3914f9849036f826e054cbabdc8519970b8998ddaf3b5bd3c65f11"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
-SRC_URI[wasip2-1.0.2+wasi-0.2.9.sha256sum] = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
-SRC_URI[wasm-bindgen-0.2.108.sha256sum] = "64024a30ec1e37399cf85a7ffefebdb72205ca1c972291c51512360d90bd8566"
-SRC_URI[wasm-bindgen-macro-0.2.108.sha256sum] = "008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
-SRC_URI[wasm-bindgen-macro-support-0.2.108.sha256sum] = "5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
-SRC_URI[wasm-bindgen-shared-0.2.108.sha256sum] = "1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
-SRC_URI[web-sys-0.3.85.sha256sum] = "312e32e551d92129218ea9a2452120f4aabc03529ef03e4d0d82fb2780608598"
-SRC_URI[web_atoms-0.1.3.sha256sum] = "57ffde1dc01240bdf9992e3205668b235e59421fd085e8a317ed98da0178d414"
+SRC_URI[wasip2-1.0.4+wasi-0.2.12.sha256sum] = "b67efb37e106e55ce722a510d6b5f9c17f083e5fc79afc2badeb12cc313d9487"
+SRC_URI[wasm-bindgen-0.2.127.sha256sum] = "1b70935747edd64d89de3efa29d73789b806c15798f8e7dca4d8ac356b50ce70"
+SRC_URI[wasm-bindgen-macro-0.2.127.sha256sum] = "77775f8f3f7217702089053b94958f8f54061a3f663417df76e19cbdcca29bc1"
+SRC_URI[wasm-bindgen-macro-support-0.2.127.sha256sum] = "e11d33f857dc2fb11b8bc75aee111aa9cbeb12cd9f25efd3d4c2a3dd4e235284"
+SRC_URI[wasm-bindgen-shared-0.2.127.sha256sum] = "7ef64dbcc55df09c7e5a46182d181c2cfa3e925f3da937ea764728b4bbb9dcbf"
+SRC_URI[web-sys-0.3.104.sha256sum] = "c435338968042f4f59a557f690a253676d47ce13ceb55d70100e7facf6620a30"
+SRC_URI[web_atoms-0.2.6.sha256sum] = "ba8b815c1b593dc0baf78dd0f4fc8fdb2de53198fb1163738093e9a311c33fb3"
 SRC_URI[weezl-0.1.12.sha256sum] = "a28ac98ddc8b9274cb41bb4d9d4d5c425b6020c50c46f25559911905610b4a88"
-SRC_URI[wide-0.7.33.sha256sum] = "0ce5da8ecb62bcd8ec8b7ea19f69a51275e91299be594ea5cc6ef7819e16cd03"
+SRC_URI[weezl-0.2.1.sha256sum] = "d4ca08e5ef825b65b056d9efbd95c8750683f0a6d0466d02e96dc2e4e360f3d2"
+SRC_URI[wide-1.6.1.sha256sum] = "de2aaf408e58689c2096682331b1f42bb2d9f2ed6b11560407d023cd0a6c634e"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
@@ -690,21 +686,21 @@ SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd4
 SRC_URI[windows-result-0.4.1.sha256sum] = "7781fa89eaf60850ac3d2da7af8e5242a5ea78d1a11c49bf2910bb5a73853eb5"
 SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
-SRC_URI[winnow-0.7.14.sha256sum] = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
-SRC_URI[wit-bindgen-0.51.0.sha256sum] = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
-SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
-SRC_URI[xml5ever-0.35.0.sha256sum] = "ee3f1e41afb31a75aef076563b0ad3ecc24f5bd9d12a72b132222664eb76b494"
+SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
+SRC_URI[wit-bindgen-0.57.1.sha256sum] = "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
+SRC_URI[writeable-0.6.3.sha256sum] = "1ffae5123b2d3fc086436f8834ae3ab053a283cfac8fe0a0b8eaae044768a4c4"
+SRC_URI[xml5ever-0.39.0.sha256sum] = "5ab627f34ff61b80d756180d556f9c68801d836d271b3b8c094504ceca69d221"
 SRC_URI[yansi-1.0.1.sha256sum] = "cfe53a6657fd280eaa890a3bc59152892ffa3e30101319d168b781ed6529b049"
-SRC_URI[yeslogic-fontconfig-sys-6.0.0.sha256sum] = "503a066b4c037c440169d995b869046827dbc71263f6e8f3be6d77d4f3229dbd"
-SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
-SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
-SRC_URI[zerocopy-0.8.36.sha256sum] = "dafd85c832c1b68bbb4ec0c72c7f6f4fc5179627d2bc7c26b30e4c0cc11e76cc"
-SRC_URI[zerocopy-derive-0.8.36.sha256sum] = "7cb7e4e8436d9db52fbd6625dbf2f45243ab84994a72882ec8227b99e72b439a"
-SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
-SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
-SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
-SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
-SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
-SRC_URI[zmij-1.0.17.sha256sum] = "02aae0f83f69aafc94776e879363e9771d7ecbffe2c7fbb6c14c5e00dfe88439"
-SRC_URI[zune-core-0.5.1.sha256sum] = "cb8a0807f7c01457d0379ba880ba6322660448ddebc890ce29bb64da71fb40f9"
-SRC_URI[zune-jpeg-0.5.13.sha256sum] = "ec5f41c76397b7da451efd19915684f727d7e1d516384ca6bd0ec43ec94de23c"
+SRC_URI[yeslogic-fontconfig-sys-6.0.1.sha256sum] = "1d8b8abf912b9a29ff112e1671c97c33636903d13a69712037190e6805af4f76"
+SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
+SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
+SRC_URI[zerocopy-0.8.56.sha256sum] = "556764e583adb45a9f8d413c2a147fa7e8d821e48e12b14fd560b607998b75eb"
+SRC_URI[zerocopy-derive-0.8.56.sha256sum] = "f2ab42fc20575779bd240faa45f94a74256f755c0fa9e89f0ede20d91d0cdfc1"
+SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
+SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
+SRC_URI[zerotrie-0.2.4.sha256sum] = "0f9152d31db0792fa83f70fb2f83148effb5c1f5b8c7686c3459e361d9bc20bf"
+SRC_URI[zerovec-0.11.6.sha256sum] = "90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239"
+SRC_URI[zerovec-derive-0.11.3.sha256sum] = "625dc425cab0dca6dc3c3319506e6593dcb08a9f387ea3b284dbd52a92c40555"
+SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
+SRC_URI[zune-core-0.5.3.sha256sum] = "d56377fd46368984a170bc5aac5567e52ca5da874caa60bea39fcbca78fb658b"
+SRC_URI[zune-jpeg-0.5.15.sha256sum] = "27bc9d5b815bc103f142aa054f561d9187d191692ec7c2d1e2b4737f8dbd7296"
diff --git a/recipes-gnome/librsvg/librsvg_2.62.3.bb b/recipes-gnome/librsvg/librsvg_2.63.0.bb
similarity index 98%
rename from recipes-gnome/librsvg/librsvg_2.62.3.bb
rename to recipes-gnome/librsvg/librsvg_2.63.0.bb
index b54371a..bc378c2 100644
--- a/recipes-gnome/librsvg/librsvg_2.62.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.63.0.bb
@@ -26,7 +26,7 @@ require ${BPN}-crates.inc
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
             file://run-ptest"
-SRC_URI[archive.sha256sum] = "7eb449b2722a768021356f66dfee3202c229b54ed4e6a70ce40c090e97ff16f2"
+SRC_URI[archive.sha256sum] = "cab7f7d1326fb001e4eb9f37990de66d4578a5f48465507471a69322d8b326e3"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.56.0

