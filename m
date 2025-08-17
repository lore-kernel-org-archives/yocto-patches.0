Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA85CA0EF5
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:32:12 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.57182.1755451931457233391
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:32:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TUyuJFc2;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70a9282141fso39964266d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451930; x=1756056730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykFiV7p9nVZh79CFRWvD2Tubpu5GTzdMhjfV13HzPLY=;
        b=TUyuJFc2AX3FmpPu2GFcptoEgNiuTV441QMLUHcvaCwHU7gZucoq5d43DxmZmLl77N
         rY5DX5PpdK8w44bIwkmQAAZB+srHDHzTqxo3RHqIZ1R45KBgcaZBxqlYnZhUZmWAwLxz
         syfLAtDM8AU5FvHWSpvR3Zm5a8Zk2t3hNFZ9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451930; x=1756056730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykFiV7p9nVZh79CFRWvD2Tubpu5GTzdMhjfV13HzPLY=;
        b=bo9yXZOJDUUWXPCu2PelC+X47a57Sg2v70/D/n+6JauPLCJN4DBDJsjA4KYC49m9u+
         pdQ55Bwz0AAODJAsR44tYL1Z7NRp5rHhgOzngGxVuFqs8VbJGV+hr8f+jRkuVGaEGlgE
         IPWTUoTaIUYfNPQ+gdgMA7zc8mrwZW1J6iczHfrBE46gC+N5TsMoA76cKUW4Rm0uXBEb
         aQia8aB1e46naSaYY3/by18jqlRofC51fyV0MAitqRHKDKHo/hGgIEQ/ZsQSgJcmXCcN
         xNhERiPbs3OIznTNybh8oI/sS49IIAfz7ETTrxKy/Jf2pzBnupPVyAKwgdBnY0pKPte4
         RnNw==
X-Gm-Message-State: AOJu0Yw2w/ug7RFLN0GuZrrec5ktRDzDx8WmSQLAqwS4AL3ZY/MzfjBs
	1s1rknM6C6MLNHzPHgxaBHc1OQyuWw2Qz+uwYDvI/QPvxeGWmlvVI3E34Gop/Rgbc/ULt7yAV6K
	uocx5
X-Gm-Gg: ASbGnctMwxW70xprQ6Sh2CxNGQEeuJVGy+g/xfpmo1QaqfBRMq+bsZVventYUNua72m
	2qusmb8x6rZg58hX8YcJQkjSkYn1HYM5+LacCHEUTauZljKQ4u3dd6E7ScoCL4F6bRmEgCO0vye
	AxnPFfoU/m2EwHTEk/5od5oVu2zB7m1unNughh1r0Rx8RhsmHCJn3Wxqtnh4/fhqCZ3G7B0R80J
	0LuFch/Em/f+ie5fCgcfsexXaQuVHKc8gC9PM7DQHVJZO9Ne6tSaIfxzpXTUX4YquMvbZI+SS7z
	MLJQduteScONmaUH3EBB6p5M9txfIT5/+Pw2o42fqEgk9W/OQ9OlQEFy4iLdt+wZeeRO/JbUgXZ
	jj1CdJbR/YHEMmHGyJeOLOd4VYkuO60xEU8lafHUgtNzp8rHEShFumERDwS8t7HUNZQcs1hjDkA
	==
X-Google-Smtp-Source: AGHT+IGUtbImHYTHwGB+BfGXWmMJVOaGQjyWnpi8XUibb9kom1CUP78nj9wOWN7+d3ZVxTKP4jxtNg==
X-Received: by 2002:ad4:4ee1:0:b0:707:6977:aa77 with SMTP id 6a1803df08f44-70bb062691dmr72169366d6.33.1755451929275;
        Sun, 17 Aug 2025 10:32:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm450093185a.36.2025.08.17.10.32.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:32:08 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 6/8] librsvg: upgrade 2.59.2 -> 2.60.0
Date: Sun, 17 Aug 2025 13:31:55 -0400
Message-ID: <303bcb2f9fd8b281985e46b7d137d084be7f52e2.1755451833.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451833.git.scott.murray@konsulko.com>
References: <cover.1755451833.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:32:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2019

From: Gyorgy Sarvari <skandigraun@gmail.com>

0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-pi.patch and
0001-meson.build-do-not-force-disable-introspection-and-v.patch
patches were dropped, because they are included in this release.

=3D=3D=3D=3D=3D=3D

Removed the CVE exception for CVE-2018-1000041, because it has been
fixed in 2017[1].

=3D=3D=3D=3D=3D

During the do_configure step, the following error popped up:

| Program meson/query-rustc.py found: YES (/home/meeee/stuff/ptest-images/b=
uild/tmp/work/core2-64-poky-linux/librsvg/2.60.0/sources/librsvg-2.60.0/mes=
on/query-rustc.py)
|
| ../sources/librsvg-2.60.0/meson.build:357:4: ERROR: Problem encountered: =
error[E0463]: can't find crate for `std`
|   |
|   =3D note: the `x86_64-poky-linux-gnu` target may not be installed
|   =3D help: consider downloading the target with `rustup target add x86_6=
4-poky-linux-gnu`
|
| error: aborting due to 1 previous error
|
| For more information about this error, try `rustc --explain E0463`.

The meson script is trying to gather the static native libraries for the
target from rust, to link with them later. However it invokes rustc binary
directly without cargo, and the RUSTFLAGS environment variable is ignored,
which makes it to fail to find the Yocto targets.

To avoid this error, add a patch to append the RUSTFLAGS to the command
that calls rustc. (0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.pa=
tch)

=3D=3D=3D=3D=3D=3D

During the development of this version, using gdk-pixbuf-loader was enabled
for non-cross builds also. Unfortunately gdk-pixbuf-loader however has no
cross-wrapper script support officially, so it fails the build if it can't
find the executable (which is not present in the target build's sysroot).

To avoid to error, add a patch that reverts this change.
(0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch)

=3D=3D=3D=3D=3D

Changelog:

- The minimum supported Rust version (MSRV) is 1.77.2.
- Many build fixes for various platforms (Amyspark, Alexander Kanavin,
  Colin Sane).
- #414 - Basic support for the dominant-baseline property (Paul Melis).
- #1146 - Parse the white-space property.  It is not processed yet;
  this is part of the work to support SVG2 text layout (Adetoye Anointing).
- #1138 - Report errors correctly from the parsers for attribute values.
- Portability fixes to the C header files.

Version 2.59.91
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- #1147 - Fix linkage on Illumos.
- #1143 - Fix the build of the static library on MinGW (Amyspark).
- Fix versioning of library name (Amyspark).
- Enable cross-compilation of the gdk-pixbuf loader if meson/qemu can
  handle it (Colin Sane).

Version 2.59.90
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- #414 - Basic support for the dominant-baseline property (Paul Melis).
- #1138 - Report errors correctly from the parsers for attribute values.
- #951 - Slightly improved test coverage (Vaishnavi Nawghare).
- #1136 - Don't use defined() in C macro definitions, since it is not
  portable.
- #1146 - Parse the white-space property.  It is not processed yet;
  this will come after the Outreachy internship (Adetoye Anointing).
- Documentation fixes (Kleis Auke Wolthuizen).
- Many build fixes (Amyspark).
- Improvements for cross builds (Alexander Kanavin).
- Fix CRLF characters in Python sources (sulincix).

[1]: https://gitlab.gnome.org/GNOME/librsvg/-/commit/c6ddf2ed4d768fd88adbea=
2b63f575cd523022ea
(this fixed the CVE according to https://nvd.nist.gov/vuln/detail/CVE-2018-=
1000041 )

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit b0691bbbdf31b0e5c50ba319bdf6d16a278c8b5a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 472 ++++++++++--------
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 ++
 ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 --
 ...ot-force-disable-introspection-and-v.patch |  34 --
 ...append-RUSTFLAGS-to-rustc-executable.patch |  37 ++
 .../{librsvg_2.59.2.bb =3D> librsvg_2.60.0.bb}  |  11 +-
 6 files changed, 348 insertions(+), 283 deletions(-)
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-d=
o-not-force-disable-gdk-pixbuf-l.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-me=
son.build-do-not-look-for-gdk-pi.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-f=
orce-disable-introspection-and-v.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-query-rustc-append-R=
USTFLAGS-to-rustc-executable.patch
 rename recipes-gnome/librsvg/{librsvg_2.59.2.bb =3D> librsvg_2.60.0.bb} (9=
0%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librs=
vg/librsvg-crates.inc
index 54cd1c6..f8f5d5d 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -2,54 +2,55 @@
=20
 # from Cargo.lock
 SRC_URI +=3D " \
-    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/adler2/2.0.0 \
     crate://crates.io/ahash/0.8.11 \
     crate://crates.io/aho-corasick/1.1.3 \
     crate://crates.io/android-tzdata/0.1.1 \
     crate://crates.io/android_system_properties/0.1.5 \
     crate://crates.io/anes/0.1.6 \
-    crate://crates.io/anstream/0.6.15 \
-    crate://crates.io/anstyle/1.0.8 \
-    crate://crates.io/anstyle-parse/0.2.5 \
-    crate://crates.io/anstyle-query/1.1.1 \
-    crate://crates.io/anstyle-wincon/3.0.4 \
-    crate://crates.io/anyhow/1.0.86 \
+    crate://crates.io/anstream/0.6.18 \
+    crate://crates.io/anstyle/1.0.10 \
+    crate://crates.io/anstyle-parse/0.2.6 \
+    crate://crates.io/anstyle-query/1.1.2 \
+    crate://crates.io/anstyle-wincon/3.0.6 \
+    crate://crates.io/anyhow/1.0.94 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.0.15 \
-    crate://crates.io/autocfg/1.3.0 \
-    crate://crates.io/av-data/0.4.2 \
+    crate://crates.io/assert_cmd/2.0.16 \
+    crate://crates.io/autocfg/1.4.0 \
+    crate://crates.io/av-data/0.4.4 \
     crate://crates.io/bit-set/0.5.3 \
     crate://crates.io/bit-vec/0.6.3 \
     crate://crates.io/bitflags/1.3.2 \
     crate://crates.io/bitflags/2.6.0 \
-    crate://crates.io/bitreader/0.3.8 \
+    crate://crates.io/bitreader/0.3.11 \
     crate://crates.io/block/0.1.6 \
     crate://crates.io/block-buffer/0.10.4 \
-    crate://crates.io/bstr/1.10.0 \
+    crate://crates.io/bstr/1.11.0 \
     crate://crates.io/bumpalo/3.16.0 \
     crate://crates.io/byte-slice-cast/1.2.2 \
-    crate://crates.io/bytemuck/1.16.3 \
+    crate://crates.io/bytemuck/1.20.0 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/byteorder-lite/0.1.0 \
-    crate://crates.io/bytes/1.7.1 \
-    crate://crates.io/cairo-rs/0.20.0 \
+    crate://crates.io/bytes/1.9.0 \
+    crate://crates.io/cairo-rs/0.20.5 \
     crate://crates.io/cairo-sys-rs/0.20.0 \
     crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cc/1.1.8 \
+    crate://crates.io/cc/1.2.3 \
     crate://crates.io/cfg-expr/0.15.8 \
+    crate://crates.io/cfg-expr/0.17.2 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/chrono/0.4.38 \
+    crate://crates.io/chrono/0.4.39 \
     crate://crates.io/ciborium/0.2.2 \
     crate://crates.io/ciborium-io/0.2.2 \
     crate://crates.io/ciborium-ll/0.2.2 \
-    crate://crates.io/clap/4.5.13 \
-    crate://crates.io/clap_builder/4.5.13 \
-    crate://crates.io/clap_complete/4.5.12 \
-    crate://crates.io/clap_derive/4.5.13 \
-    crate://crates.io/clap_lex/0.7.2 \
+    crate://crates.io/clap/4.5.23 \
+    crate://crates.io/clap_builder/4.5.23 \
+    crate://crates.io/clap_complete/4.5.38 \
+    crate://crates.io/clap_derive/4.5.18 \
+    crate://crates.io/clap_lex/0.7.4 \
     crate://crates.io/color_quant/1.1.0 \
-    crate://crates.io/colorchoice/1.0.2 \
-    crate://crates.io/core-foundation-sys/0.8.6 \
+    crate://crates.io/colorchoice/1.0.3 \
+    crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/crc32fast/1.4.2 \
     crate://crates.io/criterion/0.5.1 \
     crate://crates.io/criterion-plot/0.5.0 \
@@ -63,70 +64,82 @@ SRC_URI +=3D " \
     crate://crates.io/data-url/0.3.1 \
     crate://crates.io/dav1d/0.10.3 \
     crate://crates.io/dav1d-sys/0.8.2 \
-    crate://crates.io/dcv-color-primitives/0.6.1 \
     crate://crates.io/deranged/0.3.11 \
     crate://crates.io/derive_more/0.99.18 \
     crate://crates.io/difflib/0.4.0 \
     crate://crates.io/digest/0.10.7 \
+    crate://crates.io/displaydoc/0.2.5 \
     crate://crates.io/dlib/0.5.2 \
     crate://crates.io/doc-comment/0.3.3 \
     crate://crates.io/dtoa/1.0.9 \
     crate://crates.io/dtoa-short/0.3.5 \
     crate://crates.io/either/1.13.0 \
-    crate://crates.io/encoding_rs/0.8.34 \
+    crate://crates.io/encoding_rs/0.8.35 \
     crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/errno/0.3.9 \
+    crate://crates.io/errno/0.3.10 \
     crate://crates.io/fallible_collections/0.4.9 \
-    crate://crates.io/fastrand/2.1.0 \
-    crate://crates.io/fdeflate/0.3.4 \
-    crate://crates.io/flate2/1.0.31 \
+    crate://crates.io/fastrand/2.3.0 \
+    crate://crates.io/fdeflate/0.3.7 \
+    crate://crates.io/flate2/1.0.35 \
     crate://crates.io/float-cmp/0.9.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.1 \
     crate://crates.io/futf/0.1.5 \
-    crate://crates.io/futures-channel/0.3.30 \
-    crate://crates.io/futures-core/0.3.30 \
-    crate://crates.io/futures-executor/0.3.30 \
-    crate://crates.io/futures-io/0.3.30 \
-    crate://crates.io/futures-macro/0.3.30 \
-    crate://crates.io/futures-task/0.3.30 \
-    crate://crates.io/futures-util/0.3.30 \
+    crate://crates.io/futures-channel/0.3.31 \
+    crate://crates.io/futures-core/0.3.31 \
+    crate://crates.io/futures-executor/0.3.31 \
+    crate://crates.io/futures-io/0.3.31 \
+    crate://crates.io/futures-macro/0.3.31 \
+    crate://crates.io/futures-task/0.3.31 \
+    crate://crates.io/futures-util/0.3.31 \
     crate://crates.io/fxhash/0.2.1 \
-    crate://crates.io/gdk-pixbuf/0.20.0 \
-    crate://crates.io/gdk-pixbuf-sys/0.20.0 \
+    crate://crates.io/gdk-pixbuf/0.20.4 \
+    crate://crates.io/gdk-pixbuf-sys/0.20.4 \
     crate://crates.io/generic-array/0.14.7 \
     crate://crates.io/getrandom/0.2.15 \
     crate://crates.io/gif/0.13.1 \
-    crate://crates.io/gio/0.20.0 \
-    crate://crates.io/gio-sys/0.20.0 \
-    crate://crates.io/glib/0.20.0 \
-    crate://crates.io/glib-macros/0.20.0 \
-    crate://crates.io/glib-sys/0.20.0 \
-    crate://crates.io/gobject-sys/0.20.0 \
+    crate://crates.io/gio/0.20.6 \
+    crate://crates.io/gio-sys/0.20.8 \
+    crate://crates.io/glib/0.20.6 \
+    crate://crates.io/glib-macros/0.20.5 \
+    crate://crates.io/glib-sys/0.20.6 \
+    crate://crates.io/gobject-sys/0.20.4 \
     crate://crates.io/half/2.4.1 \
     crate://crates.io/hashbrown/0.13.2 \
-    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/hashbrown/0.15.2 \
     crate://crates.io/heck/0.5.0 \
-    crate://crates.io/hermit-abi/0.3.9 \
-    crate://crates.io/iana-time-zone/0.1.60 \
+    crate://crates.io/hermit-abi/0.4.0 \
+    crate://crates.io/iana-time-zone/0.1.61 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/idna/0.5.0 \
-    crate://crates.io/image/0.25.2 \
-    crate://crates.io/image-webp/0.1.3 \
-    crate://crates.io/indexmap/2.3.0 \
-    crate://crates.io/is-terminal/0.4.12 \
+    crate://crates.io/icu_collections/1.5.0 \
+    crate://crates.io/icu_locid/1.5.0 \
+    crate://crates.io/icu_locid_transform/1.5.0 \
+    crate://crates.io/icu_locid_transform_data/1.5.0 \
+    crate://crates.io/icu_normalizer/1.5.0 \
+    crate://crates.io/icu_normalizer_data/1.5.0 \
+    crate://crates.io/icu_properties/1.5.1 \
+    crate://crates.io/icu_properties_data/1.5.0 \
+    crate://crates.io/icu_provider/1.5.0 \
+    crate://crates.io/icu_provider_macros/1.5.0 \
+    crate://crates.io/idna/1.0.3 \
+    crate://crates.io/idna_adapter/1.2.0 \
+    crate://crates.io/image/0.25.5 \
+    crate://crates.io/image-webp/0.2.0 \
+    crate://crates.io/indexmap/2.7.0 \
+    crate://crates.io/is-terminal/0.4.13 \
     crate://crates.io/is_terminal_polyfill/1.70.1 \
     crate://crates.io/itertools/0.10.5 \
     crate://crates.io/itertools/0.13.0 \
-    crate://crates.io/itoa/1.0.11 \
-    crate://crates.io/js-sys/0.3.69 \
+    crate://crates.io/itoa/1.0.14 \
+    crate://crates.io/js-sys/0.3.76 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.155 \
-    crate://crates.io/libloading/0.8.5 \
-    crate://crates.io/libm/0.2.8 \
+    crate://crates.io/libc/0.2.168 \
+    crate://crates.io/libloading/0.8.6 \
+    crate://crates.io/libm/0.2.11 \
     crate://crates.io/linked-hash-map/0.5.6 \
     crate://crates.io/linux-raw-sys/0.4.14 \
+    crate://crates.io/litemap/0.7.4 \
     crate://crates.io/locale_config/0.3.0 \
     crate://crates.io/lock_api/0.4.12 \
     crate://crates.io/log/0.4.22 \
@@ -139,9 +152,9 @@ SRC_URI +=3D " \
     crate://crates.io/md-5/0.10.6 \
     crate://crates.io/memchr/2.7.4 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.7.4 \
+    crate://crates.io/miniz_oxide/0.8.0 \
     crate://crates.io/mp4parse/0.17.0 \
-    crate://crates.io/nalgebra/0.33.0 \
+    crate://crates.io/nalgebra/0.33.2 \
     crate://crates.io/nalgebra-macros/0.2.2 \
     crate://crates.io/new_debug_unreachable/1.0.6 \
     crate://crates.io/nom/7.1.3 \
@@ -156,12 +169,12 @@ SRC_URI +=3D " \
     crate://crates.io/objc/0.2.7 \
     crate://crates.io/objc-foundation/0.1.1 \
     crate://crates.io/objc_id/0.1.1 \
-    crate://crates.io/once_cell/1.19.0 \
+    crate://crates.io/once_cell/1.20.2 \
     crate://crates.io/oorandom/11.1.4 \
-    crate://crates.io/pango/0.20.0 \
-    crate://crates.io/pango-sys/0.20.0 \
-    crate://crates.io/pangocairo/0.20.0 \
-    crate://crates.io/pangocairo-sys/0.20.0 \
+    crate://crates.io/pango/0.20.6 \
+    crate://crates.io/pango-sys/0.20.4 \
+    crate://crates.io/pangocairo/0.20.4 \
+    crate://crates.io/pangocairo-sys/0.20.4 \
     crate://crates.io/parking_lot/0.12.3 \
     crate://crates.io/parking_lot_core/0.9.10 \
     crate://crates.io/paste/1.0.15 \
@@ -175,25 +188,25 @@ SRC_URI +=3D " \
     crate://crates.io/phf_macros/0.11.2 \
     crate://crates.io/phf_shared/0.10.0 \
     crate://crates.io/phf_shared/0.11.2 \
-    crate://crates.io/pin-project-lite/0.2.14 \
+    crate://crates.io/pin-project-lite/0.2.15 \
     crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/pkg-config/0.3.30 \
-    crate://crates.io/plotters/0.3.6 \
-    crate://crates.io/plotters-backend/0.3.6 \
-    crate://crates.io/plotters-svg/0.3.6 \
-    crate://crates.io/png/0.17.13 \
+    crate://crates.io/pkg-config/0.3.31 \
+    crate://crates.io/plotters/0.3.7 \
+    crate://crates.io/plotters-backend/0.3.7 \
+    crate://crates.io/plotters-svg/0.3.7 \
+    crate://crates.io/png/0.17.15 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.20 \
     crate://crates.io/precomputed-hash/0.1.1 \
     crate://crates.io/predicates/3.1.2 \
     crate://crates.io/predicates-core/1.0.8 \
     crate://crates.io/predicates-tree/1.0.11 \
-    crate://crates.io/proc-macro-crate/3.1.0 \
-    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/proc-macro-crate/3.2.0 \
+    crate://crates.io/proc-macro2/1.0.92 \
     crate://crates.io/proptest/1.5.0 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/quote/1.0.37 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
@@ -202,24 +215,25 @@ SRC_URI +=3D " \
     crate://crates.io/rayon/1.10.0 \
     crate://crates.io/rayon-core/1.12.1 \
     crate://crates.io/rctree/0.6.0 \
-    crate://crates.io/redox_syscall/0.5.3 \
-    crate://crates.io/regex/1.10.6 \
-    crate://crates.io/regex-automata/0.4.7 \
-    crate://crates.io/regex-syntax/0.8.4 \
-    crate://crates.io/rgb/0.8.48 \
-    crate://crates.io/rustix/0.38.34 \
+    crate://crates.io/redox_syscall/0.5.7 \
+    crate://crates.io/regex/1.11.1 \
+    crate://crates.io/regex-automata/0.4.9 \
+    crate://crates.io/regex-syntax/0.8.5 \
+    crate://crates.io/rgb/0.8.50 \
+    crate://crates.io/rustix/0.38.42 \
     crate://crates.io/rusty-fork/0.3.0 \
     crate://crates.io/ryu/1.0.18 \
     crate://crates.io/safe_arch/0.7.2 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/selectors/0.25.0 \
-    crate://crates.io/serde/1.0.204 \
-    crate://crates.io/serde_derive/1.0.204 \
-    crate://crates.io/serde_json/1.0.122 \
-    crate://crates.io/serde_spanned/0.6.7 \
+    crate://crates.io/serde/1.0.215 \
+    crate://crates.io/serde_derive/1.0.215 \
+    crate://crates.io/serde_json/1.0.133 \
+    crate://crates.io/serde_spanned/0.6.8 \
     crate://crates.io/servo_arc/0.3.0 \
     crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/shlex/1.3.0 \
     crate://crates.io/simba/0.9.0 \
     crate://crates.io/simd-adler32/0.3.7 \
     crate://crates.io/siphasher/0.3.11 \
@@ -230,46 +244,47 @@ SRC_URI +=3D " \
     crate://crates.io/string_cache/0.8.7 \
     crate://crates.io/string_cache_codegen/0.5.2 \
     crate://crates.io/strsim/0.11.1 \
-    crate://crates.io/syn/2.0.72 \
+    crate://crates.io/syn/2.0.90 \
+    crate://crates.io/synstructure/0.13.1 \
     crate://crates.io/system-deps/6.2.2 \
-    crate://crates.io/system-deps/7.0.1 \
+    crate://crates.io/system-deps/7.0.3 \
     crate://crates.io/target-lexicon/0.12.16 \
-    crate://crates.io/tempfile/3.12.0 \
+    crate://crates.io/tempfile/3.14.0 \
     crate://crates.io/tendril/0.4.3 \
     crate://crates.io/termtree/0.4.1 \
-    crate://crates.io/thiserror/1.0.63 \
-    crate://crates.io/thiserror-impl/1.0.63 \
-    crate://crates.io/time/0.3.36 \
+    crate://crates.io/thiserror/1.0.69 \
+    crate://crates.io/thiserror-impl/1.0.69 \
+    crate://crates.io/time/0.3.37 \
     crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.18 \
+    crate://crates.io/time-macros/0.2.19 \
+    crate://crates.io/tinystr/0.7.6 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.8.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
     crate://crates.io/toml/0.8.19 \
     crate://crates.io/toml_datetime/0.6.8 \
-    crate://crates.io/toml_edit/0.21.1 \
-    crate://crates.io/toml_edit/0.22.20 \
+    crate://crates.io/toml_edit/0.22.22 \
     crate://crates.io/typenum/1.17.0 \
     crate://crates.io/unarray/0.1.4 \
-    crate://crates.io/unicode-bidi/0.3.15 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-normalization/0.1.23 \
-    crate://crates.io/url/2.5.2 \
+    crate://crates.io/unicode-ident/1.0.14 \
+    crate://crates.io/url/2.5.4 \
     crate://crates.io/utf-8/0.7.6 \
+    crate://crates.io/utf16_iter/1.0.5 \
+    crate://crates.io/utf8_iter/1.0.4 \
     crate://crates.io/utf8parse/0.2.2 \
     crate://crates.io/version-compare/0.2.0 \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/wait-timeout/0.2.0 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.92 \
-    crate://crates.io/wasm-bindgen-backend/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
-    crate://crates.io/wasm-bindgen-shared/0.2.92 \
-    crate://crates.io/web-sys/0.3.69 \
+    crate://crates.io/wasm-bindgen/0.2.99 \
+    crate://crates.io/wasm-bindgen-backend/0.2.99 \
+    crate://crates.io/wasm-bindgen-macro/0.2.99 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.99 \
+    crate://crates.io/wasm-bindgen-shared/0.2.99 \
+    crate://crates.io/web-sys/0.3.76 \
     crate://crates.io/weezl/0.1.8 \
-    crate://crates.io/wide/0.7.26 \
+    crate://crates.io/wide/0.7.30 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.9 \
@@ -286,64 +301,72 @@ SRC_URI +=3D " \
     crate://crates.io/windows_x86_64_gnu/0.52.6 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/winnow/0.5.40 \
-    crate://crates.io/winnow/0.6.18 \
+    crate://crates.io/winnow/0.6.20 \
+    crate://crates.io/write16/1.0.0 \
+    crate://crates.io/writeable/0.5.5 \
     crate://crates.io/xml5ever/0.18.1 \
     crate://crates.io/yeslogic-fontconfig-sys/6.0.0 \
+    crate://crates.io/yoke/0.7.5 \
+    crate://crates.io/yoke-derive/0.7.5 \
     crate://crates.io/zerocopy/0.7.35 \
     crate://crates.io/zerocopy-derive/0.7.35 \
+    crate://crates.io/zerofrom/0.1.5 \
+    crate://crates.io/zerofrom-derive/0.1.5 \
+    crate://crates.io/zerovec/0.10.4 \
+    crate://crates.io/zerovec-derive/0.10.3 \
     crate://crates.io/zune-core/0.4.12 \
-    crate://crates.io/zune-jpeg/0.4.13 \
+    crate://crates.io/zune-jpeg/0.4.14 \
 "
=20
-SRC_URI[adler-1.0.2.sha256sum] =3D "f26201604c87b1e01bd3d98f8d5d9a8fcbb815=
e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[adler2-2.0.0.sha256sum] =3D "512761e0bb2578dd7380c6baaa0f4ce03e84f=
95e960231d1dec8bf4d7d6e2627"
 SRC_URI[ahash-0.8.11.sha256sum] =3D "e89da841a80418a9b391ebaea17f5c112ffaa=
a96f621d2c285b5174da76b9011"
 SRC_URI[aho-corasick-1.1.3.sha256sum] =3D "8e60d3430d3a69478ad0993f19238d2=
df97c507009a52b3c10addcd7f6bcb916"
 SRC_URI[android-tzdata-0.1.1.sha256sum] =3D "e999941b234f3131b00bc13c22d06=
e8c5ff726d1b6318ac7eb276997bbb4fef0"
 SRC_URI[android_system_properties-0.1.5.sha256sum] =3D "819e7219dbd41043ac=
279b19830f2efc897156490d7fd6ea916720117ee66311"
 SRC_URI[anes-0.1.6.sha256sum] =3D "4b46cbb362ab8752921c97e041f5e366ee6297b=
d428a31275b9fcf1e380f7299"
-SRC_URI[anstream-0.6.15.sha256sum] =3D "64e15c1ab1f89faffbf04a634d5e1962e9=
074f2741eef6d97f3c4e322426d526"
-SRC_URI[anstyle-1.0.8.sha256sum] =3D "1bec1de6f59aedf83baf9ff929c98f2ad654=
b97c9510f4e70cf6f661d49fd5b1"
-SRC_URI[anstyle-parse-0.2.5.sha256sum] =3D "eb47de1e80c2b463c735db5b217a0d=
dc39d612e7ac9e2e96a5aed1f57616c1cb"
-SRC_URI[anstyle-query-1.1.1.sha256sum] =3D "6d36fc52c7f6c869915e99412912f2=
2093507da8d9e942ceaf66fe4b7c14422a"
-SRC_URI[anstyle-wincon-3.0.4.sha256sum] =3D "5bf74e1b6e971609db8ca7a9ce79f=
d5768ab6ae46441c572e46cf596f59e57f8"
-SRC_URI[anyhow-1.0.86.sha256sum] =3D "b3d1d046238990b9cf5bcde22a3fb3584ee5=
cf65fb2765f454ed428c7a0063da"
+SRC_URI[anstream-0.6.18.sha256sum] =3D "8acc5369981196006228e28809f761875c=
0327210a891e941f4c683b3a99529b"
+SRC_URI[anstyle-1.0.10.sha256sum] =3D "55cc3b69f167a1ef2e161439aa98aed94e6=
028e5f9a59be9a6ffb47aef1651f9"
+SRC_URI[anstyle-parse-0.2.6.sha256sum] =3D "3b2d16507662817a6a20a9ea92df66=
52ee4f94f914589377d69f3b21bc5798a9"
+SRC_URI[anstyle-query-1.1.2.sha256sum] =3D "79947af37f4177cfead1110013d678=
905c37501914fba0efea834c3fe9a8d60c"
+SRC_URI[anstyle-wincon-3.0.6.sha256sum] =3D "2109dbce0e72be3ec00bed26e6a74=
79ca384ad226efdd66db8fa2e3a38c83125"
+SRC_URI[anyhow-1.0.94.sha256sum] =3D "c1fd03a028ef38ba2276dce7e33fcd6369c1=
58a1bca17946c4b1b701891c1ff7"
 SRC_URI[approx-0.5.1.sha256sum] =3D "cab112f0a86d568ea0e627cc1d6be74a1e9cd=
55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.0.15.sha256sum] =3D "bc65048dd435533bb1baf2ed9956b9a2=
78fbfdcf90301b39ee117f06c0199d37"
-SRC_URI[autocfg-1.3.0.sha256sum] =3D "0c4b4d0bd25bd0b74681c0ad21497610ce1b=
7c91b1022cd21c80c6fbdd9476b0"
-SRC_URI[av-data-0.4.2.sha256sum] =3D "d75b98a3525d00f920df9a2d44cc99b9cc5b=
7dc70d7fbb612cd755270dbe6552"
+SRC_URI[assert_cmd-2.0.16.sha256sum] =3D "dc1835b7f27878de8525dc71410b5a31=
cdcc5f230aed5ba5df968e09c201b23d"
+SRC_URI[autocfg-1.4.0.sha256sum] =3D "ace50bade8e6234aa140d9a2f552bbee1db4=
d353f69b8217bc503490fc1a9f26"
+SRC_URI[av-data-0.4.4.sha256sum] =3D "fca67ba5d317924c02180c576157afd54bab=
e48a76ebc66ce6d34bb8ba08308e"
 SRC_URI[bit-set-0.5.3.sha256sum] =3D "0700ddab506f33b20a03b13996eccd309a48=
e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] =3D "349f9b6a179ed607305526ca489b34ad0a41=
aed5f7980fa90eb03160b69598fb"
 SRC_URI[bitflags-1.3.2.sha256sum] =3D "bef38d45163c2f1dde094a7dfd33ccf595c=
92905c8f8f4fdc18d06fb1037718a"
 SRC_URI[bitflags-2.6.0.sha256sum] =3D "b048fb63fd8b5923fc5aa7b340d8e156aec=
7ec02f0c78fa8a6ddc2613f6f71de"
-SRC_URI[bitreader-0.3.8.sha256sum] =3D "bdd859c9d97f7c468252795b35aeccc412=
bdbb1e90ee6969c4fa6328272eaeff"
+SRC_URI[bitreader-0.3.11.sha256sum] =3D "886559b1e163d56c765bc3a985febb4ee=
e8009f625244511d8ee3c432e08c066"
 SRC_URI[block-0.1.6.sha256sum] =3D "0d8c1fef690941d3e7788d328517591fecc684=
c084084702d6ff1641e993699a"
 SRC_URI[block-buffer-0.10.4.sha256sum] =3D "3078c7629b62d3f0439517fa394996=
acacc5cbc91c5a20d8c658e77abd503a71"
-SRC_URI[bstr-1.10.0.sha256sum] =3D "40723b8fb387abc38f4f4a37c09073622e41dd=
12327033091ef8950659e6dc0c"
+SRC_URI[bstr-1.11.0.sha256sum] =3D "1a68f1f47cdf0ec8ee4b941b2eee2a80cb796d=
b73118c0dd09ac63fbe405be22"
 SRC_URI[bumpalo-3.16.0.sha256sum] =3D "79296716171880943b8470b5f8d03aa55eb=
2e645a4874bdbb28adb49162e012c"
 SRC_URI[byte-slice-cast-1.2.2.sha256sum] =3D "c3ac9f8b63eca6fd385229b3675f=
6cc0dc5c8a5c8a54a59d4f52ffd670d87b0c"
-SRC_URI[bytemuck-1.16.3.sha256sum] =3D "102087e286b4677862ea56cf8fc58bb2cd=
fa8725c40ffb80fe3a008eb7f2fc83"
+SRC_URI[bytemuck-1.20.0.sha256sum] =3D "8b37c88a63ffd85d15b406896cc343916d=
7cf57838a847b3a6f2ca5d39a5695a"
 SRC_URI[byteorder-1.5.0.sha256sum] =3D "1fd0f2584146f6f2ef48085050886acf35=
3beff7305ebd1ae69500e27c67f64b"
 SRC_URI[byteorder-lite-0.1.0.sha256sum] =3D "8f1fe948ff07f4bd06c30984e69f5=
b4899c516a3ef74f34df92a2df2ab535495"
-SRC_URI[bytes-1.7.1.sha256sum] =3D "8318a53db07bb3f8dca91a600466bdb3f2eaad=
eedfdbcf02e1accbad9271ba50"
-SRC_URI[cairo-rs-0.20.0.sha256sum] =3D "797fd5a634dcb0ad0d7d583df794deb0a2=
36d88e759cd34b7da20198c6c9d145"
+SRC_URI[bytes-1.9.0.sha256sum] =3D "325918d6fe32f23b19878fe4b34794ae41fc19=
ddbe53b10571a4874d44ffd39b"
+SRC_URI[cairo-rs-0.20.5.sha256sum] =3D "d7fa699e1d7ae691001a811dda5ef0e3e4=
2e1d4119b26426352989df9e94e3e6"
 SRC_URI[cairo-sys-rs-0.20.0.sha256sum] =3D "428290f914b9b86089f60f5d8a9f6e=
440508e1bcff23b25afd51502b0a2da88f"
 SRC_URI[cast-0.3.0.sha256sum] =3D "37b2a672a2cb129a2e41c10b1224bb368f9f37a=
2b16b612598138befd7b37eb5"
-SRC_URI[cc-1.1.8.sha256sum] =3D "504bdec147f2cc13c8b57ed9401fd8a147cc66b67=
ad5cb241394244f2c947549"
+SRC_URI[cc-1.2.3.sha256sum] =3D "27f657647bcff5394bf56c7317665bbf790a137a5=
0eaaa5c6bfbb9e27a518f2d"
 SRC_URI[cfg-expr-0.15.8.sha256sum] =3D "d067ad48b8650848b989a59a86c6c36a99=
5d02d2bf778d45c3c5d57bc2718f02"
+SRC_URI[cfg-expr-0.17.2.sha256sum] =3D "8d4ba6e40bd1184518716a6e1a781bf916=
0e286d219ccdb8ab2612e74cfe4789"
 SRC_URI[cfg-if-1.0.0.sha256sum] =3D "baf1de4339761588bc0619e3cbc0120ee582e=
bb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.38.sha256sum] =3D "a21f936df1771bf62b77f047b726c4625ff2=
e8aa607c01ec06e5a05bd8463401"
+SRC_URI[chrono-0.4.39.sha256sum] =3D "7e36cc9d416881d2e24f9a963be5fb1cd909=
66419ac844274161d10488b3e825"
 SRC_URI[ciborium-0.2.2.sha256sum] =3D "42e69ffd6f0917f5c029256a24d0161db17=
cea3997d185db0d35926308770f0e"
 SRC_URI[ciborium-io-0.2.2.sha256sum] =3D "05afea1e0a06c9be33d539b876f1ce36=
92f4afea2cb41f740e7743225ed1c757"
 SRC_URI[ciborium-ll-0.2.2.sha256sum] =3D "57663b653d948a338bfb3eeba9bb2fd5=
fcfaecb9e199e87e1eda4d9e8b240fd9"
-SRC_URI[clap-4.5.13.sha256sum] =3D "0fbb260a053428790f3de475e304ff84cdbc4f=
ace759ea7a3e64c1edd938a7fc"
-SRC_URI[clap_builder-4.5.13.sha256sum] =3D "64b17d7ea74e9f833c7dbf2cbe4fb1=
2ff26783eda4782a8975b72f895c9b4d99"
-SRC_URI[clap_complete-4.5.12.sha256sum] =3D "a8670053e87c316345e384ca1f3eb=
a3006fc6355ed8b8a1140d104e109e3df34"
-SRC_URI[clap_derive-4.5.13.sha256sum] =3D "501d359d5f3dcaf6ecdeee48833ae73=
ec6e42723a1e52419c79abf9507eec0a0"
-SRC_URI[clap_lex-0.7.2.sha256sum] =3D "1462739cb27611015575c0c11df5df76011=
41071f07518d56fcc1be504cbec97"
+SRC_URI[clap-4.5.23.sha256sum] =3D "3135e7ec2ef7b10c6ed8950f0f792ed96ee093=
fa088608f1c76e569722700c84"
+SRC_URI[clap_builder-4.5.23.sha256sum] =3D "30582fc632330df2bd26877bde0c1f=
4470d57c582bbc070376afcd04d8cb4838"
+SRC_URI[clap_complete-4.5.38.sha256sum] =3D "d9647a559c112175f17cf724dc72d=
3645680a883c58481332779192b0d8e7a01"
+SRC_URI[clap_derive-4.5.18.sha256sum] =3D "4ac6a0c7b1a9e9a5186361f67dfa1b8=
8213572f427fb9ab038efb2bd8c582dab"
+SRC_URI[clap_lex-0.7.4.sha256sum] =3D "f46ad14479a25103f283c0f10005961cf08=
6d8dc42205bb44c46ac563475dca6"
 SRC_URI[color_quant-1.1.0.sha256sum] =3D "3d7b894f5411737b7867f4827955924d=
7c254fc9f4d91a6aad6b097804b1018b"
-SRC_URI[colorchoice-1.0.2.sha256sum] =3D "d3fd119d74b830634cea2a0f58bbd0d5=
4540518a14397557951e79340abc28c0"
-SRC_URI[core-foundation-sys-0.8.6.sha256sum] =3D "06ea2b9bc92be3c2baa9334a=
323ebca2d6f074ff852cd1d7b11064035cd3868f"
+SRC_URI[colorchoice-1.0.3.sha256sum] =3D "5b63caa9aa9397e2d9480a9b13673856=
c78d8ac123288526c37d7839f2a86990"
+SRC_URI[core-foundation-sys-0.8.7.sha256sum] =3D "773648b94d0e5d620f64f280=
777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[crc32fast-1.4.2.sha256sum] =3D "a97769d94ddab943e4510d138150169a27=
58b5ef3eb191a9ee688de3e23ef7b3"
 SRC_URI[criterion-0.5.1.sha256sum] =3D "f2b12d017a929603d80db1831cd3a24082=
f8137ce19c69e6447f54f5fc8d692f"
 SRC_URI[criterion-plot-0.5.0.sha256sum] =3D "6b50826342786a51a89e2da3a28f1=
c32b06e387201bc2d19791f622c673706b1"
@@ -357,70 +380,82 @@ SRC_URI[cssparser-macros-0.6.1.sha256sum] =3D "13b588=
ba4ac1a99f7f2964d24b3d896ddc6
 SRC_URI[data-url-0.3.1.sha256sum] =3D "5c297a1c74b71ae29df00c3e22dd9534821=
d60eb9af5a0192823fa2acea70c2a"
 SRC_URI[dav1d-0.10.3.sha256sum] =3D "0d4b54a40baf633a71c6f0fb49494a7e4ee7b=
c26f3e727212b6cb915aa1ea1e1"
 SRC_URI[dav1d-sys-0.8.2.sha256sum] =3D "6ecb1c5e8f4dc438eedc1b534a54672fb0=
e0a56035dae6b50162787bd2c50e95"
-SRC_URI[dcv-color-primitives-0.6.1.sha256sum] =3D "07ad62edfed069700a5b33a=
f6babd29c498d7e33eb01d96ffa8841ee1841634c"
 SRC_URI[deranged-0.3.11.sha256sum] =3D "b42b6fa04a440b495c8b04d0e71b707c58=
5f83cb9cb28cf8cd0d976c315e31b4"
 SRC_URI[derive_more-0.99.18.sha256sum] =3D "5f33878137e4dafd7fa914ad4e259e=
18a4e8e532b9617a2d0150262bf53abfce"
 SRC_URI[difflib-0.4.0.sha256sum] =3D "6184e33543162437515c2e2b48714794e378=
45ec9851711914eec9d308f6ebe8"
 SRC_URI[digest-0.10.7.sha256sum] =3D "9ed9a281f7bc9b7576e61468ba615a66a5c8=
cfdff42420a70aa82701a3b1e292"
+SRC_URI[displaydoc-0.2.5.sha256sum] =3D "97369cbbc041bc366949bc74d34658d6c=
da5621039731c6310521892a3a20ae0"
 SRC_URI[dlib-0.5.2.sha256sum] =3D "330c60081dcc4c72131f8eb70510f1ac07223e5=
d4163db481a04a0befcffa412"
 SRC_URI[doc-comment-0.3.3.sha256sum] =3D "fea41bba32d969b51399775273560505=
4bc0dfa92b4c56bf1189f2e174be7a10"
 SRC_URI[dtoa-1.0.9.sha256sum] =3D "dcbb2bf8e87535c23f7a8a321e364ce21462d0f=
f10cb6407820e8e96dfff6653"
 SRC_URI[dtoa-short-0.3.5.sha256sum] =3D "cd1511a7b6a56299bd043a9c167a6d2bf=
b37bf84a6dfceaba651168adfb43c87"
 SRC_URI[either-1.13.0.sha256sum] =3D "60b1af1c220855b6ceac025d3f6ecdd2b7c4=
894bfe9cd9bda4fbb4bc7c0d4cf0"
-SRC_URI[encoding_rs-0.8.34.sha256sum] =3D "b45de904aa0b010bce2ab45264d0631=
681847fa7b6f2eaa7dab7619943bc4f59"
+SRC_URI[encoding_rs-0.8.35.sha256sum] =3D "75030f3c4f45dafd7586dd6780965a8=
c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[equivalent-1.0.1.sha256sum] =3D "5443807d6dff69373d433ab9ef5378ad8=
df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[errno-0.3.9.sha256sum] =3D "534c5cf6194dfab3db3242765c03bbe257cf92=
f22b38f6bc0c58d59108a820ba"
+SRC_URI[errno-0.3.10.sha256sum] =3D "33d852cb9b869c2a9b3df2f71a3074817f01e=
1844f839a144f5fcef059a4eb5d"
 SRC_URI[fallible_collections-0.4.9.sha256sum] =3D "a88c69768c0a15262df2189=
9142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
-SRC_URI[fastrand-2.1.0.sha256sum] =3D "9fc0510504f03c51ada170672ac806f1f10=
5a88aa97a5281117e1ddc3368e51a"
-SRC_URI[fdeflate-0.3.4.sha256sum] =3D "4f9bfee30e4dedf0ab8b422f03af778d961=
2b63f502710fc500a334ebe2de645"
-SRC_URI[flate2-1.0.31.sha256sum] =3D "7f211bbe8e69bbd0cfdea405084f128ae8b4=
aaa6b0b522fc8f2b009084797920"
+SRC_URI[fastrand-2.3.0.sha256sum] =3D "37909eebbb50d72f9059c3b6d82c0463f2f=
f062c9e95845c43a6c9c0355411be"
+SRC_URI[fdeflate-0.3.7.sha256sum] =3D "1e6853b52649d4ac5c0bd02320cddc5ba95=
6bdb407c4b75a2c6b75bf51500f8c"
+SRC_URI[flate2-1.0.35.sha256sum] =3D "c936bfdafb507ebbf50b8074c54fa31c5be9=
a1e7e5f467dd659697041407d07c"
 SRC_URI[float-cmp-0.9.0.sha256sum] =3D "98de4bbd547a563b716d8dfa9aad1cb19b=
fab00f4fa09a6a4ed21dbcf44ce9c4"
 SRC_URI[fnv-1.0.7.sha256sum] =3D "3f9eec918d3f24069decb9af1554cad7c880e2da=
24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.1.sha256sum] =3D "e13624c2627564efccf4934284bd=
d98cbaa14e79b0b5a141218e507b3a823456"
 SRC_URI[futf-0.1.5.sha256sum] =3D "df420e2e84819663797d1ec6544b13c5be84629=
e7bb00dc960d6917db2987843"
-SRC_URI[futures-channel-0.3.30.sha256sum] =3D "eac8f7d7865dcb88bd4373ab671=
c8cf4508703796caa2b1985a9ca867b3fcb78"
-SRC_URI[futures-core-0.3.30.sha256sum] =3D "dfc6580bb841c5a68e9ef15c77ccc8=
37b40a7504914d52e47b8b0e9bbda25a1d"
-SRC_URI[futures-executor-0.3.30.sha256sum] =3D "a576fc72ae164fca6b9db127ea=
a9a9dda0d61316034f33a0a0d4eda41f02b01d"
-SRC_URI[futures-io-0.3.30.sha256sum] =3D "a44623e20b9681a318efdd71c299b6b2=
22ed6f231972bfe2f224ebad6311f0c1"
-SRC_URI[futures-macro-0.3.30.sha256sum] =3D "87750cf4b7a4c0625b1529e4c543c=
2182106e4dedc60a2a6455e00d212c489ac"
-SRC_URI[futures-task-0.3.30.sha256sum] =3D "38d84fa142264698cdce1a9f9172cf=
383a0c82de1bddcf3092901442c4097004"
-SRC_URI[futures-util-0.3.30.sha256sum] =3D "3d6401deb83407ab3da39eba7e3398=
7a73c3df0c82b4bb5813ee871c19c41d48"
+SRC_URI[futures-channel-0.3.31.sha256sum] =3D "2dff15bf788c671c1934e366d07=
e30c1814a8ef514e1af724a602e8a2fbe1b10"
+SRC_URI[futures-core-0.3.31.sha256sum] =3D "05f29059c0c2090612e8d742178b05=
80d2dc940c837851ad723096f87af6663e"
+SRC_URI[futures-executor-0.3.31.sha256sum] =3D "1e28d1d997f585e54aebc3f97d=
39e72338912123a67330d723fdbb564d646c9f"
+SRC_URI[futures-io-0.3.31.sha256sum] =3D "9e5c1b78ca4aae1ac06c48a526a65576=
0685149f0d465d21f37abfe57ce075c6"
+SRC_URI[futures-macro-0.3.31.sha256sum] =3D "162ee34ebcb7c64a8abebc059ce0f=
ee27c2262618d7b60ed8faf72fef13c3650"
+SRC_URI[futures-task-0.3.31.sha256sum] =3D "f90f7dce0722e95104fcb095585910=
c0977252f286e354b5e3bd38902cd99988"
+SRC_URI[futures-util-0.3.31.sha256sum] =3D "9fa08315bb612088cc391249efdc3b=
c77536f16c91f6cf495e6fbe85b20a4a81"
 SRC_URI[fxhash-0.2.1.sha256sum] =3D "c31b6d751ae2c7f11320402d34e41349dd101=
6f8d5d45e48c4312bc8625af50c"
-SRC_URI[gdk-pixbuf-0.20.0.sha256sum] =3D "28bb53ecb56857c683c9ec859908e076=
dd3969c7d67598bd8b1ce095d211304a"
-SRC_URI[gdk-pixbuf-sys-0.20.0.sha256sum] =3D "9f6681a0c1330d1d3968bec1529f=
7172d62819ef0bdbb0d18022320654158b03"
+SRC_URI[gdk-pixbuf-0.20.4.sha256sum] =3D "c4c29071a9e92337d8270a85cb0510cd=
a4ac478be26d09ad027cc1d081911b19"
+SRC_URI[gdk-pixbuf-sys-0.20.4.sha256sum] =3D "687343b059b91df5f3fbd87b4307=
038fa9e647fcc0461d0d3f93e94fee20bf3d"
 SRC_URI[generic-array-0.14.7.sha256sum] =3D "85649ca51fd72272d7821adaf274a=
d91c288277713d9c18820d8499a7ff69e9a"
 SRC_URI[getrandom-0.2.15.sha256sum] =3D "c4567c8db10ae91089c99af84c68c38da=
3ec2f087c3f82960bcdbf3656b6f4d7"
 SRC_URI[gif-0.13.1.sha256sum] =3D "3fb2d69b19215e18bb912fa30f7ce15846e3014=
08695e44e0ef719f1da9e19f2"
-SRC_URI[gio-0.20.0.sha256sum] =3D "398e3da68749fdc32783cbf7521ec3f65c9cf94=
6db8c7774f8460af49e52c6e2"
-SRC_URI[gio-sys-0.20.0.sha256sum] =3D "e4feb96b31c32730ea3e1e89aecd2e4e37e=
cb1c473ad8f685e3430a159419f63"
-SRC_URI[glib-0.20.0.sha256sum] =3D "fee90a615ce05be7a32932cfb8adf2c4bbb470=
0e80d37713c981fb24c0c56238"
-SRC_URI[glib-macros-0.20.0.sha256sum] =3D "4da558d8177c0c8c54368818b508a42=
44e1286fce2858cef4e547023f0cfa5ef"
-SRC_URI[glib-sys-0.20.0.sha256sum] =3D "4958c26e5a01c9af00dea669a97369eccb=
ec29a8e6d125c24ea2d85ee7467b60"
-SRC_URI[gobject-sys-0.20.0.sha256sum] =3D "c6908864f5ffff15b56df7e90346863=
904f49b949337ed0456b9287af61903b8"
+SRC_URI[gio-0.20.6.sha256sum] =3D "8826d2a9ad56ce3de1f04bea0bea0daff6f5f1c=
913cc834996cfea1f9401361c"
+SRC_URI[gio-sys-0.20.8.sha256sum] =3D "8446d9b475730ebef81802c1738d972db42=
fde1c5a36a627ebc4d665fc87db04"
+SRC_URI[glib-0.20.6.sha256sum] =3D "86bd3e4ee7998ab5a135d900db56930cc19ad1=
6681adf245daff54f618b9d5e1"
+SRC_URI[glib-macros-0.20.5.sha256sum] =3D "e7d21ca27acfc3e91da70456edde144=
b4ac7c36f78ee77b10189b3eb4901c156"
+SRC_URI[glib-sys-0.20.6.sha256sum] =3D "3d0b1827e8621fc42c0dfb228e5d57ff6a=
71f9699e666ece8113f979ad87c2de"
+SRC_URI[gobject-sys-0.20.4.sha256sum] =3D "a4c674d2ff8478cf0ec29d2be730ed7=
79fef54415a2fb4b565c52def62696462"
 SRC_URI[half-2.4.1.sha256sum] =3D "6dd08c532ae367adf81c312a4580bc67f1d0fe8=
bc9c460520283f4c0ff277888"
 SRC_URI[hashbrown-0.13.2.sha256sum] =3D "43a3c133739dddd0d2990f9a4bdf8eb4b=
21ef50e4851ca85ab661199821d510e"
-SRC_URI[hashbrown-0.14.5.sha256sum] =3D "e5274423e17b7c9fc20b6e7e208532f9b=
19825d82dfd615708b70edd83df41f1"
+SRC_URI[hashbrown-0.15.2.sha256sum] =3D "bf151400ff0baff5465007dd2f3e717f3=
fe502074ca563069ce3a6629d07b289"
 SRC_URI[heck-0.5.0.sha256sum] =3D "2304e00983f87ffb38b55b444b5e3b60a884b5d=
30c0fca7d82fe33449bbe55ea"
-SRC_URI[hermit-abi-0.3.9.sha256sum] =3D "d231dfb89cfffdbc30e7fc41579ed6066=
ad03abda9e567ccafae602b97ec5024"
-SRC_URI[iana-time-zone-0.1.60.sha256sum] =3D "e7ffbb5a1b541ea2561f8c41c087=
286cc091e21e556a4f09a8f6cbf17b69b141"
+SRC_URI[hermit-abi-0.4.0.sha256sum] =3D "fbf6a919d6cf397374f7dfeeea91d974c=
7c0a7221d0d0f4f20d859d329e53fcc"
+SRC_URI[iana-time-zone-0.1.61.sha256sum] =3D "235e081f3925a06703c2d0117ea8=
b91f042756fd6e7a6e5d901e8ca1a996b220"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] =3D "f31827a206f56af32e590ba=
56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[idna-0.5.0.sha256sum] =3D "634d9b1461af396cad843f47fdba5597a4f9e6d=
dd4bfb6ff5d85028c25cb12f6"
-SRC_URI[image-0.25.2.sha256sum] =3D "99314c8a2152b8ddb211f924cdae532d8c5e4=
c8bb54728e12fff1b0cd5963a10"
-SRC_URI[image-webp-0.1.3.sha256sum] =3D "f79afb8cbee2ef20f59ccd477a218c12a=
93943d075b492015ecb1bb81f8ee904"
-SRC_URI[indexmap-2.3.0.sha256sum] =3D "de3fc2e30ba82dd1b3911c8de1ffc143c74=
a914a14e99514d7637e3099df5ea0"
-SRC_URI[is-terminal-0.4.12.sha256sum] =3D "f23ff5ef2b80d608d61efee834934d8=
62cd92461afc0560dedf493e4c033738b"
+SRC_URI[icu_collections-1.5.0.sha256sum] =3D "db2fa452206ebee18c4b5c2274db=
f1de17008e874b4dc4f0aea9d01ca79e4526"
+SRC_URI[icu_locid-1.5.0.sha256sum] =3D "13acbb8371917fc971be86fc8057c41a64=
b521c184808a698c02acc242dbf637"
+SRC_URI[icu_locid_transform-1.5.0.sha256sum] =3D "01d11ac35de8e40fdeda00d9=
e1e9d92525f3f9d887cdd7aa81d727596788b54e"
+SRC_URI[icu_locid_transform_data-1.5.0.sha256sum] =3D "fdc8ff3388f852bede6=
b579ad4e978ab004f139284d7b28715f773507b946f6e"
+SRC_URI[icu_normalizer-1.5.0.sha256sum] =3D "19ce3e0da2ec68599d193c93d0881=
42efd7f9c5d6fc9b803774855747dc6a84f"
+SRC_URI[icu_normalizer_data-1.5.0.sha256sum] =3D "f8cafbf7aa791e9b22bec55a=
167906f9e1215fd475cd22adfcf660e03e989516"
+SRC_URI[icu_properties-1.5.1.sha256sum] =3D "93d6020766cfc6302c15dbbc9c877=
8c37e62c14427cb7f6e601d849e092aeef5"
+SRC_URI[icu_properties_data-1.5.0.sha256sum] =3D "67a8effbc3dd3e4ba1afa8ad=
918d5684b8868b3b26500753effea8d2eed19569"
+SRC_URI[icu_provider-1.5.0.sha256sum] =3D "6ed421c8a8ef78d3e2dbc98a973be2f=
3770cb42b606e3ab18d6237c4dfde68d9"
+SRC_URI[icu_provider_macros-1.5.0.sha256sum] =3D "1ec89e9337638ecdc08744df=
490b221a7399bf8d164eb52a665454e60e075ad6"
+SRC_URI[idna-1.0.3.sha256sum] =3D "686f825264d630750a544639377bae737628043=
f20d38bbc029e8f29ea968a7e"
+SRC_URI[idna_adapter-1.2.0.sha256sum] =3D "daca1df1c957320b2cf139ac61e7bd6=
4fed304c5040df000a745aa1de3b4ef71"
+SRC_URI[image-0.25.5.sha256sum] =3D "cd6f44aed642f18953a158afeb30206f4d50d=
a59fbc66ecb53c66488de73563b"
+SRC_URI[image-webp-0.2.0.sha256sum] =3D "e031e8e3d94711a9ccb5d6ea357439ef3=
dcbed361798bd4071dc4d9793fbe22f"
+SRC_URI[indexmap-2.7.0.sha256sum] =3D "62f822373a4fe84d4bb149bf54e584a7f4a=
bec90e072ed49cda0edea5b95471f"
+SRC_URI[is-terminal-0.4.13.sha256sum] =3D "261f68e344040fbd0edea105bef17c6=
6edf46f984ddb1115b775ce31be948f4b"
 SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] =3D "7943c866cc5cd64cbc25b2=
e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
 SRC_URI[itertools-0.10.5.sha256sum] =3D "b0fd2260e829bddf4cb6ea802289de2f8=
6d6a7a690192fbe91b3f46e0f2c8473"
 SRC_URI[itertools-0.13.0.sha256sum] =3D "413ee7dfc52ee1a4949ceeb7dbc8a33f2=
d6c088194d9f922fb8318faf1f01186"
-SRC_URI[itoa-1.0.11.sha256sum] =3D "49f1f14873335454500d59611f1cf4a4b0f786=
f9ac11f4312a78e4cf2566695b"
-SRC_URI[js-sys-0.3.69.sha256sum] =3D "29c15563dc2726973df627357ce0c9ddddbe=
a194836909d655df6a75d2cf296d"
+SRC_URI[itoa-1.0.14.sha256sum] =3D "d75a2a4b1b190afb6f5425f10f6a8f959d2ea0=
b9c2b1d79553551850539e4674"
+SRC_URI[js-sys-0.3.76.sha256sum] =3D "6717b6b5b077764fb5966237269cb3c64edd=
dde4b14ce42647430a78ced9e7b7"
 SRC_URI[language-tags-0.3.2.sha256sum] =3D "d4345964bb142484797b161f473a50=
3a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.5.0.sha256sum] =3D "bbd2bcb4c963f2ddae06a2efc7e9f359=
1312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.155.sha256sum] =3D "97b3888a4aecf77e811145cadf6eef5901f47=
82c53886191b2f693f24761847c"
-SRC_URI[libloading-0.8.5.sha256sum] =3D "4979f22fdb869068da03c9f7528f8297c=
6fd2606bc3a4affe42e6a823fdb8da4"
-SRC_URI[libm-0.2.8.sha256sum] =3D "4ec2a862134d2a7d32d7983ddcdd1c492353083=
3c9f2ea1a44fc5fa473989058"
+SRC_URI[libc-0.2.168.sha256sum] =3D "5aaeb2981e0606ca11d79718f8bb01164f1d6=
ed75080182d3abf017e6d244b6d"
+SRC_URI[libloading-0.8.6.sha256sum] =3D "fc2f4eb4bc735547cfed7c0a4922cbd04=
a4655978c09b54f1f7b228750664c34"
+SRC_URI[libm-0.2.11.sha256sum] =3D "8355be11b20d696c8f18f6cc018c4e372165b1=
fa8126cef092399c9951984ffa"
 SRC_URI[linked-hash-map-0.5.6.sha256sum] =3D "0717cef1bc8b636c6e1c1bbdefc0=
9e6322da8a9321966e8928ef80d20f7f770f"
 SRC_URI[linux-raw-sys-0.4.14.sha256sum] =3D "78b3ae25bc7c8c38cec158d1f2757=
ee79e9b3740fbc7ccf0e59e4b08d793fa89"
+SRC_URI[litemap-0.7.4.sha256sum] =3D "4ee93343901ab17bd981295f2cf0026d4ad0=
18c7c31ba84549a4ddbb47a45104"
 SRC_URI[locale_config-0.3.0.sha256sum] =3D "08d2c35b16f4483f6c26f0e4e95507=
17a2f6575bcd6f12a53ff0c490a94a6934"
 SRC_URI[lock_api-0.4.12.sha256sum] =3D "07af8b9cdd281b7915f413fa73f29ebd5d=
55d0d3f0155584dade1ff18cea1b17"
 SRC_URI[log-0.4.22.sha256sum] =3D "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c=
54bba33a7f72f873a39d07b24"
@@ -433,9 +468,9 @@ SRC_URI[matrixmultiply-0.3.9.sha256sum] =3D "9380b911e3=
e96d10c1f415da0876389aaf1b5
 SRC_URI[md-5-0.10.6.sha256sum] =3D "d89e7ee0cfbedfc4da3340218492196241d89e=
efb6dab27de5df917a6d2e78cf"
 SRC_URI[memchr-2.7.4.sha256sum] =3D "78ca9ab1a0babb1e7d5695e3530886289c18c=
f2f87ec19a575a0abdce112e3a3"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] =3D "68354c5c6bd36d73ff3feceb05ef=
a59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.7.4.sha256sum] =3D "b8a240ddb74feaf34a79a7add65a741f=
3167852fba007066dcac1ca548d89c08"
+SRC_URI[miniz_oxide-0.8.0.sha256sum] =3D "e2d80299ef12ff69b16a84bb182e3b9d=
f68b5a91574d3d4fa6e41b65deec4df1"
 SRC_URI[mp4parse-0.17.0.sha256sum] =3D "63a35203d3c6ce92d5251c77520acb2e57=
108c88728695aa883f70023624c570"
-SRC_URI[nalgebra-0.33.0.sha256sum] =3D "3c4b5f057b303842cf3262c27e465f4c30=
3572e7f6b0648f60e16248ac3397f4"
+SRC_URI[nalgebra-0.33.2.sha256sum] =3D "26aecdf64b707efd1310e3544d709c5c0a=
c61c13756046aaaba41be5c4f66a3b"
 SRC_URI[nalgebra-macros-0.2.2.sha256sum] =3D "254a5372af8fc138e36684761d3c=
0cdb758a4410e938babcff1c860ce14ddbfc"
 SRC_URI[new_debug_unreachable-1.0.6.sha256sum] =3D "650eef8c711430f1a879fd=
d01d4745a7deea475becfb90269c06775983bbf086"
 SRC_URI[nom-7.1.3.sha256sum] =3D "d273983c5a657a70a3e8f2a01329822f3b8c8172=
b73826411a55751e404a0a4a"
@@ -450,12 +485,12 @@ SRC_URI[num-traits-0.2.19.sha256sum] =3D "071dfc06269=
0e90b734c0b2273ce72ad0ffa95f0
 SRC_URI[objc-0.2.7.sha256sum] =3D "915b1b472bc21c53464d6c8461c9d3af805ba1e=
f837e1cac254428f4a77177b1"
 SRC_URI[objc-foundation-0.1.1.sha256sum] =3D "1add1b659e36c9607c7aab864a76=
c7a4c2760cd0cd2e120f3fb8b952c7e22bf9"
 SRC_URI[objc_id-0.1.1.sha256sum] =3D "c92d4ddb4bd7b50d730c215ff871754d0da6=
b2178849f8a2a2ab69712d0c073b"
-SRC_URI[once_cell-1.19.0.sha256sum] =3D "3fdb12b2476b595f9358c5161aa467c24=
38859caa136dec86c26fdd2efe17b92"
+SRC_URI[once_cell-1.20.2.sha256sum] =3D "1261fe7e33c73b354eab43b1273a57c8f=
967d0391e80353e51f764ac02cf6775"
 SRC_URI[oorandom-11.1.4.sha256sum] =3D "b410bbe7e14ab526a0e86877eb47c6996a=
2bd7746f027ba551028c925390e4e9"
-SRC_URI[pango-0.20.0.sha256sum] =3D "54768854025df6903061d0084fd9702a253dd=
fd60db7d9b751d43b76689a7f0a"
-SRC_URI[pango-sys-0.20.0.sha256sum] =3D "b07cc57d10cee4ec661f718a6902cee18=
c2f4cfae08e87e5a390525946913390"
-SRC_URI[pangocairo-0.20.0.sha256sum] =3D "902cd6e53493a475f4524e7b3f4c09ef=
60ee87c7be16f08f1b41882fc74dac46"
-SRC_URI[pangocairo-sys-0.20.0.sha256sum] =3D "bc23a5ea756e709ab1598f8446a6=
4c799b10c99ec59aa2310965218bc1915853"
+SRC_URI[pango-0.20.6.sha256sum] =3D "71e34e7ca2c52e3933d7e5251409a82b83725=
fa9d6d48fbdaacec056b3a0554a"
+SRC_URI[pango-sys-0.20.4.sha256sum] =3D "84fd65917bf12f06544ae2bbc200abf9f=
c0a513a5a88a0fa81013893aef2b838"
+SRC_URI[pangocairo-0.20.4.sha256sum] =3D "4291ca8cdd05e4330752bf8a450d3a4e=
701ca48fd9aad2b3566e92849ee4055e"
+SRC_URI[pangocairo-sys-0.20.4.sha256sum] =3D "be0ed959258ea648a49bde7dfdba=
a98310717cb15159b421fa76510c45ec306e"
 SRC_URI[parking_lot-0.12.3.sha256sum] =3D "f1bf18183cf54e8d6059647fc306364=
6a1801cf30896933ec2311622cc4b9a27"
 SRC_URI[parking_lot_core-0.9.10.sha256sum] =3D "1e401f977ab385c9e4e3ab3062=
7d6f26d00e2c73eef317493c4ec6d468726cf8"
 SRC_URI[paste-1.0.15.sha256sum] =3D "57c0d7b74b563b49d38dae00a0c37d4d6de9b=
432382b2892f0574ddcae73fd0a"
@@ -469,25 +504,25 @@ SRC_URI[phf_generator-0.11.2.sha256sum] =3D "48e4cc64=
c2ad9ebe670cb8fd69dd50ae30165
 SRC_URI[phf_macros-0.11.2.sha256sum] =3D "3444646e286606587e49f3bcf1679b8c=
ef1dc2c5ecc29ddacaffc305180d464b"
 SRC_URI[phf_shared-0.10.0.sha256sum] =3D "b6796ad771acdc0123d2a88dc428b5e3=
8ef24456743ddb1744ed628f9815c096"
 SRC_URI[phf_shared-0.11.2.sha256sum] =3D "90fcb95eef784c2ac79119d1dd819e16=
2b5da872ce6f3c3abe1e8ca1c082f72b"
-SRC_URI[pin-project-lite-0.2.14.sha256sum] =3D "bda66fc9667c18cb2758a2ac84=
d1167245054bcf85d5d1aaa6923f45801bdd02"
+SRC_URI[pin-project-lite-0.2.15.sha256sum] =3D "915a1e146535de9163f3987b89=
44ed8cf49a18bb0056bcebcdcece385cece4ff"
 SRC_URI[pin-utils-0.1.0.sha256sum] =3D "8b870d8c151b6f2fb93e84a13146138f05=
d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.30.sha256sum] =3D "d231b230927b5e4ad203db57bbcbee28=
02f6bce620b1e4a9024a07d94e2907ec"
-SRC_URI[plotters-0.3.6.sha256sum] =3D "a15b6eccb8484002195a3e44fe65a4ce8e9=
3a625797a063735536fd59cb01cf3"
-SRC_URI[plotters-backend-0.3.6.sha256sum] =3D "414cec62c6634ae900ea1c56128=
dfe87cf63e7caece0852ec76aba307cebadb7"
-SRC_URI[plotters-svg-0.3.6.sha256sum] =3D "81b30686a7d9c3e010b84284bdd26a2=
9f2138574f52f5eb6f794fc0ad924e705"
-SRC_URI[png-0.17.13.sha256sum] =3D "06e4b0d3d1312775e782c86c91a111aa1f910c=
bb65e1337f9975b5f9a554b5e1"
+SRC_URI[pkg-config-0.3.31.sha256sum] =3D "953ec861398dccce10c670dfeaf3ec49=
11ca479e9c02154b3a215178c5f566f2"
+SRC_URI[plotters-0.3.7.sha256sum] =3D "5aeb6f403d7a4911efb1e33402027fc44f2=
9b5bf6def3effcc22d7bb75f2b747"
+SRC_URI[plotters-backend-0.3.7.sha256sum] =3D "df42e13c12958a16b3f7f4386b9=
ab1f3e7933914ecea48da7139435263a4172a"
+SRC_URI[plotters-svg-0.3.7.sha256sum] =3D "51bae2ac328883f7acdfea3d66a7c35=
751187f870bc81f94563733a154d7a670"
+SRC_URI[png-0.17.15.sha256sum] =3D "b67582bd5b65bdff614270e2ea89a1cf15bef7=
1245cc1e5f7ea126977144211d"
 SRC_URI[powerfmt-0.2.0.sha256sum] =3D "439ee305def115ba05938db6eb1644ff941=
65c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.20.sha256sum] =3D "77957b295656769bb8ad2b6a6b09d897=
d94f05c41b069aede1fcdaa675eaea04"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] =3D "925383efa346730478fb4838dbe=
9137d2a47675ad789c546d150a6e1dd4ab31c"
 SRC_URI[predicates-3.1.2.sha256sum] =3D "7e9086cc7640c29a356d1a29fd134380b=
ee9d8f79a17410aa76e7ad295f42c97"
 SRC_URI[predicates-core-1.0.8.sha256sum] =3D "ae8177bee8e75d6846599c6b9ff6=
79ed51e882816914eec639944d7c9aa11931"
 SRC_URI[predicates-tree-1.0.11.sha256sum] =3D "41b740d195ed3166cd147c8047e=
c98db0e22ec019eb8eeb76d343b795304fb13"
-SRC_URI[proc-macro-crate-3.1.0.sha256sum] =3D "6d37c51ca738a55da99dc0c4a34=
860fd675453b8b36209178c2249bb13651284"
-SRC_URI[proc-macro2-1.0.86.sha256sum] =3D "5e719e8df665df0d1c8fbfd23801574=
4736151d4445ec0836b8e628aae103b77"
+SRC_URI[proc-macro-crate-3.2.0.sha256sum] =3D "8ecf48c7ca261d60b74ab1a7b20=
da18bede46776b2e55535cb958eb595c5fa7b"
+SRC_URI[proc-macro2-1.0.92.sha256sum] =3D "37d3544b3f2748c54e147655edb5025=
752e2303145b5aefb3c3ea2c78b973bb0"
 SRC_URI[proptest-1.5.0.sha256sum] =3D "b4c2511913b88df1637da85cc8d96ec8e43=
a3f8bb8ccb71ee1ac240d6f3df58d"
 SRC_URI[quick-error-1.2.3.sha256sum] =3D "a1d01941d82fa2ab50be1e79e6714289=
dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] =3D "a993555f31e5a609f617c12db6250ded=
cac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[quote-1.0.36.sha256sum] =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab=
723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[quote-1.0.37.sha256sum] =3D "b5b9d34b8991d19d98081b46eacdd8eb58c6f=
2b201139f7c5f643cc155a633af"
 SRC_URI[rand-0.8.5.sha256sum] =3D "34af8d1a0e25924bc5b7c43c079c942339d8f0a=
8b57c39049bef581b46327404"
 SRC_URI[rand_chacha-0.3.1.sha256sum] =3D "e6c10a63a0fa32252be49d21e7709d4d=
4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] =3D "ec0be4795e2f6a28069bec0b5ff3e2ac9b=
afc99e6a9a7dc3547996c5c816922c"
@@ -496,24 +531,25 @@ SRC_URI[rawpointer-0.2.1.sha256sum] =3D "60a357793950=
651c4ed0f3f52338f53b2f809f32d
 SRC_URI[rayon-1.10.0.sha256sum] =3D "b418a60154510ca1a002a752ca9714984e21e=
4241e804d32555251faf8b78ffa"
 SRC_URI[rayon-core-1.12.1.sha256sum] =3D "1465873a3dfdaa8ae7cb14b4383657ca=
ab0b3e8a0aa9ae8e04b044854c8dfce2"
 SRC_URI[rctree-0.6.0.sha256sum] =3D "e03e7866abec1101869ffa8e2c8355c4c2419=
d0214ece0cc3e428e5b94dea6e9"
-SRC_URI[redox_syscall-0.5.3.sha256sum] =3D "2a908a6e00f1fdd0dfd9c0eb08ce85=
126f6d8bbda50017e74bc4a4b7d4a926a4"
-SRC_URI[regex-1.10.6.sha256sum] =3D "4219d74c6b67a3654a9fbebc4b419e22126d1=
3d2f3c4a07ee0cb61ff79a79619"
-SRC_URI[regex-automata-0.4.7.sha256sum] =3D "38caf58cc5ef2fed281f89292ef23=
f6365465ed9a41b7a7754eb4e26496c92df"
-SRC_URI[regex-syntax-0.8.4.sha256sum] =3D "7a66a03ae7c801facd77a29370b4fae=
c201768915ac14a721ba36f20bc9c209b"
-SRC_URI[rgb-0.8.48.sha256sum] =3D "0f86ae463694029097b846d8f99fd5536740602=
ae00022c0c50c5600720b2f71"
-SRC_URI[rustix-0.38.34.sha256sum] =3D "70dc5ec042f7a43c4a73241207cecc9873a=
06d45debb38b329f8541d85c2730f"
+SRC_URI[redox_syscall-0.5.7.sha256sum] =3D "9b6dfecf2c74bce2466cabf93f6664=
d6998a69eb21e39f4207930065b27b771f"
+SRC_URI[regex-1.11.1.sha256sum] =3D "b544ef1b4eac5dc2db33ea63606ae9ffcfac2=
6c1416a2806ae0bf5f56b201191"
+SRC_URI[regex-automata-0.4.9.sha256sum] =3D "809e8dc61f6de73b46c85f4c96486=
310fe304c434cfa43669d7b40f711150908"
+SRC_URI[regex-syntax-0.8.5.sha256sum] =3D "2b15c43186be67a4fd63bee50d0303a=
fffcef381492ebe2c5d87f324e1b8815c"
+SRC_URI[rgb-0.8.50.sha256sum] =3D "57397d16646700483b67d2dd6511d79318f9d05=
7fdbd21a4066aeac8b41d310a"
+SRC_URI[rustix-0.38.42.sha256sum] =3D "f93dc38ecbab2eb790ff964bb77fa94faf2=
56fd3e73285fd7ba0903b76bedb85"
 SRC_URI[rusty-fork-0.3.0.sha256sum] =3D "cb3dcc6e454c328bb824492db107ab7c0=
ae8fcffe4ad210136ef014458c1bc4f"
 SRC_URI[ryu-1.0.18.sha256sum] =3D "f3cb5ba0dc43242ce17de99c180e96db90b235b=
8a9fdc9543c96d2209116bd9f"
 SRC_URI[safe_arch-0.7.2.sha256sum] =3D "c3460605018fdc9612bce72735cba0d27e=
fbcd9904780d44c7e3a9948f96148a"
 SRC_URI[same-file-1.0.6.sha256sum] =3D "93fc1dc3aaa9bfed95e02e6eadabb4baf7=
e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] =3D "94143f37725109f92c262ed2cf5e59bce=
7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[selectors-0.25.0.sha256sum] =3D "4eb30575f3638fc8f6815f448d50cb1a2=
e255b0897985c8c59f4d37b72a07b06"
-SRC_URI[serde-1.0.204.sha256sum] =3D "bc76f558e0cbb2a839d37354c575f1dc3fdc=
6546b5be373ba43d95f231bf7c12"
-SRC_URI[serde_derive-1.0.204.sha256sum] =3D "e0cd7e117be63d3c3678776753929=
474f3b04a43a080c744d6b0ae2a8c28e222"
-SRC_URI[serde_json-1.0.122.sha256sum] =3D "784b6203951c57ff748476b126ccb5e=
8e2959a5c19e5c617ab1956be3dbc68da"
-SRC_URI[serde_spanned-0.6.7.sha256sum] =3D "eb5b1b31579f3811bf615c14439341=
7496f152e12ac8b7663bf664f4a815306d"
+SRC_URI[serde-1.0.215.sha256sum] =3D "6513c1ad0b11a9376da888e3e0baa0077f1a=
ed55c17f50e7b2397136129fb88f"
+SRC_URI[serde_derive-1.0.215.sha256sum] =3D "ad1e866f866923f252f05c8899879=
93144fb74e722403468a4ebd70c3cd756c0"
+SRC_URI[serde_json-1.0.133.sha256sum] =3D "c7fceb2473b9166b2294ef05efcb65a=
3db80803f0b03ef86a5fc88a2b85ee377"
+SRC_URI[serde_spanned-0.6.8.sha256sum] =3D "87607cb1398ed59d48732e575a4c28=
a7a8ebf2454b964fe3f224f2afc07909e1"
 SRC_URI[servo_arc-0.3.0.sha256sum] =3D "d036d71a959e00c77a63538b90a6c23909=
69f9772b096ea837205c6bd0491a44"
 SRC_URI[shell-words-1.1.0.sha256sum] =3D "24188a676b6ae68c3b2cb3a01be17fbf=
7240ce009799bb56d5b1409051e78fde"
+SRC_URI[shlex-1.3.0.sha256sum] =3D "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3=
524c3cb8fb653a3023f6323e64"
 SRC_URI[simba-0.9.0.sha256sum] =3D "b3a386a501cd104797982c15ae17aafe8b9261=
315b5d07e3ec803f2ea26be0fa"
 SRC_URI[simd-adler32-0.3.7.sha256sum] =3D "d66dc143e6b11c1eddc06d5c423cfc9=
7062865baf299914ab64caa38182078fe"
 SRC_URI[siphasher-0.3.11.sha256sum] =3D "38b58827f4464d87d377d175e90bf58eb=
00fd8716ff0a62f80356b5e61555d0d"
@@ -524,46 +560,47 @@ SRC_URI[static_assertions-1.1.0.sha256sum] =3D "a2eb9=
349b6444b326872e140eb1cf5e7c5
 SRC_URI[string_cache-0.8.7.sha256sum] =3D "f91138e76242f575eb1d3b38b4f1362=
f10d3a43f47d182a5b359af488a02293b"
 SRC_URI[string_cache_codegen-0.5.2.sha256sum] =3D "6bb30289b722be4ff74a408=
c3cc27edeaad656e06cb1fe8fa9231fa59c728988"
 SRC_URI[strsim-0.11.1.sha256sum] =3D "7da8b5736845d9f2fcb837ea5d9e2628564b=
3b043a70948a3f0b778838c5fb4f"
-SRC_URI[syn-2.0.72.sha256sum] =3D "dc4b9b9bf2add8093d3f2c0204471e951b22855=
80335de42f9d2534f3ae7a8af"
+SRC_URI[syn-2.0.90.sha256sum] =3D "919d3b74a5dd0ccd15aeb8f93e7006bd9e14c29=
5087c9896a110f490752bcf31"
+SRC_URI[synstructure-0.13.1.sha256sum] =3D "c8af7666ab7b6390ab78131fb5b0fc=
e11d6b7a6951602017c35fa82800708971"
 SRC_URI[system-deps-6.2.2.sha256sum] =3D "a3e535eb8dded36d55ec13eddacd30de=
c501792ff23a0b1682c38601b8cf2349"
-SRC_URI[system-deps-7.0.1.sha256sum] =3D "6c81f13d9a334a6c242465140bd262fa=
e382b752ff2011c4f7419919a9c97922"
+SRC_URI[system-deps-7.0.3.sha256sum] =3D "66d23aaf9f331227789a99e8de4c91bf=
46703add012bdfd45fdecdfb2975a005"
 SRC_URI[target-lexicon-0.12.16.sha256sum] =3D "61c41af27dd6d1e27b1b16b489d=
b798443478cef1f06a660c96db617ba5de3b1"
-SRC_URI[tempfile-3.12.0.sha256sum] =3D "04cbcdd0c794ebb0d4cf35e88edd2f7d2c=
4c3e9a5a6dab322839b321c6a87a64"
+SRC_URI[tempfile-3.14.0.sha256sum] =3D "28cce251fcbc87fac86a866eeb0d6c2d53=
6fc16d06f184bb61aeae11aa4cee0c"
 SRC_URI[tendril-0.4.3.sha256sum] =3D "d24a120c5fc464a3458240ee02c299ebcb9d=
67b5249c8848b09d639dca8d7bb0"
 SRC_URI[termtree-0.4.1.sha256sum] =3D "3369f5ac52d5eb6ab48c6b4ffdc8efbcad6=
b89c765749064ba298f2c68a16a76"
-SRC_URI[thiserror-1.0.63.sha256sum] =3D "c0342370b38b6a11b6cc11d6a80556995=
8d54cfa061a29969c3b5ce2ea405724"
-SRC_URI[thiserror-impl-1.0.63.sha256sum] =3D "a4558b58466b9ad7ca0f102865ec=
cc95938dca1a74a856f2b57b6629050da261"
-SRC_URI[time-0.3.36.sha256sum] =3D "5dfd88e563464686c916c7e46e623e520ddc6d=
79fa6641390f2e3fa86e83e885"
+SRC_URI[thiserror-1.0.69.sha256sum] =3D "b6aaf5339b578ea85b50e080feb250a3e=
8ae8cfcdff9a461c9ec2904bc923f52"
+SRC_URI[thiserror-impl-1.0.69.sha256sum] =3D "4fee6c4efc90059e10f81e6d42c6=
0a18f76588c3d74cb83a0b242a2b6c7504c1"
+SRC_URI[time-0.3.37.sha256sum] =3D "35e7868883861bd0e56d9ac6efcaaca0d6d5d8=
2a2a7ec8209ff492c07cf37b21"
 SRC_URI[time-core-0.1.2.sha256sum] =3D "ef927ca75afb808a4d64dd374f00a2adf8=
d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.18.sha256sum] =3D "3f252a68540fde3a3877aeea552b832=
b40ab9a69e318efd078774a01ddee1ccf"
+SRC_URI[time-macros-0.2.19.sha256sum] =3D "2834e6017e3e5e4b9834939793b282b=
c03b37a3336245fa820e35e233e2a85de"
+SRC_URI[tinystr-0.7.6.sha256sum] =3D "9117f5d4db391c1cf6927e7bea3db74b9a1c=
1add8f7eda9ffd5364f40f57b82f"
 SRC_URI[tinytemplate-1.2.1.sha256sum] =3D "be4d6b5f19ff7664e8c98d03e2139cb=
510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.8.0.sha256sum] =3D "445e881f4f6d382d5f27c034e25eb92edd7c=
784ceab92a0937db7f2e9471b938"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] =3D "1f3ccbac311fea05f86f61904b462=
b55fb3df8837a366dfc601a0161d0532f20"
 SRC_URI[toml-0.8.19.sha256sum] =3D "a1ed1f98e3fdc28d6d910e6737ae6ab1a93bf1=
985935a1193e68f93eeb68d24e"
 SRC_URI[toml_datetime-0.6.8.sha256sum] =3D "0dd7358ecb8fc2f8d014bf86f6f638=
ce72ba252a2c3a2572f2a795f1d23efb41"
-SRC_URI[toml_edit-0.21.1.sha256sum] =3D "6a8534fd7f78b5405e860340ad6575217=
ce99f38d4d5c8f2442cb5ecb50090e1"
-SRC_URI[toml_edit-0.22.20.sha256sum] =3D "583c44c02ad26b0c3f3066fe629275e5=
0627026c51ac2e595cca4c230ce1ce1d"
+SRC_URI[toml_edit-0.22.22.sha256sum] =3D "4ae48d6208a266e853d946088ed81605=
5e556cc6028c5e8e2b84d9fa5dd7c7f5"
 SRC_URI[typenum-1.17.0.sha256sum] =3D "42ff0bf0c66b8238c6f3b578df37d0b7848=
e55df8577b3f74f92a69acceeb825"
 SRC_URI[unarray-0.1.4.sha256sum] =3D "eaea85b334db583fe3274d12b4cd1880032b=
eab409c0d774be044d4480ab9a94"
-SRC_URI[unicode-bidi-0.3.15.sha256sum] =3D "08f95100a766bf4f8f28f90d77e0a5=
461bbdb219042e7679bebe79004fed8d75"
-SRC_URI[unicode-ident-1.0.12.sha256sum] =3D "3354b9ac3fae1ff6755cb6db53683=
adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-normalization-0.1.23.sha256sum] =3D "a56d1686db2308d901306=
f92a263857ef59ea39678a5458e7cb17f01415101f5"
-SRC_URI[url-2.5.2.sha256sum] =3D "22784dbdf76fdde8af1aeda5622b546b422b6fc5=
85325248a2bf9f5e41e94d6c"
+SRC_URI[unicode-ident-1.0.14.sha256sum] =3D "adb9e6ca4f869e1180728b7950e35=
922a7fc6397f7b641499e8f3ef06e50dc83"
+SRC_URI[url-2.5.4.sha256sum] =3D "32f8b686cadd1473f4bd0117a5d28d36b1ade384=
ea9b5069a1c40aefed7fda60"
 SRC_URI[utf-8-0.7.6.sha256sum] =3D "09cc8ee72d2a9becf2f2febe0205bbed8fc661=
5b7cb429ad062dc7b7ddd036a9"
+SRC_URI[utf16_iter-1.0.5.sha256sum] =3D "c8232dd3cdaed5356e0f716d285e4b40b=
932ac434100fe9b7e0e8e935b9e6246"
+SRC_URI[utf8_iter-1.0.4.sha256sum] =3D "b6c140620e7ffbb22c2dee59cafe6084a5=
9b5ffc27a8859a5f0d494b5d52b6be"
 SRC_URI[utf8parse-0.2.2.sha256sum] =3D "06abde3611657adf66d383f00b093d7fae=
cc7fa57071cce2578660c9f1010821"
 SRC_URI[version-compare-0.2.0.sha256sum] =3D "852e951cb7832cb45cb1169900d1=
9760cfa39b82bc0ea9c0e5a14ae88411c98b"
 SRC_URI[version_check-0.9.5.sha256sum] =3D "0b928f33d975fc6ad9f86c8f283853=
ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[wait-timeout-0.2.0.sha256sum] =3D "9f200f5b12eb75f8c1ed65abd4b2db8=
a6e1b138a20de009dacee265a2498f3f6"
 SRC_URI[walkdir-2.5.0.sha256sum] =3D "29790946404f91d9c5d06f9874efddea1dc0=
6c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] =3D "9c8d87e72b64a3b=
4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.92.sha256sum] =3D "4be2531df63900aeb2bca0daaaddec=
08491ee64ceecbee5076636a3b026795a8"
-SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] =3D "614d787b966d3989fa7bb9=
8a654e369c762374fd3213d212cfc0251257e747da"
-SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] =3D "a1f8823de937b71b9460c0c3=
4e25f3da88250760bec0ebac694b49997550d726"
-SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] =3D "e94f17b526d0a461=
a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
-SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] =3D "af190c94f2773fdb3729c55=
b007a722abb5384da03bc0986df4c289bf5567e96"
-SRC_URI[web-sys-0.3.69.sha256sum] =3D "77afa9a11836342370f4817622a2f0f418b=
134426d91a82dfb48f532d2ec13ef"
+SRC_URI[wasm-bindgen-0.2.99.sha256sum] =3D "a474f6281d1d70c17ae7aa6a613c87=
fce69a127e2624002df63dcb39d6cf6396"
+SRC_URI[wasm-bindgen-backend-0.2.99.sha256sum] =3D "5f89bb38646b4f81674e8f=
5c3fb81b562be1fd936d84320f3264486418519c79"
+SRC_URI[wasm-bindgen-macro-0.2.99.sha256sum] =3D "2cc6181fd9a7492eef6fef1f=
33961e3695e4579b9872a6f7c83aee556666d4fe"
+SRC_URI[wasm-bindgen-macro-support-0.2.99.sha256sum] =3D "30d7a95b763d3c45=
903ed6c81f156801839e5ee968bb07e534c44df0fcd330c2"
+SRC_URI[wasm-bindgen-shared-0.2.99.sha256sum] =3D "943aab3fdaaa029a6e0271b=
35ea10b72b943135afe9bffca82384098ad0e06a6"
+SRC_URI[web-sys-0.3.76.sha256sum] =3D "04dd7223427d52553d3702c004d3b2fe07c=
148165faa56313cb00211e31c12bc"
 SRC_URI[weezl-0.1.8.sha256sum] =3D "53a85b86a771b1c87058196170769dd264f66c=
0782acf1ae6cc51bfd64b39082"
-SRC_URI[wide-0.7.26.sha256sum] =3D "901e8597c777fa042e9e245bd56c0dc4418c5d=
b3f845b6ff94fbac732c6a0692"
+SRC_URI[wide-0.7.30.sha256sum] =3D "58e6db2670d2be78525979e9a5f9c69d296fd7=
d670549fe9ebf70f8708cb5019"
 SRC_URI[winapi-0.3.9.sha256sum] =3D "5c839a674fcd7a98952e593242ea400abe939=
92746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] =3D "ac3b87c63620426dd=
9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.9.sha256sum] =3D "cf221c93e13a30d793f7645a0e7762c5=
5d169dbb0a49671918a2319d289b10bb"
@@ -580,11 +617,18 @@ SRC_URI[windows_i686_msvc-0.52.6.sha256sum] =3D "2409=
48bc05c5e7c6dabba28bf89d89ffc
 SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] =3D "147a5c80aabfbf0c7d901cb5=
895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] =3D "24d5b23dc41741267968=
1396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] =3D "589f6da84c646204747d127=
0a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[winnow-0.5.40.sha256sum] =3D "f593a95398737aeed53e489c785df13f3618=
e41dbcd6718c6addbf1395aa6876"
-SRC_URI[winnow-0.6.18.sha256sum] =3D "68a9bda4691f099d435ad181000724da8e58=
99daa10713c2d432552b9ccd3a6f"
+SRC_URI[winnow-0.6.20.sha256sum] =3D "36c1fec1a2bb5866f07c25f68c26e565c4c2=
00aebb96d7e55710c19d3e8ac49b"
+SRC_URI[write16-1.0.0.sha256sum] =3D "d1890f4022759daae28ed4fe62859b1236ca=
ebfc61ede2f63ed4e695f3f6d936"
+SRC_URI[writeable-0.5.5.sha256sum] =3D "1e9df38ee2d2c3c5948ea468a8406ff0db=
0b29ae1ffde1bcf20ef305bcc95c51"
 SRC_URI[xml5ever-0.18.1.sha256sum] =3D "9bbb26405d8e919bc1547a5aa9abc95cbf=
a438f04844f5fdd9dc7596b748bf69"
 SRC_URI[yeslogic-fontconfig-sys-6.0.0.sha256sum] =3D "503a066b4c037c440169=
d995b869046827dbc71263f6e8f3be6d77d4f3229dbd"
+SRC_URI[yoke-0.7.5.sha256sum] =3D "120e6aef9aa629e3d4f52dc8cc43a015c772419=
4c97dfaf45180d2daf2b77f40"
+SRC_URI[yoke-derive-0.7.5.sha256sum] =3D "2380878cad4ac9aac1e2435f3eb4020e=
8374b5f13c296cb75b4620ff8e229154"
 SRC_URI[zerocopy-0.7.35.sha256sum] =3D "1b9b4fd18abc82b8136838da5d50bae7bd=
ea537c574d8dc1a34ed098d6c166f0"
 SRC_URI[zerocopy-derive-0.7.35.sha256sum] =3D "fa4f8080344d4671fb4e831a13a=
d1e68092748387dfc4f55e356242fae12ce3e"
+SRC_URI[zerofrom-0.1.5.sha256sum] =3D "cff3ee08c995dee1859d998dea82f7374f2=
826091dd9cd47def953cae446cd2e"
+SRC_URI[zerofrom-derive-0.1.5.sha256sum] =3D "595eed982f7d355beb85837f651f=
a22e90b3c044842dc7f2c2842c086f295808"
+SRC_URI[zerovec-0.10.4.sha256sum] =3D "aa2b893d79df23bfb12d5461018d408ea19=
dfafe76c2c7ef6d4eba614f8ff079"
+SRC_URI[zerovec-derive-0.10.3.sha256sum] =3D "6eafa6dfb17584ea3e2bd6e76e0c=
c15ad7af12b09abdd1ca55961bed9b1063c6"
 SRC_URI[zune-core-0.4.12.sha256sum] =3D "3f423a2c17029964870cfaabb1f13dfab=
7d092a62a29a89264f4d36990ca414a"
-SRC_URI[zune-jpeg-0.4.13.sha256sum] =3D "16099418600b4d8f028622f73ff6e3dea=
abdff330fb9a2a131dea781ee8b0768"
+SRC_URI[zune-jpeg-0.4.14.sha256sum] =3D "99a5bab8d7dedf81405c4bb1f2b83ea05=
7643d9cb28778cea9eecddeedd2e028"
diff --git a/recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-f=
orce-disable-gdk-pixbuf-l.patch b/recipes-gnome/librsvg/librsvg/0001-Revert=
-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
new file mode 100644
index 0000000..5ff2e00
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-di=
sable-gdk-pixbuf-l.patch
@@ -0,0 +1,49 @@
+From 275edeb3794ca5581452a178fd111d0383c2f04e Mon Sep 17 00:00:00 2001
+From: Gyorgy Sarvari <skandigraun@gmail.com>
+Date: Wed, 6 Aug 2025 13:50:21 +0200
+Subject: [PATCH] Revert "meson.build: do not force-disable gdk-pixbuf-load=
er
+ in cross builds"
+
+This reverts commit 994582cfa995d00f9472dc22f8237b6571b4c510.
+
+The commit that enabled gdk-pixbuf-loader for non-cross builds, references
+a commit that enabled other binaries, claiming that they can be executed w=
ith
+a qemu wrapper.
+
+There is one difference - the projects that were enabled by that commit su=
pport such
+wrappers officially (see `gi_cross_binary_wrapper` and related build optio=
ns for g-i).
+However such support is missing from gdk-pixbuf-loader unfortunately, whic=
h can cause
+build failures when cross compiling.
+
+To avoid this, revert back to disable gdk-pixbuf-loader for cross-builds
+(until it gains a similar feature).
+
+Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1123]
+
+Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
+---
+ gdk-pixbuf-loader/meson.build | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
+index 6fa10a68..c51d8031 100644
+--- a/gdk-pixbuf-loader/meson.build
++++ b/gdk-pixbuf-loader/meson.build
+@@ -36,7 +36,7 @@ pixbuf_thumbnailer =3D configure_file(
+   install_dir: get_option('datadir') / 'thumbnailers'
+ )
+=20
+-if meson.can_run_host_binaries()
++if not meson.is_cross_build()
+   gdk_pixbuf_query_loaders =3D find_program(pixbuf_dep.get_variable(pkgco=
nfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'=
))
+ endif
+=20
+@@ -48,7 +48,7 @@ pixbufloader_svg_install_args =3D [
+ ]
+=20
+ # Tell people to run gdk-pixbuf-query-loaders manually for cross builds
+-if not meson.can_run_host_binaries()
++if meson.is_cross_build()
+   pixbufloader_svg_install_args +=3D '--show-cross-message'
+ endif
+=20
diff --git a/recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.bui=
ld-do-not-look-for-gdk-pi.patch b/recipes-gnome/librsvg/librsvg/0001-gdk-pi=
xbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
deleted file mode 100644
index 9b8468f..0000000
--- a/recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-n=
ot-look-for-gdk-pi.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 57f98688e46b128f7767479ef373e8cb5e3304b8 Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Wed, 27 Nov 2024 16:34:06 +0100
-Subject: [PATCH] gdk-pixbuf-loader/meson.build: do not look for
- gdk-pixbuf-query-loaders
-
-Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1061]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- gdk-pixbuf-loader/meson.build | 2 --
- 1 file changed, 2 deletions(-)
-
-diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
-index 5081844..4ae58c6 100644
---- a/gdk-pixbuf-loader/meson.build
-+++ b/gdk-pixbuf-loader/meson.build
-@@ -36,8 +36,6 @@ pixbuf_thumbnailer =3D configure_file(
-   install_dir: get_option('datadir') / 'thumbnailers'=0D
- )=0D
- =0D
--gdk_pixbuf_query_loaders =3D find_program(pixbuf_dep.get_variable(pkgconf=
ig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'))=
=0D
--=0D
- pixbufloader_svg_install_args =3D [=0D
-   '--gdk-pixbuf-moduledir',=0D
-   pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_de=
fine: ['prefix', prefix]),=0D
---=20
-2.39.5
-
diff --git a/recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-di=
sable-introspection-and-v.patch b/recipes-gnome/librsvg/librsvg/0001-meson.=
build-do-not-force-disable-introspection-and-v.patch
deleted file mode 100644
index f33e90a..0000000
--- a/recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-i=
ntrospection-and-v.patch
+++ /dev/null
@@ -1,34 +0,0 @@
-From 57d02c05184ae565ef8182c7151c1faa97d45b2b Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Wed, 27 Nov 2024 16:28:49 +0100
-Subject: [PATCH] meson.build: do not force-disable introspection and vala =
in
- cross builds
-
-It is entirely possible to make them work through qemu wrappers
-(and g-i has upstream support for it).
-
-Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1062]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- meson.build | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/meson.build b/meson.build
-index 12cb44f..2dae10c 100644
---- a/meson.build
-+++ b/meson.build
-@@ -160,9 +160,9 @@ endif
- if host_system =3D=3D 'windows'
-   build_gir =3D get_option('introspection').require(get_option('default_l=
ibrary') !=3D 'static' and not meson.is_cross_build() and gi_dep.found())
- else
--  build_gir =3D get_option('introspection').require(not meson.is_cross_bu=
ild() and gi_dep.found())
-+  build_gir =3D get_option('introspection').require(gi_dep.found())
- endif
--build_vala =3D get_option('vala').require(not meson.is_cross_build() and =
vapigen_dep.found())
-+build_vala =3D get_option('vala').require(vapigen_dep.found())
-=20
- build_pixbuf_loader =3D get_option('pixbuf-loader').require(pixbuf_dep.fo=
und())
-=20
---=20
-2.39.5
-
diff --git a/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAG=
S-to-rustc-executable.patch b/recipes-gnome/librsvg/librsvg/0001-query-rust=
c-append-RUSTFLAGS-to-rustc-executable.patch
new file mode 100644
index 0000000..9783ae7
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-ru=
stc-executable.patch
@@ -0,0 +1,37 @@
+From 297d3c709027467468aeb908e72d4d09cfb9ee91 Mon Sep 17 00:00:00 2001
+From: Gyorgy Sarvari <skandigraun@gmail.com>
+Date: Sat, 2 Aug 2025 20:57:49 +0200
+Subject: [PATCH] query-rustc: append RUSTFLAGS to rustc executable
+
+The RUSTFLAGS environment variable is parsed by cargo, however the
+query-rustc script invokes rustc directly, in which case these
+flags are ignored, which can cause build failures in case
+the target specification is not in the target location, and is specified
+amongst the RUSTFLAGS.
+
+This change appends the content of RUSTFLAGS environment variable
+to the rustc command, if it's not empty, when the static native
+libraries are queried.
+
+Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge=
_requests/1121]
+
+Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
+---
+ meson/query-rustc.py | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/meson/query-rustc.py b/meson/query-rustc.py
+index f97cb692..fc7369a8 100755
+--- a/meson/query-rustc.py
++++ b/meson/query-rustc.py
+@@ -78,6 +78,10 @@ if __name__ =3D=3D "__main__":
+=20=20=20=20=20=20=20=20=20
+     if query =3D=3D 'native-static-libs':
+         query_arg =3D ['--print=3D%s' % query]
++        rustflags =3D os.getenv('RUSTFLAGS')
++        if rustflags:
++            rustc_cmd.extend(rustflags.split())
++
+     else:
+         query_arg =3D ['--version', '--verbose']
+     rustc_cmd.extend(query_arg)
diff --git a/recipes-gnome/librsvg/librsvg_2.59.2.bb b/recipes-gnome/librsv=
g/librsvg_2.60.0.bb
similarity index 90%
rename from recipes-gnome/librsvg/librsvg_2.59.2.bb
rename to recipes-gnome/librsvg/librsvg_2.60.0.bb
index 7718f2b..c9f223c 100644
--- a/recipes-gnome/librsvg/librsvg_2.59.2.bb
+++ b/recipes-gnome/librsvg/librsvg_2.60.0.bb
@@ -7,8 +7,7 @@ HOMEPAGE =3D "https://gitlab.gnome.org/GNOME/librsvg"
 BUGTRACKER =3D "https://gitlab.gnome.org/GNOME/librsvg/issues"
=20
 LICENSE =3D "LGPL-2.1-or-later"
-LIC_FILES_CHKSUM =3D "file://COPYING.LIB;md5=3D4fbd65380cdd255951079008b36=
4516c \
-                   "
+LIC_FILES_CHKSUM =3D "file://COPYING.LIB;md5=3D4fbd65380cdd255951079008b36=
4516c"
=20
 SECTION =3D "x11/utils"
 DEPENDS =3D "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-nati=
ve cargo-c-native"
@@ -23,9 +22,9 @@ GIDOCGEN_MESON_DISABLE_FLAG =3D 'disabled'
=20
 require ${BPN}-crates.inc
=20
-SRC_URI +=3D "file://0001-meson.build-do-not-force-disable-introspection-a=
nd-v.patch \
-            file://0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-=
pi.patch"
-SRC_URI[archive.sha256sum] =3D "ecd293fb0cc338c170171bbc7bcfbea6725d041c95=
f31385dc935409933e4597"
+SRC_URI +=3D "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable=
.patch \
+            file://0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf=
-l.patch"
+SRC_URI[archive.sha256sum] =3D "0b6ffccdf6e70afc9876882f5d2ce9ffcf2c713cba=
af1ad90170daa752e1eec3"
=20
 UPSTREAM_CHECK_REGEX =3D "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
=20
@@ -54,8 +53,6 @@ do_compile:prepend() {
     sed -ie 's,"linker": ".*","linker": "${RUST_TARGET_CC}",g' ${RUST_TARG=
ETS_DIR}/${RUST_HOST_SYS}.json
 }
=20
-CVE_STATUS[CVE-2018-1000041] =3D "not-applicable-platform: Issue only appl=
ies on Windows"
-
 EXTRA_OEMESON =3D "-Dtriplet=3D${RUST_HOST_SYS}"
 LDFLAGS +=3D " -L${B}/rsvg"
 # needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym=
'' errors
--=20
2.50.1


