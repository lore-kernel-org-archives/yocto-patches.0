Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A84E7718C
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:12 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.152247.1734703571475722241
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:06:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Hp5Ls7By;
 spf=pass (domain: linaro.org, ip: 209.85.208.173, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003c82c95cso15255901fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703570; x=1735308370; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8rTihZkR9S82ppwgigbvVS0L1Ut/Q35dWi+fpOjMWE=;
        b=Hp5Ls7ByZqo2TwrIIeyw7WgrTJNpsJVINRfsxQzOT9HbCEHd1ND4Iz52cj2pZT2KFv
         OSQJ5iAhoIe8V4jVLiaklDUXtmyf6JPxGga+brBGFDWmRkvaXMxihJXipSwVXRU+UUek
         csBnhJt5N9LgwawHvETqJ8sLh5YY8DnNdFixMssEeu1OVA9X/tbvUu93z60xQqKgaDED
         1EaWqiu9bW2GkLWVp2gOuqg2AOOzA8Am2Cs+n9eJ3h42iOWul/IEbrgb8ykU9od0OiEI
         Btug53yY6HuE7eWIbFYs86OFwRPctc2GXm7y9haVwbLhpgQEmEMk/rFBXEWcOAmyaXSh
         eLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703570; x=1735308370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8rTihZkR9S82ppwgigbvVS0L1Ut/Q35dWi+fpOjMWE=;
        b=FZbIzBSxwjGl6+pn1CnVQxC/3qHudYo+GIyXGD6W1XDdQxbUo9lG7hvfo5xm0TQ3NI
         QNQvtUxrg60ProB36k2UI5GSzWG9BGE2a1fSlWUgE6R+8J10AX3oryi6qef2WZL/gYgi
         Tw3CcYb1KDtjgNwmJEj5uFn9fxGZa3OHCPrZpQ/vYVz/QGjHru7BpLe3dHDyNjR/szHp
         UyZ8keBsW87OEukXXiS1tTCp8gKxBY4Uo2G/HPee8Bl1APWjAyFrEbuyd5LYplW+6jjx
         SowjIIiPiXLU7o1Ro7PSAGGsWlEBEjxKs1dz4/Mc7qAlsWpoDbPXNpxwOAqGvs7Urxq0
         6i/A==
X-Gm-Message-State: AOJu0Yw2iwE96f7gwfcale2HkbMA9VWbPkfvwFpEovUw7NUImQl182fV
	6K1l2+St0p3L6aLOtmIBO4ScmEA+Up/eyOYKIy7ONCOxthQVa8cl9x+L42kBb6B06JtM/zciFmP
	aSHg=
X-Gm-Gg: ASbGncu/3ZP2g07AHflK07b10jL2NnXS+tSLQHbVxtUOpvzmPGgXDtDbGCPiSeW7UF8
	nfzcVXEKydV8VXz1s7mtJu555JV+T53Lq1ZsBTY9Eq42pZmCPHXsr+ByP29XuW6bO26OHmtgTej
	NlOBoj7XhtSSLYVp0W7P5xQG48hZ9cDPxEnKrQ4lS20rST+wQwOA618xT1eGyeALN9ZCA4MdnHZ
	46TJMoq36+5uV4VgaNVyAqy8EeKbxvmFKBtSuJWDdDjouIcD2OFTh7u/jPHssmEu6i6PlbAg8x5
	YBXSH55Rzn7AsDg9WObDrzO1xA==
X-Google-Smtp-Source: AGHT+IGjc8X9dYiJVGqj7xY004j16AGA5MzWlzOcg2Kf2MlzCj4F1VxxUqJ9nlJ6+HQe1yUbrvVWSA==
X-Received: by 2002:a2e:b8cb:0:b0:300:1ea5:1655 with SMTP id 38308e7fff4ca-30468577a10mr9499161fa.15.1734703569667;
        Fri, 20 Dec 2024 06:06:09 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:06:07 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 18/18] oeqa runtime ima.py: skip without "integrity" in DISTRO_FEATURES
Date: Fri, 20 Dec 2024 16:04:41 +0200
Message-ID: <20241220140441.271395-19-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/957

ima and meta-integrity are not enabled without and the test fails.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-integrity/lib/oeqa/runtime/cases/ima.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-integrity/lib/oeqa/runtime/cases/ima.py b/meta-integrity/lib/oeqa/runtime/cases/ima.py
index 6b361ca..23d9b6a 100644
--- a/meta-integrity/lib/oeqa/runtime/cases/ima.py
+++ b/meta-integrity/lib/oeqa/runtime/cases/ima.py
@@ -27,6 +27,7 @@ class IMACheck(OERuntimeTestCase):
 
 
     @OETestDepends(['ssh.SSHTest.test_ssh'])
+    @skipIfNotFeature('integrity','Test requires "integrity" in DISTRO_FEATURES')
     def test_ima_enabled(self):
         ''' Test if IMA policy is loaded before systemd starts'''
 
-- 
2.43.0


