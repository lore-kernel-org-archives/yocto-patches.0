Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48FCD19533
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36297.1769471494209833397
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g0+UWpQf;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c5389c3cd2so591540685a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471493; x=1770076293; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eCJlCkP/hNeRX292ImUzNeKCrfm/GDM8JhzjxlStlQ=;
        b=g0+UWpQfycn2mwMlUMZuLwgjg4jvHsqw+aoEgkobujNO6vpoqdpg87/sMi4X7rM9hk
         pZbDFeOL4BizdtsKKVNXPrp0+13G0G6V80N5Kr8t4NFTK4OqQnNk0XOuXvUhxHPbPXF0
         BOZB7GZxxc5sLZQFZF2Mp8ruQRBmAYEj1E+/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471493; x=1770076293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eCJlCkP/hNeRX292ImUzNeKCrfm/GDM8JhzjxlStlQ=;
        b=QgTAj3ffeAhLQAsgN4X3WKePTk8t2mS2VJeQiMf/qkbZmVYwrhlAxRWRccYj6iNSmy
         OTWWbTA4MtRKtIFtYNr1cX6pgRGgQF25Z/RJ/5oYqr9SZollPjrfFJfk0y8Ci9FE0KMy
         I+CFev/1y7JtrQP2YYzIJIqrhHVGgpH2Pu5jFJIpgOR3srU8OT4whlyFjBRtMRDE8kAB
         B46kmlG+WPBJb5CIwuRSpqz8kB3hmnKCCbNZ1LZZyVJlcG95C93kqAo0CerBw/wlN8vB
         Sl+1uGhIFFdkYoDFK8CoWMoc/gGygy9en5LiKTXh9OuQi3nWMsRBLsnURlK3DUpsoraD
         Z3DA==
X-Gm-Message-State: AOJu0Yw+TGz6bRSOHPpHeJwEN8VVM1YJnFxoIoZ6Aq6+s6GTJSiRgWRT
	+/apwkfZDgS+5uMEAgkunnAlLId/jv05AXVMRWmc/EFAQH3AYE2f2beTVZ64E35FVjEhCbuL+LS
	FXqNg7Ts=
X-Gm-Gg: AZuq6aIhgrnsx4ejr+BN2KI6r5pL66WneGEOtXj4T38Z5BkCv5CG4Sr6p4Sdv2hdaa0
	mv+YD8oIUoRdULOseJymE+Gx+ggeXyWN9eAzzuLsn0J4zxWxTvElyh/ly2bdEhrQT9H7mwuS4sZ
	goz1Ym9MOksMwB7ssG9tfFHvhSmchbvSiPWe4ogdycYH6Re81t4BP5M6pZsI42DqlySEpRCy1Bo
	s7EcESA91IBRYWFVXLWBSosV5Lt1uVBhdu/B7ugUbv6MvflJ6ejWowf5bkiX1EWR2RvA42BVV6r
	akBta39NwCLufG3D65nKyYv2BGJd0M1bLhryuWtX13z5NC2bfZyD/77b3+JP84UkEjAf+uucR4o
	AYMFWH73zNgnqup0l8ajDXAB2waoXvf1NLNYPb14xIzV/QeqTLtKll6oTl+b9O5bdnPpU2PzrCH
	v1I9Oiah4OlATC8C1qkmwrflkUQJPnvu1L6nHjktFX/lbeIotkHzKx55gq6PVVbXOodn5ytvhFo
	+FvaGJakKe1ogcXzgGnUJInDmD6DGBeT78C1CCdxgc1B1jF4eeo
X-Received: by 2002:a05:620a:2801:b0:8c6:abc5:f169 with SMTP id af79cd13be357-8c6f96dd424mr776344485a.73.1769471492832;
        Mon, 26 Jan 2026 15:51:32 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:32 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/11] rust: Upgrade 1.91.0 -> 1.91.1
Date: Mon, 26 Jan 2026 18:51:09 -0500
Message-ID: <3490416e9a0639ea4d3930cc35dc2f4f9b572981.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3095

From: Yash Shinde <Yash.Shinde@windriver.com>

https://blog.rust-lang.org/2025/11/10/Rust-1.91.1/

Test results summary:

   rust v1.91.1
   +-----------+--------+---------+
   | Machine   | Passed | Ignored |
   +-----------+--------+---------+
   | arm-32    | 29,968 |  1,510  |
   | arm-64    | 30,071 |  1,447  |
   | x86-32    | 29,985 |  1,489  |
   | x86-64    | 30,229 |  1,247  |
   | riscv-64  | 30,045 |  1,472  |
   +-----------+--------+---------+

   Test results difference (1.91.1 - 1.90):
   +-----------+--------+---------+
   | Machine   | Passed | Ignored |
   +-----------+--------+---------+
   | arm-32    |  +451  |   -19   |
   | arm-64    |  +463  |   -24   |
   | x86-32    |  +477  |   -18   |
   | x86-64    |  +326  |   -28   |
   | riscv-64  |  +461  |   -22   |
   +-----------+--------+---------+

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f20987e79d50b3e94df3b763326af3a44e4ae3a8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                                                 | 2 +-
 recipes-devtools/rust/{cargo_1.91.0.bb => cargo_1.91.1.bb}      | 0
 .../rust/{libstd-rs_1.91.0.bb => libstd-rs_1.91.1.bb}           | 0
 ...t-cross-canadian_1.91.0.bb => rust-cross-canadian_1.91.1.bb} | 0
 .../rust/{rust-llvm_1.91.0.bb => rust-llvm_1.91.1.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.91.0.bb => rust_1.91.1.bb}        | 0
 7 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-devtools/rust/{cargo_1.91.0.bb => cargo_1.91.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.91.0.bb => libstd-rs_1.91.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.91.0.bb => rust-cross-canadian_1.91.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.91.0.bb => rust-llvm_1.91.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.91.0.bb => rust_1.91.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 3fac513..e01a81a 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.91.0%"
+RUSTVERSION ?= "1.91.1%"
diff --git a/recipes-devtools/rust/cargo_1.91.0.bb b/recipes-devtools/rust/cargo_1.91.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.91.0.bb
rename to recipes-devtools/rust/cargo_1.91.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.91.0.bb b/recipes-devtools/rust/libstd-rs_1.91.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.91.0.bb
rename to recipes-devtools/rust/libstd-rs_1.91.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.91.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.91.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.91.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.91.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.91.0.bb b/recipes-devtools/rust/rust-llvm_1.91.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.91.0.bb
rename to recipes-devtools/rust/rust-llvm_1.91.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 0378f3c..14f74a9 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,7 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "9b94161dba3aa32192e0e75f7891912d98095ffb86087b07a05af35a0265a938"
+SRC_URI[rust.sha256sum] = "66401bb815e236cc6b2aacbbe23b61b286c1fe27a67902e7c0222cfe77b3dbab"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.91.0.bb b/recipes-devtools/rust/rust_1.91.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.91.0.bb
rename to recipes-devtools/rust/rust_1.91.1.bb
-- 
2.51.0


