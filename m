Return-Path: <yanis.binard@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A2CC6B33
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 08:54:57 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11383.1775120093772510588
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 01:54:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nr853iTD;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yanis.binard@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso524635f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775120092; x=1775724892; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11peD9uUl4hoREma+PJ4KLfPbDSCqFhefG4rk6JHwj4=;
        b=nr853iTDem88V6X1hTqxDN+2hUIiK3sqCMV5tv8rRAIBUG0hC5XA+II2kdkJiCOAL3
         YvCQNl2u3i/CC41A9g/WSAbUXIosl/75Quz32JzmVBne4uyzcOmPspOuOp8FrKkqrsFS
         UkeWMXGr1mN7/90xVLbBmX9TZAeJ72oG6dDpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120092; x=1775724892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11peD9uUl4hoREma+PJ4KLfPbDSCqFhefG4rk6JHwj4=;
        b=Mbq/YLbQ/zwxehfW+DW7LpGqfpUo9wT3aKtNxA5nhxiYU7WCbK27qsO5JhuBHYPuZ4
         637Wmotp01ysUA1hQd3eAO2dVT9WsXWr9zsyvxM1QHjZo+ntWfhfd3ZDz8rH86ySNKC3
         aX8N0jIXI87SDx6JozQm6GHZJeQhH8yaLSs3ZkfBo3YcTJT7vrDJihaTRdj5/kWI9rsx
         b/Iccl7PB2EbxvVdBR3foAT3Hcm8FXflmYO+mZxRAxHki6vhVMJJXxX22zy8N8uAOP9o
         nFAanIpBz3Lbu58X0u0Y6iJphDyTy0pn91EwDSRMj381N158L9NnKQIq6PZFzq2TFKr0
         pkvg==
X-Gm-Message-State: AOJu0YxjpOwLFFrS8rNTt7tdFuHXUunaYyTmVKXMQRDxDAu7a03ML9iG
	w+cOOtXUb72zAg4SpzkcvDKFHHWiKab+8vhQ/Nafyyn4f8v90xaC+jTWVdsDc4MFh3Q8YoANLtU
	LDn+llSowwA==
X-Gm-Gg: ATEYQzwX8kZeTpIdis5jnCfXniWHfwOxvB/y0O2oB/D0z1EuC34+ZNA4+tamv7sTHu3
	HyDBRyxbaIDTwx+LNUg7tkkeLi0YHrQEV6d8DcXeJNpZGKmnlgCva/wEACOs337aUtkcu41uE/x
	LPUtMPnaf+bx6lHO8k7FMKF7FXfbunw/qJn0PLFV49N4eSH3B3+V8+qhYBaI9kF4s3UENUyu3d5
	BWA2/S5wvddu8jPBadHGA1QrpVmJWReL/j7O/kXJejVibYiupzXlteige6kQTyBRNkKt/zKsFnM
	f16zBdd2qLgu0oTwkBHMfKjMNx+LaOHmMya0wzYBcNha9Y33fUz7tGFtKgihSIdVOgUsN5bMkGN
	RPVwlZcM0So+9vHPuFi8Lbu5cS6fGikGSPItOChRAMExllGEdcG0gtMY8UNf/XdBOnm6lGHxZs5
	0vQMMcaKLTumfdxjKz7LoQK9KcdDMLDXsQ5wzEeo+Php1dOp270HmrwTJ6famISPB9yzQyGTVxw
	3YmBK8La1uk61qwD8A67cWYaRxNuo5Mtg==
X-Received: by 2002:a05:6000:4205:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43d150b87b8mr13517831f8f.28.1775120091793;
        Thu, 02 Apr 2026 01:54:51 -0700 (PDT)
Received: from P-ASN-MAGENTA.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm6053870f8f.19.2026.04.02.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:54:51 -0700 (PDT)
From: yanis.binard@smile.fr
To: yocto-patches@lists.yoctoproject.org
Cc: Yanis BINARD <yanis.binard@smile.fr>
Subject: [yocto-metrics-meta-oe][RESEND PATCH] patch-status: Fixed typo in some h3 titles
Date: Thu,  2 Apr 2026 10:52:58 +0200
Message-ID: <20260402085257.7430-2-yanis.binard@smile.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 08:54:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3614

From: Yanis BINARD <yanis.binard@smile.fr>

Signed-off-by: Yanis BINARD <yanis.binard@smile.fr>
---
 patch-status/index.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 071bb1b7..cdd89e6e 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -95,7 +95,7 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Patch Upstream-Status Counts (meta-openemebedded)</h3>
+      <h3>Patch Upstream-Status Counts (meta-openembedded)</h3>
       <div id="upstream_status_chart" style="height:400px;"></div>
     </section>
 
@@ -105,7 +105,7 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Recipe Count (meta-openemebedded)</h3>
+      <h3>Recipe Count (meta-openembedded)</h3>
       <div id="recipe_chart" style="height:400px;"></div>
     </section>
 

