Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4913C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:18 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48541.1789157651354020862
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=t+mKb3Qr;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530d93a18ecso11192041cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157650; x=1789762450; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VF4ZcrRm+jpAtp2e7USSRB7BWCn+UplnUrF78TqKsMk=;
        b=t+mKb3QrMLg3Hr5ry70+nF/D7Lea7u9EsN+kNMjAXnwy5lOfrwjrQeoaVTPmC3vrRv
         bOBOyFIFU9FizC6gBXqkfj+mPdDrU7gPNUXWUHpucitu0KPAdfULHro9Z4VHSc5D6gM3
         aYukQeFmbIbK8bqo72QkZ0yAvKQu8Ye88E6Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157650; x=1789762450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VF4ZcrRm+jpAtp2e7USSRB7BWCn+UplnUrF78TqKsMk=;
        b=BPnKOqUMHB8tG2UCB22vof4QD6ju4Jm/2onbMXeLM3xw+88pYj74Ax+QX0LFCfw7Za
         LrVmCq8Dyg64h8AwTEBoyGTmmen8VDlvr1BFpVwDhHBp7+CbDe16kMqs1qWtFIiCAH0H
         6SaDJJOmXSIep/edER4e5Glmi93Vy0L5I2cmfTDSS1pJC77c9RuGhHbz+ohOAna48vNi
         nOtOgblqGRFW4kxI4MhA4QhfUZgmodN+Bv+aMA1eDaJF0vrXI6icyrG/0zgkrxd9LbWb
         i0cN2+jujYK+rTcMLw77wt+wBK/zPr/X7EudAMdP2k2MlFT09zle46MS6DWi0H42C4PZ
         52Jw==
X-Gm-Message-State: AFuF++muxPaiLa5EJIciv6lnzhNSWeqXSQ5rSpvmiRKT1IYP4iMq6aKY
	QAtdiSTaeKdOav6rBiu6D0bxm8kZ8CbRXprvLTC5EgZlo6onlV7UKqrZ218Y7N9n3414/fmSGyw
	aQDIe
X-Gm-Gg: AYBFou2e3ACGWTSbZxbWIaiJjtXBidb8wo0d4IsXk6R9POnB/Pi57h+oKlIN1pDCOs2
	ancX1hTwwIddlvoF1tHtNwrGDEDsiVX5R08Uf+jILUe15pUMT3kAU5tqid3tXFl4uDUI4vxXyZW
	/jvu47j7d3xzd4tONB2H9TuSyPb5PDODrCAqIQDZwRb6fgYZkvHg2OCVOTeY1hwRkWqSOeG9BsE
	3yLpMs2v+vqVxKCJ46Vr0onsg3TkDb41fW/Zxla36nAxvpbuH7d3tGo0ZJnny35iB6bzl+Vce5+
	6p/Hn/BIo4WeY+raS+7ccQNfoeczJt5cJd/E5IzLhqhHhqBaDD9gxKK9ksaPv77TQvpmm+Jf23F
	gTca3SaHp2n81TZafTALjmL3ZCFbIGrJcsHbaMGJ1oLkX42P7BcwvZkHLu6XVxWz43PiUDkLrJ6
	Yic6aQ2sukWhPncahosTieKzMbni/3yCxJ+gPLi7l27ZWD+fZ+7GT707fWnPv0ObgKxI9+lSvAN
	wZYaXPuUK7Xul6UiOc2Um1+Nx2DYbCaaEvLGVr8EKOsAR94oLJlzR5iChXFR6BBgjy9dpa3f9E5
	rX+v7w5ZzswGJR1AxyXt3gdxHKzcZihnr9w=
X-Received: by 2002:a05:622a:38b:b0:530:b2e2:d7da with SMTP id d75a77b69052e-530c8782178mr87606621cf.53.1789157649361;
        Fri, 11 Sep 2026 13:14:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:08 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 33/37] cargo-c: upgrade 0.10.24 -> 0.10.25
Date: Fri, 11 Sep 2026 16:13:19 -0400
Message-ID: <9fe8b261aba603b97146ad5ca6119a6047af0593.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4799

From: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>

Cargo-c version updated to stable version 0.10.25+cargo-0.99.0.

https://crates.io/crates/cargo-c/0.10.25+cargo-0.99.0
https://github.com/lu-zero/cargo-c/compare/v0.10.24...v0.10.25

Signed-off-by: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 5a86378f77b71f7a11638f8c485d8ebdcb81a9f7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 561 +++++++++---------
 ...8.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} |   2 +-
 2 files changed, 274 insertions(+), 289 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.24+cargo-0.98.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} (87%)

diff --git a/recipes-devtools/cargo-c/cargo-c-crates.inc b/recipes-devtools/cargo-c/cargo-c-crates.inc
index a69c2f2..4d24368 100644
--- a/recipes-devtools/cargo-c/cargo-c-crates.inc
+++ b/recipes-devtools/cargo-c/cargo-c-crates.inc
@@ -3,57 +3,56 @@
 # from Cargo.lock
 SRC_URI += " \
     crate://crates.io/adler2/2.0.1 \
-    crate://crates.io/aho-corasick/1.1.4 \
+    crate://crates.io/aho-corasick/1.1.5 \
     crate://crates.io/allocator-api2/0.2.21 \
-    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/android_system_properties/0.1.6 \
     crate://crates.io/annotate-snippets/0.12.16 \
     crate://crates.io/anstream/1.0.0 \
     crate://crates.io/anstyle/1.0.14 \
     crate://crates.io/anstyle-hyperlink/1.0.2 \
     crate://crates.io/anstyle-parse/1.0.0 \
-    crate://crates.io/anstyle-progress/0.1.0 \
+    crate://crates.io/anstyle-progress/0.1.4 \
     crate://crates.io/anstyle-query/1.1.5 \
     crate://crates.io/anstyle-wincon/3.0.11 \
-    crate://crates.io/anyhow/1.0.103 \
-    crate://crates.io/ar_archive_writer/0.5.2 \
+    crate://crates.io/anyhow/1.0.104 \
+    crate://crates.io/ar_archive_writer/0.5.3 \
     crate://crates.io/arc-swap/1.9.2 \
-    crate://crates.io/arrayref/0.3.9 \
     crate://crates.io/arrayvec/0.7.8 \
-    crate://crates.io/async-trait/0.1.89 \
+    crate://crates.io/async-trait/0.1.92 \
     crate://crates.io/autocfg/1.5.1 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
     crate://crates.io/base64ct/1.8.3 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.13.0 \
+    crate://crates.io/bitflags/2.13.1 \
     crate://crates.io/bitmaps/2.1.0 \
-    crate://crates.io/blake3/1.8.5 \
+    crate://crates.io/blake3/1.8.7 \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/block-buffer/0.12.1 \
     crate://crates.io/block2/0.6.2 \
-    crate://crates.io/bstr/1.12.3 \
+    crate://crates.io/bstr/1.13.1 \
     crate://crates.io/bumpalo/3.20.3 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.12.1 \
-    crate://crates.io/camino/1.2.4 \
-    crate://crates.io/cargo/0.98.0 \
+    crate://crates.io/camino/1.2.5 \
+    crate://crates.io/cargo/0.99.0 \
     crate://crates.io/cargo-credential/0.4.10 \
-    crate://crates.io/cargo-credential-libsecret/0.5.8 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.23 \
-    crate://crates.io/cargo-credential-wincred/0.4.23 \
+    crate://crates.io/cargo-credential-libsecret/0.5.9 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.24 \
+    crate://crates.io/cargo-credential-wincred/0.4.24 \
     crate://crates.io/cargo-platform/0.3.3 \
-    crate://crates.io/cargo-util/0.2.30 \
-    crate://crates.io/cargo-util-schemas/0.14.1 \
-    crate://crates.io/cargo-util-terminal/0.1.0 \
+    crate://crates.io/cargo-util/0.2.31 \
+    crate://crates.io/cargo-util-schemas/0.14.2 \
+    crate://crates.io/cargo-util-terminal/0.1.1 \
     crate://crates.io/cbindgen/0.29.4 \
-    crate://crates.io/cc/1.2.66 \
+    crate://crates.io/cc/1.4.4 \
     crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/cfg_aliases/0.2.1 \
+    crate://crates.io/cfg_aliases/0.2.2 \
     crate://crates.io/chacha20/0.10.1 \
-    crate://crates.io/clap/4.6.1 \
-    crate://crates.io/clap_builder/4.6.0 \
-    crate://crates.io/clap_complete/4.6.7 \
-    crate://crates.io/clap_derive/4.6.1 \
+    crate://crates.io/clap/4.6.6 \
+    crate://crates.io/clap_builder/4.6.6 \
+    crate://crates.io/clap_complete/4.6.9 \
+    crate://crates.io/clap_derive/4.6.4 \
     crate://crates.io/clap_lex/1.1.0 \
     crate://crates.io/clru/0.6.3 \
     crate://crates.io/cmov/0.5.4 \
@@ -67,8 +66,8 @@ SRC_URI += " \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
     crate://crates.io/cpufeatures/0.3.0 \
-    crate://crates.io/crates-io/0.41.0 \
-    crate://crates.io/crc32fast/1.5.0 \
+    crate://crates.io/crates-io/0.41.1 \
+    crate://crates.io/crc32fast/1.5.1 \
     crate://crates.io/crossbeam-channel/0.5.16 \
     crate://crates.io/crossbeam-deque/0.8.7 \
     crate://crates.io/crossbeam-epoch/0.9.20 \
@@ -89,11 +88,11 @@ SRC_URI += " \
     crate://crates.io/digest/0.10.7 \
     crate://crates.io/digest/0.11.3 \
     crate://crates.io/dispatch2/0.3.1 \
-    crate://crates.io/displaydoc/0.2.6 \
+    crate://crates.io/displaydoc/0.2.7 \
     crate://crates.io/dunce/1.0.5 \
     crate://crates.io/ecdsa/0.16.9 \
-    crate://crates.io/ed25519-compact/2.3.1 \
-    crate://crates.io/either/1.16.0 \
+    crate://crates.io/ed25519-compact/2.4.2 \
+    crate://crates.io/either/1.18.0 \
     crate://crates.io/elliptic-curve/0.13.8 \
     crate://crates.io/encoding_rs/0.8.35 \
     crate://crates.io/equivalent/1.0.2 \
@@ -102,96 +101,92 @@ SRC_URI += " \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
     crate://crates.io/faster-hex/0.10.0 \
-    crate://crates.io/fastrand/2.4.1 \
+    crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/ff/0.13.1 \
     crate://crates.io/fiat-crypto/0.3.0 \
     crate://crates.io/filetime/0.2.29 \
-    crate://crates.io/find-msvc-tools/0.1.9 \
+    crate://crates.io/find-msvc-tools/0.1.11 \
     crate://crates.io/flate2/1.1.9 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/foldhash/0.2.0 \
     crate://crates.io/foreign-types/0.3.2 \
     crate://crates.io/foreign-types-shared/0.1.1 \
     crate://crates.io/form_urlencoded/1.2.2 \
-    crate://crates.io/futures/0.3.32 \
-    crate://crates.io/futures-channel/0.3.32 \
-    crate://crates.io/futures-core/0.3.32 \
-    crate://crates.io/futures-executor/0.3.32 \
-    crate://crates.io/futures-io/0.3.32 \
-    crate://crates.io/futures-macro/0.3.32 \
-    crate://crates.io/futures-sink/0.3.32 \
-    crate://crates.io/futures-task/0.3.32 \
+    crate://crates.io/futures/0.3.34 \
+    crate://crates.io/futures-channel/0.3.34 \
+    crate://crates.io/futures-core/0.3.34 \
+    crate://crates.io/futures-executor/0.3.34 \
+    crate://crates.io/futures-io/0.3.34 \
+    crate://crates.io/futures-macro/0.3.34 \
+    crate://crates.io/futures-sink/0.3.34 \
+    crate://crates.io/futures-task/0.3.34 \
     crate://crates.io/futures-timer/3.0.4 \
-    crate://crates.io/futures-util/0.3.32 \
+    crate://crates.io/futures-util/0.3.34 \
     crate://crates.io/generic-array/0.14.9 \
     crate://crates.io/getrandom/0.2.17 \
     crate://crates.io/getrandom/0.4.3 \
-    crate://crates.io/git2/0.20.4 \
-    crate://crates.io/git2-curl/0.21.0 \
-    crate://crates.io/gix/0.83.0 \
-    crate://crates.io/gix-actor/0.41.1 \
-    crate://crates.io/gix-archive/0.32.0 \
+    crate://crates.io/git2/0.21.0 \
+    crate://crates.io/git2-curl/0.22.0 \
+    crate://crates.io/gix/0.85.0 \
+    crate://crates.io/gix-actor/0.41.2 \
     crate://crates.io/gix-attributes/0.33.2 \
-    crate://crates.io/gix-bitmap/0.3.2 \
-    crate://crates.io/gix-blame/0.13.0 \
-    crate://crates.io/gix-chunk/0.7.2 \
-    crate://crates.io/gix-command/0.9.1 \
+    crate://crates.io/gix-bitmap/0.3.3 \
+    crate://crates.io/gix-chunk/0.7.3 \
+    crate://crates.io/gix-command/0.9.2 \
     crate://crates.io/gix-commitgraph/0.37.1 \
-    crate://crates.io/gix-config/0.56.0 \
+    crate://crates.io/gix-config/0.58.0 \
     crate://crates.io/gix-config-value/0.18.1 \
-    crate://crates.io/gix-credentials/0.38.1 \
-    crate://crates.io/gix-date/0.15.5 \
-    crate://crates.io/gix-diff/0.63.0 \
-    crate://crates.io/gix-dir/0.25.0 \
-    crate://crates.io/gix-discover/0.51.0 \
-    crate://crates.io/gix-error/0.2.4 \
+    crate://crates.io/gix-credentials/0.38.2 \
+    crate://crates.io/gix-date/0.15.6 \
+    crate://crates.io/gix-diff/0.65.0 \
+    crate://crates.io/gix-dir/0.27.0 \
+    crate://crates.io/gix-discover/0.53.0 \
+    crate://crates.io/gix-error/0.2.5 \
     crate://crates.io/gix-features/0.48.1 \
-    crate://crates.io/gix-filter/0.30.0 \
+    crate://crates.io/gix-filter/0.32.0 \
     crate://crates.io/gix-fs/0.21.2 \
     crate://crates.io/gix-glob/0.26.1 \
     crate://crates.io/gix-hash/0.25.1 \
     crate://crates.io/gix-hashtable/0.15.2 \
     crate://crates.io/gix-ignore/0.21.1 \
-    crate://crates.io/gix-imara-diff/0.2.3 \
-    crate://crates.io/gix-index/0.51.0 \
+    crate://crates.io/gix-imara-diff/0.2.5 \
+    crate://crates.io/gix-index/0.53.0 \
     crate://crates.io/gix-lock/23.0.1 \
-    crate://crates.io/gix-merge/0.16.0 \
-    crate://crates.io/gix-negotiate/0.31.0 \
-    crate://crates.io/gix-object/0.60.0 \
-    crate://crates.io/gix-odb/0.80.0 \
-    crate://crates.io/gix-pack/0.70.0 \
+    crate://crates.io/gix-negotiate/0.33.0 \
+    crate://crates.io/gix-object/0.62.0 \
+    crate://crates.io/gix-odb/0.82.0 \
+    crate://crates.io/gix-pack/0.72.0 \
     crate://crates.io/gix-packetline/0.21.5 \
-    crate://crates.io/gix-path/0.12.1 \
+    crate://crates.io/gix-path/0.12.5 \
     crate://crates.io/gix-pathspec/0.18.1 \
     crate://crates.io/gix-prompt/0.15.1 \
-    crate://crates.io/gix-protocol/0.61.0 \
+    crate://crates.io/gix-protocol/0.63.0 \
     crate://crates.io/gix-quote/0.7.2 \
-    crate://crates.io/gix-ref/0.63.0 \
-    crate://crates.io/gix-refspec/0.41.0 \
-    crate://crates.io/gix-revision/0.45.0 \
-    crate://crates.io/gix-revwalk/0.31.0 \
-    crate://crates.io/gix-sec/0.14.1 \
+    crate://crates.io/gix-ref/0.65.0 \
+    crate://crates.io/gix-refspec/0.43.0 \
+    crate://crates.io/gix-revision/0.47.0 \
+    crate://crates.io/gix-revwalk/0.33.0 \
+    crate://crates.io/gix-sec/0.14.2 \
     crate://crates.io/gix-shallow/0.12.1 \
-    crate://crates.io/gix-status/0.30.0 \
-    crate://crates.io/gix-submodule/0.30.0 \
+    crate://crates.io/gix-status/0.32.0 \
+    crate://crates.io/gix-submodule/0.32.0 \
     crate://crates.io/gix-tempfile/23.0.2 \
-    crate://crates.io/gix-trace/0.1.20 \
+    crate://crates.io/gix-trace/0.1.21 \
     crate://crates.io/gix-transport/0.57.2 \
-    crate://crates.io/gix-traverse/0.57.0 \
-    crate://crates.io/gix-url/0.36.1 \
-    crate://crates.io/gix-utils/0.3.3 \
-    crate://crates.io/gix-validate/0.11.2 \
-    crate://crates.io/gix-worktree/0.52.0 \
-    crate://crates.io/gix-worktree-state/0.30.0 \
-    crate://crates.io/gix-worktree-stream/0.32.0 \
-    crate://crates.io/glob/0.3.3 \
-    crate://crates.io/globset/0.4.18 \
+    crate://crates.io/gix-traverse/0.59.0 \
+    crate://crates.io/gix-url/0.36.2 \
+    crate://crates.io/gix-utils/0.3.6 \
+    crate://crates.io/gix-validate/0.11.4 \
+    crate://crates.io/gix-worktree/0.54.0 \
+    crate://crates.io/gix-worktree-stream/0.34.0 \
+    crate://crates.io/glob/0.3.4 \
+    crate://crates.io/globset/0.4.20 \
     crate://crates.io/group/0.13.0 \
     crate://crates.io/hash32/0.3.1 \
     crate://crates.io/hashbrown/0.14.5 \
     crate://crates.io/hashbrown/0.16.1 \
     crate://crates.io/hashbrown/0.17.1 \
-    crate://crates.io/hashlink/0.11.1 \
+    crate://crates.io/hashlink/0.12.1 \
     crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
     crate://crates.io/hex/0.4.3 \
@@ -199,47 +194,46 @@ SRC_URI += " \
     crate://crates.io/hmac/0.12.1 \
     crate://crates.io/hmac/0.13.0 \
     crate://crates.io/home/0.5.12 \
-    crate://crates.io/http/1.4.2 \
+    crate://crates.io/http/1.5.0 \
     crate://crates.io/http-auth/0.1.10 \
-    crate://crates.io/hybrid-array/0.4.13 \
-    crate://crates.io/icu_collections/2.2.0 \
-    crate://crates.io/icu_locale_core/2.2.0 \
-    crate://crates.io/icu_normalizer/2.2.0 \
-    crate://crates.io/icu_normalizer_data/2.2.0 \
-    crate://crates.io/icu_properties/2.2.0 \
-    crate://crates.io/icu_properties_data/2.2.0 \
-    crate://crates.io/icu_provider/2.2.0 \
+    crate://crates.io/hybrid-array/0.4.14 \
+    crate://crates.io/icu_collections/2.3.0 \
+    crate://crates.io/icu_locale_core/2.3.0 \
+    crate://crates.io/icu_normalizer/2.3.0 \
+    crate://crates.io/icu_normalizer_data/2.3.0 \
+    crate://crates.io/icu_properties/2.3.0 \
+    crate://crates.io/icu_properties_data/2.3.0 \
+    crate://crates.io/icu_provider/2.3.1 \
     crate://crates.io/idna/1.1.0 \
     crate://crates.io/idna_adapter/1.2.2 \
-    crate://crates.io/ignore/0.4.28 \
+    crate://crates.io/ignore/0.4.33 \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/implib/0.6.0 \
     crate://crates.io/indexmap/2.14.0 \
-    crate://crates.io/io-close/0.3.7 \
     crate://crates.io/is_executable/1.0.6 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
-    crate://crates.io/itertools/0.14.0 \
     crate://crates.io/itertools/0.15.0 \
     crate://crates.io/itoa/1.0.18 \
-    crate://crates.io/jiff/0.2.32 \
-    crate://crates.io/jiff-static/0.2.32 \
+    crate://crates.io/jiff/0.2.35 \
+    crate://crates.io/jiff-core/0.1.0 \
+    crate://crates.io/jiff-static/0.2.35 \
     crate://crates.io/jiff-tzdb/0.1.8 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.35 \
-    crate://crates.io/js-sys/0.3.103 \
-    crate://crates.io/kstring/2.0.2 \
+    crate://crates.io/js-sys/0.3.104 \
+    crate://crates.io/kstring/2.0.4 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.186 \
-    crate://crates.io/libgit2-sys/0.18.5+1.9.4 \
+    crate://crates.io/libc/0.2.189 \
+    crate://crates.io/libgit2-sys/0.18.8+1.9.7 \
     crate://crates.io/libloading/0.9.0 \
     crate://crates.io/libnghttp2-sys/0.1.13+1.68.1 \
-    crate://crates.io/libsqlite3-sys/0.37.0 \
+    crate://crates.io/libsqlite3-sys/0.38.2 \
     crate://crates.io/libssh2-sys/0.3.2 \
     crate://crates.io/libz-sys/1.1.29 \
     crate://crates.io/linux-raw-sys/0.12.1 \
-    crate://crates.io/litemap/0.8.2 \
+    crate://crates.io/litemap/0.8.3 \
     crate://crates.io/lock_api/0.4.14 \
-    crate://crates.io/log/0.4.33 \
+    crate://crates.io/log/0.4.34 \
     crate://crates.io/matchers/0.2.0 \
     crate://crates.io/maybe-async/0.2.11 \
     crate://crates.io/memchr/2.8.3 \
@@ -269,8 +263,8 @@ SRC_URI += " \
     crate://crates.io/objc2-quartz-core/0.3.2 \
     crate://crates.io/objc2-ui-kit/0.3.2 \
     crate://crates.io/objc2-user-notifications/0.3.2 \
-    crate://crates.io/object/0.37.3 \
     crate://crates.io/object/0.39.1 \
+    crate://crates.io/object/0.40.0 \
     crate://crates.io/once_cell/1.21.4 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/opener/0.8.5 \
@@ -291,27 +285,27 @@ SRC_URI += " \
     crate://crates.io/percent-encoding/2.3.2 \
     crate://crates.io/pin-project-lite/0.2.17 \
     crate://crates.io/pkcs8/0.10.2 \
-    crate://crates.io/pkg-config/0.3.33 \
-    crate://crates.io/portable-atomic/1.13.1 \
+    crate://crates.io/pkg-config/0.3.34 \
+    crate://crates.io/portable-atomic/1.15.0 \
     crate://crates.io/portable-atomic-util/0.2.7 \
-    crate://crates.io/potential_utf/0.1.5 \
+    crate://crates.io/potential_utf/0.1.6 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/primeorder/0.13.6 \
-    crate://crates.io/proc-macro2/1.0.106 \
+    crate://crates.io/proc-macro2/1.0.107 \
     crate://crates.io/prodash/31.0.0 \
-    crate://crates.io/quote/1.0.46 \
+    crate://crates.io/quote/1.0.47 \
     crate://crates.io/r-efi/6.0.0 \
     crate://crates.io/rand/0.10.2 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.10.1 \
     crate://crates.io/rand_xoshiro/0.6.0 \
     crate://crates.io/redox_syscall/0.5.18 \
-    crate://crates.io/regex/1.13.0 \
-    crate://crates.io/regex-automata/0.4.15 \
+    crate://crates.io/regex/1.13.1 \
+    crate://crates.io/regex-automata/0.4.18 \
     crate://crates.io/regex-syntax/0.8.11 \
     crate://crates.io/rfc6979/0.4.0 \
     crate://crates.io/rsqlite-vfs/0.1.1 \
-    crate://crates.io/rusqlite/0.39.0 \
+    crate://crates.io/rusqlite/0.40.2 \
     crate://crates.io/rustc-hash/2.1.3 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
     crate://crates.io/rustfix/0.9.7 \
@@ -324,13 +318,13 @@ SRC_URI += " \
     crate://crates.io/security-framework/3.7.0 \
     crate://crates.io/security-framework-sys/2.17.0 \
     crate://crates.io/semver/1.0.28 \
-    crate://crates.io/serde/1.0.228 \
+    crate://crates.io/serde/1.0.229 \
     crate://crates.io/serde-untagged/0.1.9 \
     crate://crates.io/serde-value/0.7.0 \
-    crate://crates.io/serde_core/1.0.228 \
-    crate://crates.io/serde_derive/1.0.228 \
+    crate://crates.io/serde_core/1.0.229 \
+    crate://crates.io/serde_derive/1.0.229 \
     crate://crates.io/serde_ignored/0.1.14 \
-    crate://crates.io/serde_json/1.0.150 \
+    crate://crates.io/serde_json/1.0.151 \
     crate://crates.io/serde_spanned/1.1.1 \
     crate://crates.io/sha1/0.10.7 \
     crate://crates.io/sha1/0.11.0 \
@@ -342,11 +336,11 @@ SRC_URI += " \
     crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/2.0.1 \
     crate://crates.io/signature/2.2.0 \
-    crate://crates.io/simd-adler32/0.3.9 \
+    crate://crates.io/simd-adler32/0.3.10 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/slab/0.4.12 \
     crate://crates.io/smallvec/1.15.2 \
-    crate://crates.io/socket2/0.6.4 \
+    crate://crates.io/socket2/0.6.5 \
     crate://crates.io/spki/0.7.3 \
     crate://crates.io/sqlite-wasm-rs/0.5.5 \
     crate://crates.io/stable_deref_trait/1.2.1 \
@@ -355,27 +349,28 @@ SRC_URI += " \
     crate://crates.io/subtle/2.6.1 \
     crate://crates.io/supports-hyperlinks/3.2.0 \
     crate://crates.io/supports-unicode/3.0.0 \
-    crate://crates.io/syn/2.0.118 \
+    crate://crates.io/syn/2.0.119 \
+    crate://crates.io/syn/3.0.3 \
     crate://crates.io/synstructure/0.13.2 \
     crate://crates.io/tar/0.4.46 \
     crate://crates.io/tempfile/3.27.0 \
     crate://crates.io/terminal_size/0.4.4 \
-    crate://crates.io/thiserror/2.0.18 \
-    crate://crates.io/thiserror-impl/2.0.18 \
+    crate://crates.io/thiserror/2.0.20 \
+    crate://crates.io/thiserror-impl/2.0.20 \
     crate://crates.io/thread_local/1.1.10 \
-    crate://crates.io/time/0.3.53 \
+    crate://crates.io/time/0.3.55 \
     crate://crates.io/time-core/0.1.9 \
-    crate://crates.io/time-macros/0.2.31 \
-    crate://crates.io/tinystr/0.8.3 \
+    crate://crates.io/time-macros/0.2.32 \
+    crate://crates.io/tinystr/0.8.4 \
     crate://crates.io/tinyvec/1.12.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
     crate://crates.io/toml/0.9.12+spec-1.1.0 \
-    crate://crates.io/toml/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml/1.1.4+spec-1.1.0 \
     crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
     crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
-    crate://crates.io/toml_edit/0.25.12+spec-1.1.0 \
-    crate://crates.io/toml_parser/1.1.2+spec-1.1.0 \
-    crate://crates.io/toml_writer/1.1.1+spec-1.1.0 \
+    crate://crates.io/toml_edit/0.25.13+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
     crate://crates.io/tracing/0.1.44 \
     crate://crates.io/tracing-attributes/0.1.31 \
     crate://crates.io/tracing-chrome/0.7.2 \
@@ -397,82 +392,79 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.126 \
-    crate://crates.io/wasm-bindgen-macro/0.2.126 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.126 \
-    crate://crates.io/wasm-bindgen-shared/0.2.126 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/wasm-bindgen/0.2.127 \
+    crate://crates.io/wasm-bindgen-macro/0.2.127 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.127 \
+    crate://crates.io/wasm-bindgen-shared/0.2.127 \
     crate://crates.io/winapi-util/0.1.11 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
     crate://crates.io/windows-link/0.2.1 \
     crate://crates.io/windows-sys/0.61.2 \
     crate://crates.io/winnow/0.7.15 \
-    crate://crates.io/winnow/1.0.3 \
-    crate://crates.io/writeable/0.6.3 \
+    crate://crates.io/winnow/1.0.4 \
+    crate://crates.io/writeable/0.6.4 \
     crate://crates.io/yoke/0.8.3 \
     crate://crates.io/yoke-derive/0.8.2 \
     crate://crates.io/zerofrom/0.1.8 \
     crate://crates.io/zerofrom-derive/0.1.7 \
     crate://crates.io/zeroize/1.9.0 \
-    crate://crates.io/zerotrie/0.2.4 \
-    crate://crates.io/zerovec/0.11.6 \
-    crate://crates.io/zerovec-derive/0.11.3 \
-    crate://crates.io/zlib-rs/0.6.6 \
-    crate://crates.io/zmij/1.0.21 \
+    crate://crates.io/zerotrie/0.2.5 \
+    crate://crates.io/zerovec/0.11.8 \
+    crate://crates.io/zerovec-derive/0.11.6 \
+    crate://crates.io/zlib-rs/0.6.7 \
+    crate://crates.io/zmij/1.0.23 \
 "
+
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
-SRC_URI[aho-corasick-1.1.4.sha256sum] = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
+SRC_URI[aho-corasick-1.1.5.sha256sum] = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
-SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[android_system_properties-0.1.6.sha256sum] = "ae221649c9976a6f6c56ae1facf410f3ddb33cc661c4b7b61020a912d4237fbc"
 SRC_URI[annotate-snippets-0.12.16.sha256sum] = "f211a51805bc641f3ad5b7664c77d2547af685cc33b4cd8d31964027a46f13f1"
 SRC_URI[anstream-1.0.0.sha256sum] = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
 SRC_URI[anstyle-1.0.14.sha256sum] = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
 SRC_URI[anstyle-hyperlink-1.0.2.sha256sum] = "7a14cad0fa1d1fb02de486a95ea7fd8dd28567b82f65b4ca34bffa7da81823e4"
 SRC_URI[anstyle-parse-1.0.0.sha256sum] = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
-SRC_URI[anstyle-progress-0.1.0.sha256sum] = "ee65f3323c89eac2de51015f125682e9a88c3bf7a10d0c39b3768ff6af654ff7"
+SRC_URI[anstyle-progress-0.1.4.sha256sum] = "082ebe8b7607a68881fbcccc7b3a3e784aa58593ed4261df0679a803fdb80853"
 SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
-SRC_URI[anyhow-1.0.103.sha256sum] = "2a4385e2e34eb35d6b3efe798b9eb88096925d87726c0798709bf56d9ed84af3"
-SRC_URI[ar_archive_writer-0.5.2.sha256sum] = "4087686b4b0a3427190bae57a1d9a478dbb2d40c5dc1bd6e2b6d797913bdd348"
+SRC_URI[anyhow-1.0.104.sha256sum] = "330a5ed07fa54e4702c9d6c4174f74427fc0ef6e214bbd677ae50a5099946470"
+SRC_URI[ar_archive_writer-0.5.3.sha256sum] = "73cd58deff2140a0a8eae87e417bd01db68a33e148aa93d1e8cd837e55e312b6"
 SRC_URI[arc-swap-1.9.2.sha256sum] = "c049c0be4daef0b145cb3555416b3b8ef5b7888a38aea1a3a155801fe7b0810b"
-SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
 SRC_URI[arrayvec-0.7.8.sha256sum] = "d3fb67a6e08acf24fdeccbac2cb6ac4305825bd1f117462e0e6f2f193345ad56"
-SRC_URI[async-trait-0.1.89.sha256sum] = "9035ad2d096bed7955a320ee7e2230574d28fd3c3a0f186cbea1ff3c7eed5dbb"
+SRC_URI[async-trait-0.1.92.sha256sum] = "82f6aeea286b8eb4dd3431a1be1b59d290ace00f5bfd8e2a159bc2a05e2c1667"
 SRC_URI[autocfg-1.5.1.sha256sum] = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
 SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.13.0.sha256sum] = "b4388bee8683e3d04af747c73422af53102d2bd24d9eadb6cbc100baef4b43f8"
+SRC_URI[bitflags-2.13.1.sha256sum] = "b588b76d00fde79687d7646a9b5bdf3cc0f655e0bbd080335a95d7e96f3587da"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
-SRC_URI[blake3-1.8.5.sha256sum] = "0aa83c34e62843d924f905e0f5c866eb1dd6545fc4d719e803d9ba6030371fce"
+SRC_URI[blake3-1.8.7.sha256sum] = "6d9e454fc11f76977dc803893aff6304ed33d6a26efae8696573bea74baa27ae"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[block-buffer-0.12.1.sha256sum] = "d2f6c7dbe95a6ed67ad9f18e57daf93a2f034c524b99fd2b76d18fdfeb6660aa"
 SRC_URI[block2-0.6.2.sha256sum] = "cdeb9d870516001442e364c5220d3574d2da8dc765554b4a617230d33fa58ef5"
-SRC_URI[bstr-1.12.3.sha256sum] = "5cee35f73844aa3014bb606320a6c1f010249dbdf43342fe54b5a4f6a8ed4b79"
+SRC_URI[bstr-1.13.1.sha256sum] = "6bb31b46c14244e20ee9984b11bf5c992b91fb6939fea616e3512c8baecdbe5f"
 SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.12.1.sha256sum] = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
-SRC_URI[camino-1.2.4.sha256sum] = "5f2d30e4173c4026932d51d31d6b0613b1fd3014bf3f9f8943d4ba139c437ba0"
-SRC_URI[cargo-0.98.0.sha256sum] = "7bcc52d107e10f9695543bbdc9128c7798abafdd36c6ba5adfb35e0abe87bf6e"
+SRC_URI[camino-1.2.5.sha256sum] = "bb1307f12aa967b5a58416e87b3653360e0fd614a016b6e970db08fecbb1b80d"
+SRC_URI[cargo-0.99.0.sha256sum] = "0c30a0d29369c04a80056b22089ad95f28c3df596821f1f8672d44ef64b7e26a"
 SRC_URI[cargo-credential-0.4.10.sha256sum] = "aa57675b822ecda7f0be12eedbfabd890066271eedc7f2c45ed41e86e0f327a8"
-SRC_URI[cargo-credential-libsecret-0.5.8.sha256sum] = "2e4e04c7a5534329dcdb4c7cefc6c22b0b1206d72f868efdbfff449f44fef6ca"
-SRC_URI[cargo-credential-macos-keychain-0.4.23.sha256sum] = "0601abc232268abe2620ec2843ac642fd34bd8890ee85d3d46dc7d5a4c50d304"
-SRC_URI[cargo-credential-wincred-0.4.23.sha256sum] = "98217a0c25db10c0825228cd6dbe009742c2e524f3dd135b5abd988d6960e25a"
+SRC_URI[cargo-credential-libsecret-0.5.9.sha256sum] = "05e5f16a4f9f863e65e5c8b09a0b72d7ffe2b2c17eec4f7ea480360ddc4f61ca"
+SRC_URI[cargo-credential-macos-keychain-0.4.24.sha256sum] = "06f5b56bc59e9f3fe2a0450cd379057c8a327662c1d04ccecab61cd79818325e"
+SRC_URI[cargo-credential-wincred-0.4.24.sha256sum] = "25c2de3e8263008f298c44371abc403c08742df04c88230a66e781a11d2110fc"
 SRC_URI[cargo-platform-0.3.3.sha256sum] = "dd0061da739915fae12ea00e16397555ed4371a6bb285431aab930f61b0aa4ba"
-SRC_URI[cargo-util-0.2.30.sha256sum] = "5d7123d293f652da25899a771e48756075710465b2eedb0fc35aa3b368e9cf5c"
-SRC_URI[cargo-util-schemas-0.14.1.sha256sum] = "455abfe7d7f58e523ea3998c2dd5bc71f315df661eac2bba3dd1653401218894"
-SRC_URI[cargo-util-terminal-0.1.0.sha256sum] = "5baff8199ae90b871b3383da1b2bfd1a9f003f0b043c9278550d220a66c99a5b"
+SRC_URI[cargo-util-0.2.31.sha256sum] = "218d28c233cdb23a98404ae6d6f8eea19db3c3ab28c34633c7d9facf72f2d2ff"
+SRC_URI[cargo-util-schemas-0.14.2.sha256sum] = "46262ca4393669799a8df4852e81672ddea46657e73294b1a846f0d5c71509ed"
+SRC_URI[cargo-util-terminal-0.1.1.sha256sum] = "db1548e157f51e667fdf147e5c55ee09a713cab10345293b1009f8de9af4974b"
 SRC_URI[cbindgen-0.29.4.sha256sum] = "2ecb53484c9c167ba674026b656d8a27d7657a58e6066aa902bfb1a4aa00ae20"
-SRC_URI[cc-1.2.66.sha256sum] = "f5d6cac793997bd970000024b2934968efe83b382de4fdcf4fcb46b6ee4ad996"
+SRC_URI[cc-1.4.4.sha256sum] = "0ad534f4357a5264cce5019c989cf66a4f0dc4e0d1b1d15f8aacec0ff7360273"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[cfg_aliases-0.2.1.sha256sum] = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
+SRC_URI[cfg_aliases-0.2.2.sha256sum] = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
 SRC_URI[chacha20-0.10.1.sha256sum] = "d524456ba66e72eb8b115ff89e01e497f8e6d11d78b70b1aa13c0fbd97540a81"
-SRC_URI[clap-4.6.1.sha256sum] = "1ddb117e43bbf7dacf0a4190fef4d345b9bad68dfc649cb349e7d17d28428e51"
-SRC_URI[clap_builder-4.6.0.sha256sum] = "714a53001bf66416adb0e2ef5ac857140e7dc3a0c48fb28b2f10762fc4b5069f"
-SRC_URI[clap_complete-4.6.7.sha256sum] = "db8b397918185f0161ff3d6fcaa9e4bfc09b8367caf6e1d4a2848e5477ed027b"
-SRC_URI[clap_derive-4.6.1.sha256sum] = "f2ce8604710f6733aa641a2b3731eaa1e8b3d9973d5e3565da11800813f997a9"
+SRC_URI[clap-4.6.6.sha256sum] = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
+SRC_URI[clap_builder-4.6.6.sha256sum] = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
+SRC_URI[clap_complete-4.6.9.sha256sum] = "3be2ad0423bdbbb0e25bc89add796f3559706d4a95e1bc98e4d9662a957b6a19"
+SRC_URI[clap_derive-4.6.4.sha256sum] = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
 SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
 SRC_URI[clru-0.6.3.sha256sum] = "197fd99cb113a8d5d9b6376f3aa817f32c1078f2343b714fff7d2ca44fdf67d5"
 SRC_URI[cmov-0.5.4.sha256sum] = "0c9ea0ac24bc397ab3c98583a3c9ba74fa56b09a4449bbe172b9b1ddb016027a"
@@ -486,8 +478,8 @@ SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7f
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
 SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
-SRC_URI[crates-io-0.41.0.sha256sum] = "55754653d4ac92d6ed1d01970872e0c9803c4eecc916095e19b862d67625b987"
-SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
+SRC_URI[crates-io-0.41.1.sha256sum] = "61eac17e797075f82dc4f2ca6c2b807abcb7f2b101f1fd1f627c5f1cde27b0d5"
+SRC_URI[crc32fast-1.5.1.sha256sum] = "8498c871161e1742aaa9d52551b2d6ebdd4c3d45a3be423e3728f33b955be550"
 SRC_URI[crossbeam-channel-0.5.16.sha256sum] = "d85363c37faeca707aef026efa9f3b34d077bce547e48f770770625c6013679e"
 SRC_URI[crossbeam-deque-0.8.7.sha256sum] = "5181e0de7b61eb03a81e347d6dd8797bae9da5146707b51077e2d71a54ec0ceb"
 SRC_URI[crossbeam-epoch-0.9.20.sha256sum] = "2d6914041f254d6e9176c01941b21115dcfb7089e55135a35411081bd106ef3f"
@@ -508,11 +500,11 @@ SRC_URI[deranged-0.5.8.sha256sum] = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c
 SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
 SRC_URI[digest-0.11.3.sha256sum] = "f1dd6dbb5841937940781866fa1281a1ff7bd3bf827091440879f9994983d5c2"
 SRC_URI[dispatch2-0.3.1.sha256sum] = "1e0e367e4e7da84520dedcac1901e4da967309406d1e51017ae1abfb97adbd38"
-SRC_URI[displaydoc-0.2.6.sha256sum] = "1ac70aa55017e108007fbaf5aa0f54b021c98f92ff8af59d42eda9da96e3dd4f"
+SRC_URI[displaydoc-0.2.7.sha256sum] = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308ccd87b1c098f1fb2eaf82a8"
 SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
 SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
-SRC_URI[ed25519-compact-2.3.1.sha256sum] = "5c24599140dc39d7a81e4476e7573d41bbc18e07c803900298e522a5fbcfbfb6"
-SRC_URI[either-1.16.0.sha256sum] = "91622ff5e7162018101f2fea40d6ebf4a78bbe5a49736a2020649edf9693679e"
+SRC_URI[ed25519-compact-2.4.2.sha256sum] = "f05391a505666bdf2b5d2626f41b7f0f49052b1e33cceac960eaa818008141da"
+SRC_URI[either-1.18.0.sha256sum] = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
 SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
 SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
@@ -521,96 +513,92 @@ SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
 SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
-SRC_URI[fastrand-2.4.1.sha256sum] = "9f1f227452a390804cdb637b74a86990f2a7d7ba4b7d5693aac9b4dd6defd8d6"
+SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
 SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
 SRC_URI[filetime-0.2.29.sha256sum] = "5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
-SRC_URI[find-msvc-tools-0.1.9.sha256sum] = "5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582"
+SRC_URI[find-msvc-tools-0.1.11.sha256sum] = "d45db016d36b838f563236e9193d0ee6ce38f3f68b6c94e914b4929c96bbb890"
 SRC_URI[flate2-1.1.9.sha256sum] = "843fba2746e448b37e26a819579957415c8cef339bf08564fe8b7ddbd959573c"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[foldhash-0.2.0.sha256sum] = "77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
 SRC_URI[foreign-types-shared-0.1.1.sha256sum] = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
 SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
-SRC_URI[futures-0.3.32.sha256sum] = "8b147ee9d1f6d097cef9ce628cd2ee62288d963e16fb287bd9286455b241382d"
-SRC_URI[futures-channel-0.3.32.sha256sum] = "07bbe89c50d7a535e539b8c17bc0b49bdb77747034daa8087407d655f3f7cc1d"
-SRC_URI[futures-core-0.3.32.sha256sum] = "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
-SRC_URI[futures-executor-0.3.32.sha256sum] = "baf29c38818342a3b26b5b923639e7b1f4a61fc5e76102d4b1981c6dc7a7579d"
-SRC_URI[futures-io-0.3.32.sha256sum] = "cecba35d7ad927e23624b22ad55235f2239cfa44fd10428eecbeba6d6a717718"
-SRC_URI[futures-macro-0.3.32.sha256sum] = "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b"
-SRC_URI[futures-sink-0.3.32.sha256sum] = "c39754e157331b013978ec91992bde1ac089843443c49cbc7f46150b0fad0893"
-SRC_URI[futures-task-0.3.32.sha256sum] = "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
+SRC_URI[futures-0.3.34.sha256sum] = "9a31d2a3fbaaeb2af2368bbdd904aa8e812d3c04a1ee10d3171f52d556e5d0a3"
+SRC_URI[futures-channel-0.3.34.sha256sum] = "b1f9e3d69d39e4862ffed03ed071a76f9a13ba1d9109d355b0f0aa6b15e393c4"
+SRC_URI[futures-core-0.3.34.sha256sum] = "92d699e522242e69e3003b94ecc1f960f3a5e015aa7c5d7486e65ad01dd94f5e"
+SRC_URI[futures-executor-0.3.34.sha256sum] = "031b47cf1a3c6cc8bc2fc76cd437f521619387907d469316e7c0bc278f1f5432"
+SRC_URI[futures-io-0.3.34.sha256sum] = "53c0fa8157de1303bfffdaa1cc2a673bfffb60102f76b0ef4441659124373fed"
+SRC_URI[futures-macro-0.3.34.sha256sum] = "9fb9654ba8355388abeb8dcb4fc62f511300867002afc858860463bdd9fe0c44"
+SRC_URI[futures-sink-0.3.34.sha256sum] = "1944426bf7d03f1d14f708785e4b33efd750b36d48a157b836b3efc15ede8e1d"
+SRC_URI[futures-task-0.3.34.sha256sum] = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
 SRC_URI[futures-timer-3.0.4.sha256sum] = "af43fadb8a98512d547e37b4e92e0ced13e205c061b87b4623eff01d918d6968"
-SRC_URI[futures-util-0.3.32.sha256sum] = "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
+SRC_URI[futures-util-0.3.34.sha256sum] = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
 SRC_URI[generic-array-0.14.9.sha256sum] = "4bb6743198531e02858aeaea5398fcc883e71851fcbcb5a2f773e2fb6cb1edf2"
 SRC_URI[getrandom-0.2.17.sha256sum] = "ff2abc00be7fca6ebc474524697ae276ad847ad0a6b3faa4bcb027e9a4614ad0"
 SRC_URI[getrandom-0.4.3.sha256sum] = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
-SRC_URI[git2-0.20.4.sha256sum] = "7b88256088d75a56f8ecfa070513a775dd9107f6530ef14919dac831af9cfe2b"
-SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
-SRC_URI[gix-0.83.0.sha256sum] = "6ce52001b946a6249d5d0d3011df0a042ac3f8a4d013460db6476577b0b9c567"
-SRC_URI[gix-actor-0.41.1.sha256sum] = "8bc998b8f746dda8565450d08a63b792ced9165d8c27a1ed3f02799ec6a7820f"
-SRC_URI[gix-archive-0.32.0.sha256sum] = "9a20ec244b733338d4cb60e5e05eac700dab7fcc689647b1d1daa9396b119342"
+SRC_URI[git2-0.21.0.sha256sum] = "ddddbf932745a6be37109b6112d3ee09696106f848449069d3a57bba937ab82e"
+SRC_URI[git2-curl-0.22.0.sha256sum] = "1f1f6fe01327a2f7a1d6ee519c14651f79530aa4d64e870f4cf672efe697bea5"
+SRC_URI[gix-0.85.0.sha256sum] = "fa8b2e38ebfc4484dfef8580ddcaf8abb7285e6f3eb6413ff6775d104ae96ca6"
+SRC_URI[gix-actor-0.41.2.sha256sum] = "33f9308ad6fd35b2a865cbe4117ac61b2be59e4a9ef1621c7a9794f7c8e52c5b"
 SRC_URI[gix-attributes-0.33.2.sha256sum] = "39b40888d0ed415c0744a6cdc61eebf0304c9d26ab726725b718443c322e5ba4"
-SRC_URI[gix-bitmap-0.3.2.sha256sum] = "52ebef0c26ad305747649e727bbcd56a7b7910754eb7cea88f6dff6f93c51283"
-SRC_URI[gix-blame-0.13.0.sha256sum] = "14dab9a942ab54a9661ded7397c3bf927274e7afa94494db0d75cfcbde02ca0a"
-SRC_URI[gix-chunk-0.7.2.sha256sum] = "9faee47943b638e58ddd5e275a4906ad3e4b6c8584f1d41bd18ab9032ec52afb"
-SRC_URI[gix-command-0.9.1.sha256sum] = "00706d4fef135ef4b01680d5218c6ee40cda8baf697b864296cbc887d19118f6"
+SRC_URI[gix-bitmap-0.3.3.sha256sum] = "7cd1d118d0f5d88b96e6f6e13b566475fef4797ead4a02c26fed36c1375066f7"
+SRC_URI[gix-chunk-0.7.3.sha256sum] = "b2a871e5cab12ba568845714473505deefffb3c04eb47f4708ce344cd459c1cc"
+SRC_URI[gix-command-0.9.2.sha256sum] = "cf4363accdf6ef7ba861871d2d521ab7418a04aaaed919fadb022af71d379b12"
 SRC_URI[gix-commitgraph-0.37.1.sha256sum] = "7f675d0df484a7f6a47e64bd6f311af489d947c0323b0564f36d14f3d7762abb"
-SRC_URI[gix-config-0.56.0.sha256sum] = "8c01848aebd21c67f6ba41f1de8efd46ae96df21f001954a3c9e1517e514d410"
+SRC_URI[gix-config-0.58.0.sha256sum] = "a29bf266c4cdaf759e535c24ad4ce655b987aeb6911075643403cc7cc5ade583"
 SRC_URI[gix-config-value-0.18.1.sha256sum] = "ed42168329552f6c2e5df09665c104199d45d84bedb53683738a49b57fe1baab"
-SRC_URI[gix-credentials-0.38.1.sha256sum] = "f40cd22f0dd71988be12d6e78b1709de2370e1957c5f107ff31e56caeba3745d"
-SRC_URI[gix-date-0.15.5.sha256sum] = "3d63f9e28b59ddeb1a1eb9e5cf986a9222b5d484947445edbc20473939cc7fd0"
-SRC_URI[gix-diff-0.63.0.sha256sum] = "dc08e0fa1a91ff5f24affeab052f198056645e1de004910bde7b82b50ea5982a"
-SRC_URI[gix-dir-0.25.0.sha256sum] = "32a0fc06e9e1e430cbf0a313666976d90f822f461a6525320427aa9b8af5236c"
-SRC_URI[gix-discover-0.51.0.sha256sum] = "17852e6a501e688a1702b24ebe5b3761d4719455bc869fd29f38b0b859bcad34"
-SRC_URI[gix-error-0.2.4.sha256sum] = "e57831e199be480af90dcd7e459abed8a174c09ec9a6e2cc8f7ca6c54598b06b"
+SRC_URI[gix-credentials-0.38.2.sha256sum] = "e8a0fcfcd73229d1a9c34e04edd05dbcb80364ec6f3788d24c546de2916671eb"
+SRC_URI[gix-date-0.15.6.sha256sum] = "7e47b9e8cdc688296609b706428de570f88b1e0eed7156dde7b4a89d26fa4567"
+SRC_URI[gix-diff-0.65.0.sha256sum] = "92c6d56c94edf92d78203a1cd416f770e35e10b6955ede6b9d7d0c22ff88a5f3"
+SRC_URI[gix-dir-0.27.0.sha256sum] = "20098fba2b9c6e29361ccb4c0379d42dfb81fc7f86f7ab11f2dff4528c0bf01f"
+SRC_URI[gix-discover-0.53.0.sha256sum] = "d624d5b23b10c1d85337645227abe353ac95ab8ff66a7bdd5ce689b2db33a722"
+SRC_URI[gix-error-0.2.5.sha256sum] = "4a9292309fd944e71b2a3c96d3c03a6feb8852db646febdde7cbb9f79cb5f329"
 SRC_URI[gix-features-0.48.1.sha256sum] = "1849ae154d38bc403185be14fa871e38e3c93ee606875d94e207fdb9fba52dbc"
-SRC_URI[gix-filter-0.30.0.sha256sum] = "dac917dbe9653c9b615d248db91907a365bd779750c9e1b457a9d9fdeece3a08"
+SRC_URI[gix-filter-0.32.0.sha256sum] = "6644fb2ef97928c278675b239f366b457103d7e436f811d27331a8daf212759c"
 SRC_URI[gix-fs-0.21.2.sha256sum] = "6cdff46db8798e47e2f727d84b9379aac5add3dd3d9d0b07bb4d7d5d640771fe"
 SRC_URI[gix-glob-0.26.1.sha256sum] = "d1fcb8ef5b16bcf874abe9b68d8abb3c0493c876d367ab824151f30a0f3f3756"
 SRC_URI[gix-hash-0.25.1.sha256sum] = "cb0926d3819c837750b4e03c7754901e73f68b8c9b690753a6372a1bed4eedce"
 SRC_URI[gix-hashtable-0.15.2.sha256sum] = "7e261d54091f0d1c729bc83f54548c071bdec60a697de1e58e88bdfd7a99d24e"
 SRC_URI[gix-ignore-0.21.1.sha256sum] = "d491bab9bf2c9f341dc754f425c31d5d3f63aca615312167b82e1deeaca97d8d"
-SRC_URI[gix-imara-diff-0.2.3.sha256sum] = "b305d85504de270ad3525d726a6b69cc59ee7b2269b014387651107ab9f0755b"
-SRC_URI[gix-index-0.51.0.sha256sum] = "54c3ef97ad08121e4327a6226bd63fed6b9e3c6b976d48bddd4356d9d41191db"
+SRC_URI[gix-imara-diff-0.2.5.sha256sum] = "1c91d8cffac8849493a82233811bd02b2b183b8cf39bf704de0fa0841b737595"
+SRC_URI[gix-index-0.53.0.sha256sum] = "36d45f82ec5a4d7542ea595e9ad16e03e26c8cb4f221e5bc9fcdcf469f63a681"
 SRC_URI[gix-lock-23.0.1.sha256sum] = "65c9dedd9e90b0d47624d2ed241d394e09294118364e87b9b7e5f1fe755f3c2c"
-SRC_URI[gix-merge-0.16.0.sha256sum] = "74bbcdcc52b70a32f0a151b024dff9d0fcf56ee48f00d9503e735af9d99ea881"
-SRC_URI[gix-negotiate-0.31.0.sha256sum] = "103d42bfade1b8a96ca5005933127bdad461ce588d92422b2c2daa3ff20d780c"
-SRC_URI[gix-object-0.60.0.sha256sum] = "a38075a95d7cc5df8afd38e72c617026c1456952207a4120a7f55a3fbf93b4d7"
-SRC_URI[gix-odb-0.80.0.sha256sum] = "aeeda12a9663120418735ecdc1250d06eeab0be75700e47b3402a981331716ba"
-SRC_URI[gix-pack-0.70.0.sha256sum] = "daf02e6f5c8f07a069c9ea5245f40d9b14856ada4086091dc99941b49002b4fa"
+SRC_URI[gix-negotiate-0.33.0.sha256sum] = "63d6081882a5f575ace9f53924a7c85f69bbd0f96071b982df12f258ab338cc9"
+SRC_URI[gix-object-0.62.0.sha256sum] = "019b38afc3eac1e41f9fe09a327664b313ba4a120fa5f40e3678795d0e42783e"
+SRC_URI[gix-odb-0.82.0.sha256sum] = "7fadc59f6fa0f9dd445eceee61060a2b59ca557f48da9fc677f567db535b782a"
+SRC_URI[gix-pack-0.72.0.sha256sum] = "ca3e7f1726cd2c0cd1cf1fc20be8a8e623f0b163f1f8d6fc836cfb9bc8cd758b"
 SRC_URI[gix-packetline-0.21.5.sha256sum] = "b217dd0ee0c4021ecf169a4a519b1b4f80d15e3f3765f3dc466223dc0ac891d7"
-SRC_URI[gix-path-0.12.1.sha256sum] = "afa6ac14cd14939ea94a496ce7460daa6511c09f5b84757e9cfc6f9c8d0f93a6"
+SRC_URI[gix-path-0.12.5.sha256sum] = "2b075e730586bba7341304d6fc1b4efc1d10cf64532622521c0e07f30e661046"
 SRC_URI[gix-pathspec-0.18.1.sha256sum] = "3050783b41ee11511e1e8fb35623df81806194f4030395f14f48ea37c2798c9f"
 SRC_URI[gix-prompt-0.15.1.sha256sum] = "3ee604d7746080ae7e1023bf47204bcc2c5f307bfbe2306a3c90b1bfd1a2c6d8"
-SRC_URI[gix-protocol-0.61.0.sha256sum] = "aa4bee82db63ec635996b96efae71cf467c155fa3f34a556184373224a26c4fd"
+SRC_URI[gix-protocol-0.63.0.sha256sum] = "978468bae4ea2df20c72db3b20d0bdb548a0c1090b85a83643b553e6e0e041f2"
 SRC_URI[gix-quote-0.7.2.sha256sum] = "a6e541fc33cc2b783b7979040d445a0c86a2eca747c8faea4ca84230d06ae6ef"
-SRC_URI[gix-ref-0.63.0.sha256sum] = "d8ba9cc15f558b274c99349b83130f5ec83459660828fde9718bbbb43a726167"
-SRC_URI[gix-refspec-0.41.0.sha256sum] = "61755b27d57edc8940a1b1593c8c61548ca8e4c02da1ed8d5bfeda9eb2a6b761"
-SRC_URI[gix-revision-0.45.0.sha256sum] = "1fb5288fac706d3ea3e4e2ba9ec38b78743b8c02f422e18cb342299cfd6ab7e8"
-SRC_URI[gix-revwalk-0.31.0.sha256sum] = "313813706b073a12ff7f9b2896bf3e6504cdac7cfbc97b1920114724705069f0"
-SRC_URI[gix-sec-0.14.1.sha256sum] = "ab8519976e4c7e486270740a5400369f37940779b80bd1377d94cfa1125d01b3"
+SRC_URI[gix-ref-0.65.0.sha256sum] = "9bbfbce1dfd7d7f8469ddef6d3518376aff664348f153cbe0fc3e58ef993d24e"
+SRC_URI[gix-refspec-0.43.0.sha256sum] = "7bc36a4fb1a1540b59cf2da498783080743fa274b02a3f19ca444fc4015a9d4f"
+SRC_URI[gix-revision-0.47.0.sha256sum] = "885075c3c21eb9c06e0be3b3728ba5932c04e1c1011dcee7c81801980e3e986f"
+SRC_URI[gix-revwalk-0.33.0.sha256sum] = "8f11fe7ca2585193d3d70bbe0be175a2008d883a704cc7a55e454e113e689455"
+SRC_URI[gix-sec-0.14.2.sha256sum] = "af4fe6c152c1d50aea36f299825702cd37e303307832fec1d0fdd5844e47ce2f"
 SRC_URI[gix-shallow-0.12.1.sha256sum] = "a292fc2fe548c5dfa575479d16b445b0ddf1dd2f56f1fec6aed386f82553cd97"
-SRC_URI[gix-status-0.30.0.sha256sum] = "68c6d2a8c521ffa205fe7e268c82e6d1378ba37cd826ca10ab6129fdc29a4b65"
-SRC_URI[gix-submodule-0.30.0.sha256sum] = "9fd5fc8692890bd71a596e540fd4c364f8460eaa82c4eaaedebde6e1e3eb4d91"
+SRC_URI[gix-status-0.32.0.sha256sum] = "aec3293f75db1212f99217832cbc70c30faeb95cefc97c7f1a17fd3bcf13a72e"
+SRC_URI[gix-submodule-0.32.0.sha256sum] = "a7f9f594f7cbda0b38ba6b633b3e9a7b7901acdc5d27bc186a16633800cd1ac8"
 SRC_URI[gix-tempfile-23.0.2.sha256sum] = "6ef60812443484e67bf84e444cc71b4c78ae62deb822221774a4fa0c57fdb17f"
-SRC_URI[gix-trace-0.1.20.sha256sum] = "44dc45eae785c0eb14173e0f152e6e224dcf4d45b6a6999a3aed22af541ad678"
+SRC_URI[gix-trace-0.1.21.sha256sum] = "be3eb81d9dc914335923e50d52829c551feefd6a72d176c4130c546b67a60814"
 SRC_URI[gix-transport-0.57.2.sha256sum] = "186874f7ad1fb2f9a2f2aa9c2dabc7f9dd087bef74c1a0eee2b4a9cf0248fcb3"
-SRC_URI[gix-traverse-0.57.0.sha256sum] = "a14b7052c0786676c03e71fcfde7d7f0f8e8316e642b5cec6bb3998719b2ce5c"
-SRC_URI[gix-url-0.36.1.sha256sum] = "65bb01ec69d55e82ccb7a19e264501ead4e6aac38463a8cebfdd81e22bb67ab2"
-SRC_URI[gix-utils-0.3.3.sha256sum] = "66c50966184123caf580ffa64e28031a878597f1c7fceb8fe19566c38eb1b771"
-SRC_URI[gix-validate-0.11.2.sha256sum] = "7bc6fc771c4063ba7cd2f47b91fb6076251c6a823b64b7fe7b8874b0fe4afae3"
-SRC_URI[gix-worktree-0.52.0.sha256sum] = "d69955eb5e2910832f88d041964b809eee01dadd579237e0b55efec58fd406fd"
-SRC_URI[gix-worktree-state-0.30.0.sha256sum] = "8a96dccbcf9e8fe0291c55f06e08da93ebb2e691c1311276f541eefcc6d70800"
-SRC_URI[gix-worktree-stream-0.32.0.sha256sum] = "9a8444b8ed4662e1a0c97f3eceda29630001a1bbb2632201e50312623e594213"
-SRC_URI[glob-0.3.3.sha256sum] = "0cc23270f6e1808e30a928bdc84dea0b9b4136a8bc82338574f23baf47bbd280"
-SRC_URI[globset-0.4.18.sha256sum] = "52dfc19153a48bde0cbd630453615c8151bce3a5adfac7a0aebfbf0a1e1f57e3"
+SRC_URI[gix-traverse-0.59.0.sha256sum] = "5062cca8f2977565bbaf666ec31dbdb9bc9d9293beb65f9bec52e6c1121b62a1"
+SRC_URI[gix-url-0.36.2.sha256sum] = "57d68e70e96da0e5f9c871f1566349e0fd0e1a20bb483c7f54af1dd0b85b4b29"
+SRC_URI[gix-utils-0.3.6.sha256sum] = "0da1c46491b49458a446cc76f0085860f8164c2290742e0aa8c653ce67240a97"
+SRC_URI[gix-validate-0.11.4.sha256sum] = "4dae8780f63ed8a803b8bdabbd7aa5f5c5d74592c8b50eed875c1bb4f6545a6a"
+SRC_URI[gix-worktree-0.54.0.sha256sum] = "92399ed66f259592050c6ed9dc80105e095a2f8e87e6b83d98aa2e21d8e27036"
+SRC_URI[gix-worktree-stream-0.34.0.sha256sum] = "55f3a878c89a05470ad98c644b0015777c530da24854dd29e41fe4f41176840f"
+SRC_URI[glob-0.3.4.sha256sum] = "e4eba85ea1d0a966a983acd07deee566e67395d2d96b6fb39e62b5a833f1eb0b"
+SRC_URI[globset-0.4.20.sha256sum] = "07c34a9410465b45bd9787443bc7370f37735bad04b0f0cd57ff1a3186c98988"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
 SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e902d4df49588d1470606"
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
 SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
 SRC_URI[hashbrown-0.17.1.sha256sum] = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
-SRC_URI[hashlink-0.11.1.sha256sum] = "824e001ac4f3012dd16a264bec811403a67ca9deb6c102fc5049b32c4574b35f"
+SRC_URI[hashlink-0.12.1.sha256sum] = "32069d97bb81e38fa67eab65e3393bf804bb85969f2bc06bf13f64aef5aba248"
 SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
@@ -618,47 +606,46 @@ SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a382
 SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
 SRC_URI[hmac-0.13.0.sha256sum] = "6303bc9732ae41b04cb554b844a762b4115a61bfaa81e3e83050991eeb56863f"
 SRC_URI[home-0.5.12.sha256sum] = "cc627f471c528ff0c4a49e1d5e60450c8f6461dd6d10ba9dcd3a61d3dff7728d"
-SRC_URI[http-1.4.2.sha256sum] = "6970f50e31d6fc17d3fa27329444bfa74e196cf62e95052a3f6fee181dba6425"
+SRC_URI[http-1.5.0.sha256sum] = "918d3568bebf352712bc2ef3d46a8bcf1a75b373be6539de198e9105cbbf9ce0"
 SRC_URI[http-auth-0.1.10.sha256sum] = "150fa4a9462ef926824cf4519c84ed652ca8f4fbae34cb8af045b5cbcaf98822"
-SRC_URI[hybrid-array-0.4.13.sha256sum] = "818356c5132c1fede50f837ca96afbe78ff42413047f4abb886217845e1b6c8c"
-SRC_URI[icu_collections-2.2.0.sha256sum] = "2984d1cd16c883d7935b9e07e44071dca8d917fd52ecc02c04d5fa0b5a3f191c"
-SRC_URI[icu_locale_core-2.2.0.sha256sum] = "92219b62b3e2b4d88ac5119f8904c10f8f61bf7e95b640d25ba3075e6cac2c29"
-SRC_URI[icu_normalizer-2.2.0.sha256sum] = "c56e5ee99d6e3d33bd91c5d85458b6005a22140021cc324cea84dd0e72cff3b4"
-SRC_URI[icu_normalizer_data-2.2.0.sha256sum] = "da3be0ae77ea334f4da67c12f149704f19f81d1adf7c51cf482943e84a2bad38"
-SRC_URI[icu_properties-2.2.0.sha256sum] = "bee3b67d0ea5c2cca5003417989af8996f8604e34fb9ddf96208a033901e70de"
-SRC_URI[icu_properties_data-2.2.0.sha256sum] = "8e2bbb201e0c04f7b4b3e14382af113e17ba4f63e2c9d2ee626b720cbce54a14"
-SRC_URI[icu_provider-2.2.0.sha256sum] = "139c4cf31c8b5f33d7e199446eff9c1e02decfc2f0eec2c8d71f65befa45b421"
+SRC_URI[hybrid-array-0.4.14.sha256sum] = "707114b52a152fa7bdb290cd7cd5912d9467273b6d74e21b8d81aca1f8533f6b"
+SRC_URI[icu_collections-2.3.0.sha256sum] = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
+SRC_URI[icu_locale_core-2.3.0.sha256sum] = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
+SRC_URI[icu_normalizer-2.3.0.sha256sum] = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
+SRC_URI[icu_normalizer_data-2.3.0.sha256sum] = "1563da1ed3e0b3bf3d74c9b85917ac9c56464d2f57242270c09c9e752f8021a0"
+SRC_URI[icu_properties-2.3.0.sha256sum] = "7e7ca276ad3145661a65914e6daf131ca5120cd3dcee8f8f3214b8875184a148"
+SRC_URI[icu_properties_data-2.3.0.sha256sum] = "e590f038c1464a96894fd6d10127e90a8be4509f56ff7ecef851b15cee0b7caa"
+SRC_URI[icu_provider-2.3.1.sha256sum] = "d27bbb9d3abbefac45d55f647c9de1d44aafcd1186eb91879afef17c396c3e73"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
 SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
-SRC_URI[ignore-0.4.28.sha256sum] = "2adf14691c72bcfc1058740436a35bdd3ae9c07d1a941ef00b749e9ea16aefa7"
+SRC_URI[ignore-0.4.33.sha256sum] = "00b69833ed729dc5aa7d19541d96d6cf8e9137194207a04916d658e43168402f"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[implib-0.6.0.sha256sum] = "96e1090e37c7188a99a2353115083505ff6a489e86637dc41e1671457b1259d3"
 SRC_URI[indexmap-2.14.0.sha256sum] = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
-SRC_URI[io-close-0.3.7.sha256sum] = "9cadcf447f06744f8ce713d2d6239bb5bde2c357a452397a9ed90c625da390bc"
 SRC_URI[is_executable-1.0.6.sha256sum] = "82cb6a9f675da968c63b6208c641b9dca58fc0133ae53375736b1767b0cab8bd"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
-SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
 SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
 SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
-SRC_URI[jiff-0.2.32.sha256sum] = "961d16382652bfdd8c6f68b223b26a8c93e0d475c672f414411db31c6c5c900e"
-SRC_URI[jiff-static-0.2.32.sha256sum] = "d0879bd39df99c4c5e2c6615ccc026391a423dde10532c573e6086eb94a802cc"
+SRC_URI[jiff-0.2.35.sha256sum] = "668b7183bd07af9a4885f5c35b0cc5c83c4607a913c16b7e17291832910d2dcc"
+SRC_URI[jiff-core-0.1.0.sha256sum] = "7feca88439efe53da3754500c1851dedf3cb36c524dd5cf8225cc0794de95d09"
+SRC_URI[jiff-static-0.2.35.sha256sum] = "3a69dcb3a21cfb32ce1cd056169337ca284af0766dd766e7878819b251a49204"
 SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
-SRC_URI[js-sys-0.3.103.sha256sum] = "53b44bfcdb3f8d5837a46dae1ca9660a837176eee74a28b229bc626816589102"
-SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
+SRC_URI[js-sys-0.3.104.sha256sum] = "0e0c1080212aad755ea003d18543e8768dd432c48819efd73a7bf1e39b7a5a3a"
+SRC_URI[kstring-2.0.4.sha256sum] = "b609e7ca5ea38f093c20a4a102335b247221c9643b7a6bc3510f196f99499a9e"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.186.sha256sum] = "68ab91017fe16c622486840e4c83c9a37afeff978bd239b5293d61ece587de66"
-SRC_URI[libgit2-sys-0.18.5+1.9.4.sha256sum] = "005d6ae6eac1912906073e069f7db60b1fa98e052a68227824afe3e3a1c59ca2"
+SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+SRC_URI[libgit2-sys-0.18.8+1.9.7.sha256sum] = "7f7c568b25d7489bc3fb2988ed69ab111d2944d2f5fec3d5c987fe545ea97b50"
 SRC_URI[libloading-0.9.0.sha256sum] = "754ca22de805bb5744484a5b151a9e1a8e837d5dc232c2d7d8c2e3492edc8b60"
 SRC_URI[libnghttp2-sys-0.1.13+1.68.1.sha256sum] = "492e00167f1418c15648144f42bbfc63099806ecee9bf8d09a6353d6b4856b3c"
-SRC_URI[libsqlite3-sys-0.37.0.sha256sum] = "b1f111c8c41e7c61a49cd34e44c7619462967221a6443b0ec299e0ac30cfb9b1"
+SRC_URI[libsqlite3-sys-0.38.2.sha256sum] = "f1d20bef17f513b9b3004532233187769cd072d790971f4e4da0e346eb6401e8"
 SRC_URI[libssh2-sys-0.3.2.sha256sum] = "c04141a07bb0c0bc461cb657808764de571702a59bc5c726c400ac9a7625e3ab"
 SRC_URI[libz-sys-1.1.29.sha256sum] = "85bc9657773828b90eeb625adff10eeac83cc21bbfd8e23a03eaa8a33c9e28d9"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
-SRC_URI[litemap-0.8.2.sha256sum] = "92daf443525c4cce67b150400bc2316076100ce0b3686209eb8cf3c31612e6f0"
+SRC_URI[litemap-0.8.3.sha256sum] = "47d9d19d1d6efa0109d2f65ff4c85cddd50bd572e5a00127ab10987290bcefae"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
-SRC_URI[log-0.4.33.sha256sum] = "0ceec5bc11778974d1bcb055b18002eba7f4b3518b6a0081b3af5f21666da9ad"
+SRC_URI[log-0.4.34.sha256sum] = "f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
 SRC_URI[matchers-0.2.0.sha256sum] = "d1525a2a28c7f4fa0fc98bb91ae755d1e2d1505079e05539e35bc876b5d65ae9"
 SRC_URI[maybe-async-0.2.11.sha256sum] = "746873a384ad60adc5db74471dfaba74bd278afbdcfd81db93fafcdfc8b5ca0c"
 SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
@@ -688,8 +675,8 @@ SRC_URI[objc2-io-surface-0.3.2.sha256sum] = "180788110936d59bab6bd83b6060ffdfffb
 SRC_URI[objc2-quartz-core-0.3.2.sha256sum] = "96c1358452b371bf9f104e21ec536d37a650eb10f7ee379fff67d2e08d537f1f"
 SRC_URI[objc2-ui-kit-0.3.2.sha256sum] = "d87d638e33c06f577498cbcc50491496a3ed4246998a7fbba7ccb98b1e7eab22"
 SRC_URI[objc2-user-notifications-0.3.2.sha256sum] = "9df9128cbbfef73cda168416ccf7f837b62737d748333bfe9ab71c245d76613e"
-SRC_URI[object-0.37.3.sha256sum] = "ff76201f031d8863c38aa7f905eca4f53abbfa15f609db4277d44cd8938f33fe"
 SRC_URI[object-0.39.1.sha256sum] = "2e5a6c098c7a3b6547378093f5cc30bc54fd361ce711e05293a5cc589562739b"
+SRC_URI[object-0.40.0.sha256sum] = "dd229a0361b9d0d4396176e02d65897f487eebeab7caa6d443855ee152ca0b9c"
 SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[opener-0.8.5.sha256sum] = "b2b03ff07a220d0d0ec9a1f0f238951b7967a5a2e96aefcd21a117b1083415e9"
@@ -710,27 +697,27 @@ SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae59434
 SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
 SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
-SRC_URI[pkg-config-0.3.33.sha256sum] = "19f132c84eca552bf34cab8ec81f1c1dcc229b811638f9d283dceabe58c5569e"
-SRC_URI[portable-atomic-1.13.1.sha256sum] = "c33a9471896f1c69cecef8d20cbe2f7accd12527ce60845ff44c153bb2a21b49"
+SRC_URI[pkg-config-0.3.34.sha256sum] = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
+SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
 SRC_URI[portable-atomic-util-0.2.7.sha256sum] = "c2a106d1259c23fac8e543272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
-SRC_URI[potential_utf-0.1.5.sha256sum] = "0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564"
+SRC_URI[potential_utf-0.1.6.sha256sum] = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
-SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
 SRC_URI[prodash-31.0.0.sha256sum] = "962200e2d7d551451297d9fdce85138374019ada198e30ea9ede38034e27604c"
-SRC_URI[quote-1.0.46.sha256sum] = "dfbc457d0c7a0759a614551b11a6409e5951f6c7537be1f1b7682b9ae9230368"
+SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
 SRC_URI[rand-0.10.2.sha256sum] = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
 SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
-SRC_URI[regex-1.13.0.sha256sum] = "2a0e75113e14dc5acb068cd0786884f214f1312650a3d36d269f5c4f3cdee8a2"
-SRC_URI[regex-automata-0.4.15.sha256sum] = "1f388202e4b80542a0921078cc23b6333bcf1409c1e3f86404cae4766a6131db"
+SRC_URI[regex-1.13.1.sha256sum] = "f020237b6c8eed93db2e2cb53c00c60a8e1bc73da7d073199a1180401450218d"
+SRC_URI[regex-automata-0.4.18.sha256sum] = "ad8553b9b26413251cbf30e620595c7a41b3887f03da04579c0e6b0d6a06b4b2"
 SRC_URI[regex-syntax-0.8.11.sha256sum] = "d6f6ff9a378485b298a5286656da665ba74413d36db0979633275d2e708145d4"
 SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
 SRC_URI[rsqlite-vfs-0.1.1.sha256sum] = "c51c9ae4df8a7fba42103df5c621fa3c37eccf3a3c650879e90fc48b11cc192c"
-SRC_URI[rusqlite-0.39.0.sha256sum] = "a0d2b0146dd9661bf67bb107c0bb2a55064d556eeb3fc314151b957f313bcd4e"
+SRC_URI[rusqlite-0.40.2.sha256sum] = "23f2a97da3e3873c73cb2a2e71b35c40ff95e0b1eefa8d72d8499a6928c3b5b3"
 SRC_URI[rustc-hash-2.1.3.sha256sum] = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
 SRC_URI[rustfix-0.9.7.sha256sum] = "4ab550bf03e3428c98b8e0354800a18f366f1f5f25544b908463b4634374f34f"
@@ -743,13 +730,13 @@ SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189
 SRC_URI[security-framework-3.7.0.sha256sum] = "b7f4bc775c73d9a02cde8bf7b2ec4c9d12743edf609006c7facc23998404cd1d"
 SRC_URI[security-framework-sys-2.17.0.sha256sum] = "6ce2691df843ecc5d231c0b14ece2acc3efb62c0a398c7e1d875f3983ce020e3"
 SRC_URI[semver-1.0.28.sha256sum] = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
-SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
+SRC_URI[serde-1.0.229.sha256sum] = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
 SRC_URI[serde-untagged-0.1.9.sha256sum] = "f9faf48a4a2d2693be24c6289dbe26552776eb7737074e6722891fadbe6c5058"
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
-SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
-SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
+SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
+SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
 SRC_URI[serde_ignored-0.1.14.sha256sum] = "115dffd5f3853e06e746965a20dcbae6ee747ae30b543d91b0e089668bb07798"
-SRC_URI[serde_json-1.0.150.sha256sum] = "e8014e44b4736ed0538adeecded0fce2a272f22dc9578a7eb6b2d9993c74cfb9"
+SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
 SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
 SRC_URI[sha1-0.10.7.sha256sum] = "a978451301f4db1d02937a4ab3ccce137717b81826e79b7d49ffe3244a13c3b8"
 SRC_URI[sha1-0.11.0.sha256sum] = "aacc4cc499359472b4abe1bf11d0b12e688af9a805fa5e3016f9a386dc2d0214"
@@ -761,11 +748,11 @@ SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873b
 SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
-SRC_URI[simd-adler32-0.3.9.sha256sum] = "703d5c7ef118737c72f1af64ad2f6f8c5e1921f818cdcb97b8fe6fc69bf66214"
+SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
 SRC_URI[smallvec-1.15.2.sha256sum] = "8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
-SRC_URI[socket2-0.6.4.sha256sum] = "52d1cfed4120b4d927bf7c0f86d2087a4a7d6027c906d9f9d525a80573b9be51"
+SRC_URI[socket2-0.6.5.sha256sum] = "c3d1e2c7f27f8d4cb10542a02c49005dbd6e93095799d6f3be745fae9f8fedd4"
 SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
 SRC_URI[sqlite-wasm-rs-0.5.5.sha256sum] = "dc3efc0da82635d7e1ced0053bbbfa8c7ab9645d0bf36ceb4f7127bb85315d75"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
@@ -774,27 +761,28 @@ SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70
 SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
 SRC_URI[supports-hyperlinks-3.2.0.sha256sum] = "e396b6523b11ccb83120b115a0b7366de372751aa6edf19844dfb13a6af97e91"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
-SRC_URI[syn-2.0.118.sha256sum] = "1b9ae57f904213ebb649ce6895b8a66c66f0203b9319718f69a5612a065b1422"
+SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
+SRC_URI[syn-3.0.3.sha256sum] = "53e9bae58849f64dfa4f5d5ae372c8341f7305f82a3868709269343628b659a3"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
 SRC_URI[tar-0.4.46.sha256sum] = "3f6221d9a6003c78398e3b239969f352578258df48c8eb051caadae0015bc840"
 SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[terminal_size-0.4.4.sha256sum] = "230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
-SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
-SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
+SRC_URI[thiserror-2.0.20.sha256sum] = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
+SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
 SRC_URI[thread_local-1.1.10.sha256sum] = "1ad99c4c6d32803332c548b1af0540b357b3f5fc0be8f6c6bfe8b2e6ae784070"
-SRC_URI[time-0.3.53.sha256sum] = "18dfaaeddcb932337b5e7866ee7d0ce9b76d2fd092997146f187ec09b4558a50"
+SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
 SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
-SRC_URI[time-macros-0.2.31.sha256sum] = "c431b87111666e491a90baa837f914fb45cd5dc3c268591b0220ff5057f2085f"
-SRC_URI[tinystr-0.8.3.sha256sum] = "c8323304221c2a851516f22236c5722a72eaa19749016521d6dff0824447d96d"
+SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
+SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
 SRC_URI[tinyvec-1.12.0.sha256sum] = "bb4ebadaa0af04fab11ae01eb5f9fdb5f9c5b875506e210e71c07873528baa7f"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
 SRC_URI[toml-0.9.12+spec-1.1.0.sha256sum] = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
-SRC_URI[toml-1.1.2+spec-1.1.0.sha256sum] = "81f3d15e84cbcd896376e6730314d59fb5a87f31e4b038454184435cd57defee"
+SRC_URI[toml-1.1.4+spec-1.1.0.sha256sum] = "3aace63f4bbcdfc2c965b059de67119c89c4017a70d633be6c104910f67056f5"
 SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
 SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
-SRC_URI[toml_edit-0.25.12+spec-1.1.0.sha256sum] = "d2153edc6955a6c354fad8f5efd38b6a8769bdccf9fe50f8e1329f81b0baa5d7"
-SRC_URI[toml_parser-1.1.2+spec-1.1.0.sha256sum] = "a2abe9b86193656635d2411dc43050282ca48aa31c2451210f4202550afb7526"
-SRC_URI[toml_writer-1.1.1+spec-1.1.0.sha256sum] = "756daf9b1013ebe47a8776667b466417e2d4c5679d441c26230efd9ef78692db"
+SRC_URI[toml_edit-0.25.13+spec-1.1.0.sha256sum] = "6975367e4d2ef766d86af01ffad14b622fecc8d4357a998fbc4deb6e9bacaf9b"
+SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
+SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
 SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
 SRC_URI[tracing-attributes-0.1.31.sha256sum] = "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
@@ -816,26 +804,23 @@ SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb82
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
-SRC_URI[wasm-bindgen-0.2.126.sha256sum] = "4b067c0c11094aef6b7a801c1e34a26affafdf3d051dba08456b868789aaf9a4"
-SRC_URI[wasm-bindgen-macro-0.2.126.sha256sum] = "167ce5e579f6bcf889c4f7175a8a5a585de84e8ff93976ce393efa5f2837aab1"
-SRC_URI[wasm-bindgen-macro-support-0.2.126.sha256sum] = "f3997c7839262f4ef12cf90b818d6340c18e80f263f1a94bf157d0ec4420380e"
-SRC_URI[wasm-bindgen-shared-0.2.126.sha256sum] = "dc1b4cb0cc549fcf58d7dfc081778139b3d283a081644e833e84682ad71cea24"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[wasm-bindgen-0.2.127.sha256sum] = "1b70935747edd64d89de3efa29d73789b806c15798f8e7dca4d8ac356b50ce70"
+SRC_URI[wasm-bindgen-macro-0.2.127.sha256sum] = "77775f8f3f7217702089053b94958f8f54061a3f663417df76e19cbdcca29bc1"
+SRC_URI[wasm-bindgen-macro-support-0.2.127.sha256sum] = "e11d33f857dc2fb11b8bc75aee111aa9cbeb12cd9f25efd3d4c2a3dd4e235284"
+SRC_URI[wasm-bindgen-shared-0.2.127.sha256sum] = "7ef64dbcc55df09c7e5a46182d181c2cfa3e925f3da937ea764728b4bbb9dcbf"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
 SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
 SRC_URI[winnow-0.7.15.sha256sum] = "df79d97927682d2fd8adb29682d1140b343be4ac0f08fd68b7765d9c059d3945"
-SRC_URI[winnow-1.0.3.sha256sum] = "0592e1c9d151f854e6fd382574c3a0855250e1d9b2f99d9281c6e6391af352f1"
-SRC_URI[writeable-0.6.3.sha256sum] = "1ffae5123b2d3fc086436f8834ae3ab053a283cfac8fe0a0b8eaae044768a4c4"
+SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
+SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
 SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
 SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
 SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
 SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
 SRC_URI[zeroize-1.9.0.sha256sum] = "e13c156562582aa81c60cb29407084cdb54c4164760106ab78e6c5b0858cf64e"
-SRC_URI[zerotrie-0.2.4.sha256sum] = "0f9152d31db0792fa83f70fb2f83148effb5c1f5b8c7686c3459e361d9bc20bf"
-SRC_URI[zerovec-0.11.6.sha256sum] = "90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239"
-SRC_URI[zerovec-derive-0.11.3.sha256sum] = "625dc425cab0dca6dc3c3319506e6593dcb08a9f387ea3b284dbd52a92c40555"
-SRC_URI[zlib-rs-0.6.6.sha256sum] = "b142a20ec14a91d5bc708c1dc21b080c550113d8aa77afa29635673a65dd02c5"
-SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
+SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
+SRC_URI[zerovec-0.11.8.sha256sum] = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
+SRC_URI[zerovec-derive-0.11.6.sha256sum] = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
+SRC_URI[zlib-rs-0.6.7.sha256sum] = "34b31d188d9d685a4f9c7b46d6e36631b07058d2cfe190267adce54dc230bf12"
+SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
diff --git a/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb b/recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb
similarity index 87%
rename from recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb
rename to recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb
index 482a342..b6e459c 100644
--- a/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb
+++ b/recipes-devtools/cargo-c/cargo-c_0.10.25+cargo-0.99.0.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.12/ \
 "
-SRC_URI[cargo-c.sha256sum] = "e033742583695968c690582ab678f65c133779767940c9bc35718e990a235d45"
+SRC_URI[cargo-c.sha256sum] = "6b2ddde58a8a773ccce4b6384acacd3ce01373f52717dd2424633ed46755c627"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
-- 
2.55.0


