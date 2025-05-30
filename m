Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C60C5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:22:29 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web11.980.1748625742677745513
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 May 2025 10:22:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aJZQrRe3;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72bc3987a05so1448326a34.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625741; x=1749230541; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJWs/AAnJYSmALxyVWRdYodAQsCgqlV+MwZdTIqtP5A=;
        b=aJZQrRe3GSVCKqwAnCSSpdFlzpA9mcHU7OnTY/oUi2Y+FlEG4SqBsrN4gdYg+qZVPh
         sLyxrnxEMoxx0TPvig/sHyXE/XSrUQLJ6hcKD5PI0Mg6olsim15L/L8AV0PvDIRB6RV9
         HN+Ut6w2D7nmlFr/ei8Jl6sslOhUV9naLszwCPWNMovSGSfM9ksoSuvQkZaHrXU8mzLo
         8e/VCsBsjFYAxIlG0/Vnd8gkEtevz88NGGVChPDxJtgvYDrqhxeR+mcrpILQyCWoyEz1
         1a1X62q0eiTL5yrcuNRE1FmcbR1ftyn1mrwV8UhXBxrYpshzBsEukk0TeisM7HM1d2El
         PkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625741; x=1749230541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJWs/AAnJYSmALxyVWRdYodAQsCgqlV+MwZdTIqtP5A=;
        b=D4TXRI181nWAxoeOJ3EysjzRowtpQPDgNiSgMZpFlAri4bZlqyAC5V9nFPBZBjkoaw
         PqVu3J8UPG5xuXmIPIyk/iah4FTMKg0W7KxBr/EM0IZRPPOeB4j3ftI2LyxVNDKJBhfL
         e+JvbLjrxvsmJd8MLzKJaTh0OyXtw/s/unZKFA0b2CY5QRhEVzwK/c2MGEA5bNzEGKMK
         78il2oTFQ5CXVlgoL2xCinX7iKn0GybPZjdnGEbYQgCKpmQTu1TrBxFzhJs8xog9rQLZ
         +p50l4QHMw1HwoLWl5kDuPvoPq7mLEQKWBKsHwU2KuH0Go3U5VRxxBF8+klwSOAhxTWD
         qBCw==
X-Gm-Message-State: AOJu0YxjGK3nPeWlD03zMT4FijLLTdtaFrmNocU8CyHfM4/kIGIz9GBs
	Ch09kwkzMJH3MtRU9yvJCCi6kLK9zGmRUVCDVVIiXnfHNtwMUOZWgBuOWA/O+g==
X-Gm-Gg: ASbGnctZukunbu9KsvC9kqEAfu0gzEnoFncJwEu6TYNhTtni8lofsdArlzh2SyNJbAa
	0jtRxng4lvAi303ObtTIhQu0TFsVX/yqzk2p5goZPJjcNNIx5nlO9t49AmtpsalqEHYnYaHZvKB
	UsiO61GWu5kNN9uiKtcKauL8AtO/0F2zHI1LHdXwLqeGhnQa4qCcF/pKheEE1kxjvoJLH3mlCat
	DHZbFXicluc3h8EUny1UCgCu2EN4lGwlt5iaWITxIKgtYkMvxkwmjIQDC3dJfdSd3Put31zNf8D
	F7LkPwTOf1IAku1EPQmlJl5d77m3rOkW2f775iCjirtvWC2+dJiSfA6IIdSbNsAQHivv4dkNa5S
	52qMCK8kHpYv0PCFsGRNtzAWz3FnGaQ==
X-Google-Smtp-Source: AGHT+IFIjkqHW5FVN+42Tuek5VQ7k3rDzXaYkawezQ5zTO9+ZSM9jQgzCW4oU1n45nE0yIB8Gao9vA==
X-Received: by 2002:a05:620a:2905:b0:7ce:fc0b:d39d with SMTP id af79cd13be357-7d098762644mr1284714885a.6.1748625729828;
        Fri, 30 May 2025 10:22:09 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a195d7dsm264984385a.78.2025.05.30.10.22.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:22:07 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 3/3] rauc-conf: adjust PACKAGE_ARCH only when using the demo
Date: Fri, 30 May 2025 13:21:56 -0400
Message-ID: <20250530172156.7199-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250530172156.7199-1-twoerner@gmail.com>
References: <20250530172156.7199-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 17:22:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1602

Make setting the PACKAGE_ARCH occur only when the user has enabled the
rk-rauc-demo feature.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
index e19db234b9b5..323b63b01f40 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
@@ -1,6 +1,6 @@
 inherit rk-rauc-demo-features-check
 
-PACKAGE_ARCH = "${MACHINE_ARCH}"
+PACKAGE_ARCH:rk-rauc-demo = "${MACHINE_ARCH}"
 
 FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
 
-- 
2.44.0.478.g7774cfed6261


