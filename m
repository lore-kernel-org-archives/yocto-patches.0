Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF20CECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:04 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web11.55131.1725893756390347195
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VpCPNonb;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582a0b438aso12620291cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893754; x=1726498554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+DjYoSV3Jzgg3NRfHtFwkTEdPOGJ43OnZs29EdBhww=;
        b=VpCPNonby3gwpicQb6xCRcHLaZ6muVljYak33iAD3L4TS9FhDQT8iWTvWT2TTmvhiz
         KPBVjCuIWQTdTWoDukR+iv2SuhjvMvGO/MB/q1dQPhb5Z2Hy2xjlIbsPKsZ+Ipr/7YIQ
         HFP8a6aj9EdjuRCPQM3Q/HoGLkkP3qQ/G6lS9kXHb3riah/AhScAPshvHiFijAGLz2fQ
         hOj+aA1/tqHFmytdBx8YPM8k60BP8gdEXDoPGUmkhQyrZnoy7RlIR9WjPyFbbb0d5xVs
         xAvd4oNyFg35qJRKf6QBGXpk00ledztBy/fRwPekOSeTvs16qhPhzp0RcJCuMLNwvx8a
         cc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893754; x=1726498554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+DjYoSV3Jzgg3NRfHtFwkTEdPOGJ43OnZs29EdBhww=;
        b=XLYtqY1WenIsIx0BInONJ1W2lF9SBCJ0m9Cfrdr2K/d0WL1VL/tBxBtJjygPYSogav
         t88qKKj64G43ZFcT0NTDV4fNWXgjaFo5hmTuD2vaXgvg6iSXjGfmprReQnvC2eizgROR
         zptBtiQsAxrfov7YkLLsds9V9N1QmWCoaG7h3gsYA0qypq+C9V0eCXGKnocPZ79vSHLS
         DukcI+E//DcywV0k5o8xzgbhU0iLoFBSgnQPseHrJX0VfQBs1v6N8Y1AcxG0srWLcR8P
         iR+zyLdXblx6g5AIciWDk2Wy1nDSh+8hNI3JdU/pp7iWtN2nHZhtLN6mhiQPXdN1JHyF
         Bi7g==
X-Gm-Message-State: AOJu0YwS3PAF7SI0xmcgaiOgh8YrJFRO1X7j+m1rqugk69X+aAQZ0wQ2
	3OuW6c8e5lhQSVGTWDq2uFtkdVUEgvjgDq0i92w83wXLC5P5O8NTbv7D1gCt
X-Google-Smtp-Source: AGHT+IG01g8JwrTv/6+rW9lsJ0Qorg6ceqd/H51IXYH1d6aY4ume5TTygPmKqTUX8Cl23I8x7zG6Uw==
X-Received: by 2002:a05:622a:1804:b0:446:34cd:9e21 with SMTP id d75a77b69052e-4580c69761fmr210866571cf.18.1725893754334;
        Mon, 09 Sep 2024 07:55:54 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:52 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 06/10] README: sort MACHINE names
Date: Mon,  9 Sep 2024 10:55:26 -0400
Message-ID: <20240909145530.25301-7-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:56:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/632

Previously the MACHINEs were listed in the order in which they were added to
the layer. Going forward, separate the list into 32 vs 64 bit, sort each of
those groups, while distinguishing between which boards support wic and which
don't.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
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


