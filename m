Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D288C88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:50 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48440.1789157622143933942
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZRTqjuAx;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cc39e06bdso14268566d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157621; x=1789762421; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JfUm297wXLwaJBciENR+f34/Mi2psfxV/gq1QQnAPBk=;
        b=ZRTqjuAx4gY8qHmbmWYo4fBAtO2wBWmJpIooyDsj0APK9J/gCrf+3lm0/ljs7krULk
         R86wvMbUMasp7IzAkqv5V/r8SvCEs4x3FM/QRWkJj2bPZF4k7c7lY4SlX556WCQgRlHr
         1iG7BRxkzYNFBsTzYeuiiEoLK5maVwOXm2J7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157621; x=1789762421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JfUm297wXLwaJBciENR+f34/Mi2psfxV/gq1QQnAPBk=;
        b=U+NkI4po3N0X+Od70aMpI4+7X345MXBG12curY6xpJ44+oZyAm9NMtXHEFJ5/unyL9
         jFhbTXA/j8J0FDApiRctrfZc/TYX+Ecra+I7Rm3/KQdRBHIrNM9Zp3H9Y/MXZb6epoZd
         ZYSrYo8o95HrIkwSc1jZOV838g+wpLVcJ27vMis2MQgvC99jC/LO5o5P3l1qO1Zp5mgM
         eYZ5F0E0wFN7Mp/M6ojIbpU7zc5iiHcAOnFz/0vf/JcWcvgBXzkl1P/0js+eyQ79y/td
         YgjtzU6S9JtMzmQKljG3OKUGOkj9K9BnTHeUL8Bk5jC8MTxJv+eFZSWF1uk88aamuB5D
         GEzQ==
X-Gm-Message-State: AFuF++mwe0aopQCIqo/70IXK4SoKWhBppwgpCKisLWaJ2nsxVQxei5R6
	yi46B5hKxQmoSSGLOyFcOpk261s+7X5AKHCbdoWHYfEkv0qfH3EkwKB30ymJ9OIwKEo2glR/fgO
	BUY5F
X-Gm-Gg: AYBFou1FmVOAlq4tw7NPMZ4NP0XmwbRKLgAu+spc7CTkHD4fRkULjeCa5TkbRp5Aoat
	JVt8/GLig/92l981Au3Pzsg6qE/m5sQNbFL/iewoXvx8Iw4CQ3rsjhJDSiE+Gqlw/7Ro4e8AYh6
	mRLwvz3/lNrzuxsj2Ng4z/ypS+A1FjnH3xHqNgmsITCNHT+Iz6pbNGRxYEhxVUJZGAfq7ThHKff
	C0XPUczyjEvk3eNpU31OGNoozEWLYdJ0dvqDWMIGuPxUsuL2IVUVdEbaImbzEAV2CWqc3HV1YgC
	QFLPjst3TAyO0J0oUc915AlOr3vEYD/vciatGCFFxHIE3GiYVvRAKIYmPjZeQ79kA8VquCydxar
	WW4+F8n7LgjLXq6+QA0Q+0Tzj8qcoU9Ig8FGUvIeO2jL17o9phNoVHqEQQisx34fYnrO0XFKgDJ
	inmFy9ZHct4XCh8XJaB4vt6casdBugSfxbKh6/BoWQcZRv+T0qMd6KisMOlfyuFUGQwlJNs+OGw
	jo9Ai64/1Lv7qDwYwz9Dt2H5hZ1NAILsoGSokxo7Catr4sFGGIiGjSOzMg5U6/fVbafNaFsCrZ8
	R7uuqN9Y/YZuKW8Sg50GioYDlQIi/hTdsjY=
X-Received: by 2002:ac8:5d56:0:b0:528:601:301e with SMTP id d75a77b69052e-530c855b1a0mr86987581cf.26.1789157620089;
        Fri, 11 Sep 2026 13:13:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/37] cargo-c: update 0.10.21 -> 0.10.22
Date: Fri, 11 Sep 2026 16:12:48 -0400
Message-ID: <8785e38700dbf3fd174f7ee230fd54ad6124f034.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4767

From: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>

cargo-c version updated to stable version 0.10.22+cargo-0.96.0.

https://crates.io/crates/cargo-c/0.10.22+cargo-0.96.0
https://github.com/lu-zero/cargo-c/compare/v0.10.21...v0.10.22

Signed-off-by: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f645390d6499919a85dec75814e0e6556fffa48a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 554 +++++++++---------
 ...5.0.bb => cargo-c_0.10.22+cargo-0.96.0.bb} |   2 +-
 2 files changed, 285 insertions(+), 271 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.21+cargo-0.95.0.bb => cargo-c_0.10.22+cargo-0.96.0.bb} (87%)

diff --git a/recipes-devtools/cargo-c/cargo-c-crates.inc b/recipes-devtools/cargo-c/cargo-c-crates.inc
index bb58955..8b301b1 100644
--- a/recipes-devtools/cargo-c/cargo-c-crates.inc
+++ b/recipes-devtools/cargo-c/cargo-c-crates.inc
@@ -6,23 +6,26 @@ SRC_URI += " \
     crate://crates.io/aho-corasick/1.1.4 \
     crate://crates.io/allocator-api2/0.2.21 \
     crate://crates.io/android_system_properties/0.1.5 \
-    crate://crates.io/annotate-snippets/0.12.13 \
+    crate://crates.io/annotate-snippets/0.12.15 \
     crate://crates.io/anstream/0.6.21 \
-    crate://crates.io/anstyle/1.0.13 \
+    crate://crates.io/anstream/1.0.0 \
+    crate://crates.io/anstyle/1.0.14 \
     crate://crates.io/anstyle-parse/0.2.7 \
+    crate://crates.io/anstyle-parse/1.0.0 \
     crate://crates.io/anstyle-query/1.1.5 \
     crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/anyhow/1.0.102 \
-    crate://crates.io/arc-swap/1.8.2 \
+    crate://crates.io/ar_archive_writer/0.5.1 \
+    crate://crates.io/arc-swap/1.9.1 \
     crate://crates.io/arrayref/0.3.9 \
     crate://crates.io/arrayvec/0.7.6 \
     crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
     crate://crates.io/base64ct/1.8.3 \
-    crate://crates.io/bitflags/2.11.0 \
+    crate://crates.io/bitflags/2.11.1 \
     crate://crates.io/bitmaps/2.1.0 \
-    crate://crates.io/blake3/1.8.3 \
+    crate://crates.io/blake3/1.8.5 \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/block2/0.6.2 \
     crate://crates.io/bstr/1.12.1 \
@@ -30,33 +33,34 @@ SRC_URI += " \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.11.1 \
     crate://crates.io/camino/1.2.2 \
-    crate://crates.io/cargo/0.95.0 \
-    crate://crates.io/cargo-credential/0.4.9 \
-    crate://crates.io/cargo-credential-libsecret/0.5.5 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.20 \
-    crate://crates.io/cargo-credential-wincred/0.4.20 \
-    crate://crates.io/cargo-platform/0.3.2 \
-    crate://crates.io/cargo-util/0.2.27 \
-    crate://crates.io/cargo-util-schemas/0.12.0 \
+    crate://crates.io/cargo/0.96.0 \
+    crate://crates.io/cargo-credential/0.4.10 \
+    crate://crates.io/cargo-credential-libsecret/0.5.6 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.21 \
+    crate://crates.io/cargo-credential-wincred/0.4.21 \
+    crate://crates.io/cargo-platform/0.3.3 \
+    crate://crates.io/cargo-util/0.2.28 \
+    crate://crates.io/cargo-util-schemas/0.13.0 \
     crate://crates.io/cbindgen/0.29.2 \
-    crate://crates.io/cc/1.2.56 \
+    crate://crates.io/cc/1.2.61 \
     crate://crates.io/cfg-if/1.0.4 \
     crate://crates.io/cfg_aliases/0.2.1 \
-    crate://crates.io/clap/4.5.60 \
-    crate://crates.io/clap_builder/4.5.60 \
-    crate://crates.io/clap_complete/4.5.66 \
-    crate://crates.io/clap_derive/4.5.55 \
-    crate://crates.io/clap_lex/1.0.0 \
+    crate://crates.io/clap/4.6.1 \
+    crate://crates.io/clap_builder/4.6.0 \
+    crate://crates.io/clap_complete/4.6.3 \
+    crate://crates.io/clap_derive/4.6.1 \
+    crate://crates.io/clap_lex/1.1.0 \
     crate://crates.io/clru/0.6.3 \
     crate://crates.io/color-print/0.3.7 \
     crate://crates.io/color-print-proc-macro/0.3.7 \
-    crate://crates.io/colorchoice/1.0.4 \
+    crate://crates.io/colorchoice/1.0.5 \
     crate://crates.io/const-oid/0.9.6 \
     crate://crates.io/constant_time_eq/0.4.2 \
     crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crates-io/0.40.17 \
+    crate://crates.io/cpufeatures/0.3.0 \
+    crate://crates.io/crates-io/0.40.18 \
     crate://crates.io/crc32fast/1.5.0 \
     crate://crates.io/crossbeam-channel/0.5.15 \
     crate://crates.io/crossbeam-deque/0.8.6 \
@@ -66,7 +70,7 @@ SRC_URI += " \
     crate://crates.io/crypto-common/0.1.6 \
     crate://crates.io/ct-codecs/1.1.6 \
     crate://crates.io/curl/0.4.49 \
-    crate://crates.io/curl-sys/0.4.85+curl-8.18.0 \
+    crate://crates.io/curl-sys/0.4.83+curl-8.15.0 \
     crate://crates.io/dashmap/6.1.0 \
     crate://crates.io/der/0.7.10 \
     crate://crates.io/deranged/0.5.8 \
@@ -85,7 +89,7 @@ SRC_URI += " \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
     crate://crates.io/faster-hex/0.10.0 \
-    crate://crates.io/fastrand/2.3.0 \
+    crate://crates.io/fastrand/2.4.1 \
     crate://crates.io/ff/0.13.1 \
     crate://crates.io/fiat-crypto/0.3.0 \
     crate://crates.io/filetime/0.2.27 \
@@ -103,55 +107,56 @@ SRC_URI += " \
     crate://crates.io/getrandom/0.4.2 \
     crate://crates.io/git2/0.20.4 \
     crate://crates.io/git2-curl/0.21.0 \
-    crate://crates.io/gix/0.77.0 \
-    crate://crates.io/gix-actor/0.37.1 \
-    crate://crates.io/gix-attributes/0.29.0 \
+    crate://crates.io/gix/0.79.0 \
+    crate://crates.io/gix-actor/0.39.0 \
+    crate://crates.io/gix-attributes/0.30.1 \
     crate://crates.io/gix-bitmap/0.2.16 \
-    crate://crates.io/gix-chunk/0.4.12 \
-    crate://crates.io/gix-command/0.6.5 \
-    crate://crates.io/gix-commitgraph/0.31.0 \
-    crate://crates.io/gix-config/0.50.0 \
-    crate://crates.io/gix-config-value/0.16.0 \
-    crate://crates.io/gix-credentials/0.34.1 \
-    crate://crates.io/gix-date/0.12.1 \
-    crate://crates.io/gix-diff/0.57.1 \
-    crate://crates.io/gix-dir/0.19.0 \
-    crate://crates.io/gix-discover/0.45.0 \
-    crate://crates.io/gix-features/0.45.2 \
-    crate://crates.io/gix-filter/0.24.1 \
-    crate://crates.io/gix-fs/0.18.2 \
-    crate://crates.io/gix-glob/0.23.0 \
-    crate://crates.io/gix-hash/0.21.2 \
-    crate://crates.io/gix-hashtable/0.11.0 \
-    crate://crates.io/gix-ignore/0.18.0 \
-    crate://crates.io/gix-index/0.45.1 \
-    crate://crates.io/gix-lock/20.0.1 \
-    crate://crates.io/gix-negotiate/0.25.0 \
-    crate://crates.io/gix-object/0.54.1 \
-    crate://crates.io/gix-odb/0.74.0 \
-    crate://crates.io/gix-pack/0.64.1 \
-    crate://crates.io/gix-packetline/0.20.0 \
-    crate://crates.io/gix-path/0.10.22 \
-    crate://crates.io/gix-pathspec/0.14.0 \
-    crate://crates.io/gix-prompt/0.12.0 \
-    crate://crates.io/gix-protocol/0.55.0 \
+    crate://crates.io/gix-chunk/0.6.0 \
+    crate://crates.io/gix-command/0.7.1 \
+    crate://crates.io/gix-commitgraph/0.33.0 \
+    crate://crates.io/gix-config/0.52.0 \
+    crate://crates.io/gix-config-value/0.17.2 \
+    crate://crates.io/gix-credentials/0.36.0 \
+    crate://crates.io/gix-date/0.14.0 \
+    crate://crates.io/gix-diff/0.59.0 \
+    crate://crates.io/gix-dir/0.21.0 \
+    crate://crates.io/gix-discover/0.47.0 \
+    crate://crates.io/gix-error/0.1.0 \
+    crate://crates.io/gix-features/0.46.2 \
+    crate://crates.io/gix-filter/0.26.0 \
+    crate://crates.io/gix-fs/0.19.2 \
+    crate://crates.io/gix-glob/0.24.0 \
+    crate://crates.io/gix-hash/0.22.1 \
+    crate://crates.io/gix-hashtable/0.12.0 \
+    crate://crates.io/gix-ignore/0.19.1 \
+    crate://crates.io/gix-index/0.47.0 \
+    crate://crates.io/gix-lock/21.0.2 \
+    crate://crates.io/gix-negotiate/0.27.0 \
+    crate://crates.io/gix-object/0.56.0 \
+    crate://crates.io/gix-odb/0.76.0 \
+    crate://crates.io/gix-pack/0.66.0 \
+    crate://crates.io/gix-packetline/0.21.3 \
+    crate://crates.io/gix-path/0.11.3 \
+    crate://crates.io/gix-pathspec/0.15.1 \
+    crate://crates.io/gix-prompt/0.13.1 \
+    crate://crates.io/gix-protocol/0.57.0 \
     crate://crates.io/gix-quote/0.6.2 \
-    crate://crates.io/gix-ref/0.57.0 \
-    crate://crates.io/gix-refspec/0.35.0 \
-    crate://crates.io/gix-revision/0.39.0 \
-    crate://crates.io/gix-revwalk/0.25.0 \
-    crate://crates.io/gix-sec/0.12.2 \
-    crate://crates.io/gix-shallow/0.7.0 \
-    crate://crates.io/gix-status/0.24.0 \
-    crate://crates.io/gix-submodule/0.24.0 \
-    crate://crates.io/gix-tempfile/20.0.1 \
-    crate://crates.io/gix-trace/0.1.18 \
-    crate://crates.io/gix-transport/0.52.1 \
-    crate://crates.io/gix-traverse/0.51.1 \
-    crate://crates.io/gix-url/0.34.0 \
-    crate://crates.io/gix-utils/0.3.1 \
-    crate://crates.io/gix-validate/0.10.1 \
-    crate://crates.io/gix-worktree/0.46.0 \
+    crate://crates.io/gix-ref/0.59.0 \
+    crate://crates.io/gix-refspec/0.37.0 \
+    crate://crates.io/gix-revision/0.41.0 \
+    crate://crates.io/gix-revwalk/0.27.0 \
+    crate://crates.io/gix-sec/0.13.3 \
+    crate://crates.io/gix-shallow/0.8.1 \
+    crate://crates.io/gix-status/0.26.0 \
+    crate://crates.io/gix-submodule/0.26.0 \
+    crate://crates.io/gix-tempfile/21.0.2 \
+    crate://crates.io/gix-trace/0.1.19 \
+    crate://crates.io/gix-transport/0.54.0 \
+    crate://crates.io/gix-traverse/0.53.0 \
+    crate://crates.io/gix-url/0.35.3 \
+    crate://crates.io/gix-utils/0.3.2 \
+    crate://crates.io/gix-validate/0.11.1 \
+    crate://crates.io/gix-worktree/0.48.0 \
     crate://crates.io/glob/0.3.3 \
     crate://crates.io/globset/0.4.18 \
     crate://crates.io/group/0.13.0 \
@@ -159,6 +164,7 @@ SRC_URI += " \
     crate://crates.io/hashbrown/0.14.5 \
     crate://crates.io/hashbrown/0.15.5 \
     crate://crates.io/hashbrown/0.16.1 \
+    crate://crates.io/hashbrown/0.17.0 \
     crate://crates.io/hashlink/0.11.0 \
     crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
@@ -167,44 +173,44 @@ SRC_URI += " \
     crate://crates.io/hmac/0.12.1 \
     crate://crates.io/home/0.5.12 \
     crate://crates.io/http-auth/0.1.10 \
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
     crate://crates.io/id-arena/2.3.0 \
     crate://crates.io/idna/1.1.0 \
-    crate://crates.io/idna_adapter/1.2.1 \
+    crate://crates.io/idna_adapter/1.2.2 \
     crate://crates.io/ignore/0.4.25 \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/imara-diff/0.1.8 \
-    crate://crates.io/implib/0.4.0 \
-    crate://crates.io/indexmap/2.13.0 \
+    crate://crates.io/implib/0.6.0 \
+    crate://crates.io/indexmap/2.14.0 \
     crate://crates.io/is_executable/1.0.5 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.14.0 \
-    crate://crates.io/itoa/1.0.17 \
-    crate://crates.io/jiff/0.2.23 \
-    crate://crates.io/jiff-static/0.2.23 \
+    crate://crates.io/itoa/1.0.18 \
+    crate://crates.io/jiff/0.2.24 \
+    crate://crates.io/jiff-static/0.2.24 \
     crate://crates.io/jiff-tzdb/0.1.6 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.34 \
-    crate://crates.io/js-sys/0.3.91 \
+    crate://crates.io/js-sys/0.3.97 \
     crate://crates.io/kstring/2.0.2 \
     crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/leb128fmt/0.1.0 \
-    crate://crates.io/libc/0.2.182 \
+    crate://crates.io/libc/0.2.186 \
     crate://crates.io/libgit2-sys/0.18.3+1.9.2 \
     crate://crates.io/libloading/0.9.0 \
-    crate://crates.io/libnghttp2-sys/0.1.12+1.68.0 \
-    crate://crates.io/libredox/0.1.14 \
+    crate://crates.io/libnghttp2-sys/0.1.13+1.68.1 \
+    crate://crates.io/libredox/0.1.16 \
     crate://crates.io/libsqlite3-sys/0.36.0 \
     crate://crates.io/libssh2-sys/0.3.1 \
-    crate://crates.io/libz-sys/1.1.24 \
+    crate://crates.io/libz-sys/1.1.28 \
     crate://crates.io/linux-raw-sys/0.12.1 \
-    crate://crates.io/litemap/0.8.1 \
+    crate://crates.io/litemap/0.8.2 \
     crate://crates.io/lock_api/0.4.14 \
     crate://crates.io/log/0.4.29 \
     crate://crates.io/matchers/0.2.0 \
@@ -219,7 +225,7 @@ SRC_URI += " \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normpath/1.5.0 \
     crate://crates.io/nu-ansi-term/0.50.3 \
-    crate://crates.io/num-conv/0.2.0 \
+    crate://crates.io/num-conv/0.2.1 \
     crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/objc2/0.6.4 \
     crate://crates.io/objc2-cloud-kit/0.3.2 \
@@ -236,17 +242,17 @@ SRC_URI += " \
     crate://crates.io/objc2-ui-kit/0.3.2 \
     crate://crates.io/objc2-user-notifications/0.3.2 \
     crate://crates.io/object/0.37.3 \
-    crate://crates.io/object/0.38.1 \
-    crate://crates.io/once_cell/1.21.3 \
+    crate://crates.io/object/0.39.1 \
+    crate://crates.io/once_cell/1.21.4 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/opener/0.8.4 \
-    crate://crates.io/openssl/0.10.75 \
+    crate://crates.io/openssl/0.10.78 \
     crate://crates.io/openssl-macros/0.1.1 \
     crate://crates.io/openssl-probe/0.1.6 \
-    crate://crates.io/openssl-src/300.5.5+3.5.5 \
-    crate://crates.io/openssl-sys/0.9.111 \
+    crate://crates.io/openssl-src/300.6.0+3.6.2 \
+    crate://crates.io/openssl-sys/0.9.114 \
     crate://crates.io/ordered-float/2.10.1 \
-    crate://crates.io/orion/0.17.13 \
+    crate://crates.io/orion/0.17.14 \
     crate://crates.io/os_info/3.14.0 \
     crate://crates.io/p384/0.13.1 \
     crate://crates.io/parking_lot/0.12.5 \
@@ -257,45 +263,45 @@ SRC_URI += " \
     crate://crates.io/percent-encoding/2.3.2 \
     crate://crates.io/pin-project-lite/0.2.17 \
     crate://crates.io/pkcs8/0.10.2 \
-    crate://crates.io/pkg-config/0.3.32 \
+    crate://crates.io/pkg-config/0.3.33 \
     crate://crates.io/plain/0.2.3 \
     crate://crates.io/portable-atomic/1.13.1 \
-    crate://crates.io/portable-atomic-util/0.2.5 \
-    crate://crates.io/potential_utf/0.1.4 \
+    crate://crates.io/portable-atomic-util/0.2.7 \
+    crate://crates.io/potential_utf/0.1.5 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/prettyplease/0.2.37 \
     crate://crates.io/primeorder/0.13.6 \
     crate://crates.io/proc-macro2/1.0.106 \
-    crate://crates.io/prodash/30.0.1 \
+    crate://crates.io/prodash/31.0.0 \
     crate://crates.io/quote/1.0.45 \
     crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/r-efi/6.0.0 \
-    crate://crates.io/rand/0.9.2 \
+    crate://crates.io/rand/0.9.4 \
     crate://crates.io/rand_chacha/0.9.0 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.9.5 \
     crate://crates.io/rand_xoshiro/0.6.0 \
     crate://crates.io/redox_syscall/0.5.18 \
-    crate://crates.io/redox_syscall/0.7.3 \
+    crate://crates.io/redox_syscall/0.7.4 \
     crate://crates.io/regex/1.12.3 \
     crate://crates.io/regex-automata/0.4.14 \
     crate://crates.io/regex-syntax/0.8.10 \
     crate://crates.io/rfc6979/0.4.0 \
     crate://crates.io/rsqlite-vfs/0.1.0 \
     crate://crates.io/rusqlite/0.38.0 \
-    crate://crates.io/rustc-hash/2.1.1 \
+    crate://crates.io/rustc-hash/2.1.2 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
-    crate://crates.io/rustfix/0.9.4 \
+    crate://crates.io/rustfix/0.9.5 \
     crate://crates.io/rustix/1.1.4 \
     crate://crates.io/rustversion/1.0.22 \
     crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/schannel/0.1.28 \
+    crate://crates.io/schannel/0.1.29 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/sec1/0.7.3 \
     crate://crates.io/security-framework/3.7.0 \
     crate://crates.io/security-framework-sys/2.17.0 \
-    crate://crates.io/semver/1.0.27 \
+    crate://crates.io/semver/1.0.28 \
     crate://crates.io/serde/1.0.228 \
     crate://crates.io/serde-untagged/0.1.9 \
     crate://crates.io/serde-value/0.7.0 \
@@ -303,7 +309,7 @@ SRC_URI += " \
     crate://crates.io/serde_derive/1.0.228 \
     crate://crates.io/serde_ignored/0.1.14 \
     crate://crates.io/serde_json/1.0.149 \
-    crate://crates.io/serde_spanned/1.0.4 \
+    crate://crates.io/serde_spanned/1.1.1 \
     crate://crates.io/sha1/0.10.6 \
     crate://crates.io/sha1-checked/0.10.0 \
     crate://crates.io/sha2/0.10.9 \
@@ -312,12 +318,12 @@ SRC_URI += " \
     crate://crates.io/shell-words/1.1.1 \
     crate://crates.io/shlex/1.3.0 \
     crate://crates.io/signature/2.2.0 \
-    crate://crates.io/simd-adler32/0.3.8 \
+    crate://crates.io/simd-adler32/0.3.9 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/smallvec/1.15.1 \
-    crate://crates.io/socket2/0.6.2 \
+    crate://crates.io/socket2/0.6.3 \
     crate://crates.io/spki/0.7.3 \
-    crate://crates.io/sqlite-wasm-rs/0.5.2 \
+    crate://crates.io/sqlite-wasm-rs/0.5.3 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/strsim/0.11.1 \
@@ -326,31 +332,31 @@ SRC_URI += " \
     crate://crates.io/supports-unicode/3.0.0 \
     crate://crates.io/syn/2.0.117 \
     crate://crates.io/synstructure/0.13.2 \
-    crate://crates.io/tar/0.4.44 \
-    crate://crates.io/tempfile/3.26.0 \
-    crate://crates.io/terminal_size/0.4.3 \
+    crate://crates.io/tar/0.4.45 \
+    crate://crates.io/tempfile/3.27.0 \
+    crate://crates.io/terminal_size/0.4.4 \
     crate://crates.io/thiserror/2.0.18 \
     crate://crates.io/thiserror-impl/2.0.18 \
     crate://crates.io/thread_local/1.1.9 \
     crate://crates.io/time/0.3.47 \
     crate://crates.io/time-core/0.1.8 \
     crate://crates.io/time-macros/0.2.27 \
-    crate://crates.io/tinystr/0.8.2 \
-    crate://crates.io/tinyvec/1.10.0 \
+    crate://crates.io/tinystr/0.8.3 \
+    crate://crates.io/tinyvec/1.11.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
     crate://crates.io/toml/0.9.12+spec-1.1.0 \
     crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
     crate://crates.io/toml_edit/0.24.1+spec-1.1.0 \
-    crate://crates.io/toml_parser/1.0.9+spec-1.1.0 \
-    crate://crates.io/toml_writer/1.0.6+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.1+spec-1.1.0 \
     crate://crates.io/tracing/0.1.44 \
     crate://crates.io/tracing-attributes/0.1.31 \
     crate://crates.io/tracing-chrome/0.7.2 \
     crate://crates.io/tracing-core/0.1.36 \
     crate://crates.io/tracing-log/0.2.0 \
-    crate://crates.io/tracing-subscriber/0.3.22 \
+    crate://crates.io/tracing-subscriber/0.3.23 \
     crate://crates.io/typeid/1.0.3 \
-    crate://crates.io/typenum/1.19.0 \
+    crate://crates.io/typenum/1.20.0 \
     crate://crates.io/unicase/2.9.0 \
     crate://crates.io/unicode-bom/2.0.3 \
     crate://crates.io/unicode-ident/1.0.24 \
@@ -365,12 +371,12 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
-    crate://crates.io/wasip2/1.0.2+wasi-0.2.9 \
+    crate://crates.io/wasip2/1.0.3+wasi-0.2.9 \
     crate://crates.io/wasip3/0.4.0+wasi-0.3.0-rc-2026-01-06 \
-    crate://crates.io/wasm-bindgen/0.2.114 \
-    crate://crates.io/wasm-bindgen-macro/0.2.114 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.114 \
-    crate://crates.io/wasm-bindgen-shared/0.2.114 \
+    crate://crates.io/wasm-bindgen/0.2.120 \
+    crate://crates.io/wasm-bindgen-macro/0.2.120 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.120 \
+    crate://crates.io/wasm-bindgen-shared/0.2.120 \
     crate://crates.io/wasm-encoder/0.244.0 \
     crate://crates.io/wasm-metadata/0.244.0 \
     crate://crates.io/wasmparser/0.244.0 \
@@ -398,24 +404,25 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.53.1 \
     crate://crates.io/winnow/0.7.15 \
+    crate://crates.io/winnow/1.0.2 \
     crate://crates.io/wit-bindgen/0.51.0 \
+    crate://crates.io/wit-bindgen/0.57.1 \
     crate://crates.io/wit-bindgen-core/0.51.0 \
     crate://crates.io/wit-bindgen-rust/0.51.0 \
     crate://crates.io/wit-bindgen-rust-macro/0.51.0 \
     crate://crates.io/wit-component/0.244.0 \
     crate://crates.io/wit-parser/0.244.0 \
-    crate://crates.io/writeable/0.6.2 \
-    crate://crates.io/yoke/0.8.1 \
-    crate://crates.io/yoke-derive/0.8.1 \
-    crate://crates.io/zerocopy/0.8.40 \
-    crate://crates.io/zerocopy-derive/0.8.40 \
-    crate://crates.io/zerofrom/0.1.6 \
-    crate://crates.io/zerofrom-derive/0.1.6 \
+    crate://crates.io/writeable/0.6.3 \
+    crate://crates.io/yoke/0.8.2 \
+    crate://crates.io/yoke-derive/0.8.2 \
+    crate://crates.io/zerocopy/0.8.48 \
+    crate://crates.io/zerocopy-derive/0.8.48 \
+    crate://crates.io/zerofrom/0.1.7 \
+    crate://crates.io/zerofrom-derive/0.1.7 \
     crate://crates.io/zeroize/1.8.2 \
-    crate://crates.io/zerotrie/0.2.3 \
-    crate://crates.io/zerovec/0.11.5 \
-    crate://crates.io/zerovec-derive/0.11.2 \
-    crate://crates.io/zlib-rs/0.5.5 \
+    crate://crates.io/zerotrie/0.2.4 \
+    crate://crates.io/zerovec/0.11.6 \
+    crate://crates.io/zerovec-derive/0.11.3 \
     crate://crates.io/zlib-rs/0.6.3 \
     crate://crates.io/zmij/1.0.21 \
 "
@@ -424,23 +431,26 @@ SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e062506252
 SRC_URI[aho-corasick-1.1.4.sha256sum] = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
 SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
-SRC_URI[annotate-snippets-0.12.13.sha256sum] = "74fc7650eedcb2fee505aad48491529e408f0e854c2d9f63eb86c1361b9b3f93"
+SRC_URI[annotate-snippets-0.12.15.sha256sum] = "92570a3f9c98e7e84df84b71d0965ac99b1871fcd75a3773a3bd1bad13f64cf7"
 SRC_URI[anstream-0.6.21.sha256sum] = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
-SRC_URI[anstyle-1.0.13.sha256sum] = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
+SRC_URI[anstream-1.0.0.sha256sum] = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
+SRC_URI[anstyle-1.0.14.sha256sum] = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
 SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
+SRC_URI[anstyle-parse-1.0.0.sha256sum] = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
 SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[anyhow-1.0.102.sha256sum] = "7f202df86484c868dbad7eaa557ef785d5c66295e41b460ef922eca0723b842c"
-SRC_URI[arc-swap-1.8.2.sha256sum] = "f9f3647c145568cec02c42054e07bdf9a5a698e15b466fb2341bfc393cd24aa5"
+SRC_URI[ar_archive_writer-0.5.1.sha256sum] = "7eb93bbb63b9c227414f6eb3a0adfddca591a8ce1e9b60661bb08969b87e340b"
+SRC_URI[arc-swap-1.9.1.sha256sum] = "6a3a1fd6f75306b68087b831f025c712524bcb19aad54e557b1129cfa0a2b207"
 SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
 SRC_URI[arrayvec-0.7.6.sha256sum] = "7c02d123df017efcdfbd739ef81735b36c5ba83ec3c59c80a9d7ecc718f92e50"
 SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
 SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
-SRC_URI[bitflags-2.11.0.sha256sum] = "843867be96c8daad0d758b57df9392b6d8d271134fce549de6ce169ff98a92af"
+SRC_URI[bitflags-2.11.1.sha256sum] = "c4512299f36f043ab09a583e57bceb5a5aab7a73db1805848e8fef3c9e8c78b3"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
-SRC_URI[blake3-1.8.3.sha256sum] = "2468ef7d57b3fb7e16b576e8377cdbde2320c60e1491e961d11da40fc4f02a2d"
+SRC_URI[blake3-1.8.5.sha256sum] = "0aa83c34e62843d924f905e0f5c866eb1dd6545fc4d719e803d9ba6030371fce"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[block2-0.6.2.sha256sum] = "cdeb9d870516001442e364c5220d3574d2da8dc765554b4a617230d33fa58ef5"
 SRC_URI[bstr-1.12.1.sha256sum] = "63044e1ae8e69f3b5a92c736ca6269b8d12fa7efe39bf34ddb06d102cf0e2cab"
@@ -448,33 +458,34 @@ SRC_URI[bumpalo-3.20.2.sha256sum] = "5d20789868f4b01b2f2caec9f5c4e0213b41e3e5702
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.11.1.sha256sum] = "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33"
 SRC_URI[camino-1.2.2.sha256sum] = "e629a66d692cb9ff1a1c664e41771b3dcaf961985a9774c0eb0bd1b51cf60a48"
-SRC_URI[cargo-0.95.0.sha256sum] = "0af45a75a5265a587a8d9e4098cd2b12a07b34bcbd9eb7952ae6a62ea6d65c4d"
-SRC_URI[cargo-credential-0.4.9.sha256sum] = "e36f089041deadf16226478a7737a833864fbda09408c7af237b9d615eeb6d69"
-SRC_URI[cargo-credential-libsecret-0.5.5.sha256sum] = "e6f199366cecd4e86e3db8c16d4054ea3c53287250a18190929f74be26bb8642"
-SRC_URI[cargo-credential-macos-keychain-0.4.20.sha256sum] = "bf99df49467cac5cc000b9134f4faf9ecc54484462d314ce605ff6e19c523f90"
-SRC_URI[cargo-credential-wincred-0.4.20.sha256sum] = "9be5164881738c558a89fd0fd25cdda82a587dab6d2616e4a3ba0c9069a29c35"
-SRC_URI[cargo-platform-0.3.2.sha256sum] = "87a0c0e6148f11f01f32650a2ea02d532b2ad4e81d8bd41e6e565b5adc5e6082"
-SRC_URI[cargo-util-0.2.27.sha256sum] = "4a4b72539a4e322539ac3cd07d7e63d60ca3823f3143a2d39a9f8fcdace0e8ca"
-SRC_URI[cargo-util-schemas-0.12.0.sha256sum] = "74b5c24ba23f6d05b6cb15946d08bb6dd61b96ae920f17b33b17d4e7b1e76555"
+SRC_URI[cargo-0.96.0.sha256sum] = "4653299848aaa3c7c34a06a9c1f9248e1340f8d23aa2bd1681a131a070c1cd06"
+SRC_URI[cargo-credential-0.4.10.sha256sum] = "aa57675b822ecda7f0be12eedbfabd890066271eedc7f2c45ed41e86e0f327a8"
+SRC_URI[cargo-credential-libsecret-0.5.6.sha256sum] = "58a795e7ae9d07fe3943afa57a752a476d01532d4119ed375ac5f002aa2297bf"
+SRC_URI[cargo-credential-macos-keychain-0.4.21.sha256sum] = "9120b1181de67f8796928c41f56ee053b7983cfd0fa81ab59adf9e7c7110e674"
+SRC_URI[cargo-credential-wincred-0.4.21.sha256sum] = "5356aa9bee1f33e94f9b39779a7ba9999a9068dcb37055ef2eded869a1f5e03d"
+SRC_URI[cargo-platform-0.3.3.sha256sum] = "dd0061da739915fae12ea00e16397555ed4371a6bb285431aab930f61b0aa4ba"
+SRC_URI[cargo-util-0.2.28.sha256sum] = "a4162900cab52029d1e29a44ba98277ec9936948b8cefbd7a2269c990ac7d58a"
+SRC_URI[cargo-util-schemas-0.13.0.sha256sum] = "73d08f8ffc65abe86dffd3497839adee21cbe3f3b19c17987aa5267998adcf77"
 SRC_URI[cbindgen-0.29.2.sha256sum] = "befbfd072a8e81c02f8c507aefce431fe5e7d051f83d48a23ffc9b9fe5a11799"
-SRC_URI[cc-1.2.56.sha256sum] = "aebf35691d1bfb0ac386a69bac2fde4dd276fb618cf8bf4f5318fe285e821bb2"
+SRC_URI[cc-1.2.61.sha256sum] = "d16d90359e986641506914ba71350897565610e87ce0ad9e6f28569db3dd5c6d"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
 SRC_URI[cfg_aliases-0.2.1.sha256sum] = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
-SRC_URI[clap-4.5.60.sha256sum] = "2797f34da339ce31042b27d23607e051786132987f595b02ba4f6a6dffb7030a"
-SRC_URI[clap_builder-4.5.60.sha256sum] = "24a241312cea5059b13574bb9b3861cabf758b879c15190b37b6d6fd63ab6876"
-SRC_URI[clap_complete-4.5.66.sha256sum] = "c757a3b7e39161a4e56f9365141ada2a6c915a8622c408ab6bb4b5d047371031"
-SRC_URI[clap_derive-4.5.55.sha256sum] = "a92793da1a46a5f2a02a6f4c46c6496b28c43638adea8306fcb0caa1634f24e5"
-SRC_URI[clap_lex-1.0.0.sha256sum] = "3a822ea5bc7590f9d40f1ba12c0dc3c2760f3482c6984db1573ad11031420831"
+SRC_URI[clap-4.6.1.sha256sum] = "1ddb117e43bbf7dacf0a4190fef4d345b9bad68dfc649cb349e7d17d28428e51"
+SRC_URI[clap_builder-4.6.0.sha256sum] = "714a53001bf66416adb0e2ef5ac857140e7dc3a0c48fb28b2f10762fc4b5069f"
+SRC_URI[clap_complete-4.6.3.sha256sum] = "660c0520455b1013b9bcb0393d5f643d7e4454fb69c915b8d6d2aa0e9a45acc3"
+SRC_URI[clap_derive-4.6.1.sha256sum] = "f2ce8604710f6733aa641a2b3731eaa1e8b3d9973d5e3565da11800813f997a9"
+SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
 SRC_URI[clru-0.6.3.sha256sum] = "197fd99cb113a8d5d9b6376f3aa817f32c1078f2343b714fff7d2ca44fdf67d5"
 SRC_URI[color-print-0.3.7.sha256sum] = "3aa954171903797d5623e047d9ab69d91b493657917bdfb8c2c80ecaf9cdb6f4"
 SRC_URI[color-print-proc-macro-0.3.7.sha256sum] = "692186b5ebe54007e45a59aea47ece9eb4108e141326c304cdc91699a7118a22"
-SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
+SRC_URI[colorchoice-1.0.5.sha256sum] = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
 SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
 SRC_URI[constant_time_eq-0.4.2.sha256sum] = "3d52eff69cd5e647efe296129160853a42795992097e8af39800e1060caeea9b"
 SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crates-io-0.40.17.sha256sum] = "ec97b1f074b7b2fe478fb89e51a26e25a75ae2de02d4c8cc85c5f206dd628286"
+SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
+SRC_URI[crates-io-0.40.18.sha256sum] = "77ba15a8fb280fc0913c21098c1801c274da7852f0665684fbdf1fcc2dc97cb5"
 SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
 SRC_URI[crossbeam-channel-0.5.15.sha256sum] = "82b8f8f868b36967f9606790d1903570de9ceaf870a7bf9fbbd3016d636a2cb2"
 SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
@@ -484,7 +495,7 @@ SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
 SRC_URI[ct-codecs-1.1.6.sha256sum] = "9b10589d1a5e400d61f9f38f12f884cfd080ff345de8f17efda36fe0e4a02aa8"
 SRC_URI[curl-0.4.49.sha256sum] = "79fc3b6dd0b87ba36e565715bf9a2ced221311db47bd18011676f24a6066edbc"
-SRC_URI[curl-sys-0.4.85+curl-8.18.0.sha256sum] = "c0efa6142b5ecc05f6d3eaa39e6af4888b9d3939273fb592c92b7088a8cf3fdb"
+SRC_URI[curl-sys-0.4.83+curl-8.15.0.sha256sum] = "5830daf304027db10c82632a464879d46a3f7c4ba17a31592657ad16c719b483"
 SRC_URI[dashmap-6.1.0.sha256sum] = "5041cc499144891f3790297212f32a74fb938e5136a14943f338ef9e0ae276cf"
 SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
 SRC_URI[deranged-0.5.8.sha256sum] = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
@@ -503,7 +514,7 @@ SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
 SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
-SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
+SRC_URI[fastrand-2.4.1.sha256sum] = "9f1f227452a390804cdb637b74a86990f2a7d7ba4b7d5693aac9b4dd6defd8d6"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
 SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
 SRC_URI[filetime-0.2.27.sha256sum] = "f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
@@ -521,55 +532,56 @@ SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395
 SRC_URI[getrandom-0.4.2.sha256sum] = "0de51e6874e94e7bf76d726fc5d13ba782deca734ff60d5bb2fb2607c7406555"
 SRC_URI[git2-0.20.4.sha256sum] = "7b88256088d75a56f8ecfa070513a775dd9107f6530ef14919dac831af9cfe2b"
 SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
-SRC_URI[gix-0.77.0.sha256sum] = "3d8284d86a2f5c0987fbf7219a128815cc04af5a18f5fd7eec6a76d83c2b78cc"
-SRC_URI[gix-actor-0.37.1.sha256sum] = "c345528d405eab51d20f505f5fe1a4680973953694e0292c6bbe97827daa55c4"
-SRC_URI[gix-attributes-0.29.0.sha256sum] = "f47dabf8a50f1558c3a55d978440c7c4f22f87ac897bef03b4edbc96f6115966"
+SRC_URI[gix-0.79.0.sha256sum] = "c66adef5e4d836ad08bf424dce5e3eb18f51544eee702860419295120dd48811"
+SRC_URI[gix-actor-0.39.0.sha256sum] = "0c44f13049925e8dc3955c20ecec5391cedfb041e0952416b583ecc57bc68325"
+SRC_URI[gix-attributes-0.30.1.sha256sum] = "9e72da5a1c35c9a129be0c60ab9968779981ca50835dd98650ecd8b0ea4d721e"
 SRC_URI[gix-bitmap-0.2.16.sha256sum] = "d982fc7ef0608e669851d0d2a6141dae74c60d5a27e8daa451f2a4857bbf41e2"
-SRC_URI[gix-chunk-0.4.12.sha256sum] = "5c356b3825677cb6ff579551bb8311a81821e184453cbd105e2fc5311b288eeb"
-SRC_URI[gix-command-0.6.5.sha256sum] = "46f9c425730a654835351e6da8c3c69ba1804f8b8d4e96d027254151138d5c64"
-SRC_URI[gix-commitgraph-0.31.0.sha256sum] = "efdcba8048045baf15225daf949d597c3e6183d130245e22a7fbd27084abe63a"
-SRC_URI[gix-config-0.50.0.sha256sum] = "b58e2ff8eef96b71f2c5e260f02ca0475caff374027c5cc5a29bda69fac67404"
-SRC_URI[gix-config-value-0.16.0.sha256sum] = "2409cffa4fe8b303847d5b6ba8df9da9ba65d302fc5ee474ea0cac5afde79840"
-SRC_URI[gix-credentials-0.34.1.sha256sum] = "316a12842fb761a7a6e9ae963d7bae9f0f4c433f242282df91192ef084b1891c"
-SRC_URI[gix-date-0.12.1.sha256sum] = "fe4a31bab8159e233094fa70d2e5fd3ec6f19e593f67e6ae01281daa48f8d8e7"
-SRC_URI[gix-diff-0.57.1.sha256sum] = "3506936e63ce14cd54b5f28ed06c8e43b92ef9f41c2238cc0bc271a9259b4e90"
-SRC_URI[gix-dir-0.19.0.sha256sum] = "709d9fad32d2eb8b0129850874246569e801b6d5877e0c41356c23e9e2501e06"
-SRC_URI[gix-discover-0.45.0.sha256sum] = "42ce096dc132533802a09d6fd5d4008858f2038341dfe2e69e0d0239edb359de"
-SRC_URI[gix-features-0.45.2.sha256sum] = "d56aad357ae016449434705033df644ac6253dfcf1281aad3af3af9e907560d1"
-SRC_URI[gix-filter-0.24.1.sha256sum] = "10c02464962482570c1f94ad451a608c4391514f803e8074662d02c5629a25dc"
-SRC_URI[gix-fs-0.18.2.sha256sum] = "785b9c499e46bc78d7b81c148c21b3fca18655379ee729a856ed19ce50d359ec"
-SRC_URI[gix-glob-0.23.0.sha256sum] = "e8546300aee4c65c5862c22a3e321124a69b654a61a8b60de546a9284812b7e2"
-SRC_URI[gix-hash-0.21.2.sha256sum] = "e153930f42ccdab8a3306b1027cd524879f6a8996cd0c474d18b0e56cae7714d"
-SRC_URI[gix-hashtable-0.11.0.sha256sum] = "222f7428636020bef272a87ed833ea48bf5fb3193f99852ae16fbb5a602bd2f0"
-SRC_URI[gix-ignore-0.18.0.sha256sum] = "dfa727fdf54fd9fb53fa3fbb1a5c17172d3073e8e336bf155f3cac3e25b81b21"
-SRC_URI[gix-index-0.45.1.sha256sum] = "9ea6d3e9e11647ba49f441dea0782494cc6d2875ff43fa4ad9094e6957f42051"
-SRC_URI[gix-lock-20.0.1.sha256sum] = "115268ae5e3b3b7bc7fc77260eecee05acca458e45318ca45d35467fa81a3ac5"
-SRC_URI[gix-negotiate-0.25.0.sha256sum] = "f3cee7e32e6198e356caef0e4b8321bc2f9b2afeb76f870c0bf9aa05fe53edb6"
-SRC_URI[gix-object-0.54.1.sha256sum] = "363d6a879c52e4890180e0ffa7d8c9a364fd0b7e807caa368e860b80e8d0bc81"
-SRC_URI[gix-odb-0.74.0.sha256sum] = "165a907df369a12ed4330faf8baf7ae597aadb08cfacb4ed8649f93d90bcc0c5"
-SRC_URI[gix-pack-0.64.1.sha256sum] = "b04a73d5ab07ea0faae55e2c0ae6f24e36e365ac8ce140394dee3a2c89cd4366"
-SRC_URI[gix-packetline-0.20.0.sha256sum] = "fad0ffb982a289888087a165d3e849cbac724f2aa5431236b050dd2cb9c7de31"
-SRC_URI[gix-path-0.10.22.sha256sum] = "7cb06c3e4f8eed6e24fd915fa93145e28a511f4ea0e768bae16673e05ed3f366"
-SRC_URI[gix-pathspec-0.14.0.sha256sum] = "ed9e0c881933c37a7ef45288d6c5779c4a7b3ad240b4c37657e1d9829eb90085"
-SRC_URI[gix-prompt-0.12.0.sha256sum] = "974b142ea650fb0050a301958f49c8cc68929c36f686e9606a381ce39da34fd9"
-SRC_URI[gix-protocol-0.55.0.sha256sum] = "02c5dfd068789442c5709e702ef42d851765f2c09a11bf0a13749d24363f4d07"
+SRC_URI[gix-chunk-0.6.0.sha256sum] = "d14ee09ab454481a91fe969ca5afbd41c8a9b05680197b6554ebb69bdcf7d571"
+SRC_URI[gix-command-0.7.1.sha256sum] = "2962172c6f78731e2b7773bf762f7b8d1746a342a4c0a8914a612206e1295953"
+SRC_URI[gix-commitgraph-0.33.0.sha256sum] = "f9dc2a550978b510b4e58b0bf5a15481433c3b21981330f3898d93f25b07d9a5"
+SRC_URI[gix-config-0.52.0.sha256sum] = "db778c8703f3c7f687e03ce22ac8f6eac02adbdafae4cb19d541126fa012524f"
+SRC_URI[gix-config-value-0.17.2.sha256sum] = "4378c53ec3db049919edf91ff76f56f28886a8b4b4a5a9dc633108d84afc3675"
+SRC_URI[gix-credentials-0.36.0.sha256sum] = "64b5ef8d1d86b9598df695fd61989e535dc7d139040ed9f31944bc7dcd81b713"
+SRC_URI[gix-date-0.14.0.sha256sum] = "e66a5117b22495fe7cb4b443777cf3f024a1b1db0009771db440fc8b38a0a6fd"
+SRC_URI[gix-diff-0.59.0.sha256sum] = "ebee256b21a7d46cec85ab84e824742142a23a21111556a5e50c15796110c6c6"
+SRC_URI[gix-dir-0.21.0.sha256sum] = "88897d9c3ea961d4b9a1addc466767c127b1f25713d3e054ea32ef02ab7c5db8"
+SRC_URI[gix-discover-0.47.0.sha256sum] = "93103d88576e048a681ebee83e93162972cd4cbce1485a6137cfc98fc0ba152d"
+SRC_URI[gix-error-0.1.0.sha256sum] = "92e37b10e97c822fc17550fc1a187283ad3ce79617e920bf179f301ee12abcbc"
+SRC_URI[gix-features-0.46.2.sha256sum] = "752493cd4b1d5eaaa0138a7493f65c96863fefa990fc021e0e519579e389ab20"
+SRC_URI[gix-filter-0.26.0.sha256sum] = "094253121df9aa1cb46d1da0200dd63ebf16263a35f03295109978bf7ed2b483"
+SRC_URI[gix-fs-0.19.2.sha256sum] = "a964b4aec683eb0bacb87533defa80805bb4768056371a47ab38b00a2d377b72"
+SRC_URI[gix-glob-0.24.0.sha256sum] = "b03e6cd88cc0dc1eafa1fddac0fb719e4e74b6ea58dd016e71125fde4a326bee"
+SRC_URI[gix-hash-0.22.1.sha256sum] = "d8ced05d2d7b13bff08b2f7eb4e47cfeaf00b974c2ddce08377c4fe1f706b3eb"
+SRC_URI[gix-hashtable-0.12.0.sha256sum] = "52f1eecdd006390cbed81f105417dbf82a6fe40842022006550f2e32484101da"
+SRC_URI[gix-ignore-0.19.1.sha256sum] = "09f915dcf6911e3027537166d34e13f0fe101ed12225178d2ae29cd1272cff26"
+SRC_URI[gix-index-0.47.0.sha256sum] = "ea450ed666a39676d7e9a41b899487d1645d88053bc8c8cecfca0cf96fcd4a03"
+SRC_URI[gix-lock-21.0.2.sha256sum] = "054fbd0989700c69dc5aa80bc66944f05df1e15aa7391a9e42aca7366337905f"
+SRC_URI[gix-negotiate-0.27.0.sha256sum] = "68d01c3303ed336b72eb3a48543c028be4650279ff3c3b561f13fa9d2b1979e7"
+SRC_URI[gix-object-0.56.0.sha256sum] = "227e12fad42022ff08d6fbcc4bae34d6e2aa180576e9e1106d9a29a06798e750"
+SRC_URI[gix-odb-0.76.0.sha256sum] = "e84f7e115b2b6615f0c5acddc269598ebc539c363fb276dbd242755a1dd7126c"
+SRC_URI[gix-pack-0.66.0.sha256sum] = "dfc20b54d50f64fb02281f2a6c4a24bb9356befdf4535d5a68924575fd67cd5e"
+SRC_URI[gix-packetline-0.21.3.sha256sum] = "362246df440ee691699f0664cbf7006a6ece477db6734222be95e4198e5656e6"
+SRC_URI[gix-path-0.11.3.sha256sum] = "c8fd1fe596dc393b538e1d5492c5585971a9311475b3255f7b889023df208476"
+SRC_URI[gix-pathspec-0.15.1.sha256sum] = "c7f4cc23f55ca7c190bf243f1a4e2139d4522022f724fb0dfc06c93f65a01ef6"
+SRC_URI[gix-prompt-0.13.1.sha256sum] = "4806f1ebf969cd54d178ccd975911ef1829aeccea0b27630e63c9d26c8347d7f"
+SRC_URI[gix-protocol-0.57.0.sha256sum] = "a13680c03e847d8f32a59cf1511dd05334d429da33f5af08891367680f15cbca"
 SRC_URI[gix-quote-0.6.2.sha256sum] = "96fc2ff2ec8cc0c92807f02eab1f00eb02619fc2810d13dc42679492fcc36757"
-SRC_URI[gix-ref-0.57.0.sha256sum] = "ccb33aa97006e37e9e83fde233569a66b02ed16fd4b0406cdf35834b06cf8a63"
-SRC_URI[gix-refspec-0.35.0.sha256sum] = "dcbba6ae5389f4021f73a2d62a4195aace7db1e8bb684b25521d3d685f57da02"
-SRC_URI[gix-revision-0.39.0.sha256sum] = "91898c83b18c635696f7355d171cfa74a52f38022ff89581f567768935ebc4c8"
-SRC_URI[gix-revwalk-0.25.0.sha256sum] = "0d063699278485016863d0d2bb0db7609fd2e8ba9a89379717bf06fd96949eb2"
-SRC_URI[gix-sec-0.12.2.sha256sum] = "ea9962ed6d9114f7f100efe038752f41283c225bb507a2888903ac593dffa6be"
-SRC_URI[gix-shallow-0.7.0.sha256sum] = "9c1c467fb9f7ec1d33613c2ea5482de514bcb84b8222a793cdc4c71955832356"
-SRC_URI[gix-status-0.24.0.sha256sum] = "ed0d94c685a831c679ca5454c22f350e8c233f50dcf377ca00d858bcba9696d2"
-SRC_URI[gix-submodule-0.24.0.sha256sum] = "efee2a61198413d80de10028aa507344537827d776ade781760130721bec2419"
-SRC_URI[gix-tempfile-20.0.1.sha256sum] = "ad89218e74850f42d364ed3877c7291f0474c8533502df91bb877ecc5cb0dd40"
-SRC_URI[gix-trace-0.1.18.sha256sum] = "f69a13643b8437d4ca6845e08143e847a36ca82903eed13303475d0ae8b162e0"
-SRC_URI[gix-transport-0.52.1.sha256sum] = "a4d4ed02a2ebe771a26111896ecda0b98b58ed35e1d9c0ccf07251c1abb4918d"
-SRC_URI[gix-traverse-0.51.1.sha256sum] = "d052b83d1d1744be95ac6448ac02f95f370a8f6720e466be9ce57146e39f5280"
-SRC_URI[gix-url-0.34.0.sha256sum] = "cff1996dfb9430b3699d89224c674169c1ae355eacc52bf30a03c0b8bffe73d9"
-SRC_URI[gix-utils-0.3.1.sha256sum] = "befcdbdfb1238d2854591f760a48711bed85e72d80a10e8f2f93f656746ef7c5"
-SRC_URI[gix-validate-0.10.1.sha256sum] = "5b1e63a5b516e970a594f870ed4571a8fdcb8a344e7bd407a20db8bd61dbfde4"
-SRC_URI[gix-worktree-0.46.0.sha256sum] = "1cfb7ce8cdbfe06117d335d1ad329351468d20331e0aafd108ceb647c1326aca"
+SRC_URI[gix-ref-0.59.0.sha256sum] = "c92fd2e86d65efe972a5226f303ed72cfb49a8ad03740e5cc2b27c07970a5d78"
+SRC_URI[gix-refspec-0.37.0.sha256sum] = "40adba15f8099159d37d0a21e1cfb6602c2e49b6c05f6f8a57a47d0fb21611af"
+SRC_URI[gix-revision-0.41.0.sha256sum] = "a75ef94c9d76de0765e429ae22a01c512c0d50459269195a90ea11099a5fc752"
+SRC_URI[gix-revwalk-0.27.0.sha256sum] = "07efcad1d064abdac3e79dfc6e23e05accb579559d015e944c9dcf64be95eb49"
+SRC_URI[gix-sec-0.13.3.sha256sum] = "283f4a746c9bde8550be63e6f961ff4651f412ca12666e8f5615f39464960ab9"
+SRC_URI[gix-shallow-0.8.1.sha256sum] = "189386b5da5285216cc0ede89eff5a943d5261fc794241ee6ec5360b77df15ad"
+SRC_URI[gix-status-0.26.0.sha256sum] = "a441e06bff4a4f86ac0b320424193b061ee9c0578448eb9b965fbc96454ca292"
+SRC_URI[gix-submodule-0.26.0.sha256sum] = "ac5d38afa855046b7b9e2b85f8cdf7fbf2e449ed061dc81fa7a757abaa38bfac"
+SRC_URI[gix-tempfile-21.0.2.sha256sum] = "d22227f6b203f511ff451c33c89899e87e4f571fc596b06f68e6e613a6508528"
+SRC_URI[gix-trace-0.1.19.sha256sum] = "6f23569e55f2ffaf958617353b9734a7d52a7c19c439eeaa5e3efc217fd2270e"
+SRC_URI[gix-transport-0.54.0.sha256sum] = "9561a98f4f1cada03b565121c475c95d060998082bdb1277044fa6e11fe2aa17"
+SRC_URI[gix-traverse-0.53.0.sha256sum] = "bcdd399f8527f643f8d4fd8de6ec3b6e2c3c826b758b68e90f28275af2e7b33a"
+SRC_URI[gix-url-0.35.3.sha256sum] = "1a61ead12e33fa52ae92b207ee27554f646a8e7a3dad8b78da1582ec91eda0a6"
+SRC_URI[gix-utils-0.3.2.sha256sum] = "4e477b4f07a6e8da4ba791c53c858102959703c60d70f199932010d5b94adb2c"
+SRC_URI[gix-validate-0.11.1.sha256sum] = "e26ac2602b43eadfdca0560b81d3341944162a3c9f64ccdeef8fc501ad80dad5"
+SRC_URI[gix-worktree-0.48.0.sha256sum] = "93381c5cd37fa208e3f454433425985ea02725369fb33a79ff4ecf7c279f2f98"
 SRC_URI[glob-0.3.3.sha256sum] = "0cc23270f6e1808e30a928bdc84dea0b9b4136a8bc82338574f23baf47bbd280"
 SRC_URI[globset-0.4.18.sha256sum] = "52dfc19153a48bde0cbd630453615c8151bce3a5adfac7a0aebfbf0a1e1f57e3"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
@@ -577,6 +589,7 @@ SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e9
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
 SRC_URI[hashbrown-0.15.5.sha256sum] = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
 SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
+SRC_URI[hashbrown-0.17.0.sha256sum] = "4f467dd6dccf739c208452f8014c75c18bb8301b050ad1cfb27153803edb0f51"
 SRC_URI[hashlink-0.11.0.sha256sum] = "ea0b22561a9c04a7cb1a302c013e0259cd3b4bb619f145b32f72b8b4bcbed230"
 SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
@@ -585,44 +598,44 @@ SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a382
 SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
 SRC_URI[home-0.5.12.sha256sum] = "cc627f471c528ff0c4a49e1d5e60450c8f6461dd6d10ba9dcd3a61d3dff7728d"
 SRC_URI[http-auth-0.1.10.sha256sum] = "150fa4a9462ef926824cf4519c84ed652ca8f4fbae34cb8af045b5cbcaf98822"
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
 SRC_URI[id-arena-2.3.0.sha256sum] = "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
-SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
+SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
 SRC_URI[ignore-0.4.25.sha256sum] = "d3d782a365a015e0f5c04902246139249abf769125006fbe7649e2ee88169b4a"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[imara-diff-0.1.8.sha256sum] = "17d34b7d42178945f775e84bc4c36dde7c1c6cdfea656d3354d009056f2bb3d2"
-SRC_URI[implib-0.4.0.sha256sum] = "7923c255262a0e44362e221f8b74b931fe21484b83f27386aa45f021a379caf6"
-SRC_URI[indexmap-2.13.0.sha256sum] = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
+SRC_URI[implib-0.6.0.sha256sum] = "96e1090e37c7188a99a2353115083505ff6a489e86637dc41e1671457b1259d3"
+SRC_URI[indexmap-2.14.0.sha256sum] = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
 SRC_URI[is_executable-1.0.5.sha256sum] = "baabb8b4867b26294d818bf3f651a454b6901431711abb96e296245888d6e8c4"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
-SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
-SRC_URI[jiff-0.2.23.sha256sum] = "1a3546dc96b6d42c5f24902af9e2538e82e39ad350b0c766eb3fbf2d8f3d8359"
-SRC_URI[jiff-static-0.2.23.sha256sum] = "2a8c8b344124222efd714b73bb41f8b5120b27a7cc1c75593a6ff768d9d05aa4"
+SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
+SRC_URI[jiff-0.2.24.sha256sum] = "f00b5dbd620d61dfdcb6007c9c1f6054ebd75319f163d886a9055cec1155073d"
+SRC_URI[jiff-static-0.2.24.sha256sum] = "e000de030ff8022ea1da3f466fbb0f3a809f5e51ed31f6dd931c35181ad8e6d7"
 SRC_URI[jiff-tzdb-0.1.6.sha256sum] = "c900ef84826f1338a557697dc8fc601df9ca9af4ac137c7fb61d4c6f2dfd3076"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.34.sha256sum] = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
-SRC_URI[js-sys-0.3.91.sha256sum] = "b49715b7073f385ba4bc528e5747d02e66cb39c6146efb66b781f131f0fb399c"
+SRC_URI[js-sys-0.3.97.sha256sum] = "a1840c94c045fbcf8ba2812c95db44499f7c64910a912551aaaa541decebcacf"
 SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
 SRC_URI[leb128fmt-0.1.0.sha256sum] = "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
-SRC_URI[libc-0.2.182.sha256sum] = "6800badb6cb2082ffd7b6a67e6125bb39f18782f793520caee8cb8846be06112"
+SRC_URI[libc-0.2.186.sha256sum] = "68ab91017fe16c622486840e4c83c9a37afeff978bd239b5293d61ece587de66"
 SRC_URI[libgit2-sys-0.18.3+1.9.2.sha256sum] = "c9b3acc4b91781bb0b3386669d325163746af5f6e4f73e6d2d630e09a35f3487"
 SRC_URI[libloading-0.9.0.sha256sum] = "754ca22de805bb5744484a5b151a9e1a8e837d5dc232c2d7d8c2e3492edc8b60"
-SRC_URI[libnghttp2-sys-0.1.12+1.68.0.sha256sum] = "31d4c51112b381b39a072a6010bc5d3e5557996c5d0150abacd1d349b2636299"
-SRC_URI[libredox-0.1.14.sha256sum] = "1744e39d1d6a9948f4f388969627434e31128196de472883b39f148769bfe30a"
+SRC_URI[libnghttp2-sys-0.1.13+1.68.1.sha256sum] = "492e00167f1418c15648144f42bbfc63099806ecee9bf8d09a6353d6b4856b3c"
+SRC_URI[libredox-0.1.16.sha256sum] = "e02f3bb43d335493c96bf3fd3a321600bf6bd07ed34bc64118e9293bdffea46c"
 SRC_URI[libsqlite3-sys-0.36.0.sha256sum] = "95b4103cffefa72eb8428cb6b47d6627161e51c2739fc5e3b734584157bc642a"
 SRC_URI[libssh2-sys-0.3.1.sha256sum] = "220e4f05ad4a218192533b300327f5150e809b54c4ec83b5a1d91833601811b9"
-SRC_URI[libz-sys-1.1.24.sha256sum] = "4735e9cbde5aac84a5ce588f6b23a90b9b0b528f6c5a8db8a4aff300463a0839"
+SRC_URI[libz-sys-1.1.28.sha256sum] = "fc3a226e576f50782b3305c5ccf458698f92798987f551c6a02efe8276721e22"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
-SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
+SRC_URI[litemap-0.8.2.sha256sum] = "92daf443525c4cce67b150400bc2316076100ce0b3686209eb8cf3c31612e6f0"
 SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
 SRC_URI[log-0.4.29.sha256sum] = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
 SRC_URI[matchers-0.2.0.sha256sum] = "d1525a2a28c7f4fa0fc98bb91ae755d1e2d1505079e05539e35bc876b5d65ae9"
@@ -637,7 +650,7 @@ SRC_URI[nix-0.30.1.sha256sum] = "74523f3a35e05aba87a1d978330aef40f67b0304ac79c1c
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normpath-1.5.0.sha256sum] = "bf23ab2b905654b4cb177e30b629937b3868311d4e1cba859f899c041046e69b"
 SRC_URI[nu-ansi-term-0.50.3.sha256sum] = "7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5"
-SRC_URI[num-conv-0.2.0.sha256sum] = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
+SRC_URI[num-conv-0.2.1.sha256sum] = "c6673768db2d862beb9b39a78fdcb1a69439615d5794a1be50caa9bc92c81967"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[objc2-0.6.4.sha256sum] = "3a12a8ed07aefc768292f076dc3ac8c48f3781c8f2d5851dd3d98950e8c5a89f"
 SRC_URI[objc2-cloud-kit-0.3.2.sha256sum] = "73ad74d880bb43877038da939b7427bba67e9dd42004a18b809ba7d87cee241c"
@@ -654,17 +667,17 @@ SRC_URI[objc2-quartz-core-0.3.2.sha256sum] = "96c1358452b371bf9f104e21ec536d37a6
 SRC_URI[objc2-ui-kit-0.3.2.sha256sum] = "d87d638e33c06f577498cbcc50491496a3ed4246998a7fbba7ccb98b1e7eab22"
 SRC_URI[objc2-user-notifications-0.3.2.sha256sum] = "9df9128cbbfef73cda168416ccf7f837b62737d748333bfe9ab71c245d76613e"
 SRC_URI[object-0.37.3.sha256sum] = "ff76201f031d8863c38aa7f905eca4f53abbfa15f609db4277d44cd8938f33fe"
-SRC_URI[object-0.38.1.sha256sum] = "271638cd5fa9cca89c4c304675ca658efc4e64a66c716b7cfe1afb4b9611dbbc"
-SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
+SRC_URI[object-0.39.1.sha256sum] = "2e5a6c098c7a3b6547378093f5cc30bc54fd361ce711e05293a5cc589562739b"
+SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[opener-0.8.4.sha256sum] = "a2fa337e0cf13357c13ef1dc108df1333eb192f75fc170bea03fcf1fd404c2ee"
-SRC_URI[openssl-0.10.75.sha256sum] = "08838db121398ad17ab8531ce9de97b244589089e290a384c900cb9ff7434328"
+SRC_URI[openssl-0.10.78.sha256sum] = "f38c4372413cdaaf3cc79dd92d29d7d9f5ab09b51b10dded508fb90bb70b9222"
 SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
 SRC_URI[openssl-probe-0.1.6.sha256sum] = "d05e27ee213611ffe7d6348b942e8f942b37114c00cc03cec254295a4a17852e"
-SRC_URI[openssl-src-300.5.5+3.5.5.sha256sum] = "3f1787d533e03597a7934fd0a765f0d28e94ecc5fb7789f8053b1e699a56f709"
-SRC_URI[openssl-sys-0.9.111.sha256sum] = "82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
+SRC_URI[openssl-src-300.6.0+3.6.2.sha256sum] = "a8e8cbfd3a4a8c8f089147fd7aaa33cf8c7450c4d09f8f80698a0cf093abeff4"
+SRC_URI[openssl-sys-0.9.114.sha256sum] = "13ce1245cd07fcc4cfdb438f7507b0c7e4f3849a69fd84d52374c66d83741bb6"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
-SRC_URI[orion-0.17.13.sha256sum] = "58fa7b8bd24f9f1b7fa56de934075adba4b6fb1bf0bf38db74f4236e05e14776"
+SRC_URI[orion-0.17.14.sha256sum] = "3b78afeb2bca97d4d834c3ad8df676b5c312af28c06a58a656e516422df1f1e5"
 SRC_URI[os_info-3.14.0.sha256sum] = "e4022a17595a00d6a369236fdae483f0de7f0a339960a53118b818238e132224"
 SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
@@ -675,45 +688,45 @@ SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae59434
 SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
 SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
-SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+SRC_URI[pkg-config-0.3.33.sha256sum] = "19f132c84eca552bf34cab8ec81f1c1dcc229b811638f9d283dceabe58c5569e"
 SRC_URI[plain-0.2.3.sha256sum] = "b4596b6d070b27117e987119b4dac604f3c58cfb0b191112e24771b2faeac1a6"
 SRC_URI[portable-atomic-1.13.1.sha256sum] = "c33a9471896f1c69cecef8d20cbe2f7accd12527ce60845ff44c153bb2a21b49"
-SRC_URI[portable-atomic-util-0.2.5.sha256sum] = "7a9db96d7fa8782dd8c15ce32ffe8680bbd1e978a43bf51a34d39483540495f5"
-SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
+SRC_URI[portable-atomic-util-0.2.7.sha256sum] = "c2a106d1259c23fac8e543272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
+SRC_URI[potential_utf-0.1.5.sha256sum] = "0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[prettyplease-0.2.37.sha256sum] = "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
 SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
-SRC_URI[prodash-30.0.1.sha256sum] = "5a6efc566849d3d9d737c5cb06cc50e48950ebe3d3f9d70631490fff3a07b139"
+SRC_URI[prodash-31.0.0.sha256sum] = "962200e2d7d551451297d9fdce85138374019ada198e30ea9ede38034e27604c"
 SRC_URI[quote-1.0.45.sha256sum] = "41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
-SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
+SRC_URI[rand-0.9.4.sha256sum] = "44c5af06bb1b7d3216d91932aed5265164bf384dc89cd6ba05cf59a35f5f76ea"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
 SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
-SRC_URI[redox_syscall-0.7.3.sha256sum] = "6ce70a74e890531977d37e532c34d45e9055d2409ed08ddba14529471ed0be16"
+SRC_URI[redox_syscall-0.7.4.sha256sum] = "f450ad9c3b1da563fb6948a8e0fb0fb9269711c9c73d9ea1de5058c79c8d643a"
 SRC_URI[regex-1.12.3.sha256sum] = "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
 SRC_URI[regex-automata-0.4.14.sha256sum] = "6e1dd4122fc1595e8162618945476892eefca7b88c52820e74af6262213cae8f"
 SRC_URI[regex-syntax-0.8.10.sha256sum] = "dc897dd8d9e8bd1ed8cdad82b5966c3e0ecae09fb1907d58efaa013543185d0a"
 SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
 SRC_URI[rsqlite-vfs-0.1.0.sha256sum] = "a8a1f2315036ef6b1fbacd1972e8ee7688030b0a2121edfc2a6550febd41574d"
 SRC_URI[rusqlite-0.38.0.sha256sum] = "f1c93dd1c9683b438c392c492109cb702b8090b2bfc8fed6f6e4eb4523f17af3"
-SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
+SRC_URI[rustc-hash-2.1.2.sha256sum] = "94300abf3f1ae2e2b8ffb7b58043de3d399c73fa6f4b73826402a5c457614dbe"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
-SRC_URI[rustfix-0.9.4.sha256sum] = "864792a841a1d785ba91b8d2a75e1936b40bc517020c3c2958ac403b92e4f00a"
+SRC_URI[rustfix-0.9.5.sha256sum] = "6b2be8b3fffc5dc9216f4044289ae4b74f6634d89f65df2ca7814e0add852495"
 SRC_URI[rustix-1.1.4.sha256sum] = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
 SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
-SRC_URI[schannel-0.1.28.sha256sum] = "891d81b926048e76efe18581bf793546b4c0eaf8448d72be8de2bbee5fd166e1"
+SRC_URI[schannel-0.1.29.sha256sum] = "91c1b7e4904c873ef0710c1f407dde2e6287de2bebc1bbbf7d430bb7cbffd939"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
 SRC_URI[security-framework-3.7.0.sha256sum] = "b7f4bc775c73d9a02cde8bf7b2ec4c9d12743edf609006c7facc23998404cd1d"
 SRC_URI[security-framework-sys-2.17.0.sha256sum] = "6ce2691df843ecc5d231c0b14ece2acc3efb62c0a398c7e1d875f3983ce020e3"
-SRC_URI[semver-1.0.27.sha256sum] = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
+SRC_URI[semver-1.0.28.sha256sum] = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
 SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
 SRC_URI[serde-untagged-0.1.9.sha256sum] = "f9faf48a4a2d2693be24c6289dbe26552776eb7737074e6722891fadbe6c5058"
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
@@ -721,7 +734,7 @@ SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852
 SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
 SRC_URI[serde_ignored-0.1.14.sha256sum] = "115dffd5f3853e06e746965a20dcbae6ee747ae30b543d91b0e089668bb07798"
 SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
-SRC_URI[serde_spanned-1.0.4.sha256sum] = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
+SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
 SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
 SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832b03984598375bff3975b804423"
 SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
@@ -730,12 +743,12 @@ SRC_URI[shell-escape-0.1.5.sha256sum] = "45bb67a18fa91266cc7807181f62f9178a6873b
 SRC_URI[shell-words-1.1.1.sha256sum] = "dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
 SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
 SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
-SRC_URI[simd-adler32-0.3.8.sha256sum] = "e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
+SRC_URI[simd-adler32-0.3.9.sha256sum] = "703d5c7ef118737c72f1af64ad2f6f8c5e1921f818cdcb97b8fe6fc69bf66214"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
-SRC_URI[socket2-0.6.2.sha256sum] = "86f4aa3ad99f2088c990dfa82d367e19cb29268ed67c574d10d0a4bfe71f07e0"
+SRC_URI[socket2-0.6.3.sha256sum] = "3a766e1110788c36f4fa1c2b71b387a7815aa65f88ce0229841826633d93723e"
 SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
-SRC_URI[sqlite-wasm-rs-0.5.2.sha256sum] = "2f4206ed3a67690b9c29b77d728f6acc3ce78f16bf846d83c94f76400320181b"
+SRC_URI[sqlite-wasm-rs-0.5.3.sha256sum] = "1b2c760607300407ddeaee518acf28c795661b7108c75421303dbefb237d3a36"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
@@ -744,31 +757,31 @@ SRC_URI[supports-hyperlinks-3.2.0.sha256sum] = "e396b6523b11ccb83120b115a0b7366d
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
 SRC_URI[syn-2.0.117.sha256sum] = "e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
-SRC_URI[tar-0.4.44.sha256sum] = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
-SRC_URI[tempfile-3.26.0.sha256sum] = "82a72c767771b47409d2345987fda8628641887d5466101319899796367354a0"
-SRC_URI[terminal_size-0.4.3.sha256sum] = "60b8cb979cb11c32ce1603f8137b22262a9d131aaa5c37b5678025f22b8becd0"
+SRC_URI[tar-0.4.45.sha256sum] = "22692a6476a21fa75fdfc11d452fda482af402c008cdbaf3476414e122040973"
+SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
+SRC_URI[terminal_size-0.4.4.sha256sum] = "230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
 SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
 SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
 SRC_URI[thread_local-1.1.9.sha256sum] = "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
 SRC_URI[time-0.3.47.sha256sum] = "743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
 SRC_URI[time-core-0.1.8.sha256sum] = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
 SRC_URI[time-macros-0.2.27.sha256sum] = "2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
-SRC_URI[tinystr-0.8.2.sha256sum] = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
-SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
+SRC_URI[tinystr-0.8.3.sha256sum] = "c8323304221c2a851516f22236c5722a72eaa19749016521d6dff0824447d96d"
+SRC_URI[tinyvec-1.11.0.sha256sum] = "3e61e67053d25a4e82c844e8424039d9745781b3fc4f32b8d55ed50f5f667ef3"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
 SRC_URI[toml-0.9.12+spec-1.1.0.sha256sum] = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
 SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
 SRC_URI[toml_edit-0.24.1+spec-1.1.0.sha256sum] = "01f2eadbbc6b377a847be05f60791ef1058d9f696ecb51d2c07fe911d8569d8e"
-SRC_URI[toml_parser-1.0.9+spec-1.1.0.sha256sum] = "702d4415e08923e7e1ef96cd5727c0dfed80b4d2fa25db9647fe5eb6f7c5a4c4"
-SRC_URI[toml_writer-1.0.6+spec-1.1.0.sha256sum] = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
+SRC_URI[toml_parser-1.1.2+spec-1.1.0.sha256sum] = "a2abe9b86193656635d2411dc43050282ca48aa31c2451210f4202550afb7526"
+SRC_URI[toml_writer-1.1.1+spec-1.1.0.sha256sum] = "756daf9b1013ebe47a8776667b466417e2d4c5679d441c26230efd9ef78692db"
 SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
 SRC_URI[tracing-attributes-0.1.31.sha256sum] = "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
 SRC_URI[tracing-core-0.1.36.sha256sum] = "db97caf9d906fbde555dd62fa95ddba9eecfd14cb388e4f491a66d74cd5fb79a"
 SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
-SRC_URI[tracing-subscriber-0.3.22.sha256sum] = "2f30143827ddab0d256fd843b7a66d164e9f271cfa0dde49142c5ca0ca291f1e"
+SRC_URI[tracing-subscriber-0.3.23.sha256sum] = "cb7f578e5945fb242538965c2d0b04418d38ec25c79d160cd279bf0731c8d319"
 SRC_URI[typeid-1.0.3.sha256sum] = "bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
-SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
+SRC_URI[typenum-1.20.0.sha256sum] = "40ce102ab67701b8526c123c1bab5cbe42d7040ccfd0f64af1a385808d2f43de"
 SRC_URI[unicase-2.9.0.sha256sum] = "dbc4bc3a9f746d862c45cb89d705aa10f187bb96c76001afab07a0d35ce60142"
 SRC_URI[unicode-bom-2.0.3.sha256sum] = "7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
 SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
@@ -783,12 +796,12 @@ SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb82
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
-SRC_URI[wasip2-1.0.2+wasi-0.2.9.sha256sum] = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
+SRC_URI[wasip2-1.0.3+wasi-0.2.9.sha256sum] = "20064672db26d7cdc89c7798c48a0fdfac8213434a1186e5ef29fd560ae223d6"
 SRC_URI[wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.sha256sum] = "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
-SRC_URI[wasm-bindgen-0.2.114.sha256sum] = "6532f9a5c1ece3798cb1c2cfdba640b9b3ba884f5db45973a6f442510a87d38e"
-SRC_URI[wasm-bindgen-macro-0.2.114.sha256sum] = "18a2d50fcf105fb33bb15f00e7a77b772945a2ee45dcf454961fd843e74c18e6"
-SRC_URI[wasm-bindgen-macro-support-0.2.114.sha256sum] = "03ce4caeaac547cdf713d280eda22a730824dd11e6b8c3ca9e42247b25c631e3"
-SRC_URI[wasm-bindgen-shared-0.2.114.sha256sum] = "75a326b8c223ee17883a4251907455a2431acc2791c98c26279376490c378c16"
+SRC_URI[wasm-bindgen-0.2.120.sha256sum] = "df52b6d9b87e0c74c9edfa1eb2d9bf85e5d63515474513aa50fa181b3c4f5db1"
+SRC_URI[wasm-bindgen-macro-0.2.120.sha256sum] = "78b1041f495fb322e64aca85f5756b2172e35cd459376e67f2a6c9dffcedb103"
+SRC_URI[wasm-bindgen-macro-support-0.2.120.sha256sum] = "9dcd0ff20416988a18ac686d4d4d0f6aae9ebf08a389ff5d29012b05af2a1b41"
+SRC_URI[wasm-bindgen-shared-0.2.120.sha256sum] = "49757b3c82ebf16c57d69365a142940b384176c24df52a087fb748e2085359ea"
 SRC_URI[wasm-encoder-0.244.0.sha256sum] = "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
 SRC_URI[wasm-metadata-0.244.0.sha256sum] = "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
 SRC_URI[wasmparser-0.244.0.sha256sum] = "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
@@ -816,23 +829,24 @@ SRC_URI[windows_x86_64_gnullvm-0.53.1.sha256sum] = "0ffa179e2d07eee8ad8f57493436
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[windows_x86_64_msvc-0.53.1.sha256sum] = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
 SRC_URI[winnow-0.7.15.sha256sum] = "df79d97927682d2fd8adb29682d1140b343be4ac0f08fd68b7765d9c059d3945"
+SRC_URI[winnow-1.0.2.sha256sum] = "2ee1708bef14716a11bae175f579062d4554d95be2c6829f518df847b7b3fdd0"
 SRC_URI[wit-bindgen-0.51.0.sha256sum] = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
+SRC_URI[wit-bindgen-0.57.1.sha256sum] = "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
 SRC_URI[wit-bindgen-core-0.51.0.sha256sum] = "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
 SRC_URI[wit-bindgen-rust-0.51.0.sha256sum] = "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
 SRC_URI[wit-bindgen-rust-macro-0.51.0.sha256sum] = "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
 SRC_URI[wit-component-0.244.0.sha256sum] = "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
 SRC_URI[wit-parser-0.244.0.sha256sum] = "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
-SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
-SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
-SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
-SRC_URI[zerocopy-0.8.40.sha256sum] = "a789c6e490b576db9f7e6b6d661bcc9799f7c0ac8352f56ea20193b2681532e5"
-SRC_URI[zerocopy-derive-0.8.40.sha256sum] = "f65c489a7071a749c849713807783f70672b28094011623e200cb86dcb835953"
-SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
-SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
+SRC_URI[writeable-0.6.3.sha256sum] = "1ffae5123b2d3fc086436f8834ae3ab053a283cfac8fe0a0b8eaae044768a4c4"
+SRC_URI[yoke-0.8.2.sha256sum] = "abe8c5fda708d9ca3df187cae8bfb9ceda00dd96231bed36e445a1a48e66f9ca"
+SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
+SRC_URI[zerocopy-0.8.48.sha256sum] = "eed437bf9d6692032087e337407a86f04cd8d6a16a37199ed57949d415bd68e9"
+SRC_URI[zerocopy-derive-0.8.48.sha256sum] = "70e3cd084b1788766f53af483dd21f93881ff30d7320490ec3ef7526d203bad4"
+SRC_URI[zerofrom-0.1.7.sha256sum] = "69faa1f2a1ea75661980b013019ed6687ed0e83d069bc1114e2cc74c6c04c4df"
+SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
 SRC_URI[zeroize-1.8.2.sha256sum] = "b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
-SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
-SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
-SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
-SRC_URI[zlib-rs-0.5.5.sha256sum] = "40990edd51aae2c2b6907af74ffb635029d5788228222c4bb811e9351c0caad3"
+SRC_URI[zerotrie-0.2.4.sha256sum] = "0f9152d31db0792fa83f70fb2f83148effb5c1f5b8c7686c3459e361d9bc20bf"
+SRC_URI[zerovec-0.11.6.sha256sum] = "90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239"
+SRC_URI[zerovec-derive-0.11.3.sha256sum] = "625dc425cab0dca6dc3c3319506e6593dcb08a9f387ea3b284dbd52a92c40555"
 SRC_URI[zlib-rs-0.6.3.sha256sum] = "3be3d40e40a133f9c916ee3f9f4fa2d9d63435b5fbe1bfc6d9dae0aa0ada1513"
 SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
diff --git a/recipes-devtools/cargo-c/cargo-c_0.10.21+cargo-0.95.0.bb b/recipes-devtools/cargo-c/cargo-c_0.10.22+cargo-0.96.0.bb
similarity index 87%
rename from recipes-devtools/cargo-c/cargo-c_0.10.21+cargo-0.95.0.bb
rename to recipes-devtools/cargo-c/cargo-c_0.10.22+cargo-0.96.0.bb
index 1f94d8e..79a95d1 100644
--- a/recipes-devtools/cargo-c/cargo-c_0.10.21+cargo-0.95.0.bb
+++ b/recipes-devtools/cargo-c/cargo-c_0.10.22+cargo-0.96.0.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.12/ \
 "
-SRC_URI[cargo-c.sha256sum] = "a458fad2489698dd392a624551644975b01f5684bd7721e09999fd37e0f26e91"
+SRC_URI[cargo-c.sha256sum] = "608749b7bc6c26638c676215e35603a8eeff40d87feb7d65375b0445a110a1c8"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
-- 
2.55.0


