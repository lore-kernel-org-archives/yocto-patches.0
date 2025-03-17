Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F635C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 20:09:55 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.953.1742242193078863216
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 13:09:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=u9XXfGe7;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-394780e98easo3140789f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1742242191; x=1742846991; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2Yczro+K4ECS3sp2KQT3nsfq/HqpbYFmZbfozoTNo=;
        b=u9XXfGe7lxyfMmYNPy2QNk5NnsiNQlgsRY7/EHOU8FWkjkv5a/Pg2ZBe2KIpsb/7ER
         I+kmCUSxn6gOPGK1rKN2iTAKXEGGeZL9lIaW5rtq3pYo+qMCmFJTQPCsdLTCcEgWA/hh
         vDjXFpRHZwijxb/6VZATQzZu65EeAQHwYFjYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742242191; x=1742846991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI2Yczro+K4ECS3sp2KQT3nsfq/HqpbYFmZbfozoTNo=;
        b=BNj0E+n97NIqu0C7/PgA4g6yklio6OVZfTzEmbSWn0Bx/vuZbnzwFNQCRbwMwY9o3v
         u+cpavPFy5Wx8tKY4lZiTutCHKTwS2elf2pG11Avc4ZWD0xvzlrOvm6/pI99AGK3IHv1
         eklMLpBCTu95D9ttxyIu9nMQUh8h5c5SlpkWRN+xtZvP77XeIb8ERhccp0Na1yKLenYp
         DlM0adpGjzP9pi674le3zGYlQHbTrjZlhoCtqhzkR7Vy3NPLBCkK7yylVpw2SEmEj4YO
         PuMtv9qNUcNid2lJ7Zx3nTyVwkbpeHb1ZwLgJlUzMqzyrue8urPFr8rIlW4z/8cxxRbU
         Jevg==
X-Gm-Message-State: AOJu0YyEVNvk/npL56MF/zW3+HfmcG2xMSTwyDRZ6OM8J07DyNFJTcH7
	fpmhMwykvAljtF1kYy3fQ+gio5CV5SJznc/RXKYE52LMxWWdFnLVU5ZrmtZsE9cyJM4wGFfAOMi
	P
X-Gm-Gg: ASbGncv7EYxIDhOd6Vi8xQ7v0sUHGSfyH7p1tfDidmRA0n36C3qaeo6V1YgGgRMILZL
	wCsZmGPezQrj39gHd5s+Olm3xKXoJPW5YfmF6xZkz47TxyXHn3G8DiJuq6eo0+QYbQWCqR238dQ
	FT/CMlofwogriAq+8PBkwy31ZoEL5VNJH/8qJGGK6GuQ9Lp03IHjtA1Xh1eUWF36nsSL8Vd8MSz
	DLvLN7r4N6Mm1eeVLd/d+FBbmEbhRvwc2UNCagLSQ/mq92/12/RYbcLToAmKoJAzntr5dg+bi4Q
	oAlLPKojbYtJo4t/YDggAa8NxWzWWnFO7edR0yjgszawKcOtW5b/CRM0mKaTSDQtAilIenAI1FT
	TMRC5ltMH9/uetQJt/rBlui9yjyw09aeiVSSMzHHqVyrB9lGqnAM=
X-Google-Smtp-Source: AGHT+IEN5RG16KtS35izgNOBsEx85hIjNnjor38w+uqwTjSAXYK8MuQ7u2AVLjpFvXEfm6Iqom9SVA==
X-Received: by 2002:a05:6000:1ac5:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-3996b4998a4mr944598f8f.42.1742242191207;
        Mon, 17 Mar 2025 13:09:51 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef0002cff7470e58ff5dc.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:2cff:7470:e58f:f5dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm16344301f8f.91.2025.03.17.13.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:09:50 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Khem Raj <raj.khem@gmail.com>
Subject: [yocto-autobuilder2][PATCH] config: Ban Ubuntu 20.04 from running "reproducible-meta-oe"
Date: Mon, 17 Mar 2025 21:09:26 +0100
Message-Id: <20250317200926.3247948-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1209

From: Yoann Congal <yoann.congal@smile.fr>

Ubuntu 20.04 lacks a g++ recent enough to build nodejs. Nodejs builds a
native C++ program using std=g++20 which is not supported in Ubuntu
20.04 g++ (9.4).

For example, see these AB runs:
 * https://autobuilder.yoctoproject.org/valkyrie/#/builders/87/builds/33/steps/32/logs/stdio
 * https://autobuilder.yoctoproject.org/valkyrie/#/builders/87/builds/36/steps/32/logs/stdio
Note, these logs show the nodejs failure but not the reason (I
reproduced locally to get it).

Link: https://lists.openembedded.org/g/openembedded-devel/topic/111740469
Cc: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.py b/config.py
index 74c7c0a..8fb34d1 100644
--- a/config.py
+++ b/config.py
@@ -236,6 +236,8 @@ builder_to_workers = {
      # Have gitstats and gnuplot
     "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"],
     "toaster": workers_toaster,
+    # Ban Ubuntu 20.04 from trying "reproducible-meta-oe" (lacks a g++ recent enough (std=g++20) to build nodejs)
+    "reproducible-meta-oe": [worker for worker in workers if not worker.startswith("ubuntu2004-")],
     "default": workers
 }
 

