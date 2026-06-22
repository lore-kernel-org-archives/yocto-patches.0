Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA950CD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:43:47 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44915.1782139426733627053
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 07:43:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=O8mvArIv;
 spf=pass (domain: gmail.com, ip: 209.85.161.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a0edfe29ecso1470528eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782139426; x=1782744226; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIjU5Z1GxRK4YfOiM6xGgzA9/E+pAgkHDPHytvyS7EQ=;
        b=O8mvArIvy78tExztf9rErLptnBqnzKAIyKBRdYUKiyziy6hnmZ6a77/nPaALkVZBs9
         TNMDVNbeX6QZH77lmMNY/+7aOf4XJ3n5B+E6a7o0C6PITvbfg6WkJJrW6HVunLhWIGXP
         WmEUe9Km7ZyjGgXZYvWRdsJ6Y/EnEgZmAYld4DhfZkafKjHxp1clmsaAQgcnldNxX0/r
         fDskmRHJocsHw5S0LcJ9ibog7P3poBEF4hag7RcyMaE3HdN+eJkZOIvx/n2fy5YACb7Y
         ldL5ivScCzEBzrhKz4Yt2KAG6djcXnCBTmRxaPANnFi1gOZ+0ZTcS5HwANj+DZjvHByK
         mkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139426; x=1782744226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIjU5Z1GxRK4YfOiM6xGgzA9/E+pAgkHDPHytvyS7EQ=;
        b=RaGxMiqsohODnrDd1gkbcFZwCS9hIJ4hhXOcOgjgWlVCiKoWyHT3TU24i6yPmTYWy5
         uYHM5n4E5sTjLTCnl1bO0rDwvVPJXtHUPLC4MbvN/QAhI2aNXlhw3J51CzJ6kcWxnILp
         Sh5/JZ2ClKKgfS8I+Rkblr/IgjhzGEbRXZpHEWPG9jyg36VnCEmfoRZK2U9TQcGcXZ/a
         LNI2JqMrk++iWf0DpIdv+2hrvHVF3bsu6Fu+FmtZlygvMUS8kaYA9chIOBQbxxEVift2
         jnvpPbXrWP3KL7zcr+E7gg/1NlcPTEMUE35un/JU3cmIfQ1YiHveIp7xGyHhZgWz58ku
         kJqg==
X-Gm-Message-State: AOJu0Yw7KoiyuFGiB/ySk9QmVA8erWMn4LKy6SNNPhnQHOkTpUUqTJiW
	HC3OfmOliGs6RwbXCEYhrcv839OL+TwTvef1oLfIWwL+qSpT8TqQmpRdAFMTjQ==
X-Gm-Gg: AfdE7cmiD+WJYaXYxe4PibeW27C0s/FAHSrhP3l6+fwJHNtT8cqJ0loF4gUkyc0SXUS
	KEcsdFjytpQ95DpmjBtZidjerq/8yLZK/LCqFqhGsDqe2j/RWl/mWebSI6rJcVdzSq0NH+Vx2O1
	ViMo5J/6Qf5Dqsx+d8V9/6uHQaqEEzTIEf0xMqpyIzELgAa92gHrcYbw4Tra15HEIGmGBb1Mnao
	XyKTbDKhnASmgKJHCc7m4zsEZkpK7AAl9z+o97qHkobftzpr4hyIBy0plWXueDabRO/yTTrFB5y
	di0hJTgGfRSZ3XU/5ER6NjUMCflaXwvEKZYaV5H8ErSv5JZWpjx+yW5RHHWfM/e5ZJPnLutWZf7
	OjNuvN2GNd4OCAe9/Bz6MgcVBETMYrusd0kjq05LX1cmdxhD3RcMgHP1q1AgXyljadCCBir+BUn
	ZiYbA/7qZ1Og==
X-Received: by 2002:a05:6820:4c81:b0:69d:6bbf:3fe5 with SMTP id 006d021491bc7-6a0d8d5105dmr11502605eaf.51.1782139425909;
        Mon, 22 Jun 2026 07:43:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::fe98])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f29e37sm4998540eaf.3.2026.06.22.07.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:43:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] libpcre: Move to meta-oe dynamic layer
Date: Mon, 22 Jun 2026 08:43:39 -0600
Message-ID: <20260622144339.200796-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 14:43:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4257

libpcre was moved from OE-core to meta-oe, so move the recipe to be
under the dynamic meta-oe directory

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../recipes-support}/libpcre/libpcre_%.bbappend                   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {recipes-support => dynamic-layers/openembedded-layer/recipes-support}/libpcre/libpcre_%.bbappend (100%)

diff --git a/recipes-support/libpcre/libpcre_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/libpcre/libpcre_%.bbappend
similarity index 100%
rename from recipes-support/libpcre/libpcre_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-support/libpcre/libpcre_%.bbappend
-- 
2.54.0


