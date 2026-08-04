Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24317C55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 15:37:18 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19418.1785857831419851230
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 08:37:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cDNcef1A;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ee4399c423so28761a34.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785857830; x=1786462630; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZ8AWsCPZX6fyeOJqRiIacJdtnId32kslpot0hjBgXM=;
        b=cDNcef1A/xCO+4pTOaC7s8aanve+KwmpRMqesMAo/UT6QMn9Za5dWiXtNH197681l1
         aqqv134+4tI57QoQAwafoPmRdjUZ9QfbOtdi/Qq+y+QqVDHlaRoBIC4FfNg+eSDCwsxs
         5XEXrUksRhTstuYXkaAVpCPjlqvUG3r5YiQnCbuyLiANNL/WBJr0kgsnvuLo4I64f6se
         wiCfd9fqL4CPdmWX1G4RkBZD38/nJhXH3AAguBRVt7m3MkN1FMWRrSCHK33Oj6crRE6x
         tfoyX7PlbCIrqdt91S9fYadXuLnXb+VeFNU7xf3BBH2AwDqHsKp+ZKkbWb84HOYtPObN
         kM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857830; x=1786462630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZ8AWsCPZX6fyeOJqRiIacJdtnId32kslpot0hjBgXM=;
        b=VPI382woW0bsxoPnGgkUK8DZUMMVAv33lRW1zywjOLPPv9y+noYTjtSJ4RliuHUUx/
         edjxpvHx2E9nX0tgnzxeHszEwkKAhL3wdII7X0OQIO4CZpoF4+6ZQPaZ5CiWcHXPNTnW
         daXSaXKPYGGOncEb3HblVFJcCsyPWq3UZsCxzOC7Tp6EctRiU+KnQSTtREldUqrTxIL2
         S6PwUpptbvqVcf6K+sy8dEFDgijs6ngvMegVLsBoD2GNPWusOA/fQwIp8EDiAM7303Cg
         6dVJUMVmq0uSU4G8GrpslGLyQdzgFFzwopTNVAH6/MobJ6sLcaoHKdpSmcyJ5x5iMpjs
         D2Ig==
X-Gm-Message-State: AOJu0YxiuNz0ud2qzF6ZR5RWtWyE/4fj3ECbi77/iwzG48kDd/63x/2i
	/rNErUIxaiLn5MRb4YOZc5waNcXcAY/usqAoxaXq4x48IgI+TpC+/neiTq0a1A==
X-Gm-Gg: AR+sD12eGBXusRVsIQRy3IpSffRRvUnJOZ/o4/R7FR5MRSbBqqzFue6jMy8VvuZ9Ap6
	kXsWJzzT+1ezQaczqzgaDKmiHfc0mOfGgswgsWn3q3rz2X2EFSZtgcXtrD5sZCQQqFfpp3iT6xL
	RcDMyRpoSMAHB3gBuykd2bYwBy2FLZuJoXLaXrHit4+MYgaW57Pyl9zddwTEmZH99KfEd76g+/5
	WQFZsZ4BDNFR4yXs9CdzRSbK0dvbtQm3Y2AelhgHhGQpTKIRYYCL8J8HteJS7FkrNVT8KbJPib5
	6kBTnr9zlDW9RGaQOr+Rtu2gluAUjxAKQEAE1lmrletnRnqR+J7al0I2vSfOmRovqeeFSp4u5cp
	Vucc/4nDYeKA36vr5Cw0st3lRrajZQZhZpIFZ7Dxh+7zZyvvU+G/LkJks8nvJMofNbgvvdz7xQ0
	fTd/pd5WTAy5jd8DPuFpwOLjFhYZTV6oCOslzS8qUQmHdz2g5LyGKWFMXPxCSd+FXnbfhp
X-Received: by 2002:a05:6808:152b:b0:4a3:3108:8653 with SMTP id 5614622812f47-4af5e076ec4mr21471303b6e.9.1785857830342;
        Tue, 04 Aug 2026 08:37:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::2351])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58f6fd37sm8864469b6e.17.2026.08.04.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:37:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH v2] c-ares: Fix append
Date: Tue,  4 Aug 2026 09:37:00 -0600
Message-ID: <20260804153700.962926-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804152903.929527-1-JPEWhacker@gmail.com>
References: <20260804152903.929527-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 15:37:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4623

The append needs a space prefixed to apply correctly

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../recipes-support/c-ares/c-ares_%.bbappend                   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
index 8ef58f9..4d1fe51 100644
--- a/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
+++ b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
@@ -1,2 +1 @@
-EXTRA_OECMAKE:append:mingw32 = "-DCARES_SHARED=OFF"
-EXTRA_OECMAKE:append:mingw32 = "-DCARES_STATIC=ON"
+EXTRA_OECMAKE:append:mingw32 = " -DCARES_SHARED=OFF -DCARES_STATIC=ON"
-- 
2.54.0


