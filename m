Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592EC77B7C
	for <webhook@archiver.kernel.org>; Sun, 22 Jun 2025 22:13:54 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.1510.1750613861475949330
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 22 Jun 2025 10:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gtI/Ehpk;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: hiagofranco@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2548553b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Jun 2025 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750613860; x=1751218660; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RI0svL2R1ueT2CEieWV6OkZQ7gVBWC5iKCW4QJLDKcE=;
        b=gtI/EhpkPktJFclh/MwiFowKcUowDhzfR4mWCK0LHOMBt6oO8/IW0A2R+pdPZ4UgSq
         +drfA8i7ZSDLM5G5K4WIjZzVnQwJqGLjRfsapJpqzbSo/u90+UGAbT0wE1dur2RYjVvJ
         GKVJuVUF48IaQrLvD1so+LO8EMZO8QOaI9Ne1IsE40xUdrGDEuH1QGqhmu+4VlFu+jx5
         U0Ei75eeo3/OCHdhUcuu5Xa6Z0413tmXE0C5AP54C9MWuH7ImRu4t0uMy/blQl+2lP5I
         qWT9k4XXzKhlbDH2VzvGGKpAazwW2Q4POicV6gKG4TRX3op6AnOBNF84R7OUdeR3qmXH
         jfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750613860; x=1751218660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RI0svL2R1ueT2CEieWV6OkZQ7gVBWC5iKCW4QJLDKcE=;
        b=HOW4lBf8HG6jkOVfds6dfsXM3UGmy6cp67GqLAZZ+iATmxgH190KUWyMEIpqgxwbkE
         SXMGinVbDUueIof+H7OYEP0tBFBcNQSw52a7He6DNYEbFPmUGBdretUakbJONebOvsRg
         Ad05FWKbjdUWdu4v/F6p9ZSd26kxEQQkP/RL38co+ptS8L4bgQ2bsSRzpwn3W8Vnzcm2
         Ul/46YvzGgx1kS7u0eaXUuQBerUStiqbw5qVdfZLwrhUZO52ifHC4eeO7uaO8ZoloD0U
         fkwSuhmAN1+rcLee+Zm74uq6mhe6f4HDYxMKKVa6yfjH7nHEAdY6219HM6n1F/WsQXv7
         CIZA==
X-Gm-Message-State: AOJu0YzoeQSQiQDrQ3VEEp08ZBUsul1IOR1mz0FMf8jX+hootuU1FGFt
	IrnEJpLkZ7KcPc9Kcah0BkAdGD7mPUA0q45dBG3ABoFdQadUb+GOHQCCY/PdKg==
X-Gm-Gg: ASbGnctL22bVi8yqdWv0HOEyI6+dZm9g5lxonZytyoF7KV13l1DFiczfJpcN+Zwa9XD
	+7w8DH3OIiJTmu7+u3XsnKUNeEbeBkXuSR5okQA5ojbb5pRHKHfc6960+1Xt3NRhmOx1byK7t8d
	imzly0mUcO7WYBzX142dmymBmVn3T0Ehs8zrv9jcAeRs1ArxWxFSTgeJ5oGUOU4zqJl+J4WqH+A
	/hCBeSZyrxxN1se8VmaOu4LDCHtLkcjtSODqVluDTSpKD4eI44aLb8uBk/ZyimqKWCg2/jGDK0c
	DfENLUb/toz9QiAjOh/D0NFlgIy870YlcHYgwgeeDiRMhgirpe9k9pK9NCh1C+I9eJ6Pwi/3qZl
	D3A==
X-Google-Smtp-Source: AGHT+IFYBC7Nb+0bcyr4SHXUuKitjmwOgqsL/powotwO9D8vjxgYj5xB43CaVZnM0+aQlqGIp64NUg==
X-Received: by 2002:a17:902:e54e:b0:215:6c5f:d142 with SMTP id d9443c01a7336-237db0d5a62mr124320675ad.20.1750613860506;
        Sun, 22 Jun 2025 10:37:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:9542:348b:4dc5:d486:ed09:1ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860fb63sm63696205ad.130.2025.06.22.10.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 10:37:39 -0700 (PDT)
From: "Hiago De Franco" <hiagofranco@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hiago De Franco <hiago.franco@toradex.com>
Subject: [meta-security][PATCH] layer.conf: Update to whinlatter release series
Date: Sun, 22 Jun 2025 14:37:29 -0300
Message-Id: <20250622173729.13803-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 22 Jun 2025 22:13:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1675

From: Hiago De Franco <hiago.franco@toradex.com>

Update to the new Yocto release series.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 meta-tpm/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 5f96114f29a5..0a461e238757 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "styhead walnascar"
+LAYERSERIES_COMPAT_tpm-layer = "walnascar whinlatter"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.39.5


