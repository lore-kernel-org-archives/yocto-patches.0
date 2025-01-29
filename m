Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D6DC02193
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:28 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.19469.1738174159271622321
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M9zNE7VT;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844df397754so182802939f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174158; x=1738778958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQHFiB6RPSmeiNtMdTQzGoHgUW0RfjtU/x0+Z3vmlR4=;
        b=M9zNE7VTHqmpSVXccfF69V5NSSpqImyozCF0iVa7iAnvNpPa7Q8B3GlsD+YEBMTX+b
         5l15/vf+JAdd0HoXMwKBucilRSUdLS+QRBPe7Y07xepFdqVaAcrSKSDDlagZ5BoKmtn/
         Ip79YNyodubUBk2kQNRtldJitcSag2EQAX+AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174158; x=1738778958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQHFiB6RPSmeiNtMdTQzGoHgUW0RfjtU/x0+Z3vmlR4=;
        b=AhbeL1osX5RMZRqgivNFACDl+0tUAPbSbZHnSSKo3fVzwh0WzaajzNH4ZJgUiEuRt4
         xIUJBc9F1DiPAo22N1+BPSCynx5/wbfo/4fu2eB+ePGTl4ztq5XpUDbQDjFsiggn19wR
         pnPhPYij6QNFFiwnWG5NGWjzJWVcoPF1/yP8YUYlHiQNDdxl7aS+SMWsGtnGDJFeAnzV
         YZCjiLP3bSupkdig3EFie8ofj6/cT9pppW45VtTEsA63z2GynoRtWyqRrmcywSNstZMq
         ayuMewjDp5zcRo6uAVI3NeRmd/fxN3M8z+ZGT/fkb4AFwToviCv1bj57+YfKNN9YkIxo
         +VTQ==
X-Gm-Message-State: AOJu0YzAxIcXAd+/nPIG6aMs9Q8rCQgyBgfXBN/dkBuD85DwtCgONrFu
	FQ4G9xkcBPZsLeIPhXLcLAvNb3Yib7Nljgx5aHqgKl4N3IEwreWUVjiIF0X8p/ENXNRelxWTyt3
	U
X-Gm-Gg: ASbGnct09okeOpK07vmryjS7EuqTGo5bQ/F8CqQGR/y7SJlBLUGGQ4WyuH/tfqa2FVV
	7BeDS1to+FtqFmmP7xsxvbX7lmqjTBnK4vwQ328tjmTSuUsnFKla6KdiH4QasWA1HPODtE9aFD1
	jz+pZKGsYPQgT5+3MJaRGWiLB1KPQFDiPRhu369K8j1B+ZkOu8Sqo2LjibD/h8aLY1ilQtFcg/L
	V3bdx0rtge2tVvUHDSW8HnjXy6wiYQ9yF57HGDTiSWI+g3tV+odS8eqUMzGjyxnVefMeKRkaBiZ
	MTnVySpDLVJzgkD0VN54yGWnCo3DUDPRBWfWEShrDKWu7BEwYgrqNh7AXHoy8C9f/AM=
X-Google-Smtp-Source: AGHT+IGS6kPqJdTRQPneqj6vZp+/rnyWu+GjSjXk9MEex5DtgUM4tDBpxSp2Rl6WtxVxSOZ3yFRroQ==
X-Received: by 2002:a05:6602:3943:b0:847:4fc0:c775 with SMTP id ca18e2360f4ac-85427d770f6mr406879939f.8.1738174158119;
        Wed, 29 Jan 2025 10:09:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 5/9] rust-target-config: Update the data layout for x86 , ppc , riscv64 , aarch64 and loongaarch64 targets.
Date: Wed, 29 Jan 2025 13:08:56 -0500
Message-ID: <67faa3fac1578ffe45021d7ea34bed40accfe8bf.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1018

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

-----------------------------------------------------------------------------------------
error: data-layout for target `x86-linux`, `e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128`,
differs from LLVM target's `i686-unknown-linux-gnu` default layout,
`e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128`

error: data-layout for target `powerpc-linux`, `E-m:e-p:32:32-i64:64-n32`,
differs from LLVM target's `powerpc-unknown-linux-gnu` default layout,
`E-m:e-p:32:32-Fn32-i64:64-n32`

error: data-layout for target `x86_64-poky-linux-gnux32`,
`e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128`,
differs from LLVM target's `x86_64-poky-linux-gnux32` default layout,
`e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128`
-------------------------------------------------------------------------------------------
Rust commits for updating the data layouts:

x86: https://github.com/rust-lang/rust/commit/dbff90c2a7c751cf9d6843cd585429beb100c17d
x86_64-x32: https://github.com/rust-lang/rust/commit/ec55a05374d89d206be5140a4759af92f1b42f15
aarch64: https://github.com/rust-lang/rust/commit/4d397d33da8aff64419a03694d152c8250916f19
ppc: https://github.com/rust-lang/rust/commit/ad7ea8b7e690e6000006b6fde630a2c8c4385019
riscv64gc: https://github.com/rust-lang/rust/commit/f414715ebfda201f91f80ef9f28d9923d614d1c4
loongaarch64: https://github.com/rust-lang/rust/commit/4a06a5bc7ad259023e4373e794687adfce252dac

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 5136176198d4d150afa39b50dc4e879f5b206909)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 399c13d..67aaa56 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -146,7 +146,7 @@ MAX_ATOMIC_WIDTH[armv7-eabi] = "64"
 FEATURES[armv7-eabi] = "+v7,+vfp2,+thumb2"
 
 ## aarch64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[aarch64] = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
+DATA_LAYOUT[aarch64] = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
 TARGET_ENDIAN[aarch64] = "little"
 TARGET_POINTER_WIDTH[aarch64] = "64"
 TARGET_C_INT_WIDTH[aarch64] = "32"
@@ -160,21 +160,21 @@ TARGET_C_INT_WIDTH[x86_64] = "32"
 MAX_ATOMIC_WIDTH[x86_64] = "64"
 
 ## x86_64-unknown-linux-gnux32
-DATA_LAYOUT[x86_64-x32] = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
+DATA_LAYOUT[x86_64-x32] = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
 TARGET_ENDIAN[x86_64-x32] = "little"
 TARGET_POINTER_WIDTH[x86_64-x32] = "32"
 TARGET_C_INT_WIDTH[x86_64-x32] = "32"
 MAX_ATOMIC_WIDTH[x86_64-x32] = "64"
 
 ## i686-unknown-linux-{gnu, musl}
-DATA_LAYOUT[i686] = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
+DATA_LAYOUT[i686] = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128"
 TARGET_ENDIAN[i686] = "little"
 TARGET_POINTER_WIDTH[i686] = "32"
 TARGET_C_INT_WIDTH[i686] = "32"
 MAX_ATOMIC_WIDTH[i686] = "64"
 
 ## XXX: a bit of a hack so qemux86 builds, clone of i686-unknown-linux-{gnu, musl} above
-DATA_LAYOUT[i586] = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
+DATA_LAYOUT[i586] = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128"
 TARGET_ENDIAN[i586] = "little"
 TARGET_POINTER_WIDTH[i586] = "32"
 TARGET_C_INT_WIDTH[i586] = "32"
@@ -216,21 +216,21 @@ TARGET_C_INT_WIDTH[mips64el] = "32"
 MAX_ATOMIC_WIDTH[mips64el] = "64"
 
 ## powerpc-unknown-linux-{gnu, musl}
-DATA_LAYOUT[powerpc] = "E-m:e-p:32:32-i64:64-n32"
+DATA_LAYOUT[powerpc] = "E-m:e-p:32:32-Fn32-i64:64-n32"
 TARGET_ENDIAN[powerpc] = "big"
 TARGET_POINTER_WIDTH[powerpc] = "32"
 TARGET_C_INT_WIDTH[powerpc] = "32"
 MAX_ATOMIC_WIDTH[powerpc] = "32"
 
 ## powerpc64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[powerpc64] = "E-m:e-i64:64-n32:64-S128-v256:256:256-v512:512:512"
+DATA_LAYOUT[powerpc64] = "E-m:e-Fi64-i64:64-n32:64-S128-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64] = "big"
 TARGET_POINTER_WIDTH[powerpc64] = "64"
 TARGET_C_INT_WIDTH[powerpc64] = "32"
 MAX_ATOMIC_WIDTH[powerpc64] = "64"
 
 ## powerpc64le-unknown-linux-{gnu, musl}
-DATA_LAYOUT[powerpc64le] = "e-m:e-i64:64-n32:64-v256:256:256-v512:512:512"
+DATA_LAYOUT[powerpc64le] = "e-m:e-Fn32-i64:64-n32:64-S128-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64le] = "little"
 TARGET_POINTER_WIDTH[powerpc64le] = "64"
 TARGET_C_INT_WIDTH[powerpc64le] = "32"
@@ -244,14 +244,14 @@ TARGET_C_INT_WIDTH[riscv32gc] = "32"
 MAX_ATOMIC_WIDTH[riscv32gc] = "32"
 
 ## riscv64gc-unknown-linux-{gnu, musl}
-DATA_LAYOUT[riscv64gc] = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
+DATA_LAYOUT[riscv64gc] = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
 TARGET_ENDIAN[riscv64gc] = "little"
 TARGET_POINTER_WIDTH[riscv64gc] = "64"
 TARGET_C_INT_WIDTH[riscv64gc] = "32"
 MAX_ATOMIC_WIDTH[riscv64gc] = "64"
 
 ## loongarch64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[loongarch64] = "e-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
+DATA_LAYOUT[loongarch64] = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
 TARGET_ENDIAN[loongarch64] = "little"
 TARGET_POINTER_WIDTH[loongarch64] = "64"
 TARGET_C_INT_WIDTH[loongarch64] = "32"
-- 
2.48.1


