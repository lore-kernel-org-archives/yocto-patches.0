Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D2C25B7B
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.62823.1715612375767681157
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=vLqX8NPR;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.49, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a609dd3fso768933066b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612374; x=1716217174; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k2flzxvu0JVU/SIpD1Z0RZmeUyW1QPaxeCc/J0YoX88=;
        b=vLqX8NPRcLi21j8M2xprmSy9UGRDbhnhlJuZ38JghY08M5H+DXEFg9EotJIWHNg95Q
         3HziqsrSoVaKVqz4XC3Ybfz75KRRpS5OrM9qKNe2TEr8uQXw19kV6FNYnsIU9RcFbijj
         Tu4AS7VTwjK1Dtq0gR9YgelocupVIO1GAcryMkydKVbKVcvzG2zYqc4n/OIMqVaG2Ei3
         L7IHqP1vNsnJDQTf1Brbq9smHJvXkN2ID/L/cq3x/3wbbRkTQESJRS7F0iMqsOIRFm7c
         cJAgU38LGXUKzGyx4yZo9aBA1E22ht9Zd2tMlfypuTrJeu2Z2sIz55bu25FxsBWlDooy
         mUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612374; x=1716217174;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2flzxvu0JVU/SIpD1Z0RZmeUyW1QPaxeCc/J0YoX88=;
        b=qTHhcNlTfKUifzxV5WEBbBU5xIEtBwgERpgm5lrmB9Yct/VuU10vYXGRb3MMJkxTIB
         gPd6ywKUUcC78De85lD5BYKMDeLgsnR2rtsPjlkFDVsxQcEr95KG+mJQhHi1XbseYUIq
         Sfqe+R0khf8DswA8kAXBglSKUdqzOqzdh7G9UQYC7ygs+PkekYtasRWowv/wtEEqOQCd
         SPqzH1loemWA+KMjo8THdn2VlDTQ/63xDOWhkXtr0Gn5s+Q4RrdOu/ir4gnCLdd2rsZ9
         P4gtVmlyCpp5uf/u0MAREcG6mGgwXthnKLJFaCbs3iADVdY2oPow982bVQ/6Qx+sbV8K
         bsXQ==
X-Gm-Message-State: AOJu0YyA72Fo0MCtlu+RtrT4M0koBTUH0ppqVsxBZmNWs/OQ3bvM9g0I
	msubDBx0Zo9E6Xw3m5xcyi5TF1ov5qkmI4UV7frQIfjTz5M+koJ8owul5SChP1OH3qM8ly4U5t/
	t
X-Google-Smtp-Source: AGHT+IHw0IDitx48zq069zZhtYABMltZ9vhyfaIj1UxT2epOADpGZuAK1Svv72XkQ5t0qP0Aswg7+g==
X-Received: by 2002:a17:907:720f:b0:a59:9ed5:eefc with SMTP id a640c23a62f3a-a5a2d30ba12mr1152393766b.32.1715612374261;
        Mon, 13 May 2024 07:59:34 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:34 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 09/12] index.html: Move raw data to own section element
Date: Mon, 13 May 2024 16:58:58 +0200
Message-ID: <20240513145905.4167-10-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/129

From: Alex Feyerke <hello@alexfeyerke.com>

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/patch-status/index.html b/patch-status/index.html
index 8089a1c0..31c5bfe5 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -346,6 +346,15 @@ SPDX-License-Identifier: MIT
 
     <div id="recipe_chart" style="height:400px;"></div>
 
+    <section>
+      <h2>Raw Data</h2>
+      <ul>
+        <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
+        <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
+        <li><a href="cve-count-byday.json">cve-count-byday.json</a></li>
+        <li><a href="releases.csv">releases.csv</a></li>
+      </ul>
+    </section>
   </main>
 
   <script type="text/javascript">
-- 
2.44.0


