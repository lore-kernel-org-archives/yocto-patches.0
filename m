Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98327103D926
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:01:03 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10546.1773828062167341710
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 03:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GLeJzanW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so77813795e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773828060; x=1774432860; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bReCzuKEZ+Z6bOtHjqfIDuU8cA52wh9mwA3zqX5CJA0=;
        b=GLeJzanW9jCrS2f9jcWPRmzQBhJMYUxw0KRM1KtodEmowP4JK3N4KhfbsAl1Ped7cI
         fJwhlp/f2CDFxSod/D60/Nl/gSknYF6IcgLGgZU3SQXxLx2PElmdX2va4pRQNKcAoCUz
         9CYfHrm5xub3hMTaAlE9Cst3tv+mU0fK6sGeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773828060; x=1774432860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bReCzuKEZ+Z6bOtHjqfIDuU8cA52wh9mwA3zqX5CJA0=;
        b=KEA6MAg9a11S2fwIGObkOIdHw8P1wS2c//b2g4dLebTdJ53FPzGi3g8Kg64sE91yGg
         iJqqLTes2L2zin8pOit0Szd5d8r+TotCStbHiuMVVT3VqnD4ls+27ToY0KHVCyFHP6+C
         JO8/EiN5a4uIbNWYfYitcE0vy/oN08ajskVFYYtXW8Cu61StalGlyz2QinKHBwuArooO
         Badwh7FV46cfXyVcNH6NyOfP/LAlfiNf7GPpu144rn0JhLg97aUo1eMPgvtjxWTcgh5o
         aaiojk0+VU9rrkWv/whruQkDAgnaOC/JbA5ozzMEK1yJN2aHV9L1DdxRCR7subgyOfNF
         bjNQ==
X-Gm-Message-State: AOJu0Yxy2Fiqwyt8MVYn/FWT7N2t3QztSEjP+Vk9PEunjh04BNZlrQne
	ZNoW+NwN4vJLFBXbQvNRcpAu8sh0BUQLOHeKa61l6UabDpSDTCxe45wrxRuC0kUYKauOhswsK/Z
	V9Ya0h8o=
X-Gm-Gg: ATEYQzwkcJxEmKiOVJ7FAs0KxyZ5sELN9Op2x0SqvFo8BBdYMnD1i9EOHrzRyVNQQGd
	LlIaAEvFqY00L7Z+1GiIvpmBmRGBNxgdJCMwSbcN44RPl/+LWCbZm21l/3qkE/oyE8tasexF2/2
	3SRFZwvf7ap1ejyHcJcKBYgtiqq5nz5IqBg5Ulq81/WKVFdfgtkz5ouwGWP2oHHQ82r9lStL8Xh
	jw8ehkthdhTrVnpZCySStsxYFycTmtWDmqnfS+JMyqxu/Zv2ajzqHIk8NoQT5b0bDL+yBhBfb6F
	X/ABnN6AHOcwTJnh//SGZ4oEWc6k0nGXC6+EPuMKBhdlonM73f+iqMqxhljMIKsUMF3EppGMTXc
	stbMmZ5Uw9vIrE6d84z4xUm2X03cwFBBQOUSjpNFadHcYQiWbGmdlQyJaBax8i9u35dtu3n+b48
	n1wmJa3pTW666z61QrHy1OG+XZTcQRJXCMSul6a5CIc6WkWvZgUXjRT7KzD8qy4Q==
X-Received: by 2002:a05:600c:3551:b0:485:3e00:9440 with SMTP id 5b1f17b1804b1-486f4474b56mr45883355e9.24.1773828059836;
        Wed, 18 Mar 2026 03:00:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ccd1:68ee:ff8c:5895])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f442d5d0sm49832775e9.9.2026.03.18.03.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:00:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] lasyer.conf: Update whinlatter -> wrynose
Date: Wed, 18 Mar 2026 10:00:58 +0000
Message-ID: <20260318100058.1105184-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 10:01:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3509

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 4110f08..0dddb81 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -16,5 +16,5 @@ addpylib ${LAYERDIR}/lib oeqa
 
 LAYERDEPENDS_meta-mingw = "core"
 
-LAYERSERIES_COMPAT_meta-mingw = "whinlatter"
+LAYERSERIES_COMPAT_meta-mingw = "wrynose"
 

