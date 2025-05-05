Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991EC3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:22:55 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.46123.1746436972329982762
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mVJOv80H;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5859102b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436971; x=1747041771; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNzhkZxgprF8meM67E04MxVitR+DqzMECL2R0fXMy9E=;
        b=mVJOv80HLbLDjhxoTEPiWYVfHLXIRGhcO+A3XfSrV6w8Wvh+7lBdeCjmimrjwdrlYo
         GXA8knRoLZC/C0MMubiCBdEjiFJsIYxpFgvrRcP+yv9nSxzEvJ5CxX1fO+ajt2xxT1Mj
         pT9wI9TJL/nJ0r2FbgTDTdz8wX76uG/qnvoAgdjnAHJzDZZFUhgneuOQBde14qAuPq8Q
         xv4N1uUsYvXIBCH4zWq+fmKPuKacutgohrKHJloILTLnAW2ksVKCyPcy3PrFBDquCBZM
         L/vww4D+3CapFgyXavhH4h7PRg3fRNrPPV8DbXNj/qrX2qjiwFyDleOWLUz+AKnSM8QH
         dvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436971; x=1747041771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNzhkZxgprF8meM67E04MxVitR+DqzMECL2R0fXMy9E=;
        b=pDGRvYz1cWpHtnmdeAqRGIoMpAxRXI3JTXMym3C5joJP8zvYwsM9Z2Gw5SYpFWP6Z0
         C5SemK/3n1CJuKlCoCVkrGD22REtYGQSQhmbIt5BUr3AeJDBbt1XTJRKob/KRWQuTjLG
         Qq5HC7EQr4nT+UWJmhD71JEIb76K/kAdAF460D2h9AXdiMjzKzZN2iwGan7Cm14ZcP/o
         yaFwNk22rPwV5IqpwLbG447GHYKVP706WstSp1mdxqfcPG5cb6GYppWWiIbhmKZSmqpO
         RWYK5tzSGS6qCeONgGsvlJFqfYOE2CYrm1IsGAReZwj7eXY8+o9C9IA5D3HCS/488dCN
         w1Bg==
X-Gm-Message-State: AOJu0Yz54Y26NJg61+dNbBKaRMJkxC+4NcbMgZFA7tsbkfnoAdI3dYcF
	lzisX8ge/3AIEulrgnMRZMpBb3qKQ72cIVBaw3mcu3jBBwxsqjYjFldTtg==
X-Gm-Gg: ASbGncsKzoABVp/ub1u3jn6v0C9VgpeH/8XK04qZgSNHIZJ3mQWkzatQI79XBW+mjVR
	flr1RWEYwyTXPW2xkyceDjqf/pom77jg3FfuybELLctOvCfG+UFYYLTjS83P+0V6reKplEsOGoS
	OodEIZazooFU9qTBtSjR0LdjLgEwA6aB1d6YLCHxmC+fTWqwN92PGVW6HVbZ2imbcc2YB6HMuM0
	7iXdSNrsEfW20oT84aKkx/FkWwc57IOW8YelBqWbgcIldCiFOt1+JpueOvWF+4T/pX90NWwQlX5
	Sx6CciiQNBWOWfPPEc2t+YXJvRmo83H/ueq8uCFjVpY5mKfmHGbB
X-Google-Smtp-Source: AGHT+IHp4mFJiGqvV7wclfp1cbfnCaDiadIAzjL3HhK1gmrAnmKipd+bvq1gRXR8HWWMuJxdv2oItA==
X-Received: by 2002:a05:6a00:35cf:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-7406f0a0a11mr8656264b3a.9.1746436971442;
        Mon, 05 May 2025 02:22:51 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm6487611b3a.98.2025.05.05.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:22:51 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH 3/4] Updates the SRC_URI for avalon-framework-api recipe
Date: Mon,  5 May 2025 14:52:37 +0530
Message-ID: <20250505092238.853811-4-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
References: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1495

Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
---
 recipes-core/jakarta-libs/avalon-framework-api_4.3.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
index 081cfe7..e7b4d55 100644
--- a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
+++ b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
@@ -5,7 +5,7 @@ LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=1dece7821bf3fd70fe1309eaa37d52a2"
 PR = "r1"
 
 SRC_URI = " \
-	   http://archive.apache.org/dist/excalibur/avalon-framework/source/${BP}-src.tar.gz;name=archive \
+           https://archive.apache.org/dist/excalibur/excalibur-framework/source/${BP}-src.tar.gz;name=archive \
 	   http://archive.apache.org/dist/avalon/logkit/source/logkit-1.2.2-src.tar.gz;name=logkit \
 	  "
 

