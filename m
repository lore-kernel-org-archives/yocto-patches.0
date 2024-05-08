Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97701C25B4F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.15798.1715182302701257349
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=vibahn+W;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.54, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1046103666b.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182301; x=1715787101; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPqPqPq9ZkBUDHNFlpiE44H3vGZTMuLbvjFhuP9oUPg=;
        b=vibahn+WWSudWYc+DDTi/PUhGlrT4wQyDDJGVG/mx2yfqUzcfIT7i6tWgXjwzI7U/C
         ToNwtaWu2cXcOjzxwhcmMbxndk9LJGaNCCzXz6Xz3WXk777OhDYUZZS/J14TeiXmUi3J
         82e+kGkR1Tu2xmlZdyzSun1MxxwtMUbhTgKU0XcrVWA8A+KkXofr39HtzN7jwpORgav3
         Jb+jS4eHKjsPadvLGLsNpXB9Pz+dPuEodu3VsDUyw1aPVtvnvdvDwsFuh7xA2Ok/qHiI
         cYQHJvF8vK2vxRJaoGv6yom7GdSvA88GTIG8Z0M8prL8hKjPheyMqKyjgFvZ7ejDJtZH
         Zo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182301; x=1715787101;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPqPqPq9ZkBUDHNFlpiE44H3vGZTMuLbvjFhuP9oUPg=;
        b=JCNpmHGEyFgjnVBydVsyA03lmQr3Ahn4fYQQcu0Ssit2ITKU1F2iExXc0Wj7gXm928
         3Kle61RNl3Xuzq3A+61ysGubKN1+DLWjnhK0rj9R7rZOc2i6GVzoclozMTQ9QGEALJOy
         w6tCtrpgP9Z/2axImhNGosfEN/MzPFGf6/WOfeBN3UlOicGnLqLgNIvuKkTty2nt2rY8
         DVb4pcAAdw/qdLayMIhpYJ/D6/o3S0KNsIhWb/tFwuu30XXxbgtaZcMQjKTLviEX3//I
         4fqnZqF0IY6r/3RjBvk8ktrMYNFm+v9bRhFk4Dmxfb/ypO3U1KDb0fsDix8IWxjv3DGV
         d4Tw==
X-Gm-Message-State: AOJu0YzRwSCx65Vt4y4Ceh5rK/BcYOw/QdVjcgytNFimcLttgo4bEZxD
	lLOWTFQa4EJZ+CRdtzSxeYfx25sTAC2AjW1W7zD8cytvh+7qPo+YU+Pg/AzEGHHbzLxi0Zy4MKv
	r
X-Google-Smtp-Source: AGHT+IFSGQQm6b323bBg9uU8x71/uMvtAC25De85IRjpN/LBGG0WeheCQqY7eNsKfSQTGV9gJz195w==
X-Received: by 2002:a17:906:f914:b0:a59:a7b7:2b9a with SMTP id a640c23a62f3a-a59fb94d381mr171337966b.17.1715182301252;
        Wed, 08 May 2024 08:31:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:41 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 06/12] index.html: Add description to patch status metric pie chart
Date: Wed,  8 May 2024 17:31:21 +0200
Message-ID: <20240508153131.94270-7-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/97

From: Alex Feyerke <hello@alexfeyerke.com>

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
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
2.39.3 (Apple Git-145)


