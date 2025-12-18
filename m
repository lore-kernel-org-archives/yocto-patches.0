Return-Path: <albertoj.rodriguez.gallego@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A2D6E2AA
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:43:06 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45149.1766072576185161518
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 07:42:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: albertoj.rodriguez.gallego@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae77516so8576565e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 07:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072574; x=1766677374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHPytgMelmwKeUJideD6dOj/qS9GzGfd+/VZxPTYBV0=;
        b=qvYiiSkJuy+9OU6qjcZ1iNIFF6YVcjwxmIPdoCB9SmN0WUzMM2++a+4MtjMLoRfYeW
         vkEmKcjyQ0k68rvLL0D4I3aPBOP55Ol+aUaIIpIHPmbsx0Sh+VunMP/adUBx8FwVh7fA
         A7FtVDZIWoW4UEvwWmgb/9R6U5K4A/toz7MYtB08gKLtUFbK2qJxMalNCa64FRLgQsUR
         6Tpmw6kQis0lF0bGQQW8cCa4ON+0rqNCCZyRAP/YfiwymW4/AacNDQTXz+EaH31epucy
         +cpJuxp6cGpYKdHuQaz8ZJPX0E+sN1lZM6xzERfdZk5dgCCfQWZhR9vckgS4QKFfiOJy
         Kkdg==
X-Gm-Message-State: AOJu0YyznTglFX6OGWymnkxeYEqY/P0pkCvBijdOpx3kmEpsFpSFQjU3
	YjdIKX+SNEtOMhCePtae+TKUjeTc13iHFjdeZNlalxv4sw2XGDYu1i3Qb6YKgw==
X-Gm-Gg: AY/fxX5g9WL6XrUVc+n0grNPkQf2o11uJcdBuUmb+gI3CyH7TTmIsilpJfiWkTa10Fx
	xGScvkbtrXqNT1dnoPmhf/gIFbZHKo6v2F/Lg1Jb4PNg6BbUYWV5WrATOlgRS4I3NfrIwvy20YX
	IqOxcwcFYQAxNfWe+HWfKtYX15Ea6RB5DFUP16nCd7IQKVtege/6F3vAtOjCHz1jEMnyt8rZvzm
	SPOnx05QHPe/uhA42GZSqHR3al+tzuQRMi3YgvgwFbBUdc7RluEz+p5zZWH2FoYJhu/RavZ4uyP
	QWEMyi4KOmRJtIW3w7lQKqTE68XrWZVCNWTVSBOi6GZgEeLyKPoestcICEZaTRTgoSmGV0Yd4S4
	L9X5RNLI8oW6kyWElz+d4Bl9NLrC05hRPi+B53mX7KSdp8SJz2bBDEqg/pOWI31uo6B6sShlSvn
	wSmf97MqLaWe+OfAEHMY8=
X-Google-Smtp-Source: AGHT+IGDVUQMp3HkT8jXf6z/EOS6r5sMZrN65NAXRUJ5FvdIU6G0IaytFz91z9wM/RIz2n8Y0juS6g==
X-Received: by 2002:a05:600c:3f08:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47bdd99b2femr64718755e9.5.1766072574225;
        Thu, 18 Dec 2025 07:42:54 -0800 (PST)
Received: from localhost.localdomain ([91.116.119.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a49315sm17213365e9.2.2025.12.18.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:42:53 -0800 (PST)
From: Alberto@codeaurora.org, J@codeaurora.org,
	Rodriguez@codeaurora.org, Gallego@codeaurora.org,
	albertoj.rodriguez.gallego@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
Subject: [meta-rockchip][PATCH] README: update patch submission guidelines URLs
Date: Thu, 18 Dec 2025 16:42:26 +0100
Message-ID: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 15:43:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2816

From: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>

Signed-off-by: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index c1d5d4c..c2697d1 100644
--- a/README
+++ b/README
@@ -251,8 +251,8 @@ Maintenance:
 	When sending patches, please make sure the email subject line includes
 	"[meta-rockchip][PATCH]" and follow the community's patch submission
 	guidelines, as described in:
-		https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines
-		https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
+		https://docs.yoctoproject.org/dev/contributor-guide/recipe-style-guide.html#patch-upstream-status
+		https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html
 
 	This can be configured within the repository with the following commands:
 

