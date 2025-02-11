Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F91C0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:57 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.1820.1739301466991473697
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=itZLFQcX;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c060568959so226452985a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301466; x=1739906266; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK3Vwd4XLzXVO8yHabiL5WdcNvGNM/1qWbBhzAby7Fc=;
        b=itZLFQcXomAQKEE8JUBc2U03QZoB270z9ZtUjYb5h4AUqixgxP4w+qHGGxjrnpAO61
         TSY0HSzqJB0fVuDMKpOw3G430gbaKrYLL+zTFep0V4kuvU+PQ6MQiugJ7tCZ/OBb3r/o
         NWHaQfkKyOTx0ma0PpCt0KwdiMxqWD4ne0m8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301466; x=1739906266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK3Vwd4XLzXVO8yHabiL5WdcNvGNM/1qWbBhzAby7Fc=;
        b=DnyQIXvoSvOoG8cEQqiMcxM1EtGXB/4vLJtsGE+gpMYzEoNRkkviGtJOFzO5cS21P4
         jH/gMULV1AL7gThgkYLTJyMNj5GMO2AQsqfPCcjcmW3dmFVAsx7wIl2U0YM2YmM1H36d
         yEgV0pSylnwdWMvzrvatMzHgatIaM8fu8Tb9/xlw917+RUGdquhluGLG/WdRjYsjVRbM
         w2fCE/CK5M/XX2O0U2nHswPPVRKB6WkpZ4ivWu9YJkq/4+AgoNPhyLFpXuH4wA+ZtY3a
         9fjY1K6SVuS9AuOCaB84qadDY8+pAnwMEAOe7rv0Z2nTjN8kvUtQSOifovAmGBzpIOEl
         HH/A==
X-Gm-Message-State: AOJu0YzzF9PQdxg55vwZ06otHiMo11IbtTInyb+K/0/fz5BRyGGafyW9
	x6bqD0u/+TdqoIPInh0FGnvcPcUmgf/3csd7Jqr7dRp47x8XxdZ78J1tiVmrSIITBWWZv4xXYOs
	+
X-Gm-Gg: ASbGncsGtUudokQbrBspTLcBTWri0EvtezKjXOTQw40gRR6kBpWNzVWoMkccD5UFc7R
	tm1PFt+5iPMqqZcCPdIkVNSWLgF4iuU6k+HTxjIy8DG/am5ozF0oU72a0YPTJY1Sfo9cFkXe5I/
	rywrIVHDRu2rRUsgs2zxvHkPElyEmObTqVJPMu1sGbe7MkrpEtTQDVcv4Av88WOqCrG/N2cEdpE
	/7ZQLSRnNgoz6PW2CFMCHRwOqE2bfJIJdFNvzAdx0JKZ2aBeFmkPf5G0ydCHyik0gi5KYqg59lw
	f39uIJigErTAfzK1pfPi2Qzkse0iY2HnjKu//x9JrhzHVN37mVCz+CTe3c4VYT7kVvU=
X-Google-Smtp-Source: AGHT+IHPPhp4rTmvMuvKPOH/PjLo1oO1mlZg7GehMo11E/GTXxaZr6OQuYj4Iy1baBDzVDZXxIKM1g==
X-Received: by 2002:a05:620a:44d1:b0:7b6:d58b:9de5 with SMTP id af79cd13be357-7c06fc67f19mr79578085a.13.1739301465798;
        Tue, 11 Feb 2025 11:17:45 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:44 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 05/10] rust-target-config: Update the data layout for x86 , ppc , riscv64 , aarch64 and loongaarch64 targets.
Date: Tue, 11 Feb 2025 14:17:18 -0500
Message-ID: <446b87a586f578f1f8f7bcc2299982dd93414931.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1071

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
---
 classes/rust-target-config.bbclass | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index e44252b..074267f 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
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


