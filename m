Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C10CD6E79
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 09:44:08 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75512.1780998241565292012
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 02:44:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YDkmtc3v;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so35471245e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998240; x=1781603040; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oO+YIsSaIoawg/rVo/2A02ThcxZveamlvkppHoPwUP4=;
        b=YDkmtc3vzCQ7sZhA3jarjSltGhZgb97Z/qd4a1KVOQ6GaXjJ06MUFOJVCacdIuQ1dD
         H5csVxRKZ8LP8+jtSEBfTs+x9M5qiRtbTRmdqmcfOHMIBMm/JeFq9S86sKmdhiZqSZEH
         HdVFqiL4pOnk4HqADzM/tqJ2RUQ8iSiBdOmarP5vVvDb4gC+U5ngwept3oNgTVCk3NDt
         53kUQPH9zmdg/KmEYlPbBXWHMHUyl9EYqE32u5p7QafspBEgNyX7eNAeSISxB3Qq7t7p
         ude9+Nh25VVAEdOEYVvufhn+ShBYA41veA23ZCu4lVxg8hl80lpkLnQ+WjjsAG9I07ua
         IGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998240; x=1781603040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO+YIsSaIoawg/rVo/2A02ThcxZveamlvkppHoPwUP4=;
        b=ZwmtLEwJTprypAkCrKEftwLS2lv6sxBkyCOrD1CMfCxuONINHdOW+vCw391auCfG1L
         DKGNLt8JT67E0LH6OIp44VdiCLXYnVCuNCStG8r+1bGH1eTM3L0KUTvPNZuIng+TKV4s
         6VgIsGAmpGNqre7DBKp4pd3kcSGnqw+tFFEiD0Bl/AspuaQsPQ+PQYyXRHYrN1+D/5aF
         Rls3+QqvAvtta6iYeH6AS5ZXpqLNSGj4CU7X4xvNXeheGPDr7Ex6YxAoLoZoXQqzsIVa
         /EfsJ/8mBGsoZVGmtx/3lqHzmlbUZSSB9FNdVfvsfyncu6MoZ3qEA0EVO8bVpobakvt2
         NNOw==
X-Gm-Message-State: AOJu0YyK47zmYvrOC/Z/Xd8KlAtKZEeCDfRyo5yPfrlm4gRaxNZxuAqn
	aC3aegH3ta5cnPDcYLOKM9lB5JkWWRAjOAU1zFtWW5G5pT/HDU+qhThIpOefnsMS
X-Gm-Gg: Acq92OHw0WAaELHUqyJxTiktwE9Cn7ft9b2izoNNmwa3istlAcDWGDtrWi0k6ujqBEt
	cqel/drLNoim6nVkjv9ajToWUDSma8DDGD/NL0pTpNapb32SdGj85IYBEPCQLZxIj2WSQPEw1pd
	5g6shUvlpPuBVXO4O4RLmXlLmHgpUtk8JMeoog/s9z6uUrj2qH4VydhTWsIZj4J0afOFzD/+KJ5
	MTdmqRS/Gh/vdg6dlfyTGUBlEYIwiy3ilz2TfcK5j22ixL9pz5/QxmhKgB/1j0Xe6J7I5kubb2n
	PYnX4GTkt9Ug6tv5HEF/m61UaYFe93aTDsGfFFsxY0nZp+H6duyAmgLrI/heSDj1lWtEN0Mcg/5
	afvyB0AL6norXmL44eWz+nqhX81ul95i4y29zdlY+vXdnZuDwIYyujHvFlIyrHfQi84Ot1m2mMk
	wYvTqhtMa1ima0jd8i5Cfk2EDhVcP911eSvt4Aklba3Ozz3OXHpcP/OhH+wg8+Drz+Qy8A1Q==
X-Received: by 2002:a05:600c:4708:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-490c2602987mr302300845e9.25.1780998239791;
        Tue, 09 Jun 2026 02:43:59 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm410955665e9.4.2026.06.09.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:43:59 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH] modules/state: default to 30 days for rapid fire updates
Date: Tue,  9 Jun 2026 11:43:50 +0200
Message-ID: <20260609094350.364558-1-alex@linutronix.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 09:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4182

I feel that 7 days is too short.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 modules/state.py    | 2 +-
 upgrade-helper.conf | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules/state.py b/modules/state.py
index 0c2c7bb..d70972b 100644
--- a/modules/state.py
+++ b/modules/state.py
@@ -36,7 +36,7 @@ STATE_VERSION = 1
 
 SECONDS_PER_DAY = 86400
 DEFAULT_RETRY_SAME_VERSION_DAYS = 30
-DEFAULT_RETRY_ANY_VERSION_DAYS = 7
+DEFAULT_RETRY_ANY_VERSION_DAYS = 30
 DEFAULT_SUCCESS_MAX_AGE_DAYS = 30
 
 
diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 53c3c46..bd4dace 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -61,8 +61,8 @@
 # When running with --incremental, how many days to suppress any upgrade
 # attempt for recipes listed in retry_any_version_recipes, regardless of
 # version or result. Useful for recipes with very frequent upstream releases.
-# Default is 7 days.
-#retry_any_version_interval=7
+# Default is 30 days.
+#retry_any_version_interval=30
 
 # Space-separated list of recipes that release so frequently that they would
 # flood the mailing list. These are throttled by retry_any_version_interval
-- 
2.47.3


