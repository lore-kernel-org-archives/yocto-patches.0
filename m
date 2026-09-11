Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8689FC88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:19 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48544.1789157654624677045
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=edzIYOna;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9103f5b813aso8893636d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157653; x=1789762453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IeZljPfObr0JktM9Vn2eFkwnjUyTY77evhQrpx7YaRw=;
        b=edzIYOnai9ZL7LqZqthpE+pLd+cF99YrRIcyxpEA84Lp2UaofOcCYpeYfeaes/57Xw
         8HlQcPLFHx5zEoqIF9pbpFgvy2aI8Ubptb5+ll/ipDhCGvzVWHu8WNkyM60W9fL8NTVG
         hpJUBfGRgTqOR8CArudZMKlrrXFWNrYR4MEH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157653; x=1789762453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IeZljPfObr0JktM9Vn2eFkwnjUyTY77evhQrpx7YaRw=;
        b=gexL3I1dnhRWf8Ru8hv+3/F+v7I7j5DSW+1iHp8Xy5u2AAfmzfB3VHsYsg8NFi0XaQ
         DzwIARnbkawH4BfRbIrfBmOh6f4eR2qttySvQ1nVHlW/wkRyUWm04rmXPpnSxXuqhAub
         k1SqFjRGaCXHI24BrqMRiYBWaADoP/1B7LF1J/Pp2+pVxBR0US2k7LF2OTbt/XQWRES9
         OW1UsN4J7AcJ6WLqN+HCmB9yTpMNKsaUeSkjZhNSboNJ2cPwjNO1IwEGJdHmKwz/s5Ql
         i8lDsT4SBhA8QhKupRQXDdm0ug19Ga3jQIgqNjndOxIK5ye7yHNOBeoOpm0frXhcKYVC
         CiRQ==
X-Gm-Message-State: AFuF++mMzk5SYnoeIIdxJN90WJ3cBoxlq9xc88z3y7mEyp5YJgA0nIax
	3sOhLUrOQwoccp9X/E/WPbWv98xIT2svb3GZ53p6km0e6TCND3pkzaQzKii82rmN/lLAvKLEl2w
	7lerj
X-Gm-Gg: AYBFou08dhUvGcUFmf9Z4JqNzjt/SG8NfMBP1eE4RCJIrdexgzfBC/sJW9OPsXLQr+F
	5MNTOkKi5H+gyvfTK4P0DmQcvo//FmKJd709BLr2vOr63HAkWionCMyTdzpM4f0k9JXXhvQr9Qz
	YidKz3ej6xgnveSLbnys6bpELWBSUXe3Mc/qI7x7x2abNu151fpoGzo2drE/0PjIx7KIpwJ3ROm
	u4daAHIfl439IdDHHjNKU0AKf36ZXxIhZAnNmViy4z+cWfmggQfZSL2356i7hdfJ/b+en0XflJV
	5zMUl9HKYc7czkguDYv8NAg18JfDZNI0v/waQFdTxYIerxEMSGo63j61qbUah1Il3WItAHtPn8Z
	fk1uyc/N9lHABDcXcvvmSTmFV0A8zmOFSwakUNg5ngKm2bZWDA92vGtn+K/FEoDT62mTe6doO+w
	HcWcIujBonkjM2aiuwejfMvVJ98E3dt0ztj2b8qJuhU7LOV56qgbHniheXCZ1VeRqsqGMhnFD2P
	UkODXLFlei7YrJJlFPaTdVdymXYKvNio7YMRJgc00Svz4l2CpuZ5BT3S9VHopXMTG30MxldSjWV
	ecrLJtcTb5x8IbfdHQkswbKO9qK+BK36NZThVUz1OgCiug==
X-Received: by 2002:a05:622a:550c:b0:530:2512:f6d8 with SMTP id d75a77b69052e-530c8226d41mr93855361cf.0.1789157653358;
        Fri, 11 Sep 2026 13:14:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 37/37] rust: Upgrade 1.98.0 -> 1.98.1
Date: Fri, 11 Sep 2026 16:13:23 -0400
Message-ID: <eedcdc7486ff15c3510c2ceff68c87d9db141312.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4802

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

https://github.com/rust-lang/rust/releases/tag/1.98.1

Rust 1.98.1 fixes:
- Fixes a miscompilation when generating vtables

Test results:

rust v1.98.1
+-------------+---------+---------+
| Machine     | Passed  | Skipped |
+-------------+---------+---------+
| qemux86-64  |  23170  |   805   |
| qemux86     |  22914  |  1061   |
| qemuarm64   |  23000  |   975   |
| qemuarm     |  22894  |  1081   |
| qemuriscv64 |  22943  |  1032   |
+-------------+---------+---------+

Test results difference (1.98.1 - 1.98.0):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |   +1   |    0    |
| qemux86     |   +1   |    0    |
| qemuarm64   |   +1   |    0    |
| qemuarm     |   +1   |    0    |
| qemuriscv64 |   +1   |    0    |
+-------------+--------+---------+

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8597de0d9517292aacff49c35b80647ae94accf8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                                               | 4 ++--
 recipes-devtools/rust/{cargo_1.98.0.bb => cargo_1.98.1.bb}    | 0
 .../rust/{libstd-rs_1.98.0.bb => libstd-rs_1.98.1.bb}         | 0
 ...cross-canadian_1.98.0.bb => rust-cross-canadian_1.98.1.bb} | 0
 .../rust/{rust-llvm_1.98.0.bb => rust-llvm_1.98.1.bb}         | 0
 recipes-devtools/rust/rust-source.inc                         | 2 +-
 .../rust/{rust-source_1.98.0.bb => rust-source_1.98.1.bb}     | 0
 recipes-devtools/rust/{rust_1.98.0.bb => rust_1.98.1.bb}      | 0
 8 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-devtools/rust/{cargo_1.98.0.bb => cargo_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.98.0.bb => libstd-rs_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.98.0.bb => rust-cross-canadian_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.98.0.bb => rust-llvm_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.98.0.bb => rust-source_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.98.0.bb => rust_1.98.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index d310640..81b4267 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,8 +15,8 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.98.0%"
+RUSTVERSION ?= "1.98.1%"
 
 # For lack of a better place to put this since it needs to be visible
 # globally, carry it here.
-RECIPE_MAINTAINER:pn-rust-source-1.98.0 = "Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>"
+RECIPE_MAINTAINER:pn-rust-source-1.98.1 = "Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>"
diff --git a/recipes-devtools/rust/cargo_1.98.0.bb b/recipes-devtools/rust/cargo_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.98.0.bb
rename to recipes-devtools/rust/cargo_1.98.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.98.0.bb b/recipes-devtools/rust/libstd-rs_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.98.0.bb
rename to recipes-devtools/rust/libstd-rs_1.98.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.98.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.98.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.98.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.98.0.bb b/recipes-devtools/rust/rust-llvm_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.98.0.bb
rename to recipes-devtools/rust/rust-llvm_1.98.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 4ef2ada..3b41db1 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -10,7 +10,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch;patchdir=${RUSTSRC} \
             file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "271fa73d8174f53d713c46a8310da7bf7cfdcfb8b7cfd1c2b74b84a83ae9fb1e"
+SRC_URI[rust.sha256sum] = "be1816e7f6c40abb90245ad6e024bed2a7e88d7dda4561e4d5470207df616b9f"
 
 # Point UNPACKDIR into the work-shared location so rust-source.bb and all
 # consumers (via S/RUSTSRC) reference a single shared source tree.
diff --git a/recipes-devtools/rust/rust-source_1.98.0.bb b/recipes-devtools/rust/rust-source_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-source_1.98.0.bb
rename to recipes-devtools/rust/rust-source_1.98.1.bb
diff --git a/recipes-devtools/rust/rust_1.98.0.bb b/recipes-devtools/rust/rust_1.98.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.98.0.bb
rename to recipes-devtools/rust/rust_1.98.1.bb
-- 
2.55.0


