Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F1C55838
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 15:29:08 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19229.1785857347222307921
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 08:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DKpl5Nuy;
 spf=pass (domain: gmail.com, ip: 209.85.161.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6acb51944d6so24180eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785857346; x=1786462146; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eigbG6sjkwjKqYPNcwXKieBeX4qhlDkvOJubtKHwUw=;
        b=DKpl5NuyG4Xv6uNice7sjR56QO9gCsWxRoMIy4Binj9nvm7I7eImydxp6Eyg7xS3BQ
         LVVf5IASPmbYQRbpaYDa59Y/zLTko7boW7BSkv1Nf/YVmrOBVnAUbs1Fy1un4OCHI2aR
         NrSQvc3M0/ekAK/K2fpiITI8hqcrOZcQC9ALxPihZ6A6fomeys6khsRmSRZVnuBEleKl
         wVkctCk7aSJG77zrcYLHDmTmfL/BznODMSExYofkIS8RIMZONdqY6/3/TCsq7Sx+k/DR
         ZPjFQHB2lHC8/OuZzrM1GVPOoR2gVIfCvtn8YeCzUniFsrQ0g1GadMNpTyJEWg2ATRZG
         OUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857346; x=1786462146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eigbG6sjkwjKqYPNcwXKieBeX4qhlDkvOJubtKHwUw=;
        b=YC8P7h9f3K0BxkL0d6s01/GLiA5/DWflWIzou7spLXbVlrLdnzdzRf8vvD2RF8OkVM
         F6HDjyRzQAIRhgAYmfUJJPV1PV7lELXdCcqFHJfQD0qU3EkiytXz/sxXcn73dRUlsxpA
         bXeS85uwaWt5URReQnWmwZn9vTHZt5/tDmk/AO63AIXWZp3jWjZCCrmLwnnfnEkul9cK
         kbDLMtyQwZD5UnSS6XYWyxY8Y0PeV6iihdG0lEHOCPs65n9s1gkNv8xez+4H1r2mnuzG
         OXZD1BogDIw5s8yLtv5FhnwynJM8Ubd5VujJpcLPM9u4dcvZVGK0slMqlNnvXRPu51WZ
         cCFw==
X-Gm-Message-State: AOJu0Yzhlf/p47JXA3ajSj2a8rtkm+Y1Dh3WRmI1pc12jUMZoZ4Ka9Ce
	nODyXc7hA68dr7IrLznGCqtFzP7lPuAH2RLw2rRcF8BndxHV3bIAK9iUl3bi0w==
X-Gm-Gg: AR+sD1009Q0oq+LQJ1nqKzA7m3P94A2SNn2uO/d1O7aPdrpOP4QQIvqLsKXdS8QbCF1
	BqZH9l6zq9tYFq9O4OtDngTWg6RuO5JlaLiF5sAq3fxtSuE36/Lu4HRdukqJuEj/lk3r/f405bI
	h2omKpoJqB/bDzPPLos54ZOzAUcsk7b8unN6NbmgcXNSC/uuGsbqvJRvihuYpK1/gZweenw8WlI
	d/lRzAxiwFarp4S4pcanDJhMTeJmooPDXah/3Mo2YZWp1XVXpjiZR5dzjtXuHjSMkHBWbGPAxZL
	72XTl4jMEySjzG6tmoX7k3dSlMARQGJvuRiA889HqHCThKPvQMYOVzDK6LpwNI56gwqTnEqTyA6
	XerWEyp6hdSAgPtWVysOKJZX2YS75zFK1HMEBC5Hz7t3dXkbkqmmFVf6prRXaUph5Qql9oYYE8/
	8n0ZXLMqQz4vtNo9D9xApeKEey8rN0r52OZp2PD9Wem2ToFr9Wmay55+Watg==
X-Received: by 2002:a05:6820:1849:b0:6ac:a5a3:460f with SMTP id 006d021491bc7-6ae43408fa4mr21307183eaf.25.1785857346306;
        Tue, 04 Aug 2026 08:29:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::2351])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f60ea539sm12196526fac.8.2026.08.04.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:29:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] c-ares: Fix append
Date: Tue,  4 Aug 2026 09:29:03 -0600
Message-ID: <20260804152903.929527-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 15:29:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4622

The append needs a space prefixed to apply correctly

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
index 8ef58f9..84330d8 100644
--- a/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
+++ b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
@@ -1,2 +1,2 @@
 EXTRA_OECMAKE:append:mingw32 = "-DCARES_SHARED=OFF"
-EXTRA_OECMAKE:append:mingw32 = "-DCARES_STATIC=ON"
+EXTRA_OECMAKE:append:mingw32 = " -DCARES_STATIC=ON"
-- 
2.54.0


