Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305EC25B7D
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.62674.1715612372508519908
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=x183LSqf;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.50, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a64db066so1124433266b.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612371; x=1716217171; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doYhzwA5vSIZcs0itlTf7G1d0CWKOLi9VQIqMho+mSo=;
        b=x183LSqftPSkqt39FcFjbSUnTWKwYxBd+BPpuC+oSGKtnjBz/JqCmI93OS09zKDyhR
         /pc6WBnXCCGycHIuKZvc6mpGAZITI51xwm3anDMPMN6PzloQMnEYuDz1g70D00O0V8nX
         88JJSvQj1IRRyeZdu8psepwc7yrg7mIUYtkqUuXLVkppR6joH7R/puq2sRJwqY4rpzuh
         oW3cQBrvj8q4fRqah4HbY23TbPNtp7D8p1sThttS6m/JPnZ+Mjp13Ua5hBvKnIMrUTNl
         6YInFTo17SYcBeyOp0p9qWh6CfvHtQbF2LE0x85xDuiEPiv9PvLBvzlOwVnbOVk6c3aO
         8yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612371; x=1716217171;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doYhzwA5vSIZcs0itlTf7G1d0CWKOLi9VQIqMho+mSo=;
        b=J+AgdwNhzfHgJZwJMBRPC0omDIsfDj9I7bPoms2T0/Y62cgASRsG9KZom8KZYf+VT9
         7ZULEzBzd+DM8uHl4TuD4zgc2yRT2kh38UQRCwtK9/pSYF2YqGG0tYI1KGp+4uZef34b
         mVN5YRXUqzYpCTmJ7jShGhA6Qmqonp1ISngn1lG2zvRkfQHDN6rfTErLhHdc3AHAAQrB
         bUTX/D96o+JkllhQ/cjSBnKY1wQs1Ggy8ovnzKVKQN2xHg0H9JBe/uCwrNV3VFwzfJFx
         fwdG3rPlZyfr3MFZcyWrQZsfJvTf9IkWQeioD96pPAoCdxARLPcdpfTCOpf1FEVho4jP
         YxLg==
X-Gm-Message-State: AOJu0YwePGCre2NmThldERtNsb2pHewauTKbeuWXGu/+SXaLjIsuxDGI
	rIxYpC4rJYA6oSxDm4A25ksI/s9vwJmjR3lG2jlA+TAknbkOFNmac6anwyGO8GOTi4FUnr9w3rx
	U
X-Google-Smtp-Source: AGHT+IEw3oaEbKWcJHaLqvctwpBe5Yy7mrO7XSDqT8adZH/VV8/SYvPMCq2fcdEonXX5K0MXO+N4ww==
X-Received: by 2002:a17:907:552:b0:a59:a6b2:b898 with SMTP id a640c23a62f3a-a5a2d57b00dmr655558366b.27.1715612371100;
        Mon, 13 May 2024 07:59:31 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:30 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 06/12] index.html: Add description to patch status metric pie chart
Date: Mon, 13 May 2024 16:58:55 +0200
Message-ID: <20240513145905.4167-7-ninette@thehoodiefirm.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/126

From: Alex Feyerke <hello@alexfeyerke.com>

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 09299910..30f1cef0 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -29,6 +29,11 @@ SPDX-License-Identifier: MIT
     h2 {
       padding-top: 1em;
     }
+
+    .flex {
+      display: flex;
+    }
+
     details {
       margin-bottom: 0;
     }
@@ -173,8 +178,17 @@ SPDX-License-Identifier: MIT
     <div id='cve_chart' style='height:400px;'></div>
 
     <section>
-      <h3>Current Patch Status Pie</h3>
-      <div id='pie_chart' style='height:300px; width: 600px;'></div>
+      <h2>Current Patch Status Metrics</h2>
+      <div class="flex">
+        <div id='pie_chart' style='height:300px; width: 600px;'></div>
+        <div>
+          <p>
+            This graph shows the latest patch breakdown metrics.</p>
+          <p>
+            <strong>Hover over a section</strong> to see the amount of patches with each status.
+          </p>
+        </div>
+      </div>
     </section>
 
     <section>
-- 
2.44.0


