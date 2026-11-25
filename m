Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3153.1795645890533283752
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nTqOF6HA;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55c35262674so48332291cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645889; x=1796250689; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DH13nHuJsQeIl7Xkakg8u3GNrox4aNw3+g93UZhYkOc=;
        b=nTqOF6HAI0h0tK89eQ3dBNlrVi0gf4HneS4u34/M69TSpgEt+o1RQ2pDYYYsnYV8ds
         0t4dbjBMT2GL1ux9I69Dtvwmqj3T/1chhSyZlJ6d5w9zD9W3ZXjJoynjL0vhaOydAqrn
         U+5jFTwBHAoUBfPZu6deJMtIf3VeenImPzJvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645889; x=1796250689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DH13nHuJsQeIl7Xkakg8u3GNrox4aNw3+g93UZhYkOc=;
        b=xHkZTJkPu8nWNzmiaWGz4HM92Q4jsAnGcFws8QpT18/1DMMzVZCFHWCXwOCFv0Zuuw
         TRhr253H04lhrl1Ug4drm40oUW63SzJ5sq+sqgKI0MMc9NcKHzhS1CFn8yBWAhvQ+6Yf
         AkggjONtrruJXUb9o1kQB/H9R1c3qB+BlSitwaVz8XwaNANJn1IA7nlAFczhuuecjgUU
         rQ2ANgcwaaMOeHt1IerOTlM/BXlf8SvgwTFHTkqUnJ/pRts/ARGRWjXrdOz+swZ3iTDI
         azZBFMa1DPRp7oUbukFRfwlnsYLyt+iJ8+zQA8oI15uk5ZpZ2PNJFObGVa3+7iNwzAQU
         /Beg==
X-Gm-Message-State: APuU4Z8E1Z8uatinnesgemwPx/O+NqLG57HS8Dr+gJt3HTigDGvfqJ09
	GNjSw99O2h4pwo1swBbwaqkN/8gWMWdeC5u9Y8yOqAF8Iv6C8F3VjO/H/jWk2GWrs6YVGirhPbM
	Cu/JI
X-Gm-Gg: AZFdTZdddhkaUqzKJrdcpz8Kue2t+mG07L9VQ6a7NoVuyfhbK6zqQ2roKo5hKsb3mlE
	Fvzrh1AmI+h/II7yNj75DML3G4EqYxg5ax8uezfYtgWSHxwBqnZSKcFVtREXrhoysSpkwr9DCBz
	W9wH5EV1aLFCpAmSI/S5M0cLFApy380iIS9jDQhSqiFlgZL0JG62qtyD2DeZHBJRztVRbd6cRW3
	uXQvbwkvoKw8kKnH/tyyyvb+cNUG82tqMBF5vjpzDZTc5Xr1twYXmRiNmry6gVAQasF3MrHFBz+
	iegzp+Atb3SeZLiYcBsLKHyb1OUvGn+ZhtCYK8Q2FINdSbakdfTpEKmsgYVPkvPtLBIBVl58egY
	r/tkI3r/UHlFaZoftqRsZ6exMV8lv+qfFM0oE6xYQxobQoOuGHolYRUh/5OsjOZwaK2NlkxYrjI
	B+PpfKki3Xr6Xh14AnGFC+yA6fNXAQ6QVgs48uGFYtH4KsIIFnyHd7wNkArZ+lwnEpRZT1V0NHs
	yeJGPoPiRZIjlcYxcl0Py02fW8/WoobHclFevI2/52g0Ak+0M9Mpg3tM5PkoRfA0/6E/sGYIuH8
	h4d2rVTB6+M6y4DrQrVC526fwgmyRGz+Fd4ZqqcsaGd8s2A+7FtaxkSHJk/4F/ik/a8+TqfdNJe
	X1P9Bx2uN8RIiR1bV2EgEGZFQ2/5TaQfhYpIo/3zVhn95v8RyORPZV4ovxZyKR0aXNHhpS4ostP
	Uu/G/KGH4DS+im
X-Received: by 2002:a05:622a:8ca:b0:55c:303f:622b with SMTP id d75a77b69052e-55d76740464mr366289341cf.0.1795645889247;
        Wed, 25 Nov 2026 14:31:29 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:28 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/19] rust: sort hygiene data before it is encoded
Date: Wed, 25 Nov 2026 17:30:59 -0500
Message-ID: <299f4adab5ecc996394e606551d1c27ec132c1c6.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5527
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

HygieneEncodeContext::encode walks a hash set while it writes the syntax
context and expansion records into the rmeta, so the byte order of the
records follows the iteration order of the set and differs between
builds on the arm workers. The added patch sorts both sets before they
are written.

Upstream tracks this as rust-lang/rust issue 129094 [1] and has fixed
it differently in pull request 161450 [2], merged after 1.99 branched.
That change is too big to backport to 1.98 safely, so carry this small
sort until a rust upgrade contains it.

[1] https://github.com/rust-lang/rust/issues/129094
[2] https://github.com/rust-lang/rust/pull/161450

[YOCTO #16376]

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 7f97e87e41b49899ecdbde1ed5205f4b6f033c89)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...hygiene-encoding-order-deterministic.patch | 59 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch

diff --git a/recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch b/recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch
new file mode 100644
index 0000000..47a713f
--- /dev/null
+++ b/recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch
@@ -0,0 +1,59 @@
+From 9c190d14f93bf27c7f1c94d400cda6f48f285a34 Mon Sep 17 00:00:00 2001
+From: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
+Date: Tue, 15 Sep 2026 17:05:36 +0530
+Subject: [PATCH] rust: sort syntax contexts and expansions before encoding
+
+HygieneEncodeContext encodes the pending syntax contexts and expansions in
+hash-map order, so the encoded rmeta depends on the build host. Sort both
+before encoding. Upstream has fixed the same problem with a different
+approach in https://github.com/rust-lang/rust/pull/161450, merged after
+rust 1.99 branched, so this stays a local fix rather than a backport
+until a rust upgrade contains it.
+
+Patch by Alejandro Enedino Hernandez Samaniego, from his strict-version-hash
+v5 series for openembedded-core:
+https://lists.openembedded.org/g/openembedded-core/topic/120939810
+
+Upstream-Status: Inappropriate [OE-specific]
+
+Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
+Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
+---
+ compiler/rustc_span/src/hygiene.rs | 10 ++++++----
+ 1 file changed, 6 insertions(+), 4 deletions(-)
+
+diff --git a/compiler/rustc_span/src/hygiene.rs b/compiler/rustc_span/src/hygiene.rs
+index 1c74205..a464eca 100644
+--- a/compiler/rustc_span/src/hygiene.rs
++++ b/compiler/rustc_span/src/hygiene.rs
+@@ -1313,12 +1313,12 @@ impl HygieneEncodeContext {
+ 
+             // Consume the current round of syntax contexts.
+             // Drop the lock() temporary early.
+-            // It's fine to iterate over a HashMap, because the serialization of the table
+-            // that we insert data into doesn't depend on insertion order.
+             #[allow(rustc::potential_query_instability)]
+-            let latest_ctxts = { mem::take(&mut *self.latest_ctxts.lock()) }.into_iter();
++            let mut latest_ctxts: Vec<_> = { mem::take(&mut *self.latest_ctxts.lock()) }.into_iter().collect();
++            latest_ctxts.sort_by_key(|ctxt| ctxt.0);
+             let all_ctxt_data: Vec<_> = HygieneData::with(|data| {
+                 latest_ctxts
++                    .into_iter()
+                     .map(|ctxt| (ctxt, data.syntax_context_data[ctxt.0 as usize].key()))
+                     .collect()
+             });
+@@ -1330,9 +1330,11 @@ impl HygieneEncodeContext {
+ 
+             // Same as above, but for expansions instead of syntax contexts.
+             #[allow(rustc::potential_query_instability)]
+-            let latest_expns = { mem::take(&mut *self.latest_expns.lock()) }.into_iter();
++            let mut latest_expns: Vec<_> = { mem::take(&mut *self.latest_expns.lock()) }.into_iter().collect();
++            latest_expns.sort_by_key(|expn| (expn.krate, expn.local_id));
+             let all_expn_data: Vec<_> = HygieneData::with(|data| {
+                 latest_expns
++                    .into_iter()
+                     .map(|expn| (expn, data.expn_data(expn).clone(), data.expn_hash(expn)))
+                     .collect()
+             });
+-- 
+2.43.0
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 66fbdc6..179347a 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,6 +11,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
             file://0007-cargo-omit-host-triple-from-unit-metadata-hash.patch;patchdir=${RUSTSRC} \
             file://0008-rustc-hir-make-doc-link-metadata-order-deterministic.patch;patchdir=${RUSTSRC} \
+            file://0009-rustc-span-make-hygiene-encoding-order-deterministic.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "be1816e7f6c40abb90245ad6e024bed2a7e88d7dda4561e4d5470207df616b9f"
 
-- 
2.56.1

