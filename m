Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CFDC369BA
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 16:43:15 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.24596.1744821786620728275
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Apr 2025 09:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OogMmhLG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f391864so4244266f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Apr 2025 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744821784; x=1745426584; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZEJLTB+o0i1a4ZkiGPWF22+AMd92f24YYaMr0zniOE=;
        b=OogMmhLGL8Z4NPNklcSRk5q6a6bk7nE+arfleFJKLCku2JefJqztugZ7EJXptIbH8J
         mpCcaWbSHZ03C1t/oVZ8zXFNA7jG8dhHlBj62h7vQCDex4oLXWmVHDNhmXvAaNCzQ5dk
         M+isVLSYgXIooI+SuJ7uwXcuupFW2LFWjA4KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821784; x=1745426584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZEJLTB+o0i1a4ZkiGPWF22+AMd92f24YYaMr0zniOE=;
        b=t3oflxWD2Ufrtuxztfqqx2tJRyZAnG5R4c3U5YtzQy06pctr8SKLVgBnOuIphsJOro
         hD3Zkbq7uUc0POUx8Sh/muczduwMylAtiQKo5E5hBqbyE9fNK8vxGqOkjawjdwrUEI/S
         QqZSBbB2IUXm1+CL9LIvelcA+Jo1BKswzIxEPoDrX4b8xRp1/2+odB6E12B4ZzMen9Vl
         CyNwwQG9YbvIdWLmhXZ6EeT8Cb6J/A8ZCVnuHIe9NlRXCO1Ew+0lZKDnzdXPi/KqzRwu
         dpLgk867Cni/DFkzWSxYPUKUz1VqMmCqtzeDyteFPWoaDH7UNq5pf8MTivkSDBjVvz0i
         rqOw==
X-Gm-Message-State: AOJu0YyR6KIouA2NoJcr81TH4i+O4lLKz20GpkNrkS98kMKggqQwkdgZ
	KmW/mSmms7h70Feb9ujSSRuPGCrZ0lRPsF/D5T9w47Cf7i5k4vK8sg23EMn0Z3Cpy/xKOJO5mlc
	C
X-Gm-Gg: ASbGncsH/WHoAe6QVAYz4BvnHCxqL9e0KnxkaRTqThvlVrX0yVmTKIBkFLZK3LJadTI
	FuV/nTDZQYCsFp+mh+WfWLEGo0wKkb0mgBVJKKpHXnOG6oUy23X2mRNce8bEJVGnhmOmDlco4NG
	ANDLv82e79r8MAU19MVGxAZh9qTxaagxlADfvMYRRPgExCXLnyC5JwSVhMnk5709V+TKUaPMfOk
	AIU47MysYfol7t7Bv0Pc0MiEWjwNAJmePPPAevPTSYb1h+/pRrSxOX3E3Qtx6wFRjJbFoY1DbdW
	S6g5NqujU3RGJpkqtWMh9BxUDu530QFixPNUFQCnbP5gALMFy50e2tz8nsZoIMTZVSckKQ==
X-Google-Smtp-Source: AGHT+IEkhscPai4Dc1ymV5Srrb7JM/np9IL/3YElgDvhmGtiJJctMydeKcGaxJ/hVGK1+W9TxHJLuw==
X-Received: by 2002:a5d:5c84:0:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-39ee5badec6mr2095564f8f.49.1744821784625;
        Wed, 16 Apr 2025 09:43:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3e1:10a8:f859:c922])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cf42sm17731638f8f.64.2025.04.16.09.43.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:43:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Update PACKAGECONFIG to match meta change
Date: Wed, 16 Apr 2025 17:43:03 +0100
Message-ID: <20250416164303.1448544-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Apr 2025 16:43:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1377

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 03472a5..0631023 100644
--- a/config.json
+++ b/config.json
@@ -1531,7 +1531,7 @@
                 "BBTARGETS" : "core-image-sato",
                 "SANITYTARGETS" : "core-image-sato:do_testimage",
                 "extravars" : [
-                    "PACKAGECONFIG:append:x86-64:pn-mesa = ' gallium-llvm gallium r600'"
+                    "PACKAGECONFIG:append:x86-64:pn-mesa = ' gallium-llvm gallium amd'"
                 ]
             },
             "step8" : {

