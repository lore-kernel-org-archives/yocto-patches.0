Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A799C19F4F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.15792.1715182301525927652
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=nl4FpX0P;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.41, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59c04839caso1031900266b.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182300; x=1715787100; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJshCEGEO6C7BPozVmrqwdwGDdbBdrDE7yf6LFuqA4U=;
        b=nl4FpX0P4WkxI549muirN8bsBHMDrqI8VvayMethQGO2Z4vZ8TJGoR/ZpvdnckPCiA
         qeYvpbwD3Bmrf4Qa4bsE/4RwxEBIsATy+Iu9NifhYp3maBUhpOv1Rf8Cb/d355Yis4Mi
         CzRBysufdEFm515/P5D+UcBPzbChgprAsHit5sg1XJ9gNwrv8p61V7EuP8xyvdR0a/uH
         CEocAF2wfzWT7XgofyTyUsqP3nVNAuFW42x8o2zcYSGqPgq7VjDjLd0DbSYO84lfCT5e
         dgJoN3mSbM24UUsTl1bH6dqB1JWmL/dw4lfNHLpQFYhpiycmEfIVIWGtmzrCc0PnQVld
         zW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182300; x=1715787100;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJshCEGEO6C7BPozVmrqwdwGDdbBdrDE7yf6LFuqA4U=;
        b=YXBVXPeotZ6o+lLzHieWDGxwS7ie1cEcNArFd11LyHx6tvD0ZxmpbMpi/Xud0X/FTr
         TAh/iVFgd+teXO9b6kBNblgjJOAN/7Dy1rf+Dgl/vfgNWtgyA1ffCkQLMok1A8Hx3IGd
         17U0rSTfyqPEWMYLCYnASwXcCHLXwt6qg94cdzxDWyHG4hJeoQau9uVh133zXNrmeZjZ
         gPUTEGrh70D+iZWZ+R6rkadInW0svgkeSkw04xpLfmt7+RLZH17kaaKQyaQZkVRzpDQL
         U4rg5IyFQWGCEZQD7HspHAQqoJ1S05ngIgWMgfTZc1sCA34iiaLymRtCj/R0VELhwK8l
         o8zg==
X-Gm-Message-State: AOJu0Yzjm9taC8Wm2YgOqfY6X2odpFOrpAYsx/wRYIAcKVejhNO6tQuP
	0zdZ1Hu/9IOEo7M9W/hbF8cXSMVIfIsdTEnHk45ViMmBjmGj9gohk6glkBHPUuu0o0NOZkBondB
	d
X-Google-Smtp-Source: AGHT+IGHScwpvebIo4nh4ihEMfXqvesAb9OIiF7V1C8QcjBPLyWjeNYUUk/SMm3WPs5Mr/igbDk6FQ==
X-Received: by 2002:a17:906:3715:b0:a59:aae5:b0bc with SMTP id a640c23a62f3a-a59fb952c14mr167737266b.42.1715182300057;
        Wed, 08 May 2024 08:31:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:39 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 05/12] index.html: Add description to CVE trends section
Date: Wed,  8 May 2024 17:31:20 +0200
Message-ID: <20240508153131.94270-6-ninette@thehoodiefirm.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/96

From: Alex Feyerke <hello@alexfeyerke.com>

Also moves the chart out of the section element so it can be displayed at full page width.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
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
2.39.3 (Apple Git-145)


