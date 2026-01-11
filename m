Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8ABD2502E
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:06:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16327.1768158415396633866
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:06:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=OPjzZNKt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20260111190653cf06bd6603000207a7-pmvdz_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260111190653cf06bd6603000207a7
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:06:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6PT53c5rKrlWAxGXGkxbg4OnvX/PeFTSYvKdmu/VyBM=;
 b=OPjzZNKtrYbKIw5ZGZQ35RGGcEJ3LIiwEWUULgRjoITOVd01TK7LaHyHkePwMbyU/HFQc3
 UKAeYdsZhH1LY3LWrD+y70RjpDjQ7N/BwGJwwKbIIW3i4pDVvDQY8qXPO6FdYqJ/DMIAsho0
 kaVnlTo0WQn5WduwFDre3sZWKoIiHj9uye9vvBBXJrH9ZEkJR2ne+Afb2hIlOLkuNJmtkPFu
 ElLU/TFDlhT8YqmdMUZl/voMJOS6lYy0S8u0TON8YGOsiqnMx5XawQkzP96hGddvS8mYOfFX
 vO+xzV2DQCoOALcWRtNMbaAog9/KSDGjrFoJct2OhHI6U+CJPRupButw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH v2 2/2] patch-status: add whinlatter
Date: Sun, 11 Jan 2026 20:06:43 +0100
Message-Id: <20260111190643.13404-2-peter.marko@siemens.com>
In-Reply-To: <20260111190643.13404-1-peter.marko@siemens.com>
References: <20260111190643.13404-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:06:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2936

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/366

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
v2: correct sender
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 39c6f5a5..f0841c73 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
           <summary>master</summary>
           <div id="cve_status_master"></div>
         </details>
+        <details>
+          <summary>whinlatter</summary>
+          <div id="cve_status_whinlatter"></div>
+        </details>
         <details>
           <summary>walnascar</summary>
           <div id="cve_status_walnascar"></div>
@@ -365,6 +369,12 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_master', data);
       })
 
+    fetch('cve-status-whinlatter.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_whinlatter', data);
+      })
+
     fetch('cve-status-walnascar.txt')
       .then(response => response.text())
       .then(data => {
@@ -440,7 +450,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches = ['master', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 91b94bd9..1e8d95f3 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+5.3 (Whinlatter),2025-12-16
 5.2 (Walnascar),2025-05-08
 5.1 (Styhead),2024-10-17
 5.0 (Scarthgap),2024-04-30

