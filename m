Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30AFEE4DF
	for <webhook@archiver.kernel.org>; Sat, 28 Feb 2026 09:21:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.116143.1772270473033389423
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Feb 2026 01:21:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=n6YwUbc5;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so30680505e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Feb 2026 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772270471; x=1772875271; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKoh7D7A6CS4u5bA5aph3uruy8ExlHBLwGno00y7eDc=;
        b=n6YwUbc5JAr6kWv3lhmti50d9tPXd+LoWhWK4ZooHo90t4hahtaoE85mIXQ01NLb3u
         dahg7kRHoZ1CaSfZ5Ny3vXV9iWfo+WpOi/IrfLiI+nKeg19ngpfH9U6q5V9i+Qp1J3iC
         Mtqo680H0l2vlElYHvUgq+wFsQpuipG8enyU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772270471; x=1772875271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKoh7D7A6CS4u5bA5aph3uruy8ExlHBLwGno00y7eDc=;
        b=HdY+MORkt9q0+rXt5G3jd68jvSlrc3gqm4Q31rRiE83BzKIuDcb9T1Jtz0WLxw0ZRD
         1DTPkp5MEpF5jerSGna57Mmyvv8HMfqupoeS0Rjf2y09eFx/h10MIhIZGrhmjbU56+5c
         k7660tTKRvcKzT2XAwmJk8zjB+iih7L5ZAfEtom37wxkcY875X8eKzLtQXYZx7aXWA4n
         m96dMrT4fQNrAlAuem80tpPnOQ8+lX2yEs1FwmyagP3drFK8LcFTfXNDHsqS+1KEu3Zj
         y3Y1KxKnZhUo0EAbwwbH7U0Ty4kGlebffJxlEOjr5qk8XD6jTmBtewA3lSQ4sFAY1hLC
         JisQ==
X-Gm-Message-State: AOJu0YxIaU4RSf6AnYocHH/wWUpqD8tJGz3tOiMmoTwxYFsCc5W4l4rn
	rqzKDxOnQPqnNkRTVZvYpAUng+q0vTepLizG+glk4XIJStZLws8c476fKHkRDLfVthwGVWK4plE
	VCTOm
X-Gm-Gg: ATEYQzzVpCFI1wwbbCE7CYlBMsDPTwM+GyQPq3uTYxVdKiRLIIWOwzVR4wfer1oMRSN
	rsuAmEnh0N+ckwx+66VGIpDwL2T4a3cYSM1xPH8mcOo2oeJ+1BuYogPKaW38k2vWWOrTHkvoQJt
	vIyzrOpwuv5qwwQK8Bx1x3KW5F2HeKrG5BKa8pdfZwD/Gl2uAhFZDjCUprvh0abMfxi466A82xQ
	jnJOtHFC2RiOnTEhrTQ+xIfkmI3syviDxC4GDgILXteGIWVF8bzL5+qq119zIAAZmfvgkSfmQdP
	tnxyYnFPpL/KN8VYRQhzXC2NbbZp6NZVxxNk62FZ2iLRFFQ67KpSGBGXoZQpqTx+A7Xh2FC7Rcn
	pajawn9XpjPTSMASP0e/+9GAhkQQiPg4lLSUaxdUB1BHPoFIi9JIAd6P0Q+ULLVIn409mWLQVd5
	hqrDB4m1eWNOMCumyeKE+qaF1IGflTjYmtph975b9RxAzygrQjebVZkO1VE1FGODzT6+bY5ffEV
	WQz/6X4D97ydIXPmb6jjlRdH+ze
X-Received: by 2002:a05:600c:8108:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-483c9c0baf4mr84932375e9.28.1772270471143;
        Sat, 28 Feb 2026 01:21:11 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa007f1b644d71d78354.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:7f1b:644d:71d7:8354])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm297145235e9.9.2026.02.28.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:21:10 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][yocto-autobuilder-helper][PATCH] config.json: Use buildtools tarball for rocky8
Date: Sat, 28 Feb 2026 10:21:00 +0100
Message-ID: <20260228092100.175603-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Feb 2026 09:21:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3310

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f7309f16f9b640f221237dc086943cad057d2211)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index faedfe7..a03b674 100644
--- a/config.json
+++ b/config.json
@@ -1930,6 +1930,7 @@
     "buildtools" : {
         "ubuntu1804-arm-*" : "${BUILDTOOLS_ARM_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
+        "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",

