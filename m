Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD5DCCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:00 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13171.1762633196496776444
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:19:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HjUUBfx4;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88059c28da1so18679686d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633195; x=1763237995; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfjV6wQj3NEzZ99juT6Twe+57JjZfb6mcrXlS+hdmqA=;
        b=HjUUBfx4jMPM8Wj8Z3jQudzaYDFsa+MvibBAiPOPDmxrEZbhDCOE0aWBE8E/yklMh9
         8gL5bgOhHf08TfKmJSYj/ZZT3Wc5VDC6/e9915uGzGRBmjRIMKlcaBsrmsi5Wc//BF4S
         KvJP3lEvPcE3C5ca48x1QAw4zS4+09ZwfydQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633195; x=1763237995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfjV6wQj3NEzZ99juT6Twe+57JjZfb6mcrXlS+hdmqA=;
        b=mdk0Ng/Glbv/5cJ0CxOxjy7iwcbOtW5cVNnVgG5uIYEvsDvtWQPSIlzw7ZqaHO5VQO
         XJyB6y52BOIoxIpYNi/FECTRs/maJfQ4ErVH0eAfb7Sa2XfGrOJI0T8FgCnObsbEkjzm
         6cm92tf5G7Aw/sMCun4F1v9TQ4WNq3OGzDcxQWFuFzHn9C0qJAfK36hcRKFhUp6OxDYY
         DrCOqEV4vthqwRtmFR/1TM8Kjol4FpzMtUJ+/mEmmXbnEknIU567I2uLNNhO32CUxafy
         t5v+fWkkRbI1Wk8KB0ZHFahl4fFcuk+/SQCfr5U7NW2kYqSozG9W0Rdl+iYk1ut1AXk6
         mwKw==
X-Gm-Message-State: AOJu0YxN5yrU8IdsLNkL5KCHVaT0L28+2OjT+V6XYtRfvOJbNlpcC6qo
	mOYlz43E9E3xme5W1w8GhBwZJr9PDIaEFGgys7VVvI+81BTFb1fsDjuho379UzXsYdW9agxrCK4
	TZ+52
X-Gm-Gg: ASbGnctin2MsUDxCoXNLPhnt62RMhY+WLSCfkx4yY5xDgD8hytz2U7cQVgwWhWdrjAU
	JTt0WoopmCdHNLussu226sTGy2zceBH+8mmzYl52s7J2rRUPB4k+Ed3DR3qKasKk1yeZ0MAFeyH
	B2Zvhdj4bKOaFMBi+HdzFHXfMthuUXLggNcbvPcmZ63jSSDodfq8z+3YCznnIXrihaUlpgX8ZTm
	UzjTQApDMkresoPaJUGZDVP/STcpCojO/fmP5hYPsDUs7mrjmEPKiet1xte48EiffysFAVCRu/A
	oBV2vXdg63ZCI4muz2b/g5xd+SfmGgwDeQgXa8ONjLjznkIw5dSS7KIgS7wT2dHTElLu0A52VEU
	kFVc6wT2bB2coJBrWghiGNjTC00FWFgNccXl9HDibionlto38rfDOFMGep5zPnKHpY3FMrHWlKv
	HrHedo5Vzp0PhHfKcG38mKaKPhNkVNdoJ4lOj96s3fNwPjGQfwzy8B
X-Google-Smtp-Source: AGHT+IGI3jsZPsHPNMU7H/jiIn177sQh9jUlgtbvoFPZtDKCALGXZmx3DERJcO4MK6lgFqZAzNN75w==
X-Received: by 2002:a05:6214:62e:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882386ecaedmr51432686d6.54.1762633195053;
        Sat, 08 Nov 2025 12:19:55 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:54 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/11] cargo-c: update 0.10.14 -> 0.10.15
Date: Sat,  8 Nov 2025 15:19:37 -0500
Message-ID: <868a66da39f2ddbbffaf3e2540c45659558e8301.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2449

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 363cc3166329d2457c531e7d6375fe0c63f1e90e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c-crates.inc      | 310 +++++++++---------
 ...9.0.bb => cargo-c_0.10.15+cargo-0.90.0.bb} |   2 +-
 2 files changed, 148 insertions(+), 164 deletions(-)
 rename recipes-devtools/rust/{cargo-c_0.10.14+cargo-0.89.0.bb => cargo-c_0.10.15+cargo-0.90.0.bb} (87%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/rust/cargo-c-crates.inc
index c7d333c..9d34d00 100644
--- a/recipes-devtools/rust/cargo-c-crates.inc
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -1,4 +1,4 @@
-# Autogenerated with 'bitbake -c update_crates cargo-c-native'
+# Autogenerated with 'bitbake -c update_crates cargo-c'
 
 # from Cargo.lock
 SRC_URI += " \
@@ -7,11 +7,11 @@ SRC_URI += " \
     crate://crates.io/aho-corasick/1.1.3 \
     crate://crates.io/allocator-api2/0.2.21 \
     crate://crates.io/annotate-snippets/0.11.5 \
-    crate://crates.io/anstream/0.6.19 \
+    crate://crates.io/anstream/0.6.20 \
     crate://crates.io/anstyle/1.0.11 \
     crate://crates.io/anstyle-parse/0.2.7 \
-    crate://crates.io/anstyle-query/1.1.3 \
-    crate://crates.io/anstyle-wincon/3.0.9 \
+    crate://crates.io/anstyle-query/1.1.4 \
+    crate://crates.io/anstyle-wincon/3.0.10 \
     crate://crates.io/anyhow/1.0.98 \
     crate://crates.io/arc-swap/1.7.1 \
     crate://crates.io/arrayref/0.3.9 \
@@ -28,21 +28,21 @@ SRC_URI += " \
     crate://crates.io/bumpalo/3.19.0 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.10.1 \
-    crate://crates.io/cargo/0.89.0 \
+    crate://crates.io/cargo/0.90.0 \
     crate://crates.io/cargo-credential/0.4.8 \
-    crate://crates.io/cargo-credential-libsecret/0.4.14 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.14 \
-    crate://crates.io/cargo-credential-wincred/0.4.14 \
+    crate://crates.io/cargo-credential-libsecret/0.5.0 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.15 \
+    crate://crates.io/cargo-credential-wincred/0.4.15 \
     crate://crates.io/cargo-platform/0.3.0 \
-    crate://crates.io/cargo-util/0.2.21 \
-    crate://crates.io/cargo-util-schemas/0.8.2 \
+    crate://crates.io/cargo-util/0.2.22 \
+    crate://crates.io/cargo-util-schemas/0.9.0 \
     crate://crates.io/cbindgen/0.29.0 \
-    crate://crates.io/cc/1.2.27 \
+    crate://crates.io/cc/1.2.32 \
     crate://crates.io/cfg-if/1.0.1 \
-    crate://crates.io/clap/4.5.40 \
-    crate://crates.io/clap_builder/4.5.40 \
-    crate://crates.io/clap_complete/4.5.54 \
-    crate://crates.io/clap_derive/4.5.40 \
+    crate://crates.io/clap/4.5.43 \
+    crate://crates.io/clap_builder/4.5.43 \
+    crate://crates.io/clap_complete/4.5.56 \
+    crate://crates.io/clap_derive/4.5.41 \
     crate://crates.io/clap_lex/0.7.5 \
     crate://crates.io/clru/0.6.2 \
     crate://crates.io/color-print/0.3.7 \
@@ -53,8 +53,8 @@ SRC_URI += " \
     crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crates-io/0.40.11 \
-    crate://crates.io/crc32fast/1.4.2 \
+    crate://crates.io/crates-io/0.40.12 \
+    crate://crates.io/crc32fast/1.5.0 \
     crate://crates.io/crossbeam-channel/0.5.15 \
     crate://crates.io/crossbeam-deque/0.8.6 \
     crate://crates.io/crossbeam-epoch/0.9.18 \
@@ -80,7 +80,6 @@ SRC_URI += " \
     crate://crates.io/errno/0.3.13 \
     crate://crates.io/fallible-iterator/0.3.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
-    crate://crates.io/faster-hex/0.9.0 \
     crate://crates.io/faster-hex/0.10.0 \
     crate://crates.io/fastrand/2.3.0 \
     crate://crates.io/ff/0.13.1 \
@@ -97,66 +96,61 @@ SRC_URI += " \
     crate://crates.io/getrandom/0.3.3 \
     crate://crates.io/git2/0.20.2 \
     crate://crates.io/git2-curl/0.21.0 \
-    crate://crates.io/gix/0.71.0 \
-    crate://crates.io/gix-actor/0.34.0 \
-    crate://crates.io/gix-attributes/0.25.0 \
+    crate://crates.io/gix/0.72.1 \
+    crate://crates.io/gix-actor/0.35.3 \
+    crate://crates.io/gix-attributes/0.26.1 \
     crate://crates.io/gix-bitmap/0.2.14 \
     crate://crates.io/gix-chunk/0.4.11 \
-    crate://crates.io/gix-command/0.5.0 \
-    crate://crates.io/gix-commitgraph/0.27.0 \
-    crate://crates.io/gix-config/0.44.0 \
-    crate://crates.io/gix-config-value/0.14.12 \
-    crate://crates.io/gix-credentials/0.28.0 \
-    crate://crates.io/gix-date/0.9.4 \
-    crate://crates.io/gix-diff/0.51.0 \
-    crate://crates.io/gix-dir/0.13.0 \
-    crate://crates.io/gix-discover/0.39.0 \
-    crate://crates.io/gix-features/0.41.1 \
+    crate://crates.io/gix-command/0.6.2 \
+    crate://crates.io/gix-commitgraph/0.28.0 \
+    crate://crates.io/gix-config/0.45.1 \
+    crate://crates.io/gix-config-value/0.15.1 \
+    crate://crates.io/gix-credentials/0.29.0 \
+    crate://crates.io/gix-date/0.10.4 \
+    crate://crates.io/gix-diff/0.52.1 \
+    crate://crates.io/gix-dir/0.14.1 \
+    crate://crates.io/gix-discover/0.40.1 \
     crate://crates.io/gix-features/0.42.1 \
-    crate://crates.io/gix-filter/0.18.0 \
-    crate://crates.io/gix-fs/0.14.0 \
+    crate://crates.io/gix-filter/0.19.2 \
     crate://crates.io/gix-fs/0.15.0 \
-    crate://crates.io/gix-glob/0.19.0 \
-    crate://crates.io/gix-hash/0.17.0 \
+    crate://crates.io/gix-glob/0.20.1 \
     crate://crates.io/gix-hash/0.18.0 \
     crate://crates.io/gix-hashtable/0.8.1 \
-    crate://crates.io/gix-ignore/0.14.0 \
-    crate://crates.io/gix-index/0.39.0 \
+    crate://crates.io/gix-ignore/0.15.0 \
+    crate://crates.io/gix-index/0.40.1 \
     crate://crates.io/gix-lock/17.1.0 \
-    crate://crates.io/gix-negotiate/0.19.0 \
-    crate://crates.io/gix-object/0.48.0 \
-    crate://crates.io/gix-odb/0.68.0 \
-    crate://crates.io/gix-pack/0.58.0 \
-    crate://crates.io/gix-packetline/0.18.4 \
-    crate://crates.io/gix-packetline-blocking/0.18.3 \
-    crate://crates.io/gix-path/0.10.18 \
-    crate://crates.io/gix-pathspec/0.10.0 \
-    crate://crates.io/gix-prompt/0.10.0 \
-    crate://crates.io/gix-protocol/0.49.0 \
-    crate://crates.io/gix-quote/0.5.0 \
-    crate://crates.io/gix-ref/0.51.0 \
-    crate://crates.io/gix-refspec/0.29.0 \
-    crate://crates.io/gix-revision/0.33.0 \
-    crate://crates.io/gix-revwalk/0.19.0 \
-    crate://crates.io/gix-sec/0.10.12 \
-    crate://crates.io/gix-shallow/0.3.0 \
-    crate://crates.io/gix-submodule/0.18.0 \
+    crate://crates.io/gix-negotiate/0.20.1 \
+    crate://crates.io/gix-object/0.49.1 \
+    crate://crates.io/gix-odb/0.69.1 \
+    crate://crates.io/gix-pack/0.59.1 \
+    crate://crates.io/gix-packetline/0.19.1 \
+    crate://crates.io/gix-packetline-blocking/0.19.1 \
+    crate://crates.io/gix-path/0.10.20 \
+    crate://crates.io/gix-pathspec/0.11.0 \
+    crate://crates.io/gix-prompt/0.11.1 \
+    crate://crates.io/gix-protocol/0.50.1 \
+    crate://crates.io/gix-quote/0.6.0 \
+    crate://crates.io/gix-ref/0.52.1 \
+    crate://crates.io/gix-refspec/0.30.1 \
+    crate://crates.io/gix-revision/0.34.1 \
+    crate://crates.io/gix-revwalk/0.20.1 \
+    crate://crates.io/gix-sec/0.11.0 \
+    crate://crates.io/gix-shallow/0.4.0 \
+    crate://crates.io/gix-submodule/0.19.1 \
     crate://crates.io/gix-tempfile/17.1.0 \
-    crate://crates.io/gix-trace/0.1.12 \
-    crate://crates.io/gix-transport/0.46.0 \
-    crate://crates.io/gix-traverse/0.45.0 \
-    crate://crates.io/gix-url/0.30.0 \
-    crate://crates.io/gix-utils/0.2.0 \
+    crate://crates.io/gix-trace/0.1.13 \
+    crate://crates.io/gix-transport/0.47.0 \
+    crate://crates.io/gix-traverse/0.46.2 \
+    crate://crates.io/gix-url/0.31.0 \
     crate://crates.io/gix-utils/0.3.0 \
-    crate://crates.io/gix-validate/0.9.4 \
     crate://crates.io/gix-validate/0.10.0 \
-    crate://crates.io/gix-worktree/0.40.0 \
+    crate://crates.io/gix-worktree/0.41.0 \
     crate://crates.io/glob/0.3.2 \
     crate://crates.io/globset/0.4.16 \
     crate://crates.io/group/0.13.0 \
     crate://crates.io/hash32/0.3.1 \
     crate://crates.io/hashbrown/0.14.5 \
-    crate://crates.io/hashbrown/0.15.4 \
+    crate://crates.io/hashbrown/0.15.5 \
     crate://crates.io/hashlink/0.10.0 \
     crate://crates.io/heapless/0.8.0 \
     crate://crates.io/heck/0.5.0 \
@@ -176,7 +170,7 @@ SRC_URI += " \
     crate://crates.io/idna_adapter/1.2.1 \
     crate://crates.io/ignore/0.4.23 \
     crate://crates.io/im-rc/15.1.0 \
-    crate://crates.io/implib/0.3.5 \
+    crate://crates.io/implib/0.4.0 \
     crate://crates.io/indexmap/2.10.0 \
     crate://crates.io/is_executable/1.0.4 \
     crate://crates.io/is_terminal_polyfill/1.70.1 \
@@ -196,12 +190,11 @@ SRC_URI += " \
     crate://crates.io/libgit2-sys/0.18.2+1.9.1 \
     crate://crates.io/libloading/0.8.8 \
     crate://crates.io/libnghttp2-sys/0.1.11+1.64.0 \
-    crate://crates.io/libredox/0.1.4 \
+    crate://crates.io/libredox/0.1.9 \
     crate://crates.io/libsqlite3-sys/0.32.0 \
     crate://crates.io/libssh2-sys/0.3.1 \
     crate://crates.io/libz-rs-sys/0.5.1 \
     crate://crates.io/libz-sys/1.1.22 \
-    crate://crates.io/linux-raw-sys/0.4.15 \
     crate://crates.io/linux-raw-sys/0.9.4 \
     crate://crates.io/litemap/0.8.0 \
     crate://crates.io/lock_api/0.4.13 \
@@ -209,7 +202,7 @@ SRC_URI += " \
     crate://crates.io/matchers/0.1.0 \
     crate://crates.io/maybe-async/0.2.10 \
     crate://crates.io/memchr/2.7.5 \
-    crate://crates.io/memmap2/0.9.5 \
+    crate://crates.io/memmap2/0.9.7 \
     crate://crates.io/memoffset/0.9.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
     crate://crates.io/miniz_oxide/0.8.9 \
@@ -219,15 +212,14 @@ SRC_URI += " \
     crate://crates.io/nu-ansi-term/0.46.0 \
     crate://crates.io/num-conv/0.1.0 \
     crate://crates.io/num-traits/0.2.19 \
-    crate://crates.io/object/0.36.7 \
-    crate://crates.io/object/0.37.1 \
+    crate://crates.io/object/0.37.2 \
     crate://crates.io/once_cell/1.21.3 \
     crate://crates.io/once_cell_polyfill/1.70.1 \
     crate://crates.io/opener/0.7.2 \
     crate://crates.io/openssl/0.10.73 \
     crate://crates.io/openssl-macros/0.1.1 \
     crate://crates.io/openssl-probe/0.1.6 \
-    crate://crates.io/openssl-src/300.5.0+3.5.0 \
+    crate://crates.io/openssl-src/300.5.2+3.5.2 \
     crate://crates.io/openssl-sys/0.9.109 \
     crate://crates.io/ordered-float/2.10.1 \
     crate://crates.io/orion/0.17.11 \
@@ -236,14 +228,14 @@ SRC_URI += " \
     crate://crates.io/p384/0.13.1 \
     crate://crates.io/parking_lot/0.12.4 \
     crate://crates.io/parking_lot_core/0.9.11 \
-    crate://crates.io/pasetors/0.7.6 \
+    crate://crates.io/pasetors/0.7.7 \
     crate://crates.io/pathdiff/0.2.3 \
     crate://crates.io/pem-rfc7468/0.7.0 \
     crate://crates.io/percent-encoding/2.3.1 \
     crate://crates.io/pin-project-lite/0.2.16 \
     crate://crates.io/pkcs8/0.10.2 \
     crate://crates.io/pkg-config/0.3.32 \
-    crate://crates.io/plist/1.7.2 \
+    crate://crates.io/plist/1.7.4 \
     crate://crates.io/portable-atomic/1.11.1 \
     crate://crates.io/portable-atomic-util/0.2.4 \
     crate://crates.io/potential_utf/0.1.2 \
@@ -252,15 +244,15 @@ SRC_URI += " \
     crate://crates.io/primeorder/0.13.6 \
     crate://crates.io/proc-macro2/1.0.95 \
     crate://crates.io/prodash/29.0.2 \
-    crate://crates.io/quick-xml/0.37.5 \
+    crate://crates.io/quick-xml/0.38.1 \
     crate://crates.io/quote/1.0.40 \
     crate://crates.io/r-efi/5.3.0 \
-    crate://crates.io/rand/0.9.1 \
+    crate://crates.io/rand/0.9.2 \
     crate://crates.io/rand_chacha/0.9.0 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/rand_core/0.9.3 \
     crate://crates.io/rand_xoshiro/0.6.0 \
-    crate://crates.io/redox_syscall/0.5.13 \
+    crate://crates.io/redox_syscall/0.5.17 \
     crate://crates.io/regex/1.11.1 \
     crate://crates.io/regex-automata/0.1.10 \
     crate://crates.io/regex-automata/0.4.9 \
@@ -271,14 +263,13 @@ SRC_URI += " \
     crate://crates.io/rustc-hash/2.1.1 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
     crate://crates.io/rustfix/0.9.1 \
-    crate://crates.io/rustix/0.38.44 \
-    crate://crates.io/rustix/1.0.7 \
+    crate://crates.io/rustix/1.0.8 \
     crate://crates.io/ryu/1.0.20 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/schannel/0.1.27 \
     crate://crates.io/scopeguard/1.2.0 \
     crate://crates.io/sec1/0.7.3 \
-    crate://crates.io/security-framework/3.2.0 \
+    crate://crates.io/security-framework/3.3.0 \
     crate://crates.io/security-framework-sys/2.14.0 \
     crate://crates.io/semver/1.0.26 \
     crate://crates.io/serde/1.0.219 \
@@ -286,7 +277,7 @@ SRC_URI += " \
     crate://crates.io/serde-value/0.7.0 \
     crate://crates.io/serde_derive/1.0.219 \
     crate://crates.io/serde_ignored/0.1.12 \
-    crate://crates.io/serde_json/1.0.140 \
+    crate://crates.io/serde_json/1.0.142 \
     crate://crates.io/serde_spanned/0.6.9 \
     crate://crates.io/sha1/0.10.6 \
     crate://crates.io/sha1-checked/0.10.0 \
@@ -358,13 +349,14 @@ SRC_URI += " \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.9 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-link/0.1.3 \
     crate://crates.io/windows-sys/0.48.0 \
     crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-sys/0.59.0 \
     crate://crates.io/windows-sys/0.60.2 \
     crate://crates.io/windows-targets/0.48.5 \
     crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows-targets/0.53.2 \
+    crate://crates.io/windows-targets/0.53.3 \
     crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.53.0 \
@@ -388,7 +380,7 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_msvc/0.48.5 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.53.0 \
-    crate://crates.io/winnow/0.7.11 \
+    crate://crates.io/winnow/0.7.12 \
     crate://crates.io/wit-bindgen-rt/0.39.0 \
     crate://crates.io/writeable/0.6.1 \
     crate://crates.io/yoke/0.8.0 \
@@ -399,7 +391,7 @@ SRC_URI += " \
     crate://crates.io/zerofrom-derive/0.1.6 \
     crate://crates.io/zeroize/1.8.1 \
     crate://crates.io/zerotrie/0.2.2 \
-    crate://crates.io/zerovec/0.11.2 \
+    crate://crates.io/zerovec/0.11.4 \
     crate://crates.io/zerovec-derive/0.11.1 \
     crate://crates.io/zlib-rs/0.5.1 \
 "
@@ -409,11 +401,11 @@ SRC_URI[ahash-0.8.12.sha256sum] = "5a15f179cd60c4584b8a8c596927aadc462e27f2ca70c
 SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
 SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
 SRC_URI[annotate-snippets-0.11.5.sha256sum] = "710e8eae58854cdc1790fcb56cca04d712a17be849eeb81da2a724bf4bae2bc4"
-SRC_URI[anstream-0.6.19.sha256sum] = "301af1932e46185686725e0fad2f8f2aa7da69dd70bf6ecc44d6b703844a3933"
+SRC_URI[anstream-0.6.20.sha256sum] = "3ae563653d1938f79b1ab1b5e668c87c76a9930414574a6583a7b7e11a8e6192"
 SRC_URI[anstyle-1.0.11.sha256sum] = "862ed96ca487e809f1c8e5a8447f6ee2cf102f846893800b20cebdf541fc6bbd"
 SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
-SRC_URI[anstyle-query-1.1.3.sha256sum] = "6c8bdeb6047d8983be085bab0ba1472e6dc604e7041dbf6fcd5e71523014fae9"
-SRC_URI[anstyle-wincon-3.0.9.sha256sum] = "403f75924867bb1033c59fbf0797484329750cfbe3c4325cd33127941fabc882"
+SRC_URI[anstyle-query-1.1.4.sha256sum] = "9e231f6134f61b71076a3eab506c379d4f36122f2af15a9ff04415ea4c3339e2"
+SRC_URI[anstyle-wincon-3.0.10.sha256sum] = "3e0633414522a32ffaac8ac6cc8f748e090c5717661fddeea04219e2344f5f2a"
 SRC_URI[anyhow-1.0.98.sha256sum] = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
 SRC_URI[arc-swap-1.7.1.sha256sum] = "69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
 SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
@@ -430,21 +422,21 @@ SRC_URI[bstr-1.12.0.sha256sum] = "234113d19d0d7d613b40e86fb654acf958910802bcceab
 SRC_URI[bumpalo-3.19.0.sha256sum] = "46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.10.1.sha256sum] = "d71b6127be86fdcfddb610f7182ac57211d4b18a3e9c82eb2d17662f2227ad6a"
-SRC_URI[cargo-0.89.0.sha256sum] = "4ffb868a2869728e8cad2afd836cf7f287f5e9379f2e857deea187abfd7c5cfd"
+SRC_URI[cargo-0.90.0.sha256sum] = "a95c123eb754e6e2da70c00b026df85c7bae211692581e371e2cd9d8c175e069"
 SRC_URI[cargo-credential-0.4.8.sha256sum] = "ac1ef5080adde1db190e901884d2c400990856c2a23201c5a181b910a6dbdf2a"
-SRC_URI[cargo-credential-libsecret-0.4.14.sha256sum] = "d4c6e10380bfa25a4f1495e6ca7256332857e3ef7bb16adf376641e6af03acaf"
-SRC_URI[cargo-credential-macos-keychain-0.4.14.sha256sum] = "123e3570992ff3f899a62eefd482e131dea655df8c08150ae559bda2ff492836"
-SRC_URI[cargo-credential-wincred-0.4.14.sha256sum] = "0310db795786db4bbe6cc00f30099ff6a157bb78f9f590376e5e1005866a68d3"
+SRC_URI[cargo-credential-libsecret-0.5.0.sha256sum] = "42fb1e935ce4b67f386202b943abe6538cbf3bc520c8de4cad40434588f6e12d"
+SRC_URI[cargo-credential-macos-keychain-0.4.15.sha256sum] = "6ed2a4071b9baff1491f11e8fbd09ef66fdb49e542438520079b81fb6405d37a"
+SRC_URI[cargo-credential-wincred-0.4.15.sha256sum] = "ede93c95e499507ef7b09bd48721660809b7fe7d94ca6094f9dbe617fe067730"
 SRC_URI[cargo-platform-0.3.0.sha256sum] = "8abf5d501fd757c2d2ee78d0cc40f606e92e3a63544420316565556ed28485e2"
-SRC_URI[cargo-util-0.2.21.sha256sum] = "c95ec8b2485b20aed818bd7460f8eecc6c87c35c84191b353a3aba9aa1736c36"
-SRC_URI[cargo-util-schemas-0.8.2.sha256sum] = "7dc1a6f7b5651af85774ae5a34b4e8be397d9cf4bc063b7e6dbd99a841837830"
+SRC_URI[cargo-util-0.2.22.sha256sum] = "4f46ba11692cd1e4b09cd123877e02b74e180acae237caf905ef20b42e14e206"
+SRC_URI[cargo-util-schemas-0.9.0.sha256sum] = "0af3961378b28006148f83291d9e485044f9110542e54aae90d195e0cf178c40"
 SRC_URI[cbindgen-0.29.0.sha256sum] = "975982cdb7ad6a142be15bdf84aea7ec6a9e5d4d797c004d43185b24cfe4e684"
-SRC_URI[cc-1.2.27.sha256sum] = "d487aa071b5f64da6f19a3e848e3578944b726ee5a4854b82172f02aa876bfdc"
+SRC_URI[cc-1.2.32.sha256sum] = "2352e5597e9c544d5e6d9c95190d5d27738ade584fa8db0a16e130e5c2b5296e"
 SRC_URI[cfg-if-1.0.1.sha256sum] = "9555578bc9e57714c812a1f84e4fc5b4d21fcb063490c624de019f7464c91268"
-SRC_URI[clap-4.5.40.sha256sum] = "40b6887a1d8685cebccf115538db5c0efe625ccac9696ad45c409d96566e910f"
-SRC_URI[clap_builder-4.5.40.sha256sum] = "e0c66c08ce9f0c698cbce5c0279d0bb6ac936d8674174fe48f736533b964f59e"
-SRC_URI[clap_complete-4.5.54.sha256sum] = "aad5b1b4de04fead402672b48897030eec1f3bfe1550776322f59f6d6e6a5677"
-SRC_URI[clap_derive-4.5.40.sha256sum] = "d2c7947ae4cc3d851207c1adb5b5e260ff0cca11446b1d6d1423788e442257ce"
+SRC_URI[clap-4.5.43.sha256sum] = "50fd97c9dc2399518aa331917ac6f274280ec5eb34e555dd291899745c48ec6f"
+SRC_URI[clap_builder-4.5.43.sha256sum] = "c35b5830294e1fa0462034af85cc95225a4cb07092c088c55bda3147cfcd8f65"
+SRC_URI[clap_complete-4.5.56.sha256sum] = "67e4efcbb5da11a92e8a609233aa1e8a7d91e38de0be865f016d14700d45a7fd"
+SRC_URI[clap_derive-4.5.41.sha256sum] = "ef4f52386a59ca4c860f7393bcf8abd8dfd91ecccc0f774635ff68e92eeef491"
 SRC_URI[clap_lex-0.7.5.sha256sum] = "b94f61472cee1439c0b966b47e3aca9ae07e45d070759512cd390ea2bebc6675"
 SRC_URI[clru-0.6.2.sha256sum] = "cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
 SRC_URI[color-print-0.3.7.sha256sum] = "3aa954171903797d5623e047d9ab69d91b493657917bdfb8c2c80ecaf9cdb6f4"
@@ -455,8 +447,8 @@ SRC_URI[constant_time_eq-0.3.1.sha256sum] = "7c74b8349d32d297c9134b8c88677813a22
 SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crates-io-0.40.11.sha256sum] = "9d8912d1316660f138aa2dec2c20e38633449fb7a3b2b8fcbf1698ac31941b8e"
-SRC_URI[crc32fast-1.4.2.sha256sum] = "a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
+SRC_URI[crates-io-0.40.12.sha256sum] = "a8022895e0e2ac5156fe59598ff40c7d4354600a56ca12bcf7aa715df2c07159"
+SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
 SRC_URI[crossbeam-channel-0.5.15.sha256sum] = "82b8f8f868b36967f9606790d1903570de9ceaf870a7bf9fbbd3016d636a2cb2"
 SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
 SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
@@ -482,7 +474,6 @@ SRC_URI[erased-serde-0.4.6.sha256sum] = "e004d887f51fcb9fef17317a2f3525c887d8aa3
 SRC_URI[errno-0.3.13.sha256sum] = "778e2ac28f6c47af28e4907f13ffd1e1ddbd400980a9abd7c8df189bf578a5ad"
 SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
-SRC_URI[faster-hex-0.9.0.sha256sum] = "a2a2b11eda1d40935b26cf18f6833c526845ae8c41e58d09af6adeb6f0269183"
 SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
 SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
@@ -499,66 +490,61 @@ SRC_URI[getrandom-0.2.16.sha256sum] = "335ff9f135e4384c8150d6f27c6daed433577f86b
 SRC_URI[getrandom-0.3.3.sha256sum] = "26145e563e54f2cadc477553f1ec5ee650b00862f0a58bcd12cbdc5f0ea2d2f4"
 SRC_URI[git2-0.20.2.sha256sum] = "2deb07a133b1520dc1a5690e9bd08950108873d7ed5de38dcc74d3b5ebffa110"
 SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
-SRC_URI[gix-0.71.0.sha256sum] = "a61e71ec6817fc3c9f12f812682cfe51ee6ea0d2e27e02fc3849c35524617435"
-SRC_URI[gix-actor-0.34.0.sha256sum] = "f438c87d4028aca4b82f82ba8d8ab1569823cfb3e5bc5fa8456a71678b2a20e7"
-SRC_URI[gix-attributes-0.25.0.sha256sum] = "e4e25825e0430aa11096f8b65ced6780d4a96a133f81904edceebb5344c8dd7f"
+SRC_URI[gix-0.72.1.sha256sum] = "01237e8d3d78581f71642be8b0c2ae8c0b2b5c251c9c5d9ebbea3c1ea280dce8"
+SRC_URI[gix-actor-0.35.3.sha256sum] = "d1b1ec302f8dc059df125ed46dfdc7e9d33fe7724df19843aea53b5ffd32d5bb"
+SRC_URI[gix-attributes-0.26.1.sha256sum] = "6f50d813d5c2ce9463ba0c29eea90060df08e38ad8f34b8a192259f8bce5c078"
 SRC_URI[gix-bitmap-0.2.14.sha256sum] = "b1db9765c69502650da68f0804e3dc2b5f8ccc6a2d104ca6c85bc40700d37540"
 SRC_URI[gix-chunk-0.4.11.sha256sum] = "0b1f1d8764958699dc764e3f727cef280ff4d1bd92c107bbf8acd85b30c1bd6f"
-SRC_URI[gix-command-0.5.0.sha256sum] = "c0378995847773a697f8e157fe2963ecf3462fe64be05b7b3da000b3b472def8"
-SRC_URI[gix-commitgraph-0.27.0.sha256sum] = "043cbe49b7a7505150db975f3cb7c15833335ac1e26781f615454d9d640a28fe"
-SRC_URI[gix-config-0.44.0.sha256sum] = "9c6f830bf746604940261b49abf7f655d2c19cadc9f4142ae9379e3a316e8cfa"
-SRC_URI[gix-config-value-0.14.12.sha256sum] = "8dc2c844c4cf141884678cabef736fd91dd73068b9146e6f004ba1a0457944b6"
-SRC_URI[gix-credentials-0.28.0.sha256sum] = "25322308aaf65789536b860d21137c3f7b69004ac4971c15c1abb08d3951c062"
-SRC_URI[gix-date-0.9.4.sha256sum] = "daa30058ec7d3511fbc229e4f9e696a35abd07ec5b82e635eff864a2726217e4"
-SRC_URI[gix-diff-0.51.0.sha256sum] = "a2c975dad2afc85e4e233f444d1efbe436c3cdcf3a07173984509c436d00a3f8"
-SRC_URI[gix-dir-0.13.0.sha256sum] = "5879497bd3815d8277ed864ec8975290a70de5b62bb92d2d666a4cefc5d4793b"
-SRC_URI[gix-discover-0.39.0.sha256sum] = "f7fb8a4349b854506a3915de18d3341e5f1daa6b489c8affc9ca0d69efe86781"
-SRC_URI[gix-features-0.41.1.sha256sum] = "016d6050219458d14520fe22bdfdeb9cb71631dec9bc2724767c983f60109634"
+SRC_URI[gix-command-0.6.2.sha256sum] = "6b31b65ca48a352ae86312b27a514a0c661935f96b481ac8b4371f65815eb196"
+SRC_URI[gix-commitgraph-0.28.0.sha256sum] = "e05050fd6caa6c731fe3bd7f9485b3b520be062d3d139cb2626e052d6c127951"
+SRC_URI[gix-config-0.45.1.sha256sum] = "48f3c8f357ae049bfb77493c2ec9010f58cfc924ae485e1116c3718fc0f0d881"
+SRC_URI[gix-config-value-0.15.1.sha256sum] = "9f012703eb67e263c6c1fc96649fec47694dd3e5d2a91abfc65e4a6a6dc85309"
+SRC_URI[gix-credentials-0.29.0.sha256sum] = "ce1c7307e36026b6088e5b12014ffe6d4f509c911ee453e22a7be4003a159c9b"
+SRC_URI[gix-date-0.10.4.sha256sum] = "467254054f8df1e85b5f73cb910602767b0122391d994302a091841ba43edfaa"
+SRC_URI[gix-diff-0.52.1.sha256sum] = "5e9b43e95fe352da82a969f0c84ff860c2de3e724d93f6681fedbcd6c917f252"
+SRC_URI[gix-dir-0.14.1.sha256sum] = "01e6e2dc5b8917142d0ffe272209d1671e45b771e433f90186bc71c016792e87"
+SRC_URI[gix-discover-0.40.1.sha256sum] = "dccfe3e25b4ea46083916c56db3ba9d1e6ef6dce54da485f0463f9fc0fe1837c"
 SRC_URI[gix-features-0.42.1.sha256sum] = "56f4399af6ec4fd9db84dd4cf9656c5c785ab492ab40a7c27ea92b4241923fed"
-SRC_URI[gix-filter-0.18.0.sha256sum] = "cb2b2bbffdc5cc9b2b82fc82da1b98163c9b423ac2b45348baa83a947ac9ab89"
-SRC_URI[gix-fs-0.14.0.sha256sum] = "951e886120dc5fa8cac053e5e5c89443f12368ca36811b2e43d1539081f9c111"
+SRC_URI[gix-filter-0.19.2.sha256sum] = "ecf004912949bbcf308d71aac4458321748ecb59f4d046830d25214208c471f1"
 SRC_URI[gix-fs-0.15.0.sha256sum] = "67a0637149b4ef24d3ea55f81f77231401c8463fae6da27331c987957eb597c7"
-SRC_URI[gix-glob-0.19.0.sha256sum] = "20972499c03473e773a2099e5fd0c695b9b72465837797a51a43391a1635a030"
-SRC_URI[gix-hash-0.17.0.sha256sum] = "834e79722063958b03342edaa1e17595cd2939bb2b3306b3225d0815566dcb49"
+SRC_URI[gix-glob-0.20.1.sha256sum] = "90181472925b587f6079698f79065ff64786e6d6c14089517a1972bca99fb6e9"
 SRC_URI[gix-hash-0.18.0.sha256sum] = "8d4900562c662852a6b42e2ef03442eccebf24f047d8eab4f23bc12ef0d785d8"
 SRC_URI[gix-hashtable-0.8.1.sha256sum] = "b5b5cb3c308b4144f2612ff64e32130e641279fcf1a84d8d40dad843b4f64904"
-SRC_URI[gix-ignore-0.14.0.sha256sum] = "9a27c8380f493a10d1457f756a3f81924d578fc08d6535e304dfcafbf0261d18"
-SRC_URI[gix-index-0.39.0.sha256sum] = "855bece2d4153453aa5d0a80d51deea1ce8cd6a3b4cf213da85ac344ccb908a7"
+SRC_URI[gix-ignore-0.15.0.sha256sum] = "ae358c3c96660b10abc7da63c06788dfded603e717edbd19e38c6477911b71c8"
+SRC_URI[gix-index-0.40.1.sha256sum] = "b38e919efd59cb8275d23ad2394b2ab9d002007b27620e145d866d546403b665"
 SRC_URI[gix-lock-17.1.0.sha256sum] = "570f8b034659f256366dc90f1a24924902f20acccd6a15be96d44d1269e7a796"
-SRC_URI[gix-negotiate-0.19.0.sha256sum] = "dad912acf5a68a7defa4836014337ff4381af8c3c098f41f818a8c524285e57b"
-SRC_URI[gix-object-0.48.0.sha256sum] = "4943fcdae6ffc135920c9ea71e0362ed539182924ab7a85dd9dac8d89b0dd69a"
-SRC_URI[gix-odb-0.68.0.sha256sum] = "50306d40dcc982eb6b7593103f066ea6289c7b094cb9db14f3cd2be0b9f5e610"
-SRC_URI[gix-pack-0.58.0.sha256sum] = "9b65fffb09393c26624ca408d32cfe8776fb94cd0a5cdf984905e1d2f39779cb"
-SRC_URI[gix-packetline-0.18.4.sha256sum] = "123844a70cf4d5352441dc06bab0da8aef61be94ec239cb631e0ba01dc6d3a04"
-SRC_URI[gix-packetline-blocking-0.18.3.sha256sum] = "1ecf3ea2e105c7e45587bac04099824301262a6c43357fad5205da36dbb233b3"
-SRC_URI[gix-path-0.10.18.sha256sum] = "567f65fec4ef10dfab97ae71f26a27fd4d7fe7b8e3f90c8a58551c41ff3fb65b"
-SRC_URI[gix-pathspec-0.10.0.sha256sum] = "fef8422c3c9066d649074b24025125963f85232bfad32d6d16aea9453b82ec14"
-SRC_URI[gix-prompt-0.10.0.sha256sum] = "fbf9cbf6239fd32f2c2c9c57eeb4e9b28fa1c9b779fa0e3b7c455eb1ca49d5f0"
-SRC_URI[gix-protocol-0.49.0.sha256sum] = "5678ddae1d62880bc30e2200be1b9387af3372e0e88e21f81b4e7f8367355b5a"
-SRC_URI[gix-quote-0.5.0.sha256sum] = "1b005c550bf84de3b24aa5e540a23e6146a1c01c7d30470e35d75a12f827f969"
-SRC_URI[gix-ref-0.51.0.sha256sum] = "b2e1f7eb6b7ce82d2d19961f74bd637bab3ea79b1bc7bfb23dbefc67b0415d8b"
-SRC_URI[gix-refspec-0.29.0.sha256sum] = "1d8587b21e2264a6e8938d940c5c99662779c13a10741a5737b15fc85c252ffc"
-SRC_URI[gix-revision-0.33.0.sha256sum] = "342caa4e158df3020cadf62f656307c3948fe4eacfdf67171d7212811860c3e9"
-SRC_URI[gix-revwalk-0.19.0.sha256sum] = "2dc7c3d7e5cdc1ab8d35130106e4af0a4f9f9eca0c81f4312b690780e92bde0d"
-SRC_URI[gix-sec-0.10.12.sha256sum] = "47aeb0f13de9ef2f3033f5ff218de30f44db827ac9f1286f9ef050aacddd5888"
-SRC_URI[gix-shallow-0.3.0.sha256sum] = "cc0598aacfe1d52575a21c9492fee086edbb21e228ec36c819c42ab923f434c3"
-SRC_URI[gix-submodule-0.18.0.sha256sum] = "78c7390c2059505c365e9548016d4edc9f35749c6a9112b7b1214400bbc68da2"
+SRC_URI[gix-negotiate-0.20.1.sha256sum] = "2e1ea901acc4d5b44553132a29e8697210cb0e739b2d9752d713072e9391e3c9"
+SRC_URI[gix-object-0.49.1.sha256sum] = "d957ca3640c555d48bb27f8278c67169fa1380ed94f6452c5590742524c40fbb"
+SRC_URI[gix-odb-0.69.1.sha256sum] = "868f703905fdbcfc1bd750942f82419903ecb7039f5288adb5206d6de405e0c9"
+SRC_URI[gix-pack-0.59.1.sha256sum] = "9d49c55d69c8449f2a0a5a77eb9cbacfebb6b0e2f1215f0fc23a4cb60528a450"
+SRC_URI[gix-packetline-0.19.1.sha256sum] = "2592fbd36249a2fea11056f7055cc376301ef38d903d157de41998335bbf1f93"
+SRC_URI[gix-packetline-blocking-0.19.1.sha256sum] = "fc4e706f328cd494cc8f932172e123a72b9a4711b0db5e411681432a89bd4c94"
+SRC_URI[gix-path-0.10.20.sha256sum] = "06d37034a4c67bbdda76f7bcd037b2f7bc0fba0c09a6662b19697a5716e7b2fd"
+SRC_URI[gix-pathspec-0.11.0.sha256sum] = "ce061c50e5f8f7c830cacb3da3e999ae935e283ce8522249f0ce2256d110979d"
+SRC_URI[gix-prompt-0.11.1.sha256sum] = "6ffa1a7a34c81710aaa666a428c142b6c5d640492fcd41267db0740d923c7906"
+SRC_URI[gix-protocol-0.50.1.sha256sum] = "f5c17d78bb0414f8d60b5f952196dc2e47ec320dca885de9128ecdb4a0e38401"
+SRC_URI[gix-quote-0.6.0.sha256sum] = "4a375a75b4d663e8bafe3bf4940a18a23755644c13582fa326e99f8f987d83fd"
+SRC_URI[gix-ref-0.52.1.sha256sum] = "d1b7985657029684d759f656b09abc3e2c73085596d5cdb494428823970a7762"
+SRC_URI[gix-refspec-0.30.1.sha256sum] = "445ed14e3db78e8e79980085e3723df94e1c8163b3ae5bc8ed6a8fe6cf983b42"
+SRC_URI[gix-revision-0.34.1.sha256sum] = "78d0b8e5cbd1c329e25383e088cb8f17439414021a643b30afa5146b71e3c65d"
+SRC_URI[gix-revwalk-0.20.1.sha256sum] = "1bc756b73225bf005ddeb871d1ca7b3c33e2417d0d53e56effa5a36765b52b28"
+SRC_URI[gix-sec-0.11.0.sha256sum] = "d0dabbc78c759ecc006b970339394951b2c8e1e38a37b072c105b80b84c308fd"
+SRC_URI[gix-shallow-0.4.0.sha256sum] = "6b9a6f6e34d6ede08f522d89e5c7990b4f60524b8ae6ebf8e850963828119ad4"
+SRC_URI[gix-submodule-0.19.1.sha256sum] = "5f51472f05a450cc61bc91ed2f62fb06e31e2bbb31c420bc4be8793f26c8b0c1"
 SRC_URI[gix-tempfile-17.1.0.sha256sum] = "c750e8c008453a2dba67a2b0d928b7716e05da31173a3f5e351d5457ad4470aa"
-SRC_URI[gix-trace-0.1.12.sha256sum] = "7c396a2036920c69695f760a65e7f2677267ccf483f25046977d87e4cb2665f7"
-SRC_URI[gix-transport-0.46.0.sha256sum] = "b3f68c2870bfca8278389d2484a7f2215b67d0b0cc5277d3c72ad72acf41787e"
-SRC_URI[gix-traverse-0.45.0.sha256sum] = "36c0b049f8bdb61b20016694102f7b507f2e1727e83e9c5e6dad4f7d84ff7384"
-SRC_URI[gix-url-0.30.0.sha256sum] = "48dfe23f93f1ddb84977d80bb0dd7aa09d1bf5d5afc0c9b6820cccacc25ae860"
-SRC_URI[gix-utils-0.2.0.sha256sum] = "189f8724cf903e7fd57cfe0b7bc209db255cacdcb22c781a022f52c3a774f8d0"
+SRC_URI[gix-trace-0.1.13.sha256sum] = "e2ccaf54b0b1743a695b482ca0ab9d7603744d8d10b2e5d1a332fef337bee658"
+SRC_URI[gix-transport-0.47.0.sha256sum] = "edfe22ba26d4b65c17879f12b9882eafe65d3c8611c933b272fce2c10f546f59"
+SRC_URI[gix-traverse-0.46.2.sha256sum] = "b8648172f85aca3d6e919c06504b7ac26baef54e04c55eb0100fa588c102cc33"
+SRC_URI[gix-url-0.31.0.sha256sum] = "42a1ad0b04a5718b5cb233e6888e52a9b627846296161d81dcc5eb9203ec84b8"
 SRC_URI[gix-utils-0.3.0.sha256sum] = "5351af2b172caf41a3728eb4455326d84e0d70fe26fc4de74ab0bd37df4191c5"
-SRC_URI[gix-validate-0.9.4.sha256sum] = "34b5f1253109da6c79ed7cf6e1e38437080bb6d704c76af14c93e2f255234084"
 SRC_URI[gix-validate-0.10.0.sha256sum] = "77b9e00cacde5b51388d28ed746c493b18a6add1f19b5e01d686b3b9ece66d4d"
-SRC_URI[gix-worktree-0.40.0.sha256sum] = "f7760dbc4b79aa274fed30adc0d41dca6b917641f26e7867c4071b1fb4dc727b"
+SRC_URI[gix-worktree-0.41.0.sha256sum] = "54f1916f8d928268300c977d773dd70a8746b646873b77add0a34876a8c847e9"
 SRC_URI[glob-0.3.2.sha256sum] = "a8d1add55171497b4705a648c6b583acafb01d58050a51727785f0b2c8e0a2b2"
 SRC_URI[globset-0.4.16.sha256sum] = "54a1028dfc5f5df5da8a56a73e6c153c9a9708ec57232470703592a3f18e49f5"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
 SRC_URI[hash32-0.3.1.sha256sum] = "47d60b12902ba28e2730cd37e95b8c9223af2808df9e902d4df49588d1470606"
 SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
-SRC_URI[hashbrown-0.15.4.sha256sum] = "5971ac85611da7067dbfcabef3c70ebb5606018acd9e2a3903a0da507521e0d5"
+SRC_URI[hashbrown-0.15.5.sha256sum] = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
 SRC_URI[hashlink-0.10.0.sha256sum] = "7382cf6263419f2d8df38c55d7da83da5c18aef87fc7a7fc1fb1e344edfe14c1"
 SRC_URI[heapless-0.8.0.sha256sum] = "0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
 SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
@@ -578,7 +564,7 @@ SRC_URI[idna-1.0.3.sha256sum] = "686f825264d630750a544639377bae737628043f20d38bb
 SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
 SRC_URI[ignore-0.4.23.sha256sum] = "6d89fd380afde86567dfba715db065673989d6253f42b88179abd3eae47bda4b"
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
-SRC_URI[implib-0.3.5.sha256sum] = "598bf7096215f835b0f70c94d7b033da3cbf66181b619f25e54d65adaf825e62"
+SRC_URI[implib-0.4.0.sha256sum] = "7923c255262a0e44362e221f8b74b931fe21484b83f27386aa45f021a379caf6"
 SRC_URI[indexmap-2.10.0.sha256sum] = "fe4cd85333e22411419a0bcae1297d25e58c9443848b11dc6a86fefe8c78a661"
 SRC_URI[is_executable-1.0.4.sha256sum] = "d4a1b5bad6f9072935961dfbf1cced2f3d129963d091b6f69f007fe04e758ae2"
 SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] = "7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
@@ -598,12 +584,11 @@ SRC_URI[libdbus-sys-0.2.5.sha256sum] = "06085512b750d640299b79be4bad3d2fa90a9c00
 SRC_URI[libgit2-sys-0.18.2+1.9.1.sha256sum] = "1c42fe03df2bd3c53a3a9c7317ad91d80c81cd1fb0caec8d7cc4cd2bfa10c222"
 SRC_URI[libloading-0.8.8.sha256sum] = "07033963ba89ebaf1584d767badaa2e8fcec21aedea6b8c0346d487d49c28667"
 SRC_URI[libnghttp2-sys-0.1.11+1.64.0.sha256sum] = "1b6c24e48a7167cffa7119da39d577fa482e66c688a4aac016bee862e1a713c4"
-SRC_URI[libredox-0.1.4.sha256sum] = "1580801010e535496706ba011c15f8532df6b42297d2e471fec38ceadd8c0638"
+SRC_URI[libredox-0.1.9.sha256sum] = "391290121bad3d37fbddad76d8f5d1c1c314cfc646d143d7e07a3086ddff0ce3"
 SRC_URI[libsqlite3-sys-0.32.0.sha256sum] = "fbb8270bb4060bd76c6e96f20c52d80620f1d82a3470885694e41e0f81ef6fe7"
 SRC_URI[libssh2-sys-0.3.1.sha256sum] = "220e4f05ad4a218192533b300327f5150e809b54c4ec83b5a1d91833601811b9"
 SRC_URI[libz-rs-sys-0.5.1.sha256sum] = "172a788537a2221661b480fee8dc5f96c580eb34fa88764d3205dc356c7e4221"
 SRC_URI[libz-sys-1.1.22.sha256sum] = "8b70e7a7df205e92a1a4cd9aaae7898dac0aa555503cc0a649494d0d60e7651d"
-SRC_URI[linux-raw-sys-0.4.15.sha256sum] = "d26c52dbd32dccf2d10cac7725f8eae5296885fb5703b261f7d0a0739ec807ab"
 SRC_URI[linux-raw-sys-0.9.4.sha256sum] = "cd945864f07fe9f5371a27ad7b52a172b4b499999f1d97574c9fa68373937e12"
 SRC_URI[litemap-0.8.0.sha256sum] = "241eaef5fd12c88705a01fc1066c48c4b36e0dd4377dcdc7ec3942cea7a69956"
 SRC_URI[lock_api-0.4.13.sha256sum] = "96936507f153605bddfcda068dd804796c84324ed2510809e5b2a624c81da765"
@@ -611,7 +596,7 @@ SRC_URI[log-0.4.27.sha256sum] = "13dc2df351e3202783a1fe0d44375f7295ffb4049267b0f
 SRC_URI[matchers-0.1.0.sha256sum] = "8263075bb86c5a1b1427b5ae862e8889656f126e9f77c484496e8b47cf5c5558"
 SRC_URI[maybe-async-0.2.10.sha256sum] = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
 SRC_URI[memchr-2.7.5.sha256sum] = "32a282da65faaf38286cf3be983213fcf1d2e2a58700e808f83f4ea9a4804bc0"
-SRC_URI[memmap2-0.9.5.sha256sum] = "fd3f7eed9d3848f8b98834af67102b720745c4ec028fcd0aa0239277e7de374f"
+SRC_URI[memmap2-0.9.7.sha256sum] = "483758ad303d734cec05e5c12b41d7e93e6a6390c5e9dae6bdeb7c1259012d28"
 SRC_URI[memoffset-0.9.1.sha256sum] = "488016bfae457b036d996092f6cb448677611ce4449e970ceaf42695203f218a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[miniz_oxide-0.8.9.sha256sum] = "1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
@@ -621,15 +606,14 @@ SRC_URI[normpath-1.3.0.sha256sum] = "c8911957c4b1549ac0dc74e30db9c8b0e66ddcd6d7a
 SRC_URI[nu-ansi-term-0.46.0.sha256sum] = "77a8165726e8236064dbb45459242600304b42a5ea24ee2948e18e023bf7ba84"
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
-SRC_URI[object-0.36.7.sha256sum] = "62948e14d923ea95ea2c7c86c71013138b66525b86bdc08d2dcc262bdb497b87"
-SRC_URI[object-0.37.1.sha256sum] = "03fd943161069e1768b4b3d050890ba48730e590f57e56d4aa04e7e090e61b4a"
+SRC_URI[object-0.37.2.sha256sum] = "b3e3d0a7419f081f4a808147e845310313a39f322d7ae1f996b7f001d6cbed04"
 SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
 SRC_URI[once_cell_polyfill-1.70.1.sha256sum] = "a4895175b425cb1f87721b59f0f286c2092bd4af812243672510e1ac53e2e0ad"
 SRC_URI[opener-0.7.2.sha256sum] = "d0812e5e4df08da354c851a3376fead46db31c2214f849d3de356d774d057681"
 SRC_URI[openssl-0.10.73.sha256sum] = "8505734d46c8ab1e19a1dce3aef597ad87dcb4c37e7188231769bd6bd51cebf8"
 SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
 SRC_URI[openssl-probe-0.1.6.sha256sum] = "d05e27ee213611ffe7d6348b942e8f942b37114c00cc03cec254295a4a17852e"
-SRC_URI[openssl-src-300.5.0+3.5.0.sha256sum] = "e8ce546f549326b0e6052b649198487d91320875da901e7bd11a06d1ee3f9c2f"
+SRC_URI[openssl-src-300.5.2+3.5.2.sha256sum] = "d270b79e2926f5150189d475bc7e9d2c69f9c4697b185fa917d5a32b792d21b4"
 SRC_URI[openssl-sys-0.9.109.sha256sum] = "90096e2e47630d78b7d1c20952dc621f957103f8bc2c8359ec81290d75238571"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
 SRC_URI[orion-0.17.11.sha256sum] = "21b3da83b2b4cdc74ab6a556b2e7b473da046d5aa4008c0a7a3ae96b1b4aabb4"
@@ -638,14 +622,14 @@ SRC_URI[overload-0.1.1.sha256sum] = "b15813163c1d831bf4a13c3610c05c0d03b39feb07f
 SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
 SRC_URI[parking_lot-0.12.4.sha256sum] = "70d58bf43669b5795d1576d0641cfb6fbb2057bf629506267a92807158584a13"
 SRC_URI[parking_lot_core-0.9.11.sha256sum] = "bc838d2a56b5b1a6c25f55575dfc605fabb63bb2365f6c2353ef9159aa69e4a5"
-SRC_URI[pasetors-0.7.6.sha256sum] = "8c1c6d47c07a08cb59ddad44d53cb5729855e35f7d993184cec3aa37ccdb7008"
+SRC_URI[pasetors-0.7.7.sha256sum] = "03e1ed71dcdf863d9f66d9de86de714db38aedc2fcabc1a60207d1fde603e2d5"
 SRC_URI[pathdiff-0.2.3.sha256sum] = "df94ce210e5bc13cb6651479fa48d14f601d9858cfe0467f43ae157023b938d3"
 SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
 SRC_URI[percent-encoding-2.3.1.sha256sum] = "e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
 SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
 SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
-SRC_URI[plist-1.7.2.sha256sum] = "3d77244ce2d584cd84f6a15f86195b8c9b2a0dfbfd817c09e0464244091a58ed"
+SRC_URI[plist-1.7.4.sha256sum] = "3af6b589e163c5a788fab00ce0c0366f6efbb9959c2f9874b224936af7fce7e1"
 SRC_URI[portable-atomic-1.11.1.sha256sum] = "f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
 SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
 SRC_URI[potential_utf-0.1.2.sha256sum] = "e5a7c30837279ca13e7c867e9e40053bc68740f988cb07f7ca6df43cc734b585"
@@ -654,15 +638,15 @@ SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
 SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
 SRC_URI[prodash-29.0.2.sha256sum] = "f04bb108f648884c23b98a0e940ebc2c93c0c3b89f04dbaf7eb8256ce617d1bc"
-SRC_URI[quick-xml-0.37.5.sha256sum] = "331e97a1af0bf59823e6eadffe373d7b27f485be8748f71471c662c1f269b7fb"
+SRC_URI[quick-xml-0.38.1.sha256sum] = "9845d9dccf565065824e69f9f235fafba1587031eda353c1f1561cd6a6be78f4"
 SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
-SRC_URI[rand-0.9.1.sha256sum] = "9fbfd9d094a40bf3ae768db9361049ace4c0e04a4fd6b359518bd7b73a73dd97"
+SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
-SRC_URI[redox_syscall-0.5.13.sha256sum] = "0d04b7d0ee6b4a0207a0a7adb104d23ecb0b47d6beae7152d0fa34b692b29fd6"
+SRC_URI[redox_syscall-0.5.17.sha256sum] = "5407465600fb0548f1442edf71dd20683c6ed326200ace4b1ef0763521bb3b77"
 SRC_URI[regex-1.11.1.sha256sum] = "b544ef1b4eac5dc2db33ea63606ae9ffcfac26c1416a2806ae0bf5f56b201191"
 SRC_URI[regex-automata-0.1.10.sha256sum] = "6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
 SRC_URI[regex-automata-0.4.9.sha256sum] = "809e8dc61f6de73b46c85f4c96486310fe304c434cfa43669d7b40f711150908"
@@ -673,14 +657,13 @@ SRC_URI[rusqlite-0.34.0.sha256sum] = "37e34486da88d8e051c7c0e23c3f15fd806ea85462
 SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
 SRC_URI[rustfix-0.9.1.sha256sum] = "8abe01883100061761642e19324f87514bcaed7ddaab2dfd68041c992987b289"
-SRC_URI[rustix-0.38.44.sha256sum] = "fdb5bc1ae2baa591800df16c9ca78619bf65c0488b41b96ccec5d11220d8c154"
-SRC_URI[rustix-1.0.7.sha256sum] = "c71e83d6afe7ff64890ec6b71d6a69bb8a610ab78ce364b3352876bb4c801266"
+SRC_URI[rustix-1.0.8.sha256sum] = "11181fbabf243db407ef8df94a6ce0b2f9a733bd8be4ad02b4eda9602296cac8"
 SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[schannel-0.1.27.sha256sum] = "1f29ebaa345f945cec9fbbc532eb307f0fdad8161f281b6369539c8d84876b3d"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
 SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
-SRC_URI[security-framework-3.2.0.sha256sum] = "271720403f46ca04f7ba6f55d438f8bd878d6b8ca0a1046e8228c4145bcbb316"
+SRC_URI[security-framework-3.3.0.sha256sum] = "80fb1d92c5028aa318b4b8bd7302a5bfcf48be96a37fc6fc790f806b0004ee0c"
 SRC_URI[security-framework-sys-2.14.0.sha256sum] = "49db231d56a190491cb4aeda9527f1ad45345af50b0851622a7adb8c03b01c32"
 SRC_URI[semver-1.0.26.sha256sum] = "56e6fa9c48d24d85fb3de5ad847117517440f6beceb7798af16b4a87d616b8d0"
 SRC_URI[serde-1.0.219.sha256sum] = "5f0e2c6ed6606019b4e29e69dbaba95b11854410e5347d525002456dbbb786b6"
@@ -688,7 +671,7 @@ SRC_URI[serde-untagged-0.1.7.sha256sum] = "299d9c19d7d466db4ab10addd5703e4c615de
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
 SRC_URI[serde_derive-1.0.219.sha256sum] = "5b0276cf7f2c73365f7157c8123c21cd9a50fbbd844757af28ca1f5925fc2a00"
 SRC_URI[serde_ignored-0.1.12.sha256sum] = "b516445dac1e3535b6d658a7b528d771153dfb272ed4180ca4617a20550365ff"
-SRC_URI[serde_json-1.0.140.sha256sum] = "20068b6e96dc6c9bd23e01df8827e6c7e1f2fddd43c21810382803c136b99373"
+SRC_URI[serde_json-1.0.142.sha256sum] = "030fedb782600dcbd6f02d479bf0d817ac3bb40d644745b769d6a96bc3afc5a7"
 SRC_URI[serde_spanned-0.6.9.sha256sum] = "bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
 SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
 SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832b03984598375bff3975b804423"
@@ -760,13 +743,14 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.9.sha256sum] = "cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+SRC_URI[windows-link-0.1.3.sha256sum] = "5e6ad25900d524eaabdbbb96d20b4311e1e7ae1699af4fb28c17ae66c80d798a"
 SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
 SRC_URI[windows-sys-0.60.2.sha256sum] = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
 SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows-targets-0.53.2.sha256sum] = "c66f69fcc9ce11da9966ddb31a40968cad001c5bedeb5c2b82ede4253ab48aef"
+SRC_URI[windows-targets-0.53.3.sha256sum] = "d5fe6031c4041849d7c496a8ded650796e7b6ecc19df1a431c1a363342e5dc91"
 SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
 SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
 SRC_URI[windows_aarch64_gnullvm-0.53.0.sha256sum] = "86b8d5f90ddd19cb4a147a5fa63ca848db3df085e25fee3cc10b39b6eebae764"
@@ -790,7 +774,7 @@ SRC_URI[windows_x86_64_gnullvm-0.53.0.sha256sum] = "0a6e035dd0599267ce1ee132e51c
 SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[windows_x86_64_msvc-0.53.0.sha256sum] = "271414315aff87387382ec3d271b52d7ae78726f5d44ac98b4f4030c91880486"
-SRC_URI[winnow-0.7.11.sha256sum] = "74c7b26e3480b707944fc872477815d29a8e429d2f93a1ce000f5fa84a15cbcd"
+SRC_URI[winnow-0.7.12.sha256sum] = "f3edebf492c8125044983378ecb5766203ad3b4c2f7a922bd7dd207f6d443e95"
 SRC_URI[wit-bindgen-rt-0.39.0.sha256sum] = "6f42320e61fe2cfd34354ecb597f86f413484a798ba44a8ca1165c58d42da6c1"
 SRC_URI[writeable-0.6.1.sha256sum] = "ea2f10b9bb0928dfb1b42b65e1f9e36f7f54dbdf08457afefb38afcdec4fa2bb"
 SRC_URI[yoke-0.8.0.sha256sum] = "5f41bb01b8226ef4bfd589436a297c53d118f65921786300e427be8d487695cc"
@@ -801,6 +785,6 @@ SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870f
 SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
 SRC_URI[zeroize-1.8.1.sha256sum] = "ced3678a2879b30306d323f4542626697a464a97c0a07c9aebf7ebca65cd4dde"
 SRC_URI[zerotrie-0.2.2.sha256sum] = "36f0bbd478583f79edad978b407914f61b2972f5af6fa089686016be8f9af595"
-SRC_URI[zerovec-0.11.2.sha256sum] = "4a05eb080e015ba39cc9e23bbe5e7fb04d5fb040350f99f34e338d5fdd294428"
+SRC_URI[zerovec-0.11.4.sha256sum] = "e7aa2bd55086f1ab526693ecbe444205da57e25f4489879da80635a46d90e73b"
 SRC_URI[zerovec-derive-0.11.1.sha256sum] = "5b96237efa0c878c64bd89c436f661be4e46b2f3eff1ebb976f7ef2321d2f58f"
 SRC_URI[zlib-rs-0.5.1.sha256sum] = "626bd9fa9734751fc50d6060752170984d7053f5a39061f524cda68023d4db8a"
diff --git a/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb b/recipes-devtools/rust/cargo-c_0.10.15+cargo-0.90.0.bb
similarity index 87%
rename from recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.15+cargo-0.90.0.bb
index f21fa95..911f5be 100644
--- a/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.15+cargo-0.90.0.bb
@@ -9,7 +9,7 @@ SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../getrandom-0.3.3/ \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.11/ \
 "
-SRC_URI[cargo-c.sha256sum] = "fe82742019f0e5c1a9f8549b0f41b20f1bc834f5ed0626c47019f15be566b321"
+SRC_URI[cargo-c.sha256sum] = "32a05aa20690ce4b2ce5f8cf409ba112f7f11161f017e8430f549af3890dc948"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 inherit cargo cargo-update-recipe-crates pkgconfig
-- 
2.51.0


