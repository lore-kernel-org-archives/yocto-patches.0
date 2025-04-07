Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA4C369A6
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:15 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.60137.1744061468303168732
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ta/wDEO3;
 spf=pass (domain: konsulko.com, ip: 209.85.166.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86117e5adb3so111980839f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061467; x=1744666267; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+tOq/W9xoh0jWqvdgOEf5lWkZGhwHYOLDbDYTXYB84=;
        b=Ta/wDEO3HTSdA1Dy324PZk15lG+nLYydDNe7sK8G3YhHiMtOur6jMGc/YqXiKMSPTe
         UmjyQfjp8bxlI4evfmqP3b2NtD68GtBr1bFdsvwIvMrBDvCtWsPUpbcf076OUClVQX0Y
         nnIzABgwSuiAnycSuJwW0fpbof4Bpg9khwnx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061467; x=1744666267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+tOq/W9xoh0jWqvdgOEf5lWkZGhwHYOLDbDYTXYB84=;
        b=HSRsJ4Isc4PthW60h1I8k7I2gR2Q4LGR85KEUzJd6zBC2kBP3QhqKcg0n5Kxd6qfcq
         y9DLtN2hcOT+G/NFjawvez+mXUn4qGIOAD5kNe+EkBoXWz085CIuGslGRHRMezuwFCJK
         RD+NG0u5UGbF9p68ZPtVNLjSUX7JkOVFb546KYs1OsxBa32HHGxBV7jeEMlF1bac8TR9
         FOYkY7SOT028b7QZA3kiDtLU/c9GlDsxLN4ag2oqy2bW6/GE2g53KTDsLq/2scpNCVL5
         l6o0ZDPtIgW3TETWu6M76aB2eHR6G3eM7u4Sp6aEgJ1/lUtAu3v9pbc4WCmD3LUHq3+4
         Dbuw==
X-Gm-Message-State: AOJu0YzONh8jbIiC1dSTiFxsGWo+rcTg0bQCqjp/wv9IU80qntzx+wDi
	6nDgSyOoyQb0Af40YSWa5MJazmU204QphHtDqcd3EtBIhH/Itzq+/qHbW6MT9SWUeWCt9f0x7SH
	Yu9M=
X-Gm-Gg: ASbGncs2R4jQ5K2cINLKUtj1fIUcITKvNebAXK8k1hEt4MUwnRrETWPaqJ70sPG3MYo
	NFNlYYBc/WW1N6CZ17VKN72ThEz8qzvmjwyeBwYfH324PhX4VOWqb2UPE1QjEyF1elndQSUdNBb
	iii2tzXcVkrr7SQi/ZPzOAlHdniCmfUN9Dk2Bt2bDDh2f0lFSaHNluDwOS41ycs7bR4fna4Rfix
	nV0DJqeDMWnC/TGS4vf/2wW97sAH1TI0OO4y8kUFC2NlcpwTa3NFsTcsyPe5QdYWJwuF+uVfcox
	KUACCNN76gxH79rgwkdvlZN4Src4KUwFzFhEq2E1oJB9owGdZDGEUJ3xxft0Zykhqj++M5ZXnpq
	WvI3+nRBzfVcsTcclPlGr
X-Google-Smtp-Source: AGHT+IEmdCfj43lgM1YNl/j6Ln6A7z/usO7kx+l6XUHiT7Fx7AyzhB0Y9OTkAK1JXZTv9A5uTsvcGg==
X-Received: by 2002:a05:6602:381a:b0:85e:a8db:fa10 with SMTP id ca18e2360f4ac-8611b3d4259mr1578751339f.1.1744061467279;
        Mon, 07 Apr 2025 14:31:07 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 28/29] rust: Upgrade 1.85.0->1.85.1
Date: Mon,  7 Apr 2025 17:30:17 -0400
Message-ID: <14722a052c835dd9e65fd4ec8200577f2661bc88.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1327

From: Yash Shinde <Yash.Shinde@windriver.com>

Rust stable version updated to 1.85.1
https://blog.rust-lang.org/2025/03/18/Rust-1.85.1.html

Dropped patches:
downgrade-bootstrap-cc.patch since it's merged with v1.85.1.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b141115b9c8e052df096e55d92972b1db4c84f4e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  2 +-
 .../rust/{cargo_1.85.0.bb => cargo_1.85.1.bb} |  0
 .../rust/files/downgrade-bootstrap-cc.patch   | 41 -------------------
 ...ibstd-rs_1.85.0.bb => libstd-rs_1.85.1.bb} |  0
 ....85.0.bb => rust-cross-canadian_1.85.1.bb} |  0
 ...ust-llvm_1.85.0.bb => rust-llvm_1.85.1.bb} |  0
 recipes-devtools/rust/rust-source.inc         |  3 +-
 .../rust/{rust_1.85.0.bb => rust_1.85.1.bb}   |  0
 8 files changed, 2 insertions(+), 44 deletions(-)
 rename recipes-devtools/rust/{cargo_1.85.0.bb => cargo_1.85.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
 rename recipes-devtools/rust/{libstd-rs_1.85.0.bb => libstd-rs_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.85.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.85.0.bb => rust-llvm_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.85.0.bb => rust_1.85.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 15975bf..7db9965 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.85.0%"
+RUSTVERSION ?= "1.85.1%"
diff --git a/recipes-devtools/rust/cargo_1.85.0.bb b/recipes-devtools/rust/cargo_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.85.0.bb
rename to recipes-devtools/rust/cargo_1.85.1.bb
diff --git a/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch b/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
deleted file mode 100644
index 3ae6872..0000000
--- a/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-Downgrade bootstrap cc version
-
-In rust v1.85.0, the upgraded cc version causes bootstrap
-to fail on custom targets. Downgrading the cc version fixes
-the error. This commit is merged with v1.85.1 and the patch
-can be dropped when upgraded to it.
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/137460/commits/e4ca11f87ffca8c63aa56d45b46e62b6acc58bd7]
-
-Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
-diff --git a/src/bootstrap/Cargo.lock b/src/bootstrap/Cargo.lock
-index a47f3af60cb..890e64e2bab 100644
---- a/src/bootstrap/Cargo.lock
-+++ b/src/bootstrap/Cargo.lock
-@@ -88,9 +88,9 @@ dependencies = [
-
- [[package]]
- name = "cc"
--version = "1.2.0"
-+version = "1.1.22"
- source = "registry+https://github.com/rust-lang/crates.io-index"
--checksum = "1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"
-+checksum = "9540e661f81799159abee814118cc139a2004b3a3aa3ea37724a1b66530b90e0"
- dependencies = [
-  "shlex",
- ]
-diff --git a/src/bootstrap/Cargo.toml b/src/bootstrap/Cargo.toml
-index ed51862390d..2c1d85b01e6 100644
---- a/src/bootstrap/Cargo.toml
-+++ b/src/bootstrap/Cargo.toml
-@@ -37,7 +37,9 @@ test = false
- # Most of the time updating these dependencies requires modifications to the
- # bootstrap codebase(e.g., https://github.com/rust-lang/rust/issues/124565);
- # otherwise, some targets will fail. That's why these dependencies are explicitly pinned.
--cc = "=1.2.0"
-+#
-+# Do not upgrade this crate unless https://github.com/rust-lang/cc-rs/issues/1317 is fixed.
-+cc = "=1.1.22"
- cmake = "=0.1.48"
-
- build_helper = { path = "../build_helper" }
diff --git a/recipes-devtools/rust/libstd-rs_1.85.0.bb b/recipes-devtools/rust/libstd-rs_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.85.0.bb
rename to recipes-devtools/rust/libstd-rs_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.85.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.85.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.85.0.bb b/recipes-devtools/rust/rust-llvm_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.85.0.bb
rename to recipes-devtools/rust/rust-llvm_1.85.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index e070558..8400a48 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,9 +8,8 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
-            file://downgrade-bootstrap-cc.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "d542c397217b5ba5bac7eb274f5ca62d031f61842c3ba4cc5328c709c38ea1e7"
+SRC_URI[rust.sha256sum] = "b1fbf809efe9f036939401e142631c201a53bcf43ec1696bd9f5290ba236a266"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.85.0.bb b/recipes-devtools/rust/rust_1.85.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.85.0.bb
rename to recipes-devtools/rust/rust_1.85.1.bb
-- 
2.49.0


