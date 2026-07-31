Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44433C5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4591.1785497609496475140
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lICNCzJf;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9349ad9c857so26471485a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497608; x=1786102408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bUeNGfyaP/ROaO/4poByV7UwLBiaYqCEFMOBZuhIdQ=;
        b=lICNCzJf5nIFlh30wT9HW4rP45rZ9BfO1UtNnrP8dL8yWpcZ7v2JiNhbt/60LRcD8/
         9p1mkUFo/mkjJBPktmX5xL2Nn4QlxbJF/E3XbdhzHu5BruPJDPyHNarHSfdWcTZzuHKP
         OPNOKAQkgY+20svmgfJHFvTBEqFm1k5L9bDjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497608; x=1786102408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7bUeNGfyaP/ROaO/4poByV7UwLBiaYqCEFMOBZuhIdQ=;
        b=LydUjl0mwPlR8AtPTuF/wiJz6GOqnqN/CHpqo0JXzMPlkrqhiDXoxInKylKdpd9eUp
         HsX25drQK86uSU8oD4Sfj0cgPjRjd2q/ql6UaKaLdDuEEwfLcHFYXuH+4nJeZ1Q/Fuih
         XJx6zH1CgdDEbDqgS536GdjuVY1Kgrso+MYAohYKUNWz7tDtg5g3jsk4kuQ0+adyZYGs
         b9OMmPEjNQ8v0rWxRb+Z5L4i2tE7xaQ0N7aiEAFA8tBxCmFYq13no3HbpAhXXpVQ9Iyq
         ygO06Mw1o95mtHYi7dFgCqe+4GedUOCZVxvMywv8F8u0/e+0Mu7xsa9+I8/66axtfTDm
         ctPQ==
X-Gm-Message-State: AOJu0YxtuAzKk/5UEbl1gtWsEcVk/XRAVZhNF/BvnXu4Vz0SlTmJBPOK
	+cugjpIh2cqufqhB4Q0q16QtrfXbUshkbmJnNqlMFrbcQdKF/B8P1uqC2mgoAIArR6S3Pnk9t+f
	SSVt3
X-Gm-Gg: AR+sD12EI6g2grVLXnXk/IJVVPiVcjZxns0XIzAmZgbqoNRK9VC+7qIJqeyHDVcH13D
	6oXiczeboJVHiRVKSFhHCg6zMh6FPbCpp3t5PetoI4B8LQt9ZOIb2VWhhfIlw2zCTNzmZFJkhNq
	XQvBO6840IZgAjmxRfO6ZWJ13EU3jAaIJcv0Q4OCROPTDFKPIyeFtI6w3RzcLZQD+/VJQVV3cMX
	JDtqv+IiXF23XFf4msFRylQbfS10tHPFOP/CbNsLzdjAchzNfXxEScmJGKML4HPRz8jvNT04s0O
	quFQqQGBigh0idET5dQCwFuQBtZi6R3nNTr5YMsuO4MyeaRaE39sBIgTBOID+XTytIc9d7MXu2Y
	Ekmtz91pl8vg4dKVJbilnxuUUnwLthJlWxzwSksLQP2JepJ4+wd512z1hBYK5psQ2gpIkFg3Tff
	cdJOne6Z4p8RCCGtspD9PUzj3fSPHMpkdj8fOGGYs9U2nl92ZAMoYxLxNWbFfT2iiZKJdgpQFJd
	IXihcFtLUT0uiKctq6O31yxHEQJZBlwNlLzyd1/lBx5+yWHr/C+Wwy8VOCPaoN7sft2TariYnfJ
	Yhqupdiv8U8WlEnCa7IgoGB0p8TfJXUr16Fh
X-Received: by 2002:a05:620a:6cce:b0:932:ddff:123d with SMTP id af79cd13be357-93497219f97mr186631885a.29.1785497608300;
        Fri, 31 Jul 2026 04:33:28 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:28 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 14/35] rust: Upgrade 1.94.0 -> 1.94.1
Date: Fri, 31 Jul 2026 07:32:44 -0400
Message-ID: <3a78a005d589840111df8f64b7c6a5e350fcde4a.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4590

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

https://blog.rust-lang.org/2026/03/26/1.94.1-release/

Rust Changes:
https://github.com/rust-lang/rust/releases/tag/1.94.1

Cargo Changes:
https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-1941-2026-03-26
Fixes: CVE-2026-33055 and CVE-2026-33056

Test results:
No changes

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3a1cf16b6ff85ee814a7241cd87bba5c4b9ab5b3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                                                 | 2 +-
 recipes-devtools/rust/{cargo_1.94.0.bb => cargo_1.94.1.bb}      | 0
 .../rust/{libstd-rs_1.94.0.bb => libstd-rs_1.94.1.bb}           | 0
 ...t-cross-canadian_1.94.0.bb => rust-cross-canadian_1.94.1.bb} | 0
 .../rust/{rust-llvm_1.94.0.bb => rust-llvm_1.94.1.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.94.0.bb => rust_1.94.1.bb}        | 0
 7 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-devtools/rust/{cargo_1.94.0.bb => cargo_1.94.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.94.0.bb => libstd-rs_1.94.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.94.0.bb => rust-cross-canadian_1.94.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.94.0.bb => rust-llvm_1.94.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.94.0.bb => rust_1.94.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 2e59aff..b084f3a 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.94.0%"
+RUSTVERSION ?= "1.94.1%"
diff --git a/recipes-devtools/rust/cargo_1.94.0.bb b/recipes-devtools/rust/cargo_1.94.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.94.0.bb
rename to recipes-devtools/rust/cargo_1.94.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.94.0.bb b/recipes-devtools/rust/libstd-rs_1.94.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.94.0.bb
rename to recipes-devtools/rust/libstd-rs_1.94.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.94.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.94.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.94.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.94.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.94.0.bb b/recipes-devtools/rust/rust-llvm_1.94.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.94.0.bb
rename to recipes-devtools/rust/rust-llvm_1.94.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 843f837..19acf5f 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,7 +11,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Update-amdgpu-data-layout.patch;patchdir=${RUSTSRC} \
             file://0001-Adjust-loongarch-assembly-test.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600"
+SRC_URI[rust.sha256sum] = "174fce10ce012317ca995810296d8af199318838180b03d68a853e0f02d4b571"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.94.0.bb b/recipes-devtools/rust/rust_1.94.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.94.0.bb
rename to recipes-devtools/rust/rust_1.94.1.bb
-- 
2.55.0


