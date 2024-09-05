Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72252CD6E74
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 17:16:29 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.15381.1725556581823273668
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Sep 2024 10:16:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U7CrO7aO;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so3259946d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Sep 2024 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725556576; x=1726161376; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvKN4LdO7SapXPvWgRxhmgoTaWPO+iPphVVfD+53y9Q=;
        b=U7CrO7aO44qEPyAdImnALMMy2rm4RCM7vc9xHeDZgaq2yQ9b/QD3SUzlmVr53N1mr8
         1hHVGFoVTYpd96BaLMTwWVkb9nZ50CRKF/2esJNf9l3ay2XemU/hQekMCeeZcfIVaL8u
         iYxcz+bl5XcLLtOfJ2nStI/Btd4E6KrRo2fo1aFf0p9bY9jSwcespnEW1OO4gHi3lkB0
         2zszcVxUiDDuQIA0chrvUApwrXMfwKGL58tVziTiekOOJCPsDY5BRCLHkOm4LSQtfywr
         tH/XMevjdu1HixtDRlyvYtlmdznnScRFPQaGlOzUlnlhqZLKFOjkBcPoMeFBncBr0s5b
         n2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725556576; x=1726161376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvKN4LdO7SapXPvWgRxhmgoTaWPO+iPphVVfD+53y9Q=;
        b=EYca6dTvC4sBIeQxn1T9qkZTntmM/j4OgYWfC1pZGG0Rfmx1VO8oX7Q92xLDUm9DKR
         8lmw5GuDoWgLJuyjj2G/eyZcRPCPTNbYRJ4eI5jdM0N+vYpmlp6FT0kGY+CZaFv4BNoS
         Zie0Ox3mi2HPDC7BME6XBcTQW7u8kj4PeqwuwnoeUW0Zmywl9N2jE1VBOh0Xg9aNVP45
         FXAD85JFjKQLpEshKj9jzek04ejxp7r9wxwYNkjKD6xiqdiM5uB+Xxf7mrzjCwJYNfPK
         n8bexNJnXOOFqZ3knwwthNzhIcj8uOrS/ATX2T+6FVlQiFDTIqyPfijmxUgZqCk7ut+R
         E7iA==
X-Gm-Message-State: AOJu0Ywb2xpPYYymgwCBHC9i/fmMcEi9DwZYBfnOryoS6zHLq1X6hez2
	eKQEbI7Px8HGLIvn1WZjpFOTWpvHA1siqd0niEKWLxeq6A4nlBzE9MX9Fg==
X-Google-Smtp-Source: AGHT+IFSUsjsn8x8cAv75iqcn+9Ki6jgA/KLLbGq21b/5nliWRCuoRHd7LJV8nwcgcNEtdz555p1FA==
X-Received: by 2002:a05:6214:4386:b0:6c1:6ed9:24bf with SMTP id 6a1803df08f44-6c5282fecb4mr196116d6.17.1725556575834;
        Thu, 05 Sep 2024 10:16:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dee1bsm9174466d6.28.2024.09.05.10.16.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:16:14 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-torvalds-next: bump to next-20240904
Date: Thu,  5 Sep 2024 13:16:01 -0400
Message-ID: <20240905171601.3137-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Sep 2024 17:16:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/611

Bump kernel to tag "next-20240904".

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index 6f3db7c61bdf..b961b1408f09 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -10,15 +10,15 @@ DEFAULT_PREFERENCE = "-1"
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
-LINUX_VERSION = "6.10-rc3"
+LINUX_VERSION = "6.11-rc6"
 KERNEL_VERSION_SANITY_SKIP = "1"
 PV = "${LINUX_VERSION}+git${SRCPV}"
 SRC_URI = " \
 	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
-# this is tag 'next-20240611'
-SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
+# this is tag 'next-20240904'
+SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.44.0.501.g19981daefd7c


