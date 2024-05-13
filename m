Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC5C25B74
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.62818.1715612371511946714
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=zC0ui/58;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.47, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cdd185b9so943865266b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612370; x=1716217170; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0YFnMMv5knpHkqj0pva92qDxm1iIqOsIGklXLBneJdk=;
        b=zC0ui/58vLeU8RYxPCocTt9kJ9yoJVo8Y+2rZQ/hZhAr/mkVv/N/AnbClhVwY95F58
         3Ayp3fD+r7/wfW4Vyo3LRH4tQubnZxSz9cz7ZknztyWGO0IBzgPqBFlRLzpmk1zeUWHj
         FLl1ZzJlqbKJLFKwgZi8gK3okm+XcL6d9efQLHstvZCy5O7neI4XA+GaR6eULpusFNX0
         QIOM8uoL9P3iCtgdAOqZz14asCc1ixTQSXt2gsXz4MrpsTs03DbnqlIaEbeQHbvFiTVL
         y0zu45JRNFqnQmjD2NWng0unza828MDBX5t7drtbSskjDlZ9wIzMcCdgn+fjE0Z08zzG
         OqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612370; x=1716217170;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YFnMMv5knpHkqj0pva92qDxm1iIqOsIGklXLBneJdk=;
        b=qSe1rclYALSLVT/x68nd47LAsKQaQ+ynBL1VFCzKB76ucAwEp58m+mlwqeykNuAieZ
         5bgZigOdnJVZwqK0y/VIU/A5M9KH57cSDVH0Cl74hYwJxPLXnABk49jUlahLpASKB/td
         PlpATcWxfODzkPnbFflnjX/0xr+T/xQ46VWKP2rXnbXiCnKPr6xMEdstLhpdtSn26L7O
         s8+bPTPTBIr59ydsQ8eOGqgzBL/HHDvHifHVMYz+jZk19goE4vV0NU9IQClaxzICSFuT
         DDCXZiwgi/hP4xc3lJqSlJ8Sj4kWRblaPmFfhKquuJHVrqEF5fSpfgd0/u2/Enox5ghh
         C4Qw==
X-Gm-Message-State: AOJu0Yx7KYiBWcmq7IpGDGWGVFpvLkz5MdNRJ8thoFQnWi5X6kvsXFRy
	USd89T7+Es/DhIIJrvGNajNJa/LVVn6ZonKktq/5QwIy2kXo6pEnLkb3HcHajxrO2/5Oc6YKYi7
	y
X-Google-Smtp-Source: AGHT+IEeY1fn1TgpRhmJDmxoYGRn5sHVbHUCTBFk9O2V2uZQPchmYQPoAcjm8Dlo0OjDjuLZXFXdgg==
X-Received: by 2002:a17:906:f582:b0:a5a:66a7:47f3 with SMTP id a640c23a62f3a-a5a66a74d79mr289189566b.35.1715612369949;
        Mon, 13 May 2024 07:59:29 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:29 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 05/12] index.html: Add description to CVE trends section
Date: Mon, 13 May 2024 16:58:54 +0200
Message-ID: <20240513145905.4167-6-ninette@thehoodiefirm.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/125

From: Alex Feyerke <hello@alexfeyerke.com>

Also moves the chart out of the section element so it can be displayed at full page width.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index f95fb692..09299910 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -161,9 +161,17 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>CVE Trends for OE-Core/Poky</h3>
-      <div id='cve_chart' style='height:400px;'></div>
+      <h2>CVE Trends for <code>OE-Core/Poky</code></h2>
+      <p>
+        This graph shows the trends of CVEs affecting the <code>OE-Core/Poky</code> repository over time.</p>
+      <p>
+        It shows how many vulnerabilities have been identified within the <code>OE-Core/Poky</code> repository, per branch.
+        The colored lines show the trend of CVEs for each branch, allowing you to see how vulnerabilities evolve over time.
+      </p>
     </section>
+
+    <div id='cve_chart' style='height:400px;'></div>
+
     <section>
       <h3>Current Patch Status Pie</h3>
       <div id='pie_chart' style='height:300px; width: 600px;'></div>
-- 
2.44.0


