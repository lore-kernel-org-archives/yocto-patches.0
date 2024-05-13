Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39A6C25B78
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.62677.1715612374588383990
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=WH9ANyZ/;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.44, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a5f81af4so1136883566b.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612373; x=1716217173; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYrHEF5nivEvSCnxAHYXnJh8k0q7iS8182Hshr5lq7E=;
        b=WH9ANyZ/Hsou6Yh+A+ZrX7a4EE6SVDoUCQwQu5PpxYY38LZyNqCfmAUgx6r+dDFrYs
         plNZYXHf8NlGke1zAiXohLV3jjQJKMcb4jBokJeVeluRJl0hYn8uat26T1gcz8m3BHDj
         SkV+dO5nSWah7d7Y9dRs7/4YFMoSJyYIW4PDO0gs/tCtWYYLlnQ2e/2onrdwrM/MxGPE
         FO2JqQ77s1U0LUL877l0x3iiXAfi2Yyr3nc4p38WH+Oe4ENy0ZkScLan5R/Rng3Ho/LH
         Cz5koxC21vQZdTv6tbJ9Sio46wDA1i5bbGYO2/uI8uhugGMKFadvAFbid9XIn7DAZilS
         hH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612373; x=1716217173;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYrHEF5nivEvSCnxAHYXnJh8k0q7iS8182Hshr5lq7E=;
        b=GPjC2saQX2LYv9xNUrmXlNa6ZURlbA4RpRsFfknvdfo1bNHY5NMhggbP63+WB/Zngq
         ykEFJWZV0hMjTQu5DhmVgDbzNilwygDkVte+c6fH7gpeV0zRKLHRupJNuGQx+8oUPOQF
         RZpRicgxPJPSAP/6AUjgqRWmWR7wIVj6RqhNiCoWW8nUo7eiULAsCydLjqO3xL/jb2E9
         re42zPgWHeaU5RJnlT1jbLL5r/DaFLR8hIQja4kfc/2SwiE1vxVCYNuDMkN3I7T8MnQe
         f6pYRO+sg+3JtJ5LGdrHd1MXq1a9LQ2vMPzSLTEIll05xbOY07MeEBCNGU4djXPVs0V/
         14vQ==
X-Gm-Message-State: AOJu0Yyro2CH5hfQXUAKU2cEd8xsV1ZmaLUqziUMD4lY7zU2yI82Tspd
	HzRtidsadqHQaHOBEaJ/P1PWit6+qfjcg2V5OHpkvJfKYO4S7FlWi/J0PRfeh5O2kwxXqKFjZlJ
	u
X-Google-Smtp-Source: AGHT+IGQaHHL114v2RA7hLPf16QrqRyD9cPUGWEKRzXdLePkKjsH3xml/miNh1HhmE8sVUEWYZz6rw==
X-Received: by 2002:a17:906:d054:b0:a59:b1dc:57a8 with SMTP id a640c23a62f3a-a5a2d5ee320mr690518366b.33.1715612373131;
        Mon, 13 May 2024 07:59:33 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:33 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 08/12] index.html: Add description to recipe count section
Date: Mon, 13 May 2024 16:58:57 +0200
Message-ID: <20240513145905.4167-9-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/128

From: Alex Feyerke <hello@alexfeyerke.com>

Also moves chart out of section element.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index aacc6496..8089a1c0 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -332,17 +332,20 @@ SPDX-License-Identifier: MIT
     <div id="malformed_chart" style="height:400px;"></div>
 
     <section>
-      <h3>Recipe Count (OE-Core meta directory)</h3>
-      <div id="recipe_chart" style="height:400px;"></div>
+      <h2>Recipe Count (OE-Core meta directory)</h2>
+      <p>
+        This graph displays the number of recipes. It provides insights into the growth and evolution of the OE-Core meta directory by tracking the number of recipes over time.</p>
+      <p>
+        A recipe in the context of Yocto and the OE-Core meta directory refers to a set of instructions or metadata files that describe how to build a particular software package. These recipes typically include information about where to obtain the source code, how to configure it, and how to build and install it into the target system.</p>
+      <p>
+        <em>An increasing recipe count indicates the addition of new software packages or updates to existing ones. It reflects the growth of the OE-Core meta directory over time.
+          A higher recipe count often means better software coverage, allowing users to build a wider range of software packages for their embedded systems.
+          With more recipes, there’s increased maintenance effort to ensure that recipes are up-to-date, correctly configured, and build without errors.</em>
+      </p>
     </section>
 
-    <h3>Raw Data</h3>
-    <ul>
-      <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
-      <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
-      <li><a href="cve-count-byday.json">cve-count-byday.json</a></li>
-      <li><a href="releases.csv">releases.csv</a></li>
-    </ul>
+    <div id="recipe_chart" style="height:400px;"></div>
+
   </main>
 
   <script type="text/javascript">
-- 
2.44.0


