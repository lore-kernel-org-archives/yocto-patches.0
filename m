Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B00C3ABBA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.4605.1746132071385928768
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WB24Aru7;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c9376c4dbaso169692485a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132070; x=1746736870; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prXdiZGcqqob2erluRETq12LXjwvjOMots6AzZxVz8w=;
        b=WB24Aru7S6u+MLya2KfWJSVyBEkynYkVLBKpNt2KuWh86eY2/UdX+r25QlFAXigO87
         YKIlSYVgJ0Ym8GELzdQRsrwq5O+T+CJOFI4x0vCCAq11hFgmp8Ytmq782ugCkoKTF97X
         ghj2VxBN6wdkDBZu95viLDz2OrTNSreN0WB1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132070; x=1746736870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prXdiZGcqqob2erluRETq12LXjwvjOMots6AzZxVz8w=;
        b=jL+znK62ZCAZugmcWeU/jg1B85jRSX23WAcki0zC8t7W42qVa7pyOlApzoKzXq6uHd
         mAqA8NHxhnLwxUcOwhrYnxD+4einD+enBo7/jvQVSh7TEZIOitJjeoAgVpI496rmDwgf
         ZJvU/nlGtXtkOfwBIGrIWmWu6WpJMqEXjgKk/cEoqo4F1OtB+ythen2QMibShulV5evV
         JGiqp9c5gQhxzTXxsfHxSaMG1uPgvE4zKrjPMNmWxPYmiN+Lx77dD8NSIqnjw7i/YI09
         TRVct3Pc5rjRB1Oi6YBGC0/6O2aw5iwV5GylSCPWMdQj20Vl23E8wyMzdfWGDAeDmUha
         6O9Q==
X-Gm-Message-State: AOJu0YwZTCBxqIOlyVvoF43iQc4XT0tu6nQL1KZ6WOVxAx/92zh4Cl6a
	XefthC6yrVAjgrfbVdO1YNculBBSwSCPdIWjRzp+SWApeA3ZW4YFmiYHMwEnRDBquFVrLQRTPxj
	9
X-Gm-Gg: ASbGncvW7V4uRbS2cUKHXGKej59XfV0APgY0R84FoaFw+te/qIV1XBqjXyWChoLdrSK
	0fN7DMNChtECfpwSWm3UVMP47qcqhHgjBpc2847vqznHVGgvBcXOS8Vy8hg8fkWrZl+GUxZdkNX
	p5EFeeMxdZ4ZBdHEe/E20dAsHF0cWBC8kW6f1qcsFIf5uR7xJkyNSHwvvA8LCUJDUBRIS0Nn4jq
	LOpmSx4IYnn7jzdUx5iumJ7kRHguYh/LmOdn0teUlXRnOT0x52+gVsL1esOt/BW1rOTWYjoNPuc
	idjiuhBTd0cgkqRZndXeDP/9FtW/J/Y22jZbobJ3ZLo7emaX9uDoDnvWidhIh8IUA/S31lklV00
	F52YPT+nHgXLBJpgw
X-Google-Smtp-Source: AGHT+IHUnKfxNVD8gC5ml319IdNQrVjdyCVVc538/yWL7D6gPKdAJwxi/2NTH2D3IQdupuBJTGi0IA==
X-Received: by 2002:a05:620a:1995:b0:7c7:c1f8:34eb with SMTP id af79cd13be357-7cacea24694mr548328085a.23.1746132069920;
        Thu, 01 May 2025 13:41:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 35/38] cargo-c: Update patch Upstream-Status
Date: Thu,  1 May 2025 16:40:11 -0400
Message-ID: <659d3ed2087b802b939bcb32e8d0e4d6d83b396b.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1461

From: Yoann Congal <yoann.congal@smile.fr>

https://github.com/rust-lang/libc/pull/4382 was merge as
https://github.com/rust-lang/libc/commit/4b439b0953573e0383da7e092b1f516ba21f3398

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d34f49cc604733c7d714a72b3a3d66a99aa65c79)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...1-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch b/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
index 3b99361..95dcb45 100644
--- a/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
+++ b/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
@@ -6,7 +6,7 @@ Subject: [PATCH] Define more ioctl codes on riscv32gc-unknown-linux-gnu
 Define ioctl codes including `FICLONE` and `FS_IOC32_GETVERSION` on
 riscv32gc-unknown-linux-gnu.
 
-Upstream-Status: Submitted [https://github.com/rust-lang/libc/pull/4382]
+Upstream-Status: Backport [https://github.com/rust-lang/libc/commit/4b439b0953573e0383da7e092b1f516ba21f3398]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
 ---
  src/unix/linux_like/linux/arch/generic/mod.rs | 6 +++++-
-- 
2.49.0


