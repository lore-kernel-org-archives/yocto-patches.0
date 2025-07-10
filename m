Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE1C83F18
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 08:47:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.4058.1752137261163066432
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Jul 2025 01:47:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=eaUijOcq;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so7191485e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Jul 2025 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1752137259; x=1752742059; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=daqbylImasOwQ49uC5UnSvZzx/EER6oTu9BRsAb5Kgs=;
        b=eaUijOcqxDjjVKelawtolsN4TACjqpwwPe61FUyt04+H8wEtW6+3JP0kKphJTpbV5l
         6asKFr1aLCG8c5uezlGnLV/WyCk2q80vG1Ne/9YxI8Uqss5Oo5d5eZjcZCF1gpACezSi
         RYFrP0tU0c/rf80XeVa+7psFU/fA+loNVy4oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137259; x=1752742059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daqbylImasOwQ49uC5UnSvZzx/EER6oTu9BRsAb5Kgs=;
        b=YJEoSApp8wtkOe4RoJ7F6FmnnMtZ03SgGPF6ZDSm268zR3ZWEZXACMwL8va9HGQKV3
         sBM+FqM74vtqBVRmP4iCdNIjJKrayL7Tf1Ry6zNGR1TacW7yNTYpXKAnyXGhTlnrFFhB
         nxNYXJl3wp/FO4TNAocsy/30eHZD/SRCZic3JAiwKthcvIb8zFtDyi2sRLuSn9Fu205n
         ss4bm9p9e66oAKI4QY5ObaF29mPjipfFsFZQQfm+hNT0SCrRP4gis6y0FFhiFcvhXBar
         lJoyUWyY5m1dJ4yJKdYy2WAfNmBFfOyJhVAKy1xhLg/QtTHTheTc4HkOKVg2NKnD5M0n
         jvOA==
X-Gm-Message-State: AOJu0YwYIUX7SX5nzHoZk4h2PYwoIJsyuhKc+t8VoEGMgkAo/8VXaBWD
	E6xmbV7L9MmsdxbiQx3aHnVCfjJ+Mo3J2FA2D7+1OK5+ObP6RiDeKl/h1XxIdEi7OjkmvDBbpcv
	RrW2H
X-Gm-Gg: ASbGnctwAvlUw5vbQpeQcve/JKDi8RvtUNQVFHeyQ4S5cLuS/MuwISyi7yqEUc5uJ+F
	1wVt8vTHOJo5C9/70O95alrJYdkz0ApliezRuWcrWpiQhhQB8IaVIpwDXs0IK+3lY6JXQ6XIzND
	1ZO/1s4KDmPm+iCdiYLb1VsXdQbUkJYXKvuuUEwTFMsHW4DOlKT47OtgZcuT1m6h1Wci9oOB9IH
	Qpe31+DY8NF9xt3rQklYHNZscqtdB1IzcySm1vsjNOLQoz4VG188vZtGblL/0ALaQZ6NlIRjfKE
	BQBLeZcanaXj4KtJM34Mh1485IY7hVeg+pxPdQhdptwu7rDeicg35S8BfX7IBGiXGsvHZfhKaAy
	v8OH+HEQ8s2fnehunD4kNFpsi4N5KEIMCebirNCY/XWUzY3aGItrr5DvBtxPBPHIeTlzODuTFBq
	s=
X-Google-Smtp-Source: AGHT+IGIN5sSVqdh9z2qn2FFa57Z1mg5WZdM9JkMTe0juupnDDfSZfEBdywdgMVemqw4qMsgdsVSTw==
X-Received: by 2002:a5d:5d8a:0:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3b5e8669a45mr1638766f8f.9.1752137259040;
        Thu, 10 Jul 2025 01:47:39 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d68fc1basm43916695e9.10.2025.07.10.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:47:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] reproducible-meta-oe: start 2 hours earlier
Date: Thu, 10 Jul 2025 10:46:56 +0200
Message-Id: <20250710084656.2395280-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Jul 2025 08:47:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1798

From: Yoann Congal <yoann.congal@smile.fr>

The weekly reproducible-meta-oe was setup to run at night but now
extends into the day. Push it back a couple of hours to avoid loading
the cluster during the day (even if that is a lesser problem on
weekends).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 875f44a..11e42a5 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -572,9 +572,9 @@ schedulers.append(sched.Nightly(name='nightly-check-layer', branch='master', pro
 schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror', branch='master', properties=parent_default_props('meta-oe-mirror'),
                   builderNames=['meta-oe-mirror'], hour=0, minute=0))
 
-# Run reproducible-meta-oe for master once a week on weekends (2am on Saturday)
+# Run reproducible-meta-oe for master once a week on weekends (midnight on Friday-Saturday night)
 schedulers.append(sched.Nightly(name='nightly-reproducible-meta-oe', branch='master', properties=parent_default_props('reproducible-meta-oe'),
-                  builderNames=['reproducible-meta-oe'], hour=2, minute=0, dayOfWeek=5))
+                  builderNames=['reproducible-meta-oe'], hour=0, minute=0, dayOfWeek=5))
 
 # Run metrics at 3-7am each day
 schedulers.append(sched.Nightly(name='nightly-metrics-dunfell', branch='dunfell', properties=parent_default_props('metrics', 'dunfell'), builderNames=['metrics'], hour=6, minute=0, codebases = {'' : {'branch' : 'dunfell'}}))

