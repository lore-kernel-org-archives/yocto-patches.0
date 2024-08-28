Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6755DC6FD3B
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.5974.1724875804803092323
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NyO1guqs;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-829e856a173so134151239f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875804; x=1725480604; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwZ1/ccPyIDLKEqii3k3SoBfrualFP7ZhFAqLg3qUgk=;
        b=NyO1guqstY1COMGVHcHciQsgPwF9j+1w+Yit1ecnSUUXR1mSRtPGcBAllrgy3DkNdo
         gl/udSBsGQaM/BIHufADZZ/kBnVs2LaW10B5LBienBKHx0M5a+LMoCRX+L7CAf1MYQ++
         P4aAi2qFpZOLknxwnv2+zTGceZl3JgBSMhZm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875804; x=1725480604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwZ1/ccPyIDLKEqii3k3SoBfrualFP7ZhFAqLg3qUgk=;
        b=bodVnt5lcFQ14Up3Di+gdGva01Nlt1iq9x6K7XLAasWXaKTWahGawymI7SuQiVmtPI
         r9zT87EWya5avrj9IRUb4+XpO+ehv7jVfyWEXXd4+mstwOasJnH8l5aGWUqNOME2fQuY
         t69dOFTZDDPJ7kGjWe95cistfnUFeXYksGBKNbHbD22wc+Bwmq8lODNBpe1T9wD1ZseJ
         aSOF/Z+ZvmxCS/iRJCNWk+PQ0yHOLjCbkCWzXIoWQjPVyfHw/JPDjye3CE2oE2iVd5F2
         Xj90DBqIO7rbzb7ALE/s1feOzTwJY+bL9hZivVxWSHN4UNW1k9vEenUB57WlYE4PQSYp
         LSSA==
X-Gm-Message-State: AOJu0Yz5wXrX/SBOj8J+jjdB2D6pfEA9mFJj8q2qlY1GyIeNeivH03Gs
	iztbbLAzOS9s3bOrEX+UJwHzTwAzqZgPakLJ8x5Hd7Agxo87SGOS127A21hB1KSvbmQz3jXLucJ
	l
X-Google-Smtp-Source: AGHT+IGWalI8ALS32qsgbqIoHg6euTb5AEpOvsSz2AfGBWftgIDwY/KlMcVijNk1k93UDuZ2wknTWQ==
X-Received: by 2002:a05:6602:6d06:b0:824:e42e:a1bd with SMTP id ca18e2360f4ac-82a110a4246mr62332039f.17.1724875802701;
        Wed, 28 Aug 2024 13:10:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 18/33] librsvg: upgrade 2.57.3 -> 2.58.1
Date: Wed, 28 Aug 2024 16:09:04 -0400
Message-ID: <ac4fd651b122c8c1f97df6491207454ae3428d49.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/586

From: Wang Mingyu <wangmy@fujitsu.com>

0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
refreshed for 2.58.1

Changelog:
- Fix failing test with Pango 1.52.1.

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit bd6ea4b879b62ec83164c14a97074b8c7da7f25e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 418 +++++++++---------
 ...-rust-target-to-cargo-also-when-not-.patch |  10 +-
 .../{librsvg_2.57.3.bb => librsvg_2.58.1.bb}  |   2 +-
 3 files changed, 226 insertions(+), 204 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.57.3.bb => librsvg_2.58.1.bb} (96%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 94eba30..0ab8076 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -7,53 +7,56 @@ SRC_URI += " \
     crate://crates.io/android-tzdata/0.1.1 \
     crate://crates.io/android_system_properties/0.1.5 \
     crate://crates.io/anes/0.1.6 \
-    crate://crates.io/anstream/0.6.5 \
-    crate://crates.io/anstyle/1.0.4 \
+    crate://crates.io/anstream/0.6.11 \
+    crate://crates.io/anstyle/1.0.6 \
     crate://crates.io/anstyle-parse/0.2.3 \
     crate://crates.io/anstyle-query/1.0.2 \
     crate://crates.io/anstyle-wincon/3.0.2 \
-    crate://crates.io/anyhow/1.0.75 \
+    crate://crates.io/anyhow/1.0.79 \
     crate://crates.io/approx/0.5.1 \
-    crate://crates.io/assert_cmd/2.0.12 \
+    crate://crates.io/assert_cmd/2.0.13 \
     crate://crates.io/autocfg/1.1.0 \
     crate://crates.io/bit-set/0.5.3 \
     crate://crates.io/bit-vec/0.6.3 \
+    crate://crates.io/bit_field/0.10.2 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.4.1 \
+    crate://crates.io/bitflags/2.4.2 \
     crate://crates.io/block/0.1.6 \
-    crate://crates.io/bstr/1.8.0 \
+    crate://crates.io/bstr/1.9.0 \
     crate://crates.io/bumpalo/3.14.0 \
-    crate://crates.io/bytemuck/1.14.0 \
+    crate://crates.io/bytemuck/1.14.2 \
     crate://crates.io/byteorder/1.5.0 \
-    crate://crates.io/cairo-rs/0.18.3 \
-    crate://crates.io/cairo-sys-rs/0.18.2 \
+    crate://crates.io/cairo-rs/0.19.1 \
+    crate://crates.io/cairo-sys-rs/0.19.1 \
     crate://crates.io/cast/0.3.0 \
     crate://crates.io/cc/1.0.83 \
-    crate://crates.io/cfg-expr/0.15.5 \
+    crate://crates.io/cfg-expr/0.15.6 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/chrono/0.4.31 \
-    crate://crates.io/ciborium/0.2.1 \
-    crate://crates.io/ciborium-io/0.2.1 \
-    crate://crates.io/ciborium-ll/0.2.1 \
-    crate://crates.io/clap/4.4.11 \
-    crate://crates.io/clap_builder/4.4.11 \
-    crate://crates.io/clap_complete/4.4.4 \
+    crate://crates.io/chrono/0.4.33 \
+    crate://crates.io/ciborium/0.2.2 \
+    crate://crates.io/ciborium-io/0.2.2 \
+    crate://crates.io/ciborium-ll/0.2.2 \
+    crate://crates.io/clap/4.4.18 \
+    crate://crates.io/clap_builder/4.4.18 \
+    crate://crates.io/clap_complete/4.4.10 \
     crate://crates.io/clap_derive/4.4.7 \
     crate://crates.io/clap_lex/0.6.0 \
+    crate://crates.io/color_quant/1.1.0 \
     crate://crates.io/colorchoice/1.0.0 \
     crate://crates.io/const-cstr/0.3.0 \
     crate://crates.io/core-foundation-sys/0.8.6 \
     crate://crates.io/crc32fast/1.3.2 \
     crate://crates.io/criterion/0.5.1 \
     crate://crates.io/criterion-plot/0.5.0 \
-    crate://crates.io/crossbeam-deque/0.8.4 \
-    crate://crates.io/crossbeam-epoch/0.9.16 \
-    crate://crates.io/crossbeam-utils/0.8.17 \
+    crate://crates.io/crossbeam-deque/0.8.5 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-utils/0.8.19 \
+    crate://crates.io/crunchy/0.2.2 \
     crate://crates.io/cssparser/0.31.2 \
     crate://crates.io/cssparser-macros/0.6.1 \
     crate://crates.io/cstr/0.2.11 \
     crate://crates.io/data-url/0.3.1 \
-    crate://crates.io/deranged/0.3.10 \
+    crate://crates.io/deranged/0.3.11 \
     crate://crates.io/derive_more/0.99.17 \
     crate://crates.io/difflib/0.4.0 \
     crate://crates.io/dlib/0.5.2 \
@@ -64,82 +67,88 @@ SRC_URI += " \
     crate://crates.io/encoding_rs/0.8.33 \
     crate://crates.io/equivalent/1.0.1 \
     crate://crates.io/errno/0.3.8 \
+    crate://crates.io/exr/1.72.0 \
     crate://crates.io/fastrand/2.0.1 \
-    crate://crates.io/fdeflate/0.3.1 \
+    crate://crates.io/fdeflate/0.3.4 \
     crate://crates.io/flate2/1.0.28 \
     crate://crates.io/float-cmp/0.9.0 \
+    crate://crates.io/flume/0.11.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/form_urlencoded/1.2.1 \
     crate://crates.io/futf/0.1.5 \
-    crate://crates.io/futures-channel/0.3.29 \
-    crate://crates.io/futures-core/0.3.29 \
-    crate://crates.io/futures-executor/0.3.29 \
-    crate://crates.io/futures-io/0.3.29 \
-    crate://crates.io/futures-macro/0.3.29 \
-    crate://crates.io/futures-task/0.3.29 \
-    crate://crates.io/futures-util/0.3.29 \
+    crate://crates.io/futures-channel/0.3.30 \
+    crate://crates.io/futures-core/0.3.30 \
+    crate://crates.io/futures-executor/0.3.30 \
+    crate://crates.io/futures-io/0.3.30 \
+    crate://crates.io/futures-macro/0.3.30 \
+    crate://crates.io/futures-task/0.3.30 \
+    crate://crates.io/futures-util/0.3.30 \
     crate://crates.io/fxhash/0.2.1 \
-    crate://crates.io/gdk-pixbuf/0.18.3 \
-    crate://crates.io/gdk-pixbuf-sys/0.18.0 \
-    crate://crates.io/getrandom/0.2.11 \
-    crate://crates.io/gio/0.18.4 \
-    crate://crates.io/gio-sys/0.18.1 \
-    crate://crates.io/glib/0.18.4 \
-    crate://crates.io/glib-macros/0.18.3 \
-    crate://crates.io/glib-sys/0.18.1 \
-    crate://crates.io/gobject-sys/0.18.0 \
-    crate://crates.io/half/1.8.2 \
+    crate://crates.io/gdk-pixbuf/0.19.0 \
+    crate://crates.io/gdk-pixbuf-sys/0.19.0 \
+    crate://crates.io/getrandom/0.2.12 \
+    crate://crates.io/gif/0.12.0 \
+    crate://crates.io/gio/0.19.0 \
+    crate://crates.io/gio-sys/0.19.0 \
+    crate://crates.io/glib/0.19.0 \
+    crate://crates.io/glib-macros/0.19.0 \
+    crate://crates.io/glib-sys/0.19.0 \
+    crate://crates.io/gobject-sys/0.19.0 \
+    crate://crates.io/half/2.3.1 \
     crate://crates.io/hashbrown/0.14.3 \
     crate://crates.io/heck/0.4.1 \
-    crate://crates.io/hermit-abi/0.3.3 \
-    crate://crates.io/iana-time-zone/0.1.58 \
+    crate://crates.io/hermit-abi/0.3.5 \
+    crate://crates.io/iana-time-zone/0.1.60 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
     crate://crates.io/idna/0.5.0 \
-    crate://crates.io/indexmap/2.1.0 \
-    crate://crates.io/is-terminal/0.4.9 \
+    crate://crates.io/image/0.24.8 \
+    crate://crates.io/indexmap/2.2.2 \
+    crate://crates.io/is-terminal/0.4.10 \
     crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itertools/0.11.0 \
+    crate://crates.io/itertools/0.12.1 \
     crate://crates.io/itoa/1.0.10 \
-    crate://crates.io/js-sys/0.3.66 \
+    crate://crates.io/jpeg-decoder/0.3.1 \
+    crate://crates.io/js-sys/0.3.68 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.151 \
+    crate://crates.io/lebe/0.5.2 \
+    crate://crates.io/libc/0.2.153 \
     crate://crates.io/libloading/0.8.1 \
     crate://crates.io/libm/0.2.8 \
     crate://crates.io/linked-hash-map/0.5.6 \
-    crate://crates.io/linux-raw-sys/0.4.12 \
+    crate://crates.io/linux-raw-sys/0.4.13 \
     crate://crates.io/locale_config/0.3.0 \
     crate://crates.io/lock_api/0.4.11 \
     crate://crates.io/log/0.4.20 \
-    crate://crates.io/lopdf/0.31.0 \
+    crate://crates.io/lopdf/0.32.0 \
     crate://crates.io/mac/0.1.1 \
     crate://crates.io/malloc_buf/0.0.6 \
     crate://crates.io/markup5ever/0.11.0 \
     crate://crates.io/matches/0.1.10 \
     crate://crates.io/matrixmultiply/0.3.8 \
     crate://crates.io/md5/0.7.0 \
-    crate://crates.io/memchr/2.6.4 \
-    crate://crates.io/memoffset/0.9.0 \
+    crate://crates.io/memchr/2.7.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.7.1 \
+    crate://crates.io/miniz_oxide/0.7.2 \
     crate://crates.io/nalgebra/0.32.3 \
     crate://crates.io/nalgebra-macros/0.2.1 \
     crate://crates.io/new_debug_unreachable/1.0.4 \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normalize-line-endings/0.3.0 \
-    crate://crates.io/num-complex/0.4.4 \
-    crate://crates.io/num-integer/0.1.45 \
+    crate://crates.io/num-complex/0.4.5 \
+    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-integer/0.1.46 \
     crate://crates.io/num-rational/0.4.1 \
-    crate://crates.io/num-traits/0.2.17 \
+    crate://crates.io/num-traits/0.2.18 \
     crate://crates.io/objc/0.2.7 \
     crate://crates.io/objc-foundation/0.1.1 \
     crate://crates.io/objc_id/0.1.1 \
     crate://crates.io/once_cell/1.19.0 \
     crate://crates.io/oorandom/11.1.3 \
-    crate://crates.io/pango/0.18.3 \
-    crate://crates.io/pango-sys/0.18.0 \
-    crate://crates.io/pangocairo/0.18.0 \
-    crate://crates.io/pangocairo-sys/0.18.0 \
+    crate://crates.io/pango/0.19.0 \
+    crate://crates.io/pango-sys/0.19.0 \
+    crate://crates.io/pangocairo/0.19.1 \
+    crate://crates.io/pangocairo-sys/0.19.0 \
     crate://crates.io/parking_lot/0.12.1 \
     crate://crates.io/parking_lot_core/0.9.9 \
     crate://crates.io/paste/1.0.14 \
@@ -154,103 +163,104 @@ SRC_URI += " \
     crate://crates.io/phf_shared/0.11.2 \
     crate://crates.io/pin-project-lite/0.2.13 \
     crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/pkg-config/0.3.27 \
+    crate://crates.io/pkg-config/0.3.29 \
     crate://crates.io/plotters/0.3.5 \
     crate://crates.io/plotters-backend/0.3.5 \
     crate://crates.io/plotters-svg/0.3.5 \
-    crate://crates.io/png/0.17.10 \
+    crate://crates.io/png/0.17.11 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/precomputed-hash/0.1.1 \
-    crate://crates.io/predicates/3.0.4 \
+    crate://crates.io/predicates/3.1.0 \
     crate://crates.io/predicates-core/1.0.6 \
     crate://crates.io/predicates-tree/1.0.9 \
-    crate://crates.io/proc-macro-crate/2.0.1 \
-    crate://crates.io/proc-macro-error/1.0.4 \
-    crate://crates.io/proc-macro-error-attr/1.0.4 \
-    crate://crates.io/proc-macro2/1.0.70 \
+    crate://crates.io/proc-macro-crate/3.1.0 \
+    crate://crates.io/proc-macro2/1.0.78 \
     crate://crates.io/proptest/1.4.0 \
+    crate://crates.io/qoi/0.4.1 \
     crate://crates.io/quick-error/1.2.3 \
     crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/quote/1.0.33 \
+    crate://crates.io/quote/1.0.35 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_xorshift/0.3.0 \
     crate://crates.io/rawpointer/0.2.1 \
-    crate://crates.io/rayon/1.8.0 \
-    crate://crates.io/rayon-core/1.12.0 \
-    crate://crates.io/rctree/0.5.0 \
+    crate://crates.io/rayon/1.8.1 \
+    crate://crates.io/rayon-core/1.12.1 \
+    crate://crates.io/rctree/0.6.0 \
     crate://crates.io/redox_syscall/0.4.1 \
-    crate://crates.io/regex/1.10.2 \
-    crate://crates.io/regex-automata/0.4.3 \
+    crate://crates.io/regex/1.10.3 \
+    crate://crates.io/regex-automata/0.4.5 \
     crate://crates.io/regex-syntax/0.8.2 \
     crate://crates.io/rgb/0.8.37 \
-    crate://crates.io/rustix/0.38.28 \
+    crate://crates.io/rustix/0.38.31 \
     crate://crates.io/rusty-fork/0.3.0 \
     crate://crates.io/ryu/1.0.16 \
     crate://crates.io/safe_arch/0.7.1 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/selectors/0.25.0 \
-    crate://crates.io/serde/1.0.193 \
-    crate://crates.io/serde_derive/1.0.193 \
-    crate://crates.io/serde_json/1.0.108 \
-    crate://crates.io/serde_spanned/0.6.4 \
+    crate://crates.io/serde/1.0.196 \
+    crate://crates.io/serde_derive/1.0.196 \
+    crate://crates.io/serde_json/1.0.113 \
+    crate://crates.io/serde_spanned/0.6.5 \
     crate://crates.io/servo_arc/0.3.0 \
     crate://crates.io/simba/0.8.1 \
     crate://crates.io/simd-adler32/0.3.7 \
     crate://crates.io/siphasher/0.3.11 \
     crate://crates.io/slab/0.4.9 \
-    crate://crates.io/smallvec/1.11.2 \
+    crate://crates.io/smallvec/1.13.1 \
+    crate://crates.io/spin/0.9.8 \
     crate://crates.io/stable_deref_trait/1.2.0 \
     crate://crates.io/string_cache/0.8.7 \
     crate://crates.io/string_cache_codegen/0.5.2 \
     crate://crates.io/strsim/0.10.0 \
     crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.41 \
+    crate://crates.io/syn/2.0.48 \
     crate://crates.io/system-deps/6.2.0 \
-    crate://crates.io/target-lexicon/0.12.12 \
-    crate://crates.io/tempfile/3.8.1 \
+    crate://crates.io/target-lexicon/0.12.13 \
+    crate://crates.io/tempfile/3.10.0 \
     crate://crates.io/tendril/0.4.3 \
     crate://crates.io/termtree/0.4.1 \
-    crate://crates.io/thiserror/1.0.50 \
-    crate://crates.io/thiserror-impl/1.0.50 \
-    crate://crates.io/time/0.3.30 \
+    crate://crates.io/thiserror/1.0.56 \
+    crate://crates.io/thiserror-impl/1.0.56 \
+    crate://crates.io/tiff/0.9.1 \
+    crate://crates.io/time/0.3.34 \
     crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.15 \
+    crate://crates.io/time-macros/0.2.17 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.6.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.8.2 \
-    crate://crates.io/toml_datetime/0.6.3 \
-    crate://crates.io/toml_edit/0.20.2 \
+    crate://crates.io/toml/0.8.10 \
+    crate://crates.io/toml_datetime/0.6.5 \
+    crate://crates.io/toml_edit/0.21.1 \
+    crate://crates.io/toml_edit/0.22.4 \
     crate://crates.io/typenum/1.17.0 \
     crate://crates.io/unarray/0.1.4 \
-    crate://crates.io/unicode-bidi/0.3.14 \
+    crate://crates.io/unicode-bidi/0.3.15 \
     crate://crates.io/unicode-ident/1.0.12 \
     crate://crates.io/unicode-normalization/0.1.22 \
     crate://crates.io/url/2.5.0 \
     crate://crates.io/utf-8/0.7.6 \
     crate://crates.io/utf8parse/0.2.1 \
     crate://crates.io/version-compare/0.1.1 \
-    crate://crates.io/version_check/0.9.4 \
     crate://crates.io/wait-timeout/0.2.0 \
     crate://crates.io/walkdir/2.4.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.89 \
-    crate://crates.io/wasm-bindgen-backend/0.2.89 \
-    crate://crates.io/wasm-bindgen-macro/0.2.89 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.89 \
-    crate://crates.io/wasm-bindgen-shared/0.2.89 \
-    crate://crates.io/web-sys/0.3.66 \
-    crate://crates.io/weezl/0.1.7 \
-    crate://crates.io/wide/0.7.13 \
+    crate://crates.io/wasm-bindgen/0.2.91 \
+    crate://crates.io/wasm-bindgen-backend/0.2.91 \
+    crate://crates.io/wasm-bindgen-macro/0.2.91 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.91 \
+    crate://crates.io/wasm-bindgen-shared/0.2.91 \
+    crate://crates.io/web-sys/0.3.68 \
+    crate://crates.io/weezl/0.1.8 \
+    crate://crates.io/wide/0.7.15 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.6 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-core/0.51.1 \
+    crate://crates.io/windows-core/0.52.0 \
     crate://crates.io/windows-sys/0.48.0 \
     crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-targets/0.48.5 \
@@ -269,9 +279,10 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnullvm/0.52.0 \
     crate://crates.io/windows_x86_64_msvc/0.48.5 \
     crate://crates.io/windows_x86_64_msvc/0.52.0 \
-    crate://crates.io/winnow/0.5.28 \
+    crate://crates.io/winnow/0.5.39 \
     crate://crates.io/xml5ever/0.17.0 \
     crate://crates.io/yeslogic-fontconfig-sys/4.0.1 \
+    crate://crates.io/zune-inflate/0.2.54 \
 "
 
 SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
@@ -279,53 +290,56 @@ SRC_URI[aho-corasick-1.1.2.sha256sum] = "b2969dcb958b36655471fc61f7e416fa76033bd
 SRC_URI[android-tzdata-0.1.1.sha256sum] = "e999941b234f3131b00bc13c22d06e8c5ff726d1b6318ac7eb276997bbb4fef0"
 SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
 SRC_URI[anes-0.1.6.sha256sum] = "4b46cbb362ab8752921c97e041f5e366ee6297bd428a31275b9fcf1e380f7299"
-SRC_URI[anstream-0.6.5.sha256sum] = "d664a92ecae85fd0a7392615844904654d1d5f5514837f471ddef4a057aba1b6"
-SRC_URI[anstyle-1.0.4.sha256sum] = "7079075b41f533b8c61d2a4d073c4676e1f8b249ff94a393b0595db304e0dd87"
+SRC_URI[anstream-0.6.11.sha256sum] = "6e2e1ebcb11de5c03c67de28a7df593d32191b44939c482e97702baaaa6ab6a5"
+SRC_URI[anstyle-1.0.6.sha256sum] = "8901269c6307e8d93993578286ac0edf7f195079ffff5ebdeea6a59ffb7e36bc"
 SRC_URI[anstyle-parse-0.2.3.sha256sum] = "c75ac65da39e5fe5ab759307499ddad880d724eed2f6ce5b5e8a26f4f387928c"
 SRC_URI[anstyle-query-1.0.2.sha256sum] = "e28923312444cdd728e4738b3f9c9cac739500909bb3d3c94b43551b16517648"
 SRC_URI[anstyle-wincon-3.0.2.sha256sum] = "1cd54b81ec8d6180e24654d0b371ad22fc3dd083b6ff8ba325b72e00c87660a7"
-SRC_URI[anyhow-1.0.75.sha256sum] = "a4668cab20f66d8d020e1fbc0ebe47217433c1b6c8f2040faf858554e394ace6"
+SRC_URI[anyhow-1.0.79.sha256sum] = "080e9890a082662b09c1ad45f567faeeb47f22b5fb23895fbe1e651e718e25ca"
 SRC_URI[approx-0.5.1.sha256sum] = "cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
-SRC_URI[assert_cmd-2.0.12.sha256sum] = "88903cb14723e4d4003335bb7f8a14f27691649105346a0f0957466c096adfe6"
+SRC_URI[assert_cmd-2.0.13.sha256sum] = "00ad3f3a942eee60335ab4342358c161ee296829e0d16ff42fc1d6cb07815467"
 SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
 SRC_URI[bit-set-0.5.3.sha256sum] = "0700ddab506f33b20a03b13996eccd309a48e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
+SRC_URI[bit_field-0.10.2.sha256sum] = "dc827186963e592360843fb5ba4b973e145841266c1357f7180c43526f2e5b61"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.4.1.sha256sum] = "327762f6e5a765692301e5bb513e0d9fef63be86bbc14528052b1cd3e6f03e07"
+SRC_URI[bitflags-2.4.2.sha256sum] = "ed570934406eb16438a4e976b1b4500774099c13b8cb96eec99f620f05090ddf"
 SRC_URI[block-0.1.6.sha256sum] = "0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
-SRC_URI[bstr-1.8.0.sha256sum] = "542f33a8835a0884b006a0c3df3dadd99c0c3f296ed26c2fdc8028e01ad6230c"
+SRC_URI[bstr-1.9.0.sha256sum] = "c48f0051a4b4c5e0b6d365cd04af53aeaa209e3cc15ec2cdb69e73cc87fbd0dc"
 SRC_URI[bumpalo-3.14.0.sha256sum] = "7f30e7476521f6f8af1a1c4c0b8cc94f0bee37d91763d0ca2665f299b6cd8aec"
-SRC_URI[bytemuck-1.14.0.sha256sum] = "374d28ec25809ee0e23827c2ab573d729e293f281dfe393500e7ad618baa61c6"
+SRC_URI[bytemuck-1.14.2.sha256sum] = "ea31d69bda4949c1c1562c1e6f042a1caefac98cdc8a298260a2ff41c1e2d42b"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
-SRC_URI[cairo-rs-0.18.3.sha256sum] = "f33613627f0dea6a731b0605101fad59ba4f193a52c96c4687728d822605a8a1"
-SRC_URI[cairo-sys-rs-0.18.2.sha256sum] = "685c9fa8e590b8b3d678873528d83411db17242a73fccaed827770ea0fedda51"
+SRC_URI[cairo-rs-0.19.1.sha256sum] = "bc1c415b7088381c53c575420899c34c9e6312df5ac5defd05614210e9fd6e1b"
+SRC_URI[cairo-sys-rs-0.19.1.sha256sum] = "75b6a5fefce2eadb8333e3c604ac964ba6573ec4f28bdd17f67032c4a2831831"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 SRC_URI[cc-1.0.83.sha256sum] = "f1174fb0b6ec23863f8b971027804a42614e347eafb0a95bf0b12cdae21fc4d0"
-SRC_URI[cfg-expr-0.15.5.sha256sum] = "03915af431787e6ffdcc74c645077518c6b6e01f80b761e0fbbfa288536311b3"
+SRC_URI[cfg-expr-0.15.6.sha256sum] = "6100bc57b6209840798d95cb2775684849d332f7bd788db2a8c8caf7ef82a41a"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.31.sha256sum] = "7f2c685bad3eb3d45a01354cedb7d5faa66194d1d58ba6e267a8de788f79db38"
-SRC_URI[ciborium-0.2.1.sha256sum] = "effd91f6c78e5a4ace8a5d3c0b6bfaec9e2baaef55f3efc00e45fb2e477ee926"
-SRC_URI[ciborium-io-0.2.1.sha256sum] = "cdf919175532b369853f5d5e20b26b43112613fd6fe7aee757e35f7a44642656"
-SRC_URI[ciborium-ll-0.2.1.sha256sum] = "defaa24ecc093c77630e6c15e17c51f5e187bf35ee514f4e2d67baaa96dae22b"
-SRC_URI[clap-4.4.11.sha256sum] = "bfaff671f6b22ca62406885ece523383b9b64022e341e53e009a62ebc47a45f2"
-SRC_URI[clap_builder-4.4.11.sha256sum] = "a216b506622bb1d316cd51328dce24e07bdff4a6128a47c7e7fad11878d5adbb"
-SRC_URI[clap_complete-4.4.4.sha256sum] = "bffe91f06a11b4b9420f62103854e90867812cd5d01557f853c5ee8e791b12ae"
+SRC_URI[chrono-0.4.33.sha256sum] = "9f13690e35a5e4ace198e7beea2895d29f3a9cc55015fcebe6336bd2010af9eb"
+SRC_URI[ciborium-0.2.2.sha256sum] = "42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
+SRC_URI[ciborium-io-0.2.2.sha256sum] = "05afea1e0a06c9be33d539b876f1ce3692f4afea2cb41f740e7743225ed1c757"
+SRC_URI[ciborium-ll-0.2.2.sha256sum] = "57663b653d948a338bfb3eeba9bb2fd5fcfaecb9e199e87e1eda4d9e8b240fd9"
+SRC_URI[clap-4.4.18.sha256sum] = "1e578d6ec4194633722ccf9544794b71b1385c3c027efe0c55db226fc880865c"
+SRC_URI[clap_builder-4.4.18.sha256sum] = "4df4df40ec50c46000231c914968278b1eb05098cf8f1b3a518a95030e71d1c7"
+SRC_URI[clap_complete-4.4.10.sha256sum] = "abb745187d7f4d76267b37485a65e0149edd0e91a4cfcdd3f27524ad86cee9f3"
 SRC_URI[clap_derive-4.4.7.sha256sum] = "cf9804afaaf59a91e75b022a30fb7229a7901f60c755489cc61c9b423b836442"
 SRC_URI[clap_lex-0.6.0.sha256sum] = "702fc72eb24e5a1e48ce58027a675bc24edd52096d5397d4aea7c6dd9eca0bd1"
+SRC_URI[color_quant-1.1.0.sha256sum] = "3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
 SRC_URI[colorchoice-1.0.0.sha256sum] = "acbf1af155f9b9ef647e42cdc158db4b64a1b61f743629225fde6f3e0be2a7c7"
 SRC_URI[const-cstr-0.3.0.sha256sum] = "ed3d0b5ff30645a68f35ece8cea4556ca14ef8a1651455f789a099a0513532a6"
 SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
 SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
 SRC_URI[criterion-0.5.1.sha256sum] = "f2b12d017a929603d80db1831cd3a24082f8137ce19c69e6447f54f5fc8d692f"
 SRC_URI[criterion-plot-0.5.0.sha256sum] = "6b50826342786a51a89e2da3a28f1c32b06e387201bc2d19791f622c673706b1"
-SRC_URI[crossbeam-deque-0.8.4.sha256sum] = "fca89a0e215bab21874660c67903c5f143333cab1da83d041c7ded6053774751"
-SRC_URI[crossbeam-epoch-0.9.16.sha256sum] = "2d2fe95351b870527a5d09bf563ed3c97c0cffb87cf1c78a591bf48bb218d9aa"
-SRC_URI[crossbeam-utils-0.8.17.sha256sum] = "c06d96137f14f244c37f989d9fff8f95e6c18b918e71f36638f8c49112e4c78f"
+SRC_URI[crossbeam-deque-0.8.5.sha256sum] = "613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-utils-0.8.19.sha256sum] = "248e3bacc7dc6baa3b21e405ee045c3047101a49145e7e9eca583ab4c2ca5345"
+SRC_URI[crunchy-0.2.2.sha256sum] = "7a81dae078cea95a014a339291cec439d2f232ebe854a9d672b796c6afafa9b7"
 SRC_URI[cssparser-0.31.2.sha256sum] = "5b3df4f93e5fbbe73ec01ec8d3f68bba73107993a5b1e7519273c32db9b0d5be"
 SRC_URI[cssparser-macros-0.6.1.sha256sum] = "13b588ba4ac1a99f7f2964d24b3d896ddc6bf847ee3855dbd4366f058cfcd331"
 SRC_URI[cstr-0.2.11.sha256sum] = "8aa998c33a6d3271e3678950a22134cd7dd27cef86dee1b611b5b14207d1d90b"
 SRC_URI[data-url-0.3.1.sha256sum] = "5c297a1c74b71ae29df00c3e22dd9534821d60eb9af5a0192823fa2acea70c2a"
-SRC_URI[deranged-0.3.10.sha256sum] = "8eb30d70a07a3b04884d2677f06bec33509dc67ca60d92949e5535352d3191dc"
+SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
 SRC_URI[derive_more-0.99.17.sha256sum] = "4fb810d30a7c1953f91334de7244731fc3f3c10d7fe163338a35b9f640960321"
 SRC_URI[difflib-0.4.0.sha256sum] = "6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"
 SRC_URI[dlib-0.5.2.sha256sum] = "330c60081dcc4c72131f8eb70510f1ac07223e5d4163db481a04a0befcffa412"
@@ -336,82 +350,88 @@ SRC_URI[either-1.9.0.sha256sum] = "a26ae43d7bcc3b814de94796a5e736d4029efb0ee900c
 SRC_URI[encoding_rs-0.8.33.sha256sum] = "7268b386296a025e474d5140678f75d6de9493ae55a5d709eeb9dd08149945e1"
 SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
 SRC_URI[errno-0.3.8.sha256sum] = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"
+SRC_URI[exr-1.72.0.sha256sum] = "887d93f60543e9a9362ef8a21beedd0a833c5d9610e18c67abe15a5963dcb1a4"
 SRC_URI[fastrand-2.0.1.sha256sum] = "25cbce373ec4653f1a01a31e8a5e5ec0c622dc27ff9c4e6606eefef5cbbed4a5"
-SRC_URI[fdeflate-0.3.1.sha256sum] = "64d6dafc854908ff5da46ff3f8f473c6984119a2876a383a860246dd7841a868"
+SRC_URI[fdeflate-0.3.4.sha256sum] = "4f9bfee30e4dedf0ab8b422f03af778d9612b63f502710fc500a334ebe2de645"
 SRC_URI[flate2-1.0.28.sha256sum] = "46303f565772937ffe1d394a4fac6f411c6013172fadde9dcdb1e147a086940e"
 SRC_URI[float-cmp-0.9.0.sha256sum] = "98de4bbd547a563b716d8dfa9aad1cb19bfab00f4fa09a6a4ed21dbcf44ce9c4"
+SRC_URI[flume-0.11.0.sha256sum] = "55ac459de2512911e4b674ce33cf20befaba382d05b62b008afc1c8b57cbf181"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[form_urlencoded-1.2.1.sha256sum] = "e13624c2627564efccf4934284bdd98cbaa14e79b0b5a141218e507b3a823456"
 SRC_URI[futf-0.1.5.sha256sum] = "df420e2e84819663797d1ec6544b13c5be84629e7bb00dc960d6917db2987843"
-SRC_URI[futures-channel-0.3.29.sha256sum] = "ff4dd66668b557604244583e3e1e1eada8c5c2e96a6d0d6653ede395b78bbacb"
-SRC_URI[futures-core-0.3.29.sha256sum] = "eb1d22c66e66d9d72e1758f0bd7d4fd0bee04cad842ee34587d68c07e45d088c"
-SRC_URI[futures-executor-0.3.29.sha256sum] = "0f4fb8693db0cf099eadcca0efe2a5a22e4550f98ed16aba6c48700da29597bc"
-SRC_URI[futures-io-0.3.29.sha256sum] = "8bf34a163b5c4c52d0478a4d757da8fb65cabef42ba90515efee0f6f9fa45aaa"
-SRC_URI[futures-macro-0.3.29.sha256sum] = "53b153fd91e4b0147f4aced87be237c98248656bb01050b96bf3ee89220a8ddb"
-SRC_URI[futures-task-0.3.29.sha256sum] = "efd193069b0ddadc69c46389b740bbccdd97203899b48d09c5f7969591d6bae2"
-SRC_URI[futures-util-0.3.29.sha256sum] = "a19526d624e703a3179b3d322efec918b6246ea0fa51d41124525f00f1cc8104"
+SRC_URI[futures-channel-0.3.30.sha256sum] = "eac8f7d7865dcb88bd4373ab671c8cf4508703796caa2b1985a9ca867b3fcb78"
+SRC_URI[futures-core-0.3.30.sha256sum] = "dfc6580bb841c5a68e9ef15c77ccc837b40a7504914d52e47b8b0e9bbda25a1d"
+SRC_URI[futures-executor-0.3.30.sha256sum] = "a576fc72ae164fca6b9db127eaa9a9dda0d61316034f33a0a0d4eda41f02b01d"
+SRC_URI[futures-io-0.3.30.sha256sum] = "a44623e20b9681a318efdd71c299b6b222ed6f231972bfe2f224ebad6311f0c1"
+SRC_URI[futures-macro-0.3.30.sha256sum] = "87750cf4b7a4c0625b1529e4c543c2182106e4dedc60a2a6455e00d212c489ac"
+SRC_URI[futures-task-0.3.30.sha256sum] = "38d84fa142264698cdce1a9f9172cf383a0c82de1bddcf3092901442c4097004"
+SRC_URI[futures-util-0.3.30.sha256sum] = "3d6401deb83407ab3da39eba7e33987a73c3df0c82b4bb5813ee871c19c41d48"
 SRC_URI[fxhash-0.2.1.sha256sum] = "c31b6d751ae2c7f11320402d34e41349dd1016f8d5d45e48c4312bc8625af50c"
-SRC_URI[gdk-pixbuf-0.18.3.sha256sum] = "446f32b74d22c33b7b258d4af4ffde53c2bf96ca2e29abdf1a785fe59bd6c82c"
-SRC_URI[gdk-pixbuf-sys-0.18.0.sha256sum] = "3f9839ea644ed9c97a34d129ad56d38a25e6756f99f3a88e15cd39c20629caf7"
-SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
-SRC_URI[gio-0.18.4.sha256sum] = "d4fc8f532f87b79cbc51a79748f16a6828fb784be93145a322fa14d06d354c73"
-SRC_URI[gio-sys-0.18.1.sha256sum] = "37566df850baf5e4cb0dfb78af2e4b9898d817ed9263d1090a2df958c64737d2"
-SRC_URI[glib-0.18.4.sha256sum] = "951bbd7fdc5c044ede9f05170f05a3ae9479239c3afdfe2d22d537a3add15c4e"
-SRC_URI[glib-macros-0.18.3.sha256sum] = "72793962ceece3863c2965d7f10c8786323b17c7adea75a515809fa20ab799a5"
-SRC_URI[glib-sys-0.18.1.sha256sum] = "063ce2eb6a8d0ea93d2bf8ba1957e78dbab6be1c2220dd3daca57d5a9d869898"
-SRC_URI[gobject-sys-0.18.0.sha256sum] = "0850127b514d1c4a4654ead6dedadb18198999985908e6ffe4436f53c785ce44"
-SRC_URI[half-1.8.2.sha256sum] = "eabb4a44450da02c90444cf74558da904edde8fb4e9035a9a6a4e15445af0bd7"
+SRC_URI[gdk-pixbuf-0.19.0.sha256sum] = "c311c47800051b87de1335e8792774d7cec551c91a0a3d109ab21d76b36f208f"
+SRC_URI[gdk-pixbuf-sys-0.19.0.sha256sum] = "3dcbd04c1b2c4834cc008b4828bc917d062483b88d26effde6342e5622028f96"
+SRC_URI[getrandom-0.2.12.sha256sum] = "190092ea657667030ac6a35e305e62fc4dd69fd98ac98631e5d3a2b1575a12b5"
+SRC_URI[gif-0.12.0.sha256sum] = "80792593675e051cf94a4b111980da2ba60d4a83e43e0048c5693baab3977045"
+SRC_URI[gio-0.19.0.sha256sum] = "b3d1aaa2d926710a27f3b35822806b1513b393b71174dd2601c9d02fdab0cb82"
+SRC_URI[gio-sys-0.19.0.sha256sum] = "bcf8e1d9219bb294636753d307b030c1e8a032062cba74f493c431a5c8b81ce4"
+SRC_URI[glib-0.19.0.sha256sum] = "170ee82b9b44b3b5fd1cf4971d6cf0eadec38303bb84c7bcc4e6b95a18934e71"
+SRC_URI[glib-macros-0.19.0.sha256sum] = "2ff52fff7e4d1bb8598ae744e9bb90c8c76271712483c3f0ce931bee9814de85"
+SRC_URI[glib-sys-0.19.0.sha256sum] = "630f097773d7c7a0bb3258df4e8157b47dc98bbfa0e60ad9ab56174813feced4"
+SRC_URI[gobject-sys-0.19.0.sha256sum] = "c85e2b1080b9418dd0c58b498da3a5c826030343e0ef07bde6a955d28de54979"
+SRC_URI[half-2.3.1.sha256sum] = "bc52e53916c08643f1b56ec082790d1e86a32e58dc5268f897f313fbae7b4872"
 SRC_URI[hashbrown-0.14.3.sha256sum] = "290f1a1d9242c78d09ce40a5e87e7554ee637af1351968159f4952f028f75604"
 SRC_URI[heck-0.4.1.sha256sum] = "95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
-SRC_URI[hermit-abi-0.3.3.sha256sum] = "d77f7ec81a6d05a3abb01ab6eb7590f6083d08449fe5a1c8b1e620283546ccb7"
-SRC_URI[iana-time-zone-0.1.58.sha256sum] = "8326b86b6cff230b97d0d312a6c40a60726df3332e721f72a1b035f451663b20"
+SRC_URI[hermit-abi-0.3.5.sha256sum] = "d0c62115964e08cb8039170eb33c1d0e2388a256930279edca206fff675f82c3"
+SRC_URI[iana-time-zone-0.1.60.sha256sum] = "e7ffbb5a1b541ea2561f8c41c087286cc091e21e556a4f09a8f6cbf17b69b141"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
 SRC_URI[idna-0.5.0.sha256sum] = "634d9b1461af396cad843f47fdba5597a4f9e6ddd4bfb6ff5d85028c25cb12f6"
-SRC_URI[indexmap-2.1.0.sha256sum] = "d530e1a18b1cb4c484e6e34556a0d948706958449fca0cab753d649f2bce3d1f"
-SRC_URI[is-terminal-0.4.9.sha256sum] = "cb0889898416213fab133e1d33a0e5858a48177452750691bde3666d0fdbaf8b"
+SRC_URI[image-0.24.8.sha256sum] = "034bbe799d1909622a74d1193aa50147769440040ff36cb2baa947609b0a4e23"
+SRC_URI[indexmap-2.2.2.sha256sum] = "824b2ae422412366ba479e8111fd301f7b5faece8149317bb81925979a53f520"
+SRC_URI[is-terminal-0.4.10.sha256sum] = "0bad00257d07be169d870ab665980b06cdb366d792ad690bf2e76876dc503455"
 SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
-SRC_URI[itertools-0.11.0.sha256sum] = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+SRC_URI[itertools-0.12.1.sha256sum] = "ba291022dbbd398a455acf126c1e341954079855bc60dfdda641363bd6922569"
 SRC_URI[itoa-1.0.10.sha256sum] = "b1a46d1a171d865aa5f83f92695765caa047a9b4cbae2cbf37dbd613a793fd4c"
-SRC_URI[js-sys-0.3.66.sha256sum] = "cee9c64da59eae3b50095c18d3e74f8b73c0b86d2792824ff01bbce68ba229ca"
+SRC_URI[jpeg-decoder-0.3.1.sha256sum] = "f5d4a7da358eff58addd2877a45865158f0d78c911d43a5784ceb7bbf52833b0"
+SRC_URI[js-sys-0.3.68.sha256sum] = "406cda4b368d531c842222cf9d2600a9a4acce8d29423695379c6868a143a9ee"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.151.sha256sum] = "302d7ab3130588088d277783b1e2d2e10c9e9e4a16dd9050e6ec93fb3e7048f4"
+SRC_URI[lebe-0.5.2.sha256sum] = "03087c2bad5e1034e8cace5926dec053fb3790248370865f5117a7d0213354c8"
+SRC_URI[libc-0.2.153.sha256sum] = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"
 SRC_URI[libloading-0.8.1.sha256sum] = "c571b676ddfc9a8c12f1f3d3085a7b163966a8fd8098a90640953ce5f6170161"
 SRC_URI[libm-0.2.8.sha256sum] = "4ec2a862134d2a7d32d7983ddcdd1c4923530833c9f2ea1a44fc5fa473989058"
 SRC_URI[linked-hash-map-0.5.6.sha256sum] = "0717cef1bc8b636c6e1c1bbdefc09e6322da8a9321966e8928ef80d20f7f770f"
-SRC_URI[linux-raw-sys-0.4.12.sha256sum] = "c4cd1a83af159aa67994778be9070f0ae1bd732942279cabb14f86f986a21456"
+SRC_URI[linux-raw-sys-0.4.13.sha256sum] = "01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"
 SRC_URI[locale_config-0.3.0.sha256sum] = "08d2c35b16f4483f6c26f0e4e9550717a2f6575bcd6f12a53ff0c490a94a6934"
 SRC_URI[lock_api-0.4.11.sha256sum] = "3c168f8615b12bc01f9c17e2eb0cc07dcae1940121185446edc3744920e8ef45"
 SRC_URI[log-0.4.20.sha256sum] = "b5e6163cb8c49088c2c36f57875e58ccd8c87c7427f7fbd50ea6710b2f3f2e8f"
-SRC_URI[lopdf-0.31.0.sha256sum] = "07c8e1b6184b1b32ea5f72f572ebdc40e5da1d2921fa469947ff7c480ad1f85a"
+SRC_URI[lopdf-0.32.0.sha256sum] = "e775e4ee264e8a87d50a9efef7b67b4aa988cf94e75630859875fc347e6c872b"
 SRC_URI[mac-0.1.1.sha256sum] = "c41e0c4fef86961ac6d6f8a82609f55f31b05e4fce149ac5710e439df7619ba4"
 SRC_URI[malloc_buf-0.0.6.sha256sum] = "62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
 SRC_URI[markup5ever-0.11.0.sha256sum] = "7a2629bb1404f3d34c2e921f21fd34ba00b206124c81f65c50b43b6aaefeb016"
 SRC_URI[matches-0.1.10.sha256sum] = "2532096657941c2fea9c289d370a250971c689d4f143798ff67113ec042024a5"
 SRC_URI[matrixmultiply-0.3.8.sha256sum] = "7574c1cf36da4798ab73da5b215bbf444f50718207754cb522201d78d1cd0ff2"
 SRC_URI[md5-0.7.0.sha256sum] = "490cc448043f947bae3cbee9c203358d62dbee0db12107a74be5c30ccfd09771"
-SRC_URI[memchr-2.6.4.sha256sum] = "f665ee40bc4a3c5590afb1e9677db74a508659dfd71e126420da8274909a0167"
-SRC_URI[memoffset-0.9.0.sha256sum] = "5a634b1c61a95585bd15607c6ab0c4e5b226e695ff2800ba0cdccddf208c406c"
+SRC_URI[memchr-2.7.1.sha256sum] = "523dc4f511e55ab87b694dc30d0f820d60906ef06413f93d4d7a1385599cc149"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
+SRC_URI[miniz_oxide-0.7.2.sha256sum] = "9d811f3e15f28568be3407c8e7fdb6514c1cda3cb30683f15b6a1a1dc4ea14a7"
 SRC_URI[nalgebra-0.32.3.sha256sum] = "307ed9b18cc2423f29e83f84fd23a8e73628727990181f18641a8b5dc2ab1caa"
 SRC_URI[nalgebra-macros-0.2.1.sha256sum] = "91761aed67d03ad966ef783ae962ef9bbaca728d2dd7ceb7939ec110fffad998"
 SRC_URI[new_debug_unreachable-1.0.4.sha256sum] = "e4a24736216ec316047a1fc4252e27dabb04218aa4a3f37c6e7ddbf1f9782b54"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normalize-line-endings-0.3.0.sha256sum] = "61807f77802ff30975e01f4f071c8ba10c022052f98b3294119f3e615d13e5be"
-SRC_URI[num-complex-0.4.4.sha256sum] = "1ba157ca0885411de85d6ca030ba7e2a83a28636056c7c699b07c8b6f7383214"
-SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
+SRC_URI[num-complex-0.4.5.sha256sum] = "23c6602fda94a57c990fe0df199a035d83576b496aa29f4e634a8ac6004e68a6"
+SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
 SRC_URI[num-rational-0.4.1.sha256sum] = "0638a1c9d0a3c0914158145bc76cff373a75a627e6ecbfb71cbe6f453a5a19b0"
-SRC_URI[num-traits-0.2.17.sha256sum] = "39e3200413f237f41ab11ad6d161bc7239c84dcb631773ccd7de3dfe4b5c267c"
+SRC_URI[num-traits-0.2.18.sha256sum] = "da0df0e5185db44f69b44f26786fe401b6c293d1907744beaa7fa62b2e5a517a"
 SRC_URI[objc-0.2.7.sha256sum] = "915b1b472bc21c53464d6c8461c9d3af805ba1ef837e1cac254428f4a77177b1"
 SRC_URI[objc-foundation-0.1.1.sha256sum] = "1add1b659e36c9607c7aab864a76c7a4c2760cd0cd2e120f3fb8b952c7e22bf9"
 SRC_URI[objc_id-0.1.1.sha256sum] = "c92d4ddb4bd7b50d730c215ff871754d0da6b2178849f8a2a2ab69712d0c073b"
 SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
 SRC_URI[oorandom-11.1.3.sha256sum] = "0ab1bc2a289d34bd04a330323ac98a1b4bc82c9d9fcb1e66b63caa84da26b575"
-SRC_URI[pango-0.18.3.sha256sum] = "7ca27ec1eb0457ab26f3036ea52229edbdb74dee1edd29063f5b9b010e7ebee4"
-SRC_URI[pango-sys-0.18.0.sha256sum] = "436737e391a843e5933d6d9aa102cb126d501e815b83601365a948a518555dc5"
-SRC_URI[pangocairo-0.18.0.sha256sum] = "57036589a9cfcacf83f9e606d15813fc6bf03f0e9e69aa2b5e3bb85af86b38a5"
-SRC_URI[pangocairo-sys-0.18.0.sha256sum] = "fc3c8ff676a37e7a72ec1d5fc029f91c407278083d2752784ff9f5188c108833"
+SRC_URI[pango-0.19.0.sha256sum] = "78d7f779b957728c74fd1a060dfa6d89a0bea792ebc50cc2da80e4e87282d69e"
+SRC_URI[pango-sys-0.19.0.sha256sum] = "f52ef6a881c19fbfe3b1484df5cad411acaaba29dbec843941c3110d19f340ea"
+SRC_URI[pangocairo-0.19.1.sha256sum] = "9615c6294903a6ea26fa63984b18e51275354d1fa91bbde68eeb7fa3ab61a72f"
+SRC_URI[pangocairo-sys-0.19.0.sha256sum] = "01bd0597ae45983f9e8b7f73afc42238426cd3fbb44a9cf14fd881a4ae08f1e4"
 SRC_URI[parking_lot-0.12.1.sha256sum] = "3742b2c103b9f06bc9fff0a37ff4912935851bee6d36f3c02bcc755bcfec228f"
 SRC_URI[parking_lot_core-0.9.9.sha256sum] = "4c42a9226546d68acdd9c0a280d17ce19bfe27a46bf68784e4066115788d008e"
 SRC_URI[paste-1.0.14.sha256sum] = "de3145af08024dea9fa9914f381a17b8fc6034dfb00f3a84013f7ff43f29ed4c"
@@ -426,103 +446,104 @@ SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456
 SRC_URI[phf_shared-0.11.2.sha256sum] = "90fcb95eef784c2ac79119d1dd819e162b5da872ce6f3c3abe1e8ca1c082f72b"
 SRC_URI[pin-project-lite-0.2.13.sha256sum] = "8afb450f006bf6385ca15ef45d71d2288452bc3683ce2e2cacc0d18e4be60b58"
 SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
+SRC_URI[pkg-config-0.3.29.sha256sum] = "2900ede94e305130c13ddd391e0ab7cbaeb783945ae07a279c268cb05109c6cb"
 SRC_URI[plotters-0.3.5.sha256sum] = "d2c224ba00d7cadd4d5c660deaf2098e5e80e07846537c51f9cfa4be50c1fd45"
 SRC_URI[plotters-backend-0.3.5.sha256sum] = "9e76628b4d3a7581389a35d5b6e2139607ad7c75b17aed325f210aa91f4a9609"
 SRC_URI[plotters-svg-0.3.5.sha256sum] = "38f6d39893cca0701371e3c27294f09797214b86f1fb951b89ade8ec04e2abab"
-SRC_URI[png-0.17.10.sha256sum] = "dd75bf2d8dd3702b9707cdbc56a5b9ef42cec752eb8b3bafc01234558442aa64"
+SRC_URI[png-0.17.11.sha256sum] = "1f6c3c3e617595665b8ea2ff95a86066be38fb121ff920a9c0eb282abcd1da5a"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[predicates-3.0.4.sha256sum] = "6dfc28575c2e3f19cb3c73b93af36460ae898d426eba6fc15b9bd2a5220758a0"
+SRC_URI[predicates-3.1.0.sha256sum] = "68b87bfd4605926cdfefc1c3b5f8fe560e3feca9d5552cf68c466d3d8236c7e8"
 SRC_URI[predicates-core-1.0.6.sha256sum] = "b794032607612e7abeb4db69adb4e33590fa6cf1149e95fd7cb00e634b92f174"
 SRC_URI[predicates-tree-1.0.9.sha256sum] = "368ba315fb8c5052ab692e68a0eefec6ec57b23a36959c14496f0b0df2c0cecf"
-SRC_URI[proc-macro-crate-2.0.1.sha256sum] = "97dc5fea232fc28d2f597b37c4876b348a40e33f3b02cc975c8d006d78d94b1a"
-SRC_URI[proc-macro-error-1.0.4.sha256sum] = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
-SRC_URI[proc-macro-error-attr-1.0.4.sha256sum] = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
-SRC_URI[proc-macro2-1.0.70.sha256sum] = "39278fbbf5fb4f646ce651690877f89d1c5811a3d4acb27700c1cb3cdb78fd3b"
+SRC_URI[proc-macro-crate-3.1.0.sha256sum] = "6d37c51ca738a55da99dc0c4a34860fd675453b8b36209178c2249bb13651284"
+SRC_URI[proc-macro2-1.0.78.sha256sum] = "e2422ad645d89c99f8f3e6b88a9fdeca7fabeac836b1002371c4367c8f984aae"
 SRC_URI[proptest-1.4.0.sha256sum] = "31b476131c3c86cb68032fdc5cb6d5a1045e3e42d96b69fa599fd77701e1f5bf"
+SRC_URI[qoi-0.4.1.sha256sum] = "7f6d64c71eb498fe9eae14ce4ec935c555749aef511cca85b5568910d6e48001"
 SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
 SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
+SRC_URI[quote-1.0.35.sha256sum] = "291ec9ab5efd934aaf503a6466c5d5251535d108ee747472c3977cc5acc868ef"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
 SRC_URI[rawpointer-0.2.1.sha256sum] = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
-SRC_URI[rayon-1.8.0.sha256sum] = "9c27db03db7734835b3f53954b534c91069375ce6ccaa2e065441e07d9b6cdb1"
-SRC_URI[rayon-core-1.12.0.sha256sum] = "5ce3fb6ad83f861aac485e76e1985cd109d9a3713802152be56c3b1f0e0658ed"
-SRC_URI[rctree-0.5.0.sha256sum] = "3b42e27ef78c35d3998403c1d26f3efd9e135d3e5121b0a4845cc5cc27547f4f"
+SRC_URI[rayon-1.8.1.sha256sum] = "fa7237101a77a10773db45d62004a272517633fbcc3df19d96455ede1122e051"
+SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
+SRC_URI[rctree-0.6.0.sha256sum] = "e03e7866abec1101869ffa8e2c8355c4c2419d0214ece0cc3e428e5b94dea6e9"
 SRC_URI[redox_syscall-0.4.1.sha256sum] = "4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
-SRC_URI[regex-1.10.2.sha256sum] = "380b951a9c5e80ddfd6136919eef32310721aa4aacd4889a8d39124b026ab343"
-SRC_URI[regex-automata-0.4.3.sha256sum] = "5f804c7828047e88b2d32e2d7fe5a105da8ee3264f01902f796c8e067dc2483f"
+SRC_URI[regex-1.10.3.sha256sum] = "b62dbe01f0b06f9d8dc7d49e05a0785f153b00b2c227856282f671e0318c9b15"
+SRC_URI[regex-automata-0.4.5.sha256sum] = "5bb987efffd3c6d0d8f5f89510bb458559eab11e4f869acb20bf845e016259cd"
 SRC_URI[regex-syntax-0.8.2.sha256sum] = "c08c74e62047bb2de4ff487b251e4a92e24f48745648451635cec7d591162d9f"
 SRC_URI[rgb-0.8.37.sha256sum] = "05aaa8004b64fd573fc9d002f4e632d51ad4f026c2b5ba95fcb6c2f32c2c47d8"
-SRC_URI[rustix-0.38.28.sha256sum] = "72e572a5e8ca657d7366229cdde4bd14c4eb5499a9573d4d366fe1b599daa316"
+SRC_URI[rustix-0.38.31.sha256sum] = "6ea3e1a662af26cd7a3ba09c0297a31af215563ecf42817c98df621387f4e949"
 SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
 SRC_URI[ryu-1.0.16.sha256sum] = "f98d2aa92eebf49b69786be48e4477826b256916e84a57ff2a4f21923b48eb4c"
 SRC_URI[safe_arch-0.7.1.sha256sum] = "f398075ce1e6a179b46f51bd88d0598b92b00d3551f1a2d4ac49e771b56ac354"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[selectors-0.25.0.sha256sum] = "4eb30575f3638fc8f6815f448d50cb1a2e255b0897985c8c59f4d37b72a07b06"
-SRC_URI[serde-1.0.193.sha256sum] = "25dd9975e68d0cb5aa1120c288333fc98731bd1dd12f561e468ea4728c042b89"
-SRC_URI[serde_derive-1.0.193.sha256sum] = "43576ca501357b9b071ac53cdc7da8ef0cbd9493d8df094cd821777ea6e894d3"
-SRC_URI[serde_json-1.0.108.sha256sum] = "3d1c7e3eac408d115102c4c24ad393e0821bb3a5df4d506a80f85f7a742a526b"
-SRC_URI[serde_spanned-0.6.4.sha256sum] = "12022b835073e5b11e90a14f86838ceb1c8fb0325b72416845c487ac0fa95e80"
+SRC_URI[serde-1.0.196.sha256sum] = "870026e60fa08c69f064aa766c10f10b1d62db9ccd4d0abb206472bee0ce3b32"
+SRC_URI[serde_derive-1.0.196.sha256sum] = "33c85360c95e7d137454dc81d9a4ed2b8efd8fbe19cee57357b32b9771fccb67"
+SRC_URI[serde_json-1.0.113.sha256sum] = "69801b70b1c3dac963ecb03a364ba0ceda9cf60c71cfe475e99864759c8b8a79"
+SRC_URI[serde_spanned-0.6.5.sha256sum] = "eb3622f419d1296904700073ea6cc23ad690adbd66f13ea683df73298736f0c1"
 SRC_URI[servo_arc-0.3.0.sha256sum] = "d036d71a959e00c77a63538b90a6c2390969f9772b096ea837205c6bd0491a44"
 SRC_URI[simba-0.8.1.sha256sum] = "061507c94fc6ab4ba1c9a0305018408e312e17c041eb63bef8aa726fa33aceae"
 SRC_URI[simd-adler32-0.3.7.sha256sum] = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
 SRC_URI[siphasher-0.3.11.sha256sum] = "38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
 SRC_URI[slab-0.4.9.sha256sum] = "8f92a496fb766b417c996b9c5e57daf2f7ad3b0bebe1ccfca4856390e3d3bb67"
-SRC_URI[smallvec-1.11.2.sha256sum] = "4dccd0940a2dcdf68d092b8cbab7dc0ad8fa938bf95787e1b916b0e3d0e8e970"
+SRC_URI[smallvec-1.13.1.sha256sum] = "e6ecd384b10a64542d77071bd64bd7b231f4ed5940fba55e98c3de13824cf3d7"
+SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
 SRC_URI[stable_deref_trait-1.2.0.sha256sum] = "a8f112729512f8e442d81f95a8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
 SRC_URI[string_cache-0.8.7.sha256sum] = "f91138e76242f575eb1d3b38b4f1362f10d3a43f47d182a5b359af488a02293b"
 SRC_URI[string_cache_codegen-0.5.2.sha256sum] = "6bb30289b722be4ff74a408c3cc27edeaad656e06cb1fe8fa9231fa59c728988"
 SRC_URI[strsim-0.10.0.sha256sum] = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.41.sha256sum] = "44c8b28c477cc3bf0e7966561e3460130e1255f7a1cf71931075f1c5e7a7e269"
+SRC_URI[syn-2.0.48.sha256sum] = "0f3531638e407dfc0814761abb7c00a5b54992b849452a0646b7f65c9f770f3f"
 SRC_URI[system-deps-6.2.0.sha256sum] = "2a2d580ff6a20c55dfb86be5f9c238f67835d0e81cbdea8bf5680e0897320331"
-SRC_URI[target-lexicon-0.12.12.sha256sum] = "14c39fd04924ca3a864207c66fc2cd7d22d7c016007f9ce846cbb9326331930a"
-SRC_URI[tempfile-3.8.1.sha256sum] = "7ef1adac450ad7f4b3c28589471ade84f25f731a7a0fe30d71dfa9f60fd808e5"
+SRC_URI[target-lexicon-0.12.13.sha256sum] = "69758bda2e78f098e4ccb393021a0963bb3442eac05f135c30f61b7370bbafae"
+SRC_URI[tempfile-3.10.0.sha256sum] = "a365e8cd18e44762ef95d87f284f4b5cd04107fec2ff3052bd6a3e6069669e67"
 SRC_URI[tendril-0.4.3.sha256sum] = "d24a120c5fc464a3458240ee02c299ebcb9d67b5249c8848b09d639dca8d7bb0"
 SRC_URI[termtree-0.4.1.sha256sum] = "3369f5ac52d5eb6ab48c6b4ffdc8efbcad6b89c765749064ba298f2c68a16a76"
-SRC_URI[thiserror-1.0.50.sha256sum] = "f9a7210f5c9a7156bb50aa36aed4c95afb51df0df00713949448cf9e97d382d2"
-SRC_URI[thiserror-impl-1.0.50.sha256sum] = "266b2e40bc00e5a6c09c3584011e08b06f123c00362c92b975ba9843aaaa14b8"
-SRC_URI[time-0.3.30.sha256sum] = "c4a34ab300f2dee6e562c10a046fc05e358b29f9bf92277f30c3c8d82275f6f5"
+SRC_URI[thiserror-1.0.56.sha256sum] = "d54378c645627613241d077a3a79db965db602882668f9136ac42af9ecb730ad"
+SRC_URI[thiserror-impl-1.0.56.sha256sum] = "fa0faa943b50f3db30a20aa7e265dbc66076993efed8463e8de414e5d06d3471"
+SRC_URI[tiff-0.9.1.sha256sum] = "ba1310fcea54c6a9a4fd1aad794ecc02c31682f6bfbecdf460bf19533eed1e3e"
+SRC_URI[time-0.3.34.sha256sum] = "c8248b6521bb14bc45b4067159b9b6ad792e2d6d754d6c41fb50e29fefe38749"
 SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.15.sha256sum] = "4ad70d68dba9e1f8aceda7aa6711965dfec1cac869f311a51bd08b3a2ccbce20"
+SRC_URI[time-macros-0.2.17.sha256sum] = "7ba3a3ef41e6672a2f0f001392bb5dcd3ff0a9992d618ca761a11c3121547774"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.6.0.sha256sum] = "87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.8.2.sha256sum] = "185d8ab0dfbb35cf1399a6344d8484209c088f75f8f68230da55d48d95d43e3d"
-SRC_URI[toml_datetime-0.6.3.sha256sum] = "7cda73e2f1397b1262d6dfdcef8aafae14d1de7748d66822d3bfeeb6d03e5e4b"
-SRC_URI[toml_edit-0.20.2.sha256sum] = "396e4d48bbb2b7554c944bde63101b5ae446cff6ec4a24227428f15eb72ef338"
+SRC_URI[toml-0.8.10.sha256sum] = "9a9aad4a3066010876e8dcf5a8a06e70a558751117a145c6ce2b82c2e2054290"
+SRC_URI[toml_datetime-0.6.5.sha256sum] = "3550f4e9685620ac18a50ed434eb3aec30db8ba93b0287467bca5826ea25baf1"
+SRC_URI[toml_edit-0.21.1.sha256sum] = "6a8534fd7f78b5405e860340ad6575217ce99f38d4d5c8f2442cb5ecb50090e1"
+SRC_URI[toml_edit-0.22.4.sha256sum] = "0c9ffdf896f8daaabf9b66ba8e77ea1ed5ed0f72821b398aba62352e95062951"
 SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
-SRC_URI[unicode-bidi-0.3.14.sha256sum] = "6f2528f27a9eb2b21e69c95319b30bd0efd85d09c379741b0f78ea1d86be2416"
+SRC_URI[unicode-bidi-0.3.15.sha256sum] = "08f95100a766bf4f8f28f90d77e0a5461bbdb219042e7679bebe79004fed8d75"
 SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 SRC_URI[unicode-normalization-0.1.22.sha256sum] = "5c5713f0fc4b5db668a2ac63cdb7bb4469d8c9fed047b1d0292cc7b0ce2ba921"
 SRC_URI[url-2.5.0.sha256sum] = "31e6302e3bb753d46e83516cae55ae196fc0c309407cf11ab35cc51a4c2a4633"
 SRC_URI[utf-8-0.7.6.sha256sum] = "09cc8ee72d2a9becf2f2febe0205bbed8fc6615b7cb429ad062dc7b7ddd036a9"
 SRC_URI[utf8parse-0.2.1.sha256sum] = "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
 SRC_URI[version-compare-0.1.1.sha256sum] = "579a42fc0b8e0c63b76519a339be31bed574929511fa53c1a3acae26eb258f29"
-SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
 SRC_URI[walkdir-2.4.0.sha256sum] = "d71d857dc86794ca4c280d616f7da00d2dbfd8cd788846559a6813e6aa4b54ee"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.89.sha256sum] = "0ed0d4f68a3015cc185aff4db9506a015f4b96f95303897bfa23f846db54064e"
-SRC_URI[wasm-bindgen-backend-0.2.89.sha256sum] = "1b56f625e64f3a1084ded111c4d5f477df9f8c92df113852fa5a374dbda78826"
-SRC_URI[wasm-bindgen-macro-0.2.89.sha256sum] = "0162dbf37223cd2afce98f3d0785506dcb8d266223983e4b5b525859e6e182b2"
-SRC_URI[wasm-bindgen-macro-support-0.2.89.sha256sum] = "f0eb82fcb7930ae6219a7ecfd55b217f5f0893484b7a13022ebb2b2bf20b5283"
-SRC_URI[wasm-bindgen-shared-0.2.89.sha256sum] = "7ab9b36309365056cd639da3134bf87fa8f3d86008abf99e612384a6eecd459f"
-SRC_URI[web-sys-0.3.66.sha256sum] = "50c24a44ec86bb68fbecd1b3efed7e85ea5621b39b35ef2766b66cd984f8010f"
-SRC_URI[weezl-0.1.7.sha256sum] = "9193164d4de03a926d909d3bc7c30543cecb35400c02114792c2cae20d5e2dbb"
-SRC_URI[wide-0.7.13.sha256sum] = "c68938b57b33da363195412cfc5fc37c9ed49aa9cfe2156fde64b8d2c9498242"
+SRC_URI[wasm-bindgen-0.2.91.sha256sum] = "c1e124130aee3fb58c5bdd6b639a0509486b0338acaaae0c84a5124b0f588b7f"
+SRC_URI[wasm-bindgen-backend-0.2.91.sha256sum] = "c9e7e1900c352b609c8488ad12639a311045f40a35491fb69ba8c12f758af70b"
+SRC_URI[wasm-bindgen-macro-0.2.91.sha256sum] = "b30af9e2d358182b5c7449424f017eba305ed32a7010509ede96cdc4696c46ed"
+SRC_URI[wasm-bindgen-macro-support-0.2.91.sha256sum] = "642f325be6301eb8107a83d12a8ac6c1e1c54345a7ef1a9261962dfefda09e66"
+SRC_URI[wasm-bindgen-shared-0.2.91.sha256sum] = "4f186bd2dcf04330886ce82d6f33dd75a7bfcf69ecf5763b89fcde53b6ac9838"
+SRC_URI[web-sys-0.3.68.sha256sum] = "96565907687f7aceb35bc5fc03770a8a0471d82e479f25832f54a0e3f4b28446"
+SRC_URI[weezl-0.1.8.sha256sum] = "53a85b86a771b1c87058196170769dd264f66c0782acf1ae6cc51bfd64b39082"
+SRC_URI[wide-0.7.15.sha256sum] = "89beec544f246e679fc25490e3f8e08003bc4bf612068f325120dad4cea02c1c"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.6.sha256sum] = "f29e6f9198ba0d26b4c9f07dbe6f9ed633e1f3d5b8b414090084349e46a52596"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-core-0.51.1.sha256sum] = "f1f8cf84f35d2db49a46868f947758c7a1138116f7fac3bc844f43ade1292e64"
+SRC_URI[windows-core-0.52.0.sha256sum] = "33ab640c8d7e35bf8ba19b884ba838ceb4fba93a4e8c65a9059d08afcfc683d9"
 SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
@@ -541,6 +562,7 @@ SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390d
 SRC_URI[windows_x86_64_gnullvm-0.52.0.sha256sum] = "1a657e1e9d3f514745a572a6846d3c7aa7dbe1658c056ed9c3344c4109a6949e"
 SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
 SRC_URI[windows_x86_64_msvc-0.52.0.sha256sum] = "dff9641d1cd4be8d1a070daf9e3773c5f67e78b4d9d42263020c057706765c04"
-SRC_URI[winnow-0.5.28.sha256sum] = "6c830786f7720c2fd27a1a0e27a709dbd3c4d009b56d098fc742d4f4eab91fe2"
+SRC_URI[winnow-0.5.39.sha256sum] = "5389a154b01683d28c77f8f68f49dea75f0a4da32557a58f68ee51ebba472d29"
 SRC_URI[xml5ever-0.17.0.sha256sum] = "4034e1d05af98b51ad7214527730626f019682d797ba38b51689212118d8e650"
 SRC_URI[yeslogic-fontconfig-sys-4.0.1.sha256sum] = "ec657fd32bbcbeaef5c7bc8e10b3db95b143fab8db0a50079773dbf936fd4f73"
+SRC_URI[zune-inflate-0.2.54.sha256sum] = "73ab332fe2f6680068f3582b16a24f90ad7096d5d39b974d1c0aff0125116f02"
diff --git a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
index c08ce82..8051eb6 100644
--- a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
@@ -1,4 +1,4 @@
-From eee6c251bceb235912887a54c58a2fc2d4450216 Mon Sep 17 00:00:00 2001
+From 6e2cff10a4f24e89e6aee8250a9ac5527fdaa910 Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex@linutronix.de>
 Date: Tue, 21 Sep 2021 16:27:14 +0200
 Subject: [PATCH] Makefile.am: pass rust target to cargo also when not cross
@@ -14,10 +14,10 @@ Signed-off-by: Alexander Kanavin <alex@linutronix.de>
  2 files changed, 1 insertion(+), 5 deletions(-)
 
 diff --git a/Makefile.am b/Makefile.am
-index 2a89954..4e296d3 100644
+index b1cd889..9d33432 100644
 --- a/Makefile.am
 +++ b/Makefile.am
-@@ -173,9 +173,7 @@ else
+@@ -170,9 +170,7 @@ else
  CARGO_RELEASE_ARGS=--release
  endif
  
@@ -28,10 +28,10 @@ index 2a89954..4e296d3 100644
  CARGO_VERBOSE = $(cargo_verbose_$(V))
  cargo_verbose_ = $(cargo_verbose_$(AM_DEFAULT_VERBOSITY))
 diff --git a/configure.ac b/configure.ac
-index 480e27e..587c4db 100644
+index 2c4995e..1370a36 100644
 --- a/configure.ac
 +++ b/configure.ac
-@@ -292,9 +292,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=$host)])
+@@ -291,9 +291,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=$host)])
  : ${RUST_TARGET:=$host}
  
  AM_CONDITIONAL([CROSS_COMPILING], [test "x$cross_compiling" = xyes])
diff --git a/recipes-gnome/librsvg/librsvg_2.57.3.bb b/recipes-gnome/librsvg/librsvg_2.58.1.bb
similarity index 96%
rename from recipes-gnome/librsvg/librsvg_2.57.3.bb
rename to recipes-gnome/librsvg/librsvg_2.58.1.bb
index 5314ef9..ed4ac38 100644
--- a/recipes-gnome/librsvg/librsvg_2.57.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.58.1.bb
@@ -23,7 +23,7 @@ SRC_URI += " \
            file://disable-rsvg-loader-test.patch \
            "
 
-SRC_URI[archive.sha256sum] = "1b2267082c0b77ef93b15747a5c754584eb5886baf2d5a08011cde0659c2c479"
+SRC_URI[archive.sha256sum] = "3728596290a8576d305d06ec8afdf473516feee9dff22e03235eac433d56824e"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.46.0


