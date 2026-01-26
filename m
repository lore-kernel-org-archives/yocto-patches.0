Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6FD1953A
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35788.1769471706774149242
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Qsfe5lVF;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c52c67f64cso508413785a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471706; x=1770076506; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPHTDeXpYPEUovKay1N7FZMuM+zeyoM8WVoq2z1x86o=;
        b=Qsfe5lVFif8ftY8vVCAxnfug3oorAy0oDzJCycQyneg+3QogXiw5WMuOeMJ2hoD654
         rB7A/ZMmfV5EHwVZZLwqrm2KgQRqAN//tzXdhrsYEvXe48L0dmxRhWKuVASob99m2qNw
         l5/YeKSt/GOXw2eR6vJbCfJ4sUkp75ccZOsCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471706; x=1770076506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPHTDeXpYPEUovKay1N7FZMuM+zeyoM8WVoq2z1x86o=;
        b=P8NFNst7iyaBlf4+jgM6N2kW0/F/rsL5evKjlyhTXpglzLRltwipkUe9Gp5OfRWLzY
         MGCyYvXGzOKgI2Pta1BluKc35880PFgI/d1KqPgqu3w7eTGqOQulMUDGmJ0uESs+hkFa
         Vse0+uABTBw6XKWwLXhLPs1onEAXciTKW/ordcRG6/SFYy2q4ujKNj2VHP2YyA+QdM18
         XhjaHRdRiS8STQi1huNX8yfgcKzRRXpwOw+g6miUNSpXe4WlYqrBw0c+tVcQv5mxJlwZ
         KLolwBFrR2yKE7S6xga3caZosXzQK3zpmycTnHI/PLqcEt3fBeXaSPIauYn6UyPd/eKu
         e7Dg==
X-Gm-Message-State: AOJu0Yzt9M8uZteVshCADPue/bKNnQmnk0fPF4yX11FtaT+kq4alZDJE
	C9CrUqVjNCFgppny8cd7N2e6lP4bffdnMG6Iu/v8k7iPqYeyFGevdQ34LCnQcpVN7iHN4tGNIy2
	CzD0ecH4=
X-Gm-Gg: AZuq6aKiwxhhRz4rH1+Iwc4iA+vSzla7FE/zzGALB8XXEQ3U5UCmpumH5w+psW/F33I
	XsQ93jyXsySXPD6XI+rB7CThdB0EvT8JE/QeE9WBs6e/xC5L4yZ0S2NvSTHV8lZY12GQWy0aIJi
	vcw76E5xz8jtLdUKIW6BEhXZkvhVJ4u2v3hw3OL+azFciRRmpm+aqqqmuDyULvtGn15yqxIMg00
	21m4pLiYJZwmvDNjPWVsXYa0Fen2zS5uDcYwj/tRVP4hZVmVNvZ2tIotEgJtUHPbJLjrCXP10w5
	LpjTMS330m4Z3Rn81P4to1ecMcgFPP1bBgfK3PLuF5r/nwEOzh6Lyhp65ChIEa4tZkrdap+KXVW
	c98H056qYpg03Zb0OUJUAObsX7aVyRs6ci1VZGbBvEFRJ9ynprXTY1tGqh6GcO3haf78yS46RaW
	An4iFL6Ldq5rcVKXLszoVDG4+F0No1urThv1ZX+5fGNQjFhRnj25p3vaw+2XhaQiyzI6xrfTMFp
	bsEK1ArVubVks10E0STfroKUP1dy5wNzNHJiBQKHsAo9gCqOji5
X-Received: by 2002:a05:620a:17aa:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8c6f968f177mr782596585a.79.1769471705437;
        Mon, 26 Jan 2026 15:55:05 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:04 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 05/10] rust: Upgrade 1.91.0 -> 1.91.1
Date: Mon, 26 Jan 2026 18:54:51 -0500
Message-ID: <75c503be95d147a846bf02461fd975e74c1abe6f.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3107

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
index d024b1b..489273f 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.91.0%"
+RUSTVERSION ?= "1.91.1%"
 
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
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


