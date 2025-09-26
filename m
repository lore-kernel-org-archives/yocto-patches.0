Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE5CAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 21:10:50 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.2045.1758921045892562518
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 14:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=eu7J5ILL;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso19766965e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1758921044; x=1759525844; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2ysXVmCnlU3zXENeEjiVsB43arFxgfc4BRqrxGaXIw=;
        b=eu7J5ILLETLgG3mIibiDCNon3FPqesxT4fiIAWCXMV60EboP7NKJpFVBcrq+DXsOm0
         plcqB2GM3jxk5HVNRdgTu1k7rHIuE2jdAblrDRNF/YRawbHmbAR67CKDXJUUnHjbJBZQ
         hSwmp7nXGDdJfefVcGFJ2Ns3Q5LsgzLObd200=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921044; x=1759525844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2ysXVmCnlU3zXENeEjiVsB43arFxgfc4BRqrxGaXIw=;
        b=nVsdSsu3/FmYh3bprR/nCaJu80yy1hj+N6wc4Qz4SV2Hw9si2VI7bJsPSOxp6o+f3T
         08bOHe1lbIn245BITJXn+Zs4aKNAzgLxfjehrr/sQebvi9thWmijVANm/W2nZoOeqzz4
         rNTf6TOJCXBJIlXmho5a06WpkAijUMcbPiUz4Hb/A+wr8XbVfE2+DmVPw4HhuS0QY/Bg
         bhg+v6PQmYaO1NWk9mf4plojZuns1lhaUNBYifq/q/74TdTCtjeOVeLdOsLKIiI9ZuKQ
         XNmnPaULjG4SDzwHl/tPJ77fqH7t/wr5BcZxpGwVCT4hdgRmM6xLoPAo8hdD9jNauz/S
         b8tQ==
X-Gm-Message-State: AOJu0YwsU4MBE/z8Nr3U6KXqe+CAkH64I0uiDx02pgv117Lom+SPfwhV
	S9liNPFnOIqZguh5rjaQzIAR26nUbeW1ZaSZwz4FeDalw1TVyJGsvu662q7a10BKO06G4BpREqI
	/ukw7pzg=
X-Gm-Gg: ASbGnct4sNthRidCWGStR4fBguKF6TeS9Foc6T9vjsqyj76wtg6PBjdqilLLG3sy5cA
	18imN6IKRzCD1jVMLE1TwxDcIFcF9H93BAxwbdkL/Zdf+qiedL7feiVXeJ/C844Kcb/wjk+5IAT
	cB+wOlSX4QibarbRePeRdNkceq5nVE0G84qx3nIxfxwj3YWgKpYZnb3lsEyTFdXk2pHp0Mc6ZFT
	V6bT+Flh+6aAt1E3ZtS/mLpPtR7/QmgnjngYDEiT+ewReJLHhU3+4kalGNmua+QBKiZlzEBiFhF
	qFvluh98ea/pXzk5vpZOnUpZAU4QNB4agnbdEJHw1a2SZdP3FLD+gnY08fLzhi55mWW+/CLwK++
	lfcBMSDiXYrQOcIgEyYzX/IAh8mo5fbCUbEH9Im1xK/0en+e4REx/F0/4zLk3glfvyz7Jizj6Os
	KyC41XL6f89m7GnJwkMq4on4pduQy5Hw==
X-Google-Smtp-Source: AGHT+IG8qUveEdKt+4sedZVExabY4B+jktin7TBXG69gp63/LMr0L8LEfnISV2e9ua0PZn5DeDpQOw==
X-Received: by 2002:a05:6000:1866:b0:3ee:13ba:e13b with SMTP id ffacd0b85a97d-40e4ba3a8dcmr7979841f8f.33.1758921043793;
        Fri, 26 Sep 2025 14:10:43 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be3268sm87163925e9.11.2025.09.26.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:10:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] config.json: meta-oe-mirror: add "opencl" to DISTRO_FEATURES
Date: Fri, 26 Sep 2025 23:10:30 +0200
Message-Id: <20250926211029.637232-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 21:10:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2243

From: Yoann Congal <yoann.congal@smile.fr>

Some meta-oe recipe are behind an "opencl" feature_check. Activate it
for the test to cover these recipes.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 90cb791..588a2f6 100644
--- a/config.json
+++ b/config.json
@@ -1696,7 +1696,7 @@
             ],
             "extravars" : [
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
-                "DISTRO_FEATURES:append = ' pam systemd usrmerge'",
+                "DISTRO_FEATURES:append = ' pam systemd usrmerge opencl'",
                 "FORTRAN:forcevariable = ',fortran'",
                 "RUNTIMETARGET:append:pn-gcc-runtime = ' libquadmath'"
             ],

