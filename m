Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1DC61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 22:40:37 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24373.1787784029088584108
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 15:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Y0BOMsoA;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499cb997b8fso9550775e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1787784027; x=1788388827; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5h4RvhLjGlIj/zJmX5tLdyXxwnIOyZnjMKGCeailD+g=;
        b=Y0BOMsoAJlBzRqcr5vertMb9LTH1W/2rySLKxMYvkEfMGBJc1KzuxaLxH5YJEqq1tF
         WOc7AvKDQr3KhFigXcf2agAuRBc6eejxQJleWP9v09ubHWrKibrvq6L0akB+6+Cf0vv0
         HH2BGHYca5nIgTHJeRDtAH2JpDOM4/6d0D124=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787784027; x=1788388827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5h4RvhLjGlIj/zJmX5tLdyXxwnIOyZnjMKGCeailD+g=;
        b=T2wpmO/JApYIbGBWQqm/DBfhmRDONxLTLHi50o0YvOQfPhy+F4i2cm9wvKkGFt3Zul
         fK0oAw8vhv9qqXs4OWNT1LkM9x34lQzLRtCwTgx/0yRgIQMZAQWRm36OC9q+kwDQVog3
         sMnc7yT/X2QM9y4jKg4yQ5mhopAHj0PZcKxRb6T5EHNGbm70A2IoJoifdx3kWOgJ/rhb
         0L+6LObwE3X5X2u8nZqY7I2mZok+5e1qO7di1Lxy5EyrqbtMlS7Mfhi7FOs6SKIjduA5
         xbsStQPXOVTOsKZRJM7ql9Xcc9epzF2E+UPXe5Y6S8lkecJ5ZF3NB3JyybG+OQKGhytl
         3y6A==
X-Gm-Message-State: AFuF++kBLLdhwsInySVSwT7IyrUxdwSbRrMPw2gPzKMwXqPqQhKKlpRX
	RX7yYd1ijqa6Wchb2HDqtSSFWV3TVm8vYbL0+u1f9VKGU+3IY1wMh8oegYezXCVmDr3PRePa91q
	BEATgBgg=
X-Gm-Gg: AR+sD12OG4XB39uCvssuAmego+hVX5gx++0L3pb9ZHj50jlXCCHsJg2O6upOWy3z0hP
	mWRoEh0g07oRllZb/9fxWYrKzE/TY3Vrdph+1qm4LRUM6zbFszFfuB9svB0IgZ5ioNTW+Awv9bz
	Mz/dVJbXuqA1sClMmqqZ2Hbj0R0suUydq+JkkQNrecf4xLE+6YdYJPzWn/INPPWUxQRrR+wfnXX
	UudAp7XflFAaRXU/JzI/+IEDWjV4gOitVV/Lbs547nwpB2Q1AUqxnmyzISI+o4o84S+1S6OSOaF
	UtZpmP2MsAeKDSBCaGO0QaLD+z5rNncdoKDVawTa643Kcbgs5yxVkd8vB5L52IjwN3V8B5cuDdA
	vDPz1MZ/FHc1DIVYyvRHtZ7/R1hx6x/633RLzhg7U9oV6TNmkK1DguuiDOPo60IJDylgMtnW1cJ
	buasqrdfqIW6lv7jRlq1LRMvUyE5c0TTflh8kgq0ZV/sNEozpWw5C8xnw7M8onVDc37+6W4PruO
	2z3phc6OiBUHAtM9+oVGoyIkobiBw1csDKGohGL1nefoh7rQ3b341G1M8zRsMyN
X-Received: by 2002:a05:600c:c87:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-499dc93411fmr81909835e9.15.1787784027364;
        Wed, 26 Aug 2026 15:40:27 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4ddf5023sm779735e9.13.2026.08.26.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:40:27 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][wrynose][PATCH] config.json: add mixin-wrynose-linux-firmware repo to meta-qcom build
Date: Thu, 27 Aug 2026 00:40:11 +0200
Message-ID: <20260826224011.1389348-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 22:40:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4708

From: Yoann Congal <yoann.congal@smile.fr>

This fixes this error:
ERROR: Layer 'qcom' depends on layer 'lts-linux-firmware-mixin', but this layer is not enabled in your configuration

This has been tested in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/113/builds/1487

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index da578ae..82c5f16 100644
--- a/config.json
+++ b/config.json
@@ -675,8 +675,9 @@
             }
         },
         "meta-qcom" : {
-            "NEEDREPOS" : ["bitbake", "meta-qcom"],
+            "NEEDREPOS" : ["bitbake", "meta-qcom", "mixin-wrynose-linux-firmware"],
             "ADDLAYER" : [
+                "${BUILDDIR}/../mixin-wrynose-linux-firmware",
                 "${BUILDDIR}/../meta-qcom"
             ],
             "step1": {

