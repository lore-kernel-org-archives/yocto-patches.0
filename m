Return-Path: <alexandre.truong@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12818C41513
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 08:39:41 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.9814.1715762376582228771
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 01:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=A4siaMUx;
 spf=pass (domain: smile.fr, ip: 209.85.167.45, mailfrom: alexandre.truong@smile.fr)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso5715892e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715762375; x=1716367175; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFjRhS1yWhgLEqd3iSI3fvhtZQPrT30YUyhn4H6f1kA=;
        b=A4siaMUxVw67G2C6XJWDzMwNbZuV8nbVR8zX5an4lfiKyEI6I9qUr2EDGXSSunDFM4
         EXY+gca9N8SxYPqrXqOBPPsGKKmzV4YAJHG8AUIzFnucP6mzkr8TLKz6NJU93Z4VMXtH
         wafzPN6zQzp7PF4wCKa2fhMR+k9d8TeNA/ZpBOoI/KToppjD3l9tma7ZmVuLgXFLQMDB
         36jc9VmQDWlS2+//TGg5qyQN4aWgPVhyFWVcer+BLDkuzjnDbfEnHVTId0SGciSmswen
         K77n/bhp/GXyNi0sp0Xi2LCXFFp3PziD+AQe7oXXWs7bXle/FAx9wwLuEBsbAV7nZJgz
         RejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715762375; x=1716367175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFjRhS1yWhgLEqd3iSI3fvhtZQPrT30YUyhn4H6f1kA=;
        b=kpZagd1azOzikay8/5XZceBhrvHDdNuCKhwq8BBplP16//YGRA95C2n/MXw/T0cDRC
         DcUI2Uif0pAxAR+2ddgZKIjelK/I6gkOk4YWOFiyW0k/DL5dGed7kEyC/2/bkSh6vvNl
         IFk9W1WTo0aLvjpfDoyPzo8BUps8CoEVFUh/tRyzovsyCfcv3CHHamVVu2nGRbO+Onuu
         B/wi9H7F4YJyaCTosya5e2Fyt5ldA99b3FB/CbYcmjEqlr0VZzqYMtvjgtwafI21n3pj
         YgpyiJFErXJwXXKAkssy2uJeqO8YtyFyAc8M61np4C/IiHsaJKTN/5EYEQKk3GmpQvXf
         wLCg==
X-Gm-Message-State: AOJu0Yxvvc6AS8FR0PzZs80ZaMN5rI2XXNbZCs2BkIMqKStcehqm4eOa
	1XO+3kQLBKwvrDyw2rvEJF8kcB/RAJciSeEeO2+t4yRG+pK4OU9xUPgM7JE5Q09ci9mqOwUHp6r
	x
X-Google-Smtp-Source: AGHT+IFYH7mn1KPraDY8rtu4bVZHl7d/pwDeQElqo6Vi98ax+7Rm+6S9o6XEIHEIruyHHI4t0GBB0w==
X-Received: by 2002:a05:6512:54c:b0:51b:6934:1cb1 with SMTP id 2adb3069b0e04-5220fc7acd1mr8851764e87.17.1715762374601;
        Wed, 15 May 2024 01:39:34 -0700 (PDT)
Received: from P-ASN-MOON.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42011bd013asm132541055e9.21.2024.05.15.01.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:39:34 -0700 (PDT)
From: Alexandre Truong <alexandre.truong@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-metrics-meta-oe][PATCH 2/2] patch-status: upgrade patchmetrics graphs to follow OE-core graphs
Date: Wed, 15 May 2024 10:39:17 +0200
Message-Id: <20240515083917.8470-2-alexandre.truong@smile.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515083917.8470-1-alexandre.truong@smile.fr>
References: <20240515083917.8470-1-alexandre.truong@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 08:39:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/139

Signed-off-by: Alexandre Truong <alexandre.truong@smile.fr>
Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
---
 patch-status/index.html | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index a114918..89ee66a 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -52,7 +52,7 @@ SPDX-License-Identifier: MIT
 
 <body>
   <main>
-    <h3>Current CVE status for OE-Core/Poky</h3>
+    <h3>Current CVE status for meta-openembedded</h3>
     <div class="cve-status">
       <details>
         <summary>master</summary>
@@ -78,7 +78,7 @@ SPDX-License-Identifier: MIT
 
     <!-- Prepare a DOM with a defined width and height for ECharts -->
     <section>
-      <h3>CVE Trends for OE-Core/Poky</h3>
+      <h3>CVE Trends for meta-openembedded</h3>
       <div id='cve_chart' style='height:400px;'></div>
     </section>
     <section>
@@ -87,17 +87,17 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Patch Upstream-Status Counts (OE-Core meta directory)</h3>
+      <h3>Patch Upstream-Status Counts (meta-openemebedded)</h3>
       <div id="upstream_status_chart" style="height:400px;"></div>
     </section>
 
     <section>
-      <h3>Patch Tag Error Counts (OE-Core meta directory)</h3>
+      <h3>Patch Tag Error Counts (meta-openembedded)</h3>
       <div id="malformed_chart" style="height:400px;"></div>
     </section>
 
     <section>
-      <h3>Recipe Count (OE-Core meta directory)</h3>
+      <h3>Recipe Count (meta-openemebedded)</h3>
       <div id="recipe_chart" style="height:400px;"></div>
     </section>
 
-- 
2.34.1


