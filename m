Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352CC3ABAA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:14 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.6813.1746137765429912714
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r3/S1Ekr;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so20298526d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137763; x=1746742563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prXdiZGcqqob2erluRETq12LXjwvjOMots6AzZxVz8w=;
        b=r3/S1EkrVl3WYaB0vk9oHq2+jvMAZ3lpv+BnhsKPzuB3QXDmlSnDDV0xaoSp38I3xi
         w1evKiz7r7L8xWbvsKad8hiWW4cfZbFrTSKlzmeVXdFvgqjA4aghDawSdR0927AePqxN
         TZ/GZv0QMYupvdbvwGym4NF4a2pxyn89gQPtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137763; x=1746742563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prXdiZGcqqob2erluRETq12LXjwvjOMots6AzZxVz8w=;
        b=s8b5JRKfdPjMOGePpn2BvCX/flcr6X0B0julHDkMpdPBf8Dv2dK7VXG6L/M5UMo/Hn
         jNX47/MJ8mGZwTA/nHUsXKyA2hxnXRyUIbOsMP146Y5Eb/qLXVjQ97UMSIA2sDhSI2pD
         +DmIMYtoF1p8r+gFqo5Hb+ohNIbM5lSn+WFPv61pUTxR/oLdQiwA++GSfhRJVo0oVWAK
         Q35sqU1WxKvf1kgZ3f9nqqWZ1Go2KkM+I1UY9db+7I+VqL9R6CwhMDshQr83iqUsmu6n
         j4D5O08ly1wH2Tfm9q7O594owyP1ntoOlUFKwapnkybEZmLrJRHFpD+q6cdRIjWePqVT
         qrfA==
X-Gm-Message-State: AOJu0YzQeBdmqrJGtGQ7erBtXqd/Ec1bt0wwQuw9S/ZDjU+EMd4jkT8z
	1gI7dRDXVCPISo0EU0Ym64FFPjVMJ4TGAwLRKM8jQIQ/Ihgx/Sh1XHdAMCd5+oSjg6Nga4htY76
	q
X-Gm-Gg: ASbGncvUJ47nJgtt/NcGXuldxZgZJPKBJI+Yi42ueHLyFXYD49hkxXqJqgs3s1wb71n
	vz8ePD50LwmiL/9AQdYfw2x4GTGS0DebaqnbEGQ+SGJKfJxWAaa6XQhvI81Kc44hiDC1fivv/t2
	R2uHJ4CgNZ2pHrh2+lHw3RIAtVtxljFdBySrRNi71IFEZh8DecqUqSWtCNnbPRt7V74hplqo/WL
	7fp5I6JS/wvUhzvVAZp+bCT5VnP+qaoyg24diMfNWVb/AxAXu7nIQzCCEQtvKBenuTvYXnFvnjF
	vlxSDYHFLAL6DLjONVtm9+GjUNXtHITSTdM/IOilA1irzLuzuIA2KLBGoPj+6GvbYDXGt2loYCS
	RXxzvj1F6sxPXSufE
X-Google-Smtp-Source: AGHT+IHJk4VU047IsBorRVHsL/6pcHWeXtSCPRuXLM1Ud2jJu/R6qmjqd+f6hr4L8hMKOv6Xs1z7EQ==
X-Received: by 2002:ad4:5ecb:0:b0:6e8:99bb:f061 with SMTP id 6a1803df08f44-6f51527858amr18458816d6.18.1746137763690;
        Thu, 01 May 2025 15:16:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.16.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:16:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 4/7] cargo-c: Update patch Upstream-Status
Date: Thu,  1 May 2025 18:15:40 -0400
Message-ID: <1c1be22536881c7526c45a6a7265f21a5834a76d.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1470

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


