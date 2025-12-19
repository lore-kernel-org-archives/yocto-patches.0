Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63659D74961
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 07:01:47 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11973.1766127698229020563
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 23:01:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lVCxnvwc;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a35a00502so14465266d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 23:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766127697; x=1766732497; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/KGxpYfFckxFuJ4kj8j7VlHiPzAl4jewQ/rFEisXfg=;
        b=lVCxnvwcXJ60byDbGflJOHZ7NZCUun/dGas76B6wNdO3CK4TfK9BSs7n8qQz+DZTMb
         sDpJ6rSvZoAUHwZoKZO1b1m+zXt9hyNoTP2/iFr8s4m5IH6uzl9rk6N0JDfH0WnTasKC
         hDaQ+hlglZpHqytmFKE6KritIyWj7BWRdjlJ9bQ1DezBhMcNtUu8yHa5kPFaN1Mt6IJd
         QTbVca9YqRQJv/kmsaexH9t3+3dYnLxOnSORu4xVisJnUE23x1sordKWrmJu4a+HtP7N
         tDrO2R/Yy+dZllPmDNhnj2qVXjryjpySr3mWNNstgYsiRRYoG6vEiOT3nub1LDzderZG
         ETRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127697; x=1766732497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v/KGxpYfFckxFuJ4kj8j7VlHiPzAl4jewQ/rFEisXfg=;
        b=YCCW21qAsJU5oghV2tbnTNsjDY5rGD5lh0mA76ygqzHSPL6TIEotFA42pUHe5PdY5/
         IeGr14pSt7jzDFXFHzcErWxbFsayVrR/X15ShyopAT0hFWDuzwCTR/wEauLD8AH+ZAis
         lpPyZVO7XYAOjPmpD0F++Q8Yu6PldOBrwCfH+za73+Tk1V6dn3ahgu8i+plzzWoxKRS0
         g0m/7aNnd0VGZppiX0IuMlN3s+LDjwnNSwyW3LR66aujVEPR575uVfU7A40rmCVZl3jF
         oQnTaRHrNiZ8zM0PVNmKbpYVoR45wBCCdOc47yoL4VMnUfXBiAvNATLy9MJzPKVDFtAS
         Na9A==
X-Gm-Message-State: AOJu0YyGKTuxsbaPGTwqVtdamjq7b1SqONScK/P4sQnUdw3teW+1dBr2
	cdZcyPL3dVfjnMoDxgU8uCaLALetb0WcoBGYxOVm3rx/CxPxZprwDo/YVpMlWg==
X-Gm-Gg: AY/fxX4vLwvOPKWsNf7TmtHcyIF9zyuemJalySpTCWvqCsZuBw0dDLMo9fN5qKk9RMu
	HIprVpfnWOFYipuwCgTLMQy4hb5ehVVuJQ9wjW7TmhEALvn+xYCJVRaWr0eybQdfbqX8LyuaeAG
	++vgBiRCOipLzDvHeC9T+vq/y1V4Cz1zjsp1rMbQx+/n44LFv+R2yhSc/Degkk/O4p1i9EeXOUq
	ehij1Rua9N1EJy1JMH1R7rFFHYC2Dpj021F2Rffy8WgktVNNRneY6661k/Lxy91T1ZWWNj2Pld+
	jUKA3GhpJzplS0xeTTd6BQQ18Ald4vb4S2p2jsonyPqauar0nWBL8BF+T2a2rRShgcZOlNLFVlH
	+ORyDpzId07whx2rfcMCysaejKumLIJ4LuZPYpYwhcEFapyLbmFnQcPByBAmfpgzWKuZZSVMBDI
	rlg+BvRCMwnd6Eb9hfhIN5nfMmK9gCWEVFDYDm7A==
X-Google-Smtp-Source: AGHT+IG2bSPrt7nAL9old0fs5HVhqzAjeS2hr+WH+bLoWdl6OHbz9WTgZuJHGst3QbGxr6dEIFkxTw==
X-Received: by 2002:a05:6214:29c7:b0:880:5365:46f3 with SMTP id 6a1803df08f44-88d83f536b4mr33555556d6.48.1766127696657;
        Thu, 18 Dec 2025 23:01:36 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm13570166d6.40.2025.12.18.23.01.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:01:36 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 4/5] kernel: clean up non-rockchip arch removal
Date: Fri, 19 Dec 2025 02:00:13 -0500
Message-ID: <20251219070014.39432-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251219070014.39432-1-twoerner@gmail.com>
References: <20251219070014.39432-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 07:01:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2826

Over time more architectures are supported by the linux kernel (both
32-bit and 64-bit), and others are dropped; architectures unrelated to
rockchip. Clean up these non-rockchip architectures from the kernel
config to help keep its size small.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../bsp/rockchip/remove-non-rockchip-arch-arm.cfg     | 11 +++++++----
 .../bsp/rockchip/remove-non-rockchip-arch-arm64.cfg   |  5 +++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
index e9443f17895c..fdd3e6964053 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
@@ -38,14 +38,16 @@ CONFIG_ARCH_MESON=n
 CONFIG_ARCH_MILBEAUT=n
 CONFIG_ARCH_MILBEAUT_M10V=n
 CONFIG_ARCH_MMP=n
-CONFIG_ARCH_MSM8916=n
-CONFIG_ARCH_MSM8960=n
-CONFIG_ARCH_MSM8974=n
-CONFIG_ARCH_MSM8X60=n
 CONFIG_ARCH_MVEBU=n
 CONFIG_ARCH_MXC=n
+CONFIG_ARCH_OMAP=n
+CONFIG_ARCH_OMAP2PLUS=n
 CONFIG_ARCH_OMAP3=n
 CONFIG_ARCH_OMAP4=n
+CONFIG_SOC_OMAP5=n
+CONFIG_SOC_AM33XX=n
+CONFIG_SOC_AM43XX=n
+CONFIG_SOC_DRA7XX=n
 CONFIG_ARCH_QCOM=n
 CONFIG_ARCH_R7S72100=n
 CONFIG_ARCH_R7S9210=n
@@ -66,6 +68,7 @@ CONFIG_ARCH_R8A7794=n
 CONFIG_ARCH_R9A06G032=n
 CONFIG_ARCH_RENESAS=n
 CONFIG_ARCH_SH73A0=n
+CONFIG_PLAT_SPEAR=n
 CONFIG_ARCH_SPEAR13XX=n
 CONFIG_ARCH_STI=n
 CONFIG_ARCH_STM32=n
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
index 5b804a2ca26b..12fde404d64a 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
@@ -1,12 +1,16 @@
 CONFIG_ARCH_ACTIONS=n
+CONFIG_ARCH_AIROHA=n
 CONFIG_ARCH_ALPINE=n
 CONFIG_ARCH_APPLE=n
+CONFIG_ARCH_AXIADO=n
 CONFIG_ARCH_BCM2835=n
 CONFIG_ARCH_BCM=n
 CONFIG_ARCH_BCMBCA=n
 CONFIG_ARCH_BCM_IPROC=n
 CONFIG_ARCH_BERLIN=n
+CONFIG_ARCH_BLAIZE=n
 CONFIG_ARCH_BRCMSTB=n
+CONFIG_ARCH_CIX=n
 CONFIG_ARCH_EXYNOS=n
 CONFIG_ARCH_SPARX5=n
 CONFIG_ARCH_HISI=n
@@ -46,6 +50,7 @@ CONFIG_ARCH_R9A09G011=n
 CONFIG_ARCH_RENESAS=n
 CONFIG_ARCH_S32=n
 CONFIG_ARCH_SEATTLE=n
+CONFIG_ARCH_SOPHGO=n
 CONFIG_ARCH_STM32=n
 CONFIG_ARCH_SPRD=n
 CONFIG_ARCH_SUNXI=n
-- 
2.50.0.173.g8b6f19ccfc3a


