Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE7D3B7E2
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 19:36:08 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1529.1765222560951362379
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 11:36:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V8hFlXJ7;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b602811a01so479927085a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765222559; x=1765827359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xip29A3vAihWqh4IGNosJneLPIbL+bpZsfNaiNtOpUs=;
        b=V8hFlXJ7/0hz2FkN0MrdPBgqer0fhQw4irafOl5LAZYKIyHW/kbotMyUW/6rHPWNuC
         qFnnxgCHrzHuuRIgYX6LFou36gg2t3vFH1onUvfntku38+CAP7pfVsr8Zz5kCItuj+Wr
         6AqHe+cvLk8MIl/TggwkVPoSeEV7KXqzWqofPdqNQgkkmZzIiQ91QbUNC843mvWY4qtY
         U+GkPLVSb0bef9EZFQkRhn8yHBtV80UGrGNEACCJ7GP3LlJLAAVs12Qz6b1bDN0BYgyl
         WvCa9ZXc9eW7roQn9WQuTzHvyi3y/bPa2rs8/3QcpNa8l0jrL4ShNqup/l9t7irut/lm
         zwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765222559; x=1765827359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xip29A3vAihWqh4IGNosJneLPIbL+bpZsfNaiNtOpUs=;
        b=atYNbVhGTysYbto+Vn34UDUQZZfe2wwmpiKK71uZs1yUwewJzINaF8HAoX99lE0Bzt
         SZzv7dFW5c9yBd35ZnDVMZrDMgdAqx8t9j4VnLFiikXDgu9xgqH2eWQlGioToGOK5tq7
         sYcbU20oxy7YFw2kB0xj2aRROyOwYEbLpcr6vKamJhlmm3EpZfPKbegxMteen/gyVoAg
         gpCoHnjdtoMaK2CH1HyFobHswcvWW96ouugt0R974RWNK68TkvOkA9AU/2iPyDNNDKPI
         mL8gGMHgkCU/6zOurmHcMUe62HR2c7z6WhSk4ENInQvwoq3/45Nh84UioOPvRpoTvPED
         RgSw==
X-Gm-Message-State: AOJu0YxLy1rnGY2LYq+6xCL3bV/mRE4ooLodLTS5IIWMA0xM4ozd4Qxt
	VagPKKcpuqD/koInLF1lpkkLf5FELIxPt5QnRs9uZ7tCEJIRPg3OehQwr33TbQ==
X-Gm-Gg: ASbGncvbptY/XpF+ol7yiSV6h6TxZMWGkB3umw0O5LIPV/6hwf5Om/kjpsx8jKTvlpn
	yCCKg5sAm+Oqba7trx3I+0AAj9ztjYw75pp0BAdFgKUMD9YFxCXOKUEyJ+mS59HgRU6MrvEnkZX
	coO6SHA5UAQoC1QJ2cMDbmJni6mnGAy/t7t9WwKCWPY85RlLz0X5VEJtPi+pnhmod1p3fSGqFgM
	OlSs5QdCwWGTpzrP1LN55WopxxFlWW+13VlTozxmIaWXO/Q1+Gw3OBfDoKmxnOTpXxYBhO4edOp
	5tqJN441kw9YAFH76gE2u5SJ2AmVt7VtMP1DUT4fkn10+EA+EaXQC/LfjhTZDId1l97YMDMBn+H
	0uRdIahqXwREtBTdgAaRLF13Im3lc38QM3tFSTpwy8+phXRjTUo/IuUPh+A1eQOF396xCb5ek/C
	DDvilQnEu8XPtsd3e8HJ4RxhcxU51M+uPNvOJ2MQ==
X-Google-Smtp-Source: AGHT+IEuFW0AGF9fXZws6oKiDcpkZsoJnuiL2nTUmKN+I2DE5TGTDj1ompulhDk0WBih5e1r4URG1g==
X-Received: by 2002:a05:620a:4452:b0:8a3:9bb4:9e4f with SMTP id af79cd13be357-8b6a23518d4mr1208542485a.30.1765222559383;
        Mon, 08 Dec 2025 11:35:59 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252a01fbsm1120043485a.7.2025.12.08.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:35:58 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 2/2] remove-non-rockchip-arch-arm64: remove new arches
Date: Mon,  8 Dec 2025 14:35:51 -0500
Message-ID: <20251208193551.2426-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251208193551.2426-1-twoerner@gmail.com>
References: <20251208193551.2426-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 19:36:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2750

Over time more architectures are supported by the linux kernel,
architectures unrelated to rockchip. Therefore remove these as well from
the kernel config to help keep its size small.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1:
- added Quentin's Reviewed-by tag
---
 .../bsp/rockchip/remove-non-rockchip-arch-arm64.cfg    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
index 597d47a424d2..b4b657e00e85 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
@@ -1,12 +1,17 @@
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
+CONFIG_ARCH_BITMAIN=n
+CONFIG_ARCH_BLAIZE=n
 CONFIG_ARCH_BRCMSTB=n
+CONFIG_ARCH_CIX=n
 CONFIG_ARCH_EXYNOS=n
 CONFIG_ARCH_HISI=n
 CONFIG_ARCH_INTEL_SOCFPGA=n
@@ -14,6 +19,7 @@ CONFIG_ARCH_K3=n
 CONFIG_ARCH_KEEMBAY=n
 CONFIG_ARCH_LAYERSCAPE=n
 CONFIG_ARCH_LG1K=n
+CONFIG_ARCH_MA35=n
 CONFIG_ARCH_MEDIATEK=n
 CONFIG_ARCH_MESON=n
 CONFIG_ARCH_MVEBU=n
@@ -40,10 +46,14 @@ CONFIG_ARCH_R9A07G043=n
 CONFIG_ARCH_R9A07G044=n
 CONFIG_ARCH_R9A07G054=n
 CONFIG_ARCH_R9A09G011=n
+CONFIG_ARCH_REALTEK=n
 CONFIG_ARCH_RENESAS=n
 CONFIG_ARCH_S32=n
 CONFIG_ARCH_SEATTLE=n
+CONFIG_ARCH_SOPHGO=n
+CONFIG_ARCH_SPARX5=n
 CONFIG_ARCH_SPRD=n
+CONFIG_ARCH_STM32=n
 CONFIG_ARCH_SUNXI=n
 CONFIG_ARCH_SYNQUACER=n
 CONFIG_ARCH_TEGRA=n
-- 
2.51.0.193.g4975ec3473b4


