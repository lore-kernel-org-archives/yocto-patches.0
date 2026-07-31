Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA54C5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4579.1785497600164401795
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZPM43Ilf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee88fce572so8552776d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497599; x=1786102399; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Ls66DdLRVQ7lN7GzgS8OwfNpQL+/bdKB6yh4mH5VU0=;
        b=ZPM43IlfRasVZJKwbOOVuuzj6WzMk7YiO9nqG44X5S9+tJnVR2IIAyRLgG8Y1p6DUu
         FqT54tFD9F1A9kMwjK28pj/dUNqtTmuTuVDkneXATXH3Osu8Ag05VJaUzkCwlzz4pyCK
         AuzdtdZijWx+MVGbgXWzeMNERbPTEjfHq2AMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497599; x=1786102399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Ls66DdLRVQ7lN7GzgS8OwfNpQL+/bdKB6yh4mH5VU0=;
        b=dSMOuQinPscJK+AKOBX77qDNCR0GonTtR2cGBVCIi2Tj+P2V27xS1M/CIhqmx++GZf
         07hoa7CxyeTbTDD99KHhVHFCR5tSojNgucwpPi8XUTnNgsGA2krQ+7ZZC20NU4bPrJOT
         WOhECElPYuE9QGE0TlptNKrvYhqg4UwynCQibmWqm3AheBjuSgp5iL+eot1htMVi3z9l
         G72NxMGGL9FMBniBN8bZgImdOu0jvwqJHLFh6Du8BftG+OLPJZ2kpVjaFJakZXKQVSCn
         /n4Cc/keIfDb0IRitbOxdxkFKqpQkCjMPTKm6jMOpigULy1lcBzNd0iiJhxNH8zRMPD8
         PEsA==
X-Gm-Message-State: AOJu0YxdMTP96KytJdJu/T+2Qy56dPCisVfh6qC/sl2U2ll2KIbFcWbY
	J1jHyRIKV7bLCE5uS3LHqfCnuQLdNTTsEviPeP6j1wsNttdVDRyx9Wm1A0jHxaOx6JOs1MPXZzD
	5wGOm
X-Gm-Gg: AR+sD11+kbOvIMvGp5BdAeqRYgbrKtGzb9gnharSrnrv5TQYnDRvRyIUE1CFp3ZtFKw
	OOPLQq7UGQWk23HTk5y1yTrucKFdiYA8odihBpfXuLo3Ga0dE8kgG1C7cPaxDqE+tDj6MDRSOVK
	JSRLodHReoBRAyas0NQtm0jGqy7XP4vgW35Ub6xsCYGCXkrwXlSjUMddyrSrH7O7pRcqp1y38dk
	tChBOFJqvmt1q7PprXO9yL7JQ+0Zp/+g6xDweM6IpWxyMk3xU5Qe/szjpjMcAosn5inI7EtuTmF
	BzEvXmrS+rT/GGyVybolz8Hih/Ud71Dvw79KLWKIbRiL9JzcffIcKU+/KdHLY2FvKrduYGNWy2L
	Crcuy6che9SpZUShb3WAihErBdnoM9MRhFrmHVPDYWY9yL9cxWKf0MtC+o/POOFAV9Z7P1DKI+S
	z4RYQCGlYpB0lEtG2hY8jX1jA9EYQhnSimLzN3fib4hdfV6r/3nLfPko4ABJjHzxlXwOP5qzHm6
	R/fzl9YdRiBY8rU+sCR92HaPHz9F6uzej8jVedZFFt4upOrwldUgohJ4f2DAQTh0c95Qc3rf5dJ
	mO93MAtSGKnJi0ctigNIwUcANfg=
X-Received: by 2002:a05:620a:2418:10b0:92e:fe10:3eed with SMTP id af79cd13be357-934968bf07bmr176727185a.44.1785497598206;
        Fri, 31 Jul 2026 04:33:18 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 01/35] cargo-c: update 0.10.19 -> 0.10.20
Date: Fri, 31 Jul 2026 07:32:31 -0400
Message-ID: <e5a21b25f5523dcdb59028732e0d8252cc4c5b0f.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4578

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Changes are here:
https://github.com/lu-zero/cargo-c/compare/v0.10.19..v0.10.20

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 5116d9822a101590895efbe1d6da03b904a76ca5)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c-crates.inc      | 434 +++++++++---------
 ...3.0.bb => cargo-c_0.10.20+cargo-0.94.0.bb} |   2 +-
 2 files changed, 219 insertions(+), 217 deletions(-)
 rename recipes-devtools/rust/{cargo-c_0.10.19+cargo-0.93.0.bb => cargo-c_0.10.20+cargo-0.94.0.bb} (87%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/rust/cargo-c-crates.inc
index 9155299..e438d0e 100644
--- a/recipes-devtools/rust/cargo-c-crates.inc
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -13,49 +13,50 @@ SRC_URI += " \
     crate://crates.io/anstyle-query/1.1.5 \
     crate://crates.io/anstyle-wincon/3.0.11 \
     crate://crates.io/anyhow/1.0.100 \
-    crate://crates.io/arc-swap/1.7.1 \
+    crate://crates.io/arc-swap/1.8.0 \
     crate://crates.io/arrayref/0.3.9 \
     crate://crates.io/arrayvec/0.7.6 \
     crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/base16ct/0.2.0 \
     crate://crates.io/base64/0.22.1 \
-    crate://crates.io/base64ct/1.8.1 \
+    crate://crates.io/base64ct/1.8.3 \
     crate://crates.io/bitflags/2.10.0 \
     crate://crates.io/bitmaps/2.1.0 \
-    crate://crates.io/blake3/1.8.2 \
+    crate://crates.io/blake3/1.8.3 \
     crate://crates.io/block-buffer/0.10.4 \
     crate://crates.io/block2/0.6.2 \
     crate://crates.io/bstr/1.12.1 \
-    crate://crates.io/bumpalo/3.19.0 \
+    crate://crates.io/bumpalo/3.19.1 \
     crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/bytes/1.11.0 \
-    crate://crates.io/cargo/0.93.0 \
+    crate://crates.io/camino/1.2.2 \
+    crate://crates.io/cargo/0.94.0 \
     crate://crates.io/cargo-credential/0.4.9 \
-    crate://crates.io/cargo-credential-libsecret/0.5.3 \
-    crate://crates.io/cargo-credential-macos-keychain/0.4.18 \
-    crate://crates.io/cargo-credential-wincred/0.4.18 \
+    crate://crates.io/cargo-credential-libsecret/0.5.4 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.19 \
+    crate://crates.io/cargo-credential-wincred/0.4.19 \
     crate://crates.io/cargo-platform/0.3.2 \
-    crate://crates.io/cargo-util/0.2.25 \
-    crate://crates.io/cargo-util-schemas/0.10.2 \
+    crate://crates.io/cargo-util/0.2.26 \
+    crate://crates.io/cargo-util-schemas/0.11.0 \
     crate://crates.io/cbindgen/0.29.2 \
-    crate://crates.io/cc/1.2.49 \
+    crate://crates.io/cc/1.2.54 \
     crate://crates.io/cfg-if/1.0.4 \
     crate://crates.io/cfg_aliases/0.2.1 \
-    crate://crates.io/clap/4.5.53 \
-    crate://crates.io/clap_builder/4.5.53 \
-    crate://crates.io/clap_complete/4.5.61 \
+    crate://crates.io/clap/4.5.54 \
+    crate://crates.io/clap_builder/4.5.54 \
+    crate://crates.io/clap_complete/4.5.65 \
     crate://crates.io/clap_derive/4.5.49 \
-    crate://crates.io/clap_lex/0.7.6 \
+    crate://crates.io/clap_lex/0.7.7 \
     crate://crates.io/clru/0.6.2 \
     crate://crates.io/color-print/0.3.7 \
     crate://crates.io/color-print-proc-macro/0.3.7 \
     crate://crates.io/colorchoice/1.0.4 \
     crate://crates.io/const-oid/0.9.6 \
-    crate://crates.io/constant_time_eq/0.3.1 \
+    crate://crates.io/constant_time_eq/0.4.2 \
     crate://crates.io/core-foundation/0.10.1 \
     crate://crates.io/core-foundation-sys/0.8.7 \
     crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crates-io/0.40.15 \
+    crate://crates.io/crates-io/0.40.16 \
     crate://crates.io/crc32fast/1.5.0 \
     crate://crates.io/crossbeam-channel/0.5.15 \
     crate://crates.io/crossbeam-deque/0.8.6 \
@@ -65,7 +66,7 @@ SRC_URI += " \
     crate://crates.io/crypto-common/0.1.6 \
     crate://crates.io/ct-codecs/1.1.6 \
     crate://crates.io/curl/0.4.49 \
-    crate://crates.io/curl-sys/0.4.84+curl-8.17.0 \
+    crate://crates.io/curl-sys/0.4.85+curl-8.18.0 \
     crate://crates.io/dashmap/6.1.0 \
     crate://crates.io/der/0.7.10 \
     crate://crates.io/deranged/0.5.5 \
@@ -87,69 +88,70 @@ SRC_URI += " \
     crate://crates.io/fastrand/2.3.0 \
     crate://crates.io/ff/0.13.1 \
     crate://crates.io/fiat-crypto/0.3.0 \
-    crate://crates.io/filetime/0.2.26 \
-    crate://crates.io/find-msvc-tools/0.1.5 \
-    crate://crates.io/flate2/1.1.5 \
+    crate://crates.io/filetime/0.2.27 \
+    crate://crates.io/find-msvc-tools/0.1.8 \
+    crate://crates.io/flate2/1.1.8 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/foldhash/0.1.5 \
+    crate://crates.io/foldhash/0.2.0 \
     crate://crates.io/foreign-types/0.3.2 \
     crate://crates.io/foreign-types-shared/0.1.1 \
     crate://crates.io/form_urlencoded/1.2.2 \
     crate://crates.io/generic-array/0.14.9 \
-    crate://crates.io/getrandom/0.2.16 \
+    crate://crates.io/getrandom/0.2.17 \
     crate://crates.io/getrandom/0.3.4 \
     crate://crates.io/git2/0.20.3 \
     crate://crates.io/git2-curl/0.21.0 \
-    crate://crates.io/gix/0.73.0 \
+    crate://crates.io/gix/0.74.1 \
     crate://crates.io/gix-actor/0.35.6 \
-    crate://crates.io/gix-attributes/0.27.0 \
+    crate://crates.io/gix-attributes/0.28.1 \
     crate://crates.io/gix-bitmap/0.2.15 \
     crate://crates.io/gix-chunk/0.4.12 \
-    crate://crates.io/gix-command/0.6.3 \
-    crate://crates.io/gix-commitgraph/0.29.0 \
-    crate://crates.io/gix-config/0.46.0 \
+    crate://crates.io/gix-command/0.6.5 \
+    crate://crates.io/gix-commitgraph/0.30.1 \
+    crate://crates.io/gix-config/0.47.1 \
     crate://crates.io/gix-config-value/0.15.3 \
-    crate://crates.io/gix-credentials/0.30.0 \
+    crate://crates.io/gix-credentials/0.31.1 \
     crate://crates.io/gix-date/0.10.7 \
-    crate://crates.io/gix-diff/0.53.0 \
-    crate://crates.io/gix-dir/0.15.0 \
-    crate://crates.io/gix-discover/0.41.0 \
-    crate://crates.io/gix-features/0.43.1 \
-    crate://crates.io/gix-filter/0.20.0 \
-    crate://crates.io/gix-fs/0.16.1 \
-    crate://crates.io/gix-glob/0.21.0 \
-    crate://crates.io/gix-hash/0.19.0 \
-    crate://crates.io/gix-hashtable/0.9.0 \
-    crate://crates.io/gix-ignore/0.16.0 \
-    crate://crates.io/gix-index/0.41.0 \
-    crate://crates.io/gix-lock/18.0.0 \
-    crate://crates.io/gix-negotiate/0.21.0 \
-    crate://crates.io/gix-object/0.50.2 \
-    crate://crates.io/gix-odb/0.70.0 \
-    crate://crates.io/gix-pack/0.60.0 \
+    crate://crates.io/gix-diff/0.54.1 \
+    crate://crates.io/gix-dir/0.16.0 \
+    crate://crates.io/gix-discover/0.42.0 \
+    crate://crates.io/gix-features/0.44.1 \
+    crate://crates.io/gix-filter/0.21.0 \
+    crate://crates.io/gix-fs/0.17.0 \
+    crate://crates.io/gix-glob/0.22.1 \
+    crate://crates.io/gix-hash/0.20.1 \
+    crate://crates.io/gix-hashtable/0.10.0 \
+    crate://crates.io/gix-ignore/0.17.1 \
+    crate://crates.io/gix-index/0.42.1 \
+    crate://crates.io/gix-lock/19.0.0 \
+    crate://crates.io/gix-negotiate/0.22.0 \
+    crate://crates.io/gix-object/0.51.1 \
+    crate://crates.io/gix-odb/0.71.1 \
+    crate://crates.io/gix-pack/0.61.1 \
     crate://crates.io/gix-packetline/0.19.3 \
     crate://crates.io/gix-packetline-blocking/0.19.3 \
     crate://crates.io/gix-path/0.10.22 \
-    crate://crates.io/gix-pathspec/0.12.0 \
+    crate://crates.io/gix-pathspec/0.13.0 \
     crate://crates.io/gix-prompt/0.11.2 \
-    crate://crates.io/gix-protocol/0.51.0 \
+    crate://crates.io/gix-protocol/0.52.1 \
     crate://crates.io/gix-quote/0.6.1 \
-    crate://crates.io/gix-ref/0.53.1 \
-    crate://crates.io/gix-refspec/0.31.0 \
-    crate://crates.io/gix-revision/0.35.0 \
-    crate://crates.io/gix-revwalk/0.21.0 \
+    crate://crates.io/gix-ref/0.54.1 \
+    crate://crates.io/gix-refspec/0.32.0 \
+    crate://crates.io/gix-revision/0.36.1 \
+    crate://crates.io/gix-revwalk/0.22.0 \
     crate://crates.io/gix-sec/0.12.2 \
-    crate://crates.io/gix-shallow/0.5.0 \
-    crate://crates.io/gix-status/0.20.0 \
-    crate://crates.io/gix-submodule/0.20.0 \
-    crate://crates.io/gix-tempfile/18.0.0 \
-    crate://crates.io/gix-trace/0.1.15 \
-    crate://crates.io/gix-transport/0.48.0 \
-    crate://crates.io/gix-traverse/0.47.0 \
-    crate://crates.io/gix-url/0.32.0 \
+    crate://crates.io/gix-shallow/0.6.0 \
+    crate://crates.io/gix-status/0.21.1 \
+    crate://crates.io/gix-submodule/0.21.0 \
+    crate://crates.io/gix-tempfile/19.0.1 \
+    crate://crates.io/gix-trace/0.1.17 \
+    crate://crates.io/gix-transport/0.49.1 \
+    crate://crates.io/gix-traverse/0.48.0 \
+    crate://crates.io/gix-url/0.33.2 \
     crate://crates.io/gix-utils/0.3.1 \
     crate://crates.io/gix-validate/0.10.1 \
-    crate://crates.io/gix-worktree/0.42.0 \
+    crate://crates.io/gix-worktree/0.43.1 \
     crate://crates.io/glob/0.3.3 \
     crate://crates.io/globset/0.4.18 \
     crate://crates.io/group/0.13.0 \
@@ -178,28 +180,27 @@ SRC_URI += " \
     crate://crates.io/im-rc/15.1.0 \
     crate://crates.io/imara-diff/0.1.8 \
     crate://crates.io/implib/0.4.0 \
-    crate://crates.io/indexmap/2.12.1 \
+    crate://crates.io/indexmap/2.13.0 \
     crate://crates.io/is_executable/1.0.5 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.14.0 \
-    crate://crates.io/itoa/1.0.15 \
-    crate://crates.io/jiff/0.2.16 \
-    crate://crates.io/jiff-static/0.2.16 \
+    crate://crates.io/itoa/1.0.17 \
+    crate://crates.io/jiff/0.2.18 \
+    crate://crates.io/jiff-static/0.2.18 \
     crate://crates.io/jiff-tzdb/0.1.5 \
     crate://crates.io/jiff-tzdb-platform/0.1.3 \
     crate://crates.io/jobserver/0.1.34 \
-    crate://crates.io/js-sys/0.3.83 \
+    crate://crates.io/js-sys/0.3.85 \
     crate://crates.io/kstring/2.0.2 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/lazycell/1.3.0 \
-    crate://crates.io/libc/0.2.178 \
+    crate://crates.io/libc/0.2.180 \
     crate://crates.io/libgit2-sys/0.18.3+1.9.2 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/libnghttp2-sys/0.1.11+1.64.0 \
-    crate://crates.io/libredox/0.1.10 \
+    crate://crates.io/libredox/0.1.12 \
     crate://crates.io/libsqlite3-sys/0.35.0 \
     crate://crates.io/libssh2-sys/0.3.1 \
-    crate://crates.io/libz-rs-sys/0.5.4 \
+    crate://crates.io/libz-rs-sys/0.5.5 \
     crate://crates.io/libz-sys/1.1.23 \
     crate://crates.io/linux-raw-sys/0.11.0 \
     crate://crates.io/litemap/0.8.1 \
@@ -217,7 +218,7 @@ SRC_URI += " \
     crate://crates.io/nom/7.1.3 \
     crate://crates.io/normpath/1.5.0 \
     crate://crates.io/nu-ansi-term/0.50.3 \
-    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-conv/0.2.0 \
     crate://crates.io/num-traits/0.2.19 \
     crate://crates.io/objc2/0.6.3 \
     crate://crates.io/objc2-cloud-kit/0.3.2 \
@@ -234,7 +235,7 @@ SRC_URI += " \
     crate://crates.io/objc2-ui-kit/0.3.2 \
     crate://crates.io/objc2-user-notifications/0.3.2 \
     crate://crates.io/object/0.37.3 \
-    crate://crates.io/object/0.38.0 \
+    crate://crates.io/object/0.38.1 \
     crate://crates.io/once_cell/1.21.3 \
     crate://crates.io/once_cell_polyfill/1.70.2 \
     crate://crates.io/opener/0.8.3 \
@@ -244,8 +245,8 @@ SRC_URI += " \
     crate://crates.io/openssl-src/300.5.4+3.5.4 \
     crate://crates.io/openssl-sys/0.9.111 \
     crate://crates.io/ordered-float/2.10.1 \
-    crate://crates.io/orion/0.17.11 \
-    crate://crates.io/os_info/3.13.0 \
+    crate://crates.io/orion/0.17.12 \
+    crate://crates.io/os_info/3.14.0 \
     crate://crates.io/p384/0.13.1 \
     crate://crates.io/parking_lot/0.12.5 \
     crate://crates.io/parking_lot_core/0.9.12 \
@@ -256,22 +257,23 @@ SRC_URI += " \
     crate://crates.io/pin-project-lite/0.2.16 \
     crate://crates.io/pkcs8/0.10.2 \
     crate://crates.io/pkg-config/0.3.32 \
-    crate://crates.io/portable-atomic/1.11.1 \
+    crate://crates.io/portable-atomic/1.13.0 \
     crate://crates.io/portable-atomic-util/0.2.4 \
     crate://crates.io/potential_utf/0.1.4 \
     crate://crates.io/powerfmt/0.2.0 \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/primeorder/0.13.6 \
-    crate://crates.io/proc-macro2/1.0.103 \
+    crate://crates.io/proc-macro2/1.0.106 \
     crate://crates.io/prodash/30.0.1 \
-    crate://crates.io/quote/1.0.42 \
+    crate://crates.io/quote/1.0.44 \
     crate://crates.io/r-efi/5.3.0 \
     crate://crates.io/rand/0.9.2 \
     crate://crates.io/rand_chacha/0.9.0 \
     crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/rand_core/0.9.3 \
+    crate://crates.io/rand_core/0.9.5 \
     crate://crates.io/rand_xoshiro/0.6.0 \
     crate://crates.io/redox_syscall/0.5.18 \
+    crate://crates.io/redox_syscall/0.7.0 \
     crate://crates.io/regex/1.12.2 \
     crate://crates.io/regex-automata/0.4.13 \
     crate://crates.io/regex-syntax/0.8.8 \
@@ -280,9 +282,8 @@ SRC_URI += " \
     crate://crates.io/rustc-hash/2.1.1 \
     crate://crates.io/rustc-stable-hash/0.1.2 \
     crate://crates.io/rustfix/0.9.4 \
-    crate://crates.io/rustix/1.1.2 \
+    crate://crates.io/rustix/1.1.3 \
     crate://crates.io/rustversion/1.0.22 \
-    crate://crates.io/ryu/1.0.20 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/schannel/0.1.28 \
     crate://crates.io/scopeguard/1.2.0 \
@@ -296,8 +297,8 @@ SRC_URI += " \
     crate://crates.io/serde_core/1.0.228 \
     crate://crates.io/serde_derive/1.0.228 \
     crate://crates.io/serde_ignored/0.1.14 \
-    crate://crates.io/serde_json/1.0.145 \
-    crate://crates.io/serde_spanned/1.0.3 \
+    crate://crates.io/serde_json/1.0.149 \
+    crate://crates.io/serde_spanned/1.0.4 \
     crate://crates.io/sha1/0.10.6 \
     crate://crates.io/sha1-checked/0.10.0 \
     crate://crates.io/sha2/0.10.9 \
@@ -309,48 +310,47 @@ SRC_URI += " \
     crate://crates.io/simd-adler32/0.3.8 \
     crate://crates.io/sized-chunks/0.6.5 \
     crate://crates.io/smallvec/1.15.1 \
-    crate://crates.io/socket2/0.6.1 \
+    crate://crates.io/socket2/0.6.2 \
     crate://crates.io/spki/0.7.3 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/strsim/0.11.1 \
     crate://crates.io/subtle/2.6.1 \
-    crate://crates.io/supports-hyperlinks/3.1.0 \
+    crate://crates.io/supports-hyperlinks/3.2.0 \
     crate://crates.io/supports-unicode/3.0.0 \
-    crate://crates.io/syn/2.0.111 \
+    crate://crates.io/syn/2.0.114 \
     crate://crates.io/synstructure/0.13.2 \
     crate://crates.io/tar/0.4.44 \
-    crate://crates.io/tempfile/3.23.0 \
+    crate://crates.io/tempfile/3.24.0 \
     crate://crates.io/terminal_size/0.4.3 \
-    crate://crates.io/thiserror/2.0.17 \
-    crate://crates.io/thiserror-impl/2.0.17 \
+    crate://crates.io/thiserror/2.0.18 \
+    crate://crates.io/thiserror-impl/2.0.18 \
     crate://crates.io/thread_local/1.1.9 \
-    crate://crates.io/time/0.3.44 \
-    crate://crates.io/time-core/0.1.6 \
-    crate://crates.io/time-macros/0.2.24 \
+    crate://crates.io/time/0.3.46 \
+    crate://crates.io/time-core/0.1.8 \
+    crate://crates.io/time-macros/0.2.26 \
     crate://crates.io/tinystr/0.8.2 \
     crate://crates.io/tinyvec/1.10.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.9.8 \
-    crate://crates.io/toml_datetime/0.7.3 \
-    crate://crates.io/toml_edit/0.23.9 \
-    crate://crates.io/toml_parser/1.0.4 \
-    crate://crates.io/toml_writer/1.0.4 \
-    crate://crates.io/tracing/0.1.43 \
+    crate://crates.io/toml/0.9.11+spec-1.1.0 \
+    crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
+    crate://crates.io/toml_edit/0.23.10+spec-1.0.0 \
+    crate://crates.io/toml_parser/1.0.6+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.0.6+spec-1.1.0 \
+    crate://crates.io/tracing/0.1.44 \
     crate://crates.io/tracing-attributes/0.1.31 \
     crate://crates.io/tracing-chrome/0.7.2 \
-    crate://crates.io/tracing-core/0.1.35 \
+    crate://crates.io/tracing-core/0.1.36 \
     crate://crates.io/tracing-log/0.2.0 \
     crate://crates.io/tracing-subscriber/0.3.22 \
     crate://crates.io/typeid/1.0.3 \
     crate://crates.io/typenum/1.19.0 \
-    crate://crates.io/unicase/2.8.1 \
+    crate://crates.io/unicase/2.9.0 \
     crate://crates.io/unicode-bom/2.0.3 \
     crate://crates.io/unicode-ident/1.0.22 \
     crate://crates.io/unicode-normalization/0.1.25 \
     crate://crates.io/unicode-width/0.2.2 \
-    crate://crates.io/unicode-xid/0.2.6 \
-    crate://crates.io/url/2.5.7 \
+    crate://crates.io/url/2.5.8 \
     crate://crates.io/utf8_iter/1.0.4 \
     crate://crates.io/utf8parse/0.2.2 \
     crate://crates.io/valuable/0.1.1 \
@@ -358,11 +358,11 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.5 \
     crate://crates.io/walkdir/2.5.0 \
     crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
-    crate://crates.io/wasip2/1.0.1+wasi-0.2.4 \
-    crate://crates.io/wasm-bindgen/0.2.106 \
-    crate://crates.io/wasm-bindgen-macro/0.2.106 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.106 \
-    crate://crates.io/wasm-bindgen-shared/0.2.106 \
+    crate://crates.io/wasip2/1.0.2+wasi-0.2.9 \
+    crate://crates.io/wasm-bindgen/0.2.108 \
+    crate://crates.io/wasm-bindgen-macro/0.2.108 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.108 \
+    crate://crates.io/wasm-bindgen-shared/0.2.108 \
     crate://crates.io/winapi-util/0.1.11 \
     crate://crates.io/windows-link/0.2.1 \
     crate://crates.io/windows-sys/0.59.0 \
@@ -387,19 +387,20 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.53.1 \
     crate://crates.io/winnow/0.7.14 \
-    crate://crates.io/wit-bindgen/0.46.0 \
+    crate://crates.io/wit-bindgen/0.51.0 \
     crate://crates.io/writeable/0.6.2 \
     crate://crates.io/yoke/0.8.1 \
     crate://crates.io/yoke-derive/0.8.1 \
-    crate://crates.io/zerocopy/0.8.31 \
-    crate://crates.io/zerocopy-derive/0.8.31 \
+    crate://crates.io/zerocopy/0.8.33 \
+    crate://crates.io/zerocopy-derive/0.8.33 \
     crate://crates.io/zerofrom/0.1.6 \
     crate://crates.io/zerofrom-derive/0.1.6 \
     crate://crates.io/zeroize/1.8.2 \
     crate://crates.io/zerotrie/0.2.3 \
     crate://crates.io/zerovec/0.11.5 \
     crate://crates.io/zerovec-derive/0.11.2 \
-    crate://crates.io/zlib-rs/0.5.4 \
+    crate://crates.io/zlib-rs/0.5.5 \
+    crate://crates.io/zmij/1.0.16 \
 "
 
 SRC_URI[adler2-2.0.1.sha256sum] = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
@@ -413,49 +414,50 @@ SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6
 SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 SRC_URI[anyhow-1.0.100.sha256sum] = "a23eb6b1614318a8071c9b2521f36b424b2c83db5eb3a0fead4a6c0809af6e61"
-SRC_URI[arc-swap-1.7.1.sha256sum] = "69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
+SRC_URI[arc-swap-1.8.0.sha256sum] = "51d03449bb8ca2cc2ef70869af31463d1ae5ccc8fa3e334b307203fbf815207e"
 SRC_URI[arrayref-0.3.9.sha256sum] = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
 SRC_URI[arrayvec-0.7.6.sha256sum] = "7c02d123df017efcdfbd739ef81735b36c5ba83ec3c59c80a9d7ecc718f92e50"
 SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
 SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
 SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
-SRC_URI[base64ct-1.8.1.sha256sum] = "0e050f626429857a27ddccb31e0aca21356bfa709c04041aefddac081a8f068a"
+SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
 SRC_URI[bitflags-2.10.0.sha256sum] = "812e12b5285cc515a9c72a5c1d3b6d46a19dac5acfef5265968c166106e31dd3"
 SRC_URI[bitmaps-2.1.0.sha256sum] = "031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
-SRC_URI[blake3-1.8.2.sha256sum] = "3888aaa89e4b2a40fca9848e400f6a658a5a3978de7be858e209cafa8be9a4a0"
+SRC_URI[blake3-1.8.3.sha256sum] = "2468ef7d57b3fb7e16b576e8377cdbde2320c60e1491e961d11da40fc4f02a2d"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 SRC_URI[block2-0.6.2.sha256sum] = "cdeb9d870516001442e364c5220d3574d2da8dc765554b4a617230d33fa58ef5"
 SRC_URI[bstr-1.12.1.sha256sum] = "63044e1ae8e69f3b5a92c736ca6269b8d12fa7efe39bf34ddb06d102cf0e2cab"
-SRC_URI[bumpalo-3.19.0.sha256sum] = "46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
+SRC_URI[bumpalo-3.19.1.sha256sum] = "5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
 SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[bytes-1.11.0.sha256sum] = "b35204fbdc0b3f4446b89fc1ac2cf84a8a68971995d0bf2e925ec7cd960f9cb3"
-SRC_URI[cargo-0.93.0.sha256sum] = "2a9eb357bdc58680a9d65ec020f0ec258d89a70c96d491b39606fb86a42c0dd5"
+SRC_URI[camino-1.2.2.sha256sum] = "e629a66d692cb9ff1a1c664e41771b3dcaf961985a9774c0eb0bd1b51cf60a48"
+SRC_URI[cargo-0.94.0.sha256sum] = "d279f29211012cf2ecaf6c5f6845389b361ce050cc2b4bcbfcbf8c191a43fb36"
 SRC_URI[cargo-credential-0.4.9.sha256sum] = "e36f089041deadf16226478a7737a833864fbda09408c7af237b9d615eeb6d69"
-SRC_URI[cargo-credential-libsecret-0.5.3.sha256sum] = "67e287f3cc9732b9a7eb5140e9501ec6557bdcdc83366a424993e4d4db228c4a"
-SRC_URI[cargo-credential-macos-keychain-0.4.18.sha256sum] = "806cb58d7644f7c4f8c8e47af5f7f2dc4e10f0ce205f0416e8fdc6d58c7efaf2"
-SRC_URI[cargo-credential-wincred-0.4.18.sha256sum] = "a12eac22936a44d4be4765ffb9a29cbd69faab267a637c578feef62f8cc96c39"
+SRC_URI[cargo-credential-libsecret-0.5.4.sha256sum] = "d2f79375b18d08df983ce4d7c50b84e41f081588077038ff75e1ad13a6eee44d"
+SRC_URI[cargo-credential-macos-keychain-0.4.19.sha256sum] = "c173c41f718723681b45ebfdf6b027dd8a33a19e03500d45c74ffea7fc4a04d2"
+SRC_URI[cargo-credential-wincred-0.4.19.sha256sum] = "84eb64cf8c19bacc536b06a4452cac120a51703b742b0721de69e4b6553fb70c"
 SRC_URI[cargo-platform-0.3.2.sha256sum] = "87a0c0e6148f11f01f32650a2ea02d532b2ad4e81d8bd41e6e565b5adc5e6082"
-SRC_URI[cargo-util-0.2.25.sha256sum] = "03ae3fc62640c9e0235c95b07e68a59a31919d7331bd95961cc811bc0607c87b"
-SRC_URI[cargo-util-schemas-0.10.2.sha256sum] = "f714efe9b56ea4bed06b499396e77b68db663a55b16dc3f144d5a5a0dc19788c"
+SRC_URI[cargo-util-0.2.26.sha256sum] = "f70b0c7772872ac3234e46a6591091d4da57f0c3aa24c381776ed1550624a14b"
+SRC_URI[cargo-util-schemas-0.11.0.sha256sum] = "ddf185f0e9ea7f8a670e847decce09c41b536019a0deb7741d001c5836209e0e"
 SRC_URI[cbindgen-0.29.2.sha256sum] = "befbfd072a8e81c02f8c507aefce431fe5e7d051f83d48a23ffc9b9fe5a11799"
-SRC_URI[cc-1.2.49.sha256sum] = "90583009037521a116abf44494efecd645ba48b6622457080f080b85544e2215"
+SRC_URI[cc-1.2.54.sha256sum] = "6354c81bbfd62d9cfa9cb3c773c2b7b2a3a482d569de977fd0e961f6e7c00583"
 SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
 SRC_URI[cfg_aliases-0.2.1.sha256sum] = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
-SRC_URI[clap-4.5.53.sha256sum] = "c9e340e012a1bf4935f5282ed1436d1489548e8f72308207ea5df0e23d2d03f8"
-SRC_URI[clap_builder-4.5.53.sha256sum] = "d76b5d13eaa18c901fd2f7fca939fefe3a0727a953561fefdf3b2922b8569d00"
-SRC_URI[clap_complete-4.5.61.sha256sum] = "39615915e2ece2550c0149addac32fb5bd312c657f43845bb9088cb9c8a7c992"
+SRC_URI[clap-4.5.54.sha256sum] = "c6e6ff9dcd79cff5cd969a17a545d79e84ab086e444102a591e288a8aa3ce394"
+SRC_URI[clap_builder-4.5.54.sha256sum] = "fa42cf4d2b7a41bc8f663a7cab4031ebafa1bf3875705bfaf8466dc60ab52c00"
+SRC_URI[clap_complete-4.5.65.sha256sum] = "430b4dc2b5e3861848de79627b2bedc9f3342c7da5173a14eaa5d0f8dc18ae5d"
 SRC_URI[clap_derive-4.5.49.sha256sum] = "2a0b5487afeab2deb2ff4e03a807ad1a03ac532ff5a2cee5d86884440c7f7671"
-SRC_URI[clap_lex-0.7.6.sha256sum] = "a1d728cc89cf3aee9ff92b05e62b19ee65a02b5702cff7d5a377e32c6ae29d8d"
+SRC_URI[clap_lex-0.7.7.sha256sum] = "c3e64b0cc0439b12df2fa678eae89a1c56a529fd067a9115f7827f1fffd22b32"
 SRC_URI[clru-0.6.2.sha256sum] = "cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
 SRC_URI[color-print-0.3.7.sha256sum] = "3aa954171903797d5623e047d9ab69d91b493657917bdfb8c2c80ecaf9cdb6f4"
 SRC_URI[color-print-proc-macro-0.3.7.sha256sum] = "692186b5ebe54007e45a59aea47ece9eb4108e141326c304cdc91699a7118a22"
 SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
 SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
-SRC_URI[constant_time_eq-0.3.1.sha256sum] = "7c74b8349d32d297c9134b8c88677813a227df8f779daa29bfc29c183fe3dca6"
+SRC_URI[constant_time_eq-0.4.2.sha256sum] = "3d52eff69cd5e647efe296129160853a42795992097e8af39800e1060caeea9b"
 SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
 SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crates-io-0.40.15.sha256sum] = "62451b814867f57f25e941eeb22b55ada9d93308cb65578ec57e35e414091019"
+SRC_URI[crates-io-0.40.16.sha256sum] = "0f7f333ded3737da5d7ba014b465470cec2c77572f5a4bc56e1a6432cf0a9207"
 SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
 SRC_URI[crossbeam-channel-0.5.15.sha256sum] = "82b8f8f868b36967f9606790d1903570de9ceaf870a7bf9fbbd3016d636a2cb2"
 SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
@@ -465,7 +467,7 @@ SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
 SRC_URI[ct-codecs-1.1.6.sha256sum] = "9b10589d1a5e400d61f9f38f12f884cfd080ff345de8f17efda36fe0e4a02aa8"
 SRC_URI[curl-0.4.49.sha256sum] = "79fc3b6dd0b87ba36e565715bf9a2ced221311db47bd18011676f24a6066edbc"
-SRC_URI[curl-sys-0.4.84+curl-8.17.0.sha256sum] = "abc4294dc41b882eaff37973c2ec3ae203d0091341ee68fbadd1d06e0c18a73b"
+SRC_URI[curl-sys-0.4.85+curl-8.18.0.sha256sum] = "c0efa6142b5ecc05f6d3eaa39e6af4888b9d3939273fb592c92b7088a8cf3fdb"
 SRC_URI[dashmap-6.1.0.sha256sum] = "5041cc499144891f3790297212f32a74fb938e5136a14943f338ef9e0ae276cf"
 SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
 SRC_URI[deranged-0.5.5.sha256sum] = "ececcb659e7ba858fb4f10388c250a7252eb0a27373f1a72b8748afdd248e587"
@@ -487,69 +489,70 @@ SRC_URI[faster-hex-0.10.0.sha256sum] = "7223ae2d2f179b803433d9c830478527e92b8117
 SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
 SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
 SRC_URI[fiat-crypto-0.3.0.sha256sum] = "64cd1e32ddd350061ae6edb1b082d7c54915b5c672c389143b9a63403a109f24"
-SRC_URI[filetime-0.2.26.sha256sum] = "bc0505cd1b6fa6580283f6bdf70a73fcf4aba1184038c90902b92b3dd0df63ed"
-SRC_URI[find-msvc-tools-0.1.5.sha256sum] = "3a3076410a55c90011c298b04d0cfa770b00fa04e1e3c97d3f6c9de105a03844"
-SRC_URI[flate2-1.1.5.sha256sum] = "bfe33edd8e85a12a67454e37f8c75e730830d83e313556ab9ebf9ee7fbeb3bfb"
+SRC_URI[filetime-0.2.27.sha256sum] = "f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
+SRC_URI[find-msvc-tools-0.1.8.sha256sum] = "8591b0bcc8a98a64310a2fae1bb3e9b8564dd10e381e6e28010fde8e8e8568db"
+SRC_URI[flate2-1.1.8.sha256sum] = "b375d6465b98090a5f25b1c7703f3859783755aa9a80433b36e0379a3ec2f369"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[foldhash-0.1.5.sha256sum] = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
+SRC_URI[foldhash-0.2.0.sha256sum] = "77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
 SRC_URI[foreign-types-shared-0.1.1.sha256sum] = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
 SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
 SRC_URI[generic-array-0.14.9.sha256sum] = "4bb6743198531e02858aeaea5398fcc883e71851fcbcb5a2f773e2fb6cb1edf2"
-SRC_URI[getrandom-0.2.16.sha256sum] = "335ff9f135e4384c8150d6f27c6daed433577f86b4750418338c01a1a2528592"
+SRC_URI[getrandom-0.2.17.sha256sum] = "ff2abc00be7fca6ebc474524697ae276ad847ad0a6b3faa4bcb027e9a4614ad0"
 SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
 SRC_URI[git2-0.20.3.sha256sum] = "3e2b37e2f62729cdada11f0e6b3b6fe383c69c29fc619e391223e12856af308c"
 SRC_URI[git2-curl-0.21.0.sha256sum] = "be8dcabbc09ece4d30a9aa983d5804203b7e2f8054a171f792deff59b56d31fa"
-SRC_URI[gix-0.73.0.sha256sum] = "514c29cc879bdc0286b0cbc205585a49b252809eb86c69df4ce4f855ee75f635"
+SRC_URI[gix-0.74.1.sha256sum] = "5fd3a6fea165debe0e80648495f894aa2371a771e3ceb7a7dcc304f1c4344c43"
 SRC_URI[gix-actor-0.35.6.sha256sum] = "987a51a7e66db6ef4dc030418eb2a42af6b913a79edd8670766122d8af3ba59e"
-SRC_URI[gix-attributes-0.27.0.sha256sum] = "45442188216d08a5959af195f659cb1f244a50d7d2d0c3873633b1cd7135f638"
+SRC_URI[gix-attributes-0.28.1.sha256sum] = "cc6591add69314fc43db078076a8da6f07957c65abb0b21c3e1b6a3cf50aa18d"
 SRC_URI[gix-bitmap-0.2.15.sha256sum] = "5e150161b8a75b5860521cb876b506879a3376d3adc857ec7a9d35e7c6a5e531"
 SRC_URI[gix-chunk-0.4.12.sha256sum] = "5c356b3825677cb6ff579551bb8311a81821e184453cbd105e2fc5311b288eeb"
-SRC_URI[gix-command-0.6.3.sha256sum] = "095c8367c9dc4872a7706fbc39c7f34271b88b541120a4365ff0e36366f66e62"
-SRC_URI[gix-commitgraph-0.29.0.sha256sum] = "6bb23121e952f43a5b07e3e80890336cb847297467a410475036242732980d06"
-SRC_URI[gix-config-0.46.0.sha256sum] = "5dfb898c5b695fd4acfc3c0ab638525a65545d47706064dcf7b5ead6cdb136c0"
+SRC_URI[gix-command-0.6.5.sha256sum] = "46f9c425730a654835351e6da8c3c69ba1804f8b8d4e96d027254151138d5c64"
+SRC_URI[gix-commitgraph-0.30.1.sha256sum] = "826994ff6c01f1ff00d6a1844d7506717810a91ffed143da71e3bf39369751ef"
+SRC_URI[gix-config-0.47.1.sha256sum] = "1e74f57ea99025de9207db53488be4d59cf2000f617964c1b550880524fefbc3"
 SRC_URI[gix-config-value-0.15.3.sha256sum] = "2c489abb061c74b0c3ad790e24a606ef968cebab48ec673d6a891ece7d5aef64"
-SRC_URI[gix-credentials-0.30.0.sha256sum] = "0039dd3ac606dd80b16353a41b61fc237ca5cb8b612f67a9f880adfad4be4e05"
+SRC_URI[gix-credentials-0.31.1.sha256sum] = "20c2f7e9cda17bd982cfd4f7b7a2486239bb5be3e0893cf4b0178b8814ea3742"
 SRC_URI[gix-date-0.10.7.sha256sum] = "661245d045aa7c16ba4244daaabd823c562c3e45f1f25b816be2c57ee09f2171"
-SRC_URI[gix-diff-0.53.0.sha256sum] = "de854852010d44a317f30c92d67a983e691c9478c8a3fb4117c1f48626bcdea8"
-SRC_URI[gix-dir-0.15.0.sha256sum] = "dad34e4f373f94902df1ba1d2a1df3a1b29eacd15e316ac5972d842e31422dd7"
-SRC_URI[gix-discover-0.41.0.sha256sum] = "ffb180c91ca1a2cf53e828bb63d8d8f8fa7526f49b83b33d7f46cbeb5d79d30a"
-SRC_URI[gix-features-0.43.1.sha256sum] = "cd1543cd9b8abcbcebaa1a666a5c168ee2cda4dea50d3961ee0e6d1c42f81e5b"
-SRC_URI[gix-filter-0.20.0.sha256sum] = "aa6571a3927e7ab10f64279a088e0dae08e8da05547771796d7389bbe28ad9ff"
-SRC_URI[gix-fs-0.16.1.sha256sum] = "9a4d90307d064fa7230e0f87b03231be28f8ba63b913fc15346f489519d0c304"
-SRC_URI[gix-glob-0.21.0.sha256sum] = "b947db8366823e7a750c254f6bb29e27e17f27e457bf336ba79b32423db62cd5"
-SRC_URI[gix-hash-0.19.0.sha256sum] = "251fad79796a731a2a7664d9ea95ee29a9e99474de2769e152238d4fdb69d50e"
-SRC_URI[gix-hashtable-0.9.0.sha256sum] = "c35300b54896153e55d53f4180460931ccd69b7e8d2f6b9d6401122cdedc4f07"
-SRC_URI[gix-ignore-0.16.0.sha256sum] = "564d6fddf46e2c981f571b23d6ad40cb08bddcaf6fc7458b1d49727ad23c2870"
-SRC_URI[gix-index-0.41.0.sha256sum] = "2af39fde3ce4ce11371d9ce826f2936ec347318f2d1972fe98c2e7134e267e25"
-SRC_URI[gix-lock-18.0.0.sha256sum] = "b9fa71da90365668a621e184eb5b979904471af1b3b09b943a84bc50e8ad42ed"
-SRC_URI[gix-negotiate-0.21.0.sha256sum] = "1d58d4c9118885233be971e0d7a589f5cfb1a8bd6cb6e2ecfb0fc6b1b293c83b"
-SRC_URI[gix-object-0.50.2.sha256sum] = "d69ce108ab67b65fbd4fb7e1331502429d78baeb2eee10008bdef55765397c07"
-SRC_URI[gix-odb-0.70.0.sha256sum] = "9c9d7af10fda9df0bb4f7f9bd507963560b3c66cb15a5b825caf752e0eb109ac"
-SRC_URI[gix-pack-0.60.0.sha256sum] = "d8571df89bfca5abb49c3e3372393f7af7e6f8b8dbe2b96303593cef5b263019"
+SRC_URI[gix-diff-0.54.1.sha256sum] = "cd78d9da421baca219a650d71c797706117095635d7963f21bb6fdf2410abe04"
+SRC_URI[gix-dir-0.16.0.sha256sum] = "f99fb4dcba076453d791949bf3af977c5678a1cbd76740ec2cfe37e29431daf3"
+SRC_URI[gix-discover-0.42.0.sha256sum] = "9d24547153810634636471af88338240e6ab0831308cd41eb6ebfffea77811c6"
+SRC_URI[gix-features-0.44.1.sha256sum] = "dfa64593d1586135102307fb57fb3a9d3868b6b1f45a4da1352cce5070f8916a"
+SRC_URI[gix-filter-0.21.0.sha256sum] = "1d1253452c9808da01eaaf9b1c4929b9982efec29ef0a668b3326b8046d9b8fb"
+SRC_URI[gix-fs-0.17.0.sha256sum] = "3f1ecd896258cdc5ccd94d18386d17906b8de265ad2ecf68e3bea6b007f6a28f"
+SRC_URI[gix-glob-0.22.1.sha256sum] = "74254992150b0a88fdb3ad47635ab649512dff2cbbefca7916bb459894fc9d56"
+SRC_URI[gix-hash-0.20.1.sha256sum] = "826036a9bee95945b0be1e2394c64cd4289916c34a639818f8fd5153906985c1"
+SRC_URI[gix-hashtable-0.10.0.sha256sum] = "a27d4a3ea9640da504a2657fef3419c517fd71f1767ad8935298bcc805edd195"
+SRC_URI[gix-ignore-0.17.1.sha256sum] = "93b6a9679a1488123b7f2929684bacfd9cd2a24f286b52203b8752cbb8d7fc49"
+SRC_URI[gix-index-0.42.1.sha256sum] = "31244542fb98ea4f3e964a4f8deafc2f4c77ad42bed58a1e8424bca1965fae99"
+SRC_URI[gix-lock-19.0.0.sha256sum] = "729d7857429a66023bc0c29d60fa21d0d6ae8862f33c1937ba89e0f74dd5c67f"
+SRC_URI[gix-negotiate-0.22.0.sha256sum] = "89e16c96e052467d64c8f75a703b78976b33b034b9ff1f1d0c056c584319b0b8"
+SRC_URI[gix-object-0.51.1.sha256sum] = "87ba1815638759c80d2318c8e98296fb396f577c2e588a3d9c13f9a5d5184051"
+SRC_URI[gix-odb-0.71.1.sha256sum] = "6efc6736d3ea62640efe8c1be695fb0760af63614a7356d2091208a841f1a634"
+SRC_URI[gix-pack-0.61.1.sha256sum] = "719c60524be76874f4769da20d525ad2c00a0e7059943cc4f31fcb65cfb6b260"
 SRC_URI[gix-packetline-0.19.3.sha256sum] = "64286a8b5148e76ab80932e72762dd27ccf6169dd7a134b027c8a262a8262fcf"
 SRC_URI[gix-packetline-blocking-0.19.3.sha256sum] = "89c59c3ad41e68cb38547d849e9ef5ccfc0d00f282244ba1441ae856be54d001"
 SRC_URI[gix-path-0.10.22.sha256sum] = "7cb06c3e4f8eed6e24fd915fa93145e28a511f4ea0e768bae16673e05ed3f366"
-SRC_URI[gix-pathspec-0.12.0.sha256sum] = "daedead611c9bd1f3640dc90a9012b45f790201788af4d659f28d94071da7fba"
+SRC_URI[gix-pathspec-0.13.0.sha256sum] = "d05e28457dca7c65a2dbe118869aab922a5bd382b7bb10cff5354f366845c128"
 SRC_URI[gix-prompt-0.11.2.sha256sum] = "868e6516dfa16fdcbc5f8c935167d085f2ae65ccd4c9476a4319579d12a69d8d"
-SRC_URI[gix-protocol-0.51.0.sha256sum] = "12b4b807c47ffcf7c1e5b8119585368a56449f3493da93b931e1d4239364e922"
+SRC_URI[gix-protocol-0.52.1.sha256sum] = "64f19873bbf924fd077580d4ccaaaeddb67c3b3c09a8ffb61e6b4cb67e3c9302"
 SRC_URI[gix-quote-0.6.1.sha256sum] = "e912ec04b7b1566a85ad486db0cab6b9955e3e32bcd3c3a734542ab3af084c5b"
-SRC_URI[gix-ref-0.53.1.sha256sum] = "b966f578079a42f4a51413b17bce476544cca1cf605753466669082f94721758"
-SRC_URI[gix-refspec-0.31.0.sha256sum] = "7d29cae1ae31108826e7156a5e60bffacab405f4413f5bc0375e19772cce0055"
-SRC_URI[gix-revision-0.35.0.sha256sum] = "f651f2b1742f760bb8161d6743229206e962b73d9c33c41f4e4aefa6586cbd3d"
-SRC_URI[gix-revwalk-0.21.0.sha256sum] = "06e74f91709729e099af6721bd0fa7d62f243f2005085152301ca5cdd86ec02c"
+SRC_URI[gix-ref-0.54.1.sha256sum] = "8881d262f28eda39c244e60ae968f4f6e56c747f65addd6f4100b25f75ed8b88"
+SRC_URI[gix-refspec-0.32.0.sha256sum] = "93147960f77695ba89b72019b789679278dd4dad6a0f9a4a5bf2fd07aba56912"
+SRC_URI[gix-revision-0.36.1.sha256sum] = "13c5267e530d8762842be7d51b48d2b134c9dec5b650ca607f735a56a4b12413"
+SRC_URI[gix-revwalk-0.22.0.sha256sum] = "02e2de4f91d712b1f6873477f769225fe430ffce2af8c7c85721c3ff955783b3"
 SRC_URI[gix-sec-0.12.2.sha256sum] = "ea9962ed6d9114f7f100efe038752f41283c225bb507a2888903ac593dffa6be"
-SRC_URI[gix-shallow-0.5.0.sha256sum] = "d936745103243ae4c510f19e0760ce73fb0f08096588fdbe0f0d7fb7ce8944b7"
-SRC_URI[gix-status-0.20.0.sha256sum] = "2a4afff9b34eeececa8bdc32b42fb318434b6b1391d9f8d45fe455af08dc2d35"
-SRC_URI[gix-submodule-0.20.0.sha256sum] = "657cc5dd43cbc7a14d9c5aaf02cfbe9c2a15d077cded3f304adb30ef78852d3e"
-SRC_URI[gix-tempfile-18.0.0.sha256sum] = "666c0041bcdedf5fa05e9bef663c897debab24b7dc1741605742412d1d47da57"
-SRC_URI[gix-trace-0.1.15.sha256sum] = "1d3f59a8de2934f6391b6b3a1a7654eae18961fcb9f9c843533fed34ad0f3457"
-SRC_URI[gix-transport-0.48.0.sha256sum] = "12f7cc0179fc89d53c54e1f9ce51229494864ab4bf136132d69db1b011741ca3"
-SRC_URI[gix-traverse-0.47.0.sha256sum] = "c7cdc82509d792ba0ad815f86f6b469c7afe10f94362e96c4494525a6601bdd5"
-SRC_URI[gix-url-0.32.0.sha256sum] = "1b76a9d266254ad287ffd44467cd88e7868799b08f4d52e02d942b93e514d16f"
+SRC_URI[gix-shallow-0.6.0.sha256sum] = "e2374692db1ee1ffa0eddcb9e86ec218f7c4cdceda800ebc5a9fdf73a8c08223"
+SRC_URI[gix-status-0.21.1.sha256sum] = "3c64039358f66c955a471432aef0ea1eeebc7afe0e0a4be7b6b737cc19925e3b"
+SRC_URI[gix-submodule-0.21.0.sha256sum] = "9bacc06333b50abc4fc06204622c2dd92850de2066bb5d421ac776d2bef7ae55"
+SRC_URI[gix-tempfile-19.0.1.sha256sum] = "e265fc6b54e57693232a79d84038381ebfda7b1a3b1b8a9320d4d5fe6e820086"
+SRC_URI[gix-trace-0.1.17.sha256sum] = "6e42a4c2583357721ba2d887916e78df504980f22f1182df06997ce197b89504"
+SRC_URI[gix-transport-0.49.1.sha256sum] = "c8da4a77922accb1e26e610c7a84ef7e6b34fd07112e6a84afd68d7f3e795957"
+SRC_URI[gix-traverse-0.48.0.sha256sum] = "412126bade03a34f5d4125fd64878852718575b3b360eaae3b29970cb555e2a2"
+SRC_URI[gix-url-0.33.2.sha256sum] = "d995249a1cf1ad79ba10af6499d4bf37cb78035c0983eaa09ec5910da694957c"
 SRC_URI[gix-utils-0.3.1.sha256sum] = "befcdbdfb1238d2854591f760a48711bed85e72d80a10e8f2f93f656746ef7c5"
 SRC_URI[gix-validate-0.10.1.sha256sum] = "5b1e63a5b516e970a594f870ed4571a8fdcb8a344e7bd407a20db8bd61dbfde4"
-SRC_URI[gix-worktree-0.42.0.sha256sum] = "55f625ac9126c19bef06dbc6d2703cdd7987e21e35b497bb265ac37d383877b1"
+SRC_URI[gix-worktree-0.43.1.sha256sum] = "8df3dfc8b62b0eccc923c757b40f488abc357c85c03d798622edfc3eb5137e04"
 SRC_URI[glob-0.3.3.sha256sum] = "0cc23270f6e1808e30a928bdc84dea0b9b4136a8bc82338574f23baf47bbd280"
 SRC_URI[globset-0.4.18.sha256sum] = "52dfc19153a48bde0cbd630453615c8151bce3a5adfac7a0aebfbf0a1e1f57e3"
 SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
@@ -578,28 +581,27 @@ SRC_URI[ignore-0.4.25.sha256sum] = "d3d782a365a015e0f5c04902246139249abf76912500
 SRC_URI[im-rc-15.1.0.sha256sum] = "af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
 SRC_URI[imara-diff-0.1.8.sha256sum] = "17d34b7d42178945f775e84bc4c36dde7c1c6cdfea656d3354d009056f2bb3d2"
 SRC_URI[implib-0.4.0.sha256sum] = "7923c255262a0e44362e221f8b74b931fe21484b83f27386aa45f021a379caf6"
-SRC_URI[indexmap-2.12.1.sha256sum] = "0ad4bb2b565bca0645f4d68c5c9af97fba094e9791da685bf83cb5f3ce74acf2"
+SRC_URI[indexmap-2.13.0.sha256sum] = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
 SRC_URI[is_executable-1.0.5.sha256sum] = "baabb8b4867b26294d818bf3f651a454b6901431711abb96e296245888d6e8c4"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.14.0.sha256sum] = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
-SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
-SRC_URI[jiff-0.2.16.sha256sum] = "49cce2b81f2098e7e3efc35bc2e0a6b7abec9d34128283d7a26fa8f32a6dbb35"
-SRC_URI[jiff-static-0.2.16.sha256sum] = "980af8b43c3ad5d8d349ace167ec8170839f753a42d233ba19e08afe1850fa69"
+SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
+SRC_URI[jiff-0.2.18.sha256sum] = "e67e8da4c49d6d9909fe03361f9b620f58898859f5c7aded68351e85e71ecf50"
+SRC_URI[jiff-static-0.2.18.sha256sum] = "e0c84ee7f197eca9a86c6fd6cb771e55eb991632f15f2bc3ca6ec838929e6e78"
 SRC_URI[jiff-tzdb-0.1.5.sha256sum] = "68971ebff725b9e2ca27a601c5eb38a4c5d64422c4cbab0c535f248087eda5c2"
 SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
 SRC_URI[jobserver-0.1.34.sha256sum] = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
-SRC_URI[js-sys-0.3.83.sha256sum] = "464a3709c7f55f1f721e5389aa6ea4e3bc6aba669353300af094b29ffbdde1d8"
+SRC_URI[js-sys-0.3.85.sha256sum] = "8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
 SRC_URI[kstring-2.0.2.sha256sum] = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[lazycell-1.3.0.sha256sum] = "830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
-SRC_URI[libc-0.2.178.sha256sum] = "37c93d8daa9d8a012fd8ab92f088405fb202ea0b6ab73ee2482ae66af4f42091"
+SRC_URI[libc-0.2.180.sha256sum] = "bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
 SRC_URI[libgit2-sys-0.18.3+1.9.2.sha256sum] = "c9b3acc4b91781bb0b3386669d325163746af5f6e4f73e6d2d630e09a35f3487"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[libnghttp2-sys-0.1.11+1.64.0.sha256sum] = "1b6c24e48a7167cffa7119da39d577fa482e66c688a4aac016bee862e1a713c4"
-SRC_URI[libredox-0.1.10.sha256sum] = "416f7e718bdb06000964960ffa43b4335ad4012ae8b99060261aa4a8088d5ccb"
+SRC_URI[libredox-0.1.12.sha256sum] = "3d0b95e02c851351f877147b7deea7b1afb1df71b63aa5f8270716e0c5720616"
 SRC_URI[libsqlite3-sys-0.35.0.sha256sum] = "133c182a6a2c87864fe97778797e46c7e999672690dc9fa3ee8e241aa4a9c13f"
 SRC_URI[libssh2-sys-0.3.1.sha256sum] = "220e4f05ad4a218192533b300327f5150e809b54c4ec83b5a1d91833601811b9"
-SRC_URI[libz-rs-sys-0.5.4.sha256sum] = "15413ef615ad868d4d65dce091cb233b229419c7c0c4bcaa746c0901c49ff39c"
+SRC_URI[libz-rs-sys-0.5.5.sha256sum] = "c10501e7805cee23da17c7790e59df2870c0d4043ec6d03f67d31e2b53e77415"
 SRC_URI[libz-sys-1.1.23.sha256sum] = "15d118bbf3771060e7311cc7bb0545b01d08a8b4a7de949198dec1fa0ca1c0f7"
 SRC_URI[linux-raw-sys-0.11.0.sha256sum] = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
 SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
@@ -617,7 +619,7 @@ SRC_URI[nix-0.30.1.sha256sum] = "74523f3a35e05aba87a1d978330aef40f67b0304ac79c1c
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[normpath-1.5.0.sha256sum] = "bf23ab2b905654b4cb177e30b629937b3868311d4e1cba859f899c041046e69b"
 SRC_URI[nu-ansi-term-0.50.3.sha256sum] = "7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5"
-SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-conv-0.2.0.sha256sum] = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
 SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
 SRC_URI[objc2-0.6.3.sha256sum] = "b7c2599ce0ec54857b29ce62166b0ed9b4f6f1a70ccc9a71165b6154caca8c05"
 SRC_URI[objc2-cloud-kit-0.3.2.sha256sum] = "73ad74d880bb43877038da939b7427bba67e9dd42004a18b809ba7d87cee241c"
@@ -634,7 +636,7 @@ SRC_URI[objc2-quartz-core-0.3.2.sha256sum] = "96c1358452b371bf9f104e21ec536d37a6
 SRC_URI[objc2-ui-kit-0.3.2.sha256sum] = "d87d638e33c06f577498cbcc50491496a3ed4246998a7fbba7ccb98b1e7eab22"
 SRC_URI[objc2-user-notifications-0.3.2.sha256sum] = "9df9128cbbfef73cda168416ccf7f837b62737d748333bfe9ab71c245d76613e"
 SRC_URI[object-0.37.3.sha256sum] = "ff76201f031d8863c38aa7f905eca4f53abbfa15f609db4277d44cd8938f33fe"
-SRC_URI[object-0.38.0.sha256sum] = "b8b28f24bd43920cd8e0bc4f9c6553e8b93221c512cb9a1014987fc89d36f830"
+SRC_URI[object-0.38.1.sha256sum] = "271638cd5fa9cca89c4c304675ca658efc4e64a66c716b7cfe1afb4b9611dbbc"
 SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
 SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
 SRC_URI[opener-0.8.3.sha256sum] = "cb9024962ab91e00c89d2a14352a8d0fc1a64346bf96f1839b45c09149564e47"
@@ -644,8 +646,8 @@ SRC_URI[openssl-probe-0.1.6.sha256sum] = "d05e27ee213611ffe7d6348b942e8f942b3711
 SRC_URI[openssl-src-300.5.4+3.5.4.sha256sum] = "a507b3792995dae9b0df8a1c1e3771e8418b7c2d9f0baeba32e6fe8b06c7cb72"
 SRC_URI[openssl-sys-0.9.111.sha256sum] = "82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
 SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
-SRC_URI[orion-0.17.11.sha256sum] = "21b3da83b2b4cdc74ab6a556b2e7b473da046d5aa4008c0a7a3ae96b1b4aabb4"
-SRC_URI[os_info-3.13.0.sha256sum] = "7c39b5918402d564846d5aba164c09a66cc88d232179dfd3e3c619a25a268392"
+SRC_URI[orion-0.17.12.sha256sum] = "eb3278caf2be3bafa358c50c76170a4f3bb5f4f39e671909fb64ee558cde117e"
+SRC_URI[os_info-3.14.0.sha256sum] = "e4022a17595a00d6a369236fdae483f0de7f0a339960a53118b818238e132224"
 SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
 SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
 SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
@@ -656,22 +658,23 @@ SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f67
 SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
 SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
 SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
-SRC_URI[portable-atomic-1.11.1.sha256sum] = "f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
+SRC_URI[portable-atomic-1.13.0.sha256sum] = "f89776e4d69bb58bc6993e99ffa1d11f228b839984854c7daeb5d37f87cbe950"
 SRC_URI[portable-atomic-util-0.2.4.sha256sum] = "d8a2f0d8d040d7848a709caf78912debcc3f33ee4b3cac47d73d1e1069e83507"
 SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
-SRC_URI[proc-macro2-1.0.103.sha256sum] = "5ee95bc4ef87b8d5ba32e8b7714ccc834865276eab0aed5c9958d00ec45f49e8"
+SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
 SRC_URI[prodash-30.0.1.sha256sum] = "5a6efc566849d3d9d737c5cb06cc50e48950ebe3d3f9d70631490fff3a07b139"
-SRC_URI[quote-1.0.42.sha256sum] = "a338cc41d27e6cc6dce6cefc13a0729dfbb81c262b1f519331575dd80ef3067f"
+SRC_URI[quote-1.0.44.sha256sum] = "21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
 SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
 SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
+SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
 SRC_URI[rand_xoshiro-0.6.0.sha256sum] = "6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
 SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
+SRC_URI[redox_syscall-0.7.0.sha256sum] = "49f3fe0889e69e2ae9e41f4d6c4c0181701d00e4697b356fb1f74173a5e0ee27"
 SRC_URI[regex-1.12.2.sha256sum] = "843bc0191f75f3e22651ae5f1e72939ab2f72a4bc30fa80a066bd66edefc24d4"
 SRC_URI[regex-automata-0.4.13.sha256sum] = "5276caf25ac86c8d810222b3dbb938e512c55c6831a10f3e6ed1c93b84041f1c"
 SRC_URI[regex-syntax-0.8.8.sha256sum] = "7a2d987857b319362043e95f5353c0535c1f58eec5336fdfcf626430af7def58"
@@ -680,9 +683,8 @@ SRC_URI[rusqlite-0.37.0.sha256sum] = "165ca6e57b20e1351573e3729b958bc62f0e480253
 SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
 SRC_URI[rustc-stable-hash-0.1.2.sha256sum] = "781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
 SRC_URI[rustfix-0.9.4.sha256sum] = "864792a841a1d785ba91b8d2a75e1936b40bc517020c3c2958ac403b92e4f00a"
-SRC_URI[rustix-1.1.2.sha256sum] = "cd15f8a2c5551a84d56efdc1cd049089e409ac19a3072d5037a17fd70719ff3e"
+SRC_URI[rustix-1.1.3.sha256sum] = "146c9e247ccc180c1f61615433868c99f3de3ae256a30a43b49f67c2d9171f34"
 SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
-SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
 SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[schannel-0.1.28.sha256sum] = "891d81b926048e76efe18581bf793546b4c0eaf8448d72be8de2bbee5fd166e1"
 SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
@@ -696,8 +698,8 @@ SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e
 SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
 SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
 SRC_URI[serde_ignored-0.1.14.sha256sum] = "115dffd5f3853e06e746965a20dcbae6ee747ae30b543d91b0e089668bb07798"
-SRC_URI[serde_json-1.0.145.sha256sum] = "402a6f66d8c709116cf22f558eab210f5a50187f702eb4d7e5ef38d9a7f1c79c"
-SRC_URI[serde_spanned-1.0.3.sha256sum] = "e24345aa0fe688594e73770a5f6d1b216508b4f93484c0026d521acd30134392"
+SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
+SRC_URI[serde_spanned-1.0.4.sha256sum] = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
 SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
 SRC_URI[sha1-checked-0.10.0.sha256sum] = "89f599ac0c323ebb1c6082821a54962b839832b03984598375bff3975b804423"
 SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
@@ -709,48 +711,47 @@ SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867
 SRC_URI[simd-adler32-0.3.8.sha256sum] = "e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
 SRC_URI[sized-chunks-0.6.5.sha256sum] = "16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
 SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
-SRC_URI[socket2-0.6.1.sha256sum] = "17129e116933cf371d018bb80ae557e889637989d8638274fb25622827b03881"
+SRC_URI[socket2-0.6.2.sha256sum] = "86f4aa3ad99f2088c990dfa82d367e19cb29268ed67c574d10d0a4bfe71f07e0"
 SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
 SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
-SRC_URI[supports-hyperlinks-3.1.0.sha256sum] = "804f44ed3c63152de6a9f90acbea1a110441de43006ea51bcce8f436196a288b"
+SRC_URI[supports-hyperlinks-3.2.0.sha256sum] = "e396b6523b11ccb83120b115a0b7366de372751aa6edf19844dfb13a6af97e91"
 SRC_URI[supports-unicode-3.0.0.sha256sum] = "b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
-SRC_URI[syn-2.0.111.sha256sum] = "390cc9a294ab71bdb1aa2e99d13be9c753cd2d7bd6560c77118597410c4d2e87"
+SRC_URI[syn-2.0.114.sha256sum] = "d4d107df263a3013ef9b1879b0df87d706ff80f65a86ea879bd9c31f9b307c2a"
 SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
 SRC_URI[tar-0.4.44.sha256sum] = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
-SRC_URI[tempfile-3.23.0.sha256sum] = "2d31c77bdf42a745371d260a26ca7163f1e0924b64afa0b688e61b5a9fa02f16"
+SRC_URI[tempfile-3.24.0.sha256sum] = "655da9c7eb6305c55742045d5a8d2037996d61d8de95806335c7c86ce0f82e9c"
 SRC_URI[terminal_size-0.4.3.sha256sum] = "60b8cb979cb11c32ce1603f8137b22262a9d131aaa5c37b5678025f22b8becd0"
-SRC_URI[thiserror-2.0.17.sha256sum] = "f63587ca0f12b72a0600bcba1d40081f830876000bb46dd2337a3051618f4fc8"
-SRC_URI[thiserror-impl-2.0.17.sha256sum] = "3ff15c8ecd7de3849db632e14d18d2571fa09dfc5ed93479bc4485c7a517c913"
+SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
+SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
 SRC_URI[thread_local-1.1.9.sha256sum] = "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
-SRC_URI[time-0.3.44.sha256sum] = "91e7d9e3bb61134e77bde20dd4825b97c010155709965fedf0f49bb138e52a9d"
-SRC_URI[time-core-0.1.6.sha256sum] = "40868e7c1d2f0b8d73e4a8c7f0ff63af4f6d19be117e90bd73eb1d62cf831c6b"
-SRC_URI[time-macros-0.2.24.sha256sum] = "30cfb0125f12d9c277f35663a0a33f8c30190f4e4574868a330595412d34ebf3"
+SRC_URI[time-0.3.46.sha256sum] = "9da98b7d9b7dad93488a84b8248efc35352b0b2657397d4167e7ad67e5d535e5"
+SRC_URI[time-core-0.1.8.sha256sum] = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
+SRC_URI[time-macros-0.2.26.sha256sum] = "78cc610bac2dcee56805c99642447d4c5dbde4d01f752ffea0199aee1f601dc4"
 SRC_URI[tinystr-0.8.2.sha256sum] = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
 SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.9.8.sha256sum] = "f0dc8b1fb61449e27716ec0e1bdf0f6b8f3e8f6b05391e8497b8b6d7804ea6d8"
-SRC_URI[toml_datetime-0.7.3.sha256sum] = "f2cdb639ebbc97961c51720f858597f7f24c4fc295327923af55b74c3c724533"
-SRC_URI[toml_edit-0.23.9.sha256sum] = "5d7cbc3b4b49633d57a0509303158ca50de80ae32c265093b24c414705807832"
-SRC_URI[toml_parser-1.0.4.sha256sum] = "c0cbe268d35bdb4bb5a56a2de88d0ad0eb70af5384a99d648cd4b3d04039800e"
-SRC_URI[toml_writer-1.0.4.sha256sum] = "df8b2b54733674ad286d16267dcfc7a71ed5c776e4ac7aa3c3e2561f7c637bf2"
-SRC_URI[tracing-0.1.43.sha256sum] = "2d15d90a0b5c19378952d479dc858407149d7bb45a14de0142f6c534b16fc647"
+SRC_URI[toml-0.9.11+spec-1.1.0.sha256sum] = "f3afc9a848309fe1aaffaed6e1546a7a14de1f935dc9d89d32afd9a44bab7c46"
+SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
+SRC_URI[toml_edit-0.23.10+spec-1.0.0.sha256sum] = "84c8b9f757e028cee9fa244aea147aab2a9ec09d5325a9b01e0a49730c2b5269"
+SRC_URI[toml_parser-1.0.6+spec-1.1.0.sha256sum] = "a3198b4b0a8e11f09dd03e133c0280504d0801269e9afa46362ffde1cbeebf44"
+SRC_URI[toml_writer-1.0.6+spec-1.1.0.sha256sum] = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
+SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
 SRC_URI[tracing-attributes-0.1.31.sha256sum] = "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
 SRC_URI[tracing-chrome-0.7.2.sha256sum] = "bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
-SRC_URI[tracing-core-0.1.35.sha256sum] = "7a04e24fab5c89c6a36eb8558c9656f30d81de51dfa4d3b45f26b21d61fa0a6c"
+SRC_URI[tracing-core-0.1.36.sha256sum] = "db97caf9d906fbde555dd62fa95ddba9eecfd14cb388e4f491a66d74cd5fb79a"
 SRC_URI[tracing-log-0.2.0.sha256sum] = "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
 SRC_URI[tracing-subscriber-0.3.22.sha256sum] = "2f30143827ddab0d256fd843b7a66d164e9f271cfa0dde49142c5ca0ca291f1e"
 SRC_URI[typeid-1.0.3.sha256sum] = "bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
 SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
-SRC_URI[unicase-2.8.1.sha256sum] = "75b844d17643ee918803943289730bec8aac480150456169e647ed0b576ba539"
+SRC_URI[unicase-2.9.0.sha256sum] = "dbc4bc3a9f746d862c45cb89d705aa10f187bb96c76001afab07a0d35ce60142"
 SRC_URI[unicode-bom-2.0.3.sha256sum] = "7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
 SRC_URI[unicode-ident-1.0.22.sha256sum] = "9312f7c4f6ff9069b165498234ce8be658059c6728633667c526e27dc2cf1df5"
 SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
 SRC_URI[unicode-width-0.2.2.sha256sum] = "b4ac048d71ede7ee76d585517add45da530660ef4390e49b098733c6e897f254"
-SRC_URI[unicode-xid-0.2.6.sha256sum] = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
-SRC_URI[url-2.5.7.sha256sum] = "08bc136a29a3d1758e07a9cca267be308aeebf5cfd5a10f3f67ab2097683ef5b"
+SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
 SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
 SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
 SRC_URI[valuable-0.1.1.sha256sum] = "ba73ea9cf16a25df0c8caa16c51acb937d5712a8429db78a3ee29d5dcacd3a65"
@@ -758,11 +759,11 @@ SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb82
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
 SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
-SRC_URI[wasip2-1.0.1+wasi-0.2.4.sha256sum] = "0562428422c63773dad2c345a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
-SRC_URI[wasm-bindgen-0.2.106.sha256sum] = "0d759f433fa64a2d763d1340820e46e111a7a5ab75f993d1852d70b03dbb80fd"
-SRC_URI[wasm-bindgen-macro-0.2.106.sha256sum] = "48cb0d2638f8baedbc542ed444afc0644a29166f1595371af4fecf8ce1e7eeb3"
-SRC_URI[wasm-bindgen-macro-support-0.2.106.sha256sum] = "cefb59d5cd5f92d9dcf80e4683949f15ca4b511f4ac0a6e14d4e1ac60c6ecd40"
-SRC_URI[wasm-bindgen-shared-0.2.106.sha256sum] = "cbc538057e648b67f72a982e708d485b2efa771e1ac05fec311f9f63e5800db4"
+SRC_URI[wasip2-1.0.2+wasi-0.2.9.sha256sum] = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
+SRC_URI[wasm-bindgen-0.2.108.sha256sum] = "64024a30ec1e37399cf85a7ffefebdb72205ca1c972291c51512360d90bd8566"
+SRC_URI[wasm-bindgen-macro-0.2.108.sha256sum] = "008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
+SRC_URI[wasm-bindgen-macro-support-0.2.108.sha256sum] = "5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
+SRC_URI[wasm-bindgen-shared-0.2.108.sha256sum] = "1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
 SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
 SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
@@ -787,16 +788,17 @@ SRC_URI[windows_x86_64_gnullvm-0.53.1.sha256sum] = "0ffa179e2d07eee8ad8f57493436
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[windows_x86_64_msvc-0.53.1.sha256sum] = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
 SRC_URI[winnow-0.7.14.sha256sum] = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
-SRC_URI[wit-bindgen-0.46.0.sha256sum] = "f17a85883d4e6d00e8a97c586de764dabcc06133f7f1d55dce5cdc070ad7fe59"
+SRC_URI[wit-bindgen-0.51.0.sha256sum] = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
 SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
 SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
 SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
-SRC_URI[zerocopy-0.8.31.sha256sum] = "fd74ec98b9250adb3ca554bdde269adf631549f51d8a8f8f0a10b50f1cb298c3"
-SRC_URI[zerocopy-derive-0.8.31.sha256sum] = "d8a8d209fdf45cf5138cbb5a506f6b52522a25afccc534d1475dad8e31105c6a"
+SRC_URI[zerocopy-0.8.33.sha256sum] = "668f5168d10b9ee831de31933dc111a459c97ec93225beb307aed970d1372dfd"
+SRC_URI[zerocopy-derive-0.8.33.sha256sum] = "2c7962b26b0a8685668b671ee4b54d007a67d4eaf05fda79ac0ecf41e32270f1"
 SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
 SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
 SRC_URI[zeroize-1.8.2.sha256sum] = "b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
 SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
 SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
 SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
-SRC_URI[zlib-rs-0.5.4.sha256sum] = "51f936044d677be1a1168fae1d03b583a285a5dd9d8cbf7b24c23aa1fc775235"
+SRC_URI[zlib-rs-0.5.5.sha256sum] = "40990edd51aae2c2b6907af74ffb635029d5788228222c4bb811e9351c0caad3"
+SRC_URI[zmij-1.0.16.sha256sum] = "dfcd145825aace48cff44a8844de64bf75feec3080e0aa5cdbde72961ae51a65"
diff --git a/recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb b/recipes-devtools/rust/cargo-c_0.10.20+cargo-0.94.0.bb
similarity index 87%
rename from recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.20+cargo-0.94.0.bb
index f3923c7..3f93778 100644
--- a/recipes-devtools/rust/cargo-c_0.10.19+cargo-0.93.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.20+cargo-0.94.0.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
            file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.12/ \
 "
-SRC_URI[cargo-c.sha256sum] = "d42aa5310f659a1c3c0dea92f6dd5ba0d4e0d8d5c221ecc341ba36846ab5f7da"
+SRC_URI[cargo-c.sha256sum] = "5e953a7ea21435da3a584c61fcb7650a9a7a290a5a88d3bb05a5b1493b4a2160"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
 DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
-- 
2.55.0


