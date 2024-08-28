Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751FC6FD3A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.5965.1724875795121910040
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DvaKCOLI;
 spf=pass (domain: konsulko.com, ip: 209.85.166.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81fb419f77bso393914239f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875794; x=1725480594; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HT6VbsyyNT75/l1aobBXwrUs/rMJAk336L6JHFc3Xg=;
        b=DvaKCOLIuWnClhrj6UMe6NEWGLxIJ8bxt3+N9ssCr2qjBBPpor2qH/fd+K2khKchw2
         YyU3EQ+G0xdDLpgSCpLizAHJqKcKK87qPx3l1kZpXC+UAh8uP7Qf0i6mz2ZwVkcwAHpx
         8FTbh7d+612rZsIBkPcUHO962CDnEMadyw70s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875794; x=1725480594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HT6VbsyyNT75/l1aobBXwrUs/rMJAk336L6JHFc3Xg=;
        b=nYDar8hVUqTuoMmwW/Qu1xHMQ35frRZapDNLypbO93/Ajophr6R+zWtJ2VfI5RRK8L
         8SWfDbG9x4GGRMn3k/2zhXsEoTcLv7Ik2OZc75iXRtNo658uZW0ArfwT57Oi4XB16sMw
         Xe1NODTETX+XlfnVpPfWcdZCQEFHH9XAsUsLKJAnd5rhWNqyMVnUbEJfU1zV8ibhYB8a
         Jhb6i6maR+peOaHNw55f6QA+7w3s05TXC6v2MmpX4LktRP+KqQdT+gWviyc0gk9sBh63
         onPpY/e3H3PWvJX478BE2r8IPiELHJ+9aeVO85s4/kVR4eUOLDfBoHu5KyDC+pqv3KBV
         HSGA==
X-Gm-Message-State: AOJu0YwU7bkKEyU1dYwkU2/ZblXndT69Rs1i8hSdzKTOVCiccehdEmuW
	3b7CQeLId99P/vvSgR5L0Zlc5sloZM3JtlHUPBb09yQdHg2WhXzqWurU5dxvIy0Bmj+jy6A6sWm
	B
X-Google-Smtp-Source: AGHT+IEeU09fmNotfed4r3etsrR/D2bz9Z1lZHdSe4ZCxEGje7aGgEKkpY/qzxs76pPkqKNqFLJxRQ==
X-Received: by 2002:a05:6602:1485:b0:81f:880d:ec18 with SMTP id ca18e2360f4ac-82a10e140cemr71293939f.3.1724875792292;
        Wed, 28 Aug 2024 13:09:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 05/33] librsvg: upgrade 2.56.3 -> 2.57.1
Date: Wed, 28 Aug 2024 16:08:51 -0400
Message-ID: <464426858eb8ccf5b1057e0230bdcada0684db5b.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/574

From: Alexander Kanavin <alex.kanavin@gmail.com>

Drop 0001-Add-riscv32-support.patch
(merged upstream).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2d53ba395affdd2b4e5eb2abe105a78ddcc51ddb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      |  696 ++++----
 .../librsvg/0001-Add-riscv32-support.patch    | 1511 -----------------
 ...-rust-target-to-cargo-also-when-not-.patch |   13 +-
 .../{librsvg_2.56.3.bb => librsvg_2.57.1.bb}  |    6 +-
 4 files changed, 326 insertions(+), 1900 deletions(-)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Add-riscv32-support.patch
 rename recipes-gnome/librsvg/{librsvg_2.56.3.bb => librsvg_2.57.1.bb} (91%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 5886f3d..94eba30 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -3,604 +3,544 @@
 # from Cargo.lock
 SRC_URI += " \
     crate://crates.io/adler/1.0.2 \
-    crate://crates.io/aho-corasick/1.0.2 \
+    crate://crates.io/aho-corasick/1.1.2 \
     crate://crates.io/android-tzdata/0.1.1 \
     crate://crates.io/android_system_properties/0.1.5 \
     crate://crates.io/anes/0.1.6 \
-    crate://crates.io/anstream/0.3.2 \
-    crate://crates.io/anstyle/1.0.1 \
-    crate://crates.io/anstyle-parse/0.2.1 \
-    crate://crates.io/anstyle-query/1.0.0 \
-    crate://crates.io/anstyle-wincon/1.0.1 \
-    crate://crates.io/anyhow/1.0.72 \
+    crate://crates.io/anstream/0.6.5 \
+    crate://crates.io/anstyle/1.0.4 \
+    crate://crates.io/anstyle-parse/0.2.3 \
+    crate://crates.io/anstyle-query/1.0.2 \
+    crate://crates.io/anstyle-wincon/3.0.2 \
+    crate://crates.io/anyhow/1.0.75 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.0.11 \
-    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/assert_cmd/2.0.12 \
     crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/base-x/0.2.11 \
     crate://crates.io/bit-set/0.5.3 \
     crate://crates.io/bit-vec/0.6.3 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.3.3 \
+    crate://crates.io/bitflags/2.4.1 \
     crate://crates.io/block/0.1.6 \
-    crate://crates.io/bstr/1.6.0 \
-    crate://crates.io/bumpalo/3.13.0 \
-    crate://crates.io/bytemuck/1.13.1 \
-    crate://crates.io/byteorder/1.4.3 \
-    crate://crates.io/cairo-rs/0.17.10 \
-    crate://crates.io/cairo-sys-rs/0.17.10 \
+    crate://crates.io/bstr/1.8.0 \
+    crate://crates.io/bumpalo/3.14.0 \
+    crate://crates.io/bytemuck/1.14.0 \
+    crate://crates.io/byteorder/1.5.0 \
+    crate://crates.io/cairo-rs/0.18.3 \
+    crate://crates.io/cairo-sys-rs/0.18.2 \
     crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cc/1.0.79 \
-    crate://crates.io/cfg-expr/0.15.3 \
+    crate://crates.io/cc/1.0.83 \
+    crate://crates.io/cfg-expr/0.15.5 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/chrono/0.4.26 \
+    crate://crates.io/chrono/0.4.31 \
     crate://crates.io/ciborium/0.2.1 \
     crate://crates.io/ciborium-io/0.2.1 \
     crate://crates.io/ciborium-ll/0.2.1 \
-    crate://crates.io/clap/3.2.25 \
-    crate://crates.io/clap/4.3.17 \
-    crate://crates.io/clap_builder/4.3.17 \
-    crate://crates.io/clap_complete/4.3.2 \
-    crate://crates.io/clap_derive/4.3.12 \
-    crate://crates.io/clap_lex/0.2.4 \
-    crate://crates.io/clap_lex/0.5.0 \
+    crate://crates.io/clap/4.4.11 \
+    crate://crates.io/clap_builder/4.4.11 \
+    crate://crates.io/clap_complete/4.4.4 \
+    crate://crates.io/clap_derive/4.4.7 \
+    crate://crates.io/clap_lex/0.6.0 \
     crate://crates.io/colorchoice/1.0.0 \
     crate://crates.io/const-cstr/0.3.0 \
-    crate://crates.io/const_fn/0.4.9 \
-    crate://crates.io/convert_case/0.4.0 \
-    crate://crates.io/core-foundation-sys/0.8.4 \
+    crate://crates.io/core-foundation-sys/0.8.6 \
     crate://crates.io/crc32fast/1.3.2 \
-    crate://crates.io/criterion/0.4.0 \
+    crate://crates.io/criterion/0.5.1 \
     crate://crates.io/criterion-plot/0.5.0 \
-    crate://crates.io/crossbeam-channel/0.5.8 \
-    crate://crates.io/crossbeam-deque/0.8.3 \
-    crate://crates.io/crossbeam-epoch/0.9.15 \
-    crate://crates.io/crossbeam-utils/0.8.16 \
-    crate://crates.io/cssparser/0.29.6 \
+    crate://crates.io/crossbeam-deque/0.8.4 \
+    crate://crates.io/crossbeam-epoch/0.9.16 \
+    crate://crates.io/crossbeam-utils/0.8.17 \
+    crate://crates.io/cssparser/0.31.2 \
     crate://crates.io/cssparser-macros/0.6.1 \
-    crate://crates.io/data-url/0.2.0 \
+    crate://crates.io/cstr/0.2.11 \
+    crate://crates.io/data-url/0.3.1 \
+    crate://crates.io/deranged/0.3.10 \
     crate://crates.io/derive_more/0.99.17 \
     crate://crates.io/difflib/0.4.0 \
-    crate://crates.io/discard/1.0.4 \
     crate://crates.io/dlib/0.5.2 \
     crate://crates.io/doc-comment/0.3.3 \
     crate://crates.io/dtoa/1.0.9 \
     crate://crates.io/dtoa-short/0.3.4 \
-    crate://crates.io/either/1.8.1 \
-    crate://crates.io/encoding/0.2.33 \
-    crate://crates.io/encoding-index-japanese/1.20141219.5 \
-    crate://crates.io/encoding-index-korean/1.20141219.5 \
-    crate://crates.io/encoding-index-simpchinese/1.20141219.5 \
-    crate://crates.io/encoding-index-singlebyte/1.20141219.5 \
-    crate://crates.io/encoding-index-tradchinese/1.20141219.5 \
-    crate://crates.io/encoding_index_tests/0.1.4 \
-    crate://crates.io/encoding_rs/0.8.32 \
+    crate://crates.io/either/1.9.0 \
+    crate://crates.io/encoding_rs/0.8.33 \
     crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/errno/0.3.1 \
-    crate://crates.io/errno-dragonfly/0.1.2 \
-    crate://crates.io/fastrand/2.0.0 \
-    crate://crates.io/fdeflate/0.3.0 \
-    crate://crates.io/flate2/1.0.26 \
+    crate://crates.io/errno/0.3.8 \
+    crate://crates.io/fastrand/2.0.1 \
+    crate://crates.io/fdeflate/0.3.1 \
+    crate://crates.io/flate2/1.0.28 \
     crate://crates.io/float-cmp/0.9.0 \
     crate://crates.io/fnv/1.0.7 \
-    crate://crates.io/form_urlencoded/1.2.0 \
+    crate://crates.io/form_urlencoded/1.2.1 \
     crate://crates.io/futf/0.1.5 \
-    crate://crates.io/futures-channel/0.3.28 \
-    crate://crates.io/futures-core/0.3.28 \
-    crate://crates.io/futures-executor/0.3.28 \
-    crate://crates.io/futures-io/0.3.28 \
-    crate://crates.io/futures-macro/0.3.28 \
-    crate://crates.io/futures-task/0.3.28 \
-    crate://crates.io/futures-util/0.3.28 \
+    crate://crates.io/futures-channel/0.3.29 \
+    crate://crates.io/futures-core/0.3.29 \
+    crate://crates.io/futures-executor/0.3.29 \
+    crate://crates.io/futures-io/0.3.29 \
+    crate://crates.io/futures-macro/0.3.29 \
+    crate://crates.io/futures-task/0.3.29 \
+    crate://crates.io/futures-util/0.3.29 \
     crate://crates.io/fxhash/0.2.1 \
-    crate://crates.io/gdk-pixbuf/0.17.10 \
-    crate://crates.io/gdk-pixbuf-sys/0.17.10 \
-    crate://crates.io/getrandom/0.1.16 \
-    crate://crates.io/getrandom/0.2.10 \
-    crate://crates.io/gio/0.17.10 \
-    crate://crates.io/gio-sys/0.17.10 \
-    crate://crates.io/glib/0.17.10 \
-    crate://crates.io/glib-macros/0.17.10 \
-    crate://crates.io/glib-sys/0.17.10 \
-    crate://crates.io/gobject-sys/0.17.10 \
+    crate://crates.io/gdk-pixbuf/0.18.3 \
+    crate://crates.io/gdk-pixbuf-sys/0.18.0 \
+    crate://crates.io/getrandom/0.2.11 \
+    crate://crates.io/gio/0.18.4 \
+    crate://crates.io/gio-sys/0.18.1 \
+    crate://crates.io/glib/0.18.4 \
+    crate://crates.io/glib-macros/0.18.3 \
+    crate://crates.io/glib-sys/0.18.1 \
+    crate://crates.io/gobject-sys/0.18.0 \
     crate://crates.io/half/1.8.2 \
-    crate://crates.io/hashbrown/0.12.3 \
-    crate://crates.io/hashbrown/0.14.0 \
+    crate://crates.io/hashbrown/0.14.3 \
     crate://crates.io/heck/0.4.1 \
-    crate://crates.io/hermit-abi/0.1.19 \
-    crate://crates.io/hermit-abi/0.3.2 \
-    crate://crates.io/iana-time-zone/0.1.57 \
+    crate://crates.io/hermit-abi/0.3.3 \
+    crate://crates.io/iana-time-zone/0.1.58 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/idna/0.4.0 \
-    crate://crates.io/indexmap/1.9.3 \
-    crate://crates.io/indexmap/2.0.0 \
+    crate://crates.io/idna/0.5.0 \
+    crate://crates.io/indexmap/2.1.0 \
     crate://crates.io/is-terminal/0.4.9 \
     crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itoa/1.0.9 \
-    crate://crates.io/js-sys/0.3.64 \
+    crate://crates.io/itertools/0.11.0 \
+    crate://crates.io/itoa/1.0.10 \
+    crate://crates.io/js-sys/0.3.66 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.147 \
-    crate://crates.io/libloading/0.8.0 \
-    crate://crates.io/libm/0.2.7 \
+    crate://crates.io/libc/0.2.151 \
+    crate://crates.io/libloading/0.8.1 \
+    crate://crates.io/libm/0.2.8 \
     crate://crates.io/linked-hash-map/0.5.6 \
-    crate://crates.io/linux-raw-sys/0.4.3 \
+    crate://crates.io/linux-raw-sys/0.4.12 \
     crate://crates.io/locale_config/0.3.0 \
-    crate://crates.io/lock_api/0.4.10 \
-    crate://crates.io/log/0.4.19 \
-    crate://crates.io/lopdf/0.29.0 \
+    crate://crates.io/lock_api/0.4.11 \
+    crate://crates.io/log/0.4.20 \
+    crate://crates.io/lopdf/0.31.0 \
     crate://crates.io/mac/0.1.1 \
     crate://crates.io/malloc_buf/0.0.6 \
     crate://crates.io/markup5ever/0.11.0 \
     crate://crates.io/matches/0.1.10 \
-    crate://crates.io/matrixmultiply/0.3.7 \
-    crate://crates.io/memchr/2.5.0 \
+    crate://crates.io/matrixmultiply/0.3.8 \
+    crate://crates.io/md5/0.7.0 \
+    crate://crates.io/memchr/2.6.4 \
     crate://crates.io/memoffset/0.9.0 \
+    crate://crates.io/minimal-lexical/0.2.1 \
     crate://crates.io/miniz_oxide/0.7.1 \
     crate://crates.io/nalgebra/0.32.3 \
     crate://crates.io/nalgebra-macros/0.2.1 \
     crate://crates.io/new_debug_unreachable/1.0.4 \
-    crate://crates.io/nodrop/0.1.14 \
+    crate://crates.io/nom/7.1.3 \
     crate://crates.io/normalize-line-endings/0.3.0 \
-    crate://crates.io/num-complex/0.4.3 \
+    crate://crates.io/num-complex/0.4.4 \
     crate://crates.io/num-integer/0.1.45 \
     crate://crates.io/num-rational/0.4.1 \
-    crate://crates.io/num-traits/0.2.15 \
-    crate://crates.io/num_cpus/1.16.0 \
+    crate://crates.io/num-traits/0.2.17 \
     crate://crates.io/objc/0.2.7 \
     crate://crates.io/objc-foundation/0.1.1 \
     crate://crates.io/objc_id/0.1.1 \
-    crate://crates.io/once_cell/1.18.0 \
+    crate://crates.io/once_cell/1.19.0 \
     crate://crates.io/oorandom/11.1.3 \
-    crate://crates.io/os_str_bytes/6.5.1 \
-    crate://crates.io/pango/0.17.10 \
-    crate://crates.io/pango-sys/0.17.10 \
-    crate://crates.io/pangocairo/0.17.10 \
-    crate://crates.io/pangocairo-sys/0.17.10 \
+    crate://crates.io/pango/0.18.3 \
+    crate://crates.io/pango-sys/0.18.0 \
+    crate://crates.io/pangocairo/0.18.0 \
+    crate://crates.io/pangocairo-sys/0.18.0 \
     crate://crates.io/parking_lot/0.12.1 \
-    crate://crates.io/parking_lot_core/0.9.8 \
+    crate://crates.io/parking_lot_core/0.9.9 \
     crate://crates.io/paste/1.0.14 \
-    crate://crates.io/percent-encoding/2.3.0 \
-    crate://crates.io/phf/0.8.0 \
+    crate://crates.io/percent-encoding/2.3.1 \
     crate://crates.io/phf/0.10.1 \
-    crate://crates.io/phf_codegen/0.8.0 \
+    crate://crates.io/phf/0.11.2 \
     crate://crates.io/phf_codegen/0.10.0 \
-    crate://crates.io/phf_generator/0.8.0 \
     crate://crates.io/phf_generator/0.10.0 \
-    crate://crates.io/phf_macros/0.10.0 \
-    crate://crates.io/phf_shared/0.8.0 \
+    crate://crates.io/phf_generator/0.11.2 \
+    crate://crates.io/phf_macros/0.11.2 \
     crate://crates.io/phf_shared/0.10.0 \
-    crate://crates.io/pin-project-lite/0.2.10 \
+    crate://crates.io/phf_shared/0.11.2 \
+    crate://crates.io/pin-project-lite/0.2.13 \
     crate://crates.io/pin-utils/0.1.0 \
     crate://crates.io/pkg-config/0.3.27 \
     crate://crates.io/plotters/0.3.5 \
     crate://crates.io/plotters-backend/0.3.5 \
     crate://crates.io/plotters-svg/0.3.5 \
-    crate://crates.io/png/0.17.9 \
-    crate://crates.io/pom/3.3.0 \
+    crate://crates.io/png/0.17.10 \
+    crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/precomputed-hash/0.1.1 \
-    crate://crates.io/predicates/2.1.5 \
-    crate://crates.io/predicates/3.0.3 \
+    crate://crates.io/predicates/3.0.4 \
     crate://crates.io/predicates-core/1.0.6 \
     crate://crates.io/predicates-tree/1.0.9 \
-    crate://crates.io/proc-macro-crate/1.3.1 \
+    crate://crates.io/proc-macro-crate/2.0.1 \
     crate://crates.io/proc-macro-error/1.0.4 \
     crate://crates.io/proc-macro-error-attr/1.0.4 \
-    crate://crates.io/proc-macro-hack/0.5.20+deprecated \
-    crate://crates.io/proc-macro2/1.0.66 \
-    crate://crates.io/proptest/1.2.0 \
+    crate://crates.io/proc-macro2/1.0.70 \
+    crate://crates.io/proptest/1.4.0 \
     crate://crates.io/quick-error/1.2.3 \
-    crate://crates.io/quote/1.0.31 \
-    crate://crates.io/rand/0.7.3 \
+    crate://crates.io/quick-error/2.0.1 \
+    crate://crates.io/quote/1.0.33 \
     crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_chacha/0.2.2 \
     crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.5.1 \
     crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/rand_hc/0.2.0 \
-    crate://crates.io/rand_pcg/0.2.1 \
     crate://crates.io/rand_xorshift/0.3.0 \
     crate://crates.io/rawpointer/0.2.1 \
-    crate://crates.io/rayon/1.7.0 \
-    crate://crates.io/rayon-core/1.11.0 \
+    crate://crates.io/rayon/1.8.0 \
+    crate://crates.io/rayon-core/1.12.0 \
     crate://crates.io/rctree/0.5.0 \
-    crate://crates.io/redox_syscall/0.3.5 \
-    crate://crates.io/regex/1.9.1 \
-    crate://crates.io/regex-automata/0.3.3 \
-    crate://crates.io/regex-syntax/0.6.29 \
-    crate://crates.io/regex-syntax/0.7.4 \
-    crate://crates.io/rgb/0.8.36 \
-    crate://crates.io/rustc_version/0.2.3 \
-    crate://crates.io/rustc_version/0.4.0 \
-    crate://crates.io/rustix/0.38.4 \
+    crate://crates.io/redox_syscall/0.4.1 \
+    crate://crates.io/regex/1.10.2 \
+    crate://crates.io/regex-automata/0.4.3 \
+    crate://crates.io/regex-syntax/0.8.2 \
+    crate://crates.io/rgb/0.8.37 \
+    crate://crates.io/rustix/0.38.28 \
     crate://crates.io/rusty-fork/0.3.0 \
-    crate://crates.io/ryu/1.0.15 \
+    crate://crates.io/ryu/1.0.16 \
     crate://crates.io/safe_arch/0.7.1 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
-    crate://crates.io/selectors/0.24.0 \
-    crate://crates.io/semver/0.9.0 \
-    crate://crates.io/semver/1.0.18 \
-    crate://crates.io/semver-parser/0.7.0 \
-    crate://crates.io/serde/1.0.173 \
-    crate://crates.io/serde_derive/1.0.173 \
-    crate://crates.io/serde_json/1.0.103 \
-    crate://crates.io/serde_spanned/0.6.3 \
-    crate://crates.io/servo_arc/0.2.0 \
-    crate://crates.io/sha1/0.6.1 \
-    crate://crates.io/sha1_smol/1.0.0 \
+    crate://crates.io/selectors/0.25.0 \
+    crate://crates.io/serde/1.0.193 \
+    crate://crates.io/serde_derive/1.0.193 \
+    crate://crates.io/serde_json/1.0.108 \
+    crate://crates.io/serde_spanned/0.6.4 \
+    crate://crates.io/servo_arc/0.3.0 \
     crate://crates.io/simba/0.8.1 \
-    crate://crates.io/simd-adler32/0.3.5 \
-    crate://crates.io/siphasher/0.3.10 \
-    crate://crates.io/slab/0.4.8 \
-    crate://crates.io/smallvec/1.11.0 \
+    crate://crates.io/simd-adler32/0.3.7 \
+    crate://crates.io/siphasher/0.3.11 \
+    crate://crates.io/slab/0.4.9 \
+    crate://crates.io/smallvec/1.11.2 \
     crate://crates.io/stable_deref_trait/1.2.0 \
-    crate://crates.io/standback/0.2.17 \
-    crate://crates.io/stdweb/0.4.20 \
-    crate://crates.io/stdweb-derive/0.5.3 \
-    crate://crates.io/stdweb-internal-macros/0.2.9 \
-    crate://crates.io/stdweb-internal-runtime/0.1.5 \
     crate://crates.io/string_cache/0.8.7 \
     crate://crates.io/string_cache_codegen/0.5.2 \
     crate://crates.io/strsim/0.10.0 \
     crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.26 \
-    crate://crates.io/system-deps/6.1.1 \
-    crate://crates.io/target-lexicon/0.12.10 \
-    crate://crates.io/tempfile/3.7.0 \
+    crate://crates.io/syn/2.0.41 \
+    crate://crates.io/system-deps/6.2.0 \
+    crate://crates.io/target-lexicon/0.12.12 \
+    crate://crates.io/tempfile/3.8.1 \
     crate://crates.io/tendril/0.4.3 \
     crate://crates.io/termtree/0.4.1 \
-    crate://crates.io/textwrap/0.16.0 \
-    crate://crates.io/thiserror/1.0.43 \
-    crate://crates.io/thiserror-impl/1.0.43 \
-    crate://crates.io/time/0.2.27 \
-    crate://crates.io/time-macros/0.1.1 \
-    crate://crates.io/time-macros-impl/0.1.2 \
+    crate://crates.io/thiserror/1.0.50 \
+    crate://crates.io/thiserror-impl/1.0.50 \
+    crate://crates.io/time/0.3.30 \
+    crate://crates.io/time-core/0.1.2 \
+    crate://crates.io/time-macros/0.2.15 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.6.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.7.6 \
+    crate://crates.io/toml/0.8.2 \
     crate://crates.io/toml_datetime/0.6.3 \
-    crate://crates.io/toml_edit/0.19.14 \
-    crate://crates.io/typenum/1.16.0 \
+    crate://crates.io/toml_edit/0.20.2 \
+    crate://crates.io/typenum/1.17.0 \
     crate://crates.io/unarray/0.1.4 \
-    crate://crates.io/unicode-bidi/0.3.13 \
-    crate://crates.io/unicode-ident/1.0.11 \
+    crate://crates.io/unicode-bidi/0.3.14 \
+    crate://crates.io/unicode-ident/1.0.12 \
     crate://crates.io/unicode-normalization/0.1.22 \
-    crate://crates.io/url/2.4.0 \
+    crate://crates.io/url/2.5.0 \
     crate://crates.io/utf-8/0.7.6 \
     crate://crates.io/utf8parse/0.2.1 \
     crate://crates.io/version-compare/0.1.1 \
     crate://crates.io/version_check/0.9.4 \
     crate://crates.io/wait-timeout/0.2.0 \
-    crate://crates.io/walkdir/2.3.3 \
-    crate://crates.io/wasi/0.9.0+wasi-snapshot-preview1 \
+    crate://crates.io/walkdir/2.4.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.87 \
-    crate://crates.io/wasm-bindgen-backend/0.2.87 \
-    crate://crates.io/wasm-bindgen-macro/0.2.87 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
-    crate://crates.io/wasm-bindgen-shared/0.2.87 \
-    crate://crates.io/web-sys/0.3.64 \
+    crate://crates.io/wasm-bindgen/0.2.89 \
+    crate://crates.io/wasm-bindgen-backend/0.2.89 \
+    crate://crates.io/wasm-bindgen-macro/0.2.89 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.89 \
+    crate://crates.io/wasm-bindgen-shared/0.2.89 \
+    crate://crates.io/web-sys/0.3.66 \
     crate://crates.io/weezl/0.1.7 \
-    crate://crates.io/wide/0.7.11 \
+    crate://crates.io/wide/0.7.13 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-util/0.1.6 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows/0.48.0 \
+    crate://crates.io/windows-core/0.51.1 \
     crate://crates.io/windows-sys/0.48.0 \
-    crate://crates.io/windows-targets/0.48.1 \
-    crate://crates.io/windows_aarch64_gnullvm/0.48.0 \
-    crate://crates.io/windows_aarch64_msvc/0.48.0 \
-    crate://crates.io/windows_i686_gnu/0.48.0 \
-    crate://crates.io/windows_i686_msvc/0.48.0 \
-    crate://crates.io/windows_x86_64_gnu/0.48.0 \
-    crate://crates.io/windows_x86_64_gnullvm/0.48.0 \
-    crate://crates.io/windows_x86_64_msvc/0.48.0 \
-    crate://crates.io/winnow/0.5.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.48.5 \
+    crate://crates.io/windows-targets/0.52.0 \
+    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.0 \
+    crate://crates.io/windows_aarch64_msvc/0.48.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.0 \
+    crate://crates.io/windows_i686_gnu/0.48.5 \
+    crate://crates.io/windows_i686_gnu/0.52.0 \
+    crate://crates.io/windows_i686_msvc/0.48.5 \
+    crate://crates.io/windows_i686_msvc/0.52.0 \
+    crate://crates.io/windows_x86_64_gnu/0.48.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.0 \
+    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.0 \
+    crate://crates.io/windows_x86_64_msvc/0.48.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.0 \
+    crate://crates.io/winnow/0.5.28 \
     crate://crates.io/xml5ever/0.17.0 \
     crate://crates.io/yeslogic-fontconfig-sys/4.0.1 \
 "
 
 SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
-SRC_URI[aho-corasick-1.0.2.sha256sum] = "43f6cb1bf222025340178f382c426f13757b2960e89779dfcb319c32542a5a41"
+SRC_URI[aho-corasick-1.1.2.sha256sum] = "b2969dcb958b36655471fc61f7e416fa76033bdd4bfed0678d8fee1e2d07a1f0"
 SRC_URI[android-tzdata-0.1.1.sha256sum] = "e999941b234f3131b00bc13c22d06e8c5ff726d1b6318ac7eb276997bbb4fef0"
 SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
 SRC_URI[anes-0.1.6.sha256sum] = "4b46cbb362ab8752921c97e041f5e366ee6297bd428a31275b9fcf1e380f7299"
-SRC_URI[anstream-0.3.2.sha256sum] = "0ca84f3628370c59db74ee214b3263d58f9aadd9b4fe7e711fd87dc452b7f163"
-SRC_URI[anstyle-1.0.1.sha256sum] = "3a30da5c5f2d5e72842e00bcb57657162cdabef0931f40e2deb9b4140440cecd"
-SRC_URI[anstyle-parse-0.2.1.sha256sum] = "938874ff5980b03a87c5524b3ae5b59cf99b1d6bc836848df7bc5ada9643c333"
-SRC_URI[anstyle-query-1.0.0.sha256sum] = "5ca11d4be1bab0c8bc8734a9aa7bf4ee8316d462a08c6ac5052f888fef5b494b"
-SRC_URI[anstyle-wincon-1.0.1.sha256sum] = "180abfa45703aebe0093f79badacc01b8fd4ea2e35118747e5811127f926e188"
-SRC_URI[anyhow-1.0.72.sha256sum] = "3b13c32d80ecc7ab747b80c3784bce54ee8a7a0cc4fbda9bf4cda2cf6fe90854"
+SRC_URI[anstream-0.6.5.sha256sum] = "d664a92ecae85fd0a7392615844904654d1d5f5514837f471ddef4a057aba1b6"
+SRC_URI[anstyle-1.0.4.sha256sum] = "7079075b41f533b8c61d2a4d073c4676e1f8b249ff94a393b0595db304e0dd87"
+SRC_URI[anstyle-parse-0.2.3.sha256sum] = "c75ac65da39e5fe5ab759307499ddad880d724eed2f6ce5b5e8a26f4f387928c"
+SRC_URI[anstyle-query-1.0.2.sha256sum] = "e28923312444cdd728e4738b3f9c9cac739500909bb3d3c94b43551b16517648"
+SRC_URI[anstyle-wincon-3.0.2.sha256sum] = "1cd54b81ec8d6180e24654d0b371ad22fc3dd083b6ff8ba325b72e00c87660a7"
+SRC_URI[anyhow-1.0.75.sha256sum] = "a4668cab20f66d8d020e1fbc0ebe47217433c1b6c8f2040faf858554e394ace6"
 SRC_URI[approx-0.5.1.sha256sum] = "cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.0.11.sha256sum] = "86d6b683edf8d1119fe420a94f8a7e389239666aa72e65495d91c00462510151"
-SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
+SRC_URI[assert_cmd-2.0.12.sha256sum] = "88903cb14723e4d4003335bb7f8a14f27691649105346a0f0957466c096adfe6"
 SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[base-x-0.2.11.sha256sum] = "4cbbc9d0964165b47557570cce6c952866c2678457aca742aafc9fb771d30270"
 SRC_URI[bit-set-0.5.3.sha256sum] = "0700ddab506f33b20a03b13996eccd309a48e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.3.3.sha256sum] = "630be753d4e58660abd17930c71b647fe46c27ea6b63cc59e1e3851406972e42"
+SRC_URI[bitflags-2.4.1.sha256sum] = "327762f6e5a765692301e5bb513e0d9fef63be86bbc14528052b1cd3e6f03e07"
 SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
-SRC_URI[bstr-1.6.0.sha256sum] = "6798148dccfbff0fae41c7574d2fa8f1ef3492fba0face179de5d8d447d67b05"
-SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
-SRC_URI[bytemuck-1.13.1.sha256sum] = "17febce684fd15d89027105661fec94afb475cb995fbc59d2865198446ba2eea"
-SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
-SRC_URI[cairo-rs-0.17.10.sha256sum] = "ab3603c4028a5e368d09b51c8b624b9a46edcd7c3778284077a6125af73c9f0a"
-SRC_URI[cairo-sys-rs-0.17.10.sha256sum] = "691d0c66b1fb4881be80a760cb8fe76ea97218312f9dfe2c9cc0f496ca279cb1"
+SRC_URI[bstr-1.8.0.sha256sum] = "542f33a8835a0884b006a0c3df3dadd99c0c3f296ed26c2fdc8028e01ad6230c"
+SRC_URI[bumpalo-3.14.0.sha256sum] = "7f30e7476521f6f8af1a1c4c0b8cc94f0bee37d91763d0ca2665f299b6cd8aec"
+SRC_URI[bytemuck-1.14.0.sha256sum] = "374d28ec25809ee0e23827c2ab573d729e293f281dfe393500e7ad618baa61c6"
+SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
+SRC_URI[cairo-rs-0.18.3.sha256sum] = "f33613627f0dea6a731b0605101fad59ba4f193a52c96c4687728d822605a8a1"
+SRC_URI[cairo-sys-rs-0.18.2.sha256sum] = "685c9fa8e590b8b3d678873528d83411db17242a73fccaed827770ea0fedda51"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
-SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
-SRC_URI[cfg-expr-0.15.3.sha256sum] = "215c0072ecc28f92eeb0eea38ba63ddfcb65c2828c46311d646f1a3ff5f9841c"
+SRC_URI[cc-1.0.83.sha256sum] = "f1174fb0b6ec23863f8b971027804a42614e347eafb0a95bf0b12cdae21fc4d0"
+SRC_URI[cfg-expr-0.15.5.sha256sum] = "03915af431787e6ffdcc74c645077518c6b6e01f80b761e0fbbfa288536311b3"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.26.sha256sum] = "ec837a71355b28f6556dbd569b37b3f363091c0bd4b2e735674521b4c5fd9bc5"
+SRC_URI[chrono-0.4.31.sha256sum] = "7f2c685bad3eb3d45a01354cedb7d5faa66194d1d58ba6e267a8de788f79db38"
 SRC_URI[ciborium-0.2.1.sha256sum] = "effd91f6c78e5a4ace8a5d3c0b6bfaec9e2baaef55f3efc00e45fb2e477ee926"
 SRC_URI[ciborium-io-0.2.1.sha256sum] = "cdf919175532b369853f5d5e20b26b43112613fd6fe7aee757e35f7a44642656"
 SRC_URI[ciborium-ll-0.2.1.sha256sum] = "defaa24ecc093c77630e6c15e17c51f5e187bf35ee514f4e2d67baaa96dae22b"
-SRC_URI[clap-3.2.25.sha256sum] = "4ea181bf566f71cb9a5d17a59e1871af638180a18fb0035c92ae62b705207123"
-SRC_URI[clap-4.3.17.sha256sum] = "5b0827b011f6f8ab38590295339817b0d26f344aa4932c3ced71b45b0c54b4a9"
-SRC_URI[clap_builder-4.3.17.sha256sum] = "9441b403be87be858db6a23edb493e7f694761acdc3343d5a0fcaafd304cbc9e"
-SRC_URI[clap_complete-4.3.2.sha256sum] = "5fc443334c81a804575546c5a8a79b4913b50e28d69232903604cada1de817ce"
-SRC_URI[clap_derive-4.3.12.sha256sum] = "54a9bb5758fc5dfe728d1019941681eccaf0cf8a4189b692a0ee2f2ecf90a050"
-SRC_URI[clap_lex-0.2.4.sha256sum] = "2850f2f5a82cbf437dd5af4d49848fbdfc27c157c3d010345776f952765261c5"
-SRC_URI[clap_lex-0.5.0.sha256sum] = "2da6da31387c7e4ef160ffab6d5e7f00c42626fe39aea70a7b0f1773f7dd6c1b"
+SRC_URI[clap-4.4.11.sha256sum] = "bfaff671f6b22ca62406885ece523383b9b64022e341e53e009a62ebc47a45f2"
+SRC_URI[clap_builder-4.4.11.sha256sum] = "a216b506622bb1d316cd51328dce24e07bdff4a6128a47c7e7fad11878d5adbb"
+SRC_URI[clap_complete-4.4.4.sha256sum] = "bffe91f06a11b4b9420f62103854e90867812cd5d01557f853c5ee8e791b12ae"
+SRC_URI[clap_derive-4.4.7.sha256sum] = "cf9804afaaf59a91e75b022a30fb7229a7901f60c755489cc61c9b423b836442"
+SRC_URI[clap_lex-0.6.0.sha256sum] = "702fc72eb24e5a1e48ce58027a675bc24edd52096d5397d4aea7c6dd9eca0bd1"
 SRC_URI[colorchoice-1.0.0.sha256sum] = "acbf1af155f9b9ef647e42cdc158db4b64a1b61f743629225fde6f3e0be2a7c7"
 SRC_URI[const-cstr-0.3.0.sha256sum] = "ed3d0b5ff30645a68f35ece8cea4556ca14ef8a1651455f789a099a0513532a6"
-SRC_URI[const_fn-0.4.9.sha256sum] = "fbdcdcb6d86f71c5e97409ad45898af11cbc995b4ee8112d59095a28d376c935"
-SRC_URI[convert_case-0.4.0.sha256sum] = "6245d59a3e82a7fc217c5828a6692dbc6dfb63a0c8c90495621f7b9d79704a0e"
-SRC_URI[core-foundation-sys-0.8.4.sha256sum] = "e496a50fda8aacccc86d7529e2c1e0892dbd0f898a6b5645b5561b89c3210efa"
+SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
 SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
-SRC_URI[criterion-0.4.0.sha256sum] = "e7c76e09c1aae2bc52b3d2f29e13c6572553b30c4aa1b8a49fd70de6412654cb"
+SRC_URI[criterion-0.5.1.sha256sum] = "f2b12d017a929603d80db1831cd3a24082f8137ce19c69e6447f54f5fc8d692f"
 SRC_URI[criterion-plot-0.5.0.sha256sum] = "6b50826342786a51a89e2da3a28f1c32b06e387201bc2d19791f622c673706b1"
-SRC_URI[crossbeam-channel-0.5.8.sha256sum] = "a33c2bf77f2df06183c3aa30d1e96c0695a313d4f9c453cc3762a6db39f99200"
-SRC_URI[crossbeam-deque-0.8.3.sha256sum] = "ce6fd6f855243022dcecf8702fef0c297d4338e226845fe067f6341ad9fa0cef"
-SRC_URI[crossbeam-epoch-0.9.15.sha256sum] = "ae211234986c545741a7dc064309f67ee1e5ad243d0e48335adc0484d960bcc7"
-SRC_URI[crossbeam-utils-0.8.16.sha256sum] = "5a22b2d63d4d1dc0b7f1b6b2747dd0088008a9be28b6ddf0b1e7d335e3037294"
-SRC_URI[cssparser-0.29.6.sha256sum] = "f93d03419cb5950ccfd3daf3ff1c7a36ace64609a1a8746d493df1ca0afde0fa"
+SRC_URI[crossbeam-deque-0.8.4.sha256sum] = "fca89a0e215bab21874660c67903c5f143333cab1da83d041c7ded6053774751"
+SRC_URI[crossbeam-epoch-0.9.16.sha256sum] = "2d2fe95351b870527a5d09bf563ed3c97c0cffb87cf1c78a591bf48bb218d9aa"
+SRC_URI[crossbeam-utils-0.8.17.sha256sum] = "c06d96137f14f244c37f989d9fff8f95e6c18b918e71f36638f8c49112e4c78f"
+SRC_URI[cssparser-0.31.2.sha256sum] = "5b3df4f93e5fbbe73ec01ec8d3f68bba73107993a5b1e7519273c32db9b0d5be"
 SRC_URI[cssparser-macros-0.6.1.sha256sum] = "13b588ba4ac1a99f7f2964d24b3d896ddc6bf847ee3855dbd4366f058cfcd331"
-SRC_URI[data-url-0.2.0.sha256sum] = "8d7439c3735f405729d52c3fbbe4de140eaf938a1fe47d227c27f8254d4302a5"
+SRC_URI[cstr-0.2.11.sha256sum] = "8aa998c33a6d3271e3678950a22134cd7dd27cef86dee1b611b5b14207d1d90b"
+SRC_URI[data-url-0.3.1.sha256sum] = "5c297a1c74b71ae29df00c3e22dd9534821d60eb9af5a0192823fa2acea70c2a"
+SRC_URI[deranged-0.3.10.sha256sum] = "8eb30d70a07a3b04884d2677f06bec33509dc67ca60d92949e5535352d3191dc"
 SRC_URI[derive_more-0.99.17.sha256sum] = "4fb810d30a7c1953f91334de7244731fc3f3c10d7fe163338a35b9f640960321"
 SRC_URI[difflib-0.4.0.sha256sum] = "6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"
-SRC_URI[discard-1.0.4.sha256sum] = "212d0f5754cb6769937f4501cc0e67f4f4483c8d2c3e1e922ee9edbe4ab4c7c0"
 SRC_URI[dlib-0.5.2.sha256sum] = "330c60081dcc4c72131f8eb70510f1ac07223e5d4163db481a04a0befcffa412"
 SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
 SRC_URI[dtoa-1.0.9.sha256sum] = "dcbb2bf8e87535c23f7a8a321e364ce21462d0ff10cb6407820e8e96dfff6653"
 SRC_URI[dtoa-short-0.3.4.sha256sum] = "dbaceec3c6e4211c79e7b1800fb9680527106beb2f9c51904a3210c03a448c74"
-SRC_URI[either-1.8.1.sha256sum] = "7fcaabb2fef8c910e7f4c7ce9f67a1283a1715879a7c230ca9d6d1ae31f16d91"
-SRC_URI[encoding-0.2.33.sha256sum] = "6b0d943856b990d12d3b55b359144ff341533e516d94098b1d3fc1ac666d36ec"
-SRC_URI[encoding-index-japanese-1.20141219.5.sha256sum] = "04e8b2ff42e9a05335dbf8b5c6f7567e5591d0d916ccef4e0b1710d32a0d0c91"
-SRC_URI[encoding-index-korean-1.20141219.5.sha256sum] = "4dc33fb8e6bcba213fe2f14275f0963fd16f0a02c878e3095ecfdf5bee529d81"
-SRC_URI[encoding-index-simpchinese-1.20141219.5.sha256sum] = "d87a7194909b9118fc707194baa434a4e3b0fb6a5a757c73c3adb07aa25031f7"
-SRC_URI[encoding-index-singlebyte-1.20141219.5.sha256sum] = "3351d5acffb224af9ca265f435b859c7c01537c0849754d3db3fdf2bfe2ae84a"
-SRC_URI[encoding-index-tradchinese-1.20141219.5.sha256sum] = "fd0e20d5688ce3cab59eb3ef3a2083a5c77bf496cb798dc6fcdb75f323890c18"
-SRC_URI[encoding_index_tests-0.1.4.sha256sum] = "a246d82be1c9d791c5dfde9a2bd045fc3cbba3fa2b11ad558f27d01712f00569"
-SRC_URI[encoding_rs-0.8.32.sha256sum] = "071a31f4ee85403370b58aca746f01041ede6f0da2730960ad001edc2b71b394"
+SRC_URI[either-1.9.0.sha256sum] = "a26ae43d7bcc3b814de94796a5e736d4029efb0ee900c12e2d54c993ad1a1e07"
+SRC_URI[encoding_rs-0.8.33.sha256sum] = "7268b386296a025e474d5140678f75d6de9493ae55a5d709eeb9dd08149945e1"
 SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[errno-0.3.1.sha256sum] = "4bcfec3a70f97c962c307b2d2c56e358cf1d00b558d74262b5f929ee8cc7e73a"
-SRC_URI[errno-dragonfly-0.1.2.sha256sum] = "aa68f1b12764fab894d2755d2518754e71b4fd80ecfb822714a1206c2aab39bf"
-SRC_URI[fastrand-2.0.0.sha256sum] = "6999dc1837253364c2ebb0704ba97994bd874e8f195d665c50b7548f6ea92764"
-SRC_URI[fdeflate-0.3.0.sha256sum] = "d329bdeac514ee06249dabc27877490f17f5d371ec693360768b838e19f3ae10"
-SRC_URI[flate2-1.0.26.sha256sum] = "3b9429470923de8e8cbd4d2dc513535400b4b3fef0319fb5c4e1f520a7bef743"
+SRC_URI[errno-0.3.8.sha256sum] = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"
+SRC_URI[fastrand-2.0.1.sha256sum] = "25cbce373ec4653f1a01a31e8a5e5ec0c622dc27ff9c4e6606eefef5cbbed4a5"
+SRC_URI[fdeflate-0.3.1.sha256sum] = "64d6dafc854908ff5da46ff3f8f473c6984119a2876a383a860246dd7841a868"
+SRC_URI[flate2-1.0.28.sha256sum] = "46303f565772937ffe1d394a4fac6f411c6013172fadde9dcdb1e147a086940e"
 SRC_URI[float-cmp-0.9.0.sha256sum] = "98de4bbd547a563b716d8dfa9aad1cb19bfab00f4fa09a6a4ed21dbcf44ce9c4"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
-SRC_URI[form_urlencoded-1.2.0.sha256sum] = "a62bc1cf6f830c2ec14a513a9fb124d0a213a629668a4186f329db21fe045652"
+SRC_URI[form_urlencoded-1.2.1.sha256sum] = "e13624c2627564efccf4934284bdd98cbaa14e79b0b5a141218e507b3a823456"
 SRC_URI[futf-0.1.5.sha256sum] = "df420e2e84819663797d1ec6544b13c5be84629e7bb00dc960d6917db2987843"
-SRC_URI[futures-channel-0.3.28.sha256sum] = "955518d47e09b25bbebc7a18df10b81f0c766eaf4c4f1cccef2fca5f2a4fb5f2"
-SRC_URI[futures-core-0.3.28.sha256sum] = "4bca583b7e26f571124fe5b7561d49cb2868d79116cfa0eefce955557c6fee8c"
-SRC_URI[futures-executor-0.3.28.sha256sum] = "ccecee823288125bd88b4d7f565c9e58e41858e47ab72e8ea2d64e93624386e0"
-SRC_URI[futures-io-0.3.28.sha256sum] = "4fff74096e71ed47f8e023204cfd0aa1289cd54ae5430a9523be060cdb849964"
-SRC_URI[futures-macro-0.3.28.sha256sum] = "89ca545a94061b6365f2c7355b4b32bd20df3ff95f02da9329b34ccc3bd6ee72"
-SRC_URI[futures-task-0.3.28.sha256sum] = "76d3d132be6c0e6aa1534069c705a74a5997a356c0dc2f86a47765e5617c5b65"
-SRC_URI[futures-util-0.3.28.sha256sum] = "26b01e40b772d54cf6c6d721c1d1abd0647a0106a12ecaa1c186273392a69533"
+SRC_URI[futures-channel-0.3.29.sha256sum] = "ff4dd66668b557604244583e3e1e1eada8c5c2e96a6d0d6653ede395b78bbacb"
+SRC_URI[futures-core-0.3.29.sha256sum] = "eb1d22c66e66d9d72e1758f0bd7d4fd0bee04cad842ee34587d68c07e45d088c"
+SRC_URI[futures-executor-0.3.29.sha256sum] = "0f4fb8693db0cf099eadcca0efe2a5a22e4550f98ed16aba6c48700da29597bc"
+SRC_URI[futures-io-0.3.29.sha256sum] = "8bf34a163b5c4c52d0478a4d757da8fb65cabef42ba90515efee0f6f9fa45aaa"
+SRC_URI[futures-macro-0.3.29.sha256sum] = "53b153fd91e4b0147f4aced87be237c98248656bb01050b96bf3ee89220a8ddb"
+SRC_URI[futures-task-0.3.29.sha256sum] = "efd193069b0ddadc69c46389b740bbccdd97203899b48d09c5f7969591d6bae2"
+SRC_URI[futures-util-0.3.29.sha256sum] = "a19526d624e703a3179b3d322efec918b6246ea0fa51d41124525f00f1cc8104"
 SRC_URI[fxhash-0.2.1.sha256sum] = "c31b6d751ae2c7f11320402d34e41349dd1016f8d5d45e48c4312bc8625af50c"
-SRC_URI[gdk-pixbuf-0.17.10.sha256sum] = "695d6bc846438c5708b07007537b9274d883373dd30858ca881d7d71b5540717"
-SRC_URI[gdk-pixbuf-sys-0.17.10.sha256sum] = "9285ec3c113c66d7d0ab5676599176f1f42f4944ca1b581852215bf5694870cb"
-SRC_URI[getrandom-0.1.16.sha256sum] = "8fc3cb4d91f53b50155bdcfd23f6a4c39ae1969c2ae85982b135750cccaf5fce"
-SRC_URI[getrandom-0.2.10.sha256sum] = "be4136b2a15dd319360be1c07d9933517ccf0be8f16bf62a3bee4f0d618df427"
-SRC_URI[gio-0.17.10.sha256sum] = "a6973e92937cf98689b6a054a9e56c657ed4ff76de925e36fc331a15f0c5d30a"
-SRC_URI[gio-sys-0.17.10.sha256sum] = "0ccf87c30a12c469b6d958950f6a9c09f2be20b7773f7e70d20b867fdf2628c3"
-SRC_URI[glib-0.17.10.sha256sum] = "d3fad45ba8d4d2cea612b432717e834f48031cd8853c8aaf43b2c79fec8d144b"
-SRC_URI[glib-macros-0.17.10.sha256sum] = "eca5c79337338391f1ab8058d6698125034ce8ef31b72a442437fa6c8580de26"
-SRC_URI[glib-sys-0.17.10.sha256sum] = "d80aa6ea7bba0baac79222204aa786a6293078c210abe69ef1336911d4bdc4f0"
-SRC_URI[gobject-sys-0.17.10.sha256sum] = "cd34c3317740a6358ec04572c1bcfd3ac0b5b6529275fae255b237b314bb8062"
+SRC_URI[gdk-pixbuf-0.18.3.sha256sum] = "446f32b74d22c33b7b258d4af4ffde53c2bf96ca2e29abdf1a785fe59bd6c82c"
+SRC_URI[gdk-pixbuf-sys-0.18.0.sha256sum] = "3f9839ea644ed9c97a34d129ad56d38a25e6756f99f3a88e15cd39c20629caf7"
+SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
+SRC_URI[gio-0.18.4.sha256sum] = "d4fc8f532f87b79cbc51a79748f16a6828fb784be93145a322fa14d06d354c73"
+SRC_URI[gio-sys-0.18.1.sha256sum] = "37566df850baf5e4cb0dfb78af2e4b9898d817ed9263d1090a2df958c64737d2"
+SRC_URI[glib-0.18.4.sha256sum] = "951bbd7fdc5c044ede9f05170f05a3ae9479239c3afdfe2d22d537a3add15c4e"
+SRC_URI[glib-macros-0.18.3.sha256sum] = "72793962ceece3863c2965d7f10c8786323b17c7adea75a515809fa20ab799a5"
+SRC_URI[glib-sys-0.18.1.sha256sum] = "063ce2eb6a8d0ea93d2bf8ba1957e78dbab6be1c2220dd3daca57d5a9d869898"
+SRC_URI[gobject-sys-0.18.0.sha256sum] = "0850127b514d1c4a4654ead6dedadb18198999985908e6ffe4436f53c785ce44"
 SRC_URI[half-1.8.2.sha256sum] = "eabb4a44450da02c90444cf74558da904edde8fb4e9035a9a6a4e15445af0bd7"
-SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
-SRC_URI[hashbrown-0.14.0.sha256sum] = "2c6201b9ff9fd90a5a3bac2e56a830d0caa509576f0e503818ee82c181b3437a"
+SRC_URI[hashbrown-0.14.3.sha256sum] = "290f1a1d9242c78d09ce40a5e87e7554ee637af1351968159f4952f028f75604"
 SRC_URI[heck-0.4.1.sha256sum] = "95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
-SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
-SRC_URI[hermit-abi-0.3.2.sha256sum] = "443144c8cdadd93ebf52ddb4056d257f5b52c04d3c804e657d19eb73fc33668b"
-SRC_URI[iana-time-zone-0.1.57.sha256sum] = "2fad5b825842d2b38bd206f3e81d6957625fd7f0a361e345c30e01a0ae2dd613"
+SRC_URI[hermit-abi-0.3.3.sha256sum] = "d77f7ec81a6d05a3abb01ab6eb7590f6083d08449fe5a1c8b1e620283546ccb7"
+SRC_URI[iana-time-zone-0.1.58.sha256sum] = "8326b86b6cff230b97d0d312a6c40a60726df3332e721f72a1b035f451663b20"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[idna-0.4.0.sha256sum] = "7d20d6b07bfbc108882d88ed8e37d39636dcc260e15e30c45e6ba089610b917c"
-SRC_URI[indexmap-1.9.3.sha256sum] = "bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
-SRC_URI[indexmap-2.0.0.sha256sum] = "d5477fe2230a79769d8dc68e0eabf5437907c0457a5614a9e8dddb67f65eb65d"
+SRC_URI[idna-0.5.0.sha256sum] = "634d9b1461af396cad843f47fdba5597a4f9e6ddd4bfb6ff5d85028c25cb12f6"
+SRC_URI[indexmap-2.1.0.sha256sum] = "d530e1a18b1cb4c484e6e34556a0d948706958449fca0cab753d649f2bce3d1f"
 SRC_URI[is-terminal-0.4.9.sha256sum] = "cb0889898416213fab133e1d33a0e5858a48177452750691bde3666d0fdbaf8b"
 SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
-SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
-SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
+SRC_URI[itertools-0.11.0.sha256sum] = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+SRC_URI[itoa-1.0.10.sha256sum] = "b1a46d1a171d865aa5f83f92695765caa047a9b4cbae2cbf37dbd613a793fd4c"
+SRC_URI[js-sys-0.3.66.sha256sum] = "cee9c64da59eae3b50095c18d3e74f8b73c0b86d2792824ff01bbce68ba229ca"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
-SRC_URI[libloading-0.8.0.sha256sum] = "d580318f95776505201b28cf98eb1fa5e4be3b689633ba6a3e6cd880ff22d8cb"
-SRC_URI[libm-0.2.7.sha256sum] = "f7012b1bbb0719e1097c47611d3898568c546d597c2e74d66f6087edd5233ff4"
+SRC_URI[libc-0.2.151.sha256sum] = "302d7ab3130588088d277783b1e2d2e10c9e9e4a16dd9050e6ec93fb3e7048f4"
+SRC_URI[libloading-0.8.1.sha256sum] = "c571b676ddfc9a8c12f1f3d3085a7b163966a8fd8098a90640953ce5f6170161"
+SRC_URI[libm-0.2.8.sha256sum] = "4ec2a862134d2a7d32d7983ddcdd1c4923530833c9f2ea1a44fc5fa473989058"
 SRC_URI[linked-hash-map-0.5.6.sha256sum] = "0717cef1bc8b636c6e1c1bbdefc09e6322da8a9321966e8928ef80d20f7f770f"
-SRC_URI[linux-raw-sys-0.4.3.sha256sum] = "09fc20d2ca12cb9f044c93e3bd6d32d523e6e2ec3db4f7b2939cd99026ecd3f0"
+SRC_URI[linux-raw-sys-0.4.12.sha256sum] = "c4cd1a83af159aa67994778be9070f0ae1bd732942279cabb14f86f986a21456"
 SRC_URI[locale_config-0.3.0.sha256sum] = "08d2c35b16f4483f6c26f0e4e9550717a2f6575bcd6f12a53ff0c490a94a6934"
-SRC_URI[lock_api-0.4.10.sha256sum] = "c1cc9717a20b1bb222f333e6a92fd32f7d8a18ddc5a3191a11af45dcbf4dcd16"
-SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
-SRC_URI[lopdf-0.29.0.sha256sum] = "de0f69c40d6dbc68ebac4bf5aec3d9978e094e22e29fcabd045acd9cec74a9dc"
+SRC_URI[lock_api-0.4.11.sha256sum] = "3c168f8615b12bc01f9c17e2eb0cc07dcae1940121185446edc3744920e8ef45"
+SRC_URI[log-0.4.20.sha256sum] = "b5e6163cb8c49088c2c36f57875e58ccd8c87c7427f7fbd50ea6710b2f3f2e8f"
+SRC_URI[lopdf-0.31.0.sha256sum] = "07c8e1b6184b1b32ea5f72f572ebdc40e5da1d2921fa469947ff7c480ad1f85a"
 SRC_URI[mac-0.1.1.sha256sum] = "c41e0c4fef86961ac6d6f8a82609f55f31b05e4fce149ac5710e439df7619ba4"
 SRC_URI[malloc_buf-0.0.6.sha256sum] = "62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
 SRC_URI[markup5ever-0.11.0.sha256sum] = "7a2629bb1404f3d34c2e921f21fd34ba00b206124c81f65c50b43b6aaefeb016"
 SRC_URI[matches-0.1.10.sha256sum] = "2532096657941c2fea9c289d370a250971c689d4f143798ff67113ec042024a5"
-SRC_URI[matrixmultiply-0.3.7.sha256sum] = "090126dc04f95dc0d1c1c91f61bdd474b3930ca064c1edc8a849da2c6cbe1e77"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
+SRC_URI[matrixmultiply-0.3.8.sha256sum] = "7574c1cf36da4798ab73da5b215bbf444f50718207754cb522201d78d1cd0ff2"
+SRC_URI[md5-0.7.0.sha256sum] = "490cc448043f947bae3cbee9c203358d62dbee0db12107a74be5c30ccfd09771"
+SRC_URI[memchr-2.6.4.sha256sum] = "f665ee40bc4a3c5590afb1e9677db74a508659dfd71e126420da8274909a0167"
 SRC_URI[memoffset-0.9.0.sha256sum] = "5a634b1c61a95585bd15607c6ab0c4e5b226e695ff2800ba0cdccddf208c406c"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
 SRC_URI[nalgebra-0.32.3.sha256sum] = "307ed9b18cc2423f29e83f84fd23a8e73628727990181f18641a8b5dc2ab1caa"
 SRC_URI[nalgebra-macros-0.2.1.sha256sum] = "91761aed67d03ad966ef783ae962ef9bbaca728d2dd7ceb7939ec110fffad998"
 SRC_URI[new_debug_unreachable-1.0.4.sha256sum] = "e4a24736216ec316047a1fc4252e27dabb04218aa4a3f37c6e7ddbf1f9782b54"
-SRC_URI[nodrop-0.1.14.sha256sum] = "72ef4a56884ca558e5ddb05a1d1e7e1bfd9a68d9ed024c21704cc98872dae1bb"
+SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normalize-line-endings-0.3.0.sha256sum] = "61807f77802ff30975e01f4f071c8ba10c022052f98b3294119f3e615d13e5be"
-SRC_URI[num-complex-0.4.3.sha256sum] = "02e0d21255c828d6f128a1e41534206671e8c3ea0c62f32291e808dc82cff17d"
+SRC_URI[num-complex-0.4.4.sha256sum] = "1ba157ca0885411de85d6ca030ba7e2a83a28636056c7c699b07c8b6f7383214"
 SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
 SRC_URI[num-rational-0.4.1.sha256sum] = "0638a1c9d0a3c0914158145bc76cff373a75a627e6ecbfb71cbe6f453a5a19b0"
-SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
-SRC_URI[num_cpus-1.16.0.sha256sum] = "4161fcb6d602d4d2081af7c3a45852d875a03dd337a6bfdd6e06407b61342a43"
+SRC_URI[num-traits-0.2.17.sha256sum] = "39e3200413f237f41ab11ad6d161bc7239c84dcb631773ccd7de3dfe4b5c267c"
 SRC_URI[objc-0.2.7.sha256sum] = "915b1b472bc21c53464d6c8461c9d3af805ba1ef837e1cac254428f4a77177b1"
 SRC_URI[objc-foundation-0.1.1.sha256sum] = "1add1b659e36c9607c7aab864a76c7a4c2760cd0cd2e120f3fb8b952c7e22bf9"
 SRC_URI[objc_id-0.1.1.sha256sum] = "c92d4ddb4bd7b50d730c215ff871754d0da6b2178849f8a2a2ab69712d0c073b"
-SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
+SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
 SRC_URI[oorandom-11.1.3.sha256sum] = "0ab1bc2a289d34bd04a330323ac98a1b4bc82c9d9fcb1e66b63caa84da26b575"
-SRC_URI[os_str_bytes-6.5.1.sha256sum] = "4d5d9eb14b174ee9aa2ef96dc2b94637a2d4b6e7cb873c7e171f0c20c6cf3eac"
-SRC_URI[pango-0.17.10.sha256sum] = "35be456fc620e61f62dff7ff70fbd54dcbaf0a4b920c0f16de1107c47d921d48"
-SRC_URI[pango-sys-0.17.10.sha256sum] = "3da69f9f3850b0d8990d462f8c709561975e95f689c1cdf0fecdebde78b35195"
-SRC_URI[pangocairo-0.17.10.sha256sum] = "86bf29cb1c2e73817944f66011fb12135e1c6d268e8e4c5cfc689101c25822cf"
-SRC_URI[pangocairo-sys-0.17.10.sha256sum] = "94dfd38d9bf8ff5f881be2107ba49fcb22090d247aa00133f8dadf96b122b97a"
+SRC_URI[pango-0.18.3.sha256sum] = "7ca27ec1eb0457ab26f3036ea52229edbdb74dee1edd29063f5b9b010e7ebee4"
+SRC_URI[pango-sys-0.18.0.sha256sum] = "436737e391a843e5933d6d9aa102cb126d501e815b83601365a948a518555dc5"
+SRC_URI[pangocairo-0.18.0.sha256sum] = "57036589a9cfcacf83f9e606d15813fc6bf03f0e9e69aa2b5e3bb85af86b38a5"
+SRC_URI[pangocairo-sys-0.18.0.sha256sum] = "fc3c8ff676a37e7a72ec1d5fc029f91c407278083d2752784ff9f5188c108833"
 SRC_URI[parking_lot-0.12.1.sha256sum] = "3742b2c103b9f06bc9fff0a37ff4912935851bee6d36f3c02bcc755bcfec228f"
-SRC_URI[parking_lot_core-0.9.8.sha256sum] = "93f00c865fe7cabf650081affecd3871070f26767e7b2070a3ffae14c654b447"
+SRC_URI[parking_lot_core-0.9.9.sha256sum] = "4c42a9226546d68acdd9c0a280d17ce19bfe27a46bf68784e4066115788d008e"
 SRC_URI[paste-1.0.14.sha256sum] = "de3145af08024dea9fa9914f381a17b8fc6034dfb00f3a84013f7ff43f29ed4c"
-SRC_URI[percent-encoding-2.3.0.sha256sum] = "9b2a4787296e9989611394c33f193f676704af1686e70b8f8033ab5ba9a35a94"
-SRC_URI[phf-0.8.0.sha256sum] = "3dfb61232e34fcb633f43d12c58f83c1df82962dcdfa565a4e866ffc17dafe12"
+SRC_URI[percent-encoding-2.3.1.sha256sum] = "e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
 SRC_URI[phf-0.10.1.sha256sum] = "fabbf1ead8a5bcbc20f5f8b939ee3f5b0f6f281b6ad3468b84656b658b455259"
-SRC_URI[phf_codegen-0.8.0.sha256sum] = "cbffee61585b0411840d3ece935cce9cb6321f01c45477d30066498cd5e1a815"
+SRC_URI[phf-0.11.2.sha256sum] = "ade2d8b8f33c7333b51bcf0428d37e217e9f32192ae4772156f65063b8ce03dc"
 SRC_URI[phf_codegen-0.10.0.sha256sum] = "4fb1c3a8bc4dd4e5cfce29b44ffc14bedd2ee294559a294e2a4d4c9e9a6a13cd"
-SRC_URI[phf_generator-0.8.0.sha256sum] = "17367f0cc86f2d25802b2c26ee58a7b23faeccf78a396094c13dced0d0182526"
 SRC_URI[phf_generator-0.10.0.sha256sum] = "5d5285893bb5eb82e6aaf5d59ee909a06a16737a8970984dd7746ba9283498d6"
-SRC_URI[phf_macros-0.10.0.sha256sum] = "58fdf3184dd560f160dd73922bea2d5cd6e8f064bf4b13110abd81b03697b4e0"
-SRC_URI[phf_shared-0.8.0.sha256sum] = "c00cf8b9eafe68dde5e9eaa2cef8ee84a9336a47d566ec55ca16589633b65af7"
+SRC_URI[phf_generator-0.11.2.sha256sum] = "48e4cc64c2ad9ebe670cb8fd69dd50ae301650392e81c05f9bfcb2d5bdbc24b0"
+SRC_URI[phf_macros-0.11.2.sha256sum] = "3444646e286606587e49f3bcf1679b8cef1dc2c5ecc29ddacaffc305180d464b"
 SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456743ddb1744ed628f9815c096"
-SRC_URI[pin-project-lite-0.2.10.sha256sum] = "4c40d25201921e5ff0c862a505c6557ea88568a4e3ace775ab55e93f2f4f9d57"
+SRC_URI[phf_shared-0.11.2.sha256sum] = "90fcb95eef784c2ac79119d1dd819e162b5da872ce6f3c3abe1e8ca1c082f72b"
+SRC_URI[pin-project-lite-0.2.13.sha256sum] = "8afb450f006bf6385ca15ef45d71d2288452bc3683ce2e2cacc0d18e4be60b58"
 SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
 SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
 SRC_URI[plotters-0.3.5.sha256sum] = "d2c224ba00d7cadd4d5c660deaf2098e5e80e07846537c51f9cfa4be50c1fd45"
 SRC_URI[plotters-backend-0.3.5.sha256sum] = "9e76628b4d3a7581389a35d5b6e2139607ad7c75b17aed325f210aa91f4a9609"
 SRC_URI[plotters-svg-0.3.5.sha256sum] = "38f6d39893cca0701371e3c27294f09797214b86f1fb951b89ade8ec04e2abab"
-SRC_URI[png-0.17.9.sha256sum] = "59871cc5b6cce7eaccca5a802b4173377a1c2ba90654246789a8fa2334426d11"
-SRC_URI[pom-3.3.0.sha256sum] = "5c2d73a5fe10d458e77534589512104e5aa8ac480aa9ac30b74563274235cce4"
+SRC_URI[png-0.17.10.sha256sum] = "dd75bf2d8dd3702b9707cdbc56a5b9ef42cec752eb8b3bafc01234558442aa64"
+SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[predicates-2.1.5.sha256sum] = "59230a63c37f3e18569bdb90e4a89cbf5bf8b06fea0b84e65ea10cc4df47addd"
-SRC_URI[predicates-3.0.3.sha256sum] = "09963355b9f467184c04017ced4a2ba2d75cbcb4e7462690d388233253d4b1a9"
+SRC_URI[predicates-3.0.4.sha256sum] = "6dfc28575c2e3f19cb3c73b93af36460ae898d426eba6fc15b9bd2a5220758a0"
 SRC_URI[predicates-core-1.0.6.sha256sum] = "b794032607612e7abeb4db69adb4e33590fa6cf1149e95fd7cb00e634b92f174"
 SRC_URI[predicates-tree-1.0.9.sha256sum] = "368ba315fb8c5052ab692e68a0eefec6ec57b23a36959c14496f0b0df2c0cecf"
-SRC_URI[proc-macro-crate-1.3.1.sha256sum] = "7f4c021e1093a56626774e81216a4ce732a735e5bad4868a03f3ed65ca0c3919"
+SRC_URI[proc-macro-crate-2.0.1.sha256sum] = "97dc5fea232fc28d2f597b37c4876b348a40e33f3b02cc975c8d006d78d94b1a"
 SRC_URI[proc-macro-error-1.0.4.sha256sum] = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
 SRC_URI[proc-macro-error-attr-1.0.4.sha256sum] = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
-SRC_URI[proc-macro-hack-0.5.20+deprecated.sha256sum] = "dc375e1527247fe1a97d8b7156678dfe7c1af2fc075c9a4db3690ecd2a148068"
-SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
-SRC_URI[proptest-1.2.0.sha256sum] = "4e35c06b98bf36aba164cc17cb25f7e232f5c4aeea73baa14b8a9f0d92dbfa65"
+SRC_URI[proc-macro2-1.0.70.sha256sum] = "39278fbbf5fb4f646ce651690877f89d1c5811a3d4acb27700c1cb3cdb78fd3b"
+SRC_URI[proptest-1.4.0.sha256sum] = "31b476131c3c86cb68032fdc5cb6d5a1045e3e42d96b69fa599fd77701e1f5bf"
 SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
-SRC_URI[quote-1.0.31.sha256sum] = "5fe8a65d69dd0808184ebb5f836ab526bb259db23c657efa38711b1072ee47f0"
-SRC_URI[rand-0.7.3.sha256sum] = "6a6b1679d49b24bbfe0c803429aa1874472f50d9b363131f0e89fc356b544d03"
+SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
+SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_chacha-0.2.2.sha256sum] = "f4c8ed856279c9737206bf725bf36935d8666ead7aa69b52be55af369d193402"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.5.1.sha256sum] = "90bde5296fc891b0cef12a6d03ddccc162ce7b2aff54160af9338f8d40df6d19"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[rand_hc-0.2.0.sha256sum] = "ca3129af7b92a17112d59ad498c6f81eaf463253766b90396d39ea7a39d6613c"
-SRC_URI[rand_pcg-0.2.1.sha256sum] = "16abd0c1b639e9eb4d7c50c0b8100b0d0f849be2349829c740fe8e6eb4816429"
 SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
-SRC_URI[rayon-1.7.0.sha256sum] = "1d2df5196e37bcc87abebc0053e20787d73847bb33134a69841207dd0a47f03b"
-SRC_URI[rayon-core-1.11.0.sha256sum] = "4b8f95bd6966f5c87776639160a66bd8ab9895d9d4ab01ddba9fc60661aebe8d"
+SRC_URI[rayon-1.8.0.sha256sum] = "9c27db03db7734835b3f53954b534c91069375ce6ccaa2e065441e07d9b6cdb1"
+SRC_URI[rayon-core-1.12.0.sha256sum] = "5ce3fb6ad83f861aac485e76e1985cd109d9a3713802152be56c3b1f0e0658ed"
 SRC_URI[rctree-0.5.0.sha256sum] = "3b42e27ef78c35d3998403c1d26f3efd9e135d3e5121b0a4845cc5cc27547f4f"
-SRC_URI[redox_syscall-0.3.5.sha256sum] = "567664f262709473930a4bf9e51bf2ebf3348f2e748ccc50dea20646858f8f29"
-SRC_URI[regex-1.9.1.sha256sum] = "b2eae68fc220f7cf2532e4494aded17545fce192d59cd996e0fe7887f4ceb575"
-SRC_URI[regex-automata-0.3.3.sha256sum] = "39354c10dd07468c2e73926b23bb9c2caca74c5501e38a35da70406f1d923310"
-SRC_URI[regex-syntax-0.6.29.sha256sum] = "f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
-SRC_URI[regex-syntax-0.7.4.sha256sum] = "e5ea92a5b6195c6ef2a0295ea818b312502c6fc94dde986c5553242e18fd4ce2"
-SRC_URI[rgb-0.8.36.sha256sum] = "20ec2d3e3fc7a92ced357df9cebd5a10b6fb2aa1ee797bf7e9ce2f17dffc8f59"
-SRC_URI[rustc_version-0.2.3.sha256sum] = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a"
-SRC_URI[rustc_version-0.4.0.sha256sum] = "bfa0f585226d2e68097d4f95d113b15b83a82e819ab25717ec0590d9584ef366"
-SRC_URI[rustix-0.38.4.sha256sum] = "0a962918ea88d644592894bc6dc55acc6c0956488adcebbfb6e273506b7fd6e5"
+SRC_URI[redox_syscall-0.4.1.sha256sum] = "4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
+SRC_URI[regex-1.10.2.sha256sum] = "380b951a9c5e80ddfd6136919eef32310721aa4aacd4889a8d39124b026ab343"
+SRC_URI[regex-automata-0.4.3.sha256sum] = "5f804c7828047e88b2d32e2d7fe5a105da8ee3264f01902f796c8e067dc2483f"
+SRC_URI[regex-syntax-0.8.2.sha256sum] = "c08c74e62047bb2de4ff487b251e4a92e24f48745648451635cec7d591162d9f"
+SRC_URI[rgb-0.8.37.sha256sum] = "05aaa8004b64fd573fc9d002f4e632d51ad4f026c2b5ba95fcb6c2f32c2c47d8"
+SRC_URI[rustix-0.38.28.sha256sum] = "72e572a5e8ca657d7366229cdde4bd14c4eb5499a9573d4d366fe1b599daa316"
 SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
-SRC_URI[ryu-1.0.15.sha256sum] = "1ad4cc8da4ef723ed60bced201181d83791ad433213d8c24efffda1eec85d741"
+SRC_URI[ryu-1.0.16.sha256sum] = "f98d2aa92eebf49b69786be48e4477826b256916e84a57ff2a4f21923b48eb4c"
 SRC_URI[safe_arch-0.7.1.sha256sum] = "f398075ce1e6a179b46f51bd88d0598b92b00d3551f1a2d4ac49e771b56ac354"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
-SRC_URI[selectors-0.24.0.sha256sum] = "0c37578180969d00692904465fb7f6b3d50b9a2b952b87c23d0e2e5cb5013416"
-SRC_URI[semver-0.9.0.sha256sum] = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403"
-SRC_URI[semver-1.0.18.sha256sum] = "b0293b4b29daaf487284529cc2f5675b8e57c61f70167ba415a463651fd6a918"
-SRC_URI[semver-parser-0.7.0.sha256sum] = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3"
-SRC_URI[serde-1.0.173.sha256sum] = "e91f70896d6720bc714a4a57d22fc91f1db634680e65c8efe13323f1fa38d53f"
-SRC_URI[serde_derive-1.0.173.sha256sum] = "a6250dde8342e0232232be9ca3db7aa40aceb5a3e5dd9bddbc00d99a007cde49"
-SRC_URI[serde_json-1.0.103.sha256sum] = "d03b412469450d4404fe8499a268edd7f8b79fecb074b0d812ad64ca21f4031b"
-SRC_URI[serde_spanned-0.6.3.sha256sum] = "96426c9936fd7a0124915f9185ea1d20aa9445cc9821142f0a73bc9207a2e186"
-SRC_URI[servo_arc-0.2.0.sha256sum] = "d52aa42f8fdf0fed91e5ce7f23d8138441002fa31dca008acf47e6fd4721f741"
-SRC_URI[sha1-0.6.1.sha256sum] = "c1da05c97445caa12d05e848c4a4fcbbea29e748ac28f7e80e9b010392063770"
-SRC_URI[sha1_smol-1.0.0.sha256sum] = "ae1a47186c03a32177042e55dbc5fd5aee900b8e0069a8d70fba96a9375cd012"
+SRC_URI[selectors-0.25.0.sha256sum] = "4eb30575f3638fc8f6815f448d50cb1a2e255b0897985c8c59f4d37b72a07b06"
+SRC_URI[serde-1.0.193.sha256sum] = "25dd9975e68d0cb5aa1120c288333fc98731bd1dd12f561e468ea4728c042b89"
+SRC_URI[serde_derive-1.0.193.sha256sum] = "43576ca501357b9b071ac53cdc7da8ef0cbd9493d8df094cd821777ea6e894d3"
+SRC_URI[serde_json-1.0.108.sha256sum] = "3d1c7e3eac408d115102c4c24ad393e0821bb3a5df4d506a80f85f7a742a526b"
+SRC_URI[serde_spanned-0.6.4.sha256sum] = "12022b835073e5b11e90a14f86838ceb1c8fb0325b72416845c487ac0fa95e80"
+SRC_URI[servo_arc-0.3.0.sha256sum] = "d036d71a959e00c77a63538b90a6c2390969f9772b096ea837205c6bd0491a44"
 SRC_URI[simba-0.8.1.sha256sum] = "061507c94fc6ab4ba1c9a0305018408e312e17c041eb63bef8aa726fa33aceae"
-SRC_URI[simd-adler32-0.3.5.sha256sum] = "238abfbb77c1915110ad968465608b68e869e0772622c9656714e73e5a1a522f"
-SRC_URI[siphasher-0.3.10.sha256sum] = "7bd3e3206899af3f8b12af284fafc038cc1dc2b41d1b89dd17297221c5d225de"
-SRC_URI[slab-0.4.8.sha256sum] = "6528351c9bc8ab22353f9d776db39a20288e8d6c37ef8cfe3317cf875eecfc2d"
-SRC_URI[smallvec-1.11.0.sha256sum] = "62bb4feee49fdd9f707ef802e22365a35de4b7b299de4763d44bfea899442ff9"
+SRC_URI[simd-adler32-0.3.7.sha256sum] = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
+SRC_URI[siphasher-0.3.11.sha256sum] = "38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
+SRC_URI[slab-0.4.9.sha256sum] = "8f92a496fb766b417c996b9c5e57daf2f7ad3b0bebe1ccfca4856390e3d3bb67"
+SRC_URI[smallvec-1.11.2.sha256sum] = "4dccd0940a2dcdf68d092b8cbab7dc0ad8fa938bf95787e1b916b0e3d0e8e970"
 SRC_URI[stable_deref_trait-1.2.0.sha256sum] = "a8f112729512f8e442d81f95a8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
-SRC_URI[standback-0.2.17.sha256sum] = "e113fb6f3de07a243d434a56ec6f186dfd51cb08448239fe7bcae73f87ff28ff"
-SRC_URI[stdweb-0.4.20.sha256sum] = "d022496b16281348b52d0e30ae99e01a73d737b2f45d38fed4edf79f9325a1d5"
-SRC_URI[stdweb-derive-0.5.3.sha256sum] = "c87a60a40fccc84bef0652345bbbbbe20a605bf5d0ce81719fc476f5c03b50ef"
-SRC_URI[stdweb-internal-macros-0.2.9.sha256sum] = "58fa5ff6ad0d98d1ffa8cb115892b6e69d67799f6763e162a1c9db421dc22e11"
-SRC_URI[stdweb-internal-runtime-0.1.5.sha256sum] = "213701ba3370744dcd1a12960caa4843b3d68b4d1c0a5d575e0d65b2ee9d16c0"
 SRC_URI[string_cache-0.8.7.sha256sum] = "f91138e76242f575eb1d3b38b4f1362f10d3a43f47d182a5b359af488a02293b"
 SRC_URI[string_cache_codegen-0.5.2.sha256sum] = "6bb30289b722be4ff74a408c3cc27edeaad656e06cb1fe8fa9231fa59c728988"
 SRC_URI[strsim-0.10.0.sha256sum] = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.26.sha256sum] = "45c3457aacde3c65315de5031ec191ce46604304d2446e803d71ade03308d970"
-SRC_URI[system-deps-6.1.1.sha256sum] = "30c2de8a4d8f4b823d634affc9cd2a74ec98c53a756f317e529a48046cbf71f3"
-SRC_URI[target-lexicon-0.12.10.sha256sum] = "1d2faeef5759ab89935255b1a4cd98e0baf99d1085e37d36599c625dac49ae8e"
-SRC_URI[tempfile-3.7.0.sha256sum] = "5486094ee78b2e5038a6382ed7645bc084dc2ec433426ca4c3cb61e2007b8998"
+SRC_URI[syn-2.0.41.sha256sum] = "44c8b28c477cc3bf0e7966561e3460130e1255f7a1cf71931075f1c5e7a7e269"
+SRC_URI[system-deps-6.2.0.sha256sum] = "2a2d580ff6a20c55dfb86be5f9c238f67835d0e81cbdea8bf5680e0897320331"
+SRC_URI[target-lexicon-0.12.12.sha256sum] = "14c39fd04924ca3a864207c66fc2cd7d22d7c016007f9ce846cbb9326331930a"
+SRC_URI[tempfile-3.8.1.sha256sum] = "7ef1adac450ad7f4b3c28589471ade84f25f731a7a0fe30d71dfa9f60fd808e5"
 SRC_URI[tendril-0.4.3.sha256sum] = "d24a120c5fc464a3458240ee02c299ebcb9d67b5249c8848b09d639dca8d7bb0"
 SRC_URI[termtree-0.4.1.sha256sum] = "3369f5ac52d5eb6ab48c6b4ffdc8efbcad6b89c765749064ba298f2c68a16a76"
-SRC_URI[textwrap-0.16.0.sha256sum] = "222a222a5bfe1bba4a77b45ec488a741b3cb8872e5e499451fd7d0129c9c7c3d"
-SRC_URI[thiserror-1.0.43.sha256sum] = "a35fc5b8971143ca348fa6df4f024d4d55264f3468c71ad1c2f365b0a4d58c42"
-SRC_URI[thiserror-impl-1.0.43.sha256sum] = "463fe12d7993d3b327787537ce8dd4dfa058de32fc2b195ef3cde03dc4771e8f"
-SRC_URI[time-0.2.27.sha256sum] = "4752a97f8eebd6854ff91f1c1824cd6160626ac4bd44287f7f4ea2035a02a242"
-SRC_URI[time-macros-0.1.1.sha256sum] = "957e9c6e26f12cb6d0dd7fc776bb67a706312e7299aed74c8dd5b17ebb27e2f1"
-SRC_URI[time-macros-impl-0.1.2.sha256sum] = "fd3c141a1b43194f3f56a1411225df8646c55781d5f26db825b3d98507eb482f"
+SRC_URI[thiserror-1.0.50.sha256sum] = "f9a7210f5c9a7156bb50aa36aed4c95afb51df0df00713949448cf9e97d382d2"
+SRC_URI[thiserror-impl-1.0.50.sha256sum] = "266b2e40bc00e5a6c09c3584011e08b06f123c00362c92b975ba9843aaaa14b8"
+SRC_URI[time-0.3.30.sha256sum] = "c4a34ab300f2dee6e562c10a046fc05e358b29f9bf92277f30c3c8d82275f6f5"
+SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
+SRC_URI[time-macros-0.2.15.sha256sum] = "4ad70d68dba9e1f8aceda7aa6711965dfec1cac869f311a51bd08b3a2ccbce20"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.6.0.sha256sum] = "87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.7.6.sha256sum] = "c17e963a819c331dcacd7ab957d80bc2b9a9c1e71c804826d2f283dd65306542"
+SRC_URI[toml-0.8.2.sha256sum] = "185d8ab0dfbb35cf1399a6344d8484209c088f75f8f68230da55d48d95d43e3d"
 SRC_URI[toml_datetime-0.6.3.sha256sum] = "7cda73e2f1397b1262d6dfdcef8aafae14d1de7748d66822d3bfeeb6d03e5e4b"
-SRC_URI[toml_edit-0.19.14.sha256sum] = "f8123f27e969974a3dfba720fdb560be359f57b44302d280ba72e76a74480e8a"
-SRC_URI[typenum-1.16.0.sha256sum] = "497961ef93d974e23eb6f433eb5fe1b7930b659f06d12dec6fc44a8f554c0bba"
+SRC_URI[toml_edit-0.20.2.sha256sum] = "396e4d48bbb2b7554c944bde63101b5ae446cff6ec4a24227428f15eb72ef338"
+SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
-SRC_URI[unicode-bidi-0.3.13.sha256sum] = "92888ba5573ff080736b3648696b70cafad7d250551175acbaa4e0385b3e1460"
-SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
+SRC_URI[unicode-bidi-0.3.14.sha256sum] = "6f2528f27a9eb2b21e69c95319b30bd0efd85d09c379741b0f78ea1d86be2416"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 SRC_URI[unicode-normalization-0.1.22.sha256sum] = "5c5713f0fc4b5db668a2ac63cdb7bb4469d8c9fed047b1d0292cc7b0ce2ba921"
-SRC_URI[url-2.4.0.sha256sum] = "50bff7831e19200a85b17131d085c25d7811bc4e186efdaf54bbd132994a88cb"
+SRC_URI[url-2.5.0.sha256sum] = "31e6302e3bb753d46e83516cae55ae196fc0c309407cf11ab35cc51a4c2a4633"
 SRC_URI[utf-8-0.7.6.sha256sum] = "09cc8ee72d2a9becf2f2febe0205bbed8fc6615b7cb429ad062dc7b7ddd036a9"
 SRC_URI[utf8parse-0.2.1.sha256sum] = "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
 SRC_URI[version-compare-0.1.1.sha256sum] = "579a42fc0b8e0c63b76519a339be31bed574929511fa53c1a3acae26eb258f29"
 SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
-SRC_URI[walkdir-2.3.3.sha256sum] = "36df944cda56c7d8d8b7496af378e6b16de9284591917d307c9b4d313c44e698"
-SRC_URI[wasi-0.9.0+wasi-snapshot-preview1.sha256sum] = "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
+SRC_URI[walkdir-2.4.0.sha256sum] = "d71d857dc86794ca4c280d616f7da00d2dbfd8cd788846559a6813e6aa4b54ee"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
-SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
-SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
-SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
-SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
-SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
+SRC_URI[wasm-bindgen-0.2.89.sha256sum] = "0ed0d4f68a3015cc185aff4db9506a015f4b96f95303897bfa23f846db54064e"
+SRC_URI[wasm-bindgen-backend-0.2.89.sha256sum] = "1b56f625e64f3a1084ded111c4d5f477df9f8c92df113852fa5a374dbda78826"
+SRC_URI[wasm-bindgen-macro-0.2.89.sha256sum] = "0162dbf37223cd2afce98f3d0785506dcb8d266223983e4b5b525859e6e182b2"
+SRC_URI[wasm-bindgen-macro-support-0.2.89.sha256sum] = "f0eb82fcb7930ae6219a7ecfd55b217f5f0893484b7a13022ebb2b2bf20b5283"
+SRC_URI[wasm-bindgen-shared-0.2.89.sha256sum] = "7ab9b36309365056cd639da3134bf87fa8f3d86008abf99e612384a6eecd459f"
+SRC_URI[web-sys-0.3.66.sha256sum] = "50c24a44ec86bb68fbecd1b3efed7e85ea5621b39b35ef2766b66cd984f8010f"
 SRC_URI[weezl-0.1.7.sha256sum] = "9193164d4de03a926d909d3bc7c30543cecb35400c02114792c2cae20d5e2dbb"
-SRC_URI[wide-0.7.11.sha256sum] = "aa469ffa65ef7e0ba0f164183697b89b854253fd31aeb92358b7b6155177d62f"
+SRC_URI[wide-0.7.13.sha256sum] = "c68938b57b33da363195412cfc5fc37c9ed49aa9cfe2156fde64b8d2c9498242"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+SRC_URI[winapi-util-0.1.6.sha256sum] = "f29e6f9198ba0d26b4c9f07dbe6f9ed633e1f3d5b8b414090084349e46a52596"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-0.48.0.sha256sum] = "e686886bc078bc1b0b600cac0147aadb815089b6e4da64016cbd754b6342700f"
+SRC_URI[windows-core-0.51.1.sha256sum] = "f1f8cf84f35d2db49a46868f947758c7a1138116f7fac3bc844f43ade1292e64"
 SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
-SRC_URI[windows-targets-0.48.1.sha256sum] = "05d4b17490f70499f20b9e791dcf6a299785ce8af4d709018206dc5b4953e95f"
-SRC_URI[windows_aarch64_gnullvm-0.48.0.sha256sum] = "91ae572e1b79dba883e0d315474df7305d12f569b400fcf90581b06062f7e1bc"
-SRC_URI[windows_aarch64_msvc-0.48.0.sha256sum] = "b2ef27e0d7bdfcfc7b868b317c1d32c641a6fe4629c171b8928c7b08d98d7cf3"
-SRC_URI[windows_i686_gnu-0.48.0.sha256sum] = "622a1962a7db830d6fd0a69683c80a18fda201879f0f447f065a3b7467daa241"
-SRC_URI[windows_i686_msvc-0.48.0.sha256sum] = "4542c6e364ce21bf45d69fdd2a8e455fa38d316158cfd43b3ac1c5b1b19f8e00"
-SRC_URI[windows_x86_64_gnu-0.48.0.sha256sum] = "ca2b8a661f7628cbd23440e50b05d705db3686f894fc9580820623656af974b1"
-SRC_URI[windows_x86_64_gnullvm-0.48.0.sha256sum] = "7896dbc1f41e08872e9d5e8f8baa8fdd2677f29468c4e156210174edc7f7b953"
-SRC_URI[windows_x86_64_msvc-0.48.0.sha256sum] = "1a515f5799fe4961cb532f983ce2b23082366b898e52ffbce459c86f67c8378a"
-SRC_URI[winnow-0.5.0.sha256sum] = "81fac9742fd1ad1bd9643b991319f72dd031016d44b77039a26977eb667141e7"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
+SRC_URI[windows-targets-0.52.0.sha256sum] = "8a18201040b24831fbb9e4eb208f8892e1f50a37feb53cc7ff887feb8f50e7cd"
+SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
+SRC_URI[windows_aarch64_gnullvm-0.52.0.sha256sum] = "cb7764e35d4db8a7921e09562a0304bf2f93e0a51bfccee0bd0bb0b666b015ea"
+SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] = "dc35310971f3b2dbbf3f0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
+SRC_URI[windows_aarch64_msvc-0.52.0.sha256sum] = "bbaa0368d4f1d2aaefc55b6fcfee13f41544ddf36801e793edbbfd7d7df075ef"
+SRC_URI[windows_i686_gnu-0.48.5.sha256sum] = "a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
+SRC_URI[windows_i686_gnu-0.52.0.sha256sum] = "a28637cb1fa3560a16915793afb20081aba2c92ee8af57b4d5f28e4b3e7df313"
+SRC_URI[windows_i686_msvc-0.48.5.sha256sum] = "8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
+SRC_URI[windows_i686_msvc-0.52.0.sha256sum] = "ffe5e8e31046ce6230cc7215707b816e339ff4d4d67c65dffa206fd0f7aa7b9a"
+SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] = "53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
+SRC_URI[windows_x86_64_gnu-0.52.0.sha256sum] = "3d6fa32db2bc4a2f5abeacf2b69f7992cd09dca97498da74a151a3132c26befd"
+SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
+SRC_URI[windows_x86_64_gnullvm-0.52.0.sha256sum] = "1a657e1e9d3f514745a572a6846d3c7aa7dbe1658c056ed9c3344c4109a6949e"
+SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
+SRC_URI[windows_x86_64_msvc-0.52.0.sha256sum] = "dff9641d1cd4be8d1a070daf9e3773c5f67e78b4d9d42263020c057706765c04"
+SRC_URI[winnow-0.5.28.sha256sum] = "6c830786f7720c2fd27a1a0e27a709dbd3c4d009b56d098fc742d4f4eab91fe2"
 SRC_URI[xml5ever-0.17.0.sha256sum] = "4034e1d05af98b51ad7214527730626f019682d797ba38b51689212118d8e650"
 SRC_URI[yeslogic-fontconfig-sys-4.0.1.sha256sum] = "ec657fd32bbcbeaef5c7bc8e10b3db95b143fab8db0a50079773dbf936fd4f73"
diff --git a/recipes-gnome/librsvg/librsvg/0001-Add-riscv32-support.patch b/recipes-gnome/librsvg/librsvg/0001-Add-riscv32-support.patch
deleted file mode 100644
index 2e36eaf..0000000
--- a/recipes-gnome/librsvg/librsvg/0001-Add-riscv32-support.patch
+++ /dev/null
@@ -1,1511 +0,0 @@
-From a4066c09bec2d4ec956459237e0a48501cc4780f Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Wed, 8 Nov 2023 22:41:54 -0800
-Subject: [PATCH] Add riscv32 support
-
-Upstream-Status: Submitted [https://github.com/sunfishcode/linux-raw-sys/pull/95]
-
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- src/riscv32/ioctl.rs | 1490 +++++++++++++++++++++++++++++++++++++++++-
- 1 file changed, 1488 insertions(+), 2 deletions(-)
-
-diff --git a/src/riscv32/ioctl.rs b/src/riscv32/ioctl.rs
-index 85bcbe8..1d97396 100644
---- a/src/riscv32/ioctl.rs
-+++ b/src/riscv32/ioctl.rs
-@@ -1,3 +1,1489 @@
--/* automatically generated by rust-bindgen 0.65.1 */
--
-+/* automatically generated by rust-bindgen 0.66.1 */
- 
-+pub const FIONREAD: u32 = 21531;
-+pub const FIONBIO: u32 = 21537;
-+pub const FIOCLEX: u32 = 21585;
-+pub const FIONCLEX: u32 = 21584;
-+pub const FIOASYNC: u32 = 21586;
-+pub const FIOQSIZE: u32 = 21600;
-+pub const TCXONC: u32 = 21514;
-+pub const TCFLSH: u32 = 21515;
-+pub const TIOCSCTTY: u32 = 21518;
-+pub const TIOCSPGRP: u32 = 21520;
-+pub const TIOCOUTQ: u32 = 21521;
-+pub const TIOCSTI: u32 = 21522;
-+pub const TIOCSWINSZ: u32 = 21524;
-+pub const TIOCMGET: u32 = 21525;
-+pub const TIOCMBIS: u32 = 21526;
-+pub const TIOCMBIC: u32 = 21527;
-+pub const TIOCMSET: u32 = 21528;
-+pub const TIOCSSOFTCAR: u32 = 21530;
-+pub const TIOCLINUX: u32 = 21532;
-+pub const TIOCCONS: u32 = 21533;
-+pub const TIOCSSERIAL: u32 = 21535;
-+pub const TIOCPKT: u32 = 21536;
-+pub const TIOCNOTTY: u32 = 21538;
-+pub const TIOCSETD: u32 = 21539;
-+pub const TIOCSBRK: u32 = 21543;
-+pub const TIOCCBRK: u32 = 21544;
-+pub const TIOCSRS485: u32 = 21551;
-+pub const TIOCSPTLCK: u32 = 1074025521;
-+pub const TIOCSIG: u32 = 1074025526;
-+pub const TIOCVHANGUP: u32 = 21559;
-+pub const TIOCSERCONFIG: u32 = 21587;
-+pub const TIOCSERGWILD: u32 = 21588;
-+pub const TIOCSERSWILD: u32 = 21589;
-+pub const TIOCSLCKTRMIOS: u32 = 21591;
-+pub const TIOCSERGSTRUCT: u32 = 21592;
-+pub const TIOCSERGETLSR: u32 = 21593;
-+pub const TIOCSERGETMULTI: u32 = 21594;
-+pub const TIOCSERSETMULTI: u32 = 21595;
-+pub const TIOCMIWAIT: u32 = 21596;
-+pub const TCGETS: u32 = 21505;
-+pub const TCGETA: u32 = 21509;
-+pub const TCSBRK: u32 = 21513;
-+pub const TCSBRKP: u32 = 21541;
-+pub const TCSETA: u32 = 21510;
-+pub const TCSETAF: u32 = 21512;
-+pub const TCSETAW: u32 = 21511;
-+pub const TIOCEXCL: u32 = 21516;
-+pub const TIOCNXCL: u32 = 21517;
-+pub const TIOCGDEV: u32 = 2147767346;
-+pub const TIOCGEXCL: u32 = 2147767360;
-+pub const TIOCGICOUNT: u32 = 21597;
-+pub const TIOCGLCKTRMIOS: u32 = 21590;
-+pub const TIOCGPGRP: u32 = 21519;
-+pub const TIOCGPKT: u32 = 2147767352;
-+pub const TIOCGPTLCK: u32 = 2147767353;
-+pub const TIOCGPTN: u32 = 2147767344;
-+pub const TIOCGPTPEER: u32 = 21569;
-+pub const TIOCGRS485: u32 = 21550;
-+pub const TIOCGSERIAL: u32 = 21534;
-+pub const TIOCGSID: u32 = 21545;
-+pub const TIOCGSOFTCAR: u32 = 21529;
-+pub const TIOCGWINSZ: u32 = 21523;
-+pub const TCGETS2: u32 = 2150388778;
-+pub const TCGETX: u32 = 21554;
-+pub const TCSETS: u32 = 21506;
-+pub const TCSETS2: u32 = 1076646955;
-+pub const TCSETSF: u32 = 21508;
-+pub const TCSETSF2: u32 = 1076646957;
-+pub const TCSETSW: u32 = 21507;
-+pub const TCSETSW2: u32 = 1076646956;
-+pub const TCSETX: u32 = 21555;
-+pub const TCSETXF: u32 = 21556;
-+pub const TCSETXW: u32 = 21557;
-+pub const TIOCGETD: u32 = 21540;
-+pub const MTIOCGET: u32 = 2150657282;
-+pub const BLKSSZGET: u32 = 4712;
-+pub const BLKPBSZGET: u32 = 4731;
-+pub const BLKROSET: u32 = 4701;
-+pub const BLKROGET: u32 = 4702;
-+pub const BLKRRPART: u32 = 4703;
-+pub const BLKGETSIZE: u32 = 4704;
-+pub const BLKFLSBUF: u32 = 4705;
-+pub const BLKRASET: u32 = 4706;
-+pub const BLKRAGET: u32 = 4707;
-+pub const BLKFRASET: u32 = 4708;
-+pub const BLKFRAGET: u32 = 4709;
-+pub const BLKSECTSET: u32 = 4710;
-+pub const BLKSECTGET: u32 = 4711;
-+pub const BLKPG: u32 = 4713;
-+pub const BLKBSZGET: u32 = 2148012656;
-+pub const BLKBSZSET: u32 = 1074270833;
-+pub const BLKGETSIZE64: u32 = 2148012658;
-+pub const BLKTRACESETUP: u32 = 3225948787;
-+pub const BLKTRACESTART: u32 = 4724;
-+pub const BLKTRACESTOP: u32 = 4725;
-+pub const BLKTRACETEARDOWN: u32 = 4726;
-+pub const BLKDISCARD: u32 = 4727;
-+pub const BLKIOMIN: u32 = 4728;
-+pub const BLKIOOPT: u32 = 4729;
-+pub const BLKALIGNOFF: u32 = 4730;
-+pub const BLKDISCARDZEROES: u32 = 4732;
-+pub const BLKSECDISCARD: u32 = 4733;
-+pub const BLKROTATIONAL: u32 = 4734;
-+pub const BLKZEROOUT: u32 = 4735;
-+pub const UFFDIO_REGISTER: u32 = 3223366144;
-+pub const UFFDIO_UNREGISTER: u32 = 2148575745;
-+pub const UFFDIO_WAKE: u32 = 2148575746;
-+pub const UFFDIO_COPY: u32 = 3223890435;
-+pub const UFFDIO_ZEROPAGE: u32 = 3223366148;
-+pub const UFFDIO_WRITEPROTECT: u32 = 3222841862;
-+pub const UFFDIO_API: u32 = 3222841919;
-+pub const NS_GET_USERNS: u32 = 46849;
-+pub const NS_GET_PARENT: u32 = 46850;
-+pub const NS_GET_NSTYPE: u32 = 46851;
-+pub const KDGETLED: u32 = 19249;
-+pub const KDSETLED: u32 = 19250;
-+pub const KDGKBLED: u32 = 19300;
-+pub const KDSKBLED: u32 = 19301;
-+pub const KDGKBTYPE: u32 = 19251;
-+pub const KDADDIO: u32 = 19252;
-+pub const KDDELIO: u32 = 19253;
-+pub const KDENABIO: u32 = 19254;
-+pub const KDDISABIO: u32 = 19255;
-+pub const KDSETMODE: u32 = 19258;
-+pub const KDGETMODE: u32 = 19259;
-+pub const KDMKTONE: u32 = 19248;
-+pub const KIOCSOUND: u32 = 19247;
-+pub const GIO_CMAP: u32 = 19312;
-+pub const PIO_CMAP: u32 = 19313;
-+pub const GIO_FONT: u32 = 19296;
-+pub const GIO_FONTX: u32 = 19307;
-+pub const PIO_FONT: u32 = 19297;
-+pub const PIO_FONTX: u32 = 19308;
-+pub const PIO_FONTRESET: u32 = 19309;
-+pub const GIO_SCRNMAP: u32 = 19264;
-+pub const GIO_UNISCRNMAP: u32 = 19305;
-+pub const PIO_SCRNMAP: u32 = 19265;
-+pub const PIO_UNISCRNMAP: u32 = 19306;
-+pub const GIO_UNIMAP: u32 = 19302;
-+pub const PIO_UNIMAP: u32 = 19303;
-+pub const PIO_UNIMAPCLR: u32 = 19304;
-+pub const KDGKBMODE: u32 = 19268;
-+pub const KDSKBMODE: u32 = 19269;
-+pub const KDGKBMETA: u32 = 19298;
-+pub const KDSKBMETA: u32 = 19299;
-+pub const KDGKBENT: u32 = 19270;
-+pub const KDSKBENT: u32 = 19271;
-+pub const KDGKBSENT: u32 = 19272;
-+pub const KDSKBSENT: u32 = 19273;
-+pub const KDGKBDIACR: u32 = 19274;
-+pub const KDGETKEYCODE: u32 = 19276;
-+pub const KDSETKEYCODE: u32 = 19277;
-+pub const KDSIGACCEPT: u32 = 19278;
-+pub const VT_OPENQRY: u32 = 22016;
-+pub const VT_GETMODE: u32 = 22017;
-+pub const VT_SETMODE: u32 = 22018;
-+pub const VT_GETSTATE: u32 = 22019;
-+pub const VT_RELDISP: u32 = 22021;
-+pub const VT_ACTIVATE: u32 = 22022;
-+pub const VT_WAITACTIVE: u32 = 22023;
-+pub const VT_DISALLOCATE: u32 = 22024;
-+pub const VT_RESIZE: u32 = 22025;
-+pub const VT_RESIZEX: u32 = 22026;
-+pub const FIOSETOWN: u32 = 35073;
-+pub const SIOCSPGRP: u32 = 35074;
-+pub const FIOGETOWN: u32 = 35075;
-+pub const SIOCGPGRP: u32 = 35076;
-+pub const SIOCATMARK: u32 = 35077;
-+pub const SIOCGSTAMP: u32 = 35078;
-+pub const TIOCINQ: u32 = 21531;
-+pub const SIOCADDRT: u32 = 35083;
-+pub const SIOCDELRT: u32 = 35084;
-+pub const SIOCGIFNAME: u32 = 35088;
-+pub const SIOCSIFLINK: u32 = 35089;
-+pub const SIOCGIFCONF: u32 = 35090;
-+pub const SIOCGIFFLAGS: u32 = 35091;
-+pub const SIOCSIFFLAGS: u32 = 35092;
-+pub const SIOCGIFADDR: u32 = 35093;
-+pub const SIOCSIFADDR: u32 = 35094;
-+pub const SIOCGIFDSTADDR: u32 = 35095;
-+pub const SIOCSIFDSTADDR: u32 = 35096;
-+pub const SIOCGIFBRDADDR: u32 = 35097;
-+pub const SIOCSIFBRDADDR: u32 = 35098;
-+pub const SIOCGIFNETMASK: u32 = 35099;
-+pub const SIOCSIFNETMASK: u32 = 35100;
-+pub const SIOCGIFMETRIC: u32 = 35101;
-+pub const SIOCSIFMETRIC: u32 = 35102;
-+pub const SIOCGIFMEM: u32 = 35103;
-+pub const SIOCSIFMEM: u32 = 35104;
-+pub const SIOCGIFMTU: u32 = 35105;
-+pub const SIOCSIFMTU: u32 = 35106;
-+pub const SIOCSIFHWADDR: u32 = 35108;
-+pub const SIOCGIFENCAP: u32 = 35109;
-+pub const SIOCSIFENCAP: u32 = 35110;
-+pub const SIOCGIFHWADDR: u32 = 35111;
-+pub const SIOCGIFSLAVE: u32 = 35113;
-+pub const SIOCSIFSLAVE: u32 = 35120;
-+pub const SIOCADDMULTI: u32 = 35121;
-+pub const SIOCDELMULTI: u32 = 35122;
-+pub const SIOCDARP: u32 = 35155;
-+pub const SIOCGARP: u32 = 35156;
-+pub const SIOCSARP: u32 = 35157;
-+pub const SIOCDRARP: u32 = 35168;
-+pub const SIOCGRARP: u32 = 35169;
-+pub const SIOCSRARP: u32 = 35170;
-+pub const SIOCGIFMAP: u32 = 35184;
-+pub const SIOCSIFMAP: u32 = 35185;
-+pub const SIOCRTMSG: u32 = 35085;
-+pub const SIOCSIFNAME: u32 = 35107;
-+pub const SIOCGIFINDEX: u32 = 35123;
-+pub const SIOGIFINDEX: u32 = 35123;
-+pub const SIOCSIFPFLAGS: u32 = 35124;
-+pub const SIOCGIFPFLAGS: u32 = 35125;
-+pub const SIOCDIFADDR: u32 = 35126;
-+pub const SIOCSIFHWBROADCAST: u32 = 35127;
-+pub const SIOCGIFCOUNT: u32 = 35128;
-+pub const SIOCGIFBR: u32 = 35136;
-+pub const SIOCSIFBR: u32 = 35137;
-+pub const SIOCGIFTXQLEN: u32 = 35138;
-+pub const SIOCSIFTXQLEN: u32 = 35139;
-+pub const SIOCADDDLCI: u32 = 35200;
-+pub const SIOCDELDLCI: u32 = 35201;
-+pub const SIOCDEVPRIVATE: u32 = 35312;
-+pub const SIOCPROTOPRIVATE: u32 = 35296;
-+pub const FIBMAP: u32 = 1;
-+pub const FIGETBSZ: u32 = 2;
-+pub const FIFREEZE: u32 = 3221510263;
-+pub const FITHAW: u32 = 3221510264;
-+pub const FITRIM: u32 = 3222820985;
-+pub const FICLONE: u32 = 1074041865;
-+pub const FICLONERANGE: u32 = 1075876877;
-+pub const FIDEDUPERANGE: u32 = 3222836278;
-+pub const FS_IOC_GETFLAGS: u32 = 2148034049;
-+pub const FS_IOC_SETFLAGS: u32 = 1074292226;
-+pub const FS_IOC_GETVERSION: u32 = 2148038145;
-+pub const FS_IOC_SETVERSION: u32 = 1074296322;
-+pub const FS_IOC_FIEMAP: u32 = 3223348747;
-+pub const FS_IOC32_GETFLAGS: u32 = 2147771905;
-+pub const FS_IOC32_SETFLAGS: u32 = 1074030082;
-+pub const FS_IOC32_GETVERSION: u32 = 2147776001;
-+pub const FS_IOC32_SETVERSION: u32 = 1074034178;
-+pub const FS_IOC_FSGETXATTR: u32 = 2149341215;
-+pub const FS_IOC_FSSETXATTR: u32 = 1075599392;
-+pub const FS_IOC_GETFSLABEL: u32 = 2164298801;
-+pub const FS_IOC_SETFSLABEL: u32 = 1090556978;
-+pub const EXT4_IOC_GETVERSION: u32 = 2148034051;
-+pub const EXT4_IOC_SETVERSION: u32 = 1074292228;
-+pub const EXT4_IOC_GETVERSION_OLD: u32 = 2148038145;
-+pub const EXT4_IOC_SETVERSION_OLD: u32 = 1074296322;
-+pub const EXT4_IOC_GETRSVSZ: u32 = 2148034053;
-+pub const EXT4_IOC_SETRSVSZ: u32 = 1074292230;
-+pub const EXT4_IOC_GROUP_EXTEND: u32 = 1074292231;
-+pub const EXT4_IOC_MIGRATE: u32 = 26121;
-+pub const EXT4_IOC_ALLOC_DA_BLKS: u32 = 26124;
-+pub const EXT4_IOC_RESIZE_FS: u32 = 1074292240;
-+pub const EXT4_IOC_SWAP_BOOT: u32 = 26129;
-+pub const EXT4_IOC_PRECACHE_EXTENTS: u32 = 26130;
-+pub const EXT4_IOC_CLEAR_ES_CACHE: u32 = 26152;
-+pub const EXT4_IOC_GETSTATE: u32 = 1074030121;
-+pub const EXT4_IOC_GET_ES_CACHE: u32 = 3223348778;
-+pub const EXT4_IOC_CHECKPOINT: u32 = 1074030123;
-+pub const EXT4_IOC_SHUTDOWN: u32 = 2147768445;
-+pub const EXT4_IOC32_GETVERSION: u32 = 2147771907;
-+pub const EXT4_IOC32_SETVERSION: u32 = 1074030084;
-+pub const EXT4_IOC32_GETRSVSZ: u32 = 2147771909;
-+pub const EXT4_IOC32_SETRSVSZ: u32 = 1074030086;
-+pub const EXT4_IOC32_GROUP_EXTEND: u32 = 1074030087;
-+pub const EXT4_IOC32_GETVERSION_OLD: u32 = 2147776001;
-+pub const EXT4_IOC32_SETVERSION_OLD: u32 = 1074034178;
-+pub const VIDIOC_SUBDEV_QUERYSTD: u32 = 2148030015;
-+pub const AUTOFS_DEV_IOCTL_CLOSEMOUNT: u32 = 3222836085;
-+pub const LIRC_SET_SEND_CARRIER: u32 = 1074030867;
-+pub const AUTOFS_IOC_PROTOSUBVER: u32 = 2147783527;
-+pub const PTP_SYS_OFFSET_PRECISE: u32 = 3225435400;
-+pub const FSI_SCOM_WRITE: u32 = 3223352066;
-+pub const ATM_GETCIRANGE: u32 = 1074815370;
-+pub const DMA_BUF_SET_NAME_B: u32 = 1074291201;
-+pub const RIO_CM_EP_GET_LIST_SIZE: u32 = 3221512961;
-+pub const TUNSETPERSIST: u32 = 1074025675;
-+pub const FS_IOC_GET_ENCRYPTION_POLICY: u32 = 1074554389;
-+pub const CEC_RECEIVE: u32 = 3224920326;
-+pub const MGSL_IOCGPARAMS: u32 = 2150657281;
-+pub const ENI_SETMULT: u32 = 1074815335;
-+pub const RIO_GET_EVENT_MASK: u32 = 2147773710;
-+pub const LIRC_GET_MAX_TIMEOUT: u32 = 2147772681;
-+pub const USBDEVFS_CLAIMINTERFACE: u32 = 2147767567;
-+pub const CHIOMOVE: u32 = 1075077889;
-+pub const SONYPI_IOCGBATFLAGS: u32 = 2147579399;
-+pub const BTRFS_IOC_SYNC: u32 = 37896;
-+pub const VIDIOC_TRY_FMT: u32 = 3234879040;
-+pub const LIRC_SET_REC_MODE: u32 = 1074030866;
-+pub const VIDIOC_DQEVENT: u32 = 2156418649;
-+pub const RPMSG_DESTROY_EPT_IOCTL: u32 = 46338;
-+pub const UVCIOC_CTRL_MAP: u32 = 3227546912;
-+pub const VHOST_SET_BACKEND_FEATURES: u32 = 1074310949;
-+pub const VHOST_VSOCK_SET_GUEST_CID: u32 = 1074311008;
-+pub const UI_SET_KEYBIT: u32 = 1074025829;
-+pub const LIRC_SET_REC_TIMEOUT: u32 = 1074030872;
-+pub const FS_IOC_GET_ENCRYPTION_KEY_STATUS: u32 = 3229640218;
-+pub const BTRFS_IOC_TREE_SEARCH_V2: u32 = 3228603409;
-+pub const VHOST_SET_VRING_BASE: u32 = 1074310930;
-+pub const RIO_ENABLE_DOORBELL_RANGE: u32 = 1074294025;
-+pub const VIDIOC_TRY_EXT_CTRLS: u32 = 3223344713;
-+pub const LIRC_GET_REC_MODE: u32 = 2147772674;
-+pub const PPGETTIME: u32 = 2148561045;
-+pub const BTRFS_IOC_RM_DEV: u32 = 1342215179;
-+pub const ATM_SETBACKEND: u32 = 1073897970;
-+pub const FSL_HV_IOCTL_PARTITION_START: u32 = 3222318851;
-+pub const FBIO_WAITEVENT: u32 = 18056;
-+pub const SWITCHTEC_IOCTL_PORT_TO_PFF: u32 = 3222034245;
-+pub const NVME_IOCTL_IO_CMD: u32 = 3225964099;
-+pub const IPMICTL_RECEIVE_MSG_TRUNC: u32 = 3224398091;
-+pub const FDTWADDLE: u32 = 601;
-+pub const NVME_IOCTL_SUBMIT_IO: u32 = 1076907586;
-+pub const NILFS_IOCTL_SYNC: u32 = 2148036234;
-+pub const VIDIOC_SUBDEV_S_DV_TIMINGS: u32 = 3229898327;
-+pub const ASPEED_LPC_CTRL_IOCTL_GET_SIZE: u32 = 3222319616;
-+pub const DM_DEV_STATUS: u32 = 3241737479;
-+pub const TEE_IOC_CLOSE_SESSION: u32 = 2147787781;
-+pub const NS_GETPSTAT: u32 = 3222298977;
-+pub const UI_SET_PROPBIT: u32 = 1074025838;
-+pub const TUNSETFILTEREBPF: u32 = 2147767521;
-+pub const RIO_MPORT_MAINT_COMPTAG_SET: u32 = 1074031874;
-+pub const AUTOFS_DEV_IOCTL_VERSION: u32 = 3222836081;
-+pub const WDIOC_SETOPTIONS: u32 = 2147768068;
-+pub const VHOST_SCSI_SET_ENDPOINT: u32 = 1088991040;
-+pub const MGSL_IOCGTXIDLE: u32 = 27907;
-+pub const ATM_ADDLECSADDR: u32 = 1074815374;
-+pub const FSL_HV_IOCTL_GETPROP: u32 = 3223891719;
-+pub const FDGETPRM: u32 = 2149581316;
-+pub const HIDIOCAPPLICATION: u32 = 18434;
-+pub const ENI_MEMDUMP: u32 = 1074815328;
-+pub const PTP_SYS_OFFSET2: u32 = 1128283406;
-+pub const VIDIOC_SUBDEV_G_DV_TIMINGS: u32 = 3229898328;
-+pub const DMA_BUF_SET_NAME_A: u32 = 1074029057;
-+pub const PTP_PIN_GETFUNC: u32 = 3227532550;
-+pub const PTP_SYS_OFFSET_EXTENDED: u32 = 3300932873;
-+pub const DFL_FPGA_PORT_UINT_SET_IRQ: u32 = 1074312776;
-+pub const RTC_EPOCH_READ: u32 = 2148036621;
-+pub const VIDIOC_SUBDEV_S_SELECTION: u32 = 3225441854;
-+pub const VIDIOC_QUERY_EXT_CTRL: u32 = 3236451943;
-+pub const ATM_GETLECSADDR: u32 = 1074815376;
-+pub const FSL_HV_IOCTL_PARTITION_STOP: u32 = 3221794564;
-+pub const SONET_GETDIAG: u32 = 2147770644;
-+pub const ATMMPC_DATA: u32 = 25049;
-+pub const IPMICTL_UNREGISTER_FOR_CMD_CHANS: u32 = 2148296989;
-+pub const HIDIOCGCOLLECTIONINDEX: u32 = 1075333136;
-+pub const RPMSG_CREATE_EPT_IOCTL: u32 = 1076409601;
-+pub const GPIOHANDLE_GET_LINE_VALUES_IOCTL: u32 = 3225465864;
-+pub const UI_DEV_SETUP: u32 = 1079792899;
-+pub const ISST_IF_IO_CMD: u32 = 1074331138;
-+pub const RIO_MPORT_MAINT_READ_REMOTE: u32 = 2149084423;
-+pub const VIDIOC_OMAP3ISP_HIST_CFG: u32 = 3224393412;
-+pub const BLKGETNRZONES: u32 = 2147750533;
-+pub const VIDIOC_G_MODULATOR: u32 = 3225703990;
-+pub const VBG_IOCTL_WRITE_CORE_DUMP: u32 = 3223082515;
-+pub const USBDEVFS_SETINTERFACE: u32 = 2148029700;
-+pub const PPPIOCGCHAN: u32 = 2147775543;
-+pub const EVIOCGVERSION: u32 = 2147763457;
-+pub const VHOST_NET_SET_BACKEND: u32 = 1074310960;
-+pub const USBDEVFS_REAPURBNDELAY: u32 = 1074287885;
-+pub const RNDZAPENTCNT: u32 = 20996;
-+pub const VIDIOC_G_PARM: u32 = 3234616853;
-+pub const TUNGETDEVNETNS: u32 = 21731;
-+pub const LIRC_SET_MEASURE_CARRIER_MODE: u32 = 1074030877;
-+pub const VHOST_SET_VRING_ERR: u32 = 1074310946;
-+pub const VDUSE_VQ_SETUP: u32 = 1075872020;
-+pub const AUTOFS_IOC_SETTIMEOUT: u32 = 3221787492;
-+pub const VIDIOC_S_FREQUENCY: u32 = 1076647481;
-+pub const F2FS_IOC_SEC_TRIM_FILE: u32 = 1075377428;
-+pub const FS_IOC_REMOVE_ENCRYPTION_KEY: u32 = 3225445912;
-+pub const WDIOC_GETPRETIMEOUT: u32 = 2147768073;
-+pub const USBDEVFS_DROP_PRIVILEGES: u32 = 1074025758;
-+pub const BTRFS_IOC_SNAP_CREATE_V2: u32 = 1342215191;
-+pub const VHOST_VSOCK_SET_RUNNING: u32 = 1074048865;
-+pub const STP_SET_OPTIONS: u32 = 1074275586;
-+pub const FBIO_RADEON_GET_MIRROR: u32 = 2148024323;
-+pub const IVTVFB_IOC_DMA_FRAME: u32 = 1075336896;
-+pub const IPMICTL_SEND_COMMAND: u32 = 2150131981;
-+pub const VIDIOC_G_ENC_INDEX: u32 = 2283296332;
-+pub const DFL_FPGA_FME_PORT_PR: u32 = 46720;
-+pub const CHIOSVOLTAG: u32 = 1076912914;
-+pub const ATM_SETESIF: u32 = 1074815373;
-+pub const FW_CDEV_IOC_SEND_RESPONSE: u32 = 1075323652;
-+pub const PMU_IOC_GET_MODEL: u32 = 2148024835;
-+pub const JSIOCGBTNMAP: u32 = 2214619700;
-+pub const USBDEVFS_HUB_PORTINFO: u32 = 2155894035;
-+pub const VBG_IOCTL_INTERRUPT_ALL_WAIT_FOR_EVENTS: u32 = 3222820363;
-+pub const FDCLRPRM: u32 = 577;
-+pub const BTRFS_IOC_SCRUB: u32 = 3288372251;
-+pub const USBDEVFS_DISCONNECT: u32 = 21782;
-+pub const TUNSETVNETBE: u32 = 1074025694;
-+pub const ATMTCP_REMOVE: u32 = 24975;
-+pub const VHOST_VDPA_GET_CONFIG: u32 = 2148052851;
-+pub const PPPIOCGNPMODE: u32 = 3221779532;
-+pub const FDGETDRVPRM: u32 = 2155872785;
-+pub const TUNSETVNETLE: u32 = 1074025692;
-+pub const PHN_SETREG: u32 = 1074294790;
-+pub const PPPIOCDETACH: u32 = 1074033724;
-+pub const MMTIMER_GETRES: u32 = 2148035841;
-+pub const VIDIOC_SUBDEV_ENUMSTD: u32 = 3225966105;
-+pub const PPGETFLAGS: u32 = 2147774618;
-+pub const VDUSE_DEV_GET_FEATURES: u32 = 2148040977;
-+pub const CAPI_MANUFACTURER_CMD: u32 = 3222291232;
-+pub const VIDIOC_G_TUNER: u32 = 3226752541;
-+pub const DM_TABLE_STATUS: u32 = 3241737484;
-+pub const DM_DEV_ARM_POLL: u32 = 3241737488;
-+pub const NE_CREATE_VM: u32 = 2148052512;
-+pub const MEDIA_IOC_ENUM_LINKS: u32 = 3223878658;
-+pub const F2FS_IOC_PRECACHE_EXTENTS: u32 = 62735;
-+pub const DFL_FPGA_PORT_DMA_MAP: u32 = 46659;
-+pub const MGSL_IOCGXCTRL: u32 = 27926;
-+pub const FW_CDEV_IOC_SEND_REQUEST: u32 = 1076372225;
-+pub const SONYPI_IOCGBLUE: u32 = 2147579400;
-+pub const F2FS_IOC_DECOMPRESS_FILE: u32 = 62743;
-+pub const I2OHTML: u32 = 3224398089;
-+pub const VFIO_GET_API_VERSION: u32 = 15204;
-+pub const IDT77105_GETSTATZ: u32 = 1074815283;
-+pub const I2OPARMSET: u32 = 3223873795;
-+pub const TEE_IOC_CANCEL: u32 = 2148049924;
-+pub const PTP_SYS_OFFSET_PRECISE2: u32 = 3225435409;
-+pub const DFL_FPGA_PORT_RESET: u32 = 46656;
-+pub const PPPIOCGASYNCMAP: u32 = 2147775576;
-+pub const EVIOCGKEYCODE_V2: u32 = 2150122756;
-+pub const DM_DEV_SET_GEOMETRY: u32 = 3241737487;
-+pub const HIDIOCSUSAGE: u32 = 1075333132;
-+pub const FW_CDEV_IOC_DEALLOCATE_ISO_RESOURCE_ONCE: u32 = 1075323664;
-+pub const PTP_EXTTS_REQUEST: u32 = 1074806018;
-+pub const SWITCHTEC_IOCTL_EVENT_CTL: u32 = 3223869251;
-+pub const WDIOC_SETPRETIMEOUT: u32 = 3221509896;
-+pub const VHOST_SCSI_CLEAR_ENDPOINT: u32 = 1088991041;
-+pub const JSIOCGAXES: u32 = 2147576337;
-+pub const HIDIOCSFLAG: u32 = 1074022415;
-+pub const PTP_PEROUT_REQUEST2: u32 = 1077427468;
-+pub const PPWDATA: u32 = 1073836166;
-+pub const PTP_CLOCK_GETCAPS: u32 = 2152742145;
-+pub const FDGETMAXERRS: u32 = 2148794894;
-+pub const TUNSETQUEUE: u32 = 1074025689;
-+pub const PTP_ENABLE_PPS: u32 = 1074019588;
-+pub const SIOCSIFATMTCP: u32 = 24960;
-+pub const CEC_ADAP_G_LOG_ADDRS: u32 = 2153537795;
-+pub const ND_IOCTL_ARS_CAP: u32 = 3223342593;
-+pub const NBD_SET_BLKSIZE: u32 = 43777;
-+pub const NBD_SET_TIMEOUT: u32 = 43785;
-+pub const VHOST_SCSI_GET_ABI_VERSION: u32 = 1074048834;
-+pub const RIO_UNMAP_INBOUND: u32 = 1074294034;
-+pub const ATM_QUERYLOOP: u32 = 1074815316;
-+pub const DFL_FPGA_GET_API_VERSION: u32 = 46592;
-+pub const USBDEVFS_WAIT_FOR_RESUME: u32 = 21795;
-+pub const FBIO_CURSOR: u32 = 3228059144;
-+pub const RNDCLEARPOOL: u32 = 20998;
-+pub const VIDIOC_QUERYSTD: u32 = 2148030015;
-+pub const DMA_BUF_IOCTL_SYNC: u32 = 1074291200;
-+pub const SCIF_RECV: u32 = 3222827783;
-+pub const PTP_PIN_GETFUNC2: u32 = 3227532559;
-+pub const FW_CDEV_IOC_ALLOCATE: u32 = 3223331586;
-+pub const CEC_ADAP_G_CAPS: u32 = 3226231040;
-+pub const VIDIOC_G_FBUF: u32 = 2150651402;
-+pub const PTP_ENABLE_PPS2: u32 = 1074019597;
-+pub const PCITEST_CLEAR_IRQ: u32 = 20496;
-+pub const IPMICTL_SET_GETS_EVENTS_CMD: u32 = 2147772688;
-+pub const BTRFS_IOC_DEVICES_READY: u32 = 2415957031;
-+pub const JSIOCGAXMAP: u32 = 2151705138;
-+pub const FW_CDEV_IOC_GET_CYCLE_TIMER: u32 = 2148541196;
-+pub const FW_CDEV_IOC_SET_ISO_CHANNELS: u32 = 1074799383;
-+pub const RTC_WIE_OFF: u32 = 28688;
-+pub const PPGETMODE: u32 = 2147774616;
-+pub const VIDIOC_DBG_G_REGISTER: u32 = 3224917584;
-+pub const PTP_SYS_OFFSET: u32 = 1128283397;
-+pub const BTRFS_IOC_SPACE_INFO: u32 = 3222311956;
-+pub const VIDIOC_SUBDEV_ENUM_FRAME_SIZE: u32 = 3225441866;
-+pub const ND_IOCTL_VENDOR: u32 = 3221769737;
-+pub const SCIF_VREADFROM: u32 = 3223876364;
-+pub const BTRFS_IOC_TRANS_START: u32 = 37894;
-+pub const INOTIFY_IOC_SETNEXTWD: u32 = 1074022656;
-+pub const SNAPSHOT_GET_IMAGE_SIZE: u32 = 2148021006;
-+pub const TUNDETACHFILTER: u32 = 1074812118;
-+pub const ND_IOCTL_CLEAR_ERROR: u32 = 3223342596;
-+pub const IOC_PR_CLEAR: u32 = 1074819277;
-+pub const SCIF_READFROM: u32 = 3223876362;
-+pub const PPPIOCGDEBUG: u32 = 2147775553;
-+pub const BLKGETZONESZ: u32 = 2147750532;
-+pub const HIDIOCGUSAGES: u32 = 3491514387;
-+pub const SONYPI_IOCGTEMP: u32 = 2147579404;
-+pub const UI_SET_MSCBIT: u32 = 1074025832;
-+pub const APM_IOC_SUSPEND: u32 = 16642;
-+pub const BTRFS_IOC_TREE_SEARCH: u32 = 3489698833;
-+pub const RTC_PLL_GET: u32 = 2149609489;
-+pub const RIO_CM_EP_GET_LIST: u32 = 3221512962;
-+pub const USBDEVFS_DISCSIGNAL: u32 = 2148553998;
-+pub const LIRC_GET_MIN_TIMEOUT: u32 = 2147772680;
-+pub const SWITCHTEC_IOCTL_EVENT_SUMMARY_LEGACY: u32 = 2174244674;
-+pub const DM_TARGET_MSG: u32 = 3241737486;
-+pub const SONYPI_IOCGBAT1REM: u32 = 2147644931;
-+pub const EVIOCSFF: u32 = 1076905344;
-+pub const TUNSETGROUP: u32 = 1074025678;
-+pub const EVIOCGKEYCODE: u32 = 2148025604;
-+pub const KCOV_REMOTE_ENABLE: u32 = 1075340134;
-+pub const ND_IOCTL_GET_CONFIG_SIZE: u32 = 3222031876;
-+pub const FDEJECT: u32 = 602;
-+pub const TUNSETOFFLOAD: u32 = 1074025680;
-+pub const PPPIOCCONNECT: u32 = 1074033722;
-+pub const ATM_ADDADDR: u32 = 1074815368;
-+pub const VDUSE_DEV_INJECT_CONFIG_IRQ: u32 = 33043;
-+pub const AUTOFS_DEV_IOCTL_ASKUMOUNT: u32 = 3222836093;
-+pub const VHOST_VDPA_GET_STATUS: u32 = 2147594097;
-+pub const CCISS_PASSTHRU: u32 = 3227009547;
-+pub const MGSL_IOCCLRMODCOUNT: u32 = 27919;
-+pub const TEE_IOC_SUPPL_SEND: u32 = 2148574215;
-+pub const ATMARPD_CTRL: u32 = 25057;
-+pub const UI_ABS_SETUP: u32 = 1075598596;
-+pub const UI_DEV_DESTROY: u32 = 21762;
-+pub const BTRFS_IOC_QUOTA_CTL: u32 = 3222311976;
-+pub const RTC_AIE_ON: u32 = 28673;
-+pub const AUTOFS_IOC_EXPIRE: u32 = 2165085029;
-+pub const PPPIOCSDEBUG: u32 = 1074033728;
-+pub const GPIO_V2_LINE_SET_VALUES_IOCTL: u32 = 3222320143;
-+pub const PPPIOCSMRU: u32 = 1074033746;
-+pub const CCISS_DEREGDISK: u32 = 16908;
-+pub const UI_DEV_CREATE: u32 = 21761;
-+pub const FUSE_DEV_IOC_CLONE: u32 = 2147804416;
-+pub const BTRFS_IOC_START_SYNC: u32 = 2148045848;
-+pub const NILFS_IOCTL_DELETE_CHECKPOINT: u32 = 1074294401;
-+pub const SNAPSHOT_AVAIL_SWAP_SIZE: u32 = 2148021011;
-+pub const DM_TABLE_CLEAR: u32 = 3241737482;
-+pub const CCISS_GETINTINFO: u32 = 2148024834;
-+pub const PPPIOCSASYNCMAP: u32 = 1074033751;
-+pub const I2OEVTGET: u32 = 2154326283;
-+pub const NVME_IOCTL_RESET: u32 = 20036;
-+pub const PPYIELD: u32 = 28813;
-+pub const NVME_IOCTL_IO64_CMD: u32 = 3226488392;
-+pub const TUNSETCARRIER: u32 = 1074025698;
-+pub const DM_DEV_WAIT: u32 = 3241737480;
-+pub const RTC_WIE_ON: u32 = 28687;
-+pub const MEDIA_IOC_DEVICE_INFO: u32 = 3238034432;
-+pub const RIO_CM_CHAN_CREATE: u32 = 3221381891;
-+pub const MGSL_IOCSPARAMS: u32 = 1076915456;
-+pub const RTC_SET_TIME: u32 = 1076129802;
-+pub const VHOST_RESET_OWNER: u32 = 44802;
-+pub const IOC_OPAL_PSID_REVERT_TPR: u32 = 1091072232;
-+pub const AUTOFS_DEV_IOCTL_OPENMOUNT: u32 = 3222836084;
-+pub const UDF_GETEABLOCK: u32 = 2148035649;
-+pub const VFIO_IOMMU_MAP_DMA: u32 = 15217;
-+pub const VIDIOC_SUBSCRIBE_EVENT: u32 = 1075861082;
-+pub const HIDIOCGFLAG: u32 = 2147764238;
-+pub const HIDIOCGUCODE: u32 = 3222816781;
-+pub const VIDIOC_OMAP3ISP_AF_CFG: u32 = 3226228421;
-+pub const DM_REMOVE_ALL: u32 = 3241737473;
-+pub const ASPEED_LPC_CTRL_IOCTL_MAP: u32 = 1074835969;
-+pub const CCISS_GETFIRMVER: u32 = 2147762696;
-+pub const ND_IOCTL_ARS_START: u32 = 3223342594;
-+pub const PPPIOCSMRRU: u32 = 1074033723;
-+pub const CEC_ADAP_S_LOG_ADDRS: u32 = 3227279620;
-+pub const RPROC_GET_SHUTDOWN_ON_RELEASE: u32 = 2147792642;
-+pub const DMA_HEAP_IOCTL_ALLOC: u32 = 3222816768;
-+pub const PPSETTIME: u32 = 1074819222;
-+pub const RTC_ALM_READ: u32 = 2149871624;
-+pub const VDUSE_SET_API_VERSION: u32 = 1074299137;
-+pub const RIO_MPORT_MAINT_WRITE_REMOTE: u32 = 1075342600;
-+pub const VIDIOC_SUBDEV_S_CROP: u32 = 3224917564;
-+pub const USBDEVFS_CONNECT: u32 = 21783;
-+pub const SYNC_IOC_FILE_INFO: u32 = 3224911364;
-+pub const ATMARP_MKIP: u32 = 25058;
-+pub const VFIO_IOMMU_SPAPR_TCE_GET_INFO: u32 = 15216;
-+pub const CCISS_GETHEARTBEAT: u32 = 2147762694;
-+pub const ATM_RSTADDR: u32 = 1074815367;
-+pub const NBD_SET_SIZE: u32 = 43778;
-+pub const UDF_GETVOLIDENT: u32 = 2148035650;
-+pub const GPIO_V2_LINE_GET_VALUES_IOCTL: u32 = 3222320142;
-+pub const MGSL_IOCSTXIDLE: u32 = 27906;
-+pub const FSL_HV_IOCTL_SETPROP: u32 = 3223891720;
-+pub const BTRFS_IOC_GET_DEV_STATS: u32 = 3288896564;
-+pub const PPRSTATUS: u32 = 2147577985;
-+pub const MGSL_IOCTXENABLE: u32 = 27908;
-+pub const UDF_GETEASIZE: u32 = 2147773504;
-+pub const NVME_IOCTL_ADMIN64_CMD: u32 = 3226488391;
-+pub const VHOST_SET_OWNER: u32 = 44801;
-+pub const RIO_ALLOC_DMA: u32 = 3222826259;
-+pub const RIO_CM_CHAN_ACCEPT: u32 = 3221775111;
-+pub const I2OHRTGET: u32 = 3222825217;
-+pub const ATM_SETCIRANGE: u32 = 1074815371;
-+pub const HPET_IE_ON: u32 = 26625;
-+pub const PERF_EVENT_IOC_ID: u32 = 2148017159;
-+pub const TUNSETSNDBUF: u32 = 1074025684;
-+pub const PTP_PIN_SETFUNC: u32 = 1080048903;
-+pub const PPPIOCDISCONN: u32 = 29753;
-+pub const VIDIOC_QUERYCTRL: u32 = 3225703972;
-+pub const PPEXCL: u32 = 28815;
-+pub const PCITEST_MSI: u32 = 1074024451;
-+pub const FDWERRORCLR: u32 = 598;
-+pub const AUTOFS_IOC_FAIL: u32 = 37729;
-+pub const USBDEVFS_IOCTL: u32 = 3222295826;
-+pub const VIDIOC_S_STD: u32 = 1074288152;
-+pub const F2FS_IOC_RESIZE_FS: u32 = 1074328848;
-+pub const SONET_SETDIAG: u32 = 3221512466;
-+pub const BTRFS_IOC_DEFRAG: u32 = 1342215170;
-+pub const CCISS_GETDRIVVER: u32 = 2147762697;
-+pub const IPMICTL_GET_TIMING_PARMS_CMD: u32 = 2148034839;
-+pub const HPET_IRQFREQ: u32 = 1074292742;
-+pub const ATM_GETESI: u32 = 1074815365;
-+pub const CCISS_GETLUNINFO: u32 = 2148286993;
-+pub const AUTOFS_DEV_IOCTL_ISMOUNTPOINT: u32 = 3222836094;
-+pub const TEE_IOC_SHM_ALLOC: u32 = 3222316033;
-+pub const PERF_EVENT_IOC_SET_BPF: u32 = 1074013192;
-+pub const UDMABUF_CREATE_LIST: u32 = 1074296131;
-+pub const VHOST_SET_LOG_BASE: u32 = 1074310916;
-+pub const ZATM_GETPOOL: u32 = 1074815329;
-+pub const BR2684_SETFILT: u32 = 1075601808;
-+pub const RNDGETPOOL: u32 = 2148028930;
-+pub const PPS_GETPARAMS: u32 = 2148036769;
-+pub const IOC_PR_RESERVE: u32 = 1074819273;
-+pub const VIDIOC_TRY_DECODER_CMD: u32 = 3225966177;
-+pub const RIO_CM_CHAN_CLOSE: u32 = 1073898244;
-+pub const VIDIOC_DV_TIMINGS_CAP: u32 = 3230684772;
-+pub const IOCTL_MEI_CONNECT_CLIENT_VTAG: u32 = 3222554628;
-+pub const PMU_IOC_GET_BACKLIGHT: u32 = 2148024833;
-+pub const USBDEVFS_GET_CAPABILITIES: u32 = 2147767578;
-+pub const SCIF_WRITETO: u32 = 3223876363;
-+pub const UDF_RELOCATE_BLOCKS: u32 = 3221777475;
-+pub const FSL_HV_IOCTL_PARTITION_RESTART: u32 = 3221794561;
-+pub const CCISS_REGNEWD: u32 = 16910;
-+pub const FAT_IOCTL_SET_ATTRIBUTES: u32 = 1074033169;
-+pub const VIDIOC_CREATE_BUFS: u32 = 3238024796;
-+pub const CAPI_GET_VERSION: u32 = 3222291207;
-+pub const SWITCHTEC_IOCTL_EVENT_SUMMARY: u32 = 2228770626;
-+pub const VFIO_EEH_PE_OP: u32 = 15225;
-+pub const FW_CDEV_IOC_CREATE_ISO_CONTEXT: u32 = 3223331592;
-+pub const F2FS_IOC_RELEASE_COMPRESS_BLOCKS: u32 = 2148070674;
-+pub const NBD_SET_SIZE_BLOCKS: u32 = 43783;
-+pub const IPMI_BMC_IOCTL_SET_SMS_ATN: u32 = 45312;
-+pub const ASPEED_P2A_CTRL_IOCTL_GET_MEMORY_CONFIG: u32 = 3222319873;
-+pub const VIDIOC_S_AUDOUT: u32 = 1077171762;
-+pub const VIDIOC_S_FMT: u32 = 3234878981;
-+pub const PPPIOCATTACH: u32 = 1074033725;
-+pub const VHOST_GET_VRING_BUSYLOOP_TIMEOUT: u32 = 1074310948;
-+pub const FS_IOC_MEASURE_VERITY: u32 = 3221513862;
-+pub const CCISS_BIG_PASSTHRU: u32 = 3227533842;
-+pub const IPMICTL_SET_MY_LUN_CMD: u32 = 2147772691;
-+pub const PCITEST_LEGACY_IRQ: u32 = 20482;
-+pub const USBDEVFS_SUBMITURB: u32 = 2151175434;
-+pub const AUTOFS_IOC_READY: u32 = 37728;
-+pub const BTRFS_IOC_SEND: u32 = 1078498342;
-+pub const VIDIOC_G_EXT_CTRLS: u32 = 3223344711;
-+pub const JSIOCSBTNMAP: u32 = 1140877875;
-+pub const PPPIOCSFLAGS: u32 = 1074033753;
-+pub const NVRAM_INIT: u32 = 28736;
-+pub const RFKILL_IOCTL_NOINPUT: u32 = 20993;
-+pub const BTRFS_IOC_BALANCE: u32 = 1342215180;
-+pub const FS_IOC_GETFSMAP: u32 = 3233830971;
-+pub const IPMICTL_GET_MY_CHANNEL_LUN_CMD: u32 = 2147772699;
-+pub const STP_POLICY_ID_GET: u32 = 2148541697;
-+pub const PPSETFLAGS: u32 = 1074032795;
-+pub const CEC_ADAP_S_PHYS_ADDR: u32 = 1073897730;
-+pub const ATMTCP_CREATE: u32 = 24974;
-+pub const IPMI_BMC_IOCTL_FORCE_ABORT: u32 = 45314;
-+pub const PPPIOCGXASYNCMAP: u32 = 2149610576;
-+pub const VHOST_SET_VRING_CALL: u32 = 1074310945;
-+pub const LIRC_GET_FEATURES: u32 = 2147772672;
-+pub const GSMIOC_DISABLE_NET: u32 = 18179;
-+pub const AUTOFS_IOC_CATATONIC: u32 = 37730;
-+pub const NBD_DO_IT: u32 = 43779;
-+pub const LIRC_SET_REC_CARRIER_RANGE: u32 = 1074030879;
-+pub const IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD: u32 = 2147772697;
-+pub const EVIOCSCLOCKID: u32 = 1074021792;
-+pub const USBDEVFS_FREE_STREAMS: u32 = 2148029725;
-+pub const FSI_SCOM_RESET: u32 = 1074033411;
-+pub const PMU_IOC_GRAB_BACKLIGHT: u32 = 2148024838;
-+pub const VIDIOC_SUBDEV_S_FMT: u32 = 3227014661;
-+pub const FDDEFPRM: u32 = 1075839555;
-+pub const TEE_IOC_INVOKE: u32 = 2148574211;
-+pub const USBDEVFS_BULK: u32 = 3222820098;
-+pub const SCIF_VWRITETO: u32 = 3223876365;
-+pub const SONYPI_IOCSBRT: u32 = 1073837568;
-+pub const BTRFS_IOC_FILE_EXTENT_SAME: u32 = 3222836278;
-+pub const RTC_PIE_ON: u32 = 28677;
-+pub const BTRFS_IOC_SCAN_DEV: u32 = 1342215172;
-+pub const PPPIOCXFERUNIT: u32 = 29774;
-+pub const WDIOC_GETTIMEOUT: u32 = 2147768071;
-+pub const BTRFS_IOC_SET_RECEIVED_SUBVOL: u32 = 3234370597;
-+pub const DFL_FPGA_PORT_ERR_SET_IRQ: u32 = 1074312774;
-+pub const FBIO_WAITFORVSYNC: u32 = 1074021920;
-+pub const RTC_PIE_OFF: u32 = 28678;
-+pub const EVIOCGRAB: u32 = 1074021776;
-+pub const PMU_IOC_SET_BACKLIGHT: u32 = 1074283010;
-+pub const EVIOCGREP: u32 = 2148025603;
-+pub const PERF_EVENT_IOC_MODIFY_ATTRIBUTES: u32 = 1074275339;
-+pub const UFFDIO_CONTINUE: u32 = 3223366151;
-+pub const VDUSE_GET_API_VERSION: u32 = 2148040960;
-+pub const RTC_RD_TIME: u32 = 2149871625;
-+pub const FDMSGOFF: u32 = 582;
-+pub const IPMICTL_REGISTER_FOR_CMD_CHANS: u32 = 2148296988;
-+pub const CAPI_GET_ERRCODE: u32 = 2147631905;
-+pub const PCITEST_SET_IRQTYPE: u32 = 1074024456;
-+pub const VIDIOC_SUBDEV_S_EDID: u32 = 3223868969;
-+pub const MATROXFB_SET_OUTPUT_MODE: u32 = 1074294522;
-+pub const RIO_DEV_ADD: u32 = 1075866903;
-+pub const VIDIOC_ENUM_FREQ_BANDS: u32 = 3225441893;
-+pub const FBIO_RADEON_SET_MIRROR: u32 = 1074282500;
-+pub const PCITEST_GET_IRQTYPE: u32 = 20489;
-+pub const JSIOCGVERSION: u32 = 2147772929;
-+pub const SONYPI_IOCSBLUE: u32 = 1073837577;
-+pub const SNAPSHOT_PREF_IMAGE_SIZE: u32 = 13074;
-+pub const F2FS_IOC_GET_FEATURES: u32 = 2147808524;
-+pub const SCIF_REG: u32 = 3223876360;
-+pub const NILFS_IOCTL_CLEAN_SEGMENTS: u32 = 1081634440;
-+pub const FW_CDEV_IOC_INITIATE_BUS_RESET: u32 = 1074012933;
-+pub const RIO_WAIT_FOR_ASYNC: u32 = 1074294038;
-+pub const VHOST_SET_VRING_NUM: u32 = 1074310928;
-+pub const AUTOFS_DEV_IOCTL_PROTOVER: u32 = 3222836082;
-+pub const RIO_FREE_DMA: u32 = 1074294036;
-+pub const MGSL_IOCRXENABLE: u32 = 27909;
-+pub const IOCTL_VM_SOCKETS_GET_LOCAL_CID: u32 = 1977;
-+pub const IPMICTL_SET_TIMING_PARMS_CMD: u32 = 2148034838;
-+pub const PPPIOCGL2TPSTATS: u32 = 2152231990;
-+pub const PERF_EVENT_IOC_PERIOD: u32 = 1074275332;
-+pub const PTP_PIN_SETFUNC2: u32 = 1080048912;
-+pub const CHIOEXCHANGE: u32 = 1075602178;
-+pub const NILFS_IOCTL_GET_SUINFO: u32 = 2149084804;
-+pub const CEC_DQEVENT: u32 = 3226493191;
-+pub const UI_SET_SWBIT: u32 = 1074025837;
-+pub const VHOST_VDPA_SET_CONFIG: u32 = 1074311028;
-+pub const TUNSETIFF: u32 = 1074025674;
-+pub const CHIOPOSITION: u32 = 1074553603;
-+pub const IPMICTL_SET_MAINTENANCE_MODE_CMD: u32 = 1074030879;
-+pub const BTRFS_IOC_DEFAULT_SUBVOL: u32 = 1074304019;
-+pub const RIO_UNMAP_OUTBOUND: u32 = 1076391184;
-+pub const CAPI_CLR_FLAGS: u32 = 2147762981;
-+pub const FW_CDEV_IOC_ALLOCATE_ISO_RESOURCE_ONCE: u32 = 1075323663;
-+pub const MATROXFB_GET_OUTPUT_CONNECTION: u32 = 2148036344;
-+pub const EVIOCSMASK: u32 = 1074808211;
-+pub const BTRFS_IOC_FORGET_DEV: u32 = 1342215173;
-+pub const CXL_MEM_QUERY_COMMANDS: u32 = 2148060673;
-+pub const CEC_S_MODE: u32 = 1074028809;
-+pub const MGSL_IOCSIF: u32 = 27914;
-+pub const SWITCHTEC_IOCTL_PFF_TO_PORT: u32 = 3222034244;
-+pub const PPSETMODE: u32 = 1074032768;
-+pub const VFIO_DEVICE_SET_IRQS: u32 = 15214;
-+pub const VIDIOC_PREPARE_BUF: u32 = 3227014749;
-+pub const CEC_ADAP_G_CONNECTOR_INFO: u32 = 2151964938;
-+pub const IOC_OPAL_WRITE_SHADOW_MBR: u32 = 1092645098;
-+pub const VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL: u32 = 3225441867;
-+pub const UDMABUF_CREATE: u32 = 1075344706;
-+pub const SONET_CLRDIAG: u32 = 3221512467;
-+pub const PHN_SET_REG: u32 = 1074294785;
-+pub const RNDADDTOENTCNT: u32 = 1074024961;
-+pub const VBG_IOCTL_CHECK_BALLOON: u32 = 3223344657;
-+pub const VIDIOC_OMAP3ISP_STAT_REQ: u32 = 3223869126;
-+pub const PPS_FETCH: u32 = 3221778596;
-+pub const RTC_AIE_OFF: u32 = 28674;
-+pub const VFIO_GROUP_SET_CONTAINER: u32 = 15208;
-+pub const FW_CDEV_IOC_RECEIVE_PHY_PACKETS: u32 = 1074275094;
-+pub const VFIO_IOMMU_SPAPR_TCE_REMOVE: u32 = 15224;
-+pub const VFIO_IOMMU_GET_INFO: u32 = 15216;
-+pub const DM_DEV_SUSPEND: u32 = 3241737478;
-+pub const F2FS_IOC_GET_COMPRESS_OPTION: u32 = 2147677461;
-+pub const FW_CDEV_IOC_STOP_ISO: u32 = 1074012939;
-+pub const GPIO_V2_GET_LINEINFO_IOCTL: u32 = 3238048773;
-+pub const ATMMPC_CTRL: u32 = 25048;
-+pub const PPPIOCSXASYNCMAP: u32 = 1075868751;
-+pub const CHIOGSTATUS: u32 = 1074815752;
-+pub const FW_CDEV_IOC_ALLOCATE_ISO_RESOURCE: u32 = 3222807309;
-+pub const RIO_MPORT_MAINT_PORT_IDX_GET: u32 = 2147773699;
-+pub const CAPI_SET_FLAGS: u32 = 2147762980;
-+pub const VFIO_GROUP_GET_DEVICE_FD: u32 = 15210;
-+pub const VHOST_SET_MEM_TABLE: u32 = 1074310915;
-+pub const MATROXFB_SET_OUTPUT_CONNECTION: u32 = 1074294520;
-+pub const DFL_FPGA_PORT_GET_REGION_INFO: u32 = 46658;
-+pub const VHOST_GET_FEATURES: u32 = 2148052736;
-+pub const LIRC_GET_REC_RESOLUTION: u32 = 2147772679;
-+pub const PACKET_CTRL_CMD: u32 = 3222820865;
-+pub const LIRC_SET_TRANSMITTER_MASK: u32 = 1074030871;
-+pub const BTRFS_IOC_ADD_DEV: u32 = 1342215178;
-+pub const JSIOCGCORR: u32 = 2149870114;
-+pub const VIDIOC_G_FMT: u32 = 3234878980;
-+pub const RTC_EPOCH_SET: u32 = 1074294798;
-+pub const CAPI_GET_PROFILE: u32 = 3225436937;
-+pub const ATM_GETLOOP: u32 = 1074815314;
-+pub const SCIF_LISTEN: u32 = 1074033410;
-+pub const NBD_CLEAR_QUE: u32 = 43781;
-+pub const F2FS_IOC_MOVE_RANGE: u32 = 3223385353;
-+pub const LIRC_GET_LENGTH: u32 = 2147772687;
-+pub const I8K_SET_FAN: u32 = 3221776775;
-+pub const FDSETMAXERRS: u32 = 1075053132;
-+pub const VIDIOC_SUBDEV_QUERYCAP: u32 = 2151699968;
-+pub const SNAPSHOT_SET_SWAP_AREA: u32 = 1074541325;
-+pub const LIRC_GET_REC_TIMEOUT: u32 = 2147772708;
-+pub const EVIOCRMFF: u32 = 1074021761;
-+pub const GPIO_GET_LINEEVENT_IOCTL: u32 = 3224417284;
-+pub const PPRDATA: u32 = 2147577989;
-+pub const RIO_MPORT_GET_PROPERTIES: u32 = 2150657284;
-+pub const TUNSETVNETHDRSZ: u32 = 1074025688;
-+pub const GPIO_GET_LINEINFO_IOCTL: u32 = 3225990146;
-+pub const GSMIOC_GETCONF: u32 = 2152482560;
-+pub const LIRC_GET_SEND_MODE: u32 = 2147772673;
-+pub const PPPIOCSACTIVE: u32 = 1074820166;
-+pub const SIOCGSTAMPNS_NEW: u32 = 2148567303;
-+pub const IPMICTL_RECEIVE_MSG: u32 = 3224398092;
-+pub const LIRC_SET_SEND_DUTY_CYCLE: u32 = 1074030869;
-+pub const UI_END_FF_ERASE: u32 = 1074550219;
-+pub const SWITCHTEC_IOCTL_FLASH_PART_INFO: u32 = 3222296385;
-+pub const FW_CDEV_IOC_SEND_PHY_PACKET: u32 = 3222807317;
-+pub const NBD_SET_FLAGS: u32 = 43786;
-+pub const VFIO_DEVICE_GET_REGION_INFO: u32 = 15212;
-+pub const REISERFS_IOC_UNPACK: u32 = 1074318593;
-+pub const FW_CDEV_IOC_REMOVE_DESCRIPTOR: u32 = 1074012935;
-+pub const RIO_SET_EVENT_MASK: u32 = 1074031885;
-+pub const SNAPSHOT_ALLOC_SWAP_PAGE: u32 = 2148021012;
-+pub const VDUSE_VQ_INJECT_IRQ: u32 = 1074037015;
-+pub const I2OPASSTHRU: u32 = 2148559116;
-+pub const IOC_OPAL_SET_PW: u32 = 1109422304;
-+pub const FSI_SCOM_READ: u32 = 3223352065;
-+pub const VHOST_VDPA_GET_DEVICE_ID: u32 = 2147790704;
-+pub const VIDIOC_QBUF: u32 = 3227014671;
-+pub const VIDIOC_S_TUNER: u32 = 1079268894;
-+pub const TUNGETVNETHDRSZ: u32 = 2147767511;
-+pub const CAPI_NCCI_GETUNIT: u32 = 2147762983;
-+pub const DFL_FPGA_PORT_UINT_GET_IRQ_NUM: u32 = 2147792455;
-+pub const VIDIOC_OMAP3ISP_STAT_EN: u32 = 3221771975;
-+pub const GPIO_V2_LINE_SET_CONFIG_IOCTL: u32 = 3239097357;
-+pub const TEE_IOC_VERSION: u32 = 2148312064;
-+pub const VIDIOC_LOG_STATUS: u32 = 22086;
-+pub const IPMICTL_SEND_COMMAND_SETTIME: u32 = 2150656277;
-+pub const VHOST_SET_LOG_FD: u32 = 1074048775;
-+pub const SCIF_SEND: u32 = 3222827782;
-+pub const VIDIOC_SUBDEV_G_FMT: u32 = 3227014660;
-+pub const NS_ADJBUFLEV: u32 = 24931;
-+pub const VIDIOC_DBG_S_REGISTER: u32 = 1077433935;
-+pub const NILFS_IOCTL_RESIZE: u32 = 1074294411;
-+pub const PHN_GETREG: u32 = 3221778437;
-+pub const I2OSWDL: u32 = 3224398085;
-+pub const VBG_IOCTL_VMMDEV_REQUEST_BIG: u32 = 22019;
-+pub const JSIOCGBUTTONS: u32 = 2147576338;
-+pub const VFIO_IOMMU_ENABLE: u32 = 15219;
-+pub const DM_DEV_RENAME: u32 = 3241737477;
-+pub const MEDIA_IOC_SETUP_LINK: u32 = 3224665091;
-+pub const VIDIOC_ENUMOUTPUT: u32 = 3225966128;
-+pub const STP_POLICY_ID_SET: u32 = 3222283520;
-+pub const VHOST_VDPA_SET_CONFIG_CALL: u32 = 1074048887;
-+pub const VIDIOC_SUBDEV_G_CROP: u32 = 3224917563;
-+pub const VIDIOC_S_CROP: u32 = 1075074620;
-+pub const WDIOC_GETTEMP: u32 = 2147768067;
-+pub const IOC_OPAL_ADD_USR_TO_LR: u32 = 1092120804;
-+pub const UI_SET_LEDBIT: u32 = 1074025833;
-+pub const NBD_SET_SOCK: u32 = 43776;
-+pub const BTRFS_IOC_SNAP_DESTROY_V2: u32 = 1342215231;
-+pub const HIDIOCGCOLLECTIONINFO: u32 = 3222292497;
-+pub const I2OSWUL: u32 = 3224398086;
-+pub const IOCTL_MEI_NOTIFY_GET: u32 = 2147764227;
-+pub const FDFMTTRK: u32 = 1074528840;
-+pub const MMTIMER_GETBITS: u32 = 27908;
-+pub const VIDIOC_ENUMSTD: u32 = 3225966105;
-+pub const VHOST_GET_VRING_BASE: u32 = 3221794578;
-+pub const VFIO_DEVICE_IOEVENTFD: u32 = 15220;
-+pub const ATMARP_SETENTRY: u32 = 25059;
-+pub const CCISS_REVALIDVOLS: u32 = 16906;
-+pub const MGSL_IOCLOOPTXDONE: u32 = 27913;
-+pub const RTC_VL_READ: u32 = 2147774483;
-+pub const ND_IOCTL_ARS_STATUS: u32 = 3224391171;
-+pub const RIO_DEV_DEL: u32 = 1075866904;
-+pub const VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES: u32 = 3223606797;
-+pub const VIDIOC_SUBDEV_DV_TIMINGS_CAP: u32 = 3230684772;
-+pub const SONYPI_IOCSFAN: u32 = 1073837579;
-+pub const SPIOCSTYPE: u32 = 1074295041;
-+pub const IPMICTL_REGISTER_FOR_CMD: u32 = 2147641614;
-+pub const I8K_GET_FAN: u32 = 3221776774;
-+pub const TUNGETVNETBE: u32 = 2147767519;
-+pub const AUTOFS_DEV_IOCTL_FAIL: u32 = 3222836087;
-+pub const UI_END_FF_UPLOAD: u32 = 1080579529;
-+pub const TOSH_SMM: u32 = 3222828176;
-+pub const SONYPI_IOCGBAT2REM: u32 = 2147644933;
-+pub const F2FS_IOC_GET_COMPRESS_BLOCKS: u32 = 2148070673;
-+pub const PPPIOCSNPMODE: u32 = 1074295883;
-+pub const USBDEVFS_CONTROL: u32 = 3222820096;
-+pub const HIDIOCGUSAGE: u32 = 3222816779;
-+pub const TUNSETTXFILTER: u32 = 1074025681;
-+pub const TUNGETVNETLE: u32 = 2147767517;
-+pub const VIDIOC_ENUM_DV_TIMINGS: u32 = 3230946914;
-+pub const BTRFS_IOC_INO_PATHS: u32 = 3224933411;
-+pub const MGSL_IOCGXSYNC: u32 = 27924;
-+pub const HIDIOCGFIELDINFO: u32 = 3224913930;
-+pub const VIDIOC_SUBDEV_G_STD: u32 = 2148029975;
-+pub const I2OVALIDATE: u32 = 2147772680;
-+pub const VIDIOC_TRY_ENCODER_CMD: u32 = 3223869006;
-+pub const NILFS_IOCTL_GET_CPINFO: u32 = 2149084802;
-+pub const VIDIOC_G_FREQUENCY: u32 = 3224131128;
-+pub const VFAT_IOCTL_READDIR_SHORT: u32 = 2184212994;
-+pub const ND_IOCTL_GET_CONFIG_DATA: u32 = 3222031877;
-+pub const F2FS_IOC_RESERVE_COMPRESS_BLOCKS: u32 = 2148070675;
-+pub const FDGETDRVSTAT: u32 = 2152727058;
-+pub const SYNC_IOC_MERGE: u32 = 3224387075;
-+pub const VIDIOC_S_DV_TIMINGS: u32 = 3229898327;
-+pub const PPPIOCBRIDGECHAN: u32 = 1074033717;
-+pub const LIRC_SET_SEND_MODE: u32 = 1074030865;
-+pub const RIO_ENABLE_PORTWRITE_RANGE: u32 = 1074818315;
-+pub const ATM_GETTYPE: u32 = 1074815364;
-+pub const PHN_GETREGS: u32 = 3223875591;
-+pub const FDSETEMSGTRESH: u32 = 586;
-+pub const NILFS_IOCTL_GET_VINFO: u32 = 3222826630;
-+pub const MGSL_IOCWAITEVENT: u32 = 3221515528;
-+pub const CAPI_INSTALLED: u32 = 2147631906;
-+pub const EVIOCGMASK: u32 = 2148550034;
-+pub const BTRFS_IOC_SUBVOL_GETFLAGS: u32 = 2148045849;
-+pub const FSL_HV_IOCTL_PARTITION_GET_STATUS: u32 = 3222056706;
-+pub const MEDIA_IOC_ENUM_ENTITIES: u32 = 3238034433;
-+pub const GSMIOC_GETFIRST: u32 = 2147763972;
-+pub const FW_CDEV_IOC_FLUSH_ISO: u32 = 1074012952;
-+pub const VIDIOC_DBG_G_CHIP_INFO: u32 = 3234354790;
-+pub const F2FS_IOC_RELEASE_VOLATILE_WRITE: u32 = 62724;
-+pub const CAPI_GET_SERIAL: u32 = 3221504776;
-+pub const FDSETDRVPRM: u32 = 1082131088;
-+pub const IOC_OPAL_SAVE: u32 = 1092120796;
-+pub const VIDIOC_G_DV_TIMINGS: u32 = 3229898328;
-+pub const TUNSETIFINDEX: u32 = 1074025690;
-+pub const CCISS_SETINTINFO: u32 = 1074283011;
-+pub const CM_IOSDBGLVL: u32 = 1074291706;
-+pub const RTC_VL_CLR: u32 = 28692;
-+pub const VIDIOC_REQBUFS: u32 = 3222558216;
-+pub const USBDEVFS_REAPURBNDELAY32: u32 = 1074025741;
-+pub const TEE_IOC_SHM_REGISTER: u32 = 3222840329;
-+pub const USBDEVFS_SETCONFIGURATION: u32 = 2147767557;
-+pub const CCISS_GETNODENAME: u32 = 2148549124;
-+pub const VIDIOC_SUBDEV_S_FRAME_INTERVAL: u32 = 3224393238;
-+pub const VIDIOC_ENUM_FRAMESIZES: u32 = 3224131146;
-+pub const VFIO_DEVICE_PCI_HOT_RESET: u32 = 15217;
-+pub const FW_CDEV_IOC_SEND_BROADCAST_REQUEST: u32 = 1076372242;
-+pub const LPSETTIMEOUT_NEW: u32 = 1074791951;
-+pub const RIO_CM_MPORT_GET_LIST: u32 = 3221512971;
-+pub const FW_CDEV_IOC_QUEUE_ISO: u32 = 3222807305;
-+pub const FDRAWCMD: u32 = 600;
-+pub const SCIF_UNREG: u32 = 3222303497;
-+pub const PPPIOCGIDLE64: u32 = 2148561983;
-+pub const USBDEVFS_RELEASEINTERFACE: u32 = 2147767568;
-+pub const VIDIOC_CROPCAP: u32 = 3224131130;
-+pub const DFL_FPGA_PORT_GET_INFO: u32 = 46657;
-+pub const PHN_SET_REGS: u32 = 1074294787;
-+pub const ATMLEC_DATA: u32 = 25041;
-+pub const PPPOEIOCDFWD: u32 = 45313;
-+pub const VIDIOC_S_SELECTION: u32 = 3225441887;
-+pub const SNAPSHOT_FREE_SWAP_PAGES: u32 = 13065;
-+pub const BTRFS_IOC_LOGICAL_INO: u32 = 3224933412;
-+pub const VIDIOC_S_CTRL: u32 = 3221771804;
-+pub const ZATM_SETPOOL: u32 = 1074815331;
-+pub const MTIOCPOS: u32 = 2148035843;
-+pub const PMU_IOC_SLEEP: u32 = 16896;
-+pub const AUTOFS_DEV_IOCTL_PROTOSUBVER: u32 = 3222836083;
-+pub const VBG_IOCTL_CHANGE_FILTER_MASK: u32 = 3223344652;
-+pub const NILFS_IOCTL_GET_SUSTAT: u32 = 2150657669;
-+pub const VIDIOC_QUERYCAP: u32 = 2154321408;
-+pub const HPET_INFO: u32 = 2149083139;
-+pub const VIDIOC_AM437X_CCDC_CFG: u32 = 1074288321;
-+pub const DM_LIST_DEVICES: u32 = 3241737474;
-+pub const TUNSETOWNER: u32 = 1074025676;
-+pub const VBG_IOCTL_CHANGE_GUEST_CAPABILITIES: u32 = 3223344654;
-+pub const RNDADDENTROPY: u32 = 1074287107;
-+pub const USBDEVFS_RESET: u32 = 21780;
-+pub const BTRFS_IOC_SUBVOL_CREATE: u32 = 1342215182;
-+pub const USBDEVFS_FORBID_SUSPEND: u32 = 21793;
-+pub const FDGETDRVTYP: u32 = 2148532751;
-+pub const PPWCONTROL: u32 = 1073836164;
-+pub const VIDIOC_ENUM_FRAMEINTERVALS: u32 = 3224655435;
-+pub const KCOV_DISABLE: u32 = 25445;
-+pub const IOC_OPAL_ACTIVATE_LSP: u32 = 1092120799;
-+pub const VHOST_VDPA_GET_IOVA_RANGE: u32 = 2148577144;
-+pub const PPPIOCSPASS: u32 = 1074820167;
-+pub const RIO_CM_CHAN_CONNECT: u32 = 1074291464;
-+pub const I2OSWDEL: u32 = 3224398087;
-+pub const FS_IOC_SET_ENCRYPTION_POLICY: u32 = 2148296211;
-+pub const IOC_OPAL_MBR_DONE: u32 = 1091596521;
-+pub const PPPIOCSMAXCID: u32 = 1074033745;
-+pub const PPSETPHASE: u32 = 1074032788;
-+pub const VHOST_VDPA_SET_VRING_ENABLE: u32 = 1074311029;
-+pub const USBDEVFS_GET_SPEED: u32 = 21791;
-+pub const SONET_GETFRAMING: u32 = 2147770646;
-+pub const VIDIOC_QUERYBUF: u32 = 3227014665;
-+pub const VIDIOC_S_EDID: u32 = 3223868969;
-+pub const BTRFS_IOC_QGROUP_ASSIGN: u32 = 1075352617;
-+pub const PPS_GETCAP: u32 = 2148036771;
-+pub const SNAPSHOT_PLATFORM_SUPPORT: u32 = 13071;
-+pub const LIRC_SET_REC_TIMEOUT_REPORTS: u32 = 1074030873;
-+pub const SCIF_GET_NODEIDS: u32 = 3222827790;
-+pub const NBD_DISCONNECT: u32 = 43784;
-+pub const VIDIOC_SUBDEV_G_FRAME_INTERVAL: u32 = 3224393237;
-+pub const VFIO_IOMMU_DISABLE: u32 = 15220;
-+pub const SNAPSHOT_CREATE_IMAGE: u32 = 1074017041;
-+pub const SNAPSHOT_POWER_OFF: u32 = 13072;
-+pub const APM_IOC_STANDBY: u32 = 16641;
-+pub const PPPIOCGUNIT: u32 = 2147775574;
-+pub const AUTOFS_IOC_EXPIRE_MULTI: u32 = 1074041702;
-+pub const SCIF_BIND: u32 = 3221779201;
-+pub const IOC_WATCH_QUEUE_SET_SIZE: u32 = 22368;
-+pub const NILFS_IOCTL_CHANGE_CPMODE: u32 = 1074818688;
-+pub const IOC_OPAL_LOCK_UNLOCK: u32 = 1092120797;
-+pub const F2FS_IOC_SET_PIN_FILE: u32 = 1074066701;
-+pub const PPPIOCGRASYNCMAP: u32 = 2147775573;
-+pub const MMTIMER_MMAPAVAIL: u32 = 27910;
-+pub const I2OPASSTHRU32: u32 = 2148034828;
-+pub const DFL_FPGA_FME_PORT_RELEASE: u32 = 1074050689;
-+pub const VIDIOC_SUBDEV_QUERY_DV_TIMINGS: u32 = 2156156515;
-+pub const UI_SET_SNDBIT: u32 = 1074025834;
-+pub const VIDIOC_G_AUDOUT: u32 = 2150913585;
-+pub const RTC_PLL_SET: u32 = 1075867666;
-+pub const VIDIOC_ENUMAUDIO: u32 = 3224655425;
-+pub const AUTOFS_DEV_IOCTL_TIMEOUT: u32 = 3222836090;
-+pub const VBG_IOCTL_DRIVER_VERSION_INFO: u32 = 3224131072;
-+pub const VHOST_SCSI_GET_EVENTS_MISSED: u32 = 1074048836;
-+pub const VHOST_SET_VRING_ADDR: u32 = 1076408081;
-+pub const VDUSE_CREATE_DEV: u32 = 1095794946;
-+pub const FDFLUSH: u32 = 587;
-+pub const VBG_IOCTL_WAIT_FOR_EVENTS: u32 = 3223344650;
-+pub const DFL_FPGA_FME_ERR_SET_IRQ: u32 = 1074312836;
-+pub const F2FS_IOC_GET_PIN_FILE: u32 = 2147808526;
-+pub const SCIF_CONNECT: u32 = 3221779203;
-+pub const BLKREPORTZONE: u32 = 3222278786;
-+pub const AUTOFS_IOC_ASKUMOUNT: u32 = 2147783536;
-+pub const ATM_ADDPARTY: u32 = 1074815476;
-+pub const FDSETPRM: u32 = 1075839554;
-+pub const ATM_GETSTATZ: u32 = 1074815313;
-+pub const ISST_IF_MSR_COMMAND: u32 = 3221814788;
-+pub const BTRFS_IOC_GET_SUBVOL_INFO: u32 = 2180551740;
-+pub const VIDIOC_UNSUBSCRIBE_EVENT: u32 = 1075861083;
-+pub const SEV_ISSUE_CMD: u32 = 3222295296;
-+pub const GPIOHANDLE_SET_LINE_VALUES_IOCTL: u32 = 3225465865;
-+pub const PCITEST_COPY: u32 = 1074286598;
-+pub const IPMICTL_GET_MY_ADDRESS_CMD: u32 = 2147772690;
-+pub const CHIOGPICKER: u32 = 2147771140;
-+pub const CAPI_NCCI_OPENCOUNT: u32 = 2147762982;
-+pub const CXL_MEM_SEND_COMMAND: u32 = 3224423938;
-+pub const PERF_EVENT_IOC_SET_FILTER: u32 = 1074275334;
-+pub const IOC_OPAL_REVERT_TPR: u32 = 1091072226;
-+pub const CHIOGVPARAMS: u32 = 2154849043;
-+pub const PTP_PEROUT_REQUEST: u32 = 1077427459;
-+pub const FSI_SCOM_CHECK: u32 = 2147775232;
-+pub const RTC_IRQP_READ: u32 = 2148036619;
-+pub const RIO_MPORT_MAINT_READ_LOCAL: u32 = 2149084421;
-+pub const HIDIOCGRDESCSIZE: u32 = 2147764225;
-+pub const UI_GET_VERSION: u32 = 2147767597;
-+pub const NILFS_IOCTL_GET_CPSTAT: u32 = 2149084803;
-+pub const CCISS_GETBUSTYPES: u32 = 2147762695;
-+pub const VFIO_IOMMU_SPAPR_TCE_CREATE: u32 = 15223;
-+pub const VIDIOC_EXPBUF: u32 = 3225441808;
-+pub const UI_SET_RELBIT: u32 = 1074025830;
-+pub const VFIO_SET_IOMMU: u32 = 15206;
-+pub const VIDIOC_S_MODULATOR: u32 = 1078220343;
-+pub const TUNGETFILTER: u32 = 2148553947;
-+pub const MEYEIOC_SYNC: u32 = 3221518019;
-+pub const CCISS_SETNODENAME: u32 = 1074807301;
-+pub const FBIO_GETCONTROL2: u32 = 2148025993;
-+pub const TUNSETDEBUG: u32 = 1074025673;
-+pub const DM_DEV_REMOVE: u32 = 3241737476;
-+pub const HIDIOCSUSAGES: u32 = 1344030740;
-+pub const FS_IOC_ADD_ENCRYPTION_KEY: u32 = 3226494487;
-+pub const FBIOGET_VBLANK: u32 = 2149598738;
-+pub const ATM_GETSTAT: u32 = 1074815312;
-+pub const VIDIOC_G_JPEGCOMP: u32 = 2156680765;
-+pub const TUNATTACHFILTER: u32 = 1074812117;
-+pub const UI_SET_ABSBIT: u32 = 1074025831;
-+pub const DFL_FPGA_PORT_ERR_GET_IRQ_NUM: u32 = 2147792453;
-+pub const USBDEVFS_REAPURB32: u32 = 1074025740;
-+pub const BTRFS_IOC_TRANS_END: u32 = 37895;
-+pub const CAPI_REGISTER: u32 = 1074545409;
-+pub const F2FS_IOC_COMPRESS_FILE: u32 = 62744;
-+pub const USBDEVFS_DISCARDURB: u32 = 21771;
-+pub const HE_GET_REG: u32 = 1074815328;
-+pub const ATM_SETLOOP: u32 = 1074815315;
-+pub const ATMSIGD_CTRL: u32 = 25072;
-+pub const CIOC_KERNEL_VERSION: u32 = 3221775114;
-+pub const BTRFS_IOC_CLONE_RANGE: u32 = 1075876877;
-+pub const SNAPSHOT_UNFREEZE: u32 = 13058;
-+pub const F2FS_IOC_START_VOLATILE_WRITE: u32 = 62723;
-+pub const PMU_IOC_HAS_ADB: u32 = 2148024836;
-+pub const I2OGETIOPS: u32 = 2149607680;
-+pub const VIDIOC_S_FBUF: u32 = 1076909579;
-+pub const PPRCONTROL: u32 = 2147577987;
-+pub const CHIOSPICKER: u32 = 1074029317;
-+pub const VFIO_IOMMU_SPAPR_REGISTER_MEMORY: u32 = 15221;
-+pub const TUNGETSNDBUF: u32 = 2147767507;
-+pub const GSMIOC_SETCONF: u32 = 1078740737;
-+pub const IOC_PR_PREEMPT: u32 = 1075343563;
-+pub const KCOV_INIT_TRACE: u32 = 2148033281;
-+pub const SONYPI_IOCGBAT1CAP: u32 = 2147644930;
-+pub const SWITCHTEC_IOCTL_FLASH_INFO: u32 = 2148554560;
-+pub const MTIOCTOP: u32 = 1074294017;
-+pub const VHOST_VDPA_SET_STATUS: u32 = 1073852274;
-+pub const VHOST_SCSI_SET_EVENTS_MISSED: u32 = 1074048835;
-+pub const VFIO_IOMMU_DIRTY_PAGES: u32 = 15221;
-+pub const BTRFS_IOC_SCRUB_PROGRESS: u32 = 3288372253;
-+pub const PPPIOCGMRU: u32 = 2147775571;
-+pub const BTRFS_IOC_DEV_REPLACE: u32 = 3391657013;
-+pub const PPPIOCGFLAGS: u32 = 2147775578;
-+pub const NILFS_IOCTL_SET_SUINFO: u32 = 1075342989;
-+pub const FW_CDEV_IOC_GET_CYCLE_TIMER2: u32 = 3222807316;
-+pub const ATM_DELLECSADDR: u32 = 1074815375;
-+pub const FW_CDEV_IOC_GET_SPEED: u32 = 8977;
-+pub const PPPIOCGIDLE32: u32 = 2148037695;
-+pub const VFIO_DEVICE_RESET: u32 = 15215;
-+pub const GPIO_GET_LINEINFO_UNWATCH_IOCTL: u32 = 3221533708;
-+pub const WDIOC_GETSTATUS: u32 = 2147768065;
-+pub const BTRFS_IOC_SET_FEATURES: u32 = 1076925497;
-+pub const IOCTL_MEI_CONNECT_CLIENT: u32 = 3222292481;
-+pub const VIDIOC_OMAP3ISP_AEWB_CFG: u32 = 3223344835;
-+pub const PCITEST_READ: u32 = 1074286597;
-+pub const VFIO_GROUP_GET_STATUS: u32 = 15207;
-+pub const MATROXFB_GET_ALL_OUTPUTS: u32 = 2148036347;
-+pub const USBDEVFS_CLEAR_HALT: u32 = 2147767573;
-+pub const VIDIOC_DECODER_CMD: u32 = 3225966176;
-+pub const VIDIOC_G_AUDIO: u32 = 2150913569;
-+pub const CCISS_RESCANDISK: u32 = 16912;
-+pub const RIO_DISABLE_PORTWRITE_RANGE: u32 = 1074818316;
-+pub const IOC_OPAL_SECURE_ERASE_LR: u32 = 1091596519;
-+pub const USBDEVFS_REAPURB: u32 = 1074287884;
-+pub const DFL_FPGA_CHECK_EXTENSION: u32 = 46593;
-+pub const AUTOFS_IOC_PROTOVER: u32 = 2147783523;
-+pub const FSL_HV_IOCTL_MEMCPY: u32 = 3223891717;
-+pub const BTRFS_IOC_GET_FEATURES: u32 = 2149094457;
-+pub const PCITEST_MSIX: u32 = 1074024455;
-+pub const BTRFS_IOC_DEFRAG_RANGE: u32 = 1076925456;
-+pub const UI_BEGIN_FF_ERASE: u32 = 3222033866;
-+pub const DM_GET_TARGET_VERSION: u32 = 3241737489;
-+pub const PPPIOCGIDLE: u32 = 2148561983;
-+pub const NVRAM_SETCKS: u32 = 28737;
-+pub const WDIOC_GETSUPPORT: u32 = 2150127360;
-+pub const GSMIOC_ENABLE_NET: u32 = 1077167874;
-+pub const GPIO_GET_CHIPINFO_IOCTL: u32 = 2151986177;
-+pub const NE_ADD_VCPU: u32 = 3221532193;
-+pub const EVIOCSKEYCODE_V2: u32 = 1076380932;
-+pub const PTP_SYS_OFFSET_EXTENDED2: u32 = 3300932882;
-+pub const SCIF_FENCE_WAIT: u32 = 3221517072;
-+pub const RIO_TRANSFER: u32 = 3222826261;
-+pub const FSL_HV_IOCTL_DOORBELL: u32 = 3221794566;
-+pub const RIO_MPORT_MAINT_WRITE_LOCAL: u32 = 1075342598;
-+pub const I2OEVTREG: u32 = 1074555146;
-+pub const I2OPARMGET: u32 = 3223873796;
-+pub const EVIOCGID: u32 = 2148025602;
-+pub const BTRFS_IOC_QGROUP_CREATE: u32 = 1074828330;
-+pub const AUTOFS_DEV_IOCTL_SETPIPEFD: u32 = 3222836088;
-+pub const VIDIOC_S_PARM: u32 = 3234616854;
-+pub const TUNSETSTEERINGEBPF: u32 = 2147767520;
-+pub const ATM_GETNAMES: u32 = 1074815363;
-+pub const VIDIOC_QUERYMENU: u32 = 3224131109;
-+pub const DFL_FPGA_PORT_DMA_UNMAP: u32 = 46660;
-+pub const I2OLCTGET: u32 = 3222825218;
-+pub const FS_IOC_GET_ENCRYPTION_PWSALT: u32 = 1074816532;
-+pub const NS_SETBUFLEV: u32 = 1074815330;
-+pub const BLKCLOSEZONE: u32 = 1074795143;
-+pub const SONET_GETFRSENSE: u32 = 2147901719;
-+pub const UI_SET_EVBIT: u32 = 1074025828;
-+pub const DM_LIST_VERSIONS: u32 = 3241737485;
-+pub const HIDIOCGSTRING: u32 = 2164541444;
-+pub const PPPIOCATTCHAN: u32 = 1074033720;
-+pub const VDUSE_DEV_SET_CONFIG: u32 = 1074299154;
-+pub const TUNGETFEATURES: u32 = 2147767503;
-+pub const VFIO_GROUP_UNSET_CONTAINER: u32 = 15209;
-+pub const IPMICTL_SET_MY_ADDRESS_CMD: u32 = 2147772689;
-+pub const CCISS_REGNEWDISK: u32 = 1074020877;
-+pub const VIDIOC_QUERY_DV_TIMINGS: u32 = 2156156515;
-+pub const PHN_SETREGS: u32 = 1076391944;
-+pub const FAT_IOCTL_GET_ATTRIBUTES: u32 = 2147774992;
-+pub const FSL_MC_SEND_MC_COMMAND: u32 = 3225440992;
-+pub const TUNGETIFF: u32 = 2147767506;
-+pub const PTP_CLOCK_GETCAPS2: u32 = 2152742154;
-+pub const BTRFS_IOC_RESIZE: u32 = 1342215171;
-+pub const VHOST_SET_VRING_ENDIAN: u32 = 1074310931;
-+pub const PPS_KC_BIND: u32 = 1074294949;
-+pub const F2FS_IOC_WRITE_CHECKPOINT: u32 = 62727;
-+pub const UI_SET_FFBIT: u32 = 1074025835;
-+pub const IPMICTL_GET_MY_LUN_CMD: u32 = 2147772692;
-+pub const CEC_ADAP_G_PHYS_ADDR: u32 = 2147639553;
-+pub const CEC_G_MODE: u32 = 2147770632;
-+pub const USBDEVFS_RESETEP: u32 = 2147767555;
-+pub const MEDIA_REQUEST_IOC_QUEUE: u32 = 31872;
-+pub const USBDEVFS_ALLOC_STREAMS: u32 = 2148029724;
-+pub const MGSL_IOCSXCTRL: u32 = 27925;
-+pub const MEDIA_IOC_G_TOPOLOGY: u32 = 3225975812;
-+pub const PPPIOCUNBRIDGECHAN: u32 = 29748;
-+pub const F2FS_IOC_COMMIT_ATOMIC_WRITE: u32 = 62722;
-+pub const ISST_IF_GET_PLATFORM_INFO: u32 = 2148072960;
-+pub const SCIF_FENCE_MARK: u32 = 3222303503;
-+pub const USBDEVFS_RELEASE_PORT: u32 = 2147767577;
-+pub const VFIO_CHECK_EXTENSION: u32 = 15205;
-+pub const BTRFS_IOC_QGROUP_LIMIT: u32 = 2150667307;
-+pub const FAT_IOCTL_GET_VOLUME_ID: u32 = 2147774995;
-+pub const UI_SET_PHYS: u32 = 1074287980;
-+pub const FDWERRORGET: u32 = 2150105623;
-+pub const VIDIOC_SUBDEV_G_EDID: u32 = 3223868968;
-+pub const MGSL_IOCGSTATS: u32 = 27911;
-+pub const RPROC_SET_SHUTDOWN_ON_RELEASE: u32 = 1074050817;
-+pub const SIOCGSTAMP_NEW: u32 = 2148567302;
-+pub const RTC_WKALM_RD: u32 = 2150133776;
-+pub const PHN_GET_REG: u32 = 3221778432;
-+pub const DELL_WMI_SMBIOS_CMD: u32 = 3224655616;
-+pub const PHN_NOT_OH: u32 = 28676;
-+pub const PPGETMODES: u32 = 2147774615;
-+pub const CHIOGPARAMS: u32 = 2148819718;
-+pub const VFIO_DEVICE_GET_GFX_DMABUF: u32 = 15219;
-+pub const VHOST_SET_VRING_BUSYLOOP_TIMEOUT: u32 = 1074310947;
-+pub const VIDIOC_SUBDEV_G_SELECTION: u32 = 3225441853;
-+pub const BTRFS_IOC_RM_DEV_V2: u32 = 1342215226;
-+pub const MGSL_IOCWAITGPIO: u32 = 3222301970;
-+pub const PMU_IOC_CAN_SLEEP: u32 = 2148024837;
-+pub const KCOV_ENABLE: u32 = 25444;
-+pub const BTRFS_IOC_CLONE: u32 = 1074041865;
-+pub const F2FS_IOC_DEFRAGMENT: u32 = 3222336776;
-+pub const FW_CDEV_IOC_DEALLOCATE_ISO_RESOURCE: u32 = 1074012942;
-+pub const AGPIOC_ALLOCATE: u32 = 3221766406;
-+pub const NE_SET_USER_MEMORY_REGION: u32 = 1075359267;
-+pub const MGSL_IOCTXABORT: u32 = 27910;
-+pub const MGSL_IOCSGPIO: u32 = 1074818320;
-+pub const LIRC_SET_REC_CARRIER: u32 = 1074030868;
-+pub const F2FS_IOC_FLUSH_DEVICE: u32 = 1074328842;
-+pub const SNAPSHOT_ATOMIC_RESTORE: u32 = 13060;
-+pub const RTC_UIE_OFF: u32 = 28676;
-+pub const BT_BMC_IOCTL_SMS_ATN: u32 = 45312;
-+pub const NVME_IOCTL_ID: u32 = 20032;
-+pub const NE_START_ENCLAVE: u32 = 3222318628;
-+pub const VIDIOC_STREAMON: u32 = 1074026002;
-+pub const FDPOLLDRVSTAT: u32 = 2152727059;
-+pub const AUTOFS_DEV_IOCTL_READY: u32 = 3222836086;
-+pub const VIDIOC_ENUMAUDOUT: u32 = 3224655426;
-+pub const VIDIOC_SUBDEV_S_STD: u32 = 1074288152;
-+pub const WDIOC_GETTIMELEFT: u32 = 2147768074;
-+pub const ATM_GETLINKRATE: u32 = 1074815361;
-+pub const RTC_WKALM_SET: u32 = 1076391951;
-+pub const VHOST_GET_BACKEND_FEATURES: u32 = 2148052774;
-+pub const ATMARP_ENCAP: u32 = 25061;
-+pub const CAPI_GET_FLAGS: u32 = 2147762979;
-+pub const IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD: u32 = 2147772696;
-+pub const DFL_FPGA_FME_PORT_ASSIGN: u32 = 1074050690;
-+pub const NS_GET_OWNER_UID: u32 = 46852;
-+pub const VIDIOC_OVERLAY: u32 = 1074025998;
-+pub const BTRFS_IOC_WAIT_SYNC: u32 = 1074304022;
-+pub const GPIOHANDLE_SET_CONFIG_IOCTL: u32 = 3226776586;
-+pub const VHOST_GET_VRING_ENDIAN: u32 = 1074310932;
-+pub const ATM_GETADDR: u32 = 1074815366;
-+pub const PHN_GET_REGS: u32 = 3221778434;
-+pub const AUTOFS_DEV_IOCTL_REQUESTER: u32 = 3222836091;
-+pub const AUTOFS_DEV_IOCTL_EXPIRE: u32 = 3222836092;
-+pub const SNAPSHOT_S2RAM: u32 = 13067;
-+pub const JSIOCSAXMAP: u32 = 1077963313;
-+pub const F2FS_IOC_SET_COMPRESS_OPTION: u32 = 1073935638;
-+pub const VBG_IOCTL_HGCM_DISCONNECT: u32 = 3223082501;
-+pub const SCIF_FENCE_SIGNAL: u32 = 3223876369;
-+pub const VFIO_DEVICE_GET_PCI_HOT_RESET_INFO: u32 = 15216;
-+pub const VIDIOC_SUBDEV_ENUM_MBUS_CODE: u32 = 3224393218;
-+pub const MMTIMER_GETOFFSET: u32 = 27904;
-+pub const RIO_CM_CHAN_LISTEN: u32 = 1073898246;
-+pub const ATM_SETSC: u32 = 1074029041;
-+pub const F2FS_IOC_SHUTDOWN: u32 = 2147768445;
-+pub const NVME_IOCTL_RESCAN: u32 = 20038;
-+pub const BLKOPENZONE: u32 = 1074795142;
-+pub const DM_VERSION: u32 = 3241737472;
-+pub const CEC_TRANSMIT: u32 = 3224920325;
-+pub const FS_IOC_GET_ENCRYPTION_POLICY_EX: u32 = 3221841430;
-+pub const SIOCMKCLIP: u32 = 25056;
-+pub const IPMI_BMC_IOCTL_CLEAR_SMS_ATN: u32 = 45313;
-+pub const HIDIOCGVERSION: u32 = 2147764225;
-+pub const VIDIOC_S_INPUT: u32 = 3221509671;
-+pub const VIDIOC_G_CROP: u32 = 3222558267;
-+pub const LIRC_SET_WIDEBAND_RECEIVER: u32 = 1074030883;
-+pub const EVIOCGEFFECTS: u32 = 2147763588;
-+pub const UVCIOC_CTRL_QUERY: u32 = 3222304033;
-+pub const IOC_OPAL_GENERIC_TABLE_RW: u32 = 1094217963;
-+pub const FS_IOC_READ_VERITY_METADATA: u32 = 3223873159;
-+pub const ND_IOCTL_SET_CONFIG_DATA: u32 = 3221769734;
-+pub const USBDEVFS_GETDRIVER: u32 = 1090802952;
-+pub const IDT77105_GETSTAT: u32 = 1074815282;
-+pub const HIDIOCINITREPORT: u32 = 18437;
-+pub const VFIO_DEVICE_GET_INFO: u32 = 15211;
-+pub const RIO_CM_CHAN_RECEIVE: u32 = 3222299402;
-+pub const RNDGETENTCNT: u32 = 2147766784;
-+pub const PPPIOCNEWUNIT: u32 = 3221517374;
-+pub const BTRFS_IOC_INO_LOOKUP: u32 = 3489698834;
-+pub const FDRESET: u32 = 596;
-+pub const IOC_PR_REGISTER: u32 = 1075343560;
-+pub const HIDIOCSREPORT: u32 = 1074546696;
-+pub const TEE_IOC_OPEN_SESSION: u32 = 2148574210;
-+pub const TEE_IOC_SUPPL_RECV: u32 = 2148574214;
-+pub const BTRFS_IOC_BALANCE_CTL: u32 = 1074041889;
-+pub const GPIO_GET_LINEINFO_WATCH_IOCTL: u32 = 3225990155;
-+pub const HIDIOCGRAWINFO: u32 = 2148026371;
-+pub const PPPIOCSCOMPRESS: u32 = 1074820173;
-+pub const USBDEVFS_CONNECTINFO: u32 = 1074287889;
-+pub const BLKRESETZONE: u32 = 1074795139;
-+pub const CHIOINITELEM: u32 = 25361;
-+pub const NILFS_IOCTL_SET_ALLOC_RANGE: u32 = 1074818700;
-+pub const AUTOFS_DEV_IOCTL_CATATONIC: u32 = 3222836089;
-+pub const RIO_MPORT_MAINT_HDID_SET: u32 = 1073900801;
-+pub const PPGETPHASE: u32 = 2147774617;
-+pub const USBDEVFS_DISCONNECT_CLAIM: u32 = 2164806939;
-+pub const FDMSGON: u32 = 581;
-+pub const VIDIOC_G_SLICED_VBI_CAP: u32 = 3228849733;
-+pub const BTRFS_IOC_BALANCE_V2: u32 = 3288372256;
-+pub const MEDIA_REQUEST_IOC_REINIT: u32 = 31873;
-+pub const IOC_OPAL_ERASE_LR: u32 = 1091596518;
-+pub const FDFMTBEG: u32 = 583;
-+pub const RNDRESEEDCRNG: u32 = 20999;
-+pub const ISST_IF_GET_PHY_ID: u32 = 3221814785;
-+pub const TUNSETNOCSUM: u32 = 1074025672;
-+pub const SONET_GETSTAT: u32 = 2149867792;
-+pub const TFD_IOC_SET_TICKS: u32 = 1074287616;
-+pub const PPDATADIR: u32 = 1074032784;
-+pub const IOC_OPAL_ENABLE_DISABLE_MBR: u32 = 1091596517;
-+pub const GPIO_V2_GET_LINE_IOCTL: u32 = 3260068871;
-+pub const RIO_CM_CHAN_SEND: u32 = 1074815753;
-+pub const PPWCTLONIRQ: u32 = 1073836178;
-+pub const SONYPI_IOCGBRT: u32 = 2147579392;
-+pub const IOC_PR_RELEASE: u32 = 1074819274;
-+pub const PPCLRIRQ: u32 = 2147774611;
-+pub const IPMICTL_SET_MY_CHANNEL_LUN_CMD: u32 = 2147772698;
-+pub const MGSL_IOCSXSYNC: u32 = 27923;
-+pub const HPET_IE_OFF: u32 = 26626;
-+pub const IOC_OPAL_ACTIVATE_USR: u32 = 1091596513;
-+pub const SONET_SETFRAMING: u32 = 1074028821;
-+pub const PERF_EVENT_IOC_PAUSE_OUTPUT: u32 = 1074013193;
-+pub const BTRFS_IOC_LOGICAL_INO_V2: u32 = 3224933435;
-+pub const VBG_IOCTL_HGCM_CONNECT: u32 = 3231471108;
-+pub const BLKFINISHZONE: u32 = 1074795144;
-+pub const EVIOCREVOKE: u32 = 1074021777;
-+pub const VFIO_DEVICE_FEATURE: u32 = 15221;
-+pub const CCISS_GETPCIINFO: u32 = 2148024833;
-+pub const ISST_IF_MBOX_COMMAND: u32 = 3221814787;
-+pub const SCIF_ACCEPTREQ: u32 = 3222303492;
-+pub const PERF_EVENT_IOC_QUERY_BPF: u32 = 3221758986;
-+pub const VIDIOC_STREAMOFF: u32 = 1074026003;
-+pub const VDUSE_DESTROY_DEV: u32 = 1090552067;
-+pub const FDGETFDCSTAT: u32 = 2150105621;
-+pub const CM_IOCGATR: u32 = 3221775105;
-+pub const VIDIOC_S_PRIORITY: u32 = 1074026052;
-+pub const SNAPSHOT_FREEZE: u32 = 13057;
-+pub const VIDIOC_ENUMINPUT: u32 = 3226490394;
-+pub const ZATM_GETPOOLZ: u32 = 1074815330;
-+pub const RIO_DISABLE_DOORBELL_RANGE: u32 = 1074294026;
-+pub const GPIO_V2_GET_LINEINFO_WATCH_IOCTL: u32 = 3238048774;
-+pub const VIDIOC_G_STD: u32 = 2148029975;
-+pub const USBDEVFS_ALLOW_SUSPEND: u32 = 21794;
-+pub const SONET_GETSTATZ: u32 = 2149867793;
-+pub const SCIF_ACCEPTREG: u32 = 3221779205;
-+pub const VIDIOC_ENCODER_CMD: u32 = 3223869005;
-+pub const PPPIOCSRASYNCMAP: u32 = 1074033748;
-+pub const IOCTL_MEI_NOTIFY_SET: u32 = 1074022402;
-+pub const BTRFS_IOC_QUOTA_RESCAN_STATUS: u32 = 2151715885;
-+pub const F2FS_IOC_GARBAGE_COLLECT: u32 = 1074066694;
-+pub const ATMLEC_CTRL: u32 = 25040;
-+pub const MATROXFB_GET_AVAILABLE_OUTPUTS: u32 = 2148036345;
-+pub const DM_DEV_CREATE: u32 = 3241737475;
-+pub const VHOST_VDPA_GET_VRING_NUM: u32 = 2147659638;
-+pub const VIDIOC_G_CTRL: u32 = 3221771803;
-+pub const NBD_CLEAR_SOCK: u32 = 43780;
-+pub const VFIO_DEVICE_QUERY_GFX_PLANE: u32 = 15218;
-+pub const WDIOC_KEEPALIVE: u32 = 2147768069;
-+pub const NVME_IOCTL_SUBSYS_RESET: u32 = 20037;
-+pub const PTP_EXTTS_REQUEST2: u32 = 1074806027;
-+pub const PCITEST_BAR: u32 = 20481;
-+pub const MGSL_IOCGGPIO: u32 = 2148560145;
-+pub const EVIOCSREP: u32 = 1074283779;
-+pub const VFIO_DEVICE_GET_IRQ_INFO: u32 = 15213;
-+pub const HPET_DPI: u32 = 26629;
-+pub const VDUSE_VQ_SETUP_KICKFD: u32 = 1074299158;
-+pub const ND_IOCTL_CALL: u32 = 3225439754;
-+pub const HIDIOCGDEVINFO: u32 = 2149337091;
-+pub const DM_TABLE_DEPS: u32 = 3241737483;
-+pub const BTRFS_IOC_DEV_INFO: u32 = 3489698846;
-+pub const VDUSE_IOTLB_GET_FD: u32 = 3223355664;
-+pub const FW_CDEV_IOC_GET_INFO: u32 = 3223855872;
-+pub const VIDIOC_G_PRIORITY: u32 = 2147767875;
-+pub const ATM_NEWBACKENDIF: u32 = 1073897971;
-+pub const VIDIOC_S_EXT_CTRLS: u32 = 3223344712;
-+pub const VIDIOC_SUBDEV_ENUM_DV_TIMINGS: u32 = 3230946914;
-+pub const VIDIOC_OMAP3ISP_CCDC_CFG: u32 = 3224917697;
-+pub const VIDIOC_S_HW_FREQ_SEEK: u32 = 1076909650;
-+pub const DM_TABLE_LOAD: u32 = 3241737481;
-+pub const F2FS_IOC_START_ATOMIC_WRITE: u32 = 62721;
-+pub const VIDIOC_G_OUTPUT: u32 = 2147767854;
-+pub const ATM_DROPPARTY: u32 = 1074029045;
-+pub const CHIOGELEM: u32 = 1080845072;
-+pub const BTRFS_IOC_GET_SUPPORTED_FEATURES: u32 = 2152240185;
-+pub const EVIOCSKEYCODE: u32 = 1074283780;
-+pub const NE_GET_IMAGE_LOAD_INFO: u32 = 3222318626;
-+pub const TUNSETLINK: u32 = 1074025677;
-+pub const FW_CDEV_IOC_ADD_DESCRIPTOR: u32 = 3222807302;
-+pub const BTRFS_IOC_SCRUB_CANCEL: u32 = 37916;
-+pub const PPS_SETPARAMS: u32 = 1074294946;
-+pub const IOC_OPAL_LR_SETUP: u32 = 1093169379;
-+pub const FW_CDEV_IOC_DEALLOCATE: u32 = 1074012931;
-+pub const WDIOC_SETTIMEOUT: u32 = 3221509894;
-+pub const IOC_WATCH_QUEUE_SET_FILTER: u32 = 22369;
-+pub const CAPI_GET_MANUFACTURER: u32 = 3221504774;
-+pub const VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY: u32 = 15222;
-+pub const ASPEED_P2A_CTRL_IOCTL_SET_WINDOW: u32 = 1074836224;
-+pub const VIDIOC_G_EDID: u32 = 3223868968;
-+pub const F2FS_IOC_GARBAGE_COLLECT_RANGE: u32 = 1075377419;
-+pub const RIO_MAP_INBOUND: u32 = 3223874833;
-+pub const IOC_OPAL_TAKE_OWNERSHIP: u32 = 1091072222;
-+pub const USBDEVFS_CLAIM_PORT: u32 = 2147767576;
-+pub const VIDIOC_S_AUDIO: u32 = 1077171746;
-+pub const FS_IOC_GET_ENCRYPTION_NONCE: u32 = 2148558363;
-+pub const FW_CDEV_IOC_SEND_STREAM_PACKET: u32 = 1076372243;
-+pub const BTRFS_IOC_SNAP_DESTROY: u32 = 1342215183;
-+pub const SNAPSHOT_FREE: u32 = 13061;
-+pub const I8K_GET_SPEED: u32 = 3221776773;
-+pub const HIDIOCGREPORT: u32 = 1074546695;
-+pub const HPET_EPI: u32 = 26628;
-+pub const JSIOCSCORR: u32 = 1076128289;
-+pub const IOC_PR_PREEMPT_ABORT: u32 = 1075343564;
-+pub const RIO_MAP_OUTBOUND: u32 = 3223874831;
-+pub const ATM_SETESI: u32 = 1074815372;
-+pub const FW_CDEV_IOC_START_ISO: u32 = 1074799370;
-+pub const ATM_DELADDR: u32 = 1074815369;
-+pub const PPFCONTROL: u32 = 1073901710;
-+pub const SONYPI_IOCGFAN: u32 = 2147579402;
-+pub const RTC_IRQP_SET: u32 = 1074294796;
-+pub const PCITEST_WRITE: u32 = 1074286596;
-+pub const PPCLAIM: u32 = 28811;
-+pub const VIDIOC_S_JPEGCOMP: u32 = 1082938942;
-+pub const IPMICTL_UNREGISTER_FOR_CMD: u32 = 2147641615;
-+pub const VHOST_SET_FEATURES: u32 = 1074310912;
-+pub const TOSHIBA_ACPI_SCI: u32 = 3222828177;
-+pub const VIDIOC_DQBUF: u32 = 3227014673;
-+pub const BTRFS_IOC_BALANCE_PROGRESS: u32 = 2214630434;
-+pub const BTRFS_IOC_SUBVOL_SETFLAGS: u32 = 1074304026;
-+pub const ATMLEC_MCAST: u32 = 25042;
-+pub const MMTIMER_GETFREQ: u32 = 2148035842;
-+pub const VIDIOC_G_SELECTION: u32 = 3225441886;
-+pub const RTC_ALM_SET: u32 = 1076129799;
-+pub const PPPOEIOCSFWD: u32 = 1074311424;
-+pub const IPMICTL_GET_MAINTENANCE_MODE_CMD: u32 = 2147772702;
-+pub const FS_IOC_ENABLE_VERITY: u32 = 1082156677;
-+pub const NILFS_IOCTL_GET_BDESCS: u32 = 3222826631;
-+pub const FDFMTEND: u32 = 585;
-+pub const DMA_BUF_SET_NAME: u32 = 1074291201;
-+pub const UI_BEGIN_FF_UPLOAD: u32 = 3228063176;
-+pub const RTC_UIE_ON: u32 = 28675;
-+pub const PPRELEASE: u32 = 28812;
-+pub const VFIO_IOMMU_UNMAP_DMA: u32 = 15218;
-+pub const VIDIOC_OMAP3ISP_PRV_CFG: u32 = 3228587714;
-+pub const GPIO_GET_LINEHANDLE_IOCTL: u32 = 3245126659;
-+pub const VFAT_IOCTL_READDIR_BOTH: u32 = 2184212993;
-+pub const NVME_IOCTL_ADMIN_CMD: u32 = 3225964097;
-+pub const VHOST_SET_VRING_KICK: u32 = 1074310944;
-+pub const BTRFS_IOC_SUBVOL_CREATE_V2: u32 = 1342215192;
-+pub const BTRFS_IOC_SNAP_CREATE: u32 = 1342215169;
-+pub const SONYPI_IOCGBAT2CAP: u32 = 2147644932;
-+pub const PPNEGOT: u32 = 1074032785;
-+pub const NBD_PRINT_DEBUG: u32 = 43782;
-+pub const BTRFS_IOC_INO_LOOKUP_USER: u32 = 3489698878;
-+pub const BTRFS_IOC_GET_SUBVOL_ROOTREF: u32 = 3489698877;
-+pub const FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS: u32 = 3225445913;
-+pub const BTRFS_IOC_FS_INFO: u32 = 2214630431;
-+pub const VIDIOC_ENUM_FMT: u32 = 3225441794;
-+pub const VIDIOC_G_INPUT: u32 = 2147767846;
-+pub const VTPM_PROXY_IOC_NEW_DEV: u32 = 3222577408;
-+pub const DFL_FPGA_FME_ERR_GET_IRQ_NUM: u32 = 2147792515;
-+pub const ND_IOCTL_DIMM_FLAGS: u32 = 3221769731;
-+pub const BTRFS_IOC_QUOTA_RESCAN: u32 = 1077974060;
-+pub const MMTIMER_GETCOUNTER: u32 = 2148035849;
-+pub const MATROXFB_GET_OUTPUT_MODE: u32 = 3221778170;
-+pub const BTRFS_IOC_QUOTA_RESCAN_WAIT: u32 = 37934;
-+pub const RIO_CM_CHAN_BIND: u32 = 1074291461;
-+pub const HIDIOCGRDESC: u32 = 2416199682;
-+pub const MGSL_IOCGIF: u32 = 27915;
-+pub const VIDIOC_S_OUTPUT: u32 = 3221509679;
-+pub const HIDIOCGREPORTINFO: u32 = 3222030345;
-+pub const WDIOC_GETBOOTSTATUS: u32 = 2147768066;
-+pub const VDUSE_VQ_GET_INFO: u32 = 3224404245;
-+pub const ACRN_IOCTL_ASSIGN_PCIDEV: u32 = 1076142677;
-+pub const BLKGETDISKSEQ: u32 = 2148012672;
-+pub const ACRN_IOCTL_PM_GET_CPU_STATE: u32 = 3221791328;
-+pub const ACRN_IOCTL_DESTROY_VM: u32 = 41489;
-+pub const ACRN_IOCTL_SET_PTDEV_INTR: u32 = 1075094099;
-+pub const ACRN_IOCTL_CREATE_IOREQ_CLIENT: u32 = 41522;
-+pub const ACRN_IOCTL_IRQFD: u32 = 1075356273;
-+pub const ACRN_IOCTL_CREATE_VM: u32 = 3224412688;
-+pub const ACRN_IOCTL_INJECT_MSI: u32 = 1074831907;
-+pub const ACRN_IOCTL_ATTACH_IOREQ_CLIENT: u32 = 41523;
-+pub const ACRN_IOCTL_RESET_PTDEV_INTR: u32 = 1075094100;
-+pub const ACRN_IOCTL_NOTIFY_REQUEST_FINISH: u32 = 1074307633;
-+pub const ACRN_IOCTL_SET_IRQLINE: u32 = 1074307621;
-+pub const ACRN_IOCTL_START_VM: u32 = 41490;
-+pub const ACRN_IOCTL_SET_VCPU_REGS: u32 = 1093181974;
-+pub const ACRN_IOCTL_SET_MEMSEG: u32 = 1075880513;
-+pub const ACRN_IOCTL_PAUSE_VM: u32 = 41491;
-+pub const ACRN_IOCTL_CLEAR_VM_IOREQ: u32 = 41525;
-+pub const ACRN_IOCTL_UNSET_MEMSEG: u32 = 1075880514;
-+pub const ACRN_IOCTL_IOEVENTFD: u32 = 1075880560;
-+pub const ACRN_IOCTL_DEASSIGN_PCIDEV: u32 = 1076142678;
-+pub const ACRN_IOCTL_RESET_VM: u32 = 41493;
-+pub const ACRN_IOCTL_DESTROY_IOREQ_CLIENT: u32 = 41524;
-+pub const ACRN_IOCTL_VM_INTR_MONITOR: u32 = 1074307620;
--- 
-2.42.1
-
diff --git a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
index d7487c2..c34a610 100644
--- a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
@@ -1,4 +1,4 @@
-From 95b2cd0169cb1b4694c2bce67169b1aa1d5e2be0 Mon Sep 17 00:00:00 2001
+From d0f4f5b3ae900b9d092407e29b5372d93910c18c Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex@linutronix.de>
 Date: Tue, 21 Sep 2021 16:27:14 +0200
 Subject: [PATCH] Makefile.am: pass rust target to cargo also when not cross
@@ -14,10 +14,10 @@ Signed-off-by: Alexander Kanavin <alex@linutronix.de>
  2 files changed, 1 insertion(+), 5 deletions(-)
 
 diff --git a/Makefile.am b/Makefile.am
-index e93714e..effe5d3 100644
+index 2a89954..4e296d3 100644
 --- a/Makefile.am
 +++ b/Makefile.am
-@@ -137,9 +137,7 @@ else
+@@ -173,9 +173,7 @@ else
  CARGO_RELEASE_ARGS=--release
  endif
  
@@ -28,10 +28,10 @@ index e93714e..effe5d3 100644
  CARGO_VERBOSE = $(cargo_verbose_$(V))
  cargo_verbose_ = $(cargo_verbose_$(AM_DEFAULT_VERBOSITY))
 diff --git a/configure.ac b/configure.ac
-index 41590ca..84cd56b 100644
+index 42215cf..2499c96 100644
 --- a/configure.ac
 +++ b/configure.ac
-@@ -255,9 +255,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=$host)])
+@@ -292,9 +292,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=$host)])
  : ${RUST_TARGET:=$host}
  
  AM_CONDITIONAL([CROSS_COMPILING], [test "x$cross_compiling" = xyes])
@@ -42,6 +42,3 @@ index 41590ca..84cd56b 100644
  AC_SUBST([RUST_TARGET_SUBDIR])
  
  dnl ===========================================================================
--- 
-2.20.1
-
diff --git a/recipes-gnome/librsvg/librsvg_2.56.3.bb b/recipes-gnome/librsvg/librsvg_2.57.1.bb
similarity index 91%
rename from recipes-gnome/librsvg/librsvg_2.56.3.bb
rename to recipes-gnome/librsvg/librsvg_2.57.1.bb
index 02ce855..0a883dd 100644
--- a/recipes-gnome/librsvg/librsvg_2.56.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.57.1.bb
@@ -18,11 +18,11 @@ inherit cargo_common gnomebase pixbufcache gobject-introspection rust vala gi-do
 
 require ${BPN}-crates.inc
 
-SRC_URI += "file://0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch \
-            file://0001-Add-riscv32-support.patch;patchdir=../cargo_home/bitbake/linux-raw-sys-0.4.3 \
+SRC_URI += " \
+           file://0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch \
            "
 
-SRC_URI[archive.sha256sum] = "5a328048a02d014645cd27f61140f4e0b11280fb2c7f2a21864fe0c59ac1ce88"
+SRC_URI[archive.sha256sum] = "074671a3ed6fbcd67cae2a40e539107f4f097ca8a4ab1a894c05e2524ff340ef"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.46.0


