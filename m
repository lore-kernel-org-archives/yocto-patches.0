Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232AD2CE18
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 03:37:32 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62475.1764905845911472744
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Dec 2025 19:37:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Bn4s8S7r;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88043139c35so15636006d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Dec 2025 19:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764905844; x=1765510644; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYU4nmykbvE+e1CXrWm+zkLxlVuabO9SnclzSotrCvY=;
        b=Bn4s8S7rCrQf79oN/nO8RhlvBi1v3iHK11K4/GdXpAAXXGin1J+YBqoFlhpU8Hqw5/
         82sET9eOMZx8+OuwPzAALf3ACJDhDvKLD3hvAQhJEKXHekxruDgKtW0HRxHDyPH9BkSa
         zp/jkeJ61vyE1PDmPXhpoaUDsin8/HrTlH11OlrCaEuLdKwJbG1bcLQXc5s0OXFBWT+x
         JiS1i6qnJE1TcRiq5JySzwEUXVFm6z0wtTagJAUlwdamai93Lwg/tTELN5LdQXObwtPr
         H/Mz8R7eR5eGhb8QfKGPjDCGPOG7OW6gBjxUA4ruQBKysCwSJOZgNAshZhvxc2Hz0QCm
         vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764905844; x=1765510644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYU4nmykbvE+e1CXrWm+zkLxlVuabO9SnclzSotrCvY=;
        b=W8RpsITMBkcz/y/SxKEJvWT3Gv0of2THyMXh13GT03DNsbniD01pbLdvEEz9E1DZib
         iIi2AJ2N8OOjlYPTzDTVCCjmipJx9PSExJqBnvByCWor07fIiI7bu5bmOzG+yFCGx0hp
         N+fB9gIiy3uM0JmIQ6fvOJLRB+p5K4h4EzaQFQC9nORyHHKtDJUDYLUtowdbbaWT1c0c
         XZz7ELPyN+rQe/RjRJAhVbBm2sdbLC48AWMCqvJ7gETW65M881vRC7IhwwLHib0PJLIN
         szyYix98vMSZ6lLqVqj1kNOreG6+uPagAGfCvL4nyyYY3aDYGJKdeWytZyMsJHh31wfP
         rTaA==
X-Gm-Message-State: AOJu0YxjVxmZYgB1dtbTjn85xQxAojf/cz2W+dUjhQr2Ltt/INfpnWKU
	lghNVkW4a1SUWkBwTuXVU8vEYhchJ9wg0+HxdmqwrditGxYGsR+ATf0T5ASzVA==
X-Gm-Gg: ASbGncsE/LDQnHPfqgEg0bC0aevzuiQyreRQeg56ukdi/mJRE3/qU9+STxtgNJD7yYf
	a5kWNM/05V8xNG7IvchgJscsw/q+Wa9idndpAnG3gKKRFJMelNH0L32AwNl3VNyznwubSVOnexn
	0hEetOaymPFFBGJXik75qoSiO5PAiwieFRdbt0+k2/DoxhyXzapAFnhwKYLKDhxaDtvYdX4/aZK
	7xCMgmnVrepsaqKGcMos7G7u6m0bdAnJJPeOGlLKjBaM0nMBuEiI62ADrvrf9UaSttX/Gur1lFe
	IUMYo+bqFgqwymvittfT/5l1xM3Z7M+LGl3g8V+O+u+2tNMLpJk+mQFwcE89S/WN21B5zqKJH4w
	rZNfUY5VG14VQOCudBYUK6WxWmuKQoj2QY5KUlJ5f11pKamiZGVvLNX2eeEi+n8a+kCx4sVPnMe
	a0eE7aebQGdOjqy4iDLpyJ+QO0ghCsCeRffH5I2A==
X-Google-Smtp-Source: AGHT+IFLJi1X4OZm+9NHk/vbPPF/433u/eJSqXi92AUURJTg3so88XDtgrTgv5dcFW67hq9Jjuls8A==
X-Received: by 2002:a05:6214:3008:b0:888:1e72:afb5 with SMTP id 6a1803df08f44-8882481c01amr84919686d6.2.1764905844429;
        Thu, 04 Dec 2025 19:37:24 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f335dbsm26050246d6.8.2025.12.04.19.37.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 19:37:23 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/2] remove-non-rockchip-arch-arm64: remove new arches
Date: Thu,  4 Dec 2025 22:37:15 -0500
Message-ID: <20251205033715.8852-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251205033715.8852-1-twoerner@gmail.com>
References: <20251205033715.8852-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 03:37:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2737

Over time more architectures are supported by the linux kernel,
architectures unrelated to rockchip. Therefore remove these as well from
the kernel config to help keep its size small.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
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


