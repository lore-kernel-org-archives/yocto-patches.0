Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4AE67494
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:49:00 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51713.1766278131463356538
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 16:48:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L9MzGV8t;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8885b3c06caso44992366d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Dec 2025 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766278130; x=1766882930; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6WpzvTnWyR+O4VaVLAqcQ4q+pM0ycwKuDP37Sw9o38=;
        b=L9MzGV8t+1b6WWiWgVGu/SiPHhe2IKpQ4iqMwSL6BhxqbxTosLLfFA9r01B2IssWnX
         rFv0PTQehNIVCGar4AKwyLB7Wm6sOkfN530+buMO0HeAWG6GRJtmsHLO1xhhtLaLEjoo
         IWY9e3DpwhjL1ow8onOYiwheq0KAewYbHcnAjpr6ZaSUhip6wXoU9Hwe+G8ERiIAKL8+
         kX3o8CKHj5Mpo8V92me7yLFnC0UcsKozeK7o5LDtuTpLUI5gCONiFOboy4H6CMXUow9D
         Jj3jO30szONF16zxS93JGvY0TrryqIkJJ8JiSfOq+vjJTbsFddtAxGVzzRvWj1oZ0RD7
         Q9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278130; x=1766882930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w6WpzvTnWyR+O4VaVLAqcQ4q+pM0ycwKuDP37Sw9o38=;
        b=JeZSL+GsB3V9VOeJ4NIKBCyZFQo3H6bgSshEutJTPUXqqNFJ8bB2bRkwHuiMUaBYCU
         FIHNxH/MJ34JA5wC2lOOsWxVsJ5hJKCwhGQolCB0P+rL5J6tQ/LB/6VWBgdWV2/3Sil4
         1MVJlJHr/JFPM5NFwWJOWO80Q+VpgGcGstwQFxEbbvVgT5CrDEUGMUVx0jTXm7qsMVmC
         xDFh+afU7AwUpPEgTKzg87NnT5HlQRg5J0CZGQgRvNW9J4ewqc97ENGjSoiUQcxBPCyf
         T9jtcAzUI230+Q+aaVmcNfV1rGqgs+7pTGytZZJ0KqkmjZ7PnbZjcaOFXxYhf60u/EEI
         M7PA==
X-Gm-Message-State: AOJu0YwZy848HSQ8FKjezvcCyIeTKXAKhiAJoMS8iaPJliTMmLqjZTQH
	4oExDDu53LnbCV6zO8al1N24R1dgYOJuAn5LCSaSxILWHupfnrOlRrlQrqa4cw==
X-Gm-Gg: AY/fxX6eklZwSoBzxq3ChKY5zDp1Nb4Hrhit052jNtU+0oHlJjsr6t8vVSpL8/p/q4U
	/xuPoWFdi3bZPEVELOwy89MYfPd1WJdt73oIJ7EQEWRuMQS2Im1j2PIVKV81x6YHV6BXqvoS5ha
	YSy7duqx0yXCB7M3Ls9nLdLsGn5pHKBK0Rx93lyHwsNWS7uaAN/AGTyPBrTAkDltGOfJo1OiSyW
	pIIdpfOpZc2tB6spyG5BC8JJXKM5Ug/HX4X8Jg0VEB6F27tVAMKHBQ1bNJs/TfG6Jsd8ROz4oUK
	Wc0IW1xL2ALerQ08eWnQXKOy1P/g2dNvZpL1OTIQdrAJRUzRa6A6+dOx598ujb43C8Bb9m38LLd
	GiU0aSOmBEmgWp6zXP8srTlf2RQ5t6VlzkAhTKwzlHZxmlvWi7HymlFrcfbbGST6U1YE42WPx1s
	4n8dawt7YRt2M3jz75D1B8cNKsi1j+EiTaTnWwByTUIBMMBhtz
X-Google-Smtp-Source: AGHT+IFtLsaZ9Iok5gt+1yMucWhgnsN3ygz58/97GP6HKu21xEMrByPfAYaIC8IN9piNCBnybX22Kw==
X-Received: by 2002:a05:620a:1904:b0:8ba:419f:c79e with SMTP id af79cd13be357-8c08fa9c407mr1091679485a.55.1766278129986;
        Sat, 20 Dec 2025 16:48:49 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm511867385a.41.2025.12.20.16.48.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:48:49 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 4/5] kernel: clean up non-rockchip arch removal
Date: Sat, 20 Dec 2025 19:48:42 -0500
Message-ID: <20251221004843.31946-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251221004843.31946-1-twoerner@gmail.com>
References: <20251221004843.31946-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 00:49:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2840

Over time more architectures are supported by the linux kernel (both
32-bit and 64-bit), and others are dropped; architectures unrelated to
rockchip. Clean up these non-rockchip architectures from the kernel
config to help keep its size small.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- none
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


