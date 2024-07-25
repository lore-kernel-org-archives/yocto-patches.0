Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB400C52CD8
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:25 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.32096.1721898138027096632
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VLSKNPxI;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52fc14d6689so639598e87.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898136; x=1722502936; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOnCtC0t+oG4U7p1iWW2f2BP5AGl7r663DoDAIMANZo=;
        b=VLSKNPxI5IN8sUJWGG1RDBeMlR8A7wopAvjYbnv14ng0WH2IShm1bTtphKo54Qew5A
         TwffRx58ZN5xkuXNMlZrcsPrD7taj5FHcRZQP8Klvns5RplwRyE/QLlEVr8LQVSoICwV
         +9kmfo2+OSLYih++b+JpHhm4z39ipTxFao20uBoM4CiXBjZgVzhBnVc/eFyIWPnlt7s2
         p4Amdw2pDIjo4vunH0GOvCyIRSkise0dN29t+3TXW5Dt0a+M6IrQ9QVhKBgqo/0AUr3X
         ye4RMWfaK4IRrfjrpXzsRLHlW8uFG09v6x3NhGKinygREQC3FWvX9pGhPr2zCqY2PCMY
         25Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898136; x=1722502936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOnCtC0t+oG4U7p1iWW2f2BP5AGl7r663DoDAIMANZo=;
        b=e35lvnOi9+m8TX5ZjKXLtcCRt5VM/eD6iXRLH/DKbWu4PMmALl/9UPZ2ArzmExzBH8
         6yhloRNp8DzQ7t9EvOpmuKflWypZvlwkWq6bUpWEaah5LlFruNL484WWDO8c+v8r3J1n
         82qQLwYlkmDykRKhqEs/UnA0unc7MZRhyI7zRLik33Qndy36RMXGHRTTG82tpgziyzY+
         P0f+ZMCwQoxA/JnWNj9K+/vn2oiSoTWf1ITIGOfuOM/Dg8M+BpUOuVC0Xxfq/X7gt0Ve
         GbAeKAcE8kv/gsyREYRd+LbJZEimnDZSXptlUOUzrAEeG9irzbv85wzOlQbcTI3gin1j
         ER2Q==
X-Gm-Message-State: AOJu0YwM0CvFWhJGj1mde/fE0lhHJ9c0jCjKuY+GF2DSdaj38lReopdq
	IUUtS4cV8oww7XDMVBZZVZuoF2BN6mXdbRezCefRHbZ62DTIMAU0fYr2P6yix+GOCawpJFpXV1f
	w
X-Google-Smtp-Source: AGHT+IEReZVcns8qOcvI+Mi329X66nXBbSHJfwRfQuQLCzv4lenFQdZljzxVSGJ0V9cV7aolAQOXuw==
X-Received: by 2002:a05:6512:234b:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-52fd60351cdmr1031061e87.25.1721898136243;
        Thu, 25 Jul 2024 02:02:16 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:15 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 11/17] arpwatch: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:25 +0300
Message-ID: <20240725090131.75860-11-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/468

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index e547938..cacfea7 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -60,9 +60,9 @@ do_install () {
     install -d ${D}/var/lib/arpwatch
 
     oe_runmake install DESTDIR=${D}
-    install -m 644 ${WORKDIR}/arpwatch.conf  ${D}${sysconfdir}
-    install -m 655 ${WORKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
-    install -m 644 ${WORKDIR}/arpwatch.default  ${D}${sysconfdir}/default
+    install -m 644 ${UNPACKDIR}/arpwatch.conf  ${D}${sysconfdir}
+    install -m 655 ${UNPACKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
+    install -m 644 ${UNPACKDIR}/arpwatch.default  ${D}${sysconfdir}/default
 }
 
 INITSCRIPT_NAME = "arpwatch"
-- 
2.34.1


