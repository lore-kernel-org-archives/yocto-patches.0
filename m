Return-Path: <arena.lor@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D69C021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 14:54:40 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.53476.1739804071257778582
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Feb 2025 06:54:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PtKt7pp9;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: arena.lor@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so1258131f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Feb 2025 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804069; x=1740408869; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6u2vOEPLi9fS1jHEknQC5oSLxEv6nBsvd9ACbHKDRE=;
        b=PtKt7pp9lyIsLehVRXV9NYDWRmF4ny489sfJlNjmHo7PLvHxHqDlhBSfB/E1KOkRlQ
         XOqaUDwnWc72pSDTPl9FMYiX5t3AFFt5e8b9dXUEwCZPVZqf59F9vuphYQifeDc39wfq
         EMNkjB9s5J74kz2KaSpdXZ7uTu3XpKjE97dUC26lB17iMlibUpu59LTT+q059s+AdL/q
         02IoZOcBlTFv6dWqEg5+3HWteWu8zwo0po+mZCQ8/i6cqVjjc+YPGMrBkCAl7jyL5qaT
         IJ7Jm3CTAioqvDfuMkJdxHmSzsgUfkrcL1NdZrU0IVSZ1C425n2NSUb5VE+pw8vAALKp
         kByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804069; x=1740408869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6u2vOEPLi9fS1jHEknQC5oSLxEv6nBsvd9ACbHKDRE=;
        b=kQkrz8w0aGEKg2vAmfgAB/gU64JlXlwL63InSyRxPKXFDkiPfFuvRM0HtX9nRgeSmq
         sslRvK1UG1IsDk8tYkYqleYrsWrxZBbYgOmBTGhABVWs38GPSIQpKJG78DH2vJSXMSIR
         /A7qXJlf2ktEZdd4mIMjapY14CCxp6OenD/JuZeB8lUTaeEI+3WeZ5qbzKS4466J3Gpi
         MQazxb4t+6K55gRkNijDXbkqWLmcwv+eWVhqXLan39BcaKMXJ5d4pXTOEvpfV5BjoV/P
         V0O3A/QoneOenRLd1b2W6Tc9mJJ6IDjIRZxMEbtrA/BxcfVwU2TduMTMj//Opc9XFHm2
         ou/A==
X-Gm-Message-State: AOJu0Yz8kfetlyxdAmwOEYJacaERDWSJdNiMSSHB6lAJhEhKAX8pl1Xb
	kHwUEDaMlOeyghkEP63V7KXCdyq8w3ApB6wty4OUm0YJSXpA8Tnb8/PAZQ==
X-Gm-Gg: ASbGncv4AgAhmR21iXsv6XtpEsskouDETHWh24qRvfHnKz63j5gDSOScC1Gu5L2Zq0e
	zSfqRGzbw1WZn0L84gm/DwwieDcrOnuM6YVtLmO1f+NokXNz8ewHHxkdF7LKPijt66rmGOLVpTj
	dQfLomGMPKkQDZYeztozxLl/GachaTR6IpXN8SMkdJk+RZsktt7lXzXCOgarBdpSZNEvvheS4KG
	lgHVGvsW12HtWejcjp2FpphuzBdYfoV8pa68KTgBj7BlZROoUqjji6y2x7GLZQRTjlTIFRRLL4Q
	E9E5V5vbGjveSYwm0axlSO1ISFxLiNBtb+fiOjenO9YZtTnV4uVbofKk80luvu89gCO4yrt3G3I
	T/qrv+gyH27E=
X-Google-Smtp-Source: AGHT+IH8fQvgpOkMf9sMo+6rsDb+kGhJMaGWOBRxZHUaVxWZuoEPN2ZdtT7aPNrh13Gx/OLRGlpiQw==
X-Received: by 2002:a5d:4b08:0:b0:38f:28df:13a8 with SMTP id ffacd0b85a97d-38f33f28ca6mr6099469f8f.17.1739804069488;
        Mon, 17 Feb 2025 06:54:29 -0800 (PST)
Received: from larena-Precision-3680.powersoft.it (host-5-99-65-66.business.telecomitalia.it. [5.99.65.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8115sm12637140f8f.92.2025.02.17.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:54:29 -0800 (PST)
From: Lorenzo Arena <arena.lor@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Lorenzo Arena <arena.lor@gmail.com>
Subject: [meta-security][PATCH] dm-verity-img.bbclass: set sparse as "never" during initial file copy
Date: Mon, 17 Feb 2025 15:54:20 +0100
Message-ID: <20250217145420.270694-1-arena.lor@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Feb 2025 14:54:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1089

This is needed when a verity image is used in conjunction with tools
like a WIC and a bmap file, as avoiding writing "sparse" sectors
can result in errors in the signature verification.

Signed-off-by: Lorenzo Arena <arena.lor@gmail.com>
---
 classes/dm-verity-img.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 296020a..47f698c 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -146,7 +146,7 @@ verity_setup() {
         HASH_OFFSET="--hash-offset="$SIZE
     fi
 
-    cp -a $INPUT $OUTPUT
+    cp -a --sparse=never $INPUT $OUTPUT
 
     SETUP_ARGS=" \
         ${DM_VERITY_SETUP_ARGS} \
-- 
2.43.0


