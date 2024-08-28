Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C1C71133
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web11.5848.1724875800925506547
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=We+tfMff;
 spf=pass (domain: konsulko.com, ip: 209.85.166.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d46ae7863so3366395ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875800; x=1725480600; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdGof6vDkmIppdLOy9FziuZU8qeiL0/LoB/ORxkm3Vk=;
        b=We+tfMffhr6YvJ/bgyBK9vQ79/kqsq0mDw/RZJejXzh8px+ZyNTqnasfMIwU4o7AUq
         3uF1SeaWuuyMl/1qdjKAsqtHzpnVhbCYIs7cHpuxlFYwGIF1qVJe4FVoigqBW8nwo3mX
         1QIwmJpAatb8MdFuzbe202z8EXvQmbVuftiI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875800; x=1725480600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdGof6vDkmIppdLOy9FziuZU8qeiL0/LoB/ORxkm3Vk=;
        b=kWBT6o63e0Vtdr6VjEsZhuxORoiF2/S46TaX8YT7o19GUkuss6pYT6C8qLLngEWswN
         vYzAegjPR/5vIBOcfRVrWIoU+BrZtgMkM49jydHd1CZyE2HC5Vy8CTiZndfoKiNDElZB
         4fcGInpa+NQQsBOCDa8jcp4UbVSfI1nmdPdEstSFLhyZw30T51A0gxHVA/F5xnppkd7J
         QfkSzQJOl+1SAqfqftqxwN6IOoJ3G2ShN1P+BNBBZ3nsjKtJ02Mw22l8EU9lwAUM7Q1k
         od8f0QURN06vpP+iqRQC+wwZGLclTgdeyNxnPzXLhjf0B72IHEm+o5Ny1MN2yE3OZEU3
         7dyA==
X-Gm-Message-State: AOJu0YzlzfhkFqaFxdGXISdKC5EsFt8XJkfaTqT3VTs8SJfA0ft/hMIi
	Dmo5QyVNN8XhT3ZV/Kj+jUlN5/QUePjPAuCHPpCLRteX+/a/zgazDe4xts+30SYywYSf7BAlTim
	S
X-Google-Smtp-Source: AGHT+IEYEBiKqEeEX2IeLz4lc5alMN7WWLgjQ4XOCyRgC3P9f9f14Q7hWcxwiLzgk2VctstRIPMwLQ==
X-Received: by 2002:a05:6e02:1d9c:b0:39d:24af:aff8 with SMTP id e9e14a558f8ab-39f38b0c090mr2212785ab.7.1724875799749;
        Wed, 28 Aug 2024 13:09:59 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 14/33] rust-target-config: Update data layouts for 32-bit arm targets
Date: Wed, 28 Aug 2024 16:09:00 -0400
Message-ID: <9aca8385d61134b01ddaff0bd46d32b9f94ca10e.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/581

From: Tronje Krabbe <tkrabbe@jusst.de>

update the rust data layout to sync with LLVM [1]
fixes the following build
error:

error: data-layout for target `arm-poky-linux-gnueabi`, `e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64`, differs from LLVM target's `armv7-unknown-linux-gnueabihf` default layout, `e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64`

meta-rust issue report with rust 1.76 [2]

[1] https://github.com/llvm/llvm-project/commit/308e82ecebeef1342004637db9fdf11567a299b3
[2]: https://github.com/meta-rust/meta-rust/issues/444

Signed-off-by: Tronje Krabbe <tkrabbe@jusst.de>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 802376953ed9f1b3e64b3cf57374c58d7ac68d88)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 38fa761..e293272 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -130,7 +130,7 @@ def llvm_features(d):
 llvm_features[vardepvalue] = "${@llvm_features(d)}"
 
 ## arm-unknown-linux-gnueabihf
-DATA_LAYOUT[arm-eabi] = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
+DATA_LAYOUT[arm-eabi] = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
 TARGET_ENDIAN[arm-eabi] = "little"
 TARGET_POINTER_WIDTH[arm-eabi] = "32"
 TARGET_C_INT_WIDTH[arm-eabi] = "32"
@@ -138,7 +138,7 @@ MAX_ATOMIC_WIDTH[arm-eabi] = "64"
 FEATURES[arm-eabi] = "+v6,+vfp2"
 
 ## armv7-unknown-linux-gnueabihf
-DATA_LAYOUT[armv7-eabi] = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
+DATA_LAYOUT[armv7-eabi] = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
 TARGET_ENDIAN[armv7-eabi] = "little"
 TARGET_POINTER_WIDTH[armv7-eabi] = "32"
 TARGET_C_INT_WIDTH[armv7-eabi] = "32"
-- 
2.46.0


