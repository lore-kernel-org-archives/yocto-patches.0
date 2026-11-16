Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6167.1794870780229464495
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DbUjCiY7;
 spf=pass (domain: konsulko.com, ip: 209.85.221.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ee3e658c72so1887962e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870779; x=1795475579; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nDH6n0d2XqWRj0XBEFH3BWDYe4ThDRF50FWYiZNZyyw=;
        b=DbUjCiY78glq4RywLFj3X4oxkP3XxfDqiTLGo+0EpggiENizcQm/O+O0iMaoGdaL6l
         +e4wY34YP+/QOwKADDuwHoKistIaXi0gHy6DrrT32IexWg7Ee76/MG6pcvYzPgNDdp0C
         N82GPkwKs4q3a570BVfyuHvLVdooH1JJpxUYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870779; x=1795475579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nDH6n0d2XqWRj0XBEFH3BWDYe4ThDRF50FWYiZNZyyw=;
        b=V79mTxD0pn/urmte+abjtyew2orgX5vfsVn/FAuXoxinln1hHNqIbi8LFkKeAMBtCr
         lAKDkBcBgXaYDtbvxCgQRCq3tOTH3CMnRsS7sCJ+sUlYWvKVU3/TPnBmnmLMtPcU9BYY
         cA1EkQ1VLnMH7zGbz0Q7sYzFfRXQLNvUbCpppAk+tKsV5bqGhFcXRO/hNEM/i8JZOcLB
         xWa8rmeAiOVtomKj9rCQ7qqSyMQuA3E59+v/vkA/qWOe5/H93dkMeGn3MZBfSHxKeXgN
         oRBsKcxGSNeXLLX9eo626T7yAiIN2EUjTOYZOefEIQ+rGNN8A3EAWHblvL/uAlRrNv8K
         OYLw==
X-Gm-Message-State: APuU4Z8YYX67FQu5pSJhsH3g7e/AAr4qeWeNAEjVnPVoYzQuHAHSOkqn
	mosMvB5ssNEfsg0yyhG7wu5CglUkcHX5CBNdG6AoTa35sA2RBpgNPNg2uUVWtMPyZEdsXrQ9Dpe
	LbWDShEw=
X-Gm-Gg: AYBFou0fbeGwlrXwE2D7G7LqLQugn+sVEuQVDK8qFfGuHw8mK2pEI2u1wxaSG7kIH3O
	BJ35LRO80mZawb9RRC6r7jpdK37vx4LM0MCTYoCFcRvGlMzoy9KBy1Rt9PGSvxtOZDYnQnjWOdP
	VIhKb7F4WLN6R/sgS3h4s9e/yxWmnjuGfPNeyWXQB42gRCFWi4d2PX0B/50ViWXfivuSaL3mERv
	H3LnnJuYShGOrXgLZVbc/OQIgk7qoz6xzJHyyaekIwoT9AK0zO7AEs0GKjGUGwJCH+oW9YRuYNL
	NeIly/beJvYaYEPd+HGV9rsWATAu7CVI/0xdqAzlrfJ2T5JtxHS9J1SXiBae6NlR+Y/mMc/rk5N
	d1ENxsInMfd4J11Owz0qvmxHOtAR9BzTOV/kB/9483qAC1TBjOPuiCtyFOIvw4K1MZLbHT16nV1
	AtYX13Uo4c16KMKvX5dXMpIQPTEHKl1Au31WmCehRnBU8RxOSl7hmH48CF+RPbuzkl1HUnJTGih
	BX3Y1fUklOSF4eKkGSpARYXodgRgbWRw/+OLv8JD6DeJudmPA8nuBTmqFV0HZR1IIwGBDaHy9ZD
	jiZs4G9sMeq1y3msCYmd1YHHFvHC8yYcSChd13GR6ZoMS2blT/+s6KiE/Wcc43SZy5N/i7kwZ4Z
	9jlsi3cDZpWKAmpWaqfgiyPKXoXy9GymRHLI5BxIFCopVSPfM7nFOkvrHIwDolC28EJJuji9BXg
	i/jU2ltNEJxw8=
X-Received: by 2002:a05:6122:4b18:b0:5e9:721c:72a8 with SMTP id 71dfb90a1353d-5ee344f0330mr4942618e0c.0.1794870778951;
        Mon, 16 Nov 2026 15:12:58 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 08/19] rust: sort hygiene data before it is encoded
Date: Mon, 16 Nov 2026 18:12:29 -0500
Message-ID: <075607fd42aafd71aaeb09d91687ac975626e38b.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5447
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
index a50a3fd..562f4af 100644
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
2.56.0

