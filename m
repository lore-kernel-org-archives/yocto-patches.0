Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CCC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 17:02:15 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.13882.1718298126481769251
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 10:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MaKdhGla;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b06e63d288so6740506d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718298124; x=1718902924; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvlx2D3DQm8ZV/OB6MTcbYSdp+lt0RYf7jLGVmiWFsM=;
        b=MaKdhGlapDEDp7KF5S3kbON6d9/nZ7maBVMAP6dhu5Uc0OdlpZNJF7HK9E1mBCmxLH
         /kpl83GYG86dZK1dXlZZ3pBo4OpwtJPkoqf6US01mMwvc3eLxXg1nl/3SOgiSxaGbiy3
         QLXBNglCwpnHW369F3f6r1t4BwvcqlOUEH7z6KxIyVnhBr3CcEm9A73TjGWWIuC5vCqJ
         HpI0s+aAdA/oxs7sM4cyJqE81TkAv03FYJyxaJWNg/t9Vj1MhN7ty0Swa0F5sw82kX2M
         yRwdeGY3Mq5GroZFg4fVXDHv69qLSf1xtFnx0sdGbam220eUKIlIeFLOOCL/SR3i732k
         KkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298124; x=1718902924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvlx2D3DQm8ZV/OB6MTcbYSdp+lt0RYf7jLGVmiWFsM=;
        b=cdxzJ1iNNnoTih3WxiEQGDxhVXhCD5nHF+L39hvRgIDy8mDHY4lJKpV8RepdNRFXpZ
         F1MP3NXCc727j8+hUuBS511wnGqkQEIJ3Cir4L2o8UxtGInqHZknjj06j8XbLe+tobQI
         s1QhWa3dnLBeP0yJCKGzFUvr/8xT8rFY+P8ESxIPgqh/1mLRtCn/1ltDp6h7cT7p7CiA
         4eFn5N9+LqsleXWlqegPom22PJIM1y87IemQD1fe0fb8QRLlEfbqfv68elAZAOnaiw7m
         y+CHpRpLafNlH//BbLF5qKxS8s8p9QnKaWYtdDC+qNF8ogsjCP/RR8ArAiGrnzdb0588
         axkw==
X-Gm-Message-State: AOJu0Yypjbh0SPz5N9/fqjXB+HljcnpbSIkJmg/jqG7rlBzI632Sq4On
	qK7uL7SFsbf4ynjy+MMUsH661uzAuXOwvwfWIc0DvtF/xDf/A+Nhhh1hwA==
X-Google-Smtp-Source: AGHT+IE2lvK8YAdzMeWNYSHN/ofjOeRB/LzLmgs5wo4eNYKOqqqvj/P9uxBAVKD/o9tsiFPCJ1aa4g==
X-Received: by 2002:a05:6214:4a41:b0:6b2:a364:b85b with SMTP id 6a1803df08f44-6b2afc8082fmr1592866d6.17.1718298124230;
        Thu, 13 Jun 2024 10:02:04 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c18209sm8588676d6.42.2024.06.13.10.02.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:02:02 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v3 4/4] README: sort MACHINE names
Date: Thu, 13 Jun 2024 13:01:54 -0400
Message-ID: <20240613170154.6441-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240613170154.6441-1-twoerner@gmail.com>
References: <20240613170154.6441-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 17:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/327

Previously the MACHINEs were listed in the order in which they were added to
the layer. Going forward, separate the list into 32 vs 64 bit, sort each of
those groups, while distinguishing between which boards support wic and which
don't.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v3 changes:
- new
---
 README | 59 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/README b/README
index 909840de2c0d..6003e7c652fe 100644
--- a/README
+++ b/README
@@ -18,34 +18,39 @@ Dependencies:
 Status of supported boards:
 --------------------------
 	builds and boots wic image:
-		nanopi-m4
-		nanopi-m4-2gb
-		rock-pi-e
-		rock-pi-4a
-		rock-pi-4b
-		rock-pi-4c
-		rock64
-		tinker-board
-		tinker-board-s
-		vyasa-rk3288
-		firefly-rk3288
-		nanopi-r4s
-		rock-5b
-		nanopi-r2s
-		nanopi-m4b
-		rock-pi-s
-		rock-5a
-		roc-rk3328-cc
-		roc-rk3308-cc
-		orangepi-5-plus
-		rock-3a
-		rock-4c-plus
-		radxa-zero-3e
-		radxa-zero-3w
+		32-bit:
+			firefly-rk3288
+			tinker-board
+			tinker-board-s
+			vyasa-rk3288
+
+		64-bit:
+			nanopi-m4
+			nanopi-m4-2gb
+			nanopi-m4b
+			nanopi-r2s
+			nanopi-r4s
+			orangepi-5-plus
+			radxa-zero-3e
+			radxa-zero-3w
+			roc-rk3308-cc
+			roc-rk3328-cc
+			rock-3a
+			rock-4c-plus
+			rock-5a
+			rock-5b
+			rock-pi-4a
+			rock-pi-4b
+			rock-pi-4c
+			rock-pi-e
+			rock-pi-s
+			rock64
+
 	builds:
-		marsboard-rk3066
-		radxarock
-		rock2-square
+		32-bit:
+			marsboard-rk3066
+			radxarock
+			rock2-square
 
 Notes:
 -----
-- 
2.44.0.478.g7774cfed6261


