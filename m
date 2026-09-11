Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB4C88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:41 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48499.1789157732963542555
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BIOz5JY+;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9103f5b813aso8901276d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157732; x=1789762532; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SepSw7FpwPB9OsKyEh4QZPx8AjUMk2yZ7IqX4Ee8IHs=;
        b=BIOz5JY+fqnOXQxRhN0tFic9doytMzNIJ2jtKgFwp3WQUM7XoOjLuIMV5H6tt9FjLB
         OqmKvIo7WM4K2f2FqY9+4awoW6/16HBYmAbiZ+EKMvSbfbzc1M3HUnQJUK6OwWzMaVT+
         ptAPg/86uQYR0Hja1h/ttEPzmKBS4WFWsEY00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157732; x=1789762532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SepSw7FpwPB9OsKyEh4QZPx8AjUMk2yZ7IqX4Ee8IHs=;
        b=QdChWh1MxboDFKzyC8a4IyBPoe34hapHvzlC9hZehwxN5JvbJG4v1TjnUUquWq3uqB
         cySJ7YdhrqT/IcKpNPzTrR1dqAuLEXz7tQ27TVY5Cnf1M1RxeE2v34THAzQ60EuDscU6
         bS+eXvxN9dzjL78JH7bbPm+kxxKoXUwe2SwRBnZPjy6HotKxWFVNRr2aYFvisp8Wi/1r
         Oszlgv2gUVdBF4mg1S1iCzGgkpOei/2Rp8KTAoc3mlnuX1zqWVNOP3WwoCMM0IQRTE6X
         AWtvS6RMIGhSYKXuZ3vMciYMFiwc7+FW7JTSQmUdCa3lbMfaUbUMhq79lDnc2mdz+tzO
         vxNg==
X-Gm-Message-State: AFuF++lrSa2tpaukh7Ip97Sq2puw/o5CNmqJ/Q+yzzXNgf6TGcf+K/nu
	LyyKHpebcgPFQzgldEPFz14y7JxUvdCzSAV4kbjhtaD0qU5RN48ltFnlKCTZSHmlVukId9lWJYz
	uFZ95
X-Gm-Gg: AYBFou1YJHN8nM0HbW9kXefs7hlyw5j8S8zQC0pBxZz7hyZxtYhYYP9YoelfcQUHPN+
	QZKSPmNDSzQtlFP8IJpdfpEfuQabxaTFqJM8w+jBa0WNYhTKZXKDSH6d+butBsBJZRk36bJx8fM
	T8tNfAg+qdIHuxU2CkSHhdyfxAZZCYJ1t/pxXEc9Iz+irp5U5DNz7GxcUtIaB7bbekSMbtlpsDd
	725AVnpOKAjGHWiHoKsWxLXlcI1MV+nkpRcG2GvigOamZOlS1sLy1WpwmuUCVAu5ftNxrri5qEf
	NcmDW8qUUcRwZXaDDr7Yn+aSuUfQTWPJxkcfpjLg3MbaHbVkBiRobLd42t9wctJ0/Oh1uPU2wO9
	kWLuzVSCSjUVIdapr/Co/sFo1MnEx00pd0mJmrM0wsePiqSZbipfRiOKlsH0QnRmmxhv03SLDAi
	CU6cpGB/0kQkk5GFVM3RZUNIRCZo7QnS1OhHy4LHBZeIEfU/BvwmdfDzh5rFmSDyfxG/EfpDTGd
	P8I2gyNg1FzdjmsrHwZIgEXdB6FyU7PIekHc32ihsX5/fj3hBhtH4cT04aWauzOdeaPPDQs4cFV
	Gc9TDsmO2ONJPMWV8A8J0LCW4LHrhVOFJ24=
X-Received: by 2002:a05:6214:268b:b0:910:6432:b201 with SMTP id 6a1803df08f44-912120d895cmr89865666d6.21.1789157731650;
        Fri, 11 Sep 2026 13:15:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 11/11] rust: Upgrade 1.98.0 -> 1.98.1
Date: Fri, 11 Sep 2026 16:15:15 -0400
Message-ID: <e575397f478a51fccf17b72459bb4d5c68a853c7.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4814

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
 recipes-devtools/rust/rust-source.inc                         | 2 +-
 .../rust/{rust-source_1.98.0.bb => rust-source_1.98.1.bb}     | 0
 recipes-devtools/rust/{rust_1.98.0.bb => rust_1.98.1.bb}      | 0
 7 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-devtools/rust/{cargo_1.98.0.bb => cargo_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.98.0.bb => libstd-rs_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.98.0.bb => rust-cross-canadian_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.98.0.bb => rust-source_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.98.0.bb => rust_1.98.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 5997fb9..9823a44 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,8 +13,8 @@ LAYERSERIES_COMPAT_wrynose-rust-mixin = "wrynose"
 
 LAYERDEPENDS_wrynose-rust-mixin = "core"
 
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
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index f40f165..019e258 100644
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


