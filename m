Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FBCA0FF2
	for <webhook@archiver.kernel.org>; Sun, 31 Aug 2025 11:41:22 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.27714.1756640475397120907
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 Aug 2025 04:41:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=czozcFxW;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b30d09da3aso25921261cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640473; x=1757245273; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qooX+kZQrPEC6eIHL4TpStCM7OCnIXIsZe5ASKQPciQ=;
        b=czozcFxWoyOKqIaGlkQ1sDkpePGwEYJrHJP7gyBfjmQUZOWcvdgyTIA0P8T+eV6iTW
         b4VhVGyMLVVLUbX/DFW0dOVobwK4upsNNi65jIuJhxCyrD6pZn4VxzqUqVx+Q6HcY9q2
         FgYqr6ynA+wJBOuXOclajq/YMOlDepa5JIy/HXTzkVizIsGn3I97v/hCfg+awVCzL8A0
         jwBrqOTfK4aePpBpnK7kfrY7loPxwoQN6lCDkLmk8wlcbKdCtRNonBeGEI2Ts07nb35q
         OsK7iExlS4450LJB2myOqQEVr9XstYtpDlgP5sKsn20HP38178vc5vRw0cJCj1iYE3Se
         KPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640473; x=1757245273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qooX+kZQrPEC6eIHL4TpStCM7OCnIXIsZe5ASKQPciQ=;
        b=dCgp8ZBVPmyCvWtuHnqpLLIYKQLOkT72k9Fdu2M29yVST7+zw1oM2/y4CiW3KLiLEO
         bxOL1DDpPlXuKx6Hg3oddCqy6UJ6YYmq34cE4eIvSFPPIwivglde9OUynv5ZXhpxm5qt
         I/XXNWJw+VyCKEJmEzvbKKeiLK+fYYFM43sNSyGBd+oo5OTp1aT4d16Gn/v7lPvxg9NN
         4PJ4TO0y+LsXb4AesM52sHm8k/gVSLCBaot36ddu82XIK1Dz9Ye/1J1BRWRMAbhSzF9I
         dBkhc6nAEcxKl/kbBdkBZdDnCPYABaUIornZN5nwoaewscBKjSBeX6XpPOuJvswiEMzw
         +Ntw==
X-Gm-Message-State: AOJu0YxbRLPQP1S5ipcEvroB8fHFKqhS/RqhbmF7/cNXN6UaR4FRC6mw
	JWnurxiOrZkQ33+ECByEg8hezO44z8s+4F1Q8/UquBtF7WOrJuVQWaLIavQ5fw==
X-Gm-Gg: ASbGnctlriJJCIWSQhdhV6AHpgSH1UHzial5ig1jZKAkfT2mzSzA8nNCCHXhtIp35Y9
	1muAVp16XyD5kpAOvrgtPlp8ujsznprHtjYBlAGaDOCFzAfPRsgYte57AQs1lwrEGj5W9em3U0F
	f9nDcu5R7WDcFG4zTaGhWSWWQ2CmwcUorf2g08HKNAsaW/zrYr0zHaBiI+k9xN9oWGAtdGr6wag
	KtgDVFibHxKfp1PDFXWmdnCKY6aIRziTbcDp6HdWTlTkVRF1/4OwvOtFjVbjDQtbUFV2rrkK7+d
	girT/rTDe+u4sNlFM3uQGVdUClY6Rn21ecuxVOAk9jpryPbPDljQX2brdv6sYAWScAWC6f3x1tm
	nsABo1dLrr/+BcKlwNqzfBYDxR1AVVlSRaVc8/EQdyowbuPM6KMn5wnH9UKugx35kssxxh1m+R2
	Zo
X-Google-Smtp-Source: AGHT+IEtZ+GeUaf6reLS/MtGFtvZasxNzKO00Q+jtkOkof0erHkPOor3uMAQkABty95UJs1PYyJeyg==
X-Received: by 2002:ac8:5f10:0:b0:4b3:d3:e7a0 with SMTP id d75a77b69052e-4b31d844931mr53715151cf.8.1756640472951;
        Sun, 31 Aug 2025 04:41:12 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6fd490sm45174911cf.53.2025.08.31.04.41.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:41:11 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 3/4] orangepi-5-plus: use non -dev kernel
Date: Sun, 31 Aug 2025 07:41:04 -0400
Message-ID: <20250831114105.27494-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250831114105.27494-1-twoerner@gmail.com>
References: <20250831114105.27494-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 11:41:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2095

Now that 6.16.y is the preferred version of the linux-yocto kernel, the
orangepi-5-plus machine that had been using the linux-yocto-dev kernel can
be switched to using the linux-yocto kernel instead.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/orangepi-5-plus.conf             | 1 -
 recipes-kernel/linux/linux-yocto-dev.bbappend | 2 --
 recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/conf/machine/orangepi-5-plus.conf b/conf/machine/orangepi-5-plus.conf
index 2731ff4d871d..a726b1c0ca67 100644
--- a/conf/machine/orangepi-5-plus.conf
+++ b/conf/machine/orangepi-5-plus.conf
@@ -5,7 +5,6 @@
 
 require conf/machine/include/rk3588.inc
 
-PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
 KERNEL_DEVICETREE = "rockchip/rk3588-orangepi-5-plus.dtb"
 MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
 
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index b876a1cefedb..6f4981fe29e6 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,7 +1,5 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
-COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
 COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 
-SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 9d60e2641ec5..45cfb1c10b48 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -13,6 +13,7 @@ COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
 COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
 COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
 COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
+COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
 COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
-- 
2.44.0.501.g19981daefd7c


